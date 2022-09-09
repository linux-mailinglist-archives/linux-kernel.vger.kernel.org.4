Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35265B2FE7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiIIHe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiIIHec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:34:32 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4725765E7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:34:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w8so1233816lft.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 00:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=RIxvHEegtZCxPOPw7EphVjzvn7r49/9vRL8dVi9xWMs=;
        b=NOp54X4f6ury83PRxp2qqhdBmIM7mv360+YQrIn5bGU7s3CQkJFG+5brMbXLsUT49d
         mqHyf0qNhAkYbaz9qSHaEQaA8y+i0wXJKjIdliolEo1Ygjat3XHmlc05/oNKHaSOQfIp
         gVvlZakjCK5x3P1hjBwt2q8hmWqn+8V9ovKr2U8IKi2PMR5jSsRCc4yMF/Efhj3ECEfl
         gUr5Ph1QJY3FPWRgdvNCnFCwzNyV89QqCrCMPyDPTpJ/IFWC7tR3rDocgdcvu5blbIgX
         m0fKyadbcY6KgmjJ6CQobtbCT3Q0qIXXhT5AOh3XyzmzxUSYl6w3Yix/bIfqcJ4GwF4h
         UmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RIxvHEegtZCxPOPw7EphVjzvn7r49/9vRL8dVi9xWMs=;
        b=uLXehuMR8q0nJER9O1HpnSvzt/C/zWyXsraJa54C2cczYNbZ3OohNq6v9OjT2cVC+e
         nQuhMFxD6pjJYITGcduueqQ/GiKPM4KgdNc91Qqg8TSAF3ly8mYj/YudSqsMLSz1nzgS
         I570B9ehwroUeIyqeEfP6ZlQu1Eqqq8TSs+IU2CxR8ATG+WYHaWnYuEOR6K8LHpkdlT/
         zAhtjMSpvprg+ollMIcezvNzQEL+Rt8gO6RsXjdhIGYzjyCQnVlv7QyBgsBFtD4Js67k
         YRJqdRq4y75hZsQyuAosxP8Cg9y+wfsUq9pCte0avfHq96c9D7SdiJBQihl49v2pqa1S
         EXQg==
X-Gm-Message-State: ACgBeo25TgngJRqKFyMP6aDs7v+3a4X6x5T5mcRywMVwnVz1AcTWnjD3
        efQpshPKKfxw1Qh/b/gThDtHNg==
X-Google-Smtp-Source: AA6agR7MFPe/65GpvTSwXGO9jKrS/KFNzQt7E0cl1aUwzOgn5MmUyTpsYJzjIROa0DwMp7uB3Yuu1A==
X-Received: by 2002:a05:6512:3183:b0:498:fa29:35fe with SMTP id i3-20020a056512318300b00498fa2935femr454877lfe.523.1662708865316;
        Fri, 09 Sep 2022 00:34:25 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f25-20020ac25cd9000000b004948378080csm152093lfq.290.2022.09.09.00.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 00:34:24 -0700 (PDT)
Message-ID: <c447b51d-339e-2bd9-2dbd-5198d4eeaa11@linaro.org>
Date:   Fri, 9 Sep 2022 09:34:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/4] pinctrl: qcom: spmi-gpio: Fix the GPIO strength
 mapping
Content-Language: en-US
To:     David Collins <quic_collinsd@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anirudh Ghayal <quic_aghayal@quicinc.com>
References: <20220907201528.9351-1-quic_amelende@quicinc.com>
 <20220907201528.9351-3-quic_amelende@quicinc.com>
 <2b809e98-85ea-6ad9-e810-106563937ddc@linaro.org>
 <4c017ad4-558b-a8d4-bc8a-eebd2d5a35ba@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4c017ad4-558b-a8d4-bc8a-eebd2d5a35ba@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 02:25, David Collins wrote:
