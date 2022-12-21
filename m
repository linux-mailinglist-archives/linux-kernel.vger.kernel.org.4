Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11E9653160
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiLUNKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiLUNKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:10:42 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA55E2339D;
        Wed, 21 Dec 2022 05:10:38 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id x11so13505639qtv.13;
        Wed, 21 Dec 2022 05:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A7QIWLzS10LQ6JTLX22gK1WQs+TjYrKUEh5HyKaIBQA=;
        b=fU8XfGFufNLuU6UKupe74aMZLu+/DMk94lHdwB2+TEnGdinvPDIh1KacKb/jf5cyLv
         x516KmwaaIx702I1D5Mq2brFM9nV4WmhGxoMDMoywr9JIx3nRC1pb15GGDFArLIqMQX4
         40EWuukjlPABN5agIiAcuF7QMDJ1Q3Tm2a3hatl6muoYS9GW1N2RYyiTo+AgAnCgUKXZ
         BhWLLfvlmMWdJAXWrNsNxXmTP5SVIGuH2zbBjx0lOu94jmFEfyp4flNXF4Gi5Y/J+cN+
         erLMHaYD0Fxlk2ijipjkwl6JNr2/DH9GOGa6ogogyReyPbwS2JZRwpojaXrSLCVt7z3w
         JSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7QIWLzS10LQ6JTLX22gK1WQs+TjYrKUEh5HyKaIBQA=;
        b=xwQlpU15DUFGP5trDnZ/dAJ8elzO7pN+tIgWA0G55UK/rFVA4wk3lxoy02AD/hNGCO
         qR34Leg9yF57sAb/jVRir6nO3HVhCJ47o2xLde3suMJtB2Uum6f/kk4bI7kDft2WHR68
         UZfY7XX3YmtkRrDYopUSYb1C5hvXH6v2wq4+lrgjyXxKTZWg7/uKJFe+iB0xRXyiSDKR
         6dffaZ8QvEtmMAavIcgWnDccVBgQm/FaubYgLsQqZFzj7iOFm5nfV8NrSLrdhxkugmXs
         x0Gp+hoFDFxJZsE/ORScqIwb/3IdPMY/jwY9n4uS3ww62NVGEnAQJxstz/+dTX+lgBdm
         KJug==
X-Gm-Message-State: AFqh2kqxR2Ro0XZLDo4HbgL06c7xlHf8INsCPBUzadIPzd70C6Oo/7Dw
        S0DAEp5yLYnNmgxxIxKf9kbgvzWReCGtXIwK2DJFFy7k9KiRGZozwYo=
X-Google-Smtp-Source: AMrXdXuW1v0uCuGdz99CAT/E4TxA7MAO8YMet/qXPjoq3dN/GvXoHPDxq3qXioKLt9f8RWGD6TN4WC50e0Co+WoA5EE=
X-Received: by 2002:ac8:4412:0:b0:3a8:2d2d:3944 with SMTP id
 j18-20020ac84412000000b003a82d2d3944mr39288qtn.519.1671628237439; Wed, 21 Dec
 2022 05:10:37 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre+XJS_s5FgVteYA@mail.gmail.com>
 <678adc67-9e46-3eef-f274-c951b121570f@nbd.name>
In-Reply-To: <678adc67-9e46-3eef-f274-c951b121570f@nbd.name>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 21 Dec 2022 18:10:26 +0500
Message-ID: <CABXGCsMUbs+bf=tWnx98r4v_JzVmYdVyOos9EhcGJ6jnEwathA@mail.gmail.com>
Subject: Re: [6.2][regression] after commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae
 stopping working wifi mt7921e
