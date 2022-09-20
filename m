Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BFB5BE6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiITNEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiITNEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:04:42 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CB6E00C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:04:40 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h3so2948336lja.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=mygucZLIIUq2+FCsjFkyMMlDK+CJ9xh7zLzeZeK2yZg=;
        b=WsxTjmjjR5He1obnmT81IpfHGF3TAtQwEqHc9G5ZqUrFs2kbImGYXtBE/xJo9lJWJE
         W2TazRt+bt2n5AWiU1ukRCVo5TNGXC566ucLppTnHSuPW0MP0YvlovfNFKnTb6skx2aS
         mFLuiC9VSf2F3yeK/uMlAHPnbgGU3EjqCDChKYlbVl9NMxHgNWhZNusMNGJ2VAHqWeaS
         7Wv2polvLKRw4rSxP65KinAT2KfRSMogHr1ERuG96Nw8pHE1xbuykZeCidiKoOXdzeAe
         Sn62ybtz34tDJ1SG8HonleKGLwlnDmSt7gc2LEKo7QcXmvG9/OVHn4pkTPHLRsQIyfYK
         +/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mygucZLIIUq2+FCsjFkyMMlDK+CJ9xh7zLzeZeK2yZg=;
        b=beYcDlrSm07/maEjyH+8OkPN7ib8mj3mx14VwV/fMf2WHGkqPt5ty2Aze0afEwxkUZ
         BumOJ1sQFL0X8vJKAtA3pWFOuck8uNf9qEf+r7SrPOAMPubOZEpbpiq8haKzFmzTraLc
         iqz29Omk5urkUsEIlOiOvTOTi0Md6Gh2Zdnqvxd6xX/zmP6OMkwPHEbhrv95WVoZKxau
         b5DjzbEKmT4cVB0uXppdlu9Drk0J+Pnp5b5ApH2dwOQxlPJm9xONV2XXmkDg1kRbEVny
         NhmXHlA3u9BBtD7YwKGFctAfbRCo5L3d6v1SzLeOgBX5dEBHYJ1t9TI2DSSuklDgQU/p
         8lBQ==
X-Gm-Message-State: ACrzQf20vI5pMs5jzhGojRDkDW/8xxrTtwQxuIZNyZV32gLXdln7g+aJ
        fTT3ahqB6ahPaadtq7O2kF++8g==
X-Google-Smtp-Source: AMsMyM5iwAJVadIwLWzNsycVIha+pQHWZEUDNZq7PgtHVR0W04+wybhIyzQLVLqGmQPd6wdqR+xJfA==
X-Received: by 2002:a2e:98c:0:b0:26a:9b25:b76f with SMTP id 134-20020a2e098c000000b0026a9b25b76fmr6869396ljj.256.1663679078764;
        Tue, 20 Sep 2022 06:04:38 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y20-20020ac24214000000b0049f54a976efsm312567lfh.29.2022.09.20.06.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:04:38 -0700 (PDT)
Message-ID: <b4b61b0a-25a2-b435-4154-2ec2db2c289e@linaro.org>
Date:   Tue, 20 Sep 2022 15:04:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 08/15] arm64: dts: qcom: msm8996: add missing TCSR
 syscon compatible
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
 <20220909092035.223915-9-krzysztof.kozlowski@linaro.org>
 <9f47ef0f-6e73-9ed4-55db-491d22c55c76@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9f47ef0f-6e73-9ed4-55db-491d22c55c76@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 00:13, Dmitry Baryshkov wrote:
> On 09/09/2022 12:20, Krzysztof Kozlowski wrote:
>> TCSR syscon node should come with dedicated compatible.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> index 166374566a49..5f45d0589265 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> @@ -3499,7 +3499,7 @@ frame@98c0000 {
>>   		};
>>   
>>   		saw3: syscon@9a10000 {
>> -			compatible = "syscon";
>> +			compatible = "qcom,tcsr-msm8996", "syscon";
> 
> No! saw3 is not a TCSR. It is a separate region, which should be managed 
> by the SPM driver.

Indeed. Thanks for checking this.

Best regards,
Krzysztof
