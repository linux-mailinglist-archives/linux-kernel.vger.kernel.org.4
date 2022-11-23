Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2526C635A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbiKWKgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbiKWKfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:35:10 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1041D125232
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:20:06 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d1so16547456wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=evmqZal6P0Gh2KtjmqsYtpngHK9nsZsmphCRedKA3xE=;
        b=lkh9GncI+CNngHOJwLpl5TTT0pzTnHj78uPilgOF9t71J+w51UpkVUSfzl0VkzLb4s
         CTHaQcIifgKEM+P8bw9mPpIT9jIwxu6DcVxVfp7bLcT4YCLo4azv516Cz6/82DsaKDy+
         dXimePNiTsxoOLOfTkelN6SaS9fxtyIbB4D3gDJGtwbnGDaPLjKPieoW3+ynnVXErG6I
         QjLW6PQ1+gUrnjUnVU96UbftOBk4QVupMII4tnGGl42yZ3be69RhlVAoVlmHMd0CFOxA
         6DcOvWMUHgVF+5OY7dYnQ4d6OowIf29f2RTVH7kImDDS/5n3tJQPGU/1+sZbaXP4GDgE
         5Lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evmqZal6P0Gh2KtjmqsYtpngHK9nsZsmphCRedKA3xE=;
        b=Gt6IGV5sOgYbaRLn6R+24av0hpx0MymKptjKF0vtEdGlp5ql+jfTugZEilanlkKYOV
         BXHEIsGFXECdzfgXQfUg0aMXU/qjkbiWKqougJP/4ZT37+YBlZVa2xKGsbIw/dUWMMbd
         CEdcU15YAaozc0TlUvnMHOK+uxdUpdKN4s7ZvobCQTISzs2ELI3AXh2nWRG2PzhdDh4E
         XDjdL8BBLxhCq1uXcRNKR2//UA7OmP/e3iYdupd1qiyKNDXOhWD+vpP2sFChabzcHbQo
         ZtrO7izWIcsQsW0vo5/Cw376fSwy1ORijWs/LasUY9YBVGdonDvjEKqXGroECN0rVLOw
         z7nA==
X-Gm-Message-State: ANoB5plzmsFOqtOxsR6tsbRKwNXxYTSj8YtgPRloIuH18/nz7AEAfq6g
        4Sx31SR8PRKfC5dcpT/46k3uuRppXpc=
X-Google-Smtp-Source: AA0mqf4VoZcQFHNMjX7NzjbJPyyRNRq8XZnr59GZjTGNVCKozWfAGWsr4g0ZjkqCfYy/YSJJLcWrIQ==
X-Received: by 2002:adf:f805:0:b0:236:ef0b:68c5 with SMTP id s5-20020adff805000000b00236ef0b68c5mr17363638wrp.373.1669198804459;
        Wed, 23 Nov 2022 02:20:04 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003c6f3e5ba42sm1898268wmg.46.2022.11.23.02.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 02:20:03 -0800 (PST)
Message-ID: <ce1c6a1a-9183-e56d-6757-947f5fc8133d@gmail.com>
Date:   Wed, 23 Nov 2022 11:20:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1] soc: mediatek: mtk-pm-domains: Allow mt8186 ADSP
 default power on
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     allen-kh.cheng@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221012075434.30009-1-tinghan.shen@mediatek.com>
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221012075434.30009-1-tinghan.shen@mediatek.com>
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



On 12/10/2022 09:54, Tinghan Shen wrote:
> In the use case of configuring the access permissions of the ADSP core,
> the mt8186 SoC ADSP power will be switched on in the bootloader because
> the permission control registers are located in the ADSP subsys.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Do we need a fixes tag here?
My bet is:
Fixes: 88590cbc1703 ("soc: mediatek: pm-domains: Add support for mt8186")

Or is this not yet a problem but needed to be able to implement access 
permission configuration in the ADSP driver?

Regards,
Matthias

> ---
>   drivers/soc/mediatek/mt8186-pm-domains.h | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mt8186-pm-domains.h b/drivers/soc/mediatek/mt8186-pm-domains.h
> index 108af61854a3..fce86f79c505 100644
> --- a/drivers/soc/mediatek/mt8186-pm-domains.h
> +++ b/drivers/soc/mediatek/mt8186-pm-domains.h
> @@ -304,7 +304,6 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
>   		.ctl_offs = 0x9FC,
>   		.pwr_sta_offs = 0x16C,
>   		.pwr_sta2nd_offs = 0x170,
> -		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
>   	},
>   	[MT8186_POWER_DOMAIN_ADSP_INFRA] = {
>   		.name = "adsp_infra",
> @@ -312,7 +311,6 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
>   		.ctl_offs = 0x9F8,
>   		.pwr_sta_offs = 0x16C,
>   		.pwr_sta2nd_offs = 0x170,
> -		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
>   	},
>   	[MT8186_POWER_DOMAIN_ADSP_TOP] = {
>   		.name = "adsp_top",
> @@ -332,7 +330,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
>   				MT8186_TOP_AXI_PROT_EN_3_CLR,
>   				MT8186_TOP_AXI_PROT_EN_3_STA),
>   		},
> -		.caps = MTK_SCPD_SRAM_ISO | MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_ACTIVE_WAKEUP,
> +		.caps = MTK_SCPD_SRAM_ISO | MTK_SCPD_ACTIVE_WAKEUP,
>   	},
>   };
>   
