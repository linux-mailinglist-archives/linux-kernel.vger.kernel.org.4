Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59D06E09CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjDMJK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjDMJKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:10:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDCAA279;
        Thu, 13 Apr 2023 02:09:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j11so17132804wrd.2;
        Thu, 13 Apr 2023 02:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681376951; x=1683968951;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=znt0aWAGbZ2cEMuIGsMFVmr5B4zvykH1K8cbHmpYw3c=;
        b=oT2GSp5inUWHvaFcb5vzUMQY5IyfZpf8HJPlNqPRh86GaPAqAqjVsvyj7iXjYcBf9H
         vuYf4FYZHdECKA/D5frVJFIJ7ZsbOcMTzwyjh8ohd9Gu9cCEgZLmFMynfTjYpytniGux
         JnOhmh9kGDEMJYlJrcT4WbP1Is/apfmclUTqn0f0O/5f/F++ituguozUBvBoWq8rg+qK
         dRcWgY4iJ88jGCwNdfzZoGQgCzkr+fV5iayBfjREwAH9HKYSb6j/fX0xOiGsw2w159CB
         zXILUPMdcpENefj0fabn0vzb8gLlLRchXQi6Q5g5mKEaWQIBnnnBmm8Lr4QdJE6qTYDn
         oKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681376951; x=1683968951;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=znt0aWAGbZ2cEMuIGsMFVmr5B4zvykH1K8cbHmpYw3c=;
        b=OcCSRIALy2fLIPH55/4z/WwhsX+yCQs0JiQ18WAb4dHQ2/zWO3H5rX5VedMvKDtUX5
         OASKgiGaF5NI23itQf5W2nhS59Cot7nS4MwjaoFRALz5BpQrDowUOYlnW4AUUKUrRv/B
         Z3ima0gUXLjqV/nbg+RyTiRz0zZRNg/No3nVgNbKSWRAtRNvAp7Bw5yp7pvu4nVkkcFh
         1mcauR5DQ07hacj/NhVkx+FHkFLrWqkZ6yAY1AwrqH7NojEcoSwXHypvDSlxM+LKJL/f
         +//TtyVM368RfLlWo8QQIMX6xHKP7CxKKzGfzvx9iA5oKzPWRDxjOiEz7lZ40DLTJjyo
         WwpQ==
X-Gm-Message-State: AAQBX9dZJf5hPvjtN+bPA1TXpeOUdJxBPkWuLKUWJlMhoUxvxC8nuOWZ
        hL7C/Sy9tdYVAGOl5D6DObjcGgyBZPth2g==
X-Google-Smtp-Source: AKy350a9Jsb9eHUuXMFUQ8nkCXFBCQ0OfR4SBVZ0IW9wf1SOpkikmocwd4Zx2WVKOnXSNJgkEI21/w==
X-Received: by 2002:adf:ebd2:0:b0:2cf:e710:a4b9 with SMTP id v18-20020adfebd2000000b002cfe710a4b9mr982347wrn.32.1681376950951;
        Thu, 13 Apr 2023 02:09:10 -0700 (PDT)
Received: from [192.168.0.32] ([37.222.243.26])
        by smtp.gmail.com with ESMTPSA id m14-20020a056000008e00b002c71b4d476asm812342wrx.106.2023.04.13.02.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 02:09:09 -0700 (PDT)
Message-ID: <015f4c60-ed77-9e1f-8a6b-cda6e4f6ac93@gmail.com>
Date:   Thu, 13 Apr 2023 11:09:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/3] drm/mediatek: dsi: Add dsi cmdq_ctl to send panel
 initial code
Content-Language: en-US
To:     xinlei.lee@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jitao.shi@mediatek.com, shuijing.li@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1681366162-4949-1-git-send-email-xinlei.lee@mediatek.com>
 <1681366162-4949-4-git-send-email-xinlei.lee@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <1681366162-4949-4-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/04/2023 08:09, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> For mt8188, add dsi cmdq reg control to send long packets to panel initialization.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_dsi.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 500a3054282d..cbfe5df4647c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -86,6 +86,7 @@
>   
>   #define DSI_CMDQ_SIZE		0x60
>   #define CMDQ_SIZE			0x3f
> +#define CMDQ_SIZE_SEL			BIT(15)
>   
>   #define DSI_HSTX_CKL_WC		0x64
>   
> @@ -178,6 +179,7 @@ struct mtk_dsi_driver_data {
>   	const u32 reg_cmdq_off;
>   	bool has_shadow_ctl;
>   	bool has_size_ctl;
> +	bool cmdq_long_packet_ctl;
>   };
>   
>   struct mtk_dsi {
> @@ -965,6 +967,11 @@ static u32 mtk_dsi_recv_cnt(u8 type, u8 *read_data)
>   	return 0;
>   }
>   
> +static void mtk_dsi_cmd_packet_ctl(struct mtk_dsi *dsi)
> +{
> +	mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE_SEL, CMDQ_SIZE_SEL);
> +}
> +
>   static void mtk_dsi_cmdq(struct mtk_dsi *dsi, const struct mipi_dsi_msg *msg)
>   {
>   	const char *tx_buf = msg->tx_buf;
> @@ -996,6 +1003,8 @@ static void mtk_dsi_cmdq(struct mtk_dsi *dsi, const struct mipi_dsi_msg *msg)
>   
>   	mtk_dsi_mask(dsi, reg_cmdq_off, cmdq_mask, reg_val);
>   	mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE, cmdq_size);
> +	if (dsi->driver_data->cmdq_long_packet_ctl)
> +		mtk_dsi_cmd_packet_ctl(dsi);

Why don't you put the onliner
mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE_SEL, CMDQ_SIZE_SEL);
directly here. Please help me understand why adding another indirection is 
usefull here.

Best regards,
Matthias

>   }
>   
>   static ssize_t mtk_dsi_host_send_cmd(struct mtk_dsi *dsi,
> @@ -1200,18 +1209,21 @@ static const struct mtk_dsi_driver_data mt8183_dsi_driver_data = {
>   	.reg_cmdq_off = 0x200,
>   	.has_shadow_ctl = true,
>   	.has_size_ctl = true,
> +	.cmdq_long_packet_ctl = false,
>   };
>   
>   static const struct mtk_dsi_driver_data mt8186_dsi_driver_data = {
>   	.reg_cmdq_off = 0xd00,
>   	.has_shadow_ctl = true,
>   	.has_size_ctl = true,
> +	.cmdq_long_packet_ctl = false,
>   };
>   
>   static const struct mtk_dsi_driver_data mt8188_dsi_driver_data = {
>   	.reg_cmdq_off = 0xd00,
>   	.has_shadow_ctl = true,
>   	.has_size_ctl = true,
> +	.cmdq_long_packet_ctl = true,
>   };
>   
>   static const struct of_device_id mtk_dsi_of_match[] = {
