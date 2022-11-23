Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F736363B7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbiKWPbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbiKWPam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:30:42 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B434856541;
        Wed, 23 Nov 2022 07:30:04 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso1700966wme.5;
        Wed, 23 Nov 2022 07:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpOfjD7j/Rp783J2m0+A9BpqEQItESEc2TO4AhrSmVA=;
        b=hM3SOVHGwLlws8xrfb0FFcF0Y+5QOgaPSyLYc1uwSz+yG+KoBbD2wWmJPwydUYq49f
         24CZlfTDaWEDi7/+kZX6JTqwPmxZia1M/FoCNnFEYwL6DlcCl60aydfSJ3/jPifz+Wvw
         oi3ra9WuGDYP8p4grhmiRWgs5p/h8QE5Ua8KIrDcONx4k2UqC7MsO+HBnmVXhwNCDU8G
         BBQC1mbrTOe8aq3LESltSYvHyW6paL6LEdulpCkV+oqub0yZs9ifcsNc1hlBiKma5fr3
         v8y8ooj2GhljboAEfygTHATK6lOwUL+Cqbg7WmkqIbuM2KAGXplaK1dynh/kI/LQGEPO
         tENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bpOfjD7j/Rp783J2m0+A9BpqEQItESEc2TO4AhrSmVA=;
        b=Vz/O12Nvo/a/SYXBYze31KiN5QKLcDfI9JqsjphicoBxmpp8cHuArwz0Ad4S3wHtKy
         CJS8Km5I5xCwg6Rl3y9w0IFpI5P22YXmvnL6LNxM0KbqmCPZGFsEMqadaWhcuPwEzKuC
         9E4v2+pHJgV54g14YhTsXenV7OQdJNrh/nZgZXNey23+rGnJ3JLaLz2I1/uGP/WNkuOt
         URPhOx/G76p3l2/h2DN247UsHpYHyCTduHHL94KF1qm5XZqXvDVL72vYc9Yz4bjS3+Oe
         a2/aSkPGLDOQkuTF3QSjk1RjBBmPuVij3dYCfgiL6o9jwtzXNwJRoKW3B0vOIFBHfkTM
         zsZQ==
X-Gm-Message-State: ANoB5pn7Qr1U0D4N2l3VQtXTjEVHX3UstR2EhuOPFoGqrdBM6IkAWi1T
        c2LB/86imX4pIlLUREqmNlI=
X-Google-Smtp-Source: AA0mqf48NKm6cCxxcl+5VTmNaZVQjZE0+MXp1r2BS9HXWJ5keVIsFYwuf1MT28TfKun1cdl98l7NHQ==
X-Received: by 2002:a1c:2743:0:b0:3c6:e471:7400 with SMTP id n64-20020a1c2743000000b003c6e4717400mr6927100wmn.98.1669217403138;
        Wed, 23 Nov 2022 07:30:03 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003cfa3a12660sm8469311wms.1.2022.11.23.07.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 07:30:01 -0800 (PST)
Message-ID: <2238a980-7e04-1615-d836-c385a41628a9@gmail.com>
Date:   Wed, 23 Nov 2022 16:30:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 4/5] arm64: dts: mt8186: Add dsi node
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org
References: <20221123135531.23221-1-allen-kh.cheng@mediatek.com>
 <20221123135531.23221-5-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221123135531.23221-5-allen-kh.cheng@mediatek.com>
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



On 23/11/2022 14:55, Allen-KH Cheng wrote:
> Add dsi node for mt8186 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index c0481f0dc527..4a2f7ad3c6f0 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -979,6 +979,25 @@
>   			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
>   		};
>   
> +		dsi0: dsi@14013000 {
> +			compatible = "mediatek,mt8186-dsi";
> +			reg = <0 0x14013000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_DSI0>,
> +				 <&mmsys CLK_MM_DSI0_DSI_CK_DOMAIN>,
> +				 <&mipi_tx0>;
> +			clock-names = "engine", "digital", "hs";
> +			interrupts = <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
> +			resets = <&mmsys MT8186_MMSYS_SW0_RST_B_DISP_DSI0>;
> +			phys = <&mipi_tx0>;
> +			phy-names = "dphy";
> +			status = "disabled";
> +
> +			port {
> +				dsi_out: endpoint { };
> +			};
> +		};
> +
>   		iommu_mm: iommu@14016000 {
>   			compatible = "mediatek,mt8186-iommu-mm";
>   			reg = <0 0x14016000 0 0x1000>;
