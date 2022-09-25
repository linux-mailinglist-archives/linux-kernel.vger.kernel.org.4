Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A355E9611
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 22:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiIYU4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 16:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiIYU4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 16:56:17 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B2822BDE
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 13:56:16 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z2so6645481edi.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 13:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=97Ii7Mnf20tLRy+FmbI0Die2YsZZlSa+I/V2fOHbZwc=;
        b=nmoBMxuoIlec7AbEPrbTDUy1e7yV3Rrg2ev5H7rc6W6jQ9JhJq4d4VhjTWmI3G65PS
         xwdzYyuOTXD8ciXfABHziIdnOf+aKWL9qrUdahFal1buJ6D9S0apPtMz3xQlpOdnBvh5
         EZGoe6ll5mRRFun1KamV0mPBNG60a6UnwvIqnRRxQpqBihSgTOp9m8CaWEcwxgXPAAdC
         omaNHQAbWRFajOvezPj9OEKTnPFlXlMy4mvU+F4Pn54PlQYj0fEH/UjG6Rvhs0NwwFwr
         i84DaOZtSlm775eFzUP2Gi32lCLhGywnd1xpCdQunzjzwsKXGV0MzwZamI1nS1ESz74s
         Km0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=97Ii7Mnf20tLRy+FmbI0Die2YsZZlSa+I/V2fOHbZwc=;
        b=Xk3rOvGlg4t8oR5qVWORGjwD0brW5EdtGqhz5r4jfQP5FT0Z0/VhxiCukYq2Lo5X0N
         CEJWova9jhapcUmAxPp31XXT2M0ZEf/W+R6nxQNfnvDSoM4fi/M7fX6yDo4gR6/8tSwL
         7cPSpMV6jX08vHIE/tkScCel+dccreQmXjvckFqAOUh7dXJaevRlZp0b2WX/t0DRYWHT
         yVjs7UFPGMb3+zlCW1SG6x49ymMQPR1tavJevnaNeQkL7lLU9JMyQGNyo8yJQ9FJtP/B
         p27hh4C0zWpi5vCl1s22ysbhM4SvxfUABc5AA4vnJqkcrAA1tAAClGCWJDWbiRo0tDKX
         OoWQ==
X-Gm-Message-State: ACrzQf1PczkxECgxld4DBIGWFrsTtSOE9NNetgsz5kwLM5lubN8FVn5L
        5gAIpqTgAr0+XDCICPI5PZK6gvhDhjc=
X-Google-Smtp-Source: AMsMyM7cyTazGbfi/wnVNEDpVnYyZ3YssJ+h4Hs0qP1sYhnoX42d6uv3MVswRHiZ/d2/8gXY7k+Xbw==
X-Received: by 2002:aa7:c9c4:0:b0:452:1d98:1be3 with SMTP id i4-20020aa7c9c4000000b004521d981be3mr19353121edt.289.1664139374536;
        Sun, 25 Sep 2022 13:56:14 -0700 (PDT)
