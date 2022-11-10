Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD2562430F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiKJNRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiKJNRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:17:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28F731DCC;
        Thu, 10 Nov 2022 05:17:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id k8so2238891wrh.1;
        Thu, 10 Nov 2022 05:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3AuGOL+RtsyjgtlhQ1twOTD3QDsCayIE+ZhoLatVnh8=;
        b=RV5fqXf/02xSU+of/wRNHSNDfokXIgvuEIDtcu2kKeQXudcWKZP7riIIAQARrusvVh
         Lkq1O6makjoEtKWWLpH1hPAcpXDsKZB+UvgoZRacC+SDPk0Xil24mAG+ydEyT5jp6XUa
         mhIR1h+1GF9Ms/9qw9vu/rgLJ7G6JVZxmyncSJUiUnKJ9+jNcscqpvoMhAhilt9hp6YQ
         ED2C03XV/n45iW+2+TFaMrPtEpbW5pxd3OtVcrc5/4Q/SEEqJdpbI5IuMiHdv8ZuDOBG
         HdM9FM9X0fkSZOdhZIEM8Vxx4dfH5iVq5dgJd4zL90MLpcDGOWmm55pqsy1VPIyUXZmV
         Vnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3AuGOL+RtsyjgtlhQ1twOTD3QDsCayIE+ZhoLatVnh8=;
        b=cf6hMEG95ER7by9T1o/V7KqhDfkSqIAz9ckk0z7NpMkbls8CRsn46I4uGnRTEIBQNz
         6qlThvOpfF5mTXaWvt+1ymVm3jgvs5cX98dcDTyXOOkdy6W7FomcLr9u0zHOsdgApszb
         113y6io+vgJez4VG0NbOBFZKNrtJA/BznIWDGlgeaISs4+Ub13AIh2TW097I+YCub+Tz
         LrS2UsushgIqOd6cOGBDgSR03HSQzXcYoSHYo5aaiRGVfCdSe3tlT4LmjdV5S533rVOo
         y7T8eM7jrP0siOsLi25uSvXqmGCae5Gj92eM7t27co8QN8F3Rj7fdQ2YN9p7VT0AHOkW
         xU6w==
X-Gm-Message-State: ACrzQf2TG2kYqesfLy0tsdR6nCLhCMuXREH9MtwZXSPdrNSEBw2GFI3d
        QQy0KTdNtBqrqq+zVqKH1u4=
X-Google-Smtp-Source: AMsMyM5u8zbufjcwPB7JaqlJrtf4ezpLmiDlsEYr4/cyk2dW/70P5nxD22butpKFtIHBptJAMs4Xxw==
X-Received: by 2002:a5d:4b11:0:b0:236:4e3c:7720 with SMTP id v17-20020a5d4b11000000b002364e3c7720mr1020738wrq.674.1668086248134;
        Thu, 10 Nov 2022 05:17:28 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id z3-20020a05600c0a0300b003c83465ccbfsm5916631wmp.35.2022.11.10.05.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 05:17:26 -0800 (PST)
Message-ID: <6def7161-d428-a822-59c4-d6012310379e@gmail.com>
Date:   Thu, 10 Nov 2022 14:17:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] arm64: dts: mt7986: fix trng node name
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sam Shih <sam.shih@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20221027151022.5541-1-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221027151022.5541-1-linux@fw-web.de>
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



On 27/10/2022 17:10, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Binding requires node name to be rng not trng:
> 
> trng@1020f000: $nodename:0: 'trng@1020f000' does not match '^rng@[0-9a-f]+$'
> 
> Fixes: 50137c150f5f ("arm64: dts: mediatek: add basic mt7986 support")
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> index 72e0d9722e07..226648f48df2 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> @@ -168,7 +168,7 @@ sgmiisys1: syscon@10070000 {
>   			#clock-cells = <1>;
>   		};
>   
> -		trng: trng@1020f000 {
> +		trng: rng@1020f000 {
>   			compatible = "mediatek,mt7986-rng",
>   				     "mediatek,mt7623-rng";
>   			reg = <0 0x1020f000 0 0x100>;
