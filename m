Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4576FA2B5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjEHI6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjEHI6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:58:05 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262BC2156F
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 01:57:59 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f18335a870so26571085e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 01:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683536277; x=1686128277;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzHUT4dMhUomj9pYklJ/WypYxlz27FOOjWTbVoGXtz0=;
        b=fej1Xepp9nHCOCYnfpfdA05bfp/+104VWtVbbSMcv2+ouIaA9GRx3O72HvkWURJv3g
         xlThRar7lBA2+15Ij1TwfCkz0Jpcw6TJsm3QqkBYhBqQ+jMwo6r9A2SWN7zqbDD9/GQj
         nJz3PNGoDHbSyF0mbnbsQtUvNaL1Qyok0R/13VRt1U2EHfeP9B+AsY59mv28udMT611D
         L59OZOkuwZWolFuLXI1aIjzq6vwzWuDCMGVAe1ca6f28rwZ86/+p0sTIGHroVATk0nQy
         NhNgrjLLmbyVmRHQc/7vF8glvnpSvl4BXUlnEq2a9auUs7d362eQqj1qsaV24ppCDiqe
         GWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683536277; x=1686128277;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzHUT4dMhUomj9pYklJ/WypYxlz27FOOjWTbVoGXtz0=;
        b=btIPhYHljZi/3uc+wMdXW6yl594Z1o0QFYPZnlT4Dl9fWLj6eRkUMBh7iWv0SzaRfS
         n3hbflI7HbEaFc0GOKhyuNg4C4daSn30yFfzvNikx6P5pPGpSV6gzbHtRrSgfCBiIayz
         wyrfNlvd8wZU66rePtlFDWKYO8U9MxS6M7doL9LJZud7rN6n1V2yDBT07bJ7CDPmvFRj
         PgzvS/bJiT1mSvx9EYcgDT2R5Os4/QR62dPT+UU/O/MY2qUm8iMcQRxM+UkeEoyu7SDo
         WntmNNCj7NSH8X1GJXx/SRHFJjF4/fFB0Va9IrpL0dt08P1yxAAPwJhZog40uri33OPl
         gcdw==
X-Gm-Message-State: AC+VfDySEfKi9dOBWR6jFJdXgp3hPUz0LBc1jfNG+2z389PMl8dYcBWm
        9vQwGjPYoF6CUQaict9NGAY=
X-Google-Smtp-Source: ACHHUZ7Yy2EGyep+kRBOOMf4Z5d4p6mnHevZ3uzj+i4tMljsaPea7VybNsMEu+P5XamexGlD/yma4w==
X-Received: by 2002:a7b:cd15:0:b0:3f1:94fe:65e2 with SMTP id f21-20020a7bcd15000000b003f194fe65e2mr6555964wmj.33.1683536277594;
        Mon, 08 May 2023 01:57:57 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003f42314832fsm4186303wml.18.2023.05.08.01.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 01:57:56 -0700 (PDT)
Message-ID: <0cdd2d49-a2a0-4968-a978-3c3caa5741f8@gmail.com>
Date:   Mon, 8 May 2023 10:57:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, ca-ES, es-ES
To:     Tom Rix <trix@redhat.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org,
        angelogioacchino.delregno@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230502145005.2927101-1-trix@redhat.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2] phy: mediatek: rework the floating point comparisons
 to fixed point
In-Reply-To: <20230502145005.2927101-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/05/2023 16:50, Tom Rix wrote:
> gcc on aarch64 reports
> drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c: In function ‘mtk_hdmi_pll_set_rate’:
> drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:240:52: error: ‘-mgeneral-regs-only’
>    is incompatible with the use of floating-point types
>    240 |         else if (tmds_clk >= 54 * MEGA && tmds_clk < 148.35 * MEGA)
> 
> Floating point should not be used, so rework the floating point comparisons
> to fixed point.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

I think this is worth a fixes tag.

Regards,
Matthias

> ---
> v2: silence robot by casting types to u64
> 
> ---
> drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> index abfc077fb0a8..093c4d1da557 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> @@ -237,11 +237,11 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdmi_phy, struct clk_hw *hw,
>   	 */
>   	if (tmds_clk < 54 * MEGA)
>   		txposdiv = 8;
> -	else if (tmds_clk >= 54 * MEGA && tmds_clk < 148.35 * MEGA)
> +	else if (tmds_clk >= 54 * MEGA && (tmds_clk * 100) < 14835 * MEGA)
>   		txposdiv = 4;
> -	else if (tmds_clk >= 148.35 * MEGA && tmds_clk < 296.7 * MEGA)
> +	else if ((tmds_clk * 100) >= 14835 * MEGA && (tmds_clk * 10) < 2967 * MEGA)
>   		txposdiv = 2;
> -	else if (tmds_clk >= 296.7 * MEGA && tmds_clk <= 594 * MEGA)
> +	else if ((tmds_clk * 10) >= 2967 * MEGA && tmds_clk <= 594 * MEGA)
>   		txposdiv = 1;
>   	else
>   		return -EINVAL;
> @@ -328,12 +328,12 @@ static int mtk_hdmi_pll_drv_setting(struct clk_hw *hw)
>   		clk_channel_bias = 0x34; /* 20mA */
>   		impedance_en = 0xf;
>   		impedance = 0x36; /* 100ohm */
> -	} else if (pixel_clk >= 74.175 * MEGA && pixel_clk <= 300 * MEGA) {
> +	} else if (((u64)pixel_clk * 1000) >= 74175 * MEGA && pixel_clk <= 300 * MEGA) {
>   		data_channel_bias = 0x34; /* 20mA */
>   		clk_channel_bias = 0x2c; /* 16mA */
>   		impedance_en = 0xf;
>   		impedance = 0x36; /* 100ohm */
> -	} else if (pixel_clk >= 27 * MEGA && pixel_clk < 74.175 * MEGA) {
> +	} else if (pixel_clk >= 27 * MEGA && ((u64)pixel_clk * 1000) < 74175 * MEGA) {
>   		data_channel_bias = 0x14; /* 10mA */
>   		clk_channel_bias = 0x14; /* 10mA */
>   		impedance_en = 0x0;
