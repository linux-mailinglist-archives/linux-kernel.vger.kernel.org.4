Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38FA65B1F5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 13:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjABMXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 07:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjABMXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:23:23 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C35BE69
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 04:23:22 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bq39so33578642lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 04:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+dRmNNPMchYdaMISw18R8w+sJn25cz5L7dDt6PVqBag=;
        b=VN/e4L2HS6tg+XCkYinWd1wou3nO6P99XPPFO258LpR2I9/o1p+QQmb9vC09d3eC/E
         elLEMe+ES7DybEugO/ORQ/BUbkXWM/5h9VONfuuviKE47mkZDOFPJI+oyVpiW++RzXhP
         zSDM+WoplFuSlGHEC8Ign188K57SX/CD+zFv8N5yN8m2JYW6TzEj0MjPcYDyB+oAa38j
         x24O42NKaj1Ddn55nnLCb/miUsznnDWnbxlP6o+fDQyiiXP/wi+RNbvwA9ulCFX3mg9E
         +HDn8tWTORdd9/vfiiDRx6CqLfmLoQ8AINmGCDOM4K2nCRPOTvVyLJ/K//QxMqNldWnf
         0WmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dRmNNPMchYdaMISw18R8w+sJn25cz5L7dDt6PVqBag=;
        b=BFmkv3xmVB7TRmq5/KfjpucsFas5sYjoBBHIjcSA3K6O4R4H5ZN6LIQ8qftLcznfwz
         H2bHIYw82TSHIFXDPiXn+l8jhZrUgiHUCaSEUiXMZc2dMmWDb2R0QqALBtBmpXGbWVAi
         v3+Fj4UAL90R+7YtvGxdcNK1zj+8iAWSnmXUyp0XY3eZsHWafydJrqiwbSmI5olqN9DO
         ieGKiO0+rwAZdfOZhm3hSM2A9pP85vh7NXS2VFldQob4g1ALupCoLppswzdAxKs61sC2
         GZCwsHzuODanvi19nB2fWrpBl3ZqF6ZdmY8BLtfdnLNCA+vplZwSDirw5jZA0gxRKWvW
         I7ww==
X-Gm-Message-State: AFqh2komMAb2TxoafTUkBNtfe113JbZt52aMcmOy07/5G+Bo0HRfCqcR
        hj7SmaH8qP7C85TOxip40UDcHQ==
X-Google-Smtp-Source: AMrXdXs+QTJA/IYSNu/6hVCWOI/glWu/glAVey3j6SRPUFYJAac1p7H5b13egEkkW98nSpA1b1SnWw==
X-Received: by 2002:a05:6512:258b:b0:4b5:b85a:5ba6 with SMTP id bf11-20020a056512258b00b004b5b85a5ba6mr12541218lfb.20.1672662200599;
        Mon, 02 Jan 2023 04:23:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s18-20020a056512215200b004cb291bcd2csm1173700lfr.246.2023.01.02.04.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 04:23:20 -0800 (PST)
Message-ID: <c2a32bd3-90cf-6d1b-1ca7-76071232c81b@linaro.org>
Date:   Mon, 2 Jan 2023 13:23:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 6/6] arm64: dts: qcom: sm8450-hdk: fix wcd938x codec node
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-7-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230102105038.8074-7-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2023 11:50, Johan Hovold wrote:
> The wcd938x codec is not a memory-mapped device and does not belong
> under the soc node.
> 
> Move the node to the root node to avoid DT validation failures.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 52 ++++++++++++-------------
>  1 file changed, 25 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> index 4de3e1f1c39c..217b2c654745 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> @@ -17,6 +17,31 @@ aliases {
>  		serial0 = &uart7;
>  	};
>  
> +	wcd938x: codec {

Let's call it audio-codec and put it somewhere ordered alphabetically.
This avoids useless reshuffles immediately. Moving things back and forth
does not make sense.

Best regards,
Krzysztof

