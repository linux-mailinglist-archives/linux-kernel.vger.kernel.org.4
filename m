Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1845B8F16
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 20:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiINSzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 14:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiINSzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 14:55:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C3418E3D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 11:55:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y8so16734670edc.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 11:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=MrHUWCulReF9XGB1uA2gMpg2LljBzM+zuS/mcSWXEIM=;
        b=VguyHLEzl76ZSGwFC4sBlyfauk3ZXnZ81wADbeQplE4qUmOvKNfcNJWHT/BVHfZer5
         ny6ky2l0vIR0vos/Cesc0No8JQfGdlgaf1bFYpyVnfLJUdPGPA5/cHYgsVQ7bWS5Enqg
         Ct9osfw9FJfcm9o4XEPKJq9elKSMtC8P357hVAaoCcHOiCGzbCatmMjCDbpXkcruyZY6
         cXfIxgiMw0z2PnnNV8Hnwt+jC17qK9VZOsHsQWHw8s49zN6WExUylzbN5j1lXImd0mdk
         ZKDCEymmpeFCoEwkHNQJl2xJh9u8i4AeaasZcBOQPbDHj82UaXlcmXtyxiruej56xk9h
         U23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MrHUWCulReF9XGB1uA2gMpg2LljBzM+zuS/mcSWXEIM=;
        b=m5cH9Me1G4H4KNiJ9iyjLgYRXB77NZWvNANFGRBuNva72w1dWvzZYsCRzksYPlxfa4
         UYyvirSXBoYFLwpJfJfC7WWkLR+zsuotl/v2P7XLDObDo4NNCKjjPZ4uPT0gNoUNFL3F
         nhmrWkOLLAMIP8E/kclXUoMb4NV7GWNk0RyN7u5gFQuGXmy5K9WfxULp0edPFu5+6dXx
         BEUhy3dUfn4Cyyt6QLXDSs9fyMcDa3WliP82qijHkr+xe2aakUTFOTE17S70gR4Cy+Tz
         EbcWyWPhrsh9116T1P1A8Jnmuo5id951rTeH7FXI9veTzpXzeIFh8FQyAUpsh86/exOk
         VhTQ==
X-Gm-Message-State: ACgBeo3NSWhRxAyyPQ5W0HqQbC3AbbHRFe/Dtke/zaJ3ds8TgMMJCP8C
        r02StX+Ej4bQ+S/GIGCTsBQ=
X-Google-Smtp-Source: AA6agR7g6gzXDLgsJUzkgfSNL4CV2ZlcwkhvnrrC7UU9RNNh1Zzg029yhf2MFCrcPu7AwzaLV7LXig==
X-Received: by 2002:a05:6402:3904:b0:451:f01c:9217 with SMTP id fe4-20020a056402390400b00451f01c9217mr11552535edb.78.1663181709295;
        Wed, 14 Sep 2022 11:55:09 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f3e:6a85:fc03:8ddc:1234:87a9? (p200300c78f3e6a85fc038ddc123487a9.dip0.t-ipconnect.de. [2003:c7:8f3e:6a85:fc03:8ddc:1234:87a9])
        by smtp.gmail.com with ESMTPSA id y7-20020a056402170700b0044e7f40c48esm10184926edu.62.2022.09.14.11.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 11:55:08 -0700 (PDT)
