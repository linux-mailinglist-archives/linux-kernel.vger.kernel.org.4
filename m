Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D5F673F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjASQjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjASQjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:39:04 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C4359E4E;
        Thu, 19 Jan 2023 08:39:03 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id n7so2434621wrx.5;
        Thu, 19 Jan 2023 08:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cFccX0iQGUkPDvHxdXm2Dg7nOAysUilW9CKtDUmJ0cw=;
        b=I81c7RERXKi+udhauEcEapckO0k8IyPli493C0u5Ry877Fr6qBEqIDv+107R/2YV0h
         RGBlf2WitbBBsk37ywG476iJ9O+F7Ci929YlrSK1e+hBMpiAkqTTdCsCi3XNsanqq2oj
         dFrpAaSLyXY4t7eeUzkB2MdTb7ye6RkvXeqiE6MZxsmjwrFoMK9i1cMdtBm73+bfB7Kf
         AzGl92rNdOnzGoGsfuf7R/ygb48lad37rsjD/i0oJJR1zzz3lwIsXOJ4Jt5eueFugZVK
         P161mwGSEDjTtvGcq9JeTcbSxHXW9D2U7+ke9NCbCNatoPaXSBtR7qhwgR+N6COXKvxP
         jgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFccX0iQGUkPDvHxdXm2Dg7nOAysUilW9CKtDUmJ0cw=;
        b=foXv0F5vvte517xFQY1s6HHdrHsissYQxnhLzDqUmB+OLDe2a3lGpKWKKm8fBk/ybF
         hVo7gburoeUii80Xlwd6i48FtJKPvNZbDwCtnq0VTaT5UdfAw0vssuwKarPcnbM0p9U3
         Jq8BZ102+Gy5F5PJGclui9ICAREoSqb9z6pKJPfmwiU4a6B9O/tP2OLSrLcVZCjCLsb2
         OEvHBzX9wnbIsHbl4tmXyhhAdceVg7C9BgSHcVvN6X3TeN5JAYVqsZ1xDMHLQ3EuxK2G
         c9+WJv1W+oKnWfBPmhbhT+FXkUzVii6CSSTzpSKRO+oZXwD6qrwW1wcRljw5fdl704LS
         sVdQ==
X-Gm-Message-State: AFqh2kpcHslBxKu9du0N5euguoDPT7XedMsnttqkjYbVz3xSz8AW8irV
        UhxbARp5cFZ7b2e+nB5i318=
X-Google-Smtp-Source: AMrXdXvnv3Mh0kiEG2JAGXOY0znP12LMrjnWY7tdftGlWSZFodg0/DJdtw6YlWjdWjtRZfMIz2R3Hw==
X-Received: by 2002:adf:df10:0:b0:2bb:e891:1829 with SMTP id y16-20020adfdf10000000b002bbe8911829mr10242278wrl.4.1674146341814;
        Thu, 19 Jan 2023 08:39:01 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4bc6000000b0027323b19ecesm33836836wrt.16.2023.01.19.08.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 08:39:01 -0800 (PST)
Message-ID: <572b472b-088b-4ebe-0b52-927736199f70@gmail.com>
Date:   Thu, 19 Jan 2023 17:38:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 7/9] arm64: dts: mediatek: mt8186: Add DPI node
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org
References: <20230118091829.755-1-allen-kh.cheng@mediatek.com>
 <20230118091829.755-8-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230118091829.755-8-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2023 10:18, Allen-KH Cheng wrote:
> Add DPI node for MT8186 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index c52f9be1e750..45b9d6777929 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -1230,6 +1230,23 @@
>   			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
>   		};
>   
> +		dpi: dpi@1400a000 {
> +			compatible = "mediatek,mt8186-dpi";
> +			reg = <0 0x1400a000 0 0x1000>;
> +			clocks = <&topckgen CLK_TOP_DPI>,
> +				 <&mmsys CLK_MM_DISP_DPI>,
> +				 <&apmixedsys CLK_APMIXED_TVDPLL>;
> +			clock-names = "pixel", "engine", "pll";
> +			assigned-clocks = <&topckgen CLK_TOP_DPI>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_TVDPLL_D2>;
> +			interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_LOW 0>;
> +			status = "disabled";
> +
> +			port {
> +				dpi_out: endpoint { };
> +			};
> +		};
> +
>   		dsi0: dsi@14013000 {
>   			compatible = "mediatek,mt8186-dsi";
>   			reg = <0 0x14013000 0 0x1000>;
