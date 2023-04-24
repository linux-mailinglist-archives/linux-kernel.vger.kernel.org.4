Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08BE6EC48B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 06:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjDXEws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 00:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjDXEwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 00:52:46 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1ACE61;
        Sun, 23 Apr 2023 21:52:41 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pqoBe-001d2G-RP; Mon, 24 Apr 2023 12:52:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 24 Apr 2023 12:52:27 +0800
Date:   Mon, 24 Apr 2023 12:52:27 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Update for 6.4
Message-ID: <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
References: <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.4-p1 

for you to fetch changes up to 482c84e906e535072c55395acabd3a58e9443d12:

  i2c: designware: Add doorbell support for Mendocino (2023-04-20 18:20:05 +0800)

----------------------------------------------------------------
This update includes the following changes:

API:

- Total usage stats now include all that returned error (instead of some).
- Remove maximum hash statesize limit.
- Add cloning support for hmac and unkeyed hashes.
- Demote BUG_ON in crypto_unregister_alg to a WARN_ON.

Algorithms:

- Use RIP-relative addressing on x86 to prepare for PIE build.
- Add accelerated AES/GCM stitched implementation on powerpc P10.
- Add some test vectors for cmac(camellia).
- Remove failure case where jent is unavailable outside of FIPS mode in drbg.
- Add permanent and intermittent health error checks in jitter RNG.

Drivers:

- Add support for 402xx devices in qat.
- Add support for HiSTB TRNG.
- Fix hash concurrency issues in stm32.
- Add OP-TEE firmware support in caam.
----------------------------------------------------------------

Anthony Yznaga (1):
      padata: use alignment when calculating the number of worker threads

Ard Biesheuvel (13):
      crypto: x86/aegis128 - Use RIP-relative addressing
      crypto: x86/aesni - Use RIP-relative addressing
      crypto: x86/aria - Use RIP-relative addressing
      crypto: x86/camellia - Use RIP-relative addressing
      crypto: x86/cast5 - Use RIP-relative addressing
      crypto: x86/cast6 - Use RIP-relative addressing
      crypto: x86/crc32c - Use RIP-relative addressing
      crypto: x86/des3 - Use RIP-relative addressing
      crypto: x86/ghash - Use RIP-relative addressing
      crypto: x86/sha256 - Use RIP-relative addressing
      crypto: x86/aesni - Use local .L symbols for code
      crypto: x86/crc32 - Use local .L symbols for code
      crypto: x86/sha - Use local .L symbols for code

Arnd Bergmann (1):
      crypto: ixp4xx - fix building wiht 64-bit dma_addr_t

Bhupesh Sharma (4):
      dt-bindings: qcom-qce: Convert bindings to yaml
      MAINTAINERS: Add qcom-qce dt-binding file to QUALCOMM CRYPTO DRIVERS section
      dt-bindings: qcom-qce: Add 'interconnects' and 'interconnect-names'
      dt-bindings: qcom-qce: Add 'iommus' to optional properties

Bjorn Helgaas (6):
      crypto: qat - drop redundant adf_enable_aer()
      crypto: cavium/nitrox - remove unnecessary aer.h include
      crypto: hisilicon/hpre - remove unnecessary aer.h include
      crypto: hisilicon/qm - remove unnecessary aer.h include
      crypto: hisilicon/sec - remove unnecessary aer.h include
      crypto: hisilicon/zip - remove unnecessary aer.h include

Christophe JAILLET (2):
      crypto: caam - Clear some memory in instantiate_rng
      crypto: mxs-dcp - Use the devm_clk_get_optional_enabled() helper

Damian Muszynski (1):
      crypto: qat - add support for 402xx devices

Danny Tsen (8):
      crypto: p10-aes-gcm - Glue code for AES/GCM stitched implementation
      crypto: p10-aes-gcm - An accelerated AES/GCM stitched implementation
      crypto: p10-aes-gcm - Supporting functions for AES
      crypto: p10-aes-gcm - Supporting functions for ghash
      crypto: p10-aes-gcm - A perl script to process PowerPC assembler source.
      crypto: p10-aes-gcm - Update Kconfig and Makefile
      crypto: p10-aes-gcm - Remove POWER10_CPU dependency
      powerpc: Move Power10 feature PPC_MODULE_FEATURE_P10

David Howells (1):
      crypto: testmgr - Add some test vectors for cmac(camellia)

David Yang (1):
      crypto: hisilicon/trng - add support for HiSTB TRNG

Eric Biggers (2):
      crypto: arm64/aes-neonbs - fix crash with CFI enabled
      crypto: testmgr - fix RNG performance in fuzz tests

