Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3017C5EF14B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbiI2JH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbiI2JHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:07:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFFB14019B;
        Thu, 29 Sep 2022 02:07:21 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bj12so1402936ejb.13;
        Thu, 29 Sep 2022 02:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4O0MPzWnZMFOr4EIiY82lHvEoYOUCd7VpBRbUFADn+c=;
        b=PxUf2qxFg4pca8Dyzl5xgvgjV1zJqNz2iSA1FfD7NJtaslvanpGEiPovW5ShzW5RjC
         Xyo/0FTKnYLjvpR0k5bK/V+mQerEC56wFu6VlTXcnCGtFCtYdcBQnKTR99krzvmKM/BL
         bodlxI8+rC5vHTsde49lcDJDq0CYOi/EcPsZuDB7Egk3kWlXZhMIi34WV9dRbDxgJ90N
         JusJswKU8WYuNJbg1hifuq9I4/cVQdJtD7Ol01LBDMTm5bXHPhq0KmEoXnxy5KMSADH6
         Y8jMun7MfaqW5LOp1bJoGdsf91AUd8d9Xoy9wrae628Ic8KlvtGrQopGAxCZHcJcJKlX
         qhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4O0MPzWnZMFOr4EIiY82lHvEoYOUCd7VpBRbUFADn+c=;
        b=p3NjuvdTr9zJ3uU0srYskhCeNyEgABqc6SPJl360I5ix9EVBXEg1ERCJbOvfttzJMH
         0UHJG01Hvc9DOihROpVA6wdWrKKbaancLSXgDdADY9Zyx4N25E0Zgfq2jJHtMPzYWt+1
         /ZSSVYh6c2Hh7M+ebukgaReLAlEwfhP7LZG5AiFUNrQnlikCpOyFMZcrmb3rvs5P0zZ+
         2MOoWr6JyWLRJ/Rw1SYP40tyY11OkLOVsNhIZMAAYNNvMJ1hct5o7OlEMGy8B0XGG3Vf
         1DUUTstJan97guJs7IPsCc0okp11cVEjAqVN7jgeUkCvWHKyiadrIrhXMnjoNh6ORv6J
         OEXQ==
X-Gm-Message-State: ACrzQf2KhagBvt5PcErMtsFYTSRqMbU97aC08aBRNJXxRxEra25jCbmh
        yBObcjr7B8d2+1DZ9hGUQMlfbzoFyk0=
X-Google-Smtp-Source: AMsMyM5+96cSUkEo8g3qFervtKPgfLAsQcYRMB4B/CY/fXJltrL658Nr6cv2XPJBwKpm5qkOxrO7tg==
X-Received: by 2002:a17:906:8a76:b0:781:7530:8b05 with SMTP id hy22-20020a1709068a7600b0078175308b05mr1843001ejc.489.1664442439254;
        Thu, 29 Sep 2022 02:07:19 -0700 (PDT)
Received: from felia.fritz.box (200116b826e11200b190ebfd45660ea6.dip.versatel-1u1.de. [2001:16b8:26e1:1200:b190:ebfd:4566:ea6])
        by smtp.gmail.com with ESMTPSA id k21-20020a1709065fd500b0073d7bef38e3sm3651755ejv.45.2022.09.29.02.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 02:07:18 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Update config files to current config definitions
Date:   Thu, 29 Sep 2022 11:06:45 +0200
Message-Id: <20220929090645.1389-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,


Here is some in-detail explanation for clean-up patches to come.

# Motivation

