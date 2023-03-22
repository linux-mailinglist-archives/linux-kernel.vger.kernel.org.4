Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3562B6C4509
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCVIev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCVIep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:34:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D5533471
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:34:30 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cn12so23912147edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679474068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBL11i9fNS27loi0emWBWEgDr/mEHlYTAb/S8cELX2g=;
        b=hIjnO2BduDViVVsMJOLDv81RmGXZTyW11ztNDNTpZkRRUmoQFOdLABlIf2bBNZDoyt
         AIZ5psXlw6W6M4qkGW9j4gFmkcCeQkuw68dmC5wJ3MLFe5aZdBiQDDu3nrdNb9b9331C
         FXh75HJHNI8nAH4cOmDxinBSa2gq1OaUI0DoCsiiRjazHfFBr4GFBzCpthPPMwiwuiT7
         oFxcoqVdogxDLw7GjaM8BPYOAtuU1w2PYcv9lQC84/185oMdnqThskZ+9XON7wpEswX7
         7N6rD3wKmZ48G5ycOV+fax7DqXjbBN8eW5944xyZB4JiLLt24CpOxHCERSbSaz2tiI7U
         AhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679474068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBL11i9fNS27loi0emWBWEgDr/mEHlYTAb/S8cELX2g=;
        b=Dzt5sc7GQrKzuPTrZ54ahOomIknoOgdC9IgFa6zv2s8+hKrfzGNL8ftYX+MuqE9Don
         tSPTl4PmYcRKq32a4SBz6LUntUrh2oHRYg3RYKFVwj8Xbex5hl7P2A9NQ5/hoxTtUoPO
         69GC6xFdFFvhvLoHjO7CL4XYqUleAy7Y+wuXGOMglMgLRaC8LbDEXArka0vPobbfYUMk
         ihhVDs/Licj+OwBuD8lLm1u5YQPl6czs+LXtSPHjIq5eSsGN+m9mSni6WVkfHp30nxxM
         8RDDZ7jp6AY+X2SK72ez+pPJrQpTa4RNjDqeFXBfFkuMp4RFuj6o33QUzzMSouaea4tz
         pdLg==
X-Gm-Message-State: AO0yUKUiUAIZZZEgjjQaikEklbBjNtyU30KJaZqaGjWKt4LiPHauYm05
        CrKc/+rG1Y47Bf0YiFNxFjPbhA==
X-Google-Smtp-Source: AK7set/RU9ipTFuWd8LW1NBalKnVQgSATdNpWtPSW0Sl1wR/ejVp2PL48iiRRMJ7g8DTcDY0vYEfig==
X-Received: by 2002:a17:906:b007:b0:931:d277:78a4 with SMTP id v7-20020a170906b00700b00931d27778a4mr6126792ejy.30.1679474068490;
        Wed, 22 Mar 2023 01:34:28 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5050:151b:e755:1c6? ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id qx20-20020a170906fcd400b008eaf99be56esm6997168ejb.170.2023.03.22.01.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 01:34:27 -0700 (PDT)
Message-ID: <83eb4c5c-b4ea-1fee-7212-c88821b90771@linaro.org>
Date:   Wed, 22 Mar 2023 09:34:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/2] dt-bindings: reset: mt8188: Add reset control for
 DSI0
Content-Language: en-US
To:     Shawn Sung <shawn.sung@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230322032202.12598-1-shawn.sung@mediatek.com>
 <20230322032202.12598-2-shawn.sung@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230322032202.12598-2-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 04:22, Shawn Sung wrote:
> Add reset control for DSI0.
> 
> Signed-off-by: Shawn Sung <shawn.sung@mediatek.com>
> ---
>  include/dt-bindings/reset/mt8188-resets.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/mt8188-resets.h b/include/dt-bindings/reset/mt8188-resets.h
> index 377cdfda82a9..5c9e74130ef0 100644
> --- a/include/dt-bindings/reset/mt8188-resets.h
> +++ b/include/dt-bindings/reset/mt8188-resets.h
> @@ -33,4 +33,7 @@
> 
>  #define MT8188_TOPRGU_SW_RST_NUM               24
> 
> +/* VDOSYS0 */
> +#define MT8188_VDO0_RST_DSI0                   21

Why this is not 0? IDs start from 0.

Best regards,
Krzysztof

