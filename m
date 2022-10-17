Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CC9601C31
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJQWRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJQWRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:17:00 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE83FD37
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:16:57 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id z18so8255005qvn.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3644dTc+xjbxoWj65g6Y7XO7ILLSKyb7UOk2axF9K8=;
        b=mNfTQl74nV8DrNWtE/kV/FjKtcTOx6hrdQgoCRRNhjEy+/o7gccT28ch4Z6gwumO6Z
         rjT5u/CbfympIrBze62SNAjaUbJofWeLhc1UXVsJleU78pdEopxE7ZXvEQRMnvIBVDQn
         wPnfR44pg0hE6XDb7uBOXR7RMv8Id9iIX2ZPt2Tairl90JvJ0A3ZGGMNql9/LA/j35tZ
         Zk0hk4wqzQViuB4Xlk3ra4vo4EcwhFZ/vNUbMSZq1X2nmpGfuJGJKYTH0YGdW552jUcE
         VeWQBzZitfeviiamdddZ1kLYq4syn5ED2ASn/+5TwF1R9WEl6UfUNblT8jV3xUQSjlpb
         MIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r3644dTc+xjbxoWj65g6Y7XO7ILLSKyb7UOk2axF9K8=;
        b=Z60VQCrU85Qrc+cmJleip4s0LZ7zvgeCoV451y8O6f1+hDzCksda/29mu8PPRO/JfA
         UO24t+xY9ZuhIclsaTaNjQxx0FXElzVxAw6AvZ2ivvmOz++297o5KNh6ejJiv+G8c6q8
         6a5hwvsDE+s+GznYzDriuUUkyTuKGQ1hjIsy0WQxHX6Lymz8GScy9MJZFGah5gVMcZxa
         Jo8Ey3Jwa8yXnojBK3+jex6bXkUUIosHJr2PV7gp39IhDDVRHbp5B/vEoEPVw1ib/mZl
         u9xlNGjY1R6IodTWL2aAyEvLvrftjW8r2UfSm6hnpuyUg02LbvpOx/7yiw2G0+2XbZ9P
         86Xw==
X-Gm-Message-State: ACrzQf3xqSFzk+VgFr02l5zwP65KU8kmWwynBkRHYUovkY+PT8MLQlye
        q5AUUlJcqIhZoIQ/czL7kCycLQ==
X-Google-Smtp-Source: AMsMyM4CNOpDBG9+P8Moi+VDJvnMwS7CB1bTaxx1UF16HMWKglFBszmtA4MFoHKybPaYMLLXvpEI5A==
X-Received: by 2002:ad4:4eec:0:b0:4b1:9859:b74b with SMTP id dv12-20020ad44eec000000b004b19859b74bmr9952835qvb.102.1666045016795;
        Mon, 17 Oct 2022 15:16:56 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id v11-20020a05620a0f0b00b006ecfb2c86d3sm796673qkl.130.2022.10.17.15.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 15:16:56 -0700 (PDT)
Message-ID: <df73124c-f06b-2762-4ea3-8fbeb48148ad@linaro.org>
Date:   Mon, 17 Oct 2022 18:16:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 06/11] dt-bindings: input: qcom,pm8921-pwrkey: convert
 to dt-schema
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20220928-mdm9615-dt-schema-fixes-v3-0-531da552c354@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v3-6-531da552c354@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v3-6-531da552c354@linaro.org>
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

On 17/10/2022 05:45, Neil Armstrong wrote:
> Convert input/qcom,pm8xxx-pwrkey.txt to YAML, and take in account that
> the PM8921 pwrkey compatible is used as fallback for the PM8018 pwrkey.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/input/qcom,pm8921-pwrkey.yaml         | 75 ++++++++++++++++++++++
>  .../bindings/input/qcom,pm8xxx-pwrkey.txt          | 46 -------------
>  2 files changed, 75 insertions(+), 46 deletions(-)

Thanks for the changes.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