To:     Felix Fietkau <nbd@nbd.name>
Cc:     lorenzo@kernel.org, sujuan.chen@mediatek.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 3:45 PM Felix Fietkau <nbd@nbd.name> wrote:
>
> I'm pretty sure that commit is unrelated to this issue. However, while
> looking at the code I found a bug that would explain your issue.
>
> Please try this patch:
> ---
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -422,15 +422,15 @@ void mt7921_roc_timer(struct timer_list *timer)
>
>   static int mt7921_abort_roc(struct mt7921_phy *phy, struct mt7921_vif *vif)
>   {
> -       int err;
> -
> -       if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
> -               return 0;
> +       int err = 0;
>
>         del_timer_sync(&phy->roc_timer);
>         cancel_work_sync(&phy->roc_work);
> -       err = mt7921_mcu_abort_roc(phy, vif, phy->roc_token_id);
> -       clear_bit(MT76_STATE_ROC, &phy->mt76->state);
> +
> +       mt7921_mutex_acquire(phy->dev);
> +       if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
> +               err = mt7921_mcu_abort_roc(phy, vif, phy->roc_token_id);
> +       mt7921_mutex_release(phy->dev);
>
>         return err;
>   }
> @@ -487,13 +487,8 @@ static int mt7921_cancel_remain_on_channel(struct ieee80211_hw *hw,
>   {
>         struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
>         struct mt7921_phy *phy = mt7921_hw_phy(hw);
> -       int err;
>
> -       mt7921_mutex_acquire(phy->dev);
> -       err = mt7921_abort_roc(phy, mvif);
> -       mt7921_mutex_release(phy->dev);
> -
> -       return err;
> +       return mt7921_abort_roc(phy, mvif);
>   }
>
>   static int mt7921_set_channel(struct mt7921_phy *phy)
> @@ -1778,11 +1773,8 @@ static void mt7921_mgd_complete_tx(struct ieee80211_hw *hw,
>                                    struct ieee80211_prep_tx_info *info)
>   {
>         struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
> -       struct mt7921_dev *dev = mt7921_hw_dev(hw);
>
> -       mt7921_mutex_acquire(dev);
>         mt7921_abort_roc(mvif->phy, mvif);
> -       mt7921_mutex_release(dev);
>   }
>
>   const struct ieee80211_ops mt7921_ops = {
>

Unfortunately this patch did not fix the issue.
There are still many messages in the logs "mt7921e 0000:05:00.0:
AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0010 address=0xffdc6a80
flags=0x0050]"

[  100.178131] wlp5s0: authenticate with 24:cf:24:c2:72:d0
[  100.365876] wlp5s0: send auth to 24:cf:24:c2:72:d0 (try 1/3)
[  100.389318] mt7921e 0000:05:00.0: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x0010 address=0xffdc6a80 flags=0x0050]
[  101.544116] wlp5s0: send auth to 24:cf:24:c2:72:d0 (try 2/3)
[  102.568019] wlp5s0: send auth to 24:cf:24:c2:72:d0 (try 3/3)
[  103.591880] wlp5s0: authentication with 24:cf:24:c2:72:d0 timed out
[  106.600014] mt7921e 0000:05:00.0: Message 00020003 (seq 9) timeout
[  109.607845] mt7921e 0000:05:00.0: Message 00020002 (seq 10) timeout
[  109.620007] ------------[ cut here ]------------
[  109.620022] WARNING: CPU: 3 PID: 9 at
drivers/iommu/dma-iommu.c:1035 iommu_dma_unmap_page+0x79/0x90
[  109.620043] Modules linked in: uinput rfcomm snd_seq_dummy
snd_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink
qrtr snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi
bnep sunrpc intel_rapl_msr intel_rapl_common snd_sof_amd_rembrandt
snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci mt7921e
snd_sof_xtensa_dsp edac_mce_amd binfmt_misc mt7921_common snd_sof
mt76_connac_lib vfat snd_sof_utils fat snd_soc_core kvm_amd mt76 btusb
snd_hda_intel snd_intel_dspcfg btrtl snd_intel_sdw_acpi snd_hda_codec
btbcm snd_compress mac80211 ac97_bus kvm snd_seq btintel snd_hda_core
snd_pcm_dmaengine snd_pci_ps snd_rpl_pci_acp6x snd_seq_device btmtk
libarc4 irqbypass snd_hwdep snd_pci_acp6x bluetooth snd_pcm
snd_pci_acp5x rapl cfg80211 snd_rn_pci_acp3x snd_acp_config snd_timer
asus_nb_wmi
[  109.620311]  snd_soc_acpi pcspkr wmi_bmof snd i2c_piix4
snd_pci_acp3x k10temp soundcore amd_pmc acpi_cpufreq asus_wireless
joydev zram amdgpu hid_asus asus_wmi ledtrig_audio sparse_keymap
drm_ttm_helper platform_profile crct10dif_pclmul ttm crc32_pclmul
crc32c_intel polyval_clmulni polyval_generic iommu_v2 drm_buddy rfkill
nvme gpu_sched ghash_clmulni_intel ucsi_acpi hid_multitouch
drm_display_helper sha512_ssse3 typec_ucsi serio_raw nvme_core ccp
r8169 sp5100_tco cec typec nvme_common i2c_hid_acpi i2c_hid video wmi
ip6_tables ip_tables fuse
[  109.620495] CPU: 3 PID: 9 Comm: kworker/u32:0 Tainted: G        W
 L    -------  ---  6.2.0-0.rc0.20221220git6feb57c2fd7c.10.fc38.x86_64
