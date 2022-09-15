Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF605B9F75
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiIOQPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiIOQPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:15:14 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B441985F84;
        Thu, 15 Sep 2022 09:15:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sb3so13644221ejb.9;
        Thu, 15 Sep 2022 09:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=v2ge41u1gkNzSONdXiyudp7Lzl9Dg/unbQXBLoKq9hU=;
        b=iTCO8J125qCrTxA0iFg+H1CARAxPJgyE9NsRJLpA9r9D8bUaWWeCK6S9k7gqxcj3Nm
         Mu7zY/+rEaZgFvF3wjEs/FobHCbKxmsrSWVf9uhjW17ucx/0cyp/Q1ib2FTk8xzczHyY
         ywJAEAqZ07B2QbbqEHtOqHcHlhepNzIDpIuWqG5sVY/6MsZdOJTd9iu6/71j0DNuiYCD
         enZgampz2rDAFbxE+wZj6ogxF96aNxELSuA1qe30H78lJ2taZaCIVIZS+CG8+ggfmQc1
         cyqx6sWFRvF8/8pLFsW8rTlRDV9dcEw+dm2byuljsDKAO+PVEInoQ4LjchdJHhRI/ul9
         ktjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=v2ge41u1gkNzSONdXiyudp7Lzl9Dg/unbQXBLoKq9hU=;
        b=l7IiitGP5ga1vkWiNwLI2WDd8SzrRRqHLYWpg7pTshdqzldo84jGwrmsdwt6iW0ncj
         A/cLhCHRDoqhKH1l8XAtfq/zVj/pUWwm+XNYUsd75wH5KegWnMU9ee1YNd8t6hVRLGCf
         Q/SMZyoX7c738uRGmQbhMSwBucWVnst+FdiPzKzX3YhifPHD8oqtlCHSmhzSOtR2t77t
         Rqun7XBz2o+5fYmVztD0GfGwnSp9qXZKxonRgCUN/m//QwFsiIaJ8vV6jveZrEAQFmGZ
         SvZbBi4V7oC0dE/SXHVBMvbiCNTGqd2B9BW/rBRB8v875g0dzXAf59x86xlvXI+AtMkN
         O+cg==
X-Gm-Message-State: ACrzQf2VX2KSPNAL681E0Jlk5CEyzLf5ybbWQfWAfpdWXLBKgohMkxUZ
        BJehxnjhJXfiAleRlVEB2Gg=
X-Google-Smtp-Source: AMsMyM5GrGz4GNx2hR374vuxPTyGV4EiiDxDSFGeIzTW/B5ABJzPFHP6RC1/GJ37AU08z/DjL8FVuA==
X-Received: by 2002:a17:907:3e89:b0:779:4869:b799 with SMTP id hs9-20020a1709073e8900b007794869b799mr467545ejc.91.1663258507015;
        Thu, 15 Sep 2022 09:15:07 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id r9-20020a1709061ba900b007413360a48fsm9224878ejg.50.2022.09.15.09.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 09:15:05 -0700 (PDT)
Message-ID: <1fd48fa0-66eb-5af9-6168-d1df602216a5@gmail.com>
Date:   Thu, 15 Sep 2022 18:15:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 4/5] arm64: dts: change compatible of vdosys0 and vdosys1
 for mt8195
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
References: <20220914182331.20515-1-jason-jh.lin@mediatek.com>
 <20220914182331.20515-5-jason-jh.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220914182331.20515-5-jason-jh.lin@mediatek.com>
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



On 14/09/2022 20:23, Jason-JH.Lin wrote:
> For previous MediaTek SoCs, such as MT8173, there are 2 display HW
> pipelines binding to 1 mmsys with the same power domain, the same
> clock driver and the same mediatek-drm driver.
> 
> For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines binding to
> 2 different power domains, different clock drivers and different
> mediatek-drm drivers.
> 
> Moreover, Hardware pipeline of VDOSYS0 has these components: COLOR,
> CCORR, AAL, GAMMA, DITHER. They are related to the PQ (Picture Quality)
> and they makes VDOSYS0 supports PQ function while they are not
> including in VDOSYS1.
> 
> Hardware pipeline of VDOSYS1 has the component ETHDR (HDR related
> component). It makes VDOSYS1 supports the HDR function while it's not
> including in VDOSYS0.
> 
> To summarize0:
> Only VDOSYS0 can support PQ adjustment.
> Only VDOSYS1 can support HDR adjustment.
> 
> Therefore, we need to separate these two different mmsys hardwares to
> 2 different compatibles for MT8195.
> 
> Fixes: b852ee68fd72 ("arm64: dts: mt8195: Add display node for vdosys0")

No fixes tag needed, there is no runtime bug.

Regards,
Matthias

> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 905d1a90b406..6ec6d59a16ec 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1966,7 +1966,7 @@
>   		};
>   
>   		vdosys0: syscon@1c01a000 {
> -			compatible = "mediatek,mt8195-mmsys", "syscon";
> +			compatible = "mediatek,mt8195-vdosys0", "syscon";
>   			reg = <0 0x1c01a000 0 0x1000>;
>   			mboxes = <&gce0 0 CMDQ_THR_PRIO_4>;
>   			#clock-cells = <1>;
> @@ -2101,7 +2101,7 @@
>   		};
>   
>   		vdosys1: syscon@1c100000 {
> -			compatible = "mediatek,mt8195-mmsys", "syscon";
> +			compatible = "mediatek,mt8195-vdosys1", "syscon";
>   			reg = <0 0x1c100000 0 0x1000>;
>   			#clock-cells = <1>;
>   		};
