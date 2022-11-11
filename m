Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28A96255D9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiKKI5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiKKI5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:57:05 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE929F5AA;
        Fri, 11 Nov 2022 00:57:01 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h9so5646951wrt.0;
        Fri, 11 Nov 2022 00:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KaMcBLsoVyqtu03uWUf8qFf/NtXFui3YcFfaHhghhcg=;
        b=dcUIec17fXShU0D22Ke0SSuSdFN+k+3iWRH8dz53i8WclFqju4JkG3PwJpCH+pnNrb
         IEvbY0q8xwL2Vys7UlnRa+zXwyy+63UIkmfmd26FAdfebzmAmc5bRO+6FKjwvBJaH/0u
         Xr3R2QNGt+JAQnqQajFyZU6jJOdDYf1Q+dty4/dlksaSHmm18+5Tks5yGne3Gc0z3KYY
         N+1V4sZsWV+V3TJ4M8LMG8UTDcr5JLk2gHdCmREptMv28bLEkustBhNA4qofg5wUwaKz
         VW+sgXmPESSIR9EwbeEpAC6aNinw8pcBx3j7Y88H+3DuZaoMXx0fKzJrMSiB+fg1S/ja
         zp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KaMcBLsoVyqtu03uWUf8qFf/NtXFui3YcFfaHhghhcg=;
        b=A6kABpa4DOusCqULcTf0b2VdPsv5kZmvSZHs1aNprhjGsHkGFlhtTgmUKpvJnj6yhe
         McI797r/JS9dmlSsgSHFRW+7bVth7+/r5bPNXS5+I1zSsWhFvpxtYJXfSWQswSkiZ1VM
         VGJOSi0m+2c96tWdI2JQTyy3bEhvBL+wLxaLMlu5Rq++PLVbQaRL3QyCMBHztITcQm74
         ikrY4o8NlsgflfK0b/tyYUAGqCJ9XYPeNZ4rM3lOtWoUDLteJdDWiYErk1r0+OexlVdE
         Uvn5tuGDo1h8IDot2YCFE4yKoUhC/FeOU3jB0wugxxytuWEHw8q4Ps9JEL4M7HFWAw0i
         Hy6A==
X-Gm-Message-State: ANoB5pnkbdTJhzBOGdHwPFx+5srXIq1qeb4wA/guZEejDoUhWanHk7gi
        Q4z2TgWacRMYfYDIxFh43dA=
X-Google-Smtp-Source: AA0mqf4N7yuM8IdQE3lXSfvVQUBKrjMvD2Eg5wiPoWiejd00raH0z2svf3porYC6FthSfggv3GyuAg==
X-Received: by 2002:a5d:558b:0:b0:236:7670:68b5 with SMTP id i11-20020a5d558b000000b00236767068b5mr605179wrv.149.1668157020392;
        Fri, 11 Nov 2022 00:57:00 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id d8-20020a1c7308000000b003cf7928e731sm2223476wmb.9.2022.11.11.00.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 00:56:58 -0800 (PST)
Message-ID: <1925e515-1a0b-f1bf-0f99-47a45de10d06@gmail.com>
Date:   Fri, 11 Nov 2022 09:56:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC v3 04/11] arm64: dts: mt7986: add crypto related device
 nodes
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Shih <sam.shih@mediatek.com>,
        Vic Wu <vic.wu@mediatek.com>
References: <20221106085034.12582-1-linux@fw-web.de>
 <20221106085034.12582-5-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221106085034.12582-5-linux@fw-web.de>
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



On 06/11/2022 09:50, Frank Wunderlich wrote:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> This patch adds crypto engine support for MT7986.
> 
> Signed-off-by: Vic Wu <vic.wu@mediatek.com>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts |  4 ++++
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 15 +++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts |  4 ++++
>   3 files changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> index de5d771e5251..2b5d7ea31b4d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> @@ -43,6 +43,10 @@ reg_5v: regulator-5v {
>   	};
>   };
>   
> +&crypto {
> +	status = "okay";
> +};
> +
>   &eth {
>   	status = "okay";
>   
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> index 58bbecfbab98..1c7a973c28ca 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> @@ -205,6 +205,21 @@ trng: rng@1020f000 {
>   			status = "disabled";
>   		};
>   
> +		crypto: crypto@10320000 {
> +			compatible = "inside-secure,safexcel-eip97";
> +			reg = <0 0x10320000 0 0x40000>;
> +			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "ring0", "ring1", "ring2", "ring3";
> +			clocks = <&infracfg CLK_INFRA_EIP97_CK>;
> +			clock-names = "infra_eip97_ck";
> +			assigned-clocks = <&topckgen CLK_TOP_EIP_B_SEL>;
> +			assigned-clock-parents = <&apmixedsys CLK_APMIXED_NET2PLL>;
> +			status = "disabled";
> +		};
> +
>   		uart0: serial@11002000 {
>   			compatible = "mediatek,mt7986-uart",
>   				     "mediatek,mt6577-uart";
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> index cd1763fa7f19..a98025112b5a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> @@ -43,6 +43,10 @@ reg_5v: regulator-5v {
>   	};
>   };
>   
> +&crypto {
> +	status = "okay";
> +};
> +
>   &eth {
>   	status = "okay";
>   
