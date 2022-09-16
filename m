Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8047F5BA67D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 07:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiIPFsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 01:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiIPFr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 01:47:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9675680F55
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 22:47:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r18so46975873eja.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 22:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=OcKeKVWdaipsZM2UXTtbaHbEX8KKigHs/WLUeqGJyHY=;
        b=psTtztujExWhwXzL+eRUtUEvxJJbEpLnI5q55XOCsBzFnBRzclZFK6B29YS0L5Enhq
         y/TAOyrFrzMDkxUec72fZOkEu0ql05Ax5bwJm9Stz41cy6AQC1rM5d5vZ0CA6OWHeXX9
         kFkyaWHS69YJyNxa2WnksNso7WbfyjGTTvEvBTIqFp/vrD28gtt2ZFz1kzy6PsZacS/0
         EoXYrPAiOP4fm2ZgwkATvyctxLjuB0M87LclaDWfTKp1IYfEJI5693vZX0WHpoGhpm+Y
         +7CJ3xsEUFUvWWcahtA1+o2Cn5mhgDdUb+UK9dHyaxwpNbcbfwjb0vWq6JhD8LA5C2DX
         FDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OcKeKVWdaipsZM2UXTtbaHbEX8KKigHs/WLUeqGJyHY=;
        b=d4GpEdnBdGcfKjiHvvQalVw9yoZE+1dh60ZXUWE/CQFxx2zXvMn+8p85ypg4tsJuUL
         gf/ppc0KZTh3WrinTQLIhOYoIKG/oTkk6X2ubUT2AU+7ECZ5Jwc2fldhp6Xdjon/UJxW
         as7tnqNZusssthRUJnf33zbQyMshTSQLnmLiTOn0idZ5HbC1BN1RSUmltnklBWk8AayM
         tzUniFSWlw88ArHNZALAbU0C1ERzvxXi8+oM9GGQIwfmyqwvSCBIEzliMuJXep+0Q4/Y
         PagkQMm/xLJlUXfRvKAbjn4CHKB2Uwmuh5y9VvSA50jfPZ8k03Nne51kk9vHbUcv8lzY
         tvOg==
X-Gm-Message-State: ACrzQf0kNgAqg63IfQY3hZl0agliqK/g/L9VL6giDAVRuP7xdjuRm0BN
        dy+dzzcOew2Ri0ZbvRSe1ZA=
X-Google-Smtp-Source: AMsMyM6uhas3Fz5dnSqdHcgb/U3UrpdfYmITTCxc7j4Wj7u/JDOb8t5KwTwRBFqUJ/JT1bbCXPVRAw==
X-Received: by 2002:a17:907:a06:b0:77b:6eca:c089 with SMTP id bb6-20020a1709070a0600b0077b6ecac089mr2286316ejc.362.1663307274012;
        Thu, 15 Sep 2022 22:47:54 -0700 (PDT)
Received: from [192.168.1.100] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id fw18-20020a170907501200b0073dbaeb50f6sm9901865ejc.169.2022.09.15.22.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 22:47:53 -0700 (PDT)
Message-ID: <28159639-c011-62a0-e8bd-07a79aadca91@gmail.com>
Date:   Fri, 16 Sep 2022 07:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Staging: rtl8192e: fixed brace, space, and align coding
 style issues
Content-Language: en-US
To:     Anjandev Momi <anjan@momi.ca>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220916030655.11105-1-anjan@momi.ca>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220916030655.11105-1-anjan@momi.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/22 05:06, Anjandev Momi wrote:
> After applying this patch, file drivers/staging/rtl8192e/rtl819x_BAProc.c only
> has "Avoid CamelCase" coding style issue
> 

The patch description needs to describe _why_ the change is required or 
makes sense.

Have a look at:
https://lore.kernel.org/linux-staging/
https://lore.kernel.org/linux-staging/20220911174933.3784-3-straube.linux@gmail.com/T/#u

