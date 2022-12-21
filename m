Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBBE652ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 02:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiLUBLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 20:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiLUBK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 20:10:56 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6D712087;
        Tue, 20 Dec 2022 17:10:54 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id pe2so6139843qkn.1;
        Tue, 20 Dec 2022 17:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=usAtTfDPkCv1SXHdkMX4KPlwqygxakOAr2qEX+SK4zY=;
        b=G2ybbi5syCPcpEaRA92pM9K4LtPkJwTKFsG1oheDYHyYXL9iW72KC7zXJtXbYnqF12
         BdZpIAtO3BWOuywLLadLviUZGr3ZQVG2Oi/ZcSKqSXfu7Z97FSqQaospX83dOo+BRavX
         zx7konUCc85YrGRJvi6elAd02EdL5ZWItyBENByIwj3N0yR6Knd63yaOjLlnp9JU2f3l
         nDpnaa7POqQAzkjG5HW2t6XUqTbwEjVhYgwGhUCTZWtRXrZ1XWTyTLSVWXcpIN8X2lpF
         PNxxvEkOJQJVg0CtVpHpkjchScqCSiTyC87Fd2wrp0V1yNrtKg40d/cBzdSVJrep5G6/
         qXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=usAtTfDPkCv1SXHdkMX4KPlwqygxakOAr2qEX+SK4zY=;
        b=Aoj3QjWiBWh1qy4k0cDviqfXBieubVTfaWIGSyg0TnHYDTFtVkW10o/H46b8mjCf15
         TtY+NTfnEoFPh1euAvUNpb1HzOZK6TeDmqrnrnvbzTSQ69mQP8A2sYAfURe91E7YqtVN
         q+FIxhMyHdFX8FrlOb9q5Y2gQ7Ey/O8dzz0ePWumzHUFy/t0hNH36NP18OLllWqd+Vjb
         tcESQ5EdwUEQ2RuHUNfMeZKnmIc2CA37OYSxxhyYn9k0DyztE84ihena1I0xQso9zpvU
         H6zkrbaBSOlGZN1NYkoiZDQISY1msngsvO71S2HpdzfnzjUuOQEKyGXcysu/HBEdmwVf
         7VFg==
X-Gm-Message-State: ANoB5plCTnPsqHpk94ZW9wRVtVEy/4iftAyB5IAjqld8BPK78t3nf7PL
        IFdRLvINDKNRQWeekwHzTgMc4rm3RKoYVHM5eyQuGfomq2xQipxm
X-Google-Smtp-Source: AA0mqf4xlL2G0KyZ8+3watXJBrD3HlMqN4ZerrQ2fYojwjKAHXFYqe26kFeuQswoVKUHfD2kmLQI4F+GJPcBacy4tSA=
X-Received: by 2002:a05:620a:1253:b0:6ff:b44d:4856 with SMTP id
 a19-20020a05620a125300b006ffb44d4856mr1508138qkl.205.1671585053494; Tue, 20
 Dec 2022 17:10:53 -0800 (PST)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 21 Dec 2022 06:10:41 +0500
Message-ID: <CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre+XJS_s5FgVteYA@mail.gmail.com>
Subject: [6.2][regression] after commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae
 stopping working wifi mt7921e
To:     lorenzo@kernel.org, sujuan.chen@mediatek.com,
        Felix Fietkau <nbd@nbd.name>,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The kernel 6.2 preparation cycle has begun.
And after the kernel was updated on my laptop, the wifi stopped working.

Bisecting blames this commit:
cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae is the first bad commit
commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Sat Nov 12 16:40:35 2022 +0100

    wifi: mt76: add WED RX support to mt76_dma_{add,get}_buf

    Introduce the capability to configure RX WED in mt76_dma_{add,get}_buf
    utility routines.

    Tested-by: Daniel Golle <daniel@makrotopia.org>
    Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
    Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
    Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
    Signed-off-by: Felix Fietkau <nbd@nbd.name>

 drivers/net/wireless/mediatek/mt76/dma.c  | 125 ++++++++++++++++++++------=
----
 drivers/net/wireless/mediatek/mt76/mt76.h |   2 +
 2 files changed, 88 insertions(+), 39 deletions(-)

