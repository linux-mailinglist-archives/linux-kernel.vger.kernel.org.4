Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427DF65FFC3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjAFLqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjAFLp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:45:58 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B351572895;
        Fri,  6 Jan 2023 03:45:57 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 5029C41902;
        Fri,  6 Jan 2023 16:45:52 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1673005553; bh=Vh6xmQnYY5DuG/ni1O6gS2g/gbn0t6QBeTipIKy2lVg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZOE37t5t/swQpUCu1ONl9BUDC21rjrpyTosEmBRYLJQIaZzzZk1hlwFq9DkAHrOhA
         ZTFxd+zg3f3WoxaN+dl1nSHLbm+Fq1zNEYEr/De66LHHtw/CI+hXLOQzy5JYw2eIJQ
         F2CnNwTF6MF1GfhyIak5b8FB4XJf43UfCGFlG4qc4t2eFOvPGdx/urS1Xg5nTdtCQQ
         4wpCYpzz0f8Md2u431vBGNIuRZnquiNv1D4zClDZukImS/RYzO7F8U9JNOIM9olyhr
         4JtJp2oLl04nOdS4fQXC96KNyRItc1ReFuZvCOhIk7zsH+ed3EQRljLxYR9g6vB7r9
         0QjXij3r1fxkA==
MIME-Version: 1.0
Date:   Fri, 06 Jan 2023 16:45:50 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Siddharth Manthan <siddharth.manthan@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 4/8] arm64: dts: qcom: msm8916-samsung-gt510: Add Vibrator
In-Reply-To: <2f9a150e-11bc-a963-f9b5-75b4ba3206bf@linaro.org>
References: <20230105123240.1089375-1-nikita@trvn.ru>
 <20230105123240.1089375-5-nikita@trvn.ru>
 <2f9a150e-11bc-a963-f9b5-75b4ba3206bf@linaro.org>
Message-ID: <0b7e6201fbabee8ee9b48bf649e8d616@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski писал(а) 06.01.2023 16:26:
> On 05/01/2023 13:32, Nikita Travkin wrote:
>> gt510 uses a PWM controllable vibrator, that uses a general purpose
>> clock output for it's control. Set up the pwm, supply and the vibrator.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
>>  .../boot/dts/qcom/msm8916-samsung-gt510.dts   | 47 +++++++++++++++++++
>>  1 file changed, 47 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
>> index e9916199e5a3..44d527b3f1f6 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
>> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
>> @@ -8,4 +8,51 @@ / {
>>  	model = "Samsung Galaxy Tab A 9.7 (2015)";
>>  	compatible = "samsung,gt510", "qcom,msm8916";
>>  	chassis-type = "tablet";
>> +
> 
> Squash. One patch per adding GT510, one for GT58.
> 

When submitting the series, I decided to not squash the commits to
preserve the authors for the changes as they were made.

I will send a v2, containing two commits for gt58 and gt510 with
the dtsi changes as part of the first one.

Regards,
Nikita

> Best regards,
> Krzysztof
