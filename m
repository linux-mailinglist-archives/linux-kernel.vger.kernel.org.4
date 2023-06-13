Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7F472EB19
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbjFMSiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240112AbjFMSiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:38:05 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F73C1BD7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:38:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9786fc23505so853637766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686681482; x=1689273482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yv0ezbwFqQwpvx+BWAvYK95gbYiy8pu6m4NXyrIcJi0=;
        b=aSBGeOVWv0EQYYWeowP5nyk1Rq4YoQToAfmc0dTkRpZIV6YkkrQTxEqqrNBhLxVVvX
         x5KHnTf600s+UbhwtXUYZjZyW7cZQBwd6sZK4wpjc1s+jAeQBa/8TtPPcNz4PUekvla7
         xhuqwzvCeYt1d/VPxIm1q07I228+eblf4i+3vPHpSswFSo4zCJoGbcfJlDrC2isiNl3s
         Rw+20Mwvg9CvrcBdYKD/koUQxsx+1y6Ducx5TE2lXjIKKBHTwjieT22rid0OM1sHlR35
         fF7f+3OAXAiM7PGeDkVHYFMgIaFtyLQXQKF1gGwh/mXJ97Z90cQM8EYGBuw+w+v8uS1W
         ifEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686681482; x=1689273482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yv0ezbwFqQwpvx+BWAvYK95gbYiy8pu6m4NXyrIcJi0=;
        b=AQiZJlnthQA6ooKCuAqJUgxNFuoO4CROrIGwotO0Sa3/V5YPvB89NGmLHGRItcfXZ0
         y06RW/dCOMffVVnizihQA0rPxAXgMdTKKSxAGp0V6Dfzvdv4B2nL4zwOASSu8XD1vTcy
         l0efaGFDfJE/ZD0hvto6NfH1hPfNwTqgjS4zNP2hNhwAsEbwebgGvFX+8KXu435RPwck
         sHjJmz7O62jtqR7WNQtL62O6ZX26PpVmy4/gGRP7QqWhf9C6iyOlmRnfBGDB9XOv+jfN
         StMajDoq7+yBpI4eYUTzOhvY0UwlcvTEjoynD8wSA52fabGuP0l2Ta2DKz5OLJrbQ31O
         ur1w==
X-Gm-Message-State: AC+VfDyxFAswzctaWG5ag7jWeDKLlHsak1f3qrKhHwvKURMI6+ruM/0T
        WWd3swcBTHtoCmDAosj+/DuDbw==
X-Google-Smtp-Source: ACHHUZ7GMOecKk6wDEM7Ozt28UyG3zTIyK9GprVXrBebNme5UQYJDt+gmOGfV9xLwAsmVXYmBRpTwA==
X-Received: by 2002:a17:907:6d1e:b0:977:b397:bbfa with SMTP id sa30-20020a1709076d1e00b00977b397bbfamr13864739ejc.6.1686681481895;
        Tue, 13 Jun 2023 11:38:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id bn14-20020a170906c0ce00b0095807ab4b57sm7119476ejb.178.2023.06.13.11.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:38:01 -0700 (PDT)
Message-ID: <7f2d89ed-9964-6d02-5511-ac66c01dc415@linaro.org>
Date:   Tue, 13 Jun 2023 20:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 5/8] qcom: pmic_glink: enable altmode for SM8550
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        neil.armstrong@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230601-topic-sm8550-upstream-type-c-v3-0-22c9973012b6@linaro.org>
 <20230601-topic-sm8550-upstream-type-c-v3-5-22c9973012b6@linaro.org>
 <5851627e-2972-f860-e965-dc8e73b01225@linaro.org>
 <8f9c549a-e37b-2877-be74-f25304a476fd@linaro.org>
 <9c3db237-9bec-36e0-8b0c-28062c631068@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9c3db237-9bec-36e0-8b0c-28062c631068@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2023 15:58, Konrad Dybcio wrote:
> 
> 
> On 13.06.2023 15:43, Neil Armstrong wrote:
>> On 13/06/2023 13:54, Krzysztof Kozlowski wrote:
>>> On 13/06/2023 09:55, Neil Armstrong wrote:
>>>> Altmode is also supported for SM8550, allow it.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>   drivers/soc/qcom/pmic_glink.c | 6 +-----
>>>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
>>>> index c87056769ebd..8af06bdc6f5a 100644
>>>> --- a/drivers/soc/qcom/pmic_glink.c
>>>> +++ b/drivers/soc/qcom/pmic_glink.c
>>>> @@ -342,13 +342,9 @@ static const unsigned long pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT
>>>>                                  BIT(PMIC_GLINK_CLIENT_ALTMODE) |
>>>>                                  BIT(PMIC_GLINK_CLIENT_UCSI);
>>>>   -/* Do not handle altmode for now on those platforms */
>>>> -static const unsigned long pmic_glink_sm8550_client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
>>>> -                               BIT(PMIC_GLINK_CLIENT_UCSI);
>>>> -
>>>>   static const struct of_device_id pmic_glink_of_match[] = {
>>>>       { .compatible = "qcom,sm8450-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
>>>
>>> Orientation and maybe all of the USB-related properties do not look like
>>> sm8450 specific, but PM8350B. That's where CC_OUT pin is. I don't think
>>> we represented this correctly, but rather copy-pasted downstream solution...
>>
>> We do not interact directly with PM8350B or PM8550B but with pmic_glink who
>> does the work work for use, and this is platform specific.
> Yep, pmic_glink is totally a firmware construct and not all platforms with
> pm8350b or so implement it.

The drivers interact like this, but there is no pmic glink on schematics
but PM8350B and PM8550 and DT represents here the hardware, thus the
schematics, not your chosen way of interface. This looks like a copy of
downstream choice which is in most cases just wrong choice.

Best regards,
Krzysztof

