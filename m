Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209926F7096
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjEDRNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjEDRNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:13:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044AA59CC
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:12:52 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f11d267d8bso867006e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683220369; x=1685812369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s/CEdgtUpi43mveuf39uYFXUUNC2tD6NAcNS1FOuE/c=;
        b=glRedMD+CCYZs68XnbUGejYxfbxN2A1ctKi63s1kFo+NAe4Xu3ziikfeT3YuW0p7c/
         lByRyNIfiUVM7PTYuqX3EJOx71gldftTyQDl/+J2iJJgq90sFOSiOmXsWPAwoyTUS04o
         A9/r4kXkz3UOogc1qvYCpzK3Wvx5hvrR4XNZbX3DpWizl5//rtTQFe8C+5Rpq7rO2M7Q
         JA1UDuXS4Ls7GB6g6/CctAC8DJvYYTn4FBVQqMMhn2PxMPru2YxOdSnG2OvCuKX90gHY
         WLkLXeuXv/T+5t1csToF9pQ7o9W4nTMiCeuvDus+4n8ptyclcQpnVYxL7CP8z9JUAVVV
         xaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683220369; x=1685812369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/CEdgtUpi43mveuf39uYFXUUNC2tD6NAcNS1FOuE/c=;
        b=Vq1o+zpduEIRKRcbXeckYdBtnYoYP7ef3Lgq8EmcUAvyb0N+cTa2gVTz1APNcnsL5L
         PkU6MabROAJUdIqjXpX6WxNnFClHUQidFgkDkLgQYB3U/cjFBsMIUQcairtDrdqlrXmM
         zIffiEJ1mLtaKFw5FEXYdD8psT55gbeeI8YDyua+PhCMCSWOHfTsS9/EDH7en8CeoHvY
         ZMIIy4SPIMuMJvWpWqCWi2/OyFkq8LxtlQBVD1sVWkl/8rQYhZB5NtmxBGQ3KYMJaWVn
         dGgfb8SnjTwER25f5hsYccfYg1xXeLxjbwjI+kfKC56JCYZGJwq7LmiHC13+pzpIFdAS
         DnxA==
X-Gm-Message-State: AC+VfDwXxRJTW6zNQ8ZmzYNkXKSFAowAZgvRhyglgUBqOdHIUvWBuXBK
        62vcrNRgi/4sGniLVwangVaicZ4/P1e0ka1h/EM=
X-Google-Smtp-Source: ACHHUZ7hTVLK8eEhO1dOL53juI+UHyGvUD0vBRFkSB59bxxkMCyfvfsmbQkNLpxSxsSiACB0FK7TKA==
X-Received: by 2002:ac2:4887:0:b0:4f0:223e:7916 with SMTP id x7-20020ac24887000000b004f0223e7916mr2104795lfc.62.1683220369491;
        Thu, 04 May 2023 10:12:49 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id s5-20020ac25fa5000000b004e83f386878sm6567522lfe.153.2023.05.04.10.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 10:12:49 -0700 (PDT)
Message-ID: <40e5dd8a-e729-524d-8c16-1999ba4ff279@linaro.org>
Date:   Thu, 4 May 2023 19:12:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sa8775p: enable AOSS
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230504161755.197417-1-brgl@bgdev.pl>
 <20230504161755.197417-2-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230504161755.197417-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.05.2023 18:17, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable the always-on subsystem controller on SA8775P platforms for use
> by upcoming support for other peripherals.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 0737ba38fefe..c5e2e3256bc4 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
>  #include <dt-bindings/clock/qcom,sa8775p-gpucc.h>
>  #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
> +#include <dt-bindings/mailbox/qcom-ipcc.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  
> @@ -752,6 +753,16 @@ pdc: interrupt-controller@b220000 {
>  			interrupt-controller;
>  		};
>  
> +		aoss_qmp: power-management@c300000 {
> +			compatible = "qcom,sa8775p-aoss-qmp", "qcom,aoss-qmp";
> +			reg = <0x0 0x0c300000 0x0 0x400>;
> +			interrupts-extended = <&ipcc IPCC_CLIENT_AOP
> +					       IPCC_MPROC_SIGNAL_GLINK_QMP
> +					       IRQ_TYPE_EDGE_RISING>;
> +			mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +			#clock-cells = <0>;
> +		};
> +
>  		spmi_bus: spmi@c440000 {
>  			compatible = "qcom,spmi-pmic-arb";
>  			reg = <0x0 0x0c440000 0x0 0x1100>,
