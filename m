Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069A05F3EE6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiJDIyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiJDIyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:54:38 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFFD129;
        Tue,  4 Oct 2022 01:54:33 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ofdh4-00BKPP-1W; Tue, 04 Oct 2022 19:54:27 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 04 Oct 2022 16:54:26 +0800
Date:   Tue, 4 Oct 2022 16:54:25 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Update for 6.1
Message-ID: <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
References: <20210817013601.GA14148@gondor.apana.org.au>
 <20210929023843.GA28594@gondor.apana.org.au>
 <20211029041408.GA3192@gondor.apana.org.au>
 <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

The following changes since commit 874b301985ef2f89b8b592ad255e03fb6fbfe605:

  crypto: lib - remove unneeded selection of XOR_BLOCKS (2022-08-26 18:40:14 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v6.1-p1

for you to fetch changes up to b411b1a0c8bddd470fc8c3457629ac25a168cba0:

  crypto: aspeed - Remove redundant dev_err call (2022-09-30 13:59:13 +0800)

----------------------------------------------------------------
This update includes the following changes:

API:

- Feed untrusted RNGs into /dev/random.
- Allow HWRNG sleeping to be more interruptible.
- Create lib/utils module.
- Setting private keys no longer required for akcipher.
- Remove tcrypt mode=1000.
- Reorganised Kconfig entries.

Algorithms:

- Load x86/sha512 based on CPU features.
- Add AES-NI/AVX/x86_64/GFNI assembler implementation of aria cipher.

Drivers:

- Add HACE crypto driver aspeed.

----------------------------------------------------------------
Adam Guerin (1):
      crypto: qat - add limit to linked list parsing

Damian Muszynski (2):
      crypto: qat - fix DMA transfer direction
      crypto: qat - use reference to structure in dma_map_single()

Dan Carpenter (2):
      crypto: marvell/octeontx - prevent integer overflows
      crypto: cavium - prevent integer overflow loading firmware

Dominik Brodowski (1):
      hwrng: core - start hwrng kthread also for untrusted sources

Dong Chuanjian (1):
      crypto: drbg - remove unnecessary (void*) conversions

Eric Biggers (3):
      crypto: lib - create utils module and move __crypto_memneq into it
      crypto: lib - move __crypto_xor into utils
      crypto: lib - remove __HAVE_ARCH_CRYPTO_MEMNEQ

Gaosheng Cui (3):
      crypto: bcm - Simplify obtain the name for cipher
      crypto: aead - Remove unused inline functions from aead
      crypto: scatterwalk - Remove unused inline function scatterwalk_aligned()

Giovanni Cabiddu (1):
      Revert "crypto: qat - reduce size of mapped region"

Herbert Xu (7):
      crypto: qcom-rng - Fix qcom_rng_of_match unused warning
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
      Revert "crypto: gemini - Fix error check for dma_map_sg"
      Revert "crypto: allwinner - Fix dma_map_sg error check"
      crypto: aspeed - Enable compile testing
      crypto: aspeed - Fix sparse warnings
      crypto: artpec6 - Fix printk warning on size_t/%d

Ignat Korchagin (1):
      crypto: akcipher - default implementation for setting a private key

Jack Wang (6):
      crypto: gemini - Fix error check for dma_map_sg
      crypto: sahara - Fix error check for dma_map_sg
      crypto: qce - Fix dma_map_sg error check
      crypto: amlogic - Fix dma_map_sg error check
      crypto: allwinner - Fix dma_map_sg error check
      crypto: ccree - Fix dma_map_sg error check

Jacky Li (2):
      crypto: ccp - Initialize PSP when reading psp data file failed
      crypto: ccp - Fail the PSP initialization when writing psp data file failed

James Cowgill (1):
      hwrng: arm-smccc-trng - fix NO_ENTROPY handling

Jarkko Sakkinen (1):
      crypto: ccp - Add a quirk to firmware update

Jason A. Donenfeld (1):
      hwrng: core - let sleep be interrupted when unregistering hwrng

Jason Wang (2):
      crypto: cavium - Fix comment typo
      crypto: api - Fix comment typo

Jean Delvare (1):
      crypto: keembay-ocs - Drop obsolete dependency on COMPILE_TEST

Junchong Pan (1):
      crypto: hisilicon/qm - remove unneeded data storage

Kai Ye (3):
      crypto: hisilicon/qm - no judgment in the back process
      crypto: hisilicon/sec - delete redundant blank lines
      crypto: hisilicon/qm - fix the qos value initialization

Koba Ko (1):
      crypto: ccp - Release dma channels before dmaengine unrgister

Kshitiz Varshney (1):
      hwrng: imx-rngc - Moving IRQ handler registering after imx_rngc_irq_mask_clear()

Liu Shixin (1):
      crypto: sun4i-ss - use DEFINE_SHOW_ATTRIBUTE to simplify sun4i_ss_debugfs

Lucas Segarra Fernandez (3):
      crypto: testmgr - extend acomp tests for NULL destination buffer
      crypto: testmgr - fix indentation for test_acomp() args
      crypto: qat - fix default value of WDT timer

Lukas Bulwahn (2):
      crypto: arm64 - revert unintended config name change for CRYPTO_SHA1_ARM64_CE
      crypto: blake2s - revert unintended config addition of CRYPTO_BLAKE2S

Martin Kaiser (3):
      hwrng: imx-rngc - use KBUILD_MODNAME as driver name
      hwrng: imx-rngc - use devm_clk_get_enabled
      hwrng: imx-rngc - use devres for hwrng registration

Neal Liu (8):
      crypto: aspeed - Add HACE hash driver
      dt-bindings: clock: Add AST2500/AST2600 HACE reset definition
      ARM: dts: aspeed: Add HACE device controller node
      dt-bindings: crypto: add documentation for aspeed hace
      crypto: aspeed - add HACE crypto driver
      crypto: aspeed - fix build module error
      crypto: aspeed: fix format unexpected build warning
      crypto: aspeed - fix build error when only CRYPTO_DEV_ASPEED is enabled

Peter Harliman Liem (3):
      crypto: inside-secure - Change swab to swab32
      crypto: inside_secure - Avoid dma map if size is zero
      crypto: inside-secure - Replace generic aes with libaes

Robert Elliott (20):
      crypto: x86/sha512 - load based on CPU features
      crypto: testmgr - don't generate WARN for missing modules
      crypto: tcrypt - remove mode=1000
      crypto: Kconfig - move mips entries to a submenu
      crypto: Kconfig - move powerpc entries to a submenu
      crypto: Kconfig - move s390 entries to a submenu
      crypto: Kconfig - move sparc entries to a submenu
      crypto: Kconfig - move x86 entries to a submenu
      crypto: Kconfig - remove AES_ARM64 ref by SA2UL
      crypto: Kconfig - submenus for arm and arm64
      crypto: Kconfig - sort the arm64 entries
      crypto: Kconfig - sort the arm entries
      crypto: Kconfig - add submenus
      crypto: Kconfig - simplify public-key entries
      crypto: Kconfig - simplify CRC entries
      crypto: Kconfig - simplify aead entries
      crypto: Kconfig - simplify hash entries
      crypto: Kconfig - simplify userspace entries
      crypto: Kconfig - simplify cipher entries
      crypto: Kconfig - simplify compression/RNG entries

Shang XiaoJing (1):
      crypto: aspeed - Remove redundant dev_err call

Srinivas Kerekare (1):
      crypto: qat - add check to validate firmware images

Sun Ke (1):
      crypto: aspeed - fix return value check in aspeed_hace_probe()

Taehee Yoo (3):
      crypto: aria - prepare generic module for optimized implementations
      crypto: aria-avx - add AES-NI/AVX/x86_64/GFNI assembler implementation of aria cipher
      crypto: tcrypt - add async speed test for aria cipher

Tuo Cao (1):
      crypto: artpec6 - move spin_lock_bh to spin_lock in tasklet

Weili Qian (12):
      crypto: hisilicon/hpre - change return type of hpre_cluster_inqry_write()
      crypto: hisilicon/qm - fix missing destroy qp_idr
      crypto: hisilicon/qm - remove unneeded hardware cache write back
      crypto: hisilicon/qm - check mailbox operation result
      crypto: hisilicon/qm - fix missing put dfx access
      crypto: hisilicon/qm - return failure if vfs_num exceeds total VFs
      crypto: hisilicon/qm - get hardware features from hardware registers
      crypto: hisilicon/qm - get qp num and depth from hardware registers
      crypto: hisilicon/qm - add UACCE_CMD_QM_SET_QP_INFO support
      crypto: hisilicon/qm - get error type from hardware registers
      crypto: hisilicon/qm - support get device irq information from hardware registers
      crypto: hisilicon/zip - support zip capability

Wenkai Lin (1):
      crypto: hisilicon/sec - get algorithm bitmap from registers

Wolfram Sang (2):
      crypto: core - move from strlcpy with unused retval to strscpy
      crypto: drivers - move from strlcpy with unused retval to strscpy

Xiu Jianfeng (1):
      crypto: add __init/__exit annotations to init/exit funcs

Yang Shen (2):
      crypto: hisilicon/zip - optimization for performance
      crypto: hisilicon/zip - some misc cleanup

Ye Weihua (1):
      crypto: hisilicon/zip - fix mismatch in get/set sgl_sge_nr

YueHaibing (1):
      crypto: aspeed - Fix check for platform_get_irq() errors

Zhengchao Shao (1):
      crypto: sahara - don't sleep when in softirq

Zhiqi Song (3):
      crypto: hisilicon/hpre - support hpre capability
      crypto: hisilicon/hpre - optimize registration of ecdh
      crypto: hisilicon - support get algs by the capability register

Zhuo Chen (1):
      crypto: hisilicon - Remove pci_aer_clear_nonfatal_status() call

lei he (1):
      crypto: virtio - fix memory-leak

wangjianli (3):
      crypto: n2 - fix repeated words in comments
      crypto: marvell/octeontx - fix repeated words in comments
      crypto: bcm - fix repeated words in comments

ye xingchen (7):
      crypto: sun8i-ce - using the pm_runtime_resume_and_get to simplify the code
      crypto: octeontx - Remove the unneeded result variable
      crypto: nx - Remove the unneeded result variable
      crypto: ccp - Remove the unneeded result variable
      crypto: octeontx2 - Remove the unneeded result variable
      crypto: zip - remove the unneeded result variable
      crypto: marvell/octeontx - use sysfs_emit() to instead of scnprintf()

 .../bindings/crypto/aspeed,ast2500-hace.yaml       |   53 +
 .../virt/kvm/x86/amd-memory-encryption.rst         |    5 +-
 MAINTAINERS                                        |    7 +
 arch/arm/Kconfig                                   |    4 -
 arch/arm/boot/dts/aspeed-g5.dtsi                   |    8 +
 arch/arm/boot/dts/aspeed-g6.dtsi                   |    8 +
 arch/arm/configs/exynos_defconfig                  |    1 -
 arch/arm/configs/milbeaut_m10v_defconfig           |    1 -
 arch/arm/configs/multi_v7_defconfig                |    1 -
 arch/arm/configs/omap2plus_defconfig               |    1 -
 arch/arm/configs/pxa_defconfig                     |    1 -
 arch/arm/crypto/Kconfig                            |  238 ++-
 arch/arm64/Kconfig                                 |    3 -
 arch/arm64/configs/defconfig                       |    1 -
 arch/arm64/crypto/Kconfig                          |  279 ++-
 arch/mips/crypto/Kconfig                           |   74 +
 arch/powerpc/crypto/Kconfig                        |   97 +
 arch/s390/crypto/Kconfig                           |  135 ++
 arch/sparc/crypto/Kconfig                          |   90 +
 arch/x86/crypto/Kconfig                            |  484 +++++
 arch/x86/crypto/Makefile                           |    3 +
 arch/x86/crypto/aria-aesni-avx-asm_64.S            | 1303 ++++++++++++
 arch/x86/crypto/aria-avx.h                         |   16 +
 arch/x86/crypto/aria_aesni_avx_glue.c              |  213 ++
 arch/x86/crypto/sha512_ssse3_glue.c                |   10 +
 crypto/Kconfig                                     | 2225 +++++++-------------
 crypto/Makefile                                    |    2 +-
 crypto/akcipher.c                                  |    8 +
 crypto/algapi.c                                    |   71 -
 crypto/api.c                                       |    4 +-
 crypto/{aria.c => aria_generic.c}                  |   39 +-
 crypto/async_tx/raid6test.c                        |    4 +-
 crypto/curve25519-generic.c                        |    4 +-
 crypto/dh.c                                        |    4 +-
 crypto/drbg.c                                      |   12 +-
 crypto/ecdh.c                                      |    4 +-
 crypto/ecdsa.c                                     |    4 +-
 crypto/essiv.c                                     |    2 +-
 crypto/rsa.c                                       |    4 +-
 crypto/sm2.c                                       |    4 +-
 crypto/tcrypt.c                                    |   53 +-
 crypto/testmgr.c                                   |   38 +-
 drivers/char/hw_random/arm_smccc_trng.c            |    4 +-
 drivers/char/hw_random/core.c                      |   55 +-
 drivers/char/hw_random/imx-rngc.c                  |   51 +-
 drivers/crypto/Kconfig                             |    3 +-
 drivers/crypto/Makefile                            |    1 +
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c  |   16 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c  |    6 +-
 drivers/crypto/amlogic/amlogic-gxl-cipher.c        |    6 +-
 drivers/crypto/aspeed/Kconfig                      |   48 +
 drivers/crypto/aspeed/Makefile                     |    7 +
 drivers/crypto/aspeed/aspeed-hace-crypto.c         | 1133 ++++++++++
 drivers/crypto/aspeed/aspeed-hace-hash.c           | 1391 ++++++++++++
 drivers/crypto/aspeed/aspeed-hace.c                |  284 +++
 drivers/crypto/aspeed/aspeed-hace.h                |  298 +++
 drivers/crypto/axis/artpec6_crypto.c               |    6 +-
 drivers/crypto/bcm/cipher.c                        |    4 +-
 drivers/crypto/bcm/cipher.h                        |    2 +-
 drivers/crypto/cavium/cpt/cpt_hw_types.h           |    2 +-
 drivers/crypto/cavium/cpt/cptpf_main.c             |    6 +-
 drivers/crypto/cavium/zip/zip_crypto.c             |   30 +-
 drivers/crypto/ccp/ccp-crypto-des3.c               |    5 +-
 drivers/crypto/ccp/ccp-dmaengine.c                 |    6 +-
 drivers/crypto/ccp/sev-dev.c                       |   78 +-
 drivers/crypto/ccree/cc_buffer_mgr.c               |    2 +-
 drivers/crypto/hisilicon/hpre/hpre.h               |    8 +-
 drivers/crypto/hisilicon/hpre/hpre_crypto.c        |  250 ++-
 drivers/crypto/hisilicon/hpre/hpre_main.c          |  216 +-
 drivers/crypto/hisilicon/qm.c                      |  906 ++++----
 drivers/crypto/hisilicon/sec2/sec.h                |   34 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c         |  456 ++--
 drivers/crypto/hisilicon/sec2/sec_main.c           |  160 +-
 drivers/crypto/hisilicon/zip/zip.h                 |    3 +-
 drivers/crypto/hisilicon/zip/zip_crypto.c          |  134 +-
 drivers/crypto/hisilicon/zip/zip_main.c            |  266 ++-
 drivers/crypto/inside-secure/safexcel_cipher.c     |   60 +-
 drivers/crypto/inside-secure/safexcel_hash.c       |   67 +-
 drivers/crypto/keembay/Kconfig                     |    4 +-
 drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h |    2 +-
 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c  |   24 +-
 drivers/crypto/marvell/octeontx/otx_cptvf_main.c   |    8 +-
 drivers/crypto/marvell/octeontx/otx_cptvf_mbox.c   |   20 +-
 .../crypto/marvell/octeontx2/otx2_cptpf_ucode.c    |    4 +-
 drivers/crypto/marvell/octeontx2/otx2_cptvf_mbox.c |    5 +-
 drivers/crypto/n2_core.c                           |    2 +-
 drivers/crypto/nx/nx-aes-ccm.c                     |    5 +-
 drivers/crypto/qat/qat_common/adf_cfg.c            |    6 +-
 drivers/crypto/qat/qat_common/adf_ctl_drv.c        |   10 +-
 drivers/crypto/qat/qat_common/adf_gen4_hw_data.h   |    2 +-
 .../crypto/qat/qat_common/adf_transport_debug.c    |    2 +-
 drivers/crypto/qat/qat_common/icp_qat_uclo.h       |    3 +-
 drivers/crypto/qat/qat_common/qat_algs.c           |   18 +-
 drivers/crypto/qat/qat_common/qat_asym_algs.c      |   24 +-
 drivers/crypto/qat/qat_common/qat_uclo.c           |   56 +-
 drivers/crypto/qce/aead.c                          |    4 +-
 drivers/crypto/qce/sha.c                           |    8 +-
 drivers/crypto/qce/skcipher.c                      |    8 +-
 drivers/crypto/qcom-rng.c                          |    7 +-
 drivers/crypto/sahara.c                            |   22 +-
 .../crypto/virtio/virtio_crypto_akcipher_algs.c    |    4 +
 drivers/net/Kconfig                                |    2 -
 drivers/net/wireless/ath/ath9k/rng.c               |    3 +-
 include/crypto/aria.h                              |   17 +-
 include/crypto/internal/aead.h                     |   25 -
 include/crypto/scatterwalk.h                       |    6 -
 include/dt-bindings/clock/aspeed-clock.h           |    1 +
 include/dt-bindings/clock/ast2600-clock.h          |    1 +
 include/linux/hisi_acc_qm.h                        |   63 +-
 include/linux/hw_random.h                          |    3 +
 include/uapi/misc/uacce/hisi_qm.h                  |   17 +-
 lib/Kconfig                                        |    3 -
 lib/Makefile                                       |    1 -
 lib/crypto/Kconfig                                 |    7 +-
 lib/crypto/Makefile                                |    3 +
 lib/{ => crypto}/memneq.c                          |    7 +-
 lib/crypto/utils.c                                 |   88 +
 117 files changed, 9052 insertions(+), 2965 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/aspeed,ast2500-hace.yaml
 create mode 100644 arch/mips/crypto/Kconfig
 create mode 100644 arch/powerpc/crypto/Kconfig
 create mode 100644 arch/s390/crypto/Kconfig
 create mode 100644 arch/sparc/crypto/Kconfig
 create mode 100644 arch/x86/crypto/Kconfig
 create mode 100644 arch/x86/crypto/aria-aesni-avx-asm_64.S
 create mode 100644 arch/x86/crypto/aria-avx.h
 create mode 100644 arch/x86/crypto/aria_aesni_avx_glue.c
 rename crypto/{aria.c => aria_generic.c} (86%)
 create mode 100644 drivers/crypto/aspeed/Kconfig
 create mode 100644 drivers/crypto/aspeed/Makefile
 create mode 100644 drivers/crypto/aspeed/aspeed-hace-crypto.c
 create mode 100644 drivers/crypto/aspeed/aspeed-hace-hash.c
 create mode 100644 drivers/crypto/aspeed/aspeed-hace.c
 create mode 100644 drivers/crypto/aspeed/aspeed-hace.h
 rename lib/{ => crypto}/memneq.c (98%)
 create mode 100644 lib/crypto/utils.c

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
