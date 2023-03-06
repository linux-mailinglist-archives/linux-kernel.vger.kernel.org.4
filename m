Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10F26AC415
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCFO4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCFO4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:56:10 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB7F23113
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:55:54 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id h9so9936833ljq.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678114553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wu38Rlz1IR8mP8Nh89bkjpaZ5IUcMWkU7u2ELQQVG30=;
        b=vLNiWB2TjOEZ7dTr0ZUeRcrfok4M+fWLoIO/LRZxQuM7JUjo438Et2X6mrr2sVXHkV
         7AQg2kC9qLS2UEwm5dwGoNabrB7ywfmZKn2dzlp90mvv73aXtUHNsFJ2SU60oddWJVnf
         zOpdA0mmpkIheIp5QYPErdWgZCf9u2X0d/KKPWpfc1e/ENnggncDkj8QeDDM0sQ3dcPw
         GTNZhlNdpqvKIhxYqjmib2+iIF7vYw/oaTIwkWDxUs/rnheLZVr4Hkh1Mezpwywl5OwZ
         onTMxE8qAgyTZflMO0K/f5l7vAE3+IcOlV+wmq/Wgl6doazCjLIppyyHPUZRy5c5eqWF
         hOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678114553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wu38Rlz1IR8mP8Nh89bkjpaZ5IUcMWkU7u2ELQQVG30=;
        b=WRABXTZwKdPLRFdmswaSx6FihLZDryomtJguiOQZMsfuPfYKfgxC3oqfy6jIQJnxLc
         gLkeaR3m86SXttEt0ctrFWoTouuhJ3vZUaDdStskeJ77dnjeH8gBZ7C3hNLtDMLCkEk/
         B1MUC/uvGp7RiAEkUDrpQK1PUXSG2XVHdMNnxGZd+pXn/rKIoSBMv+pdrk7vNrZl1wbL
         LHVhtih6ZwF8BhmQ7KeuT8yd8YTXRogHQMg+uFlNN2fQm1b4MtUI3VSc/BQbU5l8+nVX
         MOGZBM9fU/s4Hgsr2OJMLNtBFOj0dl2dRrhXKHObhxKoXSEv9Ryu20G9SoEQCYfHSuLQ
         yNfA==
X-Gm-Message-State: AO0yUKXSMuefIgetEM3XKtU+1U44rcuxcwW+kak3uUxRo1W2Xp2DYhnC
        e6kcgJ17x0abwRvMr08sE90oMA==
X-Google-Smtp-Source: AK7set+zCCAQSv/7gWaOmaO60uh020Go1KTzmRq9dd1DswrXdeuN8hM/zQThERIWy1lyNq10IKpe8A==
X-Received: by 2002:a2e:7006:0:b0:294:6a83:fb28 with SMTP id l6-20020a2e7006000000b002946a83fb28mr3407870ljc.41.1678114552732;
        Mon, 06 Mar 2023 06:55:52 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id g4-20020a2e9e44000000b00295b1b6e063sm1753050ljk.34.2023.03.06.06.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 06:55:52 -0800 (PST)
Message-ID: <e171b997-258d-7f16-944d-9ece468be1ef@linaro.org>
Date:   Mon, 6 Mar 2023 15:55:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 5/9] arm64: dts: qcom: sa8775p: add the spi16 node
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230216125257.112300-1-brgl@bgdev.pl>
 <20230216125257.112300-6-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230216125257.112300-6-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.02.2023 13:52, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the SPI controller node for the interface exposed on the sa8775p-ride
> development board.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 4666e5341922..eda5d107961b 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -503,6 +503,27 @@ qupv3_id_2: geniqup@8c0000 {
>  			iommus = <&apps_smmu 0x5a3 0x0>;
>  			status = "disabled";
>  
> +			spi16: spi@888000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x0 0x888000 0x0 0x4000>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
Meh, I sorta frown upon placing it here but it's been like that
everywhere else.. If nobody else complains, I won't either.

> +				interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
> +				clock-names = "se";
> +				interconnects = <&clk_virt MASTER_QUP_CORE_2 0
#include <dt-bindings/interconnect/qcom,icc.h>

0 -> QCOM_ICC_TAG_ALWAYS

Konrad
> +						 &clk_virt SLAVE_QUP_CORE_2 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0
> +						 &config_noc SLAVE_QUP_2 0>,
> +						<&aggre2_noc MASTER_QUP_2 0
> +						 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core",
> +						     "qup-config",
> +						     "qup-memory";
> +				power-domains = <&rpmhpd SA8775P_CX>;
> +				status = "disabled";
> +			};
> +
>  			i2c18: i2c@890000 {
>  				compatible = "qcom,geni-i2c";
>  				reg = <0x0 0x890000 0x0 0x4000>;
