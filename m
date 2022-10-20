Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2715605E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJTLLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJTLLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:11:14 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6031D73D1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:11:12 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m16so29407640edc.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hn/N2WGEIShHDhSTOCpQpwNa3x9m9bdbA56cDhmTwHI=;
        b=ef8EMNfsO7kJ1LUFqdRczimji9rYxgHXvyGrKSITnKn5o4gTgzlj/YK5sUjK5PkRWi
         Hr4qy2C0NbrUXVdLgNXVuZDfr1L6KVDyjIl8w4GKtOVXf6fXTqypjoKUU8WhFxn4yGo8
         ur4T852Gknsr/Bz2TCUEX2yM+3iWfBJEakL4QhWEOxMWAfmVbXVDLtP4NgYQxkxv7x7y
         aM20vt/1/ZUxkB/8Y7MlE04BoQCndKxopC32Hl1Z75ybbw38PBaYTsiW64AnRoZwDgvh
         L7OGOVJoi907f6UNIeOeyVkgmujlp4O82JHkscUyakfnIM2FD6SBW5Xbf+tn+GHQMign
         S6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hn/N2WGEIShHDhSTOCpQpwNa3x9m9bdbA56cDhmTwHI=;
        b=ewB/AbQx1mAdJ9VKBquhkCsu4aQLxEv0nOZn+xumzSreN0eWixWvFDj/khBtC3pjcc
         4PUN+XeP7AHQwdTFkddCXXKKThi3+PB7leWa4mH9xC6bLB7VnBCnhreRBT525AQrgLqj
         gGbudFGxuw46AZ7SkRJAjCeqIBVMQTDL/6mAuEMyyP5l+p6asD+7WeDJ48L15jthtllP
         qgol3HMXTRYeXUvpAVfP75JyVpj4ZrvUUKb3hFCGYY+yU3ni0ZIwFDRy7F6pSHQVSdtr
         jBnQgu91/+1977w5Vw4Y4XgIOPmWktlCt/1oB/ynG2cncRUEjSFI0RN4bry/xQKbZa0Z
         tyqQ==
X-Gm-Message-State: ACrzQf2Pz/VvIIuI4I2+wArjtSYJntPzI8sRFUkC1fhP9ekYuIXoCw7t
        yyGh4Jttxh78kYWlYJJHyR2MKaK2g1I=
X-Google-Smtp-Source: AMsMyM4ppw+tav9D/2RCt8wE8gvgksSGpYvuY3s8GUCLxEuXBe/Z0lKtHaOUVEpdk3ZMlOH0Jo+i2A==
X-Received: by 2002:a05:6402:4310:b0:45c:c16c:5c7d with SMTP id m16-20020a056402431000b0045cc16c5c7dmr11588275edc.246.1666264271293;
        Thu, 20 Oct 2022 04:11:11 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-158.ip.prioritytelecom.net. [217.105.46.158])
        by smtp.gmail.com with ESMTPSA id n24-20020a170906119800b0077077b59085sm10092230eja.184.2022.10.20.04.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 04:11:10 -0700 (PDT)
Date:   Thu, 20 Oct 2022 13:10:56 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     outreachy@lists.linux.dev, greg@kroah.com,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: Fix Lines should not end with a '('
Message-ID: <20221020111056.GA168499@nam-dell>
References: <Y1EpYbkrau17uhDI@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1EpYbkrau17uhDI@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:56:33AM +0000, Tanjuate Brunostar wrote:
> Code style warnings reported by checkpatch.
> Improve the layout of a function header:
> Put the first parameter immediately after the '(' and align the other
> parameters underneath it.
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> 
> ---
> v2: put static and void on the same line and adjusted the indentation as
> suggested by Greg KH
> ---
>  drivers/staging/vt6655/rxtx.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index 5bdb5176772c..d987f7dff02a 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -85,10 +85,8 @@ static const unsigned short wFB_Opt1[2][5] = {
>  #define DATADUR_A_F1    13
>  
>  /*---------------------  Static Functions  --------------------------*/
> -static
> -void
> -s_vFillRTSHead(
> -	struct vnt_private *pDevice,
> +static void
> +s_vFillRTSHead(struct vnt_private *pDevice,
>  	unsigned char byPktType,
>  	void *pvRTS,
>  	unsigned int	cbFrameLength,
> @@ -96,13 +94,10 @@ s_vFillRTSHead(
>  	bool bDisCRC,
>  	struct ieee80211_hdr *hdr,
>  	unsigned short wCurrentRate,
> -	unsigned char byFBOption
> -);
> +	unsigned char byFBOption);
>  
> -static
> -void
> -s_vGenerateTxParameter(
> -	struct vnt_private *pDevice,
> +static void
> +s_vGenerateTxParameter(struct vnt_private *pDevice,
>  	unsigned char byPktType,
>  	struct vnt_tx_fifo_head *,
>  	void *pvRrvTime,
> @@ -112,8 +107,7 @@ s_vGenerateTxParameter(
>  	bool bNeedACK,
>  	unsigned int	uDMAIdx,
>  	void *psEthHeader,
> -	unsigned short wCurrentRate
> -);
> +	unsigned short wCurrentRate);
>  
>  static unsigned int
>  s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
> -- 
> 2.34.1
>

I think you mistakenly sent v2 again..

Best regards,
Nam