There are various config files in the arch/*/configs/ directory, which have
been added at some point in the past, but have not been really maintained
with the various changes of config symbols that have been made, e.g.,
config symbol removals, renamings, splitting, etc.

This makes these configs refer to many outdated config symbols.
The script ./scripts/checkkconfigsymbols.py reports on

Many findings are referring to these unmaintained config files now. After
submitting a number of patches to clean up obsolete config symbols in
Kconfig files, Makefiles and some source files, it is time to clean up all
the config files as well.

The actual patches are created with a combination of simple bash scripting
and some manual assessment, 

# Config Symbol Collection

First, scripts/checkkconfigsymbols.py is run, and then its output is
filtered down to the configs that are referenced in config files.

# Config Assessment

For each config symbol, we need to decide if it is to be removed, replaced
with another config or kept in the config file. Further, we record why we
came to that conclusion. For this decision, we automatically collect some
background information from the git history and if no git history is
available, search manually for patches that mention this config symbol.

The overall information can be aggregated in the following form:

config <config-symbol name>:

History:
  - last defined in file <Konfig file> with kernel release <kernel-version> 
  - disappeared in commit <commit hash> ("<commit message>")
  OR:
  - never part of main-line kernel repository and patch search resulted in:
    - config definition probably never made it to mainline, found no public record of a pending patch (no-patch-found)
    - recent pending patches, to be integrated soon (recent)
    - historic patches, never integrated (historic)

Decision:
  remove, rationale: functionality/behavior is default. (rm-def)
  remove, rationale: functionality/behavior was removed. (rm-rm)
  remove, rationale: config never had an effect for mainline testing. (rm-oot)
  keep, rationale: option recently added in config, config definition pending (keep-recent)
  replace with <name of new config-symbol>, rationale: config was renamed (with no significant change of its semantics) (mv-<CONFIG_NAME>)
  complex cleanup operation, rationale: config was split in a complex way and needs dedicated manual change (manual)

This information above then summarized below in two tables, using a few
abbreviations (see Appendix below).

For all config symbols that never existed in the repository, the following
one-line abbreviated form is used:

<config-symbol name>;<result-of-patch-search>(<pending-patch-references>);<decision-abbrev>

If the config existed in the repository, the following one-line abbreviated
form is used:

<config-symbol name>;<Kconfig file>;<commit reference>;<decision-abbrev>

# Patch Creation

Once all this information collected, the actual changes for each patch is
straight-forward and just needs to be submitted according to the
corresponding maintainer/subsystem to pick them up.

# Expected Effects (if at all)

The removal of non-existing config symbols should have no effect on any use
case. The fact that I spent some effort to identify the new symbols to
which historic config symbols have been renamed to, and then re-added the
new config symbol when deleting the old symbol, may have surprising effects
for some use cases, though.

Some functionality on some configs might have been inactive for so long
that bugs have creeped in, and with this change actually restoring the
initial intent of the original config, tests might reveal that some
things have been broken in the meantime.

It is not the patch series to blame, though, but then just requires to
understand what happened while testing on this config symbol was not
active. In the end, we are possibly just reactivating some testing that
was accidently by config changes switched off.

# Appendix: Record of Assessment

Config symbols that never existed in the repository:

ARCH_NXP;recent(https://lore.kernel.org/linux-arm-kernel/20220907070626.2933998-1-michael@walle.cc/);keep-recent
ARCPGU_DISPTYPE;no-patch-found;rm-oot
ARCPGU_RGB888;no-patch-found;rm-oot
CGROUP_MEMCG;no-patch-found;rm-oot
CGROUP_MEMCG_SWAP;no-patch-found;rm-oot
COMMON_CLK_NPCM8XX;recent(https://lore.kernel.org/linux-arm-kernel/20220619151225.209029-1-tmaimon77@gmail.com/);keep-recent
DT_BCM974XX;no-patch-found;rm-oot
FB_SH7785FB;no-patch-found;rm-oot
INPUT_IBM_PANEL;recent(https://lore.kernel.org/lkml/20220809204147.238132-3-eajames@linux.ibm.com/);keep-recent
MMP_SPI;no-patch-found;rm-oot
PCIE_AXXIA;historic(https://lore.kernel.org/lkml/cover.1398335771.git.anders.berg@lsi.com/);rm-oot
SPI_BRCMSTB;no-patch-found;rm-oot
SUSPEND_TIME;no-patch-found;rm-oot
USB_EHCI_HCD_AXXIA;historic(https://lore.kernel.org/lkml/cover.1398335771.git.anders.berg@lsi.com/);rm-oot
USB_OTG_WAKELOCK;no-patch-found;rm-oot

Config symbols that existed in the repository:

88EU_AP_MODE;./drivers/staging/r8188eu/Kconfig;v5.15;'commit 102243f893ec ("staging: r8188eu: Remove conditionals CONFIG_88EU_{AP_MODE,P2P}")';rm-def
AHCI_BRCMSTB;./drivers/ata/Kconfig;v4.7;'commit eba68f829794 ("ata: ahci_brcmstb: rename to support across Broadcom SoC's")';mv AHCI_BRCM
ANDROID_LOW_MEMORY_KILLER;./drivers/staging/android/Kconfig;v4.11;'commit 915e70f9263d ("staging, android: remove lowmemory killer from the tree")';rm-rm
ARCH_AUTCPU12;./arch/arm/mach-clps711x/Kconfig;v4.7;'commit 4a56f46a7dc6 ("ARM: clps711x: Remove boards support")';rm-rm
ARCH_CDB89712;./arch/arm/mach-clps711x/Kconfig;v4.7;'commit 4a56f46a7dc6 ("ARM: clps711x: Remove boards support")';rm-rm
ARCH_CLEP7312;./arch/arm/mach-clps711x/Kconfig;v4.7;'commit 4a56f46a7dc6 ("ARM: clps711x: Remove boards support")';rm-rm
ARCH_EDB7211;./arch/arm/mach-clps711x/Kconfig;v4.7;'commit 4a56f46a7dc6 ("ARM: clps711x: Remove boards support")';rm-rm
ARCH_P720T;./arch/arm/mach-clps711x/Kconfig;v4.7;'commit 4a56f46a7dc6 ("ARM: clps711x: Remove boards support")';rm-rm
ARPD;./net/ipv4/Kconfig;v3.11;'commit 3e25c65ed085 ("net: neighbour: Remove CONFIG_ARPD")';rm-def
ASHMEM;./drivers/staging/android/Kconfig;v5.17;'commit 721412ed3d81 ("staging: remove ashmem")';rm-rm
ATH79_MACH_AP121;./arch/mips/ath79/Kconfig;v5.0;'commit 3a77e0d75eed ("MIPS: ath79: drop machfiles")';rm-rm
ATH79_MACH_AP136;./arch/mips/ath79/Kconfig;v5.0;'commit 3a77e0d75eed ("MIPS: ath79: drop machfiles")';rm-rm
ATH79_MACH_AP81;./arch/mips/ath79/Kconfig;v5.0;'commit 3a77e0d75eed ("MIPS: ath79: drop machfiles")';rm-rm
ATH79_MACH_DB120;./arch/mips/ath79/Kconfig;v5.0;'commit 3a77e0d75eed ("MIPS: ath79: drop machfiles")';rm-rm
ATH79_MACH_PB44;./arch/mips/ath79/Kconfig;v5.0;'commit 3a77e0d75eed ("MIPS: ath79: drop machfiles")';rm-rm
ATH79_MACH_UBNT_XM;./arch/mips/ath79/Kconfig;v5.0;'commit 3a77e0d75eed ("MIPS: ath79: drop machfiles")';rm-rm
BACKLIGHT_LCD_SUPPORT;./drivers/video/backlight/Kconfig;v5.1;'commit 8c5dc8d9f19c ("video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT kernel symbol")';rm-def
BLK_DEV_CRYPTOLOOP;./drivers/block/Kconfig;v5.15;'commit 47e9624616c8 ("block: remove support for cryptoloop and the xor transfer")';rm-rm
BLK_DEV_IDECD;./drivers/ide/Kconfig;v5.13;'commit b7fb14d3ac63 ("ide: remove the legacy ide driver")';rm-rm
BLK_DEV_SX8;./drivers/block/Kconfig;v5.19;'commit d13bc4d84a8e ("remove the sx8 block driver")';rm-rm
BT_HCIBTUART;./drivers/bluetooth/Kconfig;v4.16;'commit 6f6f1eced8c3 ("Bluetooth: Remove unused btuart_cs driver")';rm-rm
CACHEFILES_HISTOGRAM;./fs/cachefiles/Kconfig;v5.14;'commit 6ae9bd8bb037 ("fscache, cachefiles: Remove the histogram stuff")';rm-rm
CC_STACKPROTECTOR_REGULAR;./arch/Kconfig;v4.17;'commit 2a61f4747eea ("stack-protector: test compiler capability in Kconfig and drop AUTO mode")';rm-def
CC_STACKPROTECTOR_STRONG;./arch/Kconfig;v4.17;'commit 050e9baa9dc9 ("Kbuild: rename CC_STACKPROTECTOR[_STRONG] config variables")';rm-def
CHR_DEV_OSST;./drivers/scsi/Kconfig;v5.2;'commit 4e3ea141b5cb ("scsi: osst: kill obsolete driver")';rm-rm
CIFS_STATS;./fs/cifs/Kconfig;v4.18;'commit fcabb89299d7 ("cifs: simple stats should always be enabled")';rm-def
CPU_FREQ_STAT_DETAILS;./drivers/cpufreq/Kconfig;v4.10;'commit 801e0f378fe7 ("cpufreq: Remove CONFIG_CPU_FREQ_STAT_DETAILS config option")';mv CPU_FREQ_STAT
CROSS_COMPILE;./init/Kconfig;v4.17;'commit f1089c92da79 ("kbuild: remove CONFIG_CROSS_COMPILE support")';rm-rm
CRYPTO_BLAKE2S;./crypto/Kconfig;v5.19;'commit 2d16803c562e ("crypto: blake2s - remove shash module")';rm-rm
CRYPTO_RMD128;./crypto/Kconfig;v5.11;'commit b21b9a5e0aef ("crypto: rmd128 - remove RIPE-MD 128 hash algorithm")';rm-rm
CRYPTO_RMD256;./crypto/Kconfig;v5.11;'commit c15d4167f0b0 ("crypto: rmd256 - remove RIPE-MD 256 hash algorithm")';rm-rm
CRYPTO_RMD320;./crypto/Kconfig;v5.11;'commit 93f64202926f ("crypto: rmd320 - remove RIPE-MD 320 hash algorithm")';rm-rm
CRYPTO_SALSA20;./crypto/Kconfig;v5.11;'commit 663f63ee6d9c ("crypto: salsa20 - remove Salsa20 stream cipher algorithm")';rm-rm
CRYPTO_TGR192;./crypto/Kconfig;v5.11;'commit 87cd723f8978 ("crypto: tgr192 - remove Tiger 128/160/192 hash algorithms")';rm-rm
DEBUG_SPINLOCK_SLEEP;./lib/Kconfig.debug;v3.0;'commit d902db1eb603 ("sched: Generalize sleep inside spinlock detection")';mv DEBUG_ATOMIC_SLEEP
DETECT_SOFTLOCKUP;./lib/Kconfig.debug;v2.6.35;'commit e16bb1d7fe07 ("lockup_detector: Update some config")';mv LOCKUP_DETECTOR
DEVKMEM;./drivers/char/Kconfig;v5.12;'commit bbcd53c96071 ("drivers/char: remove /dev/kmem for good")';rm-rm
DEVPTS_MULTIPLE_INSTANCES;./drivers/tty/Kconfig;v4.6;'commit eedf265aa003 ("devpts: Make each mount of devpts an independent filesystem.")';rm-def
DM9000_DEBUGLEVEL;./drivers/net/ethernet/davicom/Kconfigv3.1;'commit 2e025c71ce3d ("dm9000: define debug level as a module parameter")';rm-rm
DRM_TINYDRM;./drivers/gpu/drm/tinydrm/Kconfig;v5.3;'commit 28c47e16ea2a ("drm/tinydrm/Kconfig: Remove menuconfig DRM_TINYDRM")';rm-def
DSCC4;./drivers/net/wan/Kconfig;v5.3;'commit 28c9eb9042a9 ("net/wan: dscc4: remove broken dscc4 driver")';rm-rm
DSCC4_PCISYNC;./drivers/net/wan/Kconfig;v5.14;'commit db3db1f41754 ("wan: remove stale Kconfig entries")';rm-rm
DSCC4_PCI_RST;./drivers/net/wan/Kconfig;v5.14;'commit db3db1f41754 ("wan: remove stale Kconfig entries")';rm-rm
DVB_FE_CUSTOMISE;./drivers/media/dvb/frontends/Kconfig;v3.6;'commit fccea74ff8b5 ("[media] Kconfig: merge all customise options into just one")';rm-rm
ENABLE_MUST_CHECK;./lib/Kconfig.debug;v5.10;'commit 196793946264 ("Compiler Attributes: remove CONFIG_ENABLE_MUST_CHECK")';rm-def
EXOFS_FS;./fs/exofs/Kconfig;v5.0;'commit 80f2121380ca ("scsi: fs: remove exofs")';rm-rm
EXT2_FS_XIP;./fs/ext2/Kconfig;v3.19;'commit 6cd176a51e52 ("vfs,ext2: remove CONFIG_EXT2_FS_XIP and rename CONFIG_FS_XIP to CONFIG_FS_DAX")';mv FS_DAX
EXT3_DEFAULTS_TO_ORDERED;./fs/ext3/Kconfig;v4.2;'commit c290ea01abb7 ("fs: Remove ext3 filesystem driver")';rm-rm
EXT3_FS_XATTR;./fs/ext3/Kconfig;v4.2;'commit c290ea01abb7 ("fs: Remove ext3 filesystem driver")';rm-rm
FB_MBX;./drivers/video/fbdev/Kconfig;v5.9;'commit 5c1529122394 ("fbdev: remove mbx framebuffer driver")';rm-rm
FB_XGI;./drivers/staging/xgifb/Kconfig;v5.0;'commit b1bd42aa72d6 ("staging: xgifb: delete the driver")';rm-rm
FSCACHE_HISTOGRAM;./fs/fscache/Kconfig;v5.14;'commit 6ae9bd8bb037 ("fscache, cachefiles: Remove the histogram stuff")';rm-rm
FSCACHE_OBJECT_LIST;./fs/fscache/Kconfig;v5.14;'commit 58f386a73f16 ("fscache: Remove the object list procfile")';rm-rm
GPIO_MOXART;./drivers/gpio/Kconfig;v4.11;'commit d8307c09206b ("gpio: moxart: Switch to using the FTGPIO010 driver")';rm-rm
HARDENED_USERCOPY_PAGESPAN;./security/Kconfig;v5.18;'commit 1109a5d90701 ("usercopy: Remove HARDENED_USERCOPY_PAGESPAN")';rm-rm
HEADERS_CHECK;./lib/Kconfig.debug;v5.4;'commit 7ecaf069da52 ("kbuild: move headers_check rule to usr/include/Makefile")';rm-def
HID_SUPPORT;./drivers/hid/Kconfig;v3.4;'commit 1f41a6a99476 ("HID: Fix the generic Kconfig options")';rm-def
HOTPLUG;./init/Kconfig;v3.10;'commit 40b313608ad4 ("Finally eradicate CONFIG_HOTPLUG")';rm-def
HP100;./drivers/staging/hp/Kconfig;v5.6;'commit a10079c66290 ("staging: remove hp100 driver")';rm-rm
I2C_PARPORT_LIGHT;./drivers/i2c/busses/Kconfig;v5.5;'commit 710b65335c19 ("i2c: parport-light: remove driver")';rm-rm
INET6_XFRM_MODE_BEET;./net/ipv6/Kconfig;v5.1;'commit 4c145dce2601 ("xfrm: make xfrm modes builtin")';rm-def
INET6_XFRM_MODE_ROUTEOPTIMIZATION;./net/ipv6/Kconfig;v5.1;'commit 4c145dce2601 ("xfrm: make xfrm modes builtin")';rm-def
INET6_XFRM_MODE_TRANSPORT;./net/ipv6/Kconfig;v5.1;'commit 4c145dce2601 ("xfrm: make xfrm modes builtin")';rm-def
INET6_XFRM_MODE_TUNNEL;./net/ipv6/Kconfig;v5.1;'commit 4c145dce2601 ("xfrm: make xfrm modes builtin")';rm-def
INET_LRO;./net/ipv4/Kconfig;v4.5;'commit 7bbf3cae65b6 ("ipv4: Remove inet_lro library")';rm-rm
INET_XFRM_MODE_BEET;./net/ipv4/Kconfig;v5.1;'commit 4c145dce2601 ("xfrm: make xfrm modes builtin")';rm-def
INET_XFRM_MODE_TRANSPORT;./net/ipv4/Kconfig;v5.1;'commit 4c145dce2601 ("xfrm: make xfrm modes builtin")';rm-def
INET_XFRM_MODE_TUNNEL;./net/ipv4/Kconfig;v5.1;'commit 4c145dce2601 ("xfrm: make xfrm modes builtin")';rm-def
INPUT_GPIO;./drivers/staging/dream/Kconfig;v2.6.36;'commit 3414df8ca38b ("Staging: dream: remove dream driver and arch from tree")';rm-rm
INPUT_MSM_VIBRATOR;./drivers/input/misc/Kconfig;v5.7;'commit 2ecf9487a7c8 ("Input: remove msm-vibrator driver")';rm-rm
IOSCHED_CFQ;./block/Kconfig.iosched;v4.20;'commit f382fb0bcef4 ("block: remove legacy IO schedulers")';rm-rm
IOSCHED_DEADLINE;./block/Kconfig.iosched;v4.20;'commit f382fb0bcef4 ("block: remove legacy IO schedulers")';rm-rm
IPV6_PRIVACY;./net/ipv6/Kconfig;v3.12;'commit 5d9efa7ee99e ("ipv6: Remove privacy config option.")';rm-def
IP_NF_MATCH_ADDRTYPE;./net/ipv4/netfilter/Kconfig;v2.6.38;'commit de81bbea1765 ("netfilter: ipt_addrtype: rename to xt_addrtype")';mv NETFILTER_XT_MATCH_ADDRTYPE
IP_NF_TARGET_LOG;./net/ipv4/netfilter/Kconfig;v3.3;'commit 6939c33a757b ("netfilter: merge ipt_LOG and ip6_LOG into xt_LOG")';mv NETFILTER_XT_TARGET_LOG
IWLWIFI_BCAST_FILTERING;./drivers/net/wireless/intel/iwlwifi/Kconfig;v5.16;'commit 92883a524ae9 ("iwlwifi: remove deprecated broadcast filtering feature")';rm-rm
KALLSYMS_EXTRA_PASS;./init/Kconfig;v2.6.39;'commit 1e2795a1191b ("kbuild: move KALLSYMS_EXTRA_PASS from Kconfig to Makefile")';rm-rm
MAC80211_RC_PID;./net/mac80211/Kconfig;v3.16;'commit 20edb50e593d ("mac80211: remove PID rate control")';rm-rm
MACH_DOVE_DT;./arch/arm/mach-dove/Kconfig;v3.14;'commit 00e8ec2f0b05 ("ARM: mvebu: move DT Dove to MVEBU")';mv MACH_DOVE
MACH_IMX27_VISSTRIM_M10;./arch/arm/mach-imx/Kconfig;v5.9;'commit 879c0e5e0ac7 ("ARM: imx: Remove i.MX27 board files")';mv SOC_IMX27
MACH_LINKSTATION_LSCHL;./arch/arm/mach-orion5x/Kconfig;v4.9;'commit ecfe69639157 ("ARM: orion5x: remove legacy support of ls-chl")';rm-rm
MACH_MX21ADS;./arch/arm/mach-imx/Kconfig;v5.9;'commit 4b563a066611 ("ARM: imx: Remove imx21 support")';rm-rm
MACH_MX27ADS;./arch/arm/mach-imx/Kconfig;v5.9;'commit 879c0e5e0ac7 ("ARM: imx: Remove i.MX27 board files")';rm-rm
MACH_MX27_3DS;./arch/arm/mach-imx/Kconfig;v5.9;'commit 879c0e5e0ac7 ("ARM: imx: Remove i.MX27 board files")';rm-rm
MACH_PCA100;./arch/arm/mach-imx/Kconfig;v5.9;'commit 879c0e5e0ac7 ("ARM: imx: Remove i.MX27 board files")';rm-rm
MEDIA_TUNER_CUSTOMISE;./drivers/media/common/tuners/Kconfig;v3.6;'commit fccea74ff8b5 ("[media] Kconfig: merge all customise options into just one")';rm-rm
MFD_SH_MOBILE_SDHI;./drivers/mfd/Kconfig;v2.6.38;'commit 42051e8a7bce ("mmc: tmio: convert the SDHI MMC driver from MFD to a platform driver")';mv MMC_SDHI
MSCC_OCELOT_SWITCH_OCELOT;./drivers/net/ethernet/mscc/Kconfig;v5.8;'commit 14addfb6356b ("net: mscc: ocelot: rename MSCC_OCELOT_SWITCH_OCELOT to MSCC_OCELOT_SWITCH")';mv MSCC_OCELOT_SWITCH
MTD_DEBUG;./drivers/mtd/Kconfig;v3.1;'commit 87ed114bb22b ("mtd: remove CONFIG_MTD_DEBUG")';rm-rm
MTD_DEBUG_VERBOSE;./drivers/mtd/Kconfig;v3.1;'commit 87ed114bb22b ("mtd: remove CONFIG_MTD_DEBUG")';rm-rm
MTD_DOC2000;./drivers/mtd/devices/Kconfig;v3.9;'commit b5a6c3095f0b ("mtd: doc: remove support for DoC 2000/2001/2001+")';rm-rm
MTD_DOC2001;./drivers/mtd/devices/Kconfig;v3.9;'commit b5a6c3095f0b ("mtd: doc: remove support for DoC 2000/2001/2001+")';rm-rm
MTD_DOC2001PLUS;./drivers/mtd/devices/Kconfig;v3.9;'commit b5a6c3095f0b ("mtd: doc: remove support for DoC 2000/2001/2001+")';rm-rm
MTD_DOCPROBE_ADDRESS;./drivers/mtd/devices/Kconfig;v3.11;'commit 9d40349681ea ("mtd: diskonchip: remove unused entries in Kconfig")';rm-rm
MTD_DOCPROBE_ADVANCED;./drivers/mtd/devices/Kconfig;v3.11;'commit 9d40349681ea ("mtd: diskonchip: remove unused entries in Kconfig")';rm-rm
MTD_DOCPROBE_HIGH;./drivers/mtd/devices/Kconfig;v3.11;'commit 9d40349681ea ("mtd: diskonchip: remove unused entries in Kconfig")';rm-rm
MTD_M25P80;./drivers/mtd/devices/Kconfig;v5.3;'commit b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")';mv MTD_SPI_NOR
MTD_NAND;./drivers/mtd/nand/raw/Kconfig;v5.1;'commit 72c5af002723 ("mtd: rawnand: Clarify Kconfig entry MTD_NAND")';mv MTD_RAW_NAND
MTD_NAND_CM_X270;./drivers/mtd/nand/raw/Kconfig;v5.7;'commit 767727b927aa ("mtd: rawnand: Remove the cmx270 NAND controller driver")';rm-rm
ND_BLK;./drivers/nvdimm/Kconfig;v5.17;'commit f8669f1d6a86 ("nvdimm/blk: Delete the block-aperture window driver")';rm-rm
NETDEV_1000;./drivers/net/Kconfig;v3.1;'commit f860b0522f65 ("drivers/net: Kconfig and Makefile cleanup")';rm-def
NETDEV_10000;./drivers/net/Kconfig;v3.1;'commit f860b0522f65 ("drivers/net: Kconfig and Makefile cleanup")';rm-def
NETFILTER_TPROXY;./net/netfilter/Kconfig;v3.11;'commit fd158d79d33d ("netfilter: tproxy: remove nf_tproxy_core, keep tw sk assigned to skb")';mv NETFILTER_XT_TARGET_TPROXY
NET_CADENCE;./drivers/net/ethernet/cadence/Kconfig;v4.18;'commit 0df5f81c481e ("net: ethernet: Add missing VENDOR to Cadence and Packet Engines symbols")';mv NET_VENDOR_CADENCE
NET_DMA;./drivers/dma/Kconfig;v3.17;'commit 7bced397510a ("net_dma: simple removal")';rm-rm
NET_DSA_MICROCHIP_KSZ9477;./drivers/net/dsa/microchip/Kconfig;v5.19;'commit 07bca160469b ("net: dsa: microchip: common menuconfig for ksz series switch")';mv NET_DSA_MICROCHIP_KSZ_COMMON
NET_DSA_MICROCHIP_KSZ9477_SPI;./drivers/net/dsa/microchip/Kconfig;v5.19;'commit 4658f2fe8fbc ("net: dsa: microchip: common ksz_spi_probe for ksz switches")';mv NET_DSA_MICROCHIP_KSZ_SPI
NET_ETHERNET;./drivers/net/Kconfig;v3.1;'commit f860b0522f65 ("drivers/net: Kconfig and Makefile cleanup")';rm-rm
NET_PCI;./drivers/net/Kconfig;v3.1;'commit f860b0522f65 ("drivers/net: Kconfig and Makefile cleanup")';rm-rm
NET_PCMCIA;./drivers/net/pcmcia/Kconfig;v3.1;'commit 330278cde612 ("com20020_cs: Move the PCMCIA Arcnet driver")';mv ARCNET
NET_TCPPROBE;./net/Kconfig;v4.15;'commit 6987990c3e16 ("net: tcp: Remove TCP probe module")';rm-rm
NET_VENDOR_AURORA;./drivers/net/ethernet/aurora/Kconfig;v5.11;'commit 19038523a735 ("net: remove aurora nb8800 driver")';rm-rm
NET_VENDOR_HP;./drivers/staging/hp/Kconfig;v5.6;'commit a10079c66290 ("staging: remove hp100 driver")';rm-rm
NET_VENDOR_SMC;./drivers/net/Kconfig;v3.1;'commit ae150435b59e ("smsc: Move the SMC (SMSC) drivers")';mv NET_VENDOR_SMSC
NFT_COUNTER;./net/netfilter/Kconfig;v5.16;'commit 023223dfbfb3 ("netfilter: nf_tables: make counter support built-in")';rm-def
NF_CONNTRACK_IPV4;./net/ipv4/netfilter/Kconfig;v4.18;'commit a0ae2562c6c4 ("netfilter: conntrack: remove l3proto abstraction")';rm-def
NF_CONNTRACK_IPV6;./net/ipv6/netfilter/Kconfig;v4.18;'commit a0ae2562c6c4 ("netfilter: conntrack: remove l3proto abstraction")';rm-def
NF_FLOW_TABLE_IPV4;./net/ipv4/netfilter/Kconfig;v5.16;'commit 7355bfe0e0cc ("netfilter: Remove flowtable relics")';rm-rm
NF_FLOW_TABLE_IPV6;./net/ipv6/netfilter/Kconfig;v5.16;'commit 7355bfe0e0cc ("netfilter: Remove flowtable relics")';rm-rm
NF_LOG_BRIDGE;./net/bridge/netfilter/Kconfig;v5.12;'commit 77ccee96a674 ("netfilter: nf_log_bridge: merge with nf_log_syslog")';rm-def
NF_LOG_NETDEV;./net/netfilter/Kconfig;v5.12;'commit 1510618e45cb ("netfilter: nf_log_netdev: merge with nf_log_syslog")';rm-def
NL80211;./net/wireless/Kconfig;v2.6.29;'commit 633e24ed95b6 ("cfg80211/nl80211: remove usage of CONFIG_NL80211")';rm-def
NR_DMA_CHANNELS;./arch/sh/drivers/dma/Kconfig;v3.4;'commit e24cca19babe ("sh: Kill off MAX_DMA_ADDRESS leftovers.")';rm-rm
NR_DMA_CHANNELS_BOOL;./arch/sh/drivers/dma/Kconfig;v3.4;'commit e24cca19babe ("sh: Kill off MAX_DMA_ADDRESS leftovers.")';rm-rm
PCIEASPM_DEBUG;./drivers/pci/pcie/Kconfig;v5.4;'commit 87e90283c94c ("PCI/ASPM: Remove PCIEASPM_DEBUG Kconfig option and related code")';rm-rm
PERF_COUNTERS;./init/Kconfig;v3.4;'commit 392d65a9adbe ("perf: Remove PERF_COUNTERS config option")';mv PERF_EVENTS
PHONE;./drivers/staging/telephony/Kconfig;v3.7;'commit 7326446c728f ("Staging: remove telephony drivers")';rm-rm
PM_RUNTIME;./kernel/power/Kconfig;v3.18;'commit 464ed18ebdb6 ("PM: Eliminate CONFIG_PM_RUNTIME")';rm-def
PPC_PTDUMP;./arch/powerpc/Kconfig.debug;v5.14;'commit e084728393a5 ("powerpc/ptdump: Convert powerpc to GENERIC_PTDUMP")';mv GENERIC_PTDUMP
PROC_DEVICETREE;./drivers/of/Kconfig;v3.14;'commit 8357041a69b3 ("of: remove /proc/device-tree")';rm-rm
QCOM_ADSP_PIL;./drivers/remoteproc/Kconfig;v4.19;'commit 9e004f97161d ("remoteproc: qcom: Rename Hexagon v5 PAS driver")';mv QCOM_Q6V5_PAS
QCOM_PM;./drivers/soc/qcom/Kconfig;v5.7;'commit a871be6b8eee ("cpuidle: Convert Qualcomm SPM driver to a generic CPUidle driver")';mv ARM_QCOM_SPM_CPUIDLE
QCOM_Q6V5_PIL;./drivers/remoteproc/Kconfig;v4.19;'commit ef73c22fa025 ("remoteproc: qcom: Rename Hexagon v5 modem driver")';mv QCOM_Q6V5_PAS
RAPIDIO_TSI568;./drivers/rapidio/switches/Kconfig;v5.16;'commit 612d4904191f ("rapidio: remove not used code about RIO_VID_TUNDRA")';rm-rm
RAPIDIO_TSI57X;./drivers/rapidio/switches/Kconfig;v5.16;'commit 612d4904191f ("rapidio: remove not used code about RIO_VID_TUNDRA")';rm-rm
RAW_DRIVER;./drivers/char/Kconfig;v5.13;'commit 603e4922f1c8 ("remove the raw driver")';rm-rm
ROCKETPORT;./drivers/tty/Kconfig;v5.12;'commit 3b00b6af7a5b ("tty: rocket, remove the driver")';rm-rm
RTC_DRV_TX4939;./drivers/rtc/Kconfig;v5.11;'commit 446667df2830 ("rtc: tx4939: Remove driver")';rm-rm
SCSI_DPT_I2O;./drivers/scsi/Kconfig;v5.19;'commit b04e75a4a8a8 ("scsi: dpt_i2o: Remove obsolete driver")';rm-rm
SCSI_MULTI_LUN;./drivers/scsi/Kconfig;v3.16;'commit c309b35171dd ("scsi: Remove CONFIG_SCSI_MULTI_LUN")';rm-rm
SCSI_OSD_INITIATOR;./drivers/scsi/osd/Kconfig;v5.0;'commit 19fcae3d4f2d ("scsi: remove the SCSI OSD library")';rm-rm
SCSI_OSD_ULD;./drivers/scsi/osd/Kconfig;v5.0;'commit 19fcae3d4f2d ("scsi: remove the SCSI OSD library")';rm-rm
SMB_FS;./drivers/staging/smbfs/Kconfig;v2.6.38;'commit 939cbe5af5fb ("staging: remove smbfs")';rm-rm
SMB_NLS_DEFAULT;./drivers/staging/smbfs/Kconfig;v2.6.38;'commit 939cbe5af5fb ("staging: remove smbfs")';rm-rm
SND_FSI_AK4642;./sound/soc/sh/Kconfig;v3.4;'commit af8a2fe12fae ("ASoC: sh: fsi: use simple-card instead of fsi-ak4642")';mv SND_SOC_AK4642
SND_FSI_DA7210;./sound/soc/sh/Kconfig;v3.4;'commit 064bfada6677 ("ASoC: sh: fsi: use simple-card instead of fsi-da7210")';mv SND_SOC_DA7210
SND_SOC_IMX_MC13783;./sound/soc/fsl/Kconfig;v5.10;'commit 83e7e2278680 ("ASoC: imx-mc13783: Remove unused driver")';rm-rm
SND_SOC_MX27VIS_AIC32X4;./sound/soc/fsl/Kconfig;v5.10;'commit 3fbb01fb583f ("ASoC: mx27vis-aic32x4: Remove unused driver")';rm-rm
SND_SOC_PHYCORE_AC97;./sound/soc/fsl/Kconfig;v5.10;'commit 440534a0ecfd ("ASoC: phycore-ac97: Remove unused driver")';rm-rm
SND_SOC_TXX9ACLC;./sound/soc/txx9/Kconfig;v5.11;'commit a8644292ea46 ("ASoC: txx9: Remove driver")';rm-rm
SND_SOC_TXX9ACLC_GENERIC;./sound/soc/txx9/Kconfig;v5.11;'commit a8644292ea46 ("ASoC: txx9: Remove driver")';rm-rm
SOUND_DMAP;./sound/oss/Kconfig;v4.14;'commit 727dede0ba8a ("sound: Retire OSS")';rm-rm
SOUND_OSS;./sound/oss/Kconfig;v4.14;'commit 727dede0ba8a ("sound: Retire OSS")';rm-rm
SOUND_PRIME;./sound/Kconfig;v4.14;'commit 727dede0ba8a ("sound: Retire OSS")';rm-rm
SOUND_TRACEINIT;./sound/oss/Kconfig;v4.14;'commit 727dede0ba8a ("sound: Retire OSS")';rm-rm
SOUND_VIDC;./sound/oss/Kconfig;v4.14;'commit 727dede0ba8a ("sound: Retire OSS")';rm-rm
SOUND_WAVEARTIST;./sound/oss/Kconfig;v4.14;'commit 727dede0ba8a ("sound: Retire OSS")';rm-rm
SOUND_YM3812;./sound/oss/Kconfig;v4.14;'commit 727dede0ba8a ("sound: Retire OSS")';rm-rm
SPI_TXX9;./drivers/spi/Kconfig;v5.11;'commit 74523a5dae0c ("spi: txx9: Remove driver")';rm-rm
SPI_XILINX_PLTFM;./drivers/spi/Kconfig;v2.6.37;'commit 8fd8821b6239 ("spi/xilinx: fold platform_driver support into main body")';rm-def
STAGING_EXCLUDE_BUILD;./drivers/staging/Kconfig;v2.6.39;'commit fe35a59e16fb ("Staging: remove STAGING_EXCLUDE_BUILD option")';rm-rm
SYNC;./drivers/staging/android/Kconfig;v4.7;'commit aff9da10e218 ("staging/android: make sync_timeline internal to sw_sync")';rm-rm
THUMB2_AVOID_R_ARM_THM_JUMP11;./arch/arm/Kconfig;v5.8;'commit 67b0141bd12d ("ARM: 8995/1: drop Thumb-2 workaround for ancient binutils")';rm-rm
TIMER_STATS;./lib/Kconfig.debug;v4.10;'commit dfb4357da6dd ("time: Remove CONFIG_TIMER_STATS")';rm-rm
UBSAN_MISC;./lib/Kconfig.ubsan;v5.10;'commit c637693b20da ("ubsan: remove UBSAN_MISC in favor of individual options")';manual
UIO_PDRV;./drivers/uio/Kconfig;v3.11;'commit 26dac3c49d56 ("uio: Remove uio_pdrv and use uio_pdrv_genirq instead")';mv CONFIG_UIO_PDRV_GENIRQ
USB_CHIPIDEA_ULPI;./drivers/usb/chipidea/Kconfig;v4.17;'commit a930d8bd94d8 ("usb: chipidea: Always build ULPI code")';rm-def
USB_EHCI_MSM;./drivers/usb/host/Kconfig;v4.14;'commit 8b3f863033f9 ("usb: host: remove ehci-msm.c")';rm-rm
USB_EHCI_MXC;./drivers/usb/host/Kconfig;v5.10;'commit e7018751d2e6 ("usb: host: ehci-mxc: Remove the driver")';rm-rm
USB_GADGET_DUMMY_HCD;./drivers/usb/gadget/Kconfig;v3.0;'commit 193ab2a60700 ("usb: gadget: allow multiple gadgets to be built")';rm-def
USB_GADGET_M66592;./drivers/usb/gadget/Kconfig;v3.0;'commit 193ab2a60700 ("usb: gadget: allow multiple gadgets to be built")';mv USB_M66592
USB_MSM_OTG;./drivers/usb/phy/Kconfig;v4.14;'commit a170a1e9ccc5 ("usb: phy: remove phy-msm-usb.c")';rm-rm
USB_WUSB_CBAF;./drivers/staging/wusbcore/Kconfig;v5.6;'commit caa6772db4c1 ("Staging: remove wusbcore and UWB from the kernel tree.")';rm-rm
V4L_USB_DRIVERS;./drivers/media/video/Kconfig;v3.6;'commit 0aa77f6c2954 ("[media] move the remaining USB drivers to drivers/media/usb")';rm-rm
VIDEO_ALLOW_V4L1;./drivers/media/Kconfig;v2.6.37;'commit 58c66df3e38f ("[media] Remove VIDEO_V4L1 Kconfig option")';rm-rm
VIDEO_HELPER_CHIPS_AUTO;./drivers/media/video/Kconfig;v3.6;'commit fccea74ff8b5 ("[media] Kconfig: merge all customise options into just one")';rm-rm
fccea74ff8b51599
VIDEO_SH_MOBILE_CEU;./drivers/media/platform/soc_camera/Kconfig;v5.0;'commit 43a445f188e1 ("media: sh_mobile_ceu_camera: remove obsolete soc_camera driver")';rm-rm
VXGE;./drivers/net/ethernet/neterion/Kconfig;v5.19;'commit f05643a0f60b ("eth: remove neterion/vxge")';rm-rm
