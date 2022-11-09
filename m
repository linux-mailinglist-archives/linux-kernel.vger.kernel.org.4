Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219BE622A6D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiKILZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiKILZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:25:33 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA971B1E7;
        Wed,  9 Nov 2022 03:25:31 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o4so25300753wrq.6;
        Wed, 09 Nov 2022 03:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7aHBcV/NNodzOnLWHFv0Riu76BmXp6c1Mma1hVG8aM=;
        b=XYam02f3n+s+9rA8MLrmSemGlScqvoMoyF9wLzLKhPcp4FqNR/uN7+e5XwyAviqitk
         cLi0AzRqM8DeNh6XzYcqB3Bjlf0KCgI2pnhMWcqLfCTM3QlDOnyyyQmxA5MgHhrd9kmj
         fT+nY9F1bHt5nyeoQawsO0YiEnLJu4/xWh2P7+joV5gc89rCg20nOlA0zpijWjoByK/Q
         B8ljkLARZUqQmYZ2N/ExbQVrTdgXYj+tQEz3nptPBQPoYbWWRP97/86m8Q889gQFHKEq
         7/aHhW7jEuBZoWCxUnWoOrYFbI0A/E5LoHHTx5cVnBUdnRmF76P/BszM+ef5iQ38pUle
         Xuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7aHBcV/NNodzOnLWHFv0Riu76BmXp6c1Mma1hVG8aM=;
        b=WUoqIo6KbN+hPMFrkrGvXIjpSWyqNaPlJPdXBcBT9r0v7gDy/UuBKOaeZaXBV2i6om
         qjUhQ/PIs1mzRp55MR22sxVJJl5hKEELmdo9JrpS7uDoc35WC4XqMB3vBUVPVDqjEkxJ
         9+OkgJ6t9nKGyotwcmoCLn0Rbj3KbSp29lfFWzmocmhKlGLSuaktllCcYA95+KJlm5A5
         QtaYl4Z2xD/Qmyi6lX4V9yrzWUeDq+MT9YGCiQ3mt2WTqiUZokfNN7af0mnzcEae0UFf
         xO91YbDtsAuhcSATM3apPuIbBHtWSH9lz45dkXeBwyX/+m+hB0J+sW21+ESm+dQ/ZuKO
         2big==
X-Gm-Message-State: ACrzQf0OY26yc3o95jbrpHmrB8K2UybvGM+5CbQH+dUXmFndp7M0vT+s
        slzAWNmAlm91V4+MtMJ1YXo=
X-Google-Smtp-Source: AMsMyM7F9beiptQWeU4dn/9YH5JLDFHVU3Fan7jjQBd5F6TMfl1va8bhwzE+wyiUlb6x39jmOAp+9g==
X-Received: by 2002:adf:f8c2:0:b0:236:9cd1:6748 with SMTP id f2-20020adff8c2000000b002369cd16748mr36855017wrq.283.1667993129624;
        Wed, 09 Nov 2022 03:25:29 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p14-20020adff20e000000b0022e344a63c7sm13030211wro.92.2022.11.09.03.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 03:25:28 -0800 (PST)
Message-ID: <30278e0f-88ec-069b-3469-56b3fb795702@gmail.com>
Date:   Wed, 9 Nov 2022 12:25:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 6/6] soc: mediatek: remove DDP_DOMPONENT_DITHER from
 enum
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220927152704.12018-1-jason-jh.lin@mediatek.com>
 <20220927152704.12018-7-jason-jh.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220927152704.12018-7-jason-jh.lin@mediatek.com>
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



On 27/09/2022 17:27, Jason-JH.Lin wrote:
> After mmsys and drm change DITHER enum to DDP_COMPONENT_DITHER0,
> mmsys header can remove the useless DDP_COMPONENT_DITHER enum.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

Chun-Kuan, I understand you will take this patch through your tree as it depends 
on DRM changes. We can also sync so that I take it once you merged the rest of 
the series. Having vdosys1 series around maybe that's better to avoid merge 
problems.

Regards,
Matthias

> ---
>   include/linux/soc/mediatek/mtk-mmsys.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
> index d2b02bb43768..16ac0e5847f0 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -16,8 +16,7 @@ enum mtk_ddp_comp_id {
>   	DDP_COMPONENT_CCORR,
>   	DDP_COMPONENT_COLOR0,
>   	DDP_COMPONENT_COLOR1,
> -	DDP_COMPONENT_DITHER,
> -	DDP_COMPONENT_DITHER0 = DDP_COMPONENT_DITHER,
> +	DDP_COMPONENT_DITHER0,
>   	DDP_COMPONENT_DITHER1,
>   	DDP_COMPONENT_DP_INTF0,
>   	DDP_COMPONENT_DP_INTF1,