> Signed-off-by: Anjandev Momi <anjan@momi.ca>
> ---
>   drivers/staging/rtl8192e/rtl819x_BAProc.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> index 7d04966af..b4e565af1 100644
> --- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> @@ -62,6 +62,7 @@ void ResetBaEntry(struct ba_record *pBA)
>   	pBA->dialog_token		  = 0;
>   	pBA->ba_start_seq_ctrl.short_data = 0;
>   }
> +
>   static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
>   				    struct ba_record *pBA,
>   				    u16 StatusCode, u8 type)

This makes sense

> @@ -113,7 +114,7 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
>   	tag += 2;
>   
>   	if (type == ACT_ADDBAREQ) {
> -		memcpy(tag, (u8 *)&(pBA->ba_start_seq_ctrl), 2);
> +		memcpy(tag, (u8 *)&pBA->ba_start_seq_ctrl, 2);
>   		tag += 2;
>   	}
>   

This makes sense

> @@ -161,7 +162,6 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
>   	*tag++ = ACT_CAT_BA;
>   	*tag++ = ACT_DELBA;
>   
> -
>   	put_unaligned_le16(DelbaParamSet.short_data, tag);
>   	tag += 2;
>   

This makes sense

> @@ -258,8 +258,8 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
>   			    ieee->pHTInfo->bCurrentHTSupport);
>   		goto OnADDBAReq_Fail;
>   	}
> -	if (!GetTs(ieee, (struct ts_common_info **)(&pTS), dst,
> -	    (u8)(pBaParamSet->field.tid), RX_DIR, true)) {
> +	if (!GetTs(ieee, (struct ts_common_info **)(&pTS),
> +		   dst, (u8)(pBaParamSet->field.tid), RX_DIR, true)) {
>   		rc = ADDBA_STATUS_REFUSED;
>   		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
>   		goto OnADDBAReq_Fail;

Why do you need to put the "dst" to the next line?

> @@ -282,7 +282,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
>   	pBA->ba_start_seq_ctrl = *pBaStartSeqCtrl;
>   
>   	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev) ||
> -	   (ieee->pHTInfo->IOTAction & HT_IOT_ACT_ALLOW_PEER_AGG_ONE_PKT))
> +	    (ieee->pHTInfo->IOTAction & HT_IOT_ACT_ALLOW_PEER_AGG_ONE_PKT))
>   		pBA->ba_param_set.field.buffer_size = 1;
>   	else
>   		pBA->ba_param_set.field.buffer_size = 32;

Did checkpatch tell you to do so?

> @@ -380,7 +380,6 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
>   			goto OnADDBARsp_Reject;
>   		}
>   
> -
>   		pAdmittedBA->dialog_token = *pDialogToken;
>   		pAdmittedBA->ba_timeout_value = *pBaTimeoutVal;
>   		pAdmittedBA->ba_start_seq_ctrl = pPendingBA->ba_start_seq_ctrl;

This makes sense

> @@ -419,8 +418,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
>   		return -1;
>   	}
>   
> -	if (!ieee->current_network.qos_data.active ||
> -		!ieee->pHTInfo->bCurrentHTSupport) {
> +	if (!ieee->current_network.qos_data.active || !ieee->pHTInfo->bCurrentHTSupport) {
>   		netdev_warn(ieee->dev,
>   			    "received DELBA while QOS or HT is not supported(%d, %d)\n",
>   			    ieee->current_network. qos_data.active,

This makes sense

> @@ -440,7 +438,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
>   		struct rx_ts_record *pRxTs;
>   
>   		if (!GetTs(ieee, (struct ts_common_info **)&pRxTs, dst,
> -		    (u8)pDelBaParamSet->field.tid, RX_DIR, false)) {
> +			   (u8)pDelBaParamSet->field.tid, RX_DIR, false)) {
>   			netdev_warn(ieee->dev,
>   				    "%s(): can't get TS for RXTS. dst:%pM TID:%d\n",
>   				    __func__, dst,

Did checkpatch tell you to do so? Checkpatch is not always right. I see 
what you want to do but I cannot say that this is really improving 
readability.

Always consider that I am not the maintainer. Those are just my opinions.

I can apply and compile your patch. Connection works.

I am sure you need a v2 of this patch with an updated description. 
Please do include a change history.

Bye Philipp