Message-ID: <1a1d346e-be81-19a5-5cb7-8b5ac896d835@gmail.com>
Date:   Wed, 14 Sep 2022 20:55:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: vt6655: replace spin_lock_irqsave with spin_lock
Content-Language: en-US
To:     Nam Cao <namcaov@gmail.com>, forest@alittletooquiet.net,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20220914080016.67951-1-namcaov@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220914080016.67951-1-namcaov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/22 10:00, Nam Cao wrote:
> In vt6655 driver, there is a single interrupt handler: vnt_interrupt(),
> and it does not take the spinlock. The interrupt handler only schedules
> a workqueue, and the spinlock is taken in this workqueue. Thus, there is
> no need to use spin_lock_irqsave, as the spinlock is never taken by an
> interrupt. Replace spin_lock_irqsave (and spin_unlock_irqsave) with
> spin_lock (and spin_unlock).
> 
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>   drivers/staging/vt6655/card.c        |  5 ++--
>   drivers/staging/vt6655/channel.c     |  6 ++---
>   drivers/staging/vt6655/device_main.c | 38 +++++++++++-----------------
>   3 files changed, 19 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
> index c680925b9c92..3d2873874886 100644
> --- a/drivers/staging/vt6655/card.c
> +++ b/drivers/staging/vt6655/card.c
> @@ -540,9 +540,8 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
>   {
>   	union vnt_phy_field_swap phy;
>   	unsigned char byTxRate, byRsvTime;      /* For OFDM */
> -	unsigned long flags;
>   
> -	spin_lock_irqsave(&priv->lock, flags);
> +	spin_lock(&priv->lock);
>   
>   	/* Set to Page1 */
>   	VT6655_MAC_SELECT_PAGE1(priv->port_offset);
> @@ -645,7 +644,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
>   	/* Set to Page0 */
>   	VT6655_MAC_SELECT_PAGE0(priv->port_offset);
>   
> -	spin_unlock_irqrestore(&priv->lock, flags);
> +	spin_unlock(&priv->lock);
>   }
>   
>   void CARDvUpdateBasicTopRate(struct vnt_private *priv)
> diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
> index 4122875ebcaa..160ed640875d 100644
> --- a/drivers/staging/vt6655/channel.c
> +++ b/drivers/staging/vt6655/channel.c
> @@ -111,9 +111,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
>   	bb_software_reset(priv);
>   
>   	if (priv->local_id > REV_ID_VT3253_B1) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&priv->lock, flags);
> +		spin_lock(&priv->lock);
>   
>   		/* set HW default power register */
>   		VT6655_MAC_SELECT_PAGE1(priv->port_offset);
> @@ -123,7 +121,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
>   		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWROFDM);
>   		VT6655_MAC_SELECT_PAGE0(priv->port_offset);
>   
> -		spin_unlock_irqrestore(&priv->lock, flags);
> +		spin_unlock(&priv->lock);
>   	}
>   
>   	if (priv->byBBType == BB_TYPE_11B)
> diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
> index 04d737012cef..ea9560996eda 100644
> --- a/drivers/staging/vt6655/device_main.c
> +++ b/drivers/staging/vt6655/device_main.c
> @@ -260,7 +260,6 @@ static void vt6655_mac_dis_barker_preamble_md(void __iomem *iobase)
>   
>   static void device_init_registers(struct vnt_private *priv)
>   {
> -	unsigned long flags;
>   	unsigned int ii;
>   	unsigned char byValue;
>   	unsigned char byCCKPwrdBm = 0;
> @@ -289,11 +288,11 @@ static void device_init_registers(struct vnt_private *priv)
>   	/* Get Local ID */
>   	priv->local_id = ioread8(priv->port_offset + MAC_REG_LOCALID);
>   
> -	spin_lock_irqsave(&priv->lock, flags);
> +	spin_lock(&priv->lock);
>   
>   	SROMvReadAllContents(priv->port_offset, priv->abyEEPROM);
>   
> -	spin_unlock_irqrestore(&priv->lock, flags);
> +	spin_unlock(&priv->lock);
>   
>   	/* Get Channel range */
>   	priv->byMinChannel = 1;
> @@ -1093,7 +1092,6 @@ static void vnt_interrupt_process(struct vnt_private *priv)
>   	int             max_count = 0;
>   	u32 mib_counter;
>   	u32 isr;
> -	unsigned long flags;
>   
>   	isr = ioread32(priv->port_offset + MAC_REG_ISR);
>   
> @@ -1105,7 +1103,7 @@ static void vnt_interrupt_process(struct vnt_private *priv)
>   		return;
>   	}
>   
> -	spin_lock_irqsave(&priv->lock, flags);
> +	spin_lock(&priv->lock);
>   
>   	/* Read low level stats */
>   	mib_counter = ioread32(priv->port_offset + MAC_REG_MIBCNTR);
> @@ -1190,7 +1188,7 @@ static void vnt_interrupt_process(struct vnt_private *priv)
>   			break;
>   	}
>   
> -	spin_unlock_irqrestore(&priv->lock, flags);
> +	spin_unlock(&priv->lock);
>   }
>   
>   static void vnt_interrupt_work(struct work_struct *work)
> @@ -1220,9 +1218,8 @@ static int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
>   	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
>   	struct vnt_tx_desc *head_td;
>   	u32 dma_idx;
> -	unsigned long flags;
>   
> -	spin_lock_irqsave(&priv->lock, flags);
> +	spin_lock(&priv->lock);
>   
>   	if (ieee80211_is_data(hdr->frame_control))
>   		dma_idx = TYPE_AC0DMA;
> @@ -1230,7 +1227,7 @@ static int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
>   		dma_idx = TYPE_TXDMA0;
>   
>   	if (AVAIL_TD(priv, dma_idx) < 1) {
> -		spin_unlock_irqrestore(&priv->lock, flags);
> +		spin_unlock(&priv->lock);
>   		ieee80211_stop_queues(priv->hw);
>   		return -ENOMEM;
>   	}
> @@ -1246,11 +1243,11 @@ static int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
>   
>   	priv->apCurrTD[dma_idx] = head_td->next;
>   
> -	spin_unlock_irqrestore(&priv->lock, flags);
> +	spin_unlock(&priv->lock);
>   
>   	vnt_generate_fifo_header(priv, dma_idx, head_td, skb);
>   
> -	spin_lock_irqsave(&priv->lock, flags);
> +	spin_lock(&priv->lock);
>   
>   	priv->bPWBitOn = false;
>   
> @@ -1272,7 +1269,7 @@ static int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
>   
>   	priv->iTDUsed[dma_idx]++;
>   
> -	spin_unlock_irqrestore(&priv->lock, flags);
> +	spin_unlock(&priv->lock);
>   
>   	return 0;
>   }
> @@ -1468,13 +1465,11 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
>   	priv->current_aid = vif->cfg.aid;
>   
>   	if (changed & BSS_CHANGED_BSSID && conf->bssid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&priv->lock, flags);
> +		spin_lock(&priv->lock);
>   
>   		vt6655_mac_write_bssid_addr(priv->port_offset, conf->bssid);
>   
> -		spin_unlock_irqrestore(&priv->lock, flags);
> +		spin_unlock(&priv->lock);
>   	}
>   
>   	if (changed & BSS_CHANGED_BASIC_RATES) {
> @@ -1581,9 +1576,7 @@ static void vnt_configure(struct ieee80211_hw *hw,
>   
>   	if (changed_flags & FIF_ALLMULTI) {
>   		if (*total_flags & FIF_ALLMULTI) {
> -			unsigned long flags;
> -
> -			spin_lock_irqsave(&priv->lock, flags);
> +			spin_lock(&priv->lock);
>   
>   			if (priv->mc_list_count > 2) {
>   				VT6655_MAC_SELECT_PAGE1(priv->port_offset);
> @@ -1603,7 +1596,7 @@ static void vnt_configure(struct ieee80211_hw *hw,
>   				VT6655_MAC_SELECT_PAGE0(priv->port_offset);
>   			}
>   
> -			spin_unlock_irqrestore(&priv->lock, flags);
> +			spin_unlock(&priv->lock);
>   
>   			rx_mode |= RCR_MULTICAST | RCR_BROADCAST;
>   		} else {
> @@ -1830,13 +1823,12 @@ vt6655_probe(struct pci_dev *pcid, const struct pci_device_id *ent)
>   static int __maybe_unused vt6655_suspend(struct device *dev_d)
>   {
>   	struct vnt_private *priv = dev_get_drvdata(dev_d);
> -	unsigned long flags;
>   
> -	spin_lock_irqsave(&priv->lock, flags);
> +	spin_lock(&priv->lock);
>   
>   	MACbShutdown(priv);
>   
> -	spin_unlock_irqrestore(&priv->lock, flags);
> +	spin_unlock(&priv->lock);
>   
>   	return 0;
>   }

Hi Nam,

I am lol ... my computer freezed (you don mind if I do not try this 
patch again? Please send a v2) ;-)
I was digging for the log see below. (kern.log)
I hope you can do something with it.

Bye Philipp

Sep 14 20:33:55 matrix-ESPRIMO-P710 kernel: [ 2993.375202] vt6655_stage: 
loading out-of-tree module taints kernel.
Sep 14 20:33:55 matrix-ESPRIMO-P710 kernel: [ 2993.375210] vt6655_stage: 
module is from the staging directory, the quality is unknown, you have 
been warned.
Sep 14 20:33:55 matrix-ESPRIMO-P710 kernel: [ 2993.375282] vt6655_stage: 
module verification failed: signature and/or required key missing - 
tainting kernel
Sep 14 20:33:55 matrix-ESPRIMO-P710 kernel: [ 2993.376701] vt6655 
0000:03:05.0: VIA Networking Solomon-A/B/G Wireless LAN Adapter Driver 
Ver. 1.19.12
Sep 14 20:33:55 matrix-ESPRIMO-P710 kernel: [ 2993.376704] vt6655 
0000:03:05.0: Copyright (c) 2003 VIA Networking Technologies, Inc.
Sep 14 20:33:55 matrix-ESPRIMO-P710 kernel: [ 2993.376734] vt6655 
0000:03:05.0: enabling device (0080 -> 0083)
Sep 14 20:33:55 matrix-ESPRIMO-P710 kernel: [ 2993.377610] ieee80211 
phy1: Selected rate control algorithm 'minstrel_ht'
Sep 14 20:33:55 matrix-ESPRIMO-P710 kernel: [ 2993.379515] vt6655 
0000:03:05.0: MAC=00:0f:a3:ad:7a:10 IO=0xd000 Mem=0xffff9c2c8004f000 IRQ=19
Sep 14 20:33:55 matrix-ESPRIMO-P710 kernel: [ 2993.386777] vt6655 
0000:03:05.0 wlp3s5: renamed from wlan0
Sep 14 20:34:05 matrix-ESPRIMO-P710 kernel: [ 3003.729819] IPv6: 
ADDRCONF(NETDEV_CHANGE): wlp3s5: link becomes ready
Sep 14 20:35:20 matrix-ESPRIMO-P710 kernel: [ 3078.679342] wlp3s5: 
authenticate with f4:ec:38:e9:c5:1c
Sep 14 20:35:20 matrix-ESPRIMO-P710 kernel: [ 3078.694837] wlp3s5: send 
auth to f4:ec:38:e9:c5:1c (try 1/3)
Sep 14 20:35:20 matrix-ESPRIMO-P710 kernel: [ 3078.696227] wlp3s5: 
authenticated
Sep 14 20:35:20 matrix-ESPRIMO-P710 kernel: [ 3078.730750] wlp3s5: 
associate with f4:ec:38:e9:c5:1c (try 1/3)
Sep 14 20:35:20 matrix-ESPRIMO-P710 kernel: [ 3078.737133] wlp3s5: RX 
AssocResp from f4:ec:38:e9:c5:1c (capab=0x431 status=0 aid=1)
Sep 14 20:35:20 matrix-ESPRIMO-P710 kernel: [ 3078.737230] wlp3s5: 
associated
Sep 14 20:35:21 matrix-ESPRIMO-P710 kernel: [ 3078.822870] IPv6: 
ADDRCONF(NETDEV_CHANGE): wlp3s5: link becomes ready
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739036] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 6 
jiffies s: 1117 root: 0x6/.
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739050] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739053] Task dump for 
CPU 1:
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739054] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739060] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739070] Call Trace:
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739072]  <TASK>
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739076]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739081] 
__schedule+0x2ee/0xb90
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739087]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739092]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739095]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739097]  ? 
kthread+0xff/0x130
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739101]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739105]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739111]  </TASK>
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739112] Task dump for 
CPU 2:
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739113] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739117] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739177] Call Trace:
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739178]  <TASK>
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739179]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739225]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739271]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739316]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739319]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739321]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739323]  ? 
kthread+0xff/0x130
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739327]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739331]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:43 matrix-ESPRIMO-P710 kernel: [ 3101.739335]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815043] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
25 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815056] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815059] Task dump for 
CPU 1:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815060] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815065] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815074] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815076]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815080]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815085] 
__schedule+0x2ee/0xb90
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815091]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815095]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815098]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815100]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815104]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815108]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815115]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815116] Task dump for 
CPU 2:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815117] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815121] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815179] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815180]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815181]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815227]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815272]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815317]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815320]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815323]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815325]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815328]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815332]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.815337]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891027] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
44 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891038] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891039] Task dump for 
CPU 1:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891040] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891044] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891052] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891053]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891056]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891059] 
__schedule+0x2ee/0xb90
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891073]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891075]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891078]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891079]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891082]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891085]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891090]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891091] Task dump for 
CPU 2:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891091] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891094] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891135] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891136]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891137]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891167]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891197]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891227]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891229]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891231]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891232]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891235]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891237]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.891240]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967037] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
63 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967049] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967051] Task dump for 
CPU 1:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967052] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967057] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967066] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967068]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967070]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967075] 
__schedule+0x2ee/0xb90
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967081]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967084]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967087]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967088]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967092]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967095]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967101]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967101] Task dump for 
CPU 2:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967102] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967106] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967154] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967155]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967156]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967195]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967232]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967270]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967272]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967274]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967276]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967279]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967282]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3101.967286]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043048] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
82 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043062] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043065] Task dump for 
CPU 1:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043066] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043072] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043082] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043085]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043088]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043093] 
__schedule+0x2ee/0xb90
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043100]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043105]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043108]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043110]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043114]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043118]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043124]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043126] Task dump for 
CPU 2:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043127] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043131] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043190] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043191]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043193]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043239]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043285]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043330]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043333]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043335]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043337]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043341]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043345]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.043349]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119050] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
101 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119063] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119065] Task dump for 
CPU 1:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119066] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119071] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119080] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119082]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119085]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119090] 
__schedule+0x2ee/0xb90
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119096]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119100]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119103]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119105]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119109]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119113]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119118]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119120] Task dump for 
CPU 2:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119121] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119124] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119180] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119181]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119182]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119228]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119273]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119319]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119322]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119324]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119326]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119330]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119333]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.119338]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195043] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
120 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195056] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195058] Task dump for 
CPU 1:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195060] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195065] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195074] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195075]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195078]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195084] 
__schedule+0x2ee/0xb90
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195090]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195094]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195097]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195099]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195103]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195107]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195112]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195113] Task dump for 
CPU 2:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195114] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195118] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195174] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195175]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195176]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195224]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195270]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195316]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195319]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195321]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195323]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195327]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195331]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.195336]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271049] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
139 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271061] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271064] Task dump for 
CPU 1:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271065] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271070] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271079] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271080]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271084]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271089] 
__schedule+0x2ee/0xb90
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271095]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271099]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271102]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271103]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271107]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271112]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271117]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271118] Task dump for 
CPU 2:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271119] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271123] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271180] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271180]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271182]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271228]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271273]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271318]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271321]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271324]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271326]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271329]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271333]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.271338]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347040] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
158 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347052] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347054] Task dump for 
CPU 1:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347056] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347060] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347069] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347071]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347073]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347077] 
__schedule+0x2ee/0xb90
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347083]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347087]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347089]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347091]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347094]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347098]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347103]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347104] Task dump for 
CPU 2:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347105] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347108] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347158] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347159]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347160]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347199]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347237]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347274]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347276]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347279]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347280]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347283]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347286]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.347290]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423063] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
177 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423086] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423089] Task dump for 
CPU 1:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423090] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423096] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423105] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423108]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423111]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423116] 
__schedule+0x2ee/0xb90
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423123]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423127]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423130]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423132]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423136]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423140]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423146]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423148] Task dump for 
CPU 2:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423149] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423153] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423211] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423212]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423213]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423260]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423305]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423350]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423353]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423356]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423358]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423361]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423365]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.423370]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499046] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
196 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499056] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499058] Task dump for 
CPU 1:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499059] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499063] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499071] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499072]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499075]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499078] 
__schedule+0x2ee/0xb90
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499084]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499087]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499089]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499090]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499093]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499096]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499101]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499102] Task dump for 
CPU 2:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499102] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499105] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499147] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499148]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499148]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499180]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499211]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499241]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499243]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499245]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499247]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499249]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499251]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.499255]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575044] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
215 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575058] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575060] Task dump for 
CPU 1:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575061] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575067] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575076] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575079]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575082]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575087] 
__schedule+0x2ee/0xb90
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575093]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575097]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575100]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575102]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575107]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575111]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575117]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575118] Task dump for 
CPU 2:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575119] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575123] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575181] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575182]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575183]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575230]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575275]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575321]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575324]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575326]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575328]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575332]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575335]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.575340]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651054] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
234 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651067] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651070] Task dump for 
CPU 1:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651071] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651076] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651085] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651087]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651090]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651095] 
__schedule+0x2ee/0xb90
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651101]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651105]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651108]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651110]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651114]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651118]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651123]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651125] Task dump for 
CPU 2:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651126] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651130] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651186] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651187]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651188]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651235]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651280]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651325]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651328]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651331]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651333]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651336]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651340]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.651344]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727046] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
253 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727058] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727060] Task dump for 
CPU 1:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727062] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727067] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727075] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727077]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727080]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727085] 
__schedule+0x2ee/0xb90
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727091]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727094]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727098]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727100]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727104]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727108]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727113]  </TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727115] Task dump for 
CPU 2:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727116] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727119] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727175] Call Trace:
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727176]  <TASK>
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727177]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727223]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727269]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727315]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727318]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727320]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727322]  ? 
kthread+0xff/0x130
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727326]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727329]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:44 matrix-ESPRIMO-P710 kernel: [ 3102.727334]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803056] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
272 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803069] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803072] Task dump for 
CPU 1:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803073] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803078] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803087] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803089]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803092]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803097] 
__schedule+0x2ee/0xb90
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803103]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803107]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803110]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803112]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803116]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803120]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803125]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803126] Task dump for 
CPU 2:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803127] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803131] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803189] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803190]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803191]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803237]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803283]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803328]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803331]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803334]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803336]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803339]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803343]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.803348]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879055] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
291 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879066] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879068] Task dump for 
CPU 1:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879069] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879073] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879080] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879082]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879085]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879088] 
__schedule+0x2ee/0xb90
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879093]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879097]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879099]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879100]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879103]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879106]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879111]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879111] Task dump for 
CPU 2:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879112] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879115] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879157] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879158]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879159]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879190]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879221]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879252]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879254]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879255]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879257]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879259]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879262]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.879265]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955068] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
310 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955083] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955085] Task dump for 
CPU 1:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955086] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955091] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955101] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955103]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955106]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955111] 
__schedule+0x2ee/0xb90
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955118]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955121]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955124]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955126]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955130]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955133]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955139]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955140] Task dump for 
CPU 2:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955141] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955145] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955200] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955201]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955203]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955245]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955287]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955329]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955331]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955334]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955336]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955339]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955342]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3102.955347]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031058] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
329 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031072] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031075] Task dump for 
CPU 1:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031076] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031082] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031092] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031094]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031098]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031103] 
__schedule+0x2ee/0xb90
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031110]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031114]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031117]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031119]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031123]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031127]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031133]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031135] Task dump for 
CPU 2:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031136] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031140] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031197] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031198]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031200]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031246]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031292]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031337]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031340]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031343]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031345]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031348]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031352]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.031357]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107052] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
348 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107065] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107067] Task dump for 
CPU 1:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107069] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107074] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107083] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107085]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107087]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107092] 
__schedule+0x2ee/0xb90
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107098]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107102]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107105]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107107]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107111]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107115]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107121]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107122] Task dump for 
CPU 2:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107123] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107126] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107183] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107184]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107185]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107231]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107277]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107322]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107325]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107327]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107329]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107333]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107337]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.107341]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183062] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
367 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183076] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183078] Task dump for 
CPU 1:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183079] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183085] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183094] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183096]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183099]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183104] 
__schedule+0x2ee/0xb90
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183109]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183113]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183116]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183118]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183122]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183126]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183132]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183133] Task dump for 
CPU 2:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183134] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183138] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183194] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183195]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183196]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183243]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183288]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183333]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183336]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183338]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183340]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183344]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183348]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.183352]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259063] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
386 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259076] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259078] Task dump for 
CPU 1:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259079] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259084] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259093] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259095]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259098]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259103] 
__schedule+0x2ee/0xb90
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259109]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259112]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259115]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259117]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259121]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259125]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259131]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259132] Task dump for 
CPU 2:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259133] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259137] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259193] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259194]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259195]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259241]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259286]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259331]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259334]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259337]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259339]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259342]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259346]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.259351]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335072] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
405 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335084] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335087] Task dump for 
CPU 1:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335088] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335093] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335102] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335104]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335107]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335112] 
__schedule+0x2ee/0xb90
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335118]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335121]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335124]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335126]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335130]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335134]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335140]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335141] Task dump for 
CPU 2:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335142] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335146] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335202] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335203]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335204]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335249]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335295]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335340]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335343]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335346]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335347]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335351]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335355]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.335359]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411077] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
424 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411092] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411094] Task dump for 
CPU 1:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411096] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411101] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411111] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411113]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411117]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411122] 
__schedule+0x2ee/0xb90
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411129]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411133]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411136]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411139]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411142]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411146]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411153]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411154] Task dump for 
CPU 2:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411155] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411159] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411217] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411218]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411219]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411266]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411311]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411356]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411359]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411361]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411363]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411367]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411371]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.411375]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487049] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
443 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487060] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487062] Task dump for 
CPU 1:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487063] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487075] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487083] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487085]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487087]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487090] 
__schedule+0x2ee/0xb90
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487095]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487098]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487100]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487102]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487105]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487107]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487112]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487113] Task dump for 
CPU 2:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487114] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487116] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487158] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487159]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487160]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487190]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487220]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487250]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487252]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487254]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487255]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487257]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487260]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.487263]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563063] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
462 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563078] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563081] Task dump for 
CPU 1:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563082] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563088] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563097] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563100]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563103]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563108] 
__schedule+0x2ee/0xb90
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563114]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563118]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563121]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563123]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563127]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563131]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563137]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563139] Task dump for 
CPU 2:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563140] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563143] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563201] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563202]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563203]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563249]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563294]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563340]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563343]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563345]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563347]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563350]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563354]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.563359]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639069] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
481 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639081] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639083] Task dump for 
CPU 1:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639085] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639090] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639099] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639101]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639104]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639109] 
__schedule+0x2ee/0xb90
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639115]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639119]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639122]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639124]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639128]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639132]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639137]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639139] Task dump for 
CPU 2:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639140] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639144] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639200] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639201]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639202]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639248]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639294]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639339]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639342]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639345]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639347]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639350]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639354]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.639359]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715064] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
500 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715079] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715082] Task dump for 
CPU 1:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715083] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715089] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715099] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715101]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715104]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715109] 
__schedule+0x2ee/0xb90
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715116]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715120]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715123]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715125]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715129]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715133]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715139]  </TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715141] Task dump for 
CPU 2:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715142] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715146] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715205] Call Trace:
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715206]  <TASK>
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715207]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715253]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715299]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715344]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715347]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715350]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715351]  ? 
kthread+0xff/0x130
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715355]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715359]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:45 matrix-ESPRIMO-P710 kernel: [ 3103.715363]  </TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791073] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
519 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791088] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791090] Task dump for 
CPU 1:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791092] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791098] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791108] Call Trace:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791110]  <TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791113]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791118] 
__schedule+0x2ee/0xb90
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791125]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791129]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791132]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791134]  ? 
kthread+0xff/0x130
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791138]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791142]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791148]  </TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791149] Task dump for 
CPU 2:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791151] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791155] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791213] Call Trace:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791214]  <TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791215]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791261]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791306]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791352]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791355]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791357]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791359]  ? 
kthread+0xff/0x130
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791363]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791366]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.791371]  </TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867068] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
538 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867079] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867080] Task dump for 
CPU 1:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867081] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867085] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867093] Call Trace:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867095]  <TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867097]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867101] 
__schedule+0x2ee/0xb90
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867106]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867109]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867111]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867113]  ? 
kthread+0xff/0x130
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867116]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867118]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867123]  </TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867124] Task dump for 
CPU 2:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867125] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867128] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867169] Call Trace:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867170]  <TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867171]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867202]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867233]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867263]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867265]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867267]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867268]  ? 
kthread+0xff/0x130
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867271]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867273]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.867277]  </TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943072] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
557 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943087] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943089] Task dump for 
CPU 1:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943091] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943096] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943107] Call Trace:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943109]  <TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943112]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943117] 
__schedule+0x2ee/0xb90
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943124]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943128]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943131]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943133]  ? 
kthread+0xff/0x130
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943137]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943141]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943147]  </TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943149] Task dump for 
CPU 2:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943149] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943154] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943211] Call Trace:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943212]  <TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943213]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943264]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943310]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943356]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943359]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943362]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943364]  ? 
kthread+0xff/0x130
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943367]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943371]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3103.943376]  </TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019078] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
576 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019093] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019096] Task dump for 
CPU 1:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019097] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019103] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019113] Call Trace:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019115]  <TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019118]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019124] 
__schedule+0x2ee/0xb90
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019130]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019134]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019137]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019139]  ? 
kthread+0xff/0x130
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019143]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019147]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019154]  </TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019155] Task dump for 
CPU 2:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019156] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019160] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019217] Call Trace:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019218]  <TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019220]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019266]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019311]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019356]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019359]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019362]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019364]  ? 
kthread+0xff/0x130
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019367]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019371]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.019376]  </TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095075] rcu: INFO: 
rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... 2-.... } 
595 jiffies s: 1117 root: 0x6/.
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095089] rcu: blocking 
rcu_node structures (internal RCU debug):
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095091] Task dump for 
CPU 1:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095093] 
task:kworker/1:0     state:R  running task     stack:    0 pid:12196 
ppid:     2 flags:0x00004008
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095098] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095107] Call Trace:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095110]  <TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095113]  ? 
vnt_interrupt_work+0x369/0x4d0 [vt6655_stage]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095118] 
__schedule+0x2ee/0xb90
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095125]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095129]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095132]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095134]  ? 
kthread+0xff/0x130
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095138]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095142]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095148]  </TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095149] Task dump for 
CPU 2:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095150] 
task:kworker/u8:16   state:R  running task     stack:    0 pid:  592 
ppid:     2 flags:0x00004008
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095154] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095211] Call Trace:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095212]  <TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095213]  ? 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095260]  ? 
ieee80211_mgd_probe_ap+0x136/0x190 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095305]  ? 
ieee80211_beacon_connection_loss_work+0x3a/0xb0 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095351]  ? 
process_one_work+0x21d/0x3f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095353]  ? 
worker_thread+0x4a/0x3c0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095356]  ? 
process_one_work+0x3f0/0x3f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095358]  ? 
kthread+0xff/0x130
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095361]  ? 
kthread_complete_and_exit+0x20/0x20
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095365]  ? 
ret_from_fork+0x22/0x30
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.095370]  </TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159052] watchdog: 
BUG: soft lockup - CPU#2 stuck for 22s! [kworker/u8:16:592]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159052] watchdog: 
BUG: soft lockup - CPU#1 stuck for 26s! [kworker/1:0:12196]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159057] Modules 
linked in: ccm xt_state
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159061] Modules 
linked in:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159061]  ipt_REJECT
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159062]  ccm
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159063] 
nf_reject_ipv4 xt_tcpudp
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159064]  xt_state 
ipt_REJECT
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159066]  nf_nat_h323 
nf_conntrack_h323
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159067] 
nf_reject_ipv4 xt_tcpudp
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159068]  nf_nat_pptp
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159069]  nf_nat_h323
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159070] 
nf_conntrack_pptp
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159071] 
nf_conntrack_h323
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159071]  nf_nat_tftp 
nf_conntrack_tftp
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159072]  nf_nat_pptp 
nf_conntrack_pptp
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159073]  nf_nat_sip 
nf_conntrack_sip
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159074]  nf_nat_tftp 
nf_conntrack_tftp
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159075]  nf_nat_irc 
nf_conntrack_irc
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159076]  nf_nat_sip 
nf_conntrack_sip
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159078]  nf_nat_ftp 
nf_conntrack_ftp
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159079]  nf_nat_irc 
nf_conntrack_irc
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159080] 
vt6655_stage(COE)
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159081]  nf_nat_ftp
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159081]  xt_conntrack 
xt_MASQUERADE
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159082] 
nf_conntrack_ftp vt6655_stage(COE)
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159084] 
nf_conntrack_netlink
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159085]  xt_conntrack
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159085]  nfnetlink 
xfrm_user
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159086] 
xt_MASQUERADE nf_conntrack_netlink
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159087]  xfrm_algo
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159088]  nfnetlink
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159089]  xt_addrtype 
iptable_filter
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159090]  xfrm_user 
xfrm_algo
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159091]  iptable_nat 
nf_nat
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159092]  xt_addrtype 
iptable_filter
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159093]  nf_conntrack
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159094]  iptable_nat 
nf_nat
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159095]  nf_defrag_ipv6
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159096]  nf_conntrack
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159096] 
nf_defrag_ipv4 libcrc32c
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159097] 
nf_defrag_ipv6 nf_defrag_ipv4
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159098]  bpfilter
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159099]  libcrc32c
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159100]  br_netfilter 
bridge
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159101]  bpfilter 
br_netfilter
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159102]  stp llc
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159103]  bridge stp
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159104]  overlay
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159105]  llc overlay
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159106]  nls_iso8859_1
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159107]  nls_iso8859_1
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159107] 
snd_hda_codec_hdmi snd_hda_codec_conexant
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159108] 
snd_hda_codec_hdmi snd_hda_codec_conexant
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159109] 
snd_hda_codec_generic ledtrig_audio
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159110] 
snd_hda_codec_generic ledtrig_audio
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159112] 
intel_rapl_msr intel_rapl_common
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159112] 
intel_rapl_msr intel_rapl_common
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159114] 
x86_pkg_temp_thermal
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159115] 
x86_pkg_temp_thermal
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159115] 
intel_powerclamp coretemp
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159116] 
intel_powerclamp coretemp
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159117]  sch5627 mei_hdcp
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159118]  sch5627 mei_hdcp
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159119]  kvm_intel
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159120]  kvm_intel
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159120]  i915 kvm
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159121]  i915
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159122]  rtl8192se
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159123]  kvm rtl8192se
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159124]  snd_hda_intel
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159124]  snd_hda_intel
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159125]  rtl_pci
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159125]  rtl_pci 
snd_intel_dspcfg
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159127] 
snd_intel_dspcfg rtlwifi
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159128]  rtlwifi 
snd_intel_sdw_acpi
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159129] 
snd_intel_sdw_acpi snd_hda_codec
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159130]  snd_hda_codec
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159131]  mac80211
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159132]  mac80211 
crct10dif_pclmul
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159133] 
crct10dif_pclmul snd_hda_core
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159134]  snd_hda_core 
ghash_clmulni_intel
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159135] 
ghash_clmulni_intel
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159136]  snd_hwdep
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159136]  snd_hwdep 
aesni_intel
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159138]  aesni_intel
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159139]  snd_pcm
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159139]  snd_pcm 
sch56xx_common
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159140]  sch56xx_common
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159141]  crypto_simd
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159141]  crypto_simd 
cryptd
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159142]  cryptd drm_buddy
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159143]  drm_buddy rapl
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159144]  rapl 
snd_seq_midi
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159145]  snd_seq_midi
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159147]  intel_cstate
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159147]  intel_cstate 
input_leds
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159148]  input_leds ttm
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159149]  ttm joydev
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159150]  joydev
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159151] 
snd_seq_midi_event
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159151] 
snd_seq_midi_event cfg80211
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159152]  cfg80211 
serio_raw
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159153]  serio_raw
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159155]  efi_pstore
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159155]  efi_pstore at24
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159156]  at24 
drm_display_helper
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159157] 
drm_display_helper
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159158]  snd_rawmidi
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159158]  snd_rawmidi cec
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159160]  cec libarc4
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159161]  libarc4
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159162]  rc_core
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159162]  rc_core snd_seq
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159163]  snd_seq
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159164]  snd_seq_device
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159164] 
snd_seq_device drm_kms_helper
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159165] 
drm_kms_helper snd_timer
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159166]  snd_timer 
i2c_algo_bit
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159167]  i2c_algo_bit snd
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159168]  snd fb_sys_fops
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159169]  fb_sys_fops 
syscopyarea
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159171]  syscopyarea 
sysfillrect
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159172]  sysfillrect 
soundcore
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159173]  soundcore mei_me
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159174]  mei_me sysimgblt
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159175]  sysimgblt mei
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159176]  mei mac_hid
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159177]  mac_hid 
tpm_infineon
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159178]  tpm_infineon 
sch_fq_codel
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159179]  sch_fq_codel 
ipmi_devintf
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159181]  ipmi_devintf 
ipmi_msghandler
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159182] 
ipmi_msghandler msr
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159183]  msr parport_pc
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159184]  parport_pc drm
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159185]  drm ppdev
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159186]  ppdev lp
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159187]  lp parport
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159188]  parport 
ip_tables
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159190]  ip_tables 
x_tables
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159191]  x_tables autofs4
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159192]  autofs4 
hid_generic
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159193]  hid_generic 
usbhid
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159194]  usbhid hid
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159195]  hid crc32_pclmul
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159196]  crc32_pclmul 
ahci
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159197]  ahci libahci
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159198]  libahci xhci_pci
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159199]  xhci_pci 
i2c_i801
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159200]  i2c_i801
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159201]  i2c_smbus
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159201]  i2c_smbus e1000e
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159202]  e1000e 
xhci_pci_renesas
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159203]  xhci_pci_renesas
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159204]  lpc_ich
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159204]  lpc_ich video
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159206]  video
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159206]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159207]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159208] CPU: 2 PID: 
592 Comm: kworker/u8:16 Tainted: G         C OE      6.0.0-rc4+ #12
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159208] CPU: 1 PID: 
12196 Comm: kworker/1:0 Tainted: G         C OE      6.0.0-rc4+ #12
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159212] Hardware 
name: FUJITSU ESPRIMO P710/D3161-A1, BIOS V4.6.5.3 R1.16.0 for D3161-A1x 
10/29/2012
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159212] Hardware 
name: FUJITSU ESPRIMO P710/D3161-A1, BIOS V4.6.5.3 R1.16.0 for D3161-A1x 
10/29/2012
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159214] Workqueue: 
events vnt_interrupt_work [vt6655_stage]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159222] RIP: 
0010:native_queued_spin_lock_slowpath+0x83/0x2f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159228] Code: 24 08 
0f 92 c0 0f b6 c0 c1 e0 08 89 c2 41 8b 04 24 30 e4 09 d0 a9 00 01 ff ff 
75 5c 85 c0 74 12 41 8b 04 24 84 c0 74 0a f3 90 <41> 8b 04 24 84 c0 75 
f6 b8 01 00 00 00 66 41 89 04 24 5b 41 5c 41
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159230] RSP: 
0000:ffff9c2c80108728 EFLAGS: 00000202
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159233] RAX: 
00000000000c0101 RBX: ffff8aa6d3b3a118 RCX: 0000000000000000
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159235] RDX: 
0000000000000000 RSI: 0000000000000000 RDI: ffff8aa6d3b3a118
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159236] RBP: 
ffff9c2c80108750 R08: 0000000000000000 R09: 0000000000000002
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159238] R10: 
0000000000000000 R11: 0000000000000014 R12: ffff8aa6d3b3a118
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159239] R13: 
ffff8aa6d3bbfe00 R14: ffff8aa6d3b3a118 R15: ffff8aa6d3b388e0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159241] FS: 
0000000000000000(0000) GS:ffff8aa896280000(0000) knlGS:0000000000000000
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159243] CS:  0010 DS: 
0000 ES: 0000 CR0: 0000000080050033
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159244] CR2: 
000055d3d48c7258 CR3: 0000000071010004 CR4: 00000000001706e0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159246] Call Trace:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159214] Workqueue: 
phy1 ieee80211_beacon_connection_loss_work [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159248]  <IRQ>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159251] 
_raw_spin_lock+0x35/0x40
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159256] 
vnt_tx_80211+0x37/0x1b0 [vt6655_stage]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159272]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159273] RIP: 
0010:native_queued_spin_lock_slowpath+0x234/0x2f0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159278] Code: 8d 47 
01 41 c1 e6 10 c1 e0 12 41 09 c6 44 89 f0 c1 e8 10 66 41 87 44 24 02 89 
c2 c1 e2 10 75 5f 31 d2 eb 02 f3 90 41 8b 04 24 <66> 85 c0 75 f5 89 c1 
66 31 c9 41 39 ce 0f 84 87 00 00 00 41 c6 04
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159280] RSP: 
0018:ffff9c2c8073bba8 EFLAGS: 00000202
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159283] RAX: 
00000000000c0101 RBX: ffff8aa896332040 RCX: 0000000000000000
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159261] 
ieee80211_tx_frags+0x16b/0x240 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159285] RDX: 
0000000000000000 RSI: ffffffff9ede5949 RDI: ffffffff9edf4b4e
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159286] RBP: 
ffff9c2c8073bbd0 R08: 0000000000000000 R09: 0000000000000002
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159287] R10: 
0000000000000000 R11: 0000000000000014 R12: ffff8aa6d3b3a118
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159289] R13: 
ffff8aa896332040 R14: 00000000000c0000 R15: 0000000000000002
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159291] FS: 
0000000000000000(0000) GS:ffff8aa896300000(0000) knlGS:0000000000000000
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159292] CS:  0010 DS: 
0000 ES: 0000 CR0: 0000000080050033
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159294] CR2: 
00007f9d2cfec000 CR3: 0000000071010006 CR4: 00000000001706e0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159296] Call Trace:
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159297]  <TASK>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159299] 
_raw_spin_lock+0x35/0x40
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159304] 
vnt_tx_80211+0x37/0x1b0 [vt6655_stage]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159308] 
__ieee80211_tx+0x61/0x100 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159309] 
ieee80211_tx_frags+0x16b/0x240 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159348] 
ieee80211_tx+0x10a/0x140 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159351] 
__ieee80211_tx+0x61/0x100 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159389] 
ieee80211_xmit+0xbd/0x100 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159391] 
ieee80211_tx+0x10a/0x140 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159429] 
__ieee80211_subif_start_xmit+0xc09/0xe50 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159432] 
ieee80211_xmit+0xbd/0x100 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159469]  ? 
fib_info_nh_uses_dev+0x60/0x180
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159472] 
__ieee80211_tx_skb_tid_band+0xa7/0x160 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159476] 
ieee80211_subif_start_xmit+0x52/0x450 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159517] 
dev_hard_start_xmit+0x9f/0x200
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159521] 
sch_direct_xmit+0xa1/0x390
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159526] 
__dev_queue_xmit+0x7ba/0xd10
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159528]  ? 
enqueue_timer+0xa0/0xe0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159512] 
ieee80211_tx_skb_tid+0x59/0xa0 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159531]  ? 
_raw_spin_unlock_irqrestore+0x27/0x43
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159534]  ? 
mod_timer+0x1be/0x330
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159537] 
neigh_resolve_output+0x116/0x1c0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159541] 
__neigh_update+0x338/0xc50
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159546] 
neigh_update+0x14/0x20
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159549] 
arp_process+0x319/0x990
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159554]  ? 
__this_cpu_preempt_check+0x13/0x20
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159557]  ? 
__netif_receive_skb_core+0xb1/0xfb0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159560] 
arp_rcv+0x1a1/0x1e0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159564] 
__netif_receive_skb_list_core+0x200/0x260
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159567] 
netif_receive_skb_list_internal+0x1a6/0x2c0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159571] 
netif_receive_skb_list+0x25/0xd0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159553] 
ieee80211_send_nullfunc+0x8b/0xa0 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159573] 
ieee80211_rx_napi+0xb8/0xc0 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159599] 
ieee80211_mgd_probe_ap_send+0x14e/0x180 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159613] 
ieee80211_tasklet_handler+0xc5/0xd0 [mac80211]
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159645] 
tasklet_action_common.isra.0+0x11f/0x140
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159650] 
tasklet_action+0x2d/0x40
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159653] 
__do_softirq+0xf5/0x2d7
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159658] 
do_softirq+0x96/0xb0
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159661]  </IRQ>
Sep 14 20:35:46 matrix-ESPRIMO-P710 kernel: [ 3104.159662]  <TASK>