>>> diff --git a/include/dt-bindings/pinctrl/qcom,pmic-gpio.h b/include/dt-bindings/pinctrl/qcom,pmic-gpio.h
>>> index e5df5ce45a0f..950be952ad3e 100644
>>> --- a/include/dt-bindings/pinctrl/qcom,pmic-gpio.h
>>> +++ b/include/dt-bindings/pinctrl/qcom,pmic-gpio.h
>>
>> You cannot mix bindings with driver. This is an ABI break.
> 
> This could be split into two patches.  However, both would need to make
> it into any given build to avoid runtime regressions when
> pinctrl-spmi-gpio.c rejects GPIO strength configurations larger than 1.

Which proves this is an ABI break. You need to gracefully handle in the
driver.

> 
> I suppose that this kind of bi-directional dependency could be avoided
> by using one of these checks instead in the driver:
> 
> if (arg > 3) {
> 
> or
> 
> if (arg > max(PMIC_GPIO_STRENGTH_LOW, PMIC_GPIO_STRENGTH_HIGH))
> 
> Going this route would only require that the driver patch is picked up
> before the DT header patch.

You cannot change constants in the DT bindings header. Regardless
whether now or in the future - the constants are frozen. Otherwise it is
an ABI break. It would be acceptable only if existing feature was
completely broken and never worked.

> 
> 
> 
>>> @@ -12,9 +12,14 @@
>>>  #define PMIC_GPIO_PULL_UP_1P5_30	3
>>>  
>>>  #define PMIC_GPIO_STRENGTH_NO		0
>>> -#define PMIC_GPIO_STRENGTH_HIGH		1
>>> +#define PMIC_GPIO_STRENGTH_LOW		1
>>>  #define PMIC_GPIO_STRENGTH_MED		2
>>> -#define PMIC_GPIO_STRENGTH_LOW		3
>>> +#define PMIC_GPIO_STRENGTH_HIGH		3
>>
>> Didn't you just break all DTSes in the world?
> 
> Currently, all PMIC GPIO peripherals managed by the pinctrl-spmi-gpio
> driver are having their drive strength control register programmed
> incorrectly at runtime for the constant name used in DT (i.e.
> PMIC_GPIO_STRENGTH_LOW vs PMIC_GPIO_STRENGTH_HIGH).  Changing the values
> of those constants as done in this patch fixes that incorrect behavior.

Wait. The values in the bindings should be only, *only* abstract ID
numbers. Not register values. How is it related to the value being
programmed in the driver? This is just an enum. If you have DTS with
PMIC_GPIO_STRENGTH_LOW you program 0xwhatever-you-wish. Not exactly
current value of "PMIC_GPIO_STRENGTH_LOW".

You need to fix the driver, not the bindings.

> 
> The qcom,drive-strength DT property is taking a raw drive strength
> control register value instead of some logical strength abstraction.
> I'm not sure of a better way to handle the situation than fixing the
> incorrect drive strength constant to register value mapping as defined
> in qcom,pmic-gpio.h.

Bindings are not for defining register values, but to define the DTS.
Feel free to use binding constants for register values if they fit
you... but if they don't fit, fix the driver. Not the bindings.

> 
> Changing the mapping in qcom,pmic-gpio.h without updating any dtsi files
> could cause a problem for very old targets that use SSBI instead of SPMI
> for PMIC communication.  However, for there to actually be a problem,
> PMIC_GPIO_STRENGTH_LOW or PMIC_GPIO_STRENGTH_HIGH would need to be
> specified for the SSBI PMIC.  That would be GPIO devices with compatible
> strings: "qcom,pm8018-gpio", "qcom,pm8038-gpio", "qcom,pm8058-gpio",
> "qcom,pm8917-gpio", or "qcom,pm8921-gpio".  I could find no instances of
> this situation in the kernel source tree.
> 
> The PMIC_GPIO_STRENGTH_LOW or PMIC_GPIO_STRENGTH_HIGH usage in dtsi
> files for SPMI PMICs does not need to be modified.  The DT header patch
> fixes configurations that are currently broken for them.
> 
> Note that the drive strength misconfiguration issue doesn't present a
> problem for commercial products as this patch has been cherry-picked
> downstream for several years.

It will affect several other out-of-tree users and other projects. Don't
think only about Qualcomm tree, but about entire Qualcomm ecosystem and
its users.


Best regards,
Krzysztof