Received: from [192.168.1.100] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0072b3406e9c2sm7302997eja.95.2022.09.25.13.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 13:56:14 -0700 (PDT)
Message-ID: <79133187-c2b5-f5ed-07eb-365c4f482a73@gmail.com>
Date:   Sun, 25 Sep 2022 22:56:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] staging: rtl8192e: fix CamelCase struct member
Content-Language: en-US
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220925122335.2489902-1-vvidic@valentin-vidic.from.hr>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220925122335.2489902-1-vvidic@valentin-vidic.from.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/22 14:23, Valentin Vidic wrote:
> Fix checkpatch warnings for struct member pFirmware.
This is too short description as you take out:
struct rt_firmware *pfirmware = priv->pFirmware;
And replace pfirmware with priv->firmware
> 
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
> ---
> v2: drop the 'p' prefix from the struct member and always
>      use priv->firmware for access.
> v3: rebase on staging-testing branch
> 
>   .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  8 +++---
>   .../rtl8192e/rtl8192e/r8192E_firmware.c       | 25 ++++++++-----------
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  8 +++---
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  2 +-
>   4 files changed, 20 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> index 5832ccdb4e50..54f5c7574f8a 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> @@ -622,19 +622,19 @@ bool rtl92e_start_adapter(struct net_device *dev)
>   		rtl92e_writeb(dev, ANAPAR, 0x37);
>   		mdelay(500);
>   	}
> -	priv->pFirmware->status = FW_STATUS_0_INIT;
> +	priv->firmware->status = FW_STATUS_0_INIT;
>   
>   	if (priv->RegRfOff)
>   		priv->rtllib->eRFPowerState = eRfOff;
>   
>   	ulRegRead = rtl92e_readl(dev, CPU_GEN);
> -	if (priv->pFirmware->status == FW_STATUS_0_INIT)
> +	if (priv->firmware->status == FW_STATUS_0_INIT)
>   		ulRegRead |= CPU_GEN_SYSTEM_RESET;
> -	else if (priv->pFirmware->status == FW_STATUS_5_READY)
> +	else if (priv->firmware->status == FW_STATUS_5_READY)
>   		ulRegRead |= CPU_GEN_FIRMWARE_RESET;
>   	else
>   		netdev_err(dev, "%s(): undefined firmware state: %d.\n",
> -			   __func__, priv->pFirmware->status);
> +			   __func__, priv->firmware->status);
>   
>   	rtl92e_writel(dev, CPU_GEN, ulRegRead);
>   
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
> index 789d288d7503..b4b702623bfe 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
> @@ -51,32 +51,31 @@ static bool _rtl92e_fw_check_ready(struct net_device *dev,
>   				   u8 load_fw_status)
>   {
>   	struct r8192_priv *priv = rtllib_priv(dev);
> -	struct rt_firmware *pfirmware = priv->pFirmware;
>   	bool rt_status  = true;
>   
>   	switch (load_fw_status) {
>   	case FW_INIT_STEP0_BOOT:
> -		pfirmware->status = FW_STATUS_1_MOVE_BOOT_CODE;
> +		priv->firmware->status = FW_STATUS_1_MOVE_BOOT_CODE;
>   		break;
>   
>   	case FW_INIT_STEP1_MAIN:
> -		pfirmware->status = FW_STATUS_2_MOVE_MAIN_CODE;
> +		priv->firmware->status = FW_STATUS_2_MOVE_MAIN_CODE;
>   
>   		rt_status = _rtl92e_fw_boot_cpu(dev);
>   		if (rt_status)
> -			pfirmware->status = FW_STATUS_3_TURNON_CPU;
> +			priv->firmware->status = FW_STATUS_3_TURNON_CPU;
>   		else
>   			netdev_dbg(dev, "_rtl92e_fw_boot_cpu fail!\n");
>   
>   		break;
>   
>   	case FW_INIT_STEP2_DATA:
> -		pfirmware->status = FW_STATUS_4_MOVE_DATA_CODE;
> +		priv->firmware->status = FW_STATUS_4_MOVE_DATA_CODE;
>   		mdelay(1);
>   
>   		rt_status = _rtl92e_wait_for_fw(dev, CPU_GEN_FIRM_RDY, 20);
>   		if (rt_status)
> -			pfirmware->status = FW_STATUS_5_READY;
> +			priv->firmware->status = FW_STATUS_5_READY;
>   		break;
>   	default:
>   		rt_status = false;
> @@ -134,22 +133,20 @@ bool rtl92e_init_fw(struct net_device *dev)
>   	enum opt_rst_type rst_opt = OPT_SYSTEM_RESET;
>   	enum firmware_init_step starting_state = FW_INIT_STEP0_BOOT;
>   
> -	struct rt_firmware *pfirmware = priv->pFirmware;
> -
>   	netdev_dbg(dev, " PlatformInitFirmware()==>\n");
>   
> -	if (pfirmware->status == FW_STATUS_0_INIT) {
> +	if (priv->firmware->status == FW_STATUS_0_INIT) {
>   		rst_opt = OPT_SYSTEM_RESET;
>   		starting_state = FW_INIT_STEP0_BOOT;
>   
> -	} else if (pfirmware->status == FW_STATUS_5_READY) {
> +	} else if (priv->firmware->status == FW_STATUS_5_READY) {
>   		rst_opt = OPT_FIRMWARE_RESET;
>   		starting_state = FW_INIT_STEP2_DATA;
>   	}
>   
>   	for (i = starting_state; i <= FW_INIT_STEP2_DATA; i++) {
>   		if (rst_opt == OPT_SYSTEM_RESET) {
> -			if (pfirmware->blobs[i].size == 0) {
> +			if (priv->firmware->blobs[i].size == 0) {
>   				const char *fw_name[3] = {
>   					RTL8192E_BOOT_IMG_FW,
>   					RTL8192E_MAIN_IMG_FW,
> @@ -161,15 +158,15 @@ bool rtl92e_init_fw(struct net_device *dev)
>   					pad = 128;
>   
>   				if (!_rtl92e_fw_prepare(dev,
> -							&pfirmware->blobs[i],
> +							&priv->firmware->blobs[i],
>   							fw_name[i],
>   							pad))
>   					goto download_firmware_fail;
>   			}
>   		}
>   
> -		mapped_file = pfirmware->blobs[i].data;
> -		file_length = pfirmware->blobs[i].size;
> +		mapped_file = priv->firmware->blobs[i].data;
> +		file_length = priv->firmware->blobs[i].size;
>   
>   		rt_status = rtl92e_send_cmd_pkt(dev, DESC_PACKET_TYPE_INIT,
>   						mapped_file, file_length);
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> index 671fe547639b..94e8f0706ed4 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> @@ -907,8 +907,8 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
>   
>   	priv->card_type = PCI;
>   
> -	priv->pFirmware = vzalloc(sizeof(struct rt_firmware));
> -	if (!priv->pFirmware)
> +	priv->firmware = vzalloc(sizeof(*priv->firmware));
> +	if (!priv->firmware)
>   		netdev_err(dev,
>   			   "rtl8192e: Unable to allocate space for firmware\n");
>   
> @@ -2409,8 +2409,8 @@ static void _rtl92e_pci_disconnect(struct pci_dev *pdev)
>   		priv->polling_timer_on = 0;
>   		_rtl92e_down(dev, true);
>   		rtl92e_dm_deinit(dev);
> -		vfree(priv->pFirmware);
> -		priv->pFirmware = NULL;
> +		vfree(priv->firmware);
> +		priv->firmware = NULL;
>   		_rtl92e_free_rx_ring(dev);
>   		for (i = 0; i < MAX_TX_QUEUE_COUNT; i++)
>   			_rtl92e_free_tx_ring(dev, i);
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
> index 093887bcd463..dba789f0c9e6 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
> @@ -343,7 +343,7 @@ struct r8192_priv {
>   
>   	enum acm_method AcmMethod;
>   
> -	struct rt_firmware			*pFirmware;
> +	struct rt_firmware			*firmware;
>   	enum rtl819x_loopback LoopbackMode;
>   
>   	struct timer_list			watch_dog_timer;

A simple connection test works.

This patch cannot be applied on top of my 10 series patch send earlier. 
Sorry for that.

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
