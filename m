Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33812690E58
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBIQ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBIQ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:29:00 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0F82ED5A;
        Thu,  9 Feb 2023 08:28:59 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a2so2341017wrd.6;
        Thu, 09 Feb 2023 08:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FzF9eAogvOx6DhR2a91i2ZoPxlv9ZBFly+RK60Plfuc=;
        b=CGmKHpTe1n7CVdM6lIWmn0S2EacNl6DiIqfvZ46zXCE1t4ovO+Qfmt4890hCS/8Lw/
         yHcDfmeDbgxaVNNhCP3DjynNzvL5awS89c88DyvPp+/w9v8asIij8kEVLFFQNntDjW2M
         q94xpenOTSKkSQ7A2LYzv0JwU3q63TrLoks3cpDB4THv0AsMN4HYvUxpHI0qsd+k0qLZ
         H/SghtYKfsORV2zUXNpFZ5UIWEp3p5h5OTveEO6jgbgDkCxjw2WWWNMVJT2CDPPsKAcp
         SjZmMf9oulSx9PI91SiBa0uMsScv2/uVcSttlTix0yY4uVlnc4gudFOIjw+YpQ0+uvR1
         ROtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FzF9eAogvOx6DhR2a91i2ZoPxlv9ZBFly+RK60Plfuc=;
        b=F6mZaozy2unZOEJ6mR5nyivdIoxHcUcaJ5YHDWvUjZr2tZEMpHtnJHb4FSAylmBqLS
         NIsGMhSxIEbL8Mx8QBnow2hBlwKAjD0BLUq3BLcrjujHXvLNyUHkaFMMUN3BY9yFSGkc
         yrNpu94Mt7Q2ftTzy8dgj6CZmxdq6nS4bnhplYYwRHjifW2HBJhi+Gvwa+nszheTU7Hw
         rFw5V6+KWqjEyPzYpY0kb0+DXx+miA0roH4/xa6myQ1IOt3SAYBm8zBdH1ol3j9IvL/k
         tmY5zSmfMfB204/gRa3xfObYwj1zdIwWF9r4FN5ThuMT/xEc3dS7+m/bIk51hnUsAUUY
         DMyA==
X-Gm-Message-State: AO0yUKU4qSj7QfHgLWFhGhHmKIbRoUPUESRqCRdS8HsOgSj4TvMGHWzB
        HFVARA5bqbEXs5XEutYNcVU=
X-Google-Smtp-Source: AK7set/aVmWH+3EhitjZ323M3nNLTEgTNM5fEVmtAeNYKcVFc3as2a5mvQv7SSu8LOsaNId3rbG5uA==
X-Received: by 2002:a5d:595f:0:b0:2c3:db98:3e96 with SMTP id e31-20020a5d595f000000b002c3db983e96mr13264222wri.22.1675960137472;
        Thu, 09 Feb 2023 08:28:57 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l5-20020adfe9c5000000b002c3e7474b0fsm1655208wrn.13.2023.02.09.08.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 08:28:56 -0800 (PST)
Message-ID: <29a867d1-12a7-449f-8d52-aaac7a622c59@gmail.com>
Date:   Thu, 9 Feb 2023 17:28:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v14 3/6] arm64: dts: mt8195: Add efuse node to mt8195
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
References: <20230209105628.50294-1-bchihi@baylibre.com>
 <20230209105628.50294-4-bchihi@baylibre.com>
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230209105628.50294-4-bchihi@baylibre.com>
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



On 09/02/2023 11:56, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add efuse node.
> This will be required by the thermal driver to get the calibration data.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Link: https://lore.kernel.org/r/20230124131717.128660-4-bchihi@baylibre.com
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

This patch is already accepted [1], please drop it from your list.

Regards,
Matthias

[1] https://lore.kernel.org/lkml/104bb37e-55c3-8dd0-f501-0e8a142511e6@gmail.com/

> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 5d31536f4c486..09df105f4606d 100644
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