Gaurav Jain (1):
      crypto: caam/jr - add .shutdown hook

Heiner Kallweit (3):
      hwrng: meson - remove unused member of struct meson_rng_data
      hwrng: meson - use devm_clk_get_optional_enabled
      hwrng: meson - remove not needed call to platform_set_drvdata

Herbert Xu (34):
      crypto: acomp - Be more careful with request flags
      crypto: qat - Include algapi.h for low-level Crypto API
      crypto: algapi - Move stat reporting into algapi
      crypto: aead - Count error stats differently
      crypto: akcipher - Count error stats differently
      crypto: hash - Count error stats differently
      crypto: acomp - Count error stats differently
      crypto: kpp - Count error stats differently
      crypto: skcipher - Count error stats differently
      crypto: rng - Count error stats differently
      crypto: api - Move MODULE_ALIAS_CRYPTO to algapi.h
      crypto: api - Check CRYPTO_USER instead of NET for report
      crypto: stm32 - Save 54 CSR registers
      crypto: stm32 - Move polling into do_one_request
      crypto: stm32 - Simplify finup
      crypto: stm32 - Remove unused hdev->err field
      crypto: stm32 - Move hash state into separate structure
      crypto: stm32 - Remove unused HASH_FLAGS_ERRORS
      crypto: stm32 - Fix empty message processing
      crypto: stm32 - Save and restore between each request
      crypto: hash - Fix kdoc errors about HASH_ALG_COMMON
      crypto: ccree - Depend on HAS_IOMEM
      crypto: lib/utils - Move utilities into new header
      crypto: drbg - Only fail when jent is unavailable in FIPS mode
      crypto: algif_hash - Allocate hash state with kmalloc
      crypto: hash - Remove maximum statesize limit
      crypto: ixp4xx - Do not check word size when compile testing
      crypto: api - Move low-level functions into algapi.h
      crypto: api - Add crypto_tfm_get
      crypto: api - Add crypto_clone_tfm
      crypto: hash - Add crypto_clone_ahash/shash
      crypto: hmac - Add support for cloning
      crypto: cryptd - Convert hash to use modern init_tfm/exit_tfm
      crypto: cryptd - Add support for cloning hashes

Horia GeantA (2):
      crypto: caam - reduce page 0 regs access to minimum
      crypto: caam - OP-TEE firmware support

Horia Geanta (1):
      drivers: crypto: caam/jr - Allow quiesce when quiesced

Jeremi Piotrowski (1):
      crypto: ccp - Clear PSP interrupt status register before calling handler

Jonathan McDowell (2):
      crypto: safexcel - Raise firmware load failure message to error
      crypto: safexcel - Cleanup ring IRQ workqueues on load failure

Krzysztof Kozlowski (2):
      crypto: atmel-sha204a - Mark OF related data as maybe unused
      crypto: img-hash - Fix img_hash_match unused warning

Luis Chamberlain (1):
      crypto: fips - simplify one-level sysctl registration for crypto_sysctl_table

Mario Limonciello (13):
      crypto: ccp - Drop TEE support for IRQ handler
      crypto: ccp - Add a header for multiple drivers to use `__psp_pa`
      crypto: ccp - Move some PSP mailbox bit definitions into common header
      crypto: ccp - Add support for an interface for platform features
      crypto: ccp - Enable platform access interface on client PSP parts
      crypto: ccp - Add support for ringing a platform doorbell
      crypto: ccp - Don't initialize CCP for PSP 0x1649
      crypto: ccp - Drop extra doorbell checks
      crypto: ccp - Bump up doorbell debug message to error
      crypto: ccp - Return doorbell status code as an argument
      crypto: ccp - Use lower 8 bytes to communicate with doorbell command register
      i2c: designware: Use PCI PSP driver for communication
      i2c: designware: Add doorbell support for Mendocino

Neal Liu (2):
      crypto: aspeed - add error handling if dmam_alloc_coherent() failed
      crypto: aspeed - fix uninitialized symbol 'idx' warning

Randy Dunlap (1):
      async_tx: fix kernel-doc notation warnings

Ryan Wanner (4):
      crypto: atmel-sha - Add zero length message digest support for hmac
      crypto: atmel-tdes - Detecting in-place operations with two sg lists
      crypto: atmel-aes - Detecting in-place operations two sg lists
      crypto: atmel-aes - Match cfb block size with generic implementation

