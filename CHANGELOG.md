### v1.3.7
**Date:** 2026/08/20

**Notes:**

* Reimplement AES-GCM using only public CommonCrypto APIs (AES-CTR + hand-written GHASH) to remove non-public symbols (`CCCryptorGCMOneshotEncrypt`/`CCCryptorGCMOneshotDecrypt`/`CCCryptorGCM`) flagged by App Store review (ITMS-90338). Wire format is unchanged (IV || ciphertext || tag), byte compatible with the previous release and the Android SDK.

### v1.3.6
**Date:** 2026/08/03

**Notes:**

* Update AES encryptor to use AES-GCM (aligned with Android SDK)

### v1.3.5
**Date:** 2026/08/03

**Notes:**

* Fix SPM public header layout for `#import <ThinkingDataCore/Header.h>`
* Fix umbrella header importing iOS-only encrypt/FPS/network headers on non-iOS platforms

### v1.3.4
**Date:** 2026/07/13

**Notes:**

* Fix a crash where FPS collection operated CADisplayLink on a background thread

### v1.3.0
**Date:** 2025/03/13

**Notes:**

* Supports encryption of local data

### v1.2.0
**Date:** 2024/12/16

**Notes:**

* Modify initialization

### v1.1.0
**Date:** 2024/11/04

**Notes:**

* Tidy common module

### v1.0.0
**Date:** 2023/09/14

**Notes:**

* Init core module
