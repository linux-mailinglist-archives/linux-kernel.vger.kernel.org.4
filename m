Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C026154B9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiKAWHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiKAWHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:07:45 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B5C62E9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:07:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id kt23so40569850ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LsShDdmGa0grrRD1g2mF/83SuhjHV8rDIY0eEAKZRrA=;
        b=hsDl3TZT4VKq+2jijDnLHryvBmIZkT18GjdwWkTkIujYOpCZ4Y4o8NSXz4ON+d7ctb
         t20wvoAdXNLsnJ4hDq6ALpTrY2pCG7TVANWj3VeYllS3R67GBhjPuCTquklEzxLAIrFo
         wQ/A6ea9mzTAip0+UHa8Tid2nkjiVwT7A/+cXwKyZlABG48efrjY9k4Uu+2LDp7LVOWD
         fruJlgsCdtBFzFj5uIG6DXJh4yt6Kyz75x2ldLZATPuFuc49zGI6NCEYFre2jcxNnnLt
         70IvPZPXMiuyLHUniQ7Sh6YNT2I4sbLcu4RJmcT2gQTmdf5YXcFb9e/Wf3XjLO+5BW8i
         nwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LsShDdmGa0grrRD1g2mF/83SuhjHV8rDIY0eEAKZRrA=;
        b=GlCzk1pRLJ9FrO5KibS++oiOQSHgx/1poqyiBViZAeNrqodqH+g48vDh8cT8dyKkWB
         sGZAhSe0dnZptJFnqx9xBYQbsj+hrKzqSox62CniP4OW8+7CTzweovVjPD3T6F0meZnU
         N4yaS/zKvTHLPG+RBmVhzb8NxqLlTz5jk4MdPVwr3xlSsJw+wB+90H0MRlQ5XoJWr7Ir
         zwX0iqY74WfWUivBnxT2dDjKd0UrUAtDgQP/OYRA5O6WCK8GmFHErjM+9ispy3JAFe3U
         /z7rc6KWp43PZhIMuLULzqf7Oi5QXEdsEX58kBcUa76ruiTkF1cGfhQfjnHuwhV/Z8JY
         pQ7w==
X-Gm-Message-State: ACrzQf2RisJv/1Na17EIILLc+VDgI7Im7MGTeJF7wrZJFruG3JOTGtBY
        bbAUJaRAfQYajrLC2oDWPCVD+g7HlSQ=
X-Google-Smtp-Source: AMsMyM4mSnmfS5fWp8bvXroTKvFiH6z94K45BOHauWbEnUhQk4F0XU9zNy0cFEbKWY7oD5K7U5cFdA==
X-Received: by 2002:a17:906:36d1:b0:76c:a723:9445 with SMTP id b17-20020a17090636d100b0076ca7239445mr19762592ejc.548.1667340462822;
        Tue, 01 Nov 2022 15:07:42 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:b885:c7c8:ee47:4872:331d? (p200300c78f2ab885c7c8ee474872331d.dip0.t-ipconnect.de. [2003:c7:8f2a:b885:c7c8:ee47:4872:331d])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b0079e552fd860sm4604163ejm.152.2022.11.01.15.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 15:07:42 -0700 (PDT)
Message-ID: <f391a7cd-e57a-0643-1ba1-c859bf2f83a6@gmail.com>
Date:   Tue, 1 Nov 2022 23:07:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] staging: rtl8192e: space formatting fixes in rtl_cam.c
Content-Language: en-US
To:     Jerom van der Sar <jerom.vandersar@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     error27@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <7d001a49-4e45-fda2-15fe-b05f2c340eaa@gmail.com>
 <20221101215246.4442-1-jerom.vandersar@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221101215246.4442-1-jerom.vandersar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/22 22:52, Jerom van der Sar wrote:
> Fixed a few coding style issues in rtl_cam.c such as double blank lines
> and lack of spaces around binary operators. Some other warnings still
> remain. These issues were found by scripts/checkpatch.pl.
> 
> This patch helps clean up the rtl8192e driver in staging, making it
> easier to read and maintain.
> 
> Signed-off-by: Jerom van der Sar <jerom.vandersar@gmail.com>.
> ---
> Changes in v2:
>    - Reverted some formatting fixes to make the diff easier to review.
> 
>   drivers/staging/rtl8192e/rtl8192e/rtl_cam.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
> index 41faeb4b9b9b..d5aaf24a0ddb 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
> @@ -17,7 +17,7 @@ void rtl92e_cam_reset(struct net_device *dev)
>   {
>   	u32 ulcommand = 0;
>   
> -	ulcommand |= BIT31|BIT30;
> +	ulcommand |= BIT31 | BIT30;
>   	rtl92e_writel(dev, RWCAM, ulcommand);
>   }
>   
> @@ -40,7 +40,6 @@ void rtl92e_enable_hw_security_config(struct net_device *dev)
>   		SECR_value |= SCR_TxUseDK;
>   	}
>   
> -
>   	ieee->hwsec_active = 1;
>   	if ((ieee->pHTInfo->iot_action & HT_IOT_ACT_PURE_N_MODE) || !hwwep) {
>   		ieee->hwsec_active = 0;
> @@ -104,10 +103,9 @@ void rtl92e_set_key(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
>   	else
>   		usConfig |= BIT15 | (KeyType<<2) | KeyIndex;
>   
> -
>   	for (i = 0; i < CAM_CONTENT_COUNT; i++) {
>   		TargetCommand  = i + CAM_CONTENT_COUNT * EntryNo;
> -		TargetCommand |= BIT31|BIT16;
> +		TargetCommand |= BIT31 | BIT16;
>   
>   		if (i == 0) {
>   			TargetContent = (u32)(*(MacAddr+0)) << 16 |
> @@ -152,7 +150,6 @@ void rtl92e_cam_restore(struct net_device *dev)
>   
>   	if ((priv->rtllib->pairwise_key_type == KEY_TYPE_WEP40) ||
>   	    (priv->rtllib->pairwise_key_type == KEY_TYPE_WEP104)) {
> -
>   		for (EntryId = 0; EntryId < 4; EntryId++) {
>   			MacAddr = CAM_CONST_ADDR[EntryId];
>   			if (priv->rtllib->swcamtable[EntryId].bused) {


WARNING: Unexpected content after email: 'Jerom van der Sar 
<jerom.vandersar@gmail.com>.', should be: 'Jerom van der Sar 
<jerom.vandersar@gmail.com>'
#14:
Signed-off-by: Jerom van der Sar <jerom.vandersar@gmail.com>.


I cannot apply your patch.

Bye Philipp