#1
[  109.620507] Hardware name: ASUSTeK COMPUTER INC. ROG Strix
G513QY_G513QY/G513QY, BIOS G513QY.320 09/07/2022
[  109.620516] Workqueue: mt76 mt7921_mac_reset_work [mt7921_common]
[  109.620543] RIP: 0010:iommu_dma_unmap_page+0x79/0x90
[  109.620555] Code: 2b 48 3b 28 72 26 48 3b 68 08 73 20 4d 89 f8 44
89 f1 4c 89 ea 48 89 ee 48 89 df 5b 5d 41 5c 41 5d 41 5e 41 5f e9 e7
40 73 ff <0f> 0b 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 66 0f 1f
44 00
[  109.620565] RSP: 0018:ffff9d8840147cb8 EFLAGS: 00010246
[  109.620577] RAX: 0000000000000000 RBX: ffff8a33d334d0d0 RCX: 0000000000000000
[  109.620586] RDX: 0000000000000000 RSI: 00000000000001c6 RDI: ffff9d8840147ca0
[  109.620593] RBP: ffff8a33d334d0d0 R08: 00000000ffdc6000 R09: 0000000000000081
[  109.620602] R10: 0000000000000001 R11: 000ffffffffff000 R12: 00000000ffdc6000
[  109.620609] R13: 00000000000006c0 R14: 0000000000000002 R15: 0000000000000000
[  109.620617] FS:  0000000000000000(0000) GS:ffff8a4296e00000(0000)
knlGS:0000000000000000
[  109.620665] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  109.620674] CR2: 00000091cba8e000 CR3: 0000000fc4428000 CR4: 0000000000750ee0
[  109.620682] PKRU: 55555554
[  109.620690] Call Trace:
[  109.620699]  <TASK>
[  109.620719]  dma_unmap_page_attrs+0x4c/0x1d0
[  109.620744]  mt76_dma_get_buf+0xaf/0x190 [mt76]
[  109.620777]  mt76_dma_rx_cleanup+0xa0/0x150 [mt76]
[  109.620808]  mt7921_wpdma_reset+0xb6/0x1d0 [mt7921e]
[  109.620837]  mt7921e_mac_reset+0x141/0x2e0 [mt7921e]
[  109.620860]  mt7921_mac_reset_work+0x8b/0x160 [mt7921_common]
[  109.620893]  process_one_work+0x294/0x5b0
[  109.620927]  worker_thread+0x4f/0x3a0
[  109.620946]  ? __pfx_worker_thread+0x10/0x10
[  109.620957]  kthread+0xf5/0x120
[  109.620967]  ? __pfx_kthread+0x10/0x10
[  109.620982]  ret_from_fork+0x2c/0x50
[  109.621022]  </TASK>
[  109.621032] irq event stamp: 1066916
[  109.621043] hardirqs last  enabled at (1066924):
[<ffffffffba1a957e>] __up_console_sem+0x5e/0x70
[  109.621064] hardirqs last disabled at (1066931):
[<ffffffffba1a9563>] __up_console_sem+0x43/0x70
[  109.621081] softirqs last  enabled at (1063892):
[<ffffffffc16fae9f>] mt76_dma_rx_cleanup+0xcf/0x150 [mt76]
[  109.621102] softirqs last disabled at (1063910):
[<ffffffffc16fae0d>] mt76_dma_rx_cleanup+0x3d/0x150 [mt76]
[  109.621135] ---[ end trace 0000000000000000 ]---


Full kernel log: https://pastebin.com/Qfhq6KDc

-- 
Best Regards,
Mike Gavrilov.