Shashank Gupta (6):
      crypto: qat - delay sysfs initialization
      crypto: qat - fix concurrency issue when device state changes
      crypto: qat - replace state machine calls
      crypto: qat - refactor device restart logic
      crypto: qat - make state machine functions static
      crypto: qat - fix apply custom thread-service mapping for dc service

Stephan Müller (1):
      crypto: jitter - permanent and intermittent health errors

Suman Anna (1):
      crypto: sa2ul - Select CRYPTO_DES

Thara Gopinath (2):
      crypto: qce - Add support to initialize interconnect path
      crypto: qce - Make clocks optional

Thomas Weißschuh (1):
      padata: Make kobj_type structure constant

Toke Høiland-Jørgensen (1):
      crypto: api - Demote BUG_ON() in crypto_unregister_alg() to a WARN_ON()

Tom Zanussi (3):
      crypto: keembay - Move driver to drivers/crypto/intel/keembay
      crypto: ixp4xx - Move driver to drivers/crypto/intel/ixp4xx
      crypto: qat - Move driver to drivers/crypto/intel/qat

Uwe Kleine-König (4):
      hwrng: xgene - Simplify using dev_err_probe()
      hwrng: xgene - Simplify using devm_clk_get_optional_enabled()
      hwrng: xgene - Improve error reporting for problems during .remove()
      crypto: keembay - Drop if with an always false condition

Vladimir Zapolskiy (4):
      dt-bindings: qcom-qce: Add new SoC compatible strings for Qualcomm QCE IP
      dt-bindings: qcom-qce: document optional clocks and clock-names properties
      arm64: dts: qcom: sm8550: add QCE IP family compatible values
      crypto: qce - Add a QCE IP family compatible 'qcom,qce'

Yang Li (4):
      crypto: aspeed - Use devm_platform_ioremap_resource()
      crypto: ccree - Use devm_platform_get_and_ioremap_resource()
      crypto: img-hash - Use devm_platform_get_and_ioremap_resource()
      crypto: stm32 - Use devm_platform_get_and_ioremap_resource()

Ye Xingchen (1):
      crypto: p10-aes-gcm - remove duplicate include header

