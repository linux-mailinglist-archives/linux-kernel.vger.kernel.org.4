Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1894F6860C5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjBAHhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjBAHhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:37:45 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C183B3CE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:37:43 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bk16so16364774wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vtEz6HgYvxRUvaHEz9ZnWOfkR0mMjLhI8XOy+dkVNLE=;
        b=xz0o1BDFiWYKQbIO3tBcvo/YDKW3Wb5ekPNta5Gb+/VxHCzyh/xLxdwqAmEy61FWbZ
         GG63C5+HLPa1VxKuFeb+JHwX+Em4qy4Q2zyIehc3mSY89R2DhPcaESdOJsZhIczh9ugK
         M9Hf1ngMucGLy6E1JpX7oMeK2MMdYZrtr6Jb3nOtzHheNcolB8/wlcub8KECYoQ+joIS
         u8ywdn4DzTI8hKgzrizXCRcv2M2Z/qYIcgBaLqy8dtyMdxPd1AgDhlNPkpkzApNLWSD3
         FDxmsxeQQVQMjOLPhTHc5bAf5sUuEZcNrkLcmwvU5CowUtLQ9Crxktl/94rkFKOnh/Lz
         beFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vtEz6HgYvxRUvaHEz9ZnWOfkR0mMjLhI8XOy+dkVNLE=;
        b=oSV+g18z/BHIiVKsd8Gbk7e2OaZfqC/FosBMJO15Ad4NK/pwzmHdMJPhUVEco07MwO
         /DTpX8WpoO6Zw1gHLC0bVVfETavu+iEAtfphEzNlKT+WWfomUlCPIH+vpTGsxnN1ccAX
         I1pxKTUvVs0SjsmeNgL9tXKbxcJSptXSUq5jAgIO/fwAXCrCCfWsRVmf6mDbSSiJFUs6
         eOF04aTo9vb9U305oQCgNWi6Rc4PduF0iL5fjlqgSABGwaHlpMWMJ6m3PuUJUk1+U7qD
         ahOcjaFa9oxReY4sZSBjdJaa9EyEB70kox7j53wrIOIiNKoY5AAVs9XHNSC7bj4cOMda
         V1IQ==
X-Gm-Message-State: AO0yUKXZqrqxrDkWJpRfQ/aX6PHq94ZhSWkvkfEqMTgdgjT4t3jXZ0Ss
        EKHpwbGKxhuFm7AfaYhO2rtedg==
X-Google-Smtp-Source: AK7set+WxI2wxDu/UXDfZmDEZtvOwJLAs2HZa186Mvnwh+h13QxLftJaM+ds3wqNh+gw73VngtvHfg==
X-Received: by 2002:adf:d846:0:b0:2bf:cc26:c6cd with SMTP id k6-20020adfd846000000b002bfcc26c6cdmr4938218wrl.43.1675237062411;
        Tue, 31 Jan 2023 23:37:42 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m8-20020a5d56c8000000b002bf94527b9esm16253376wrw.85.2023.01.31.23.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 23:37:42 -0800 (PST)
Message-ID: <91ddc32e-0e59-fe49-b8c2-b33b962c943e@linaro.org>
Date:   Wed, 1 Feb 2023 08:37:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V4 6/7] arm64: dts: qcom: Add ipq9574 SoC and AL02 board
 support
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230201060319.20434-1-quic_devipriy@quicinc.com>
 <20230201060319.20434-7-quic_devipriy@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230201060319.20434-7-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 07:03, Devi Priya wrote:
> Add initial device tree support for Qualcomm IPQ9574 SoC and AL02 board
> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---


> +
> +		sdhc_1: mmc@7804000 {
> +			compatible = "qcom,ipq9574-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0x07804000 0x1000>, <0x07805000 0x1000>;
> +			reg-names = "hc", "cqhci";
> +
> +			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +				 <&gcc GCC_SDCC1_APPS_CLK>,
> +				 <&xo_board_clk>;
> +			clock-names = "iface", "core", "xo";
> +			mmc-ddr-1_8v;
> +			mmc-hs200-1_8v;
> +			mmc-hs400-1_8v;
> +			mmc-hs400-enhanced-strobe;
> +			max-frequency = <384000000>;
> +			bus-width = <8>;

None of these 6 are properties of the SoC. Move them to the DTS.

Best regards,
Krzysztof