Unfortunately, I can't be sure that revert this commit will fix the
problem. Because after the revert, compile of kernel failing with
follow error:
drivers/net/wireless/mediatek/mt76/mt7915/dma.c: In function =E2=80=98mt791=
5_dma_init=E2=80=99:
drivers/net/wireless/mediatek/mt76/mt7915/dma.c:489:33: error:
implicit declaration of function =E2=80=98MT_WED_Q_RX=E2=80=99; did you mea=
n
=E2=80=98MT_WED_Q_TX=E2=80=99? [-Werror=3Dimplicit-function-declaration]
  489 |                                 MT_WED_Q_RX(MT7915_RXQ_BAND0);
      |                                 ^~~~~~~~~~~
      |                                 MT_WED_Q_TX
cc1: some warnings being treated as errors
  CC [M]  drivers/net/ethernet/intel/igb/e1000_phy.o
make[7]: *** [scripts/Makefile.build:252:
drivers/net/wireless/mediatek/mt76/mt7915/dma.o] Error 1
make[7]: *** Waiting for unfinished jobs....


In the kernel log I see such error traces after commit
cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae

1)
[   23.642036] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   23.642304] WARNING: possible circular locking dependency detected
[   23.642304] 6.1.0-rc5-13-cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae+
#13 Tainted: G        W    L
[   23.642304] ------------------------------------------------------
[   23.642304] kworker/u32:10/831 is trying to acquire lock:
[   23.642304] ffff8c43b2043c78 (&dev->mutex#3){+.+.}-{3:3}, at:
mt7921_roc_work+0x37/0xa0 [mt7921_common]
[   23.642304]
               but task is already holding lock:
[   23.642304] ffffaa0501a8fe78
((work_completion)(&dev->phy.roc_work)){+.+.}-{0:0}, at:
process_one_work+0x20b/0x5b0
[   23.642304]
               which lock already depends on the new lock.

[   23.642304]
               the existing dependency chain (in reverse order) is:
[   23.642304]
               -> #1 ((work_completion)(&dev->phy.roc_work)){+.+.}-{0:0}:
[   23.642304]        __flush_work+0x84/0x4b0
[   23.642304]        __cancel_work_timer+0xfc/0x190
[   23.642304]        mt7921_abort_roc+0x3b/0x60 [mt7921_common]
[   23.642304]        mt7921_mgd_complete_tx+0x4c/0x70 [mt7921_common]
[   23.642304]        drv_mgd_complete_tx+0x8c/0x190 [mac80211]
[   23.642304]        ieee80211_sta_rx_queued_mgmt+0x2a5/0x8e0 [mac80211]
[   23.642304]        ieee80211_iface_work+0x328/0x450 [mac80211]
[   23.642304]        process_one_work+0x294/0x5b0
[   23.642304]        worker_thread+0x4f/0x3a0
[   23.642304]        kthread+0xf5/0x120
[   23.642304]        ret_from_fork+0x22/0x30
[   23.642304]
               -> #0 (&dev->mutex#3){+.+.}-{3:3}:
[   23.642304]        __lock_acquire+0x12b1/0x1ef0
[   23.642304]        lock_acquire+0xc2/0x2b0
[   23.642304]        __mutex_lock+0xbb/0x850
[   23.642304]        mt7921_roc_work+0x37/0xa0 [mt7921_common]
[   23.642304]        process_one_work+0x294/0x5b0
[   23.642304]        worker_thread+0x4f/0x3a0
[   23.642304]        kthread+0xf5/0x120
[   23.642304]        ret_from_fork+0x22/0x30
[   23.642304]
               other info that might help us debug this:

[   23.642304]  Possible unsafe locking scenario:

[   23.642304]        CPU0                    CPU1
[   23.642304]        ----                    ----
[   23.642304]   lock((work_completion)(&dev->phy.roc_work));
[   23.642304]                                lock(&dev->mutex#3);
[   23.669750]
lock((work_completion)(&dev->phy.roc_work));
[   23.669750]   lock(&dev->mutex#3);
[   23.669750]
                *** DEADLOCK ***

[   23.671578] 2 locks held by kworker/u32:10/831:
[   23.671578]  #0: ffff8c43ba7aa148
((wq_completion)phy0){+.+.}-{0:0}, at: process_one_work+0x20b/0x5b0
[   23.671578]  #1: ffffaa0501a8fe78
((work_completion)(&dev->phy.roc_work)){+.+.}-{0:0}, at:
process_one_work+0x20b/0x5b0
[   23.673701]
               stack backtrace:
[   23.673701] CPU: 8 PID: 831 Comm: kworker/u32:10 Tainted: G
W    L     6.1.0-rc5-13-cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae+ #13
[   23.673701] Hardware name: ASUSTeK COMPUTER INC. ROG Strix
G513QY_G513QY/G513QY, BIOS G513QY.320 09/07/2022
[   23.673701] Workqueue: phy0 mt7921_roc_work [mt7921_common]
[   23.673701] Call Trace:
[   23.673701]  <TASK>
[   23.677973]  dump_stack_lvl+0x5b/0x77
[   23.677973]  check_noncircular+0xff/0x110
[   23.677973]  ? sched_clock_local+0xe/0x80
[   23.677973]  __lock_acquire+0x12b1/0x1ef0
[   23.677973]  lock_acquire+0xc2/0x2b0
[   23.677973]  ? mt7921_roc_work+0x37/0xa0 [mt7921_common]
[   23.677973]  __mutex_lock+0xbb/0x850
[   23.681699]  ? mt7921_roc_work+0x37/0xa0 [mt7921_common]
[   23.681699]  ? mt7921_roc_work+0x37/0xa0 [mt7921_common]
[   23.681699]  ? mt7921_roc_work+0x37/0xa0 [mt7921_common]
[   23.681699]  mt7921_roc_work+0x37/0xa0 [mt7921_common]
[   23.681699]  process_one_work+0x294/0x5b0
[   23.681699]  worker_thread+0x4f/0x3a0
[   23.681699]  ? process_one_work+0x5b0/0x5b0
[   23.681699]  kthread+0xf5/0x120
[   23.685767]  ? kthread_complete_and_exit+0x20/0x20
[   23.685767]  ret_from_fork+0x22/0x30
[   23.685767]  </TASK>
[   24.599971] wlp5s0: authentication with 24:cf:24:c2:72:d0 timed out
[   24.749911] amdgpu 0000:03:00.0: amdgpu: free PSP TMR buffer
[   27.607726] mt7921e 0000:05:00.0: Message 00020003 (seq 10) timeout
[   30.615933] mt7921e 0000:05:00.0: Message 00020002 (seq 11) timeout
[   30.703139] mt7921e 0000:05:00.0: HW/SW Version: 0x8a108a10, Build
Time: 20220908210919a



2)
[   57.627571] ------------[ cut here ]------------
[   57.627575] WARNING: CPU: 10 PID: 831 at
drivers/iommu/dma-iommu.c:1038 iommu_dma_unmap_page+0x79/0x90
[   57.627586] Modules linked in: rfcomm snd_seq_dummy snd_hrtimer
nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink qrtr bnep
intel_rapl_msr intel_rapl_common sunrpc snd_sof_amd_rembrandt
snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci snd_hda_codec_realtek
mt7921e snd_sof snd_hda_codec_generic snd_hda_codec_hdmi mt7921_common
snd_sof_utils edac_mce_amd snd_soc_core binfmt_misc snd_hda_intel
mt76_connac_lib snd_intel_dspcfg btusb snd_compress snd_intel_sdw_acpi
ac97_bus mt76 btrtl snd_pcm_dmaengine kvm_amd snd_hda_codec snd_pci_ps
btbcm snd_hda_core snd_rpl_pci_acp6x btintel vfat snd_pci_acp6x
snd_hwdep mac80211 fat btmtk kvm snd_seq libarc4 snd_seq_device
bluetooth irqbypass snd_pcm cfg80211 snd_pci_acp5x snd_rn_pci_acp3x
snd_timer snd_acp_config rapl snd snd_soc_acpi asus_nb_wmi wmi_bmof
[   57.627650]  pcspkr i2c_piix4 snd_pci_acp3x k10temp soundcore
joydev asus_wireless amd_pmc zram amdgpu crct10dif_pclmul hid_asus
crc32_pclmul drm_ttm_helper crc32c_intel asus_wmi polyval_clmulni ttm
ledtrig_audio sparse_keymap polyval_generic platform_profile iommu_v2
gpu_sched nvme drm_buddy nvme_core drm_display_helper rfkill
ghash_clmulni_intel ucsi_acpi hid_multitouch sha512_ssse3 serio_raw
typec_ucsi ccp r8169 cec sp5100_tco nvme_common typec i2c_hid_acpi
video i2c_hid wmi ip6_tables ip_tables fuse
[   57.627702] CPU: 10 PID: 831 Comm: kworker/u32:10 Tainted: G
W    L     6.1.0-rc5-13-cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae+ #13
[   57.627706] Hardware name: ASUSTeK COMPUTER INC. ROG Strix
G513QY_G513QY/G513QY, BIOS G513QY.320 09/07/2022
[   57.627708] Workqueue: mt76 mt7921_mac_reset_work [mt7921_common]
[   57.627720] RIP: 0010:iommu_dma_unmap_page+0x79/0x90
[   57.627724] Code: 2b 48 3b 28 72 26 48 3b 68 08 73 20 4d 89 f8 44
89 f1 4c 89 ea 48 89 ee 48 89 df 5b 5d 41 5c 41 5d 41 5e 41 5f e9 d7
76 7e ff <0f> 0b 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 66 0f 1f
44 00
[   57.627727] RSP: 0018:ffffaa0501a8fcb8 EFLAGS: 00010246
[   57.627730] RAX: 0000000000000000 RBX: ffff8c43933500d0 RCX: 00000000000=
00000
[   57.627732] RDX: 0000000000000000 RSI: 0000000000000177 RDI: ffffaa0501a=
8fca0
[   57.627734] RBP: ffff8c43933500d0 R08: 00000000ffd77800 R09: 00000000000=
00081
[   57.627735] R10: 0000000000000001 R11: 000ffffffffff000 R12: 00000000ffd=
77800
[   57.627737] R13: 00000000000006c0 R14: 0000000000000002 R15: 00000000000=
00000
[   57.627739] FS:  0000000000000000(0000) GS:ffff8c5258a00000(0000)
knlGS:0000000000000000
[   57.627740] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   57.627742] CR2: 000055bcc13dc800 CR3: 0000000479228000 CR4: 00000000007=
50ee0
[   57.627744] PKRU: 55555554
[   57.627745] Call Trace:
[   57.627749]  <TASK>
[   57.627753]  dma_unmap_page_attrs+0x4c/0x1d0
[   57.627763]  mt76_dma_get_buf+0xaf/0x190 [mt76]
[   57.627774]  ? free_unref_page+0x1a7/0x280
[   57.627780]  mt76_dma_rx_cleanup+0xa0/0x150 [mt76]
[   57.627787]  mt7921_wpdma_reset+0xb6/0x1d0 [mt7921e]
[   57.627795]  mt7921e_mac_reset+0x141/0x2e0 [mt7921e]
[   57.627800]  mt7921_mac_reset_work+0x8b/0x160 [mt7921_common]
[   57.627808]  process_one_work+0x294/0x5b0
[   57.627817]  worker_thread+0x4f/0x3a0
[   57.627820]  ? process_one_work+0x5b0/0x5b0
[   57.627822]  kthread+0xf5/0x120
[   57.627826]  ? kthread_complete_and_exit+0x20/0x20
[   57.627830]  ret_from_fork+0x22/0x30
[   57.627838]  </TASK>
[   57.627840] irq event stamp: 135539
[   57.627841] hardirqs last  enabled at (135539):
[<ffffffff92f7a214>] _raw_spin_unlock_irq+0x24/0x50
[   57.627848] hardirqs last disabled at (135538):
[<ffffffff92f79f18>] _raw_spin_lock_irq+0x68/0x90
[   57.627851] softirqs last  enabled at (135534):
[<ffffffffc2fc2fe8>] __ieee80211_tx_skb_tid_band+0x68/0x250 [mac80211]
[   57.627896] softirqs last disabled at (135494):
[<ffffffffc2fc2fe8>] __ieee80211_tx_skb_tid_band+0x68/0x250 [mac80211]
[   57.627924] ---[ end trace 0000000000000000 ]---
[   57.711796] mt7921e 0000:05:00.0: HW/SW Version: 0x8a108a10, Build
Time: 20220908210919a

Full kernel log is here: https://pastebin.com/ALHUDvSQ

I hope my report helps fix the problem quickly.

--=20
Best Regards,
Mike Gavrilov.
