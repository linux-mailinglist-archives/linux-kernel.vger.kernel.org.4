Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997AC6ECC01
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 14:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjDXM3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 08:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjDXM3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:29:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29742D79;
        Mon, 24 Apr 2023 05:28:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-2fc3f1d6f8cso2706655f8f.3;
        Mon, 24 Apr 2023 05:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682339337; x=1684931337;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4btwjmDtWOTvKFh0kR1iGmSPDebnG97zaZbOKyWXPl8=;
        b=NWqzOabt7g5a2aRxakDGgrWWeChfEg+FmyKj0ygzBgSA8CDGw05VghIIDZgdeIEAwQ
         RQYZCD9+Qu8Ywqw24e5+AmENg7iqveIMmnLaghK3HJXoc34QVGeNv+pKF93CtBmEiHPw
         9SUOUnhjFyi6foZ2C2PxpoaNpzL3EjmO6LsH6BUuv/ZYQ/hH1QxpkbNEu01rmuT6l01l
         0z+RzJ1FCKvp63KaXE1RS/UvJ13Z4KEqftHGHwiAFpmpK/yFeOSt1bjN81v/CmiPb2zi
         ESrFnK+1Jt+mERMRqPdrTxsH47yF89oFG3agh9ahRUC1joetW8y95Cqid/JdmL0h22OD
         CVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682339337; x=1684931337;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4btwjmDtWOTvKFh0kR1iGmSPDebnG97zaZbOKyWXPl8=;
        b=V0xQRix5iqKcTtxwV0dDVrqHMDqFYCiDTLouCdzl0iSFK5P++ts3XUbMmtMZ/OMey4
         tGd0b9bbvy7tagQoxt/tzNyxwk9FQjUGa1zxcpBsPBgSHutnung6Xh7sXD2579IjGVdC
         Z5wsRXQJFPZLiK6ka55iRWXU9UfFGcNU8t5dE7cJOe+uHU+mwbMFZvvkxSZmUzx8c4A5
         lD2u8ziJ2UqK1f4I7MBftZtoEhqvUEdkGKA8RNuEl+vRht4XDRjzbaHGBLr3bQGrajhM
         kYVEjBiem6GG33SQBKBuH3F/xFarH2WQVLvtGFovR5n1y1+AbJXxundMxbmuSPvfLlUL
         p8SA==
X-Gm-Message-State: AAQBX9d2LygGWIQBhtwl1J/qpr7qUU1dBdgwo04tvaNnnzhZduIu1XdQ
        3AzGJHXuubUkRKHLpyi4P9Y=
X-Google-Smtp-Source: AKy350agHdXEnenUeIKkyBX5s87gm3E29BhXOq6syhGfdpmGCZ8I0JFt4vEj810whEGRo1V/rkG4Sg==
X-Received: by 2002:adf:f30a:0:b0:2f1:78ca:cdea with SMTP id i10-20020adff30a000000b002f178cacdeamr9726712wro.52.1682339336905;
        Mon, 24 Apr 2023 05:28:56 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d5246000000b002fe87e0706bsm10662937wrc.97.2023.04.24.05.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 05:28:55 -0700 (PDT)
Message-ID: <16cf2101-b9ba-154a-9932-3115e2447c82@gmail.com>
Date:   Mon, 24 Apr 2023 14:28:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/2] pwm: mediatek: Add support for MT7981
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-pwm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        John Crispin <john@phrozen.org>
References: <cover.1682007088.git.daniel@makrotopia.org>
 <7f404164337a2e06a6026c5c7e066e0cfba1fb32.1682007088.git.daniel@makrotopia.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <7f404164337a2e06a6026c5c7e066e0cfba1fb32.1682007088.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/04/2023 01:23, Daniel Golle wrote:
