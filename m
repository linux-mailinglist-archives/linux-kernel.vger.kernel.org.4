Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1223667B45A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjAYOZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbjAYOZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:25:53 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A146594;
        Wed, 25 Jan 2023 06:25:51 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso1333864wmc.4;
        Wed, 25 Jan 2023 06:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IlIUJxcSdCXYA3OeLTMx+yjKn/rWMjqFuTKoW+FqBqQ=;
        b=ESzuU4Xe/NCTHQj01jK85maPoZaB0fjlWtTTOzzBYWqjXCW1UlPVfIeWfVZ69iUywz
         XDwlochFxYGMmulrlSIJmEJKnyzRQWq2/K7rOX7yFq0SbPXpJd4ziQDak9I4S9UQ1HVw
         IV12wN+ODbqdzDuepL/BbZJW/E/+XF6mV9VseyEb7EV6SD7TybiDHpezYCJS1QcQ7HIV
         KpitgM/ULJx3FH9SlGaAFw8DeSusleSe/iWfoFtg1DV3D7HUQwHv4dazXdwLWC4dQMMP
         oA+4IKuoLFkhP0E0ophBN0cQriw8drJug0/m/AWmIja6O6wnNcylAht+Y21UdXCzFSWd
         29KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IlIUJxcSdCXYA3OeLTMx+yjKn/rWMjqFuTKoW+FqBqQ=;
        b=NFppMG8GpeWNp0EjiM6ivGFSalkQ6ZGdNkl5yj57ulP3tNoGcYXDNr5nlVT1xWKzzz
         PMY8XvlLd4gRSXblGXa+hZq8yeuDMpVdntloS1fOAvs0yJtJ0Cuml52+Qd0Lo4Y5RVff
         cBGGmL5PBIkRsCB5nG4Fhmzc6GTctBvORC2CYhJWi3nlcMWGyB7sC+6tFybLv43A8tS7
         ZFRNe/TSMvy04HryFVbITRL4mMhOTEJw6sXCbjUbW/5Rv7SgOG5Sgr1R1lC/AP+5FHHU
         Tcw3DeSz7ebDfk0xzwZqImWof/b1QTFTgoW1zIoBKHjdP35+FDSrn759swfdzUSe2alb
         R9fQ==
X-Gm-Message-State: AFqh2kofAvh8rLt89KDodhclj8XF0jrEP+fBoMLWty4oMvuU62Cr+I0y
        teOOo/2Z7dQgW2agwhDmwtO0OmHgTSY=
X-Google-Smtp-Source: AMrXdXtJkYCfBZ98bJpRNPlgWcGmh8+LeAgVJB+l0cf5KmxTT+BJsZJRK7/wmRdZG8sq/rwhaW2/tw==
X-Received: by 2002:a05:600c:5021:b0:3d9:9755:d659 with SMTP id n33-20020a05600c502100b003d99755d659mr32006876wmr.22.1674656749638;
        Wed, 25 Jan 2023 06:25:49 -0800 (PST)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id r4-20020a5d4e44000000b0027cb20605e3sm4574996wrt.105.2023.01.25.06.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 06:25:49 -0800 (PST)
Message-ID: <104bb37e-55c3-8dd0-f501-0e8a142511e6@gmail.com>
Date:   Wed, 25 Jan 2023 15:25:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v11 3/6] arm64/dts/mt8195: Add efuse node to mt8195
Content-Language: en-US
To:     bchihi@baylibre.com, daniel.lezcano@linaro.org,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230124131717.128660-1-bchihi@baylibre.com>
 <20230124131717.128660-4-bchihi@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230124131717.128660-4-bchihi@baylibre.com>
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



On 24/01/2023 14:17, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add efuse node.
> This will be required by the thermal driver to get the calibration data.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

I fixed the subject prefix to:
arm64: dts: mt8195: ...
to be in line with other commits.
Please take that into account for future patches you send.

Applied thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 5d31536f4c48..09df105f4606 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1380,6 +1380,12 @@ pciephy_glb_intr: pciephy-glb-intr@193 {
>   			dp_calibration: dp-data@1ac {
>   				reg = <0x1ac 0x10>;
>   			};
> +			lvts_efuse_data1: lvts1-calib@1bc {
> +				reg = <0x1bc 0x14>;
> +			};
> +			lvts_efuse_data2: lvts2-calib@1d0 {
> +				reg = <0x1d0 0x38>;
> +			};
>   		};
>   
>   		u3phy2: t-phy@11c40000 {
