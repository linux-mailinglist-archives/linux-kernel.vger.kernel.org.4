Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4787372EA07
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbjFMRiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjFMRiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:38:22 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921E8C9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:38:19 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f74cda5f1dso2789906e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686677898; x=1689269898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/fdINgN0sqoUKaJt5t7kHQjc4xw1nfg/R7i5TeJ3AQA=;
        b=PxxyA3rl/6LX/fkIheo9I9iKqveN4xCAbrZR6T4vb8DI7L8wTll7x000K61BHNvqop
         gR3nVVTyhzyXOHWD2hoIlKy16kfv2gCK79wAr3Pbouub5N02QIueTuCniN97iU9xNo/p
         NJPFyQnKgSBkUnBWSb3HNZVBw/quYrUUCvVIZ4WK0TIG9ua/0tn8no6oGzDqc/EVTmlp
         w40YI3x1+PB+COMmz1Rb5UEqP0zg6KNfqgR0VJRKWJ0PBw4/1PlvAEhTS/V5+PquJyVw
         7RJZ02KvSwSKunzeykagm87Ks+i1fY04QCBLUswJsTtx6lwUe+5P+/yOtJ7Vj9tKLb/7
         p01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686677898; x=1689269898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/fdINgN0sqoUKaJt5t7kHQjc4xw1nfg/R7i5TeJ3AQA=;
        b=IkJ26z1pAK9VCEuvEkUlGZ9VnH6qJxZug74C6H9jmwqU3k27SRGMwkph7dCSeRjg00
         VsSzWQBSbHBrGnrV7QhJ0kPRQntyNWkpRMSGCEOpRPTY8uUMo+MmXdhJBJ3VPp4d9aaz
         wS/bB9BnEPm4Ancc3oRkOjnRQqn7wBDrbJUfuntl1wW7BEmrPU1QkU+IKzGozd9kfNYu
         /VGdU98ZhVfPod55DR04T35zbeTLatdBuCq8xZjXjQWPm6C8R+tZwdGCkEiczs5b1+fK
         DehIzBRQwJwQRX0zueWBxT/vfAHdGfPds5HB00pf6d1izCVZqe+fUplib9EMkBZQQ+Ia
         aVbQ==
X-Gm-Message-State: AC+VfDwyRVlYNIv7l0c5jl9LRE6BN61PVU59Zh+eCdYxcQunSXFvgMDR
        t0eu9t2q4HKlvayjfV+OBB8gUQ==
X-Google-Smtp-Source: ACHHUZ4BEY+8zOheAJZ4zKUdd/2nSaTf65aiMi/IBltqU4q4Coem3+XxUp/Op8XmnDUHULXgJrj1oQ==
X-Received: by 2002:a19:6752:0:b0:4f7:5e82:6de2 with SMTP id e18-20020a196752000000b004f75e826de2mr890177lfj.30.1686677897766;
        Tue, 13 Jun 2023 10:38:17 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id x8-20020ac25dc8000000b004f74056413fsm1038610lfq.166.2023.06.13.10.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 10:38:17 -0700 (PDT)
Message-ID: <08011f4b-0e15-8fab-8a97-13baa5319863@linaro.org>
Date:   Tue, 13 Jun 2023 19:38:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: dts: qcom: sc8180x: Fix LLCC reg property
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230612220632.1885175-1-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230612220632.1885175-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.06.2023 00:06, Bjorn Andersson wrote:
> The LLCC binding and driver was recently corrected to handle the stride
> varying between platforms. Switch to the new format to ensure accesses
> are done in the right place.
> 
> Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> index 88015742315b..3de62e26d56a 100644
> --- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> @@ -2541,8 +2541,11 @@ usb_sec_dpphy: dp-phy@88ef200 {
>  
>  		system-cache-controller@9200000 {
>  			compatible = "qcom,sc8180x-llcc";
> -			reg = <0 0x09200000 0 0x50000>, <0 0x09600000 0 0x50000>;
> -			reg-names = "llcc_base", "llcc_broadcast_base";
> +			reg = <0 0x09200000 0 0x50000>, <0 0x09280000 0 0x50000>,
Is there anything inbetween these register ranges?
Should they be 0x80000-long?

Konrad
> +			      <0 0x09300000 0 0x50000>, <0 0x09380000 0 0x50000>,
> +			      <0 0x09600000 0 0x50000>;
> +			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
> +				    "llcc3_base", "llcc_broadcast_base";
>  			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