> The PWM unit on MT7981 uses different register offsets than previous
> MediaTek PWM units. Add support for these new offsets and add support
> for PWM on MT7981 which has 3 PWM channels, one of them is typically
> used for a temperature controlled fan.
> While at it, also reorder pwm_mediatek_of_data entries to restore
> alphabetic order.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/pwm/pwm-mediatek.c | 39 ++++++++++++++++++++++++++++++--------
>   1 file changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index 5b5eeaff35da6..7a51d210a8778 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -38,6 +38,7 @@ struct pwm_mediatek_of_data {
>   	unsigned int num_pwms;
>   	bool pwm45_fixup;
>   	bool has_ck_26m_sel;
> +	const unsigned int *reg_offset;
>   };
>   
>   /**
> @@ -59,10 +60,14 @@ struct pwm_mediatek_chip {
>   	const struct pwm_mediatek_of_data *soc;
>   };
>   
> -static const unsigned int pwm_mediatek_reg_offset[] = {
> +static const unsigned int mtk_pwm_reg_offset_v1[] = {
>   	0x0010, 0x0050, 0x0090, 0x00d0, 0x0110, 0x0150, 0x0190, 0x0220
>   };
>   
> +static const unsigned int mtk_pwm_reg_offset_v2[] = {
> +	0x0080, 0x00c0, 0x0100, 0x0140, 0x0180, 0x01c0, 0x0200, 0x0240
> +};
> +
>   static inline struct pwm_mediatek_chip *
>   to_pwm_mediatek_chip(struct pwm_chip *chip)
>   {
> @@ -111,7 +116,7 @@ static inline void pwm_mediatek_writel(struct pwm_mediatek_chip *chip,
>   				       unsigned int num, unsigned int offset,
>   				       u32 value)
>   {
> -	writel(value, chip->regs + pwm_mediatek_reg_offset[num] + offset);
> +	writel(value, chip->regs + chip->soc->reg_offset[num] + offset);
>   }
>   
>   static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
> @@ -285,60 +290,77 @@ static const struct pwm_mediatek_of_data mt2712_pwm_data = {
>   	.num_pwms = 8,
>   	.pwm45_fixup = false,
>   	.has_ck_26m_sel = false,
> +	.reg_offset = mtk_pwm_reg_offset_v1,
>   };
>   
>   static const struct pwm_mediatek_of_data mt6795_pwm_data = {
>   	.num_pwms = 7,
>   	.pwm45_fixup = false,
>   	.has_ck_26m_sel = false,
> +	.reg_offset = mtk_pwm_reg_offset_v1,
>   };
>   
>   static const struct pwm_mediatek_of_data mt7622_pwm_data = {
>   	.num_pwms = 6,
>   	.pwm45_fixup = false,
>   	.has_ck_26m_sel = true,
> +	.reg_offset = mtk_pwm_reg_offset_v1,
>   };
>   
>   static const struct pwm_mediatek_of_data mt7623_pwm_data = {
>   	.num_pwms = 5,
>   	.pwm45_fixup = true,
>   	.has_ck_26m_sel = false,
> +	.reg_offset = mtk_pwm_reg_offset_v1,
>   };
>   
>   static const struct pwm_mediatek_of_data mt7628_pwm_data = {
>   	.num_pwms = 4,
>   	.pwm45_fixup = true,
>   	.has_ck_26m_sel = false,
> +	.reg_offset = mtk_pwm_reg_offset_v1,
>   };
>   
>   static const struct pwm_mediatek_of_data mt7629_pwm_data = {
>   	.num_pwms = 1,
>   	.pwm45_fixup = false,
>   	.has_ck_26m_sel = false,
> +	.reg_offset = mtk_pwm_reg_offset_v1,
>   };
>   
> -static const struct pwm_mediatek_of_data mt8183_pwm_data = {
> -	.num_pwms = 4,
> +static const struct pwm_mediatek_of_data mt7981_pwm_data = {
> +	.num_pwms = 3,
>   	.pwm45_fixup = false,
>   	.has_ck_26m_sel = true,
> +	.reg_offset = mtk_pwm_reg_offset_v2,
>   };
>   
> -static const struct pwm_mediatek_of_data mt8365_pwm_data = {
> -	.num_pwms = 3,
> +static const struct pwm_mediatek_of_data mt7986_pwm_data = {
> +	.num_pwms = 2,
>   	.pwm45_fixup = false,
>   	.has_ck_26m_sel = true,
> +	.reg_offset = mtk_pwm_reg_offset_v1,
>   };
>   
> -static const struct pwm_mediatek_of_data mt7986_pwm_data = {
> -	.num_pwms = 2,
> +static const struct pwm_mediatek_of_data mt8183_pwm_data = {
> +	.num_pwms = 4,
> +	.pwm45_fixup = false,
> +	.has_ck_26m_sel = true,
> +	.reg_offset = mtk_pwm_reg_offset_v1,
> +};
> +
> +static const struct pwm_mediatek_of_data mt8365_pwm_data = {
> +	.num_pwms = 3,
>   	.pwm45_fixup = false,
>   	.has_ck_26m_sel = true,
> +	.reg_offset = mtk_pwm_reg_offset_v1,
>   };
>   
>   static const struct pwm_mediatek_of_data mt8516_pwm_data = {
>   	.num_pwms = 5,
>   	.pwm45_fixup = false,
>   	.has_ck_26m_sel = true,
> +	.reg_offset = mtk_pwm_reg_offset_v1,
>   };
>   
>   static const struct of_device_id pwm_mediatek_of_match[] = {
> @@ -348,6 +370,7 @@ static const struct of_device_id pwm_mediatek_of_match[] = {
>   	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
>   	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
>   	{ .compatible = "mediatek,mt7629-pwm", .data = &mt7629_pwm_data },
> +	{ .compatible = "mediatek,mt7981-pwm", .data = &mt7981_pwm_data },
>   	{ .compatible = "mediatek,mt7986-pwm", .data = &mt7986_pwm_data },
>   	{ .compatible = "mediatek,mt8183-pwm", .data = &mt8183_pwm_data },
>   	{ .compatible = "mediatek,mt8365-pwm", .data = &mt8365_pwm_data },
