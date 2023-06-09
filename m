Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7A2729CFC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241488AbjFIOfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241489AbjFIOfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:35:19 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AC335AA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:35:17 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso18216335e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686321316; x=1688913316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wVa8MC8kwcS2ng+BkQEFaWJfUO7YqWufQrkvDktodkg=;
        b=qs8rynUduMwPWotJoNGusLZORQBlKNSob+6+KYS/2XEXJ1Jq1ci6XidnZ+I7zVjWgS
         o8v8voZwyeaOno0HA+rNpdE3eB/PmZUAh4t1HX5TuAgth65mTK0hqh730SPvxwHzkA2q
         2vaHnCKwe9Uc/tjwCi7gYm0V4uoVCOlZ81FCWBkHWCY39hHHF+4vS3iwgeIAmqbFtqhk
         iDoyY6oxTCc4XKrte6Tf3zfU7h51EADOOrZBV10TCY4NlogKTUC0HytJtT0UJXuKUzrx
         CY9qCElVaSglza1TkGdA3p3ER1b0au3usGMLCvaFyQ9GAwTB3WJVM2ZB2UGN1YHTFUXG
         SI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686321316; x=1688913316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVa8MC8kwcS2ng+BkQEFaWJfUO7YqWufQrkvDktodkg=;
        b=RM9YYlhKYaHURLVkaNKc/mu6XScRSjK7Cd9DOELdE/7ZN0Lg7YZy2H2CP/4bRoxhIu
         6JzeDWiwXDq/8D42nRltnlzst29avGveBUq0Fox22EIis09AmUsVn2I2aTOfH2Sgibgi
         KVbe29DEifJPnl840wgX+s7BfCLe2fJgLI0yWQSfCW6IpDFu2oSnCElzRRmRd18R+Noe
         h3cfFl5S9EGGwAaaLyoBPSg99fSb8kp6GBB7RnyHsxXUebVQnwkN2a76k3Gwy+5I9lZN
         IcIQDsJU/ysMeYCT7hZMESauPaM9Q0K52L3sGQ1taJds8OK7dzD3yYQWICreieft3O7I
         B7Dg==
X-Gm-Message-State: AC+VfDx9SJS6J8PeluQ0x+hgjufrkkOtOBAV5SIBP6GR0RK4HvluA0Yi
        X+AM0qRNAXdS8+L9Sozu+s2zC/+Z2pU=
X-Google-Smtp-Source: ACHHUZ64PnLXCyRKhyLcOLitaSXnzwiGlUPxQzfTXw1hF2NkXn53a8lYEktAltXoGUu/LwgkqfyoqQ==
X-Received: by 2002:a7b:c458:0:b0:3f8:6d6:d4a4 with SMTP id l24-20020a7bc458000000b003f806d6d4a4mr1268882wmi.10.1686321315852;
        Fri, 09 Jun 2023 07:35:15 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bcb93000000b003f7e75b053dsm2885791wmi.34.2023.06.09.07.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 07:35:14 -0700 (PDT)
Message-ID: <906ced27-2a01-f069-cf42-58674b0e2d65@gmail.com>
Date:   Fri, 9 Jun 2023 16:35:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] soc: mediatek: SVS: Fix MT8192 GPU node name
Content-Language: en-US, ca-ES, es-ES
To:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230531063532.2240038-1-wenst@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230531063532.2240038-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/05/2023 08:35, Chen-Yu Tsai wrote:
> Device tree node names should be generic. The planned device node name
> for the GPU, according to the bindings and posted DT changes, is "gpu",
> not "mali".
> 
> Fix the GPU node name in the SVS driver to follow.
> 
> Fixes: 0bbb09b2af9d ("soc: mediatek: SVS: add mt8192 SVS GPU driver")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Applied, thanks

> ---
>   drivers/soc/mediatek/mtk-svs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 81585733c8a9..3a2f97cd5272 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -2061,9 +2061,9 @@ static int svs_mt8192_platform_probe(struct svs_platform *svsp)
>   		svsb = &svsp->banks[idx];
>   
>   		if (svsb->type == SVSB_HIGH)
> -			svsb->opp_dev = svs_add_device_link(svsp, "mali");
> +			svsb->opp_dev = svs_add_device_link(svsp, "gpu");
>   		else if (svsb->type == SVSB_LOW)
> -			svsb->opp_dev = svs_get_subsys_device(svsp, "mali");
> +			svsb->opp_dev = svs_get_subsys_device(svsp, "gpu");
>   
>   		if (IS_ERR(svsb->opp_dev))
>   			return dev_err_probe(svsp->dev, PTR_ERR(svsb->opp_dev),