Yu Zhe (4):
      hwrng: xgene - remove unnecessary (void*) conversions
      crypto: crypto4xx - remove unnecessary (void*) conversions
      crypto: drivers - remove unnecessary (void*) conversions
      crypto: caam - remove unnecessary (void*) conversions

 .../devicetree/bindings/crypto/qcom-qce.txt        |   25 -
 .../devicetree/bindings/crypto/qcom-qce.yaml       |  123 ++
 MAINTAINERS                                        |   33 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |    2 +-
 arch/arm64/crypto/aes-neonbs-core.S                |    9 +-
 arch/powerpc/crypto/Kconfig                        |   17 +
 arch/powerpc/crypto/Makefile                       |   13 +
 arch/powerpc/crypto/aes-gcm-p10-glue.c             |  343 +++++
 arch/powerpc/crypto/aes-gcm-p10.S                  | 1521 ++++++++++++++++++++
 arch/powerpc/crypto/aesp8-ppc.pl                   |  585 ++++++++
 arch/powerpc/crypto/ghashp8-ppc.pl                 |  370 +++++
 arch/powerpc/crypto/ppc-xlate.pl                   |  229 +++
 arch/powerpc/include/asm/cpufeature.h              |    1 +
 arch/x86/crypto/aegis128-aesni-asm.S               |    6 +-
 arch/x86/crypto/aesni-intel_asm.S                  |  198 +--
 arch/x86/crypto/aesni-intel_avx-x86_64.S           |  254 ++--
 arch/x86/crypto/aria-aesni-avx-asm_64.S            |   28 +-
 arch/x86/crypto/aria-aesni-avx2-asm_64.S           |   28 +-
 arch/x86/crypto/aria-gfni-avx512-asm_64.S          |   24 +-
 arch/x86/crypto/camellia-aesni-avx-asm_64.S        |   30 +-
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S       |   30 +-
 arch/x86/crypto/camellia-x86_64-asm_64.S           |    6 +-
 arch/x86/crypto/cast5-avx-x86_64-asm_64.S          |   38 +-
 arch/x86/crypto/cast6-avx-x86_64-asm_64.S          |   32 +-
 arch/x86/crypto/crc32-pclmul_asm.S                 |   16 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S          |   70 +-
 arch/x86/crypto/des3_ede-asm_64.S                  |   96 +-
 arch/x86/crypto/ghash-clmulni-intel_asm.S          |    4 +-
 arch/x86/crypto/sha1_avx2_x86_64_asm.S             |   25 +-
 arch/x86/crypto/sha256-avx-asm.S                   |   16 +-
 arch/x86/crypto/sha256-avx2-asm.S                  |   54 +-
 arch/x86/crypto/sha256-ssse3-asm.S                 |   16 +-
 arch/x86/crypto/sha512-avx-asm.S                   |    8 +-
 arch/x86/crypto/sha512-avx2-asm.S                  |   16 +-
 arch/x86/crypto/sha512-ssse3-asm.S                 |    8 +-
 arch/x86/kvm/svm/sev.c                             |    1 +
 crypto/acompress.c                                 |   81 +-
 crypto/aead.c                                      |   98 +-
 crypto/ahash.c                                     |  144 +-
 crypto/akcipher.c                                  |   52 +-
 crypto/algapi.c                                    |  219 +--
 crypto/algif_hash.c                                |   19 +-
 crypto/api.c                                       |   63 +-
 crypto/async_tx/async_pq.c                         |   10 +-
 crypto/async_tx/async_tx.c                         |    4 +-
 crypto/compress.h                                  |   26 +
 crypto/cryptd.c                                    |   34 +-
 crypto/crypto_user_stat.c                          |  183 +--
 crypto/drbg.c                                      |    2 +-
 crypto/fips.c                                      |   11 +-
 crypto/hash.h                                      |   40 +
 crypto/hmac.c                                      |   15 +
 crypto/internal.h                                  |   10 +
 crypto/jitterentropy-kcapi.c                       |   51 +-
 crypto/jitterentropy.c                             |  144 +-
 crypto/jitterentropy.h                             |    1 -
 crypto/kpp.c                                       |   53 +-
 crypto/rng.c                                       |   65 +-
 crypto/scompress.c                                 |   39 +-
 crypto/shash.c                                     |  181 ++-
 crypto/skcipher.c                                  |  113 +-
 crypto/tcrypt.c                                    |   11 +-
 crypto/testmgr.c                                   |  272 ++--
 crypto/testmgr.h                                   |   47 +
 drivers/char/hw_random/meson-rng.c                 |   29 +-
 drivers/char/hw_random/xgene-rng.c                 |   46 +-
 drivers/crypto/Kconfig                             |   21 +-
 drivers/crypto/Makefile                            |    4 +-
 drivers/crypto/amcc/crypto4xx_core.c               |    2 +-
 drivers/crypto/aspeed/aspeed-acry.c                |   14 +-
 drivers/crypto/atmel-aes.c                         |   16 +-
 drivers/crypto/atmel-sha.c                         |   34 +-
 drivers/crypto/atmel-sha204a.c                     |    2 +-
 drivers/crypto/atmel-tdes.c                        |   15 +-
 drivers/crypto/caam/caamalg.c                      |   21 +-
 drivers/crypto/caam/caamhash.c                     |   10 +-
 drivers/crypto/caam/caampkc.c                      |    6 +-
 drivers/crypto/caam/caamrng.c                      |    6 +-
 drivers/crypto/caam/ctrl.c                         |  112 +-
 drivers/crypto/caam/debugfs.c                      |   12 +-
 drivers/crypto/caam/debugfs.h                      |    7 +-
 drivers/crypto/caam/dpseci-debugfs.c               |    2 +-
 drivers/crypto/caam/intern.h                       |    1 +
 drivers/crypto/caam/jr.c                           |   61 +-
 drivers/crypto/cavium/nitrox/nitrox_main.c         |    1 -
 drivers/crypto/ccp/Makefile                        |    3 +-
 drivers/crypto/ccp/platform-access.c               |  215 +++
 drivers/crypto/ccp/platform-access.h               |   35 +
 drivers/crypto/ccp/psp-dev.c                       |   38 +-
 drivers/crypto/ccp/psp-dev.h                       |   11 +-
 drivers/crypto/ccp/sev-dev.c                       |   16 +-
 drivers/crypto/ccp/sev-dev.h                       |    2 +-
 drivers/crypto/ccp/sp-dev.h                        |   10 +
 drivers/crypto/ccp/sp-pci.c                        |   11 +-
 drivers/crypto/ccp/tee-dev.c                       |   17 +-
 drivers/crypto/ccree/cc_driver.c                   |    4 +-
 drivers/crypto/hifn_795x.c                         |   24 +-
 drivers/crypto/hisilicon/Kconfig                   |    7 +
 drivers/crypto/hisilicon/Makefile                  |    2 +-
 drivers/crypto/hisilicon/hpre/hpre_main.c          |    1 -
 drivers/crypto/hisilicon/qm.c                      |    1 -
 drivers/crypto/hisilicon/sec2/sec_main.c           |    1 -
 drivers/crypto/hisilicon/trng/Makefile             |    3 +
 drivers/crypto/hisilicon/trng/trng-stb.c           |  176 +++
 drivers/crypto/hisilicon/zip/zip_main.c            |    1 -
 drivers/crypto/img-hash.c                          |    7 +-
 drivers/crypto/inside-secure/safexcel.c            |   39 +-
 drivers/crypto/intel/Kconfig                       |    5 +
 drivers/crypto/intel/Makefile                      |    5 +
 drivers/crypto/intel/ixp4xx/Kconfig                |   14 +
 drivers/crypto/intel/ixp4xx/Makefile               |    2 +
 drivers/crypto/{ => intel/ixp4xx}/ixp4xx_crypto.c  |   15 +-
 drivers/crypto/{ => intel}/keembay/Kconfig         |    0
 drivers/crypto/{ => intel}/keembay/Makefile        |    0
 .../{ => intel}/keembay/keembay-ocs-aes-core.c     |    2 -
 .../crypto/{ => intel}/keembay/keembay-ocs-ecc.c   |    0
 .../{ => intel}/keembay/keembay-ocs-hcu-core.c     |    0
 drivers/crypto/{ => intel}/keembay/ocs-aes.c       |    0
 drivers/crypto/{ => intel}/keembay/ocs-aes.h       |    0
 drivers/crypto/{ => intel}/keembay/ocs-hcu.c       |    0
 drivers/crypto/{ => intel}/keembay/ocs-hcu.h       |    0
 drivers/crypto/{ => intel}/qat/Kconfig             |    0
 drivers/crypto/{ => intel}/qat/Makefile            |    0
 drivers/crypto/{ => intel}/qat/qat_4xxx/Makefile   |    0
 .../{ => intel}/qat/qat_4xxx/adf_4xxx_hw_data.c    |   62 +-
 .../{ => intel}/qat/qat_4xxx/adf_4xxx_hw_data.h    |    9 +-
 drivers/crypto/{ => intel}/qat/qat_4xxx/adf_drv.c  |   31 +-
 drivers/crypto/{ => intel}/qat/qat_c3xxx/Makefile  |    0
 .../{ => intel}/qat/qat_c3xxx/adf_c3xxx_hw_data.c  |    2 +-
 .../{ => intel}/qat/qat_c3xxx/adf_c3xxx_hw_data.h  |    0
 drivers/crypto/{ => intel}/qat/qat_c3xxx/adf_drv.c |   24 +-
 .../crypto/{ => intel}/qat/qat_c3xxxvf/Makefile    |    0
 .../qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c          |    0
 .../qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.h          |    0
 .../crypto/{ => intel}/qat/qat_c3xxxvf/adf_drv.c   |   13 +-
 drivers/crypto/{ => intel}/qat/qat_c62x/Makefile   |    0
 .../{ => intel}/qat/qat_c62x/adf_c62x_hw_data.c    |    2 +-
 .../{ => intel}/qat/qat_c62x/adf_c62x_hw_data.h    |    0
 drivers/crypto/{ => intel}/qat/qat_c62x/adf_drv.c  |   24 +-
 drivers/crypto/{ => intel}/qat/qat_c62xvf/Makefile |    0
 .../qat/qat_c62xvf/adf_c62xvf_hw_data.c            |    0
 .../qat/qat_c62xvf/adf_c62xvf_hw_data.h            |    0
 .../crypto/{ => intel}/qat/qat_c62xvf/adf_drv.c    |   13 +-
 drivers/crypto/{ => intel}/qat/qat_common/Makefile |    0
 .../{ => intel}/qat/qat_common/adf_accel_devices.h |    5 +-
 .../{ => intel}/qat/qat_common/adf_accel_engine.c  |    0
 .../crypto/{ => intel}/qat/qat_common/adf_admin.c  |    0
 .../crypto/{ => intel}/qat/qat_common/adf_aer.c    |   39 +-
 .../crypto/{ => intel}/qat/qat_common/adf_cfg.c    |    0
 .../crypto/{ => intel}/qat/qat_common/adf_cfg.h    |    0
 .../{ => intel}/qat/qat_common/adf_cfg_common.h    |    0
 .../{ => intel}/qat/qat_common/adf_cfg_strings.h   |    0
 .../{ => intel}/qat/qat_common/adf_cfg_user.h      |    0
 .../{ => intel}/qat/qat_common/adf_common_drv.h    |   10 +-
 .../{ => intel}/qat/qat_common/adf_ctl_drv.c       |   30 +-
 .../{ => intel}/qat/qat_common/adf_dev_mgr.c       |    2 +
 .../{ => intel}/qat/qat_common/adf_gen2_config.c   |    0
 .../{ => intel}/qat/qat_common/adf_gen2_config.h   |    0
 .../{ => intel}/qat/qat_common/adf_gen2_dc.c       |    0
 .../{ => intel}/qat/qat_common/adf_gen2_dc.h       |    0
 .../{ => intel}/qat/qat_common/adf_gen2_hw_data.c  |    0
 .../{ => intel}/qat/qat_common/adf_gen2_hw_data.h  |    0
 .../{ => intel}/qat/qat_common/adf_gen2_pfvf.c     |    0
 .../{ => intel}/qat/qat_common/adf_gen2_pfvf.h     |    0
 .../{ => intel}/qat/qat_common/adf_gen4_dc.c       |    0
 .../{ => intel}/qat/qat_common/adf_gen4_dc.h       |    0
 .../{ => intel}/qat/qat_common/adf_gen4_hw_data.c  |    0
 .../{ => intel}/qat/qat_common/adf_gen4_hw_data.h  |    0
 .../{ => intel}/qat/qat_common/adf_gen4_pfvf.c     |    0
 .../{ => intel}/qat/qat_common/adf_gen4_pfvf.h     |    0
 .../{ => intel}/qat/qat_common/adf_gen4_pm.c       |    0
 .../{ => intel}/qat/qat_common/adf_gen4_pm.h       |    0
 .../{ => intel}/qat/qat_common/adf_hw_arbiter.c    |    2 +-
 .../crypto/{ => intel}/qat/qat_common/adf_init.c   |   96 +-
 .../crypto/{ => intel}/qat/qat_common/adf_isr.c    |    0
 .../{ => intel}/qat/qat_common/adf_pfvf_msg.h      |    0
 .../{ => intel}/qat/qat_common/adf_pfvf_pf_msg.c   |    0
 .../{ => intel}/qat/qat_common/adf_pfvf_pf_msg.h   |    0
 .../{ => intel}/qat/qat_common/adf_pfvf_pf_proto.c |    0
 .../{ => intel}/qat/qat_common/adf_pfvf_pf_proto.h |    0
 .../{ => intel}/qat/qat_common/adf_pfvf_utils.c    |    0
 .../{ => intel}/qat/qat_common/adf_pfvf_utils.h    |    0
 .../{ => intel}/qat/qat_common/adf_pfvf_vf_msg.c   |    0
 .../{ => intel}/qat/qat_common/adf_pfvf_vf_msg.h   |    0
 .../{ => intel}/qat/qat_common/adf_pfvf_vf_proto.c |    0
 .../{ => intel}/qat/qat_common/adf_pfvf_vf_proto.h |    0
 .../crypto/{ => intel}/qat/qat_common/adf_sriov.c  |   10 +-
 .../crypto/{ => intel}/qat/qat_common/adf_sysfs.c  |   23 +-
 .../{ => intel}/qat/qat_common/adf_transport.c     |    0
 .../{ => intel}/qat/qat_common/adf_transport.h     |    0
 .../qat/qat_common/adf_transport_access_macros.h   |    0
 .../qat/qat_common/adf_transport_debug.c           |    0
 .../qat/qat_common/adf_transport_internal.h        |    0
 .../crypto/{ => intel}/qat/qat_common/adf_vf_isr.c |    3 +-
 .../crypto/{ => intel}/qat/qat_common/icp_qat_fw.h |    0
 .../{ => intel}/qat/qat_common/icp_qat_fw_comp.h   |    0
 .../qat/qat_common/icp_qat_fw_init_admin.h         |    0
 .../{ => intel}/qat/qat_common/icp_qat_fw_la.h     |    0
 .../qat/qat_common/icp_qat_fw_loader_handle.h      |    0
 .../{ => intel}/qat/qat_common/icp_qat_fw_pke.h    |    0
 .../{ => intel}/qat/qat_common/icp_qat_hal.h       |    0
 .../crypto/{ => intel}/qat/qat_common/icp_qat_hw.h |    0
 .../qat/qat_common/icp_qat_hw_20_comp.h            |    0
 .../qat/qat_common/icp_qat_hw_20_comp_defs.h       |    0
 .../{ => intel}/qat/qat_common/icp_qat_uclo.h      |    0
 .../crypto/{ => intel}/qat/qat_common/qat_algs.c   |    0
 .../{ => intel}/qat/qat_common/qat_algs_send.c     |    0
 .../{ => intel}/qat/qat_common/qat_algs_send.h     |    0
 .../{ => intel}/qat/qat_common/qat_asym_algs.c     |    0
 drivers/crypto/{ => intel}/qat/qat_common/qat_bl.c |    0
 drivers/crypto/{ => intel}/qat/qat_common/qat_bl.h |    0
 .../{ => intel}/qat/qat_common/qat_comp_algs.c     |    0
 .../{ => intel}/qat/qat_common/qat_comp_req.h      |    0
 .../{ => intel}/qat/qat_common/qat_compression.c   |    0
 .../{ => intel}/qat/qat_common/qat_compression.h   |    0
 .../crypto/{ => intel}/qat/qat_common/qat_crypto.c |    0
 .../crypto/{ => intel}/qat/qat_common/qat_crypto.h |    0
 .../crypto/{ => intel}/qat/qat_common/qat_hal.c    |    1 +
 .../crypto/{ => intel}/qat/qat_common/qat_uclo.c   |    1 +
 .../crypto/{ => intel}/qat/qat_dh895xcc/Makefile   |    0
 .../qat/qat_dh895xcc/adf_dh895xcc_hw_data.c        |    2 +-
 .../qat/qat_dh895xcc/adf_dh895xcc_hw_data.h        |    0
 .../crypto/{ => intel}/qat/qat_dh895xcc/adf_drv.c  |   24 +-
 .../crypto/{ => intel}/qat/qat_dh895xccvf/Makefile |    0
 .../qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c    |    0
 .../qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.h    |    0
 .../{ => intel}/qat/qat_dh895xccvf/adf_drv.c       |   13 +-
 drivers/crypto/mxs-dcp.c                           |   21 +-
 drivers/crypto/qce/core.c                          |   23 +-
 drivers/crypto/qce/core.h                          |    1 +
 drivers/crypto/sa2ul.c                             |    6 +-
 drivers/crypto/sahara.c                            |    4 +-
 drivers/crypto/stm32/stm32-hash.c                  |  361 ++---
 drivers/i2c/busses/Kconfig                         |    5 +-
 drivers/i2c/busses/i2c-designware-amdpsp.c         |  205 +--
 drivers/i2c/busses/i2c-designware-core.h           |    1 -
 drivers/i2c/busses/i2c-designware-platdrv.c        |    1 -
 drivers/tee/amdtee/call.c                          |    2 +-
 drivers/tee/amdtee/shm_pool.c                      |    2 +-
 include/crypto/acompress.h                         |  132 +-
 include/crypto/aead.h                              |   22 +
 include/crypto/akcipher.h                          |  102 +-
 include/crypto/algapi.h                            |   93 +-
 include/crypto/hash.h                              |   95 +-
 include/crypto/internal/acompress.h                |   43 +-
 include/crypto/internal/hash.h                     |    2 -
 include/crypto/internal/scompress.h                |   15 +-
 include/crypto/kpp.h                               |   73 +-
 include/crypto/rng.h                               |   65 +-
 include/crypto/skcipher.h                          |   22 +
 include/crypto/utils.h                             |   73 +
 include/linux/crypto.h                             |  236 +--
 include/linux/psp-platform-access.h                |   65 +
 include/linux/psp-sev.h                            |    8 -
 include/linux/psp.h                                |   29 +
 kernel/padata.c                                    |    4 +-
 lib/crypto/utils.c                                 |    2 +-
 257 files changed, 6776 insertions(+), 2730 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/crypto/qcom-qce.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/qcom-qce.yaml
 create mode 100644 arch/powerpc/crypto/aes-gcm-p10-glue.c
 create mode 100644 arch/powerpc/crypto/aes-gcm-p10.S
 create mode 100644 arch/powerpc/crypto/aesp8-ppc.pl
 create mode 100644 arch/powerpc/crypto/ghashp8-ppc.pl
 create mode 100644 arch/powerpc/crypto/ppc-xlate.pl
 create mode 100644 crypto/compress.h
 create mode 100644 crypto/hash.h
 create mode 100644 drivers/crypto/ccp/platform-access.c
 create mode 100644 drivers/crypto/ccp/platform-access.h
 create mode 100644 drivers/crypto/hisilicon/trng/trng-stb.c
 create mode 100644 drivers/crypto/intel/Kconfig
 create mode 100644 drivers/crypto/intel/Makefile
 create mode 100644 drivers/crypto/intel/ixp4xx/Kconfig
 create mode 100644 drivers/crypto/intel/ixp4xx/Makefile
 rename drivers/crypto/{ => intel/ixp4xx}/ixp4xx_crypto.c (99%)
 rename drivers/crypto/{ => intel}/keembay/Kconfig (100%)
 rename drivers/crypto/{ => intel}/keembay/Makefile (100%)
 rename drivers/crypto/{ => intel}/keembay/keembay-ocs-aes-core.c (99%)
 rename drivers/crypto/{ => intel}/keembay/keembay-ocs-ecc.c (100%)
 rename drivers/crypto/{ => intel}/keembay/keembay-ocs-hcu-core.c (100%)
 rename drivers/crypto/{ => intel}/keembay/ocs-aes.c (100%)
 rename drivers/crypto/{ => intel}/keembay/ocs-aes.h (100%)
 rename drivers/crypto/{ => intel}/keembay/ocs-hcu.c (100%)
 rename drivers/crypto/{ => intel}/keembay/ocs-hcu.h (100%)
 rename drivers/crypto/{ => intel}/qat/Kconfig (100%)
 rename drivers/crypto/{ => intel}/qat/Makefile (100%)
 rename drivers/crypto/{ => intel}/qat/qat_4xxx/Makefile (100%)
 rename drivers/crypto/{ => intel}/qat/qat_4xxx/adf_4xxx_hw_data.c (87%)
 rename drivers/crypto/{ => intel}/qat/qat_4xxx/adf_4xxx_hw_data.h (86%)
 rename drivers/crypto/{ => intel}/qat/qat_4xxx/adf_drv.c (95%)
 rename drivers/crypto/{ => intel}/qat/qat_c3xxx/Makefile (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c3xxx/adf_c3xxx_hw_data.c (98%)
 rename drivers/crypto/{ => intel}/qat/qat_c3xxx/adf_c3xxx_hw_data.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c3xxx/adf_drv.c (93%)
 rename drivers/crypto/{ => intel}/qat/qat_c3xxxvf/Makefile (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c3xxxvf/adf_drv.c (96%)
 rename drivers/crypto/{ => intel}/qat/qat_c62x/Makefile (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c62x/adf_c62x_hw_data.c (98%)
 rename drivers/crypto/{ => intel}/qat/qat_c62x/adf_c62x_hw_data.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c62x/adf_drv.c (93%)
 rename drivers/crypto/{ => intel}/qat/qat_c62xvf/Makefile (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c62xvf/adf_c62xvf_hw_data.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c62xvf/adf_c62xvf_hw_data.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c62xvf/adf_drv.c (96%)
 rename drivers/crypto/{ => intel}/qat/qat_common/Makefile (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_accel_devices.h (97%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_accel_engine.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_admin.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_aer.c (82%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_cfg.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_cfg.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_cfg_common.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_cfg_strings.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_cfg_user.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_common_drv.h (96%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_ctl_drv.c (95%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_dev_mgr.c (99%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_config.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_config.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_dc.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_dc.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_hw_data.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_hw_data.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_pfvf.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_pfvf.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_dc.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_dc.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_hw_data.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_hw_data.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_pfvf.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_pfvf.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_pm.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_pm.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_hw_arbiter.c (98%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_init.c (85%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_isr.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_msg.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_pf_msg.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_pf_msg.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_pf_proto.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_pf_proto.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_utils.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_utils.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_vf_msg.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_vf_msg.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_vf_proto.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_vf_proto.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_sriov.c (96%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_sysfs.c (88%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_transport.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_transport.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_transport_access_macros.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_transport_debug.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_transport_internal.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_vf_isr.c (99%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw_comp.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw_init_admin.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw_la.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw_loader_handle.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw_pke.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_hal.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_hw.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_hw_20_comp.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_hw_20_comp_defs.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_uclo.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_algs.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_algs_send.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_algs_send.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_asym_algs.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_bl.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_bl.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_comp_algs.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_comp_req.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_compression.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_compression.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_crypto.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_crypto.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_hal.c (99%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_uclo.c (99%)
 rename drivers/crypto/{ => intel}/qat/qat_dh895xcc/Makefile (100%)
 rename drivers/crypto/{ => intel}/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c (99%)
 rename drivers/crypto/{ => intel}/qat/qat_dh895xcc/adf_dh895xcc_hw_data.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_dh895xcc/adf_drv.c (93%)
 rename drivers/crypto/{ => intel}/qat/qat_dh895xccvf/Makefile (100%)
 rename drivers/crypto/{ => intel}/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_dh895xccvf/adf_drv.c (96%)
 create mode 100644 include/crypto/utils.h
 create mode 100644 include/linux/psp-platform-access.h
 create mode 100644 include/linux/psp.h

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
