Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874B45F507F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiJEH52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJEH5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:57:22 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB6767CAF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 00:57:21 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bp15so10954507lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 00:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=D2ARNbWjWzrWSLd7BzhUTLcCyzjmT3yUMhwTkpGSXDA=;
        b=iCaQ5UjcHDNNPJYrlcmZHhEPHRd+reQ0eq2/8cdYJl0qEH2pPsz/HIGTbIjSdHM/wT
         YuwBAUuaOKD1iTOHehb0jBNUDbI199fFOp826jQxaOXYQ9dAMbh52D3y3+7LyO1TtkvW
         iMAlSe4eRyRhDYwG+LXh8jlU7ypmbdQUgh5SVdjGR3AJMeRI4iU7fTZxGEi92C68GayW
         pA2fkAW7SfgZSavya0NQKeCpsZ0rTzxItOy00KnyFAkcN5+YF770DK9SA8Rw+OVITKPD
         qQLfIHURg4h+pL4xKLw6Yfb1Vo8WgrkJ5A4PxsePTfdXufvorKBv+evGctOokFsmp0Gh
         yoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=D2ARNbWjWzrWSLd7BzhUTLcCyzjmT3yUMhwTkpGSXDA=;
        b=L1FZiMpH6dgHnBGVtDGDm18BKRVtY5NNnfsXnuOmHj/Nclqx9kp8f63H2EpMkfSKMk
         6kG4W1bZ6z/rFM288FSm9ukOhFj48IAWkW28pd28ek1wuwxnP49k9DeKON20uotAZHBg
         +6nUINBOSuQpyQA6SP19G8+sJF0XRBeTKdDvidItPWTWlwaMnmjkPtvCcXa5b9/CFHFG
         SAMinkf+cQMn87jXtzTpXF9tuQH4krWEesbJ6FFhQqV68cQIjopEA1KqAv1QWrEmlQGA
         MQ4eCqXrbNcyyfjltwlcXI191l2ylUevVo8Isj2pfeWmeP+Yu7Si95LksnfJg7xgJjOR
         gs/A==
X-Gm-Message-State: ACrzQf24anjTpH5/pMiaplM/mp5iQKBRc6VqDHq/ie/jp+0HAWyFOEQJ
        e/DbmBxZyHzgn7W+HphNaeVykg==
X-Google-Smtp-Source: AMsMyM6EyDGQavd2wdukmVY8QwvLxO38/5hzfrh/8YLOQNbUIA620QQPwUeain0Cr1kIDxEJeYPs6g==
X-Received: by 2002:a19:f809:0:b0:4a2:2db5:8c41 with SMTP id a9-20020a19f809000000b004a22db58c41mr5387256lff.179.1664956639977;
        Wed, 05 Oct 2022 00:57:19 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b0049465afdd38sm2259888lfb.108.2022.10.05.00.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 00:57:19 -0700 (PDT)
Message-ID: <2665abdb-cc0b-dd88-a545-a76ac05d7448@linaro.org>
Date:   Wed, 5 Oct 2022 09:57:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 2/6] dts: arm64: mt8195: add MMSYS and MUTEX
 configuration for VPPSYS
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
References: <20221004093319.5069-1-moudy.ho@mediatek.com>
 <20221004093319.5069-3-moudy.ho@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221004093319.5069-3-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 11:33, Moudy Ho wrote:
> From: "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
> 
> Compatible names of VPPSYS0 and VPPSYS1 should be renamed to
> "mediatek,mt8195-mmsys" to match the description of the binding file.
> Also, add two nodes for MT8195 VPPSYS0/1 MUTEX.
> 
> Signed-off-by: Roy-CW.Yeh <roy-cw.yeh@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 905d1a90b406..7f54fa7d0185 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1477,11 +1477,20 @@
>  		};
>  
>  		vppsys0: clock-controller@14000000 {
> -			compatible = "mediatek,mt8195-vppsys0";
> +			compatible = "mediatek,mt8195-mmsys";

This does not look like matching bindings. Last patch for bindings was
requiring this to be prepended with vdosys0 and followed with syscon.

Best regards,
Krzysztof

