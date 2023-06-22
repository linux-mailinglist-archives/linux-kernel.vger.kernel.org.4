Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689FE739ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjFVKtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjFVKtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:49:18 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A16619B5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 03:49:16 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so2275924e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 03:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687430954; x=1690022954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eTlu1IkqRgiab8MtP9YjYrxSdaogyHj/YUZGxV1xbag=;
        b=pKCKAjRKGtLC/WPqvh/sY5SR+6rnqhTkwvWRmItMYFHnIAiFYEBATvUFy3njhowtuw
         D87rSOu0yVqzDMD+gIuaWDXxtnK0w7GH8MFePZOEfHU+UglZqP3YW4zMLGP2YBH+H7QU
         lmSG+728zKV+k7+VeGRbOhhQc1isTCemjYU1YlbQ1g3AqRKX7xiSIb0WMsN+h2oqSm2K
         FrlBDVduwHBVCc2iQ0AO7CDv4lWlBMxVu+prldXbhnk5OE+3mU0EhHPY7eErd+vHp7Sk
         ycZz2AF7OF/CW4pIe4KsmVZvY6Ftqe+27T65xlKBvDa36X5stAxceWPH68xkAWkmQtZg
         epBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687430954; x=1690022954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eTlu1IkqRgiab8MtP9YjYrxSdaogyHj/YUZGxV1xbag=;
        b=MpPyR92SnIWIuaDFPclV+k+QB6r6b26twPLYpwFdU1TRJ0Y809lM5ZfyaDcstxf6NT
         7mMQRuOAfXVp/4h78Ttc1H3DN6+nTv323eEqmnzs7KtfL2E32bk8SlAMhcipEn0ElswV
         7B1T75e0hvxsTpaloqzLLMdIHIFWYPDFHONQ7lgyqBToppVsj0MqD9Tl236gckZvLme1
         7N7050+lmWX/+/MZik5rEC6s3AlJpR55cgeREpyjnIUwA2KigMOP/0Pt77mI9plgzgyv
         G+TY76/UwxQ6QUsqFMmQNI+DYdUCrv3sFLEU3G5/3j3nW6GtAyTCQBWJsXbG1h47wFnn
         +JYQ==
X-Gm-Message-State: AC+VfDztSsdecb9XsEXfxeyg9U8UOGzfzQw3BVxPaPn1dXy1CFxThzQM
        n7W4WaOMQkGYoY0ryEb85lKm1g==
X-Google-Smtp-Source: ACHHUZ5+UVhdOZgsQM2Fh4e445mlxmzsDvz88bXhNTNChuAjhPxjP7pEHzByjsFvDryIRBBcTzdieQ==
X-Received: by 2002:a05:6512:234a:b0:4f9:607a:6508 with SMTP id p10-20020a056512234a00b004f9607a6508mr1839292lfu.50.1687430954560;
        Thu, 22 Jun 2023 03:49:14 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id q11-20020a19a40b000000b004f13bc97b00sm1066984lfc.119.2023.06.22.03.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 03:49:14 -0700 (PDT)
Message-ID: <091a281f-b4c3-39e5-6d9c-5df903a020f5@linaro.org>
Date:   Thu, 22 Jun 2023 12:49:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sdm845-mtp: add chassis-type
 property
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230622-topic-sm8x50-upstream-chassis-type-v1-0-13f676eb71f3@linaro.org>
 <20230622-topic-sm8x50-upstream-chassis-type-v1-5-13f676eb71f3@linaro.org>
 <CAA8EJpphEZa1Vfs1ipm+1x7MvYgF7HMiW-GfNzYi37YPoMzKVw@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpphEZa1Vfs1ipm+1x7MvYgF7HMiW-GfNzYi37YPoMzKVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.2023 12:48, Dmitry Baryshkov wrote:
> On Thu, 22 Jun 2023 at 12:06, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> Qualcomm's Mobile Test Platforms devices are handsets, set the
>> chassis-type property to 'handset'.
> 
> Is it really a device that you can take into your hand and put close
> to the head?
If you don't mind getting a bit microwavey, yes

Konrad
> 
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> index b2d4336e764b..41675a8de268 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> @@ -15,6 +15,7 @@
>>  / {
>>         model = "Qualcomm Technologies, Inc. SDM845 MTP";
>>         compatible = "qcom,sdm845-mtp", "qcom,sdm845";
>> +       chassis-type = "handset";
>>
>>         aliases {
>>                 serial0 = &uart9;
>>
>> --
>> 2.34.1
>>
> 
> 
