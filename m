Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC9D5B9F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiIOQAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiIOP73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:59:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FA552821
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:59:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g3so10671458wrq.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=t0i/TBZDs7elMmSaK59d+TIsx+y7LWOVQuu86421qJg=;
        b=XyXui7x1eEUDQwQQYrglR5eB3aj/RM0yZ3vcjpOHBJXQ80mfYNO1sTXtlv++vne7JK
         /Mb/Gftu6+B1z//gjd9lA9w+3EskiTjR6GrT7VbfPgr8ANZ0NQS/jebJwk/HfeNa1Zda
         cZUrqR8WgC5m8Ji2tNo7qCIu2tqH3xb97rIUsEvPCDgLx71HziJjgH73WlUiIJahQ3jQ
         Q8EieUvvkme3gKk3atiXyHnvglkX8hlJtqMig2juqtb2tvbp0M+Tsmq1VTpsrErPWgaY
         irarFeT8Mcy0NfVUqciaE7pIi1+1tr4hg/t8/EBNNYe53xpssacCXSIjZsl9GO2pMdtn
         kSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=t0i/TBZDs7elMmSaK59d+TIsx+y7LWOVQuu86421qJg=;
        b=vUHJ5+0U4sRYCsP/3arJTn14WqgV95/X6g5mUsIW8N8UjhZQLZTgZVxhhPJGjVQPvp
         0WV56Tz6qBjFW3WBcRRDTaXeBilblrbfknbNyUsbh6ECXUm7U1dF/hKGnt7HzCLPAUqa
         tglIlvV8bR3+uK3ECmfeAnlGwGEzfKaihbwFXRo7YV94/2T+cPV6OuvFzutJ7W0nL+f4
         jOx+seVBzNw5fY4mHtMeVb5zs5yL6m3RttedYbCS2uGxEhJEwgN43/rG8wpNpubKo0Ok
         jPsAYVQwJ7LpgoulndsXVmshw7p2dcmS+R7YvQS49UE1T9K5TpCcRfN86QIe4FcB4Nii
         K6Mg==
X-Gm-Message-State: ACrzQf1I9BVyvw5QVPvL5JbrD8sqsSB2nBAiEKsIh10njW66DDG9i9C8
        sM26AI1MYbcFQ609ZHhiKUg=
X-Google-Smtp-Source: AMsMyM5/jiNeWYU9WoRMSlLzfCdBR8Xnr6/lfRMXtFiqq8S+1eZjAzfpnQw1yT+m4rqEm6haKmPb+A==
X-Received: by 2002:adf:cc92:0:b0:22a:361c:20b1 with SMTP id p18-20020adfcc92000000b0022a361c20b1mr205701wrj.691.1663257563771;
        Thu, 15 Sep 2022 08:59:23 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c425100b003a62400724bsm3475950wmm.0.2022.09.15.08.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 08:59:22 -0700 (PDT)
Message-ID: <7c2242ff-f526-a305-9d4b-650427a58a9d@gmail.com>
Date:   Thu, 15 Sep 2022 17:59:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 2/3] drm/mediatek: dp: Remove unused register definitions
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie
Cc:     granquet@baylibre.com, daniel@ffwll.ch, jitao.shi@mediatek.com,
        angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com,
        liangxu.xu@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220915075028.644-1-rex-bc.chen@mediatek.com>
 <20220915075028.644-3-rex-bc.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220915075028.644-3-rex-bc.chen@mediatek.com>
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



On 15/09/2022 09:50, Bo-Chen Chen wrote:
> Some definitions in mtk_dp_reg.h are not used, so remove these
> redundant codes.
> 
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/gpu/drm/mediatek/mtk_dp_reg.h | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp_reg.h b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
> index 096ad6572a5e..84e38cef03c2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp_reg.h
> +++ b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
> @@ -153,8 +153,6 @@
>   #define CH_STATUS_1_DP_ENC0_P0_MASK			GENMASK(15, 0)
>   #define MTK_DP_ENC0_P0_3094			0x3094
>   #define CH_STATUS_2_DP_ENC0_P0_MASK			GENMASK(7, 0)
> -#define MTK_DP_ENC0_P0_30A0			0x30a0
> -#define DP_ENC0_30A0_MASK				(BIT(7) | BIT(8) | BIT(12))
>   #define MTK_DP_ENC0_P0_30A4			0x30a4
>   #define AU_TS_CFG_DP_ENC0_P0_MASK			GENMASK(7, 0)
>   #define MTK_DP_ENC0_P0_30A8			0x30a8
> @@ -171,8 +169,6 @@
>   #define MTK_DP_ENC0_P0_312C			0x312c
>   #define ASP_HB2_DP_ENC0_P0_MASK				GENMASK(7, 0)
>   #define ASP_HB3_DP_ENC0_P0_MASK				GENMASK(15, 8)
> -#define MTK_DP_ENC0_P0_3130			0x3130
> -#define MTK_DP_ENC0_P0_3138			0x3138
>   #define MTK_DP_ENC0_P0_3154			0x3154
>   #define PGEN_HTOTAL_DP_ENC0_P0_MASK			GENMASK(13, 0)
>   #define MTK_DP_ENC0_P0_3158			0x3158
> @@ -206,8 +202,6 @@
>   #define SDP_PACKET_TYPE_DP_ENC1_P0_MASK			GENMASK(4, 0)
>   #define SDP_PACKET_W_DP_ENC1_P0				BIT(5)
>   #define SDP_PACKET_W_DP_ENC1_P0_MASK			BIT(5)
> -#define MTK_DP_ENC1_P0_328C			0x328c
> -#define VSC_DATA_RDY_VESA_DP_ENC1_P0_MASK		BIT(7)
>   #define MTK_DP_ENC1_P0_3300			0x3300
>   #define VIDEO_AFIFO_RDY_SEL_DP_ENC1_P0_VAL		2
>   #define VIDEO_AFIFO_RDY_SEL_DP_ENC1_P0_MASK		GENMASK(9, 8)
