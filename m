Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A84372E4B5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240538AbjFMN6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240426AbjFMN6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:58:42 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B961FF4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:58:39 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b1c30a1653so68108121fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686664718; x=1689256718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eYEjJGS1UUCjJyusiKu9spXvZVC2LuJOiUk5VQb5qBg=;
        b=uNjYiaaXwGbisnriVGiyDPW7ZI45SzlN8FOVeTNbbxQb4PXZ+AuM66H4Yerp0ztmPX
         01S78XYRrc7zNj88Pxcc1yV1tTzr3QBXuGBkzGMuS5uOyENuRaUoUFwpH+pm9eLJ7JcF
         nWUUkS/MhD+1NGnKuogt5np26PCxhwF8tUjQehy+RMFNIpeT8xZ7TNB5Yyfs31jl2spX
         eQ4xds7UIgd9KNJZNU/vGmbBV0mM0Uo+h6hq5N6tBa+uN2xA+BUbCVCu9DHBrde3BGKR
         tUWBvko6KywEIxeFVBGndQm556lwHleld9lw81gVJE6FplEQBzWSvAPE/dAPBGTeHwL2
         sc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686664718; x=1689256718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYEjJGS1UUCjJyusiKu9spXvZVC2LuJOiUk5VQb5qBg=;
        b=k69xtoKP2VoYOIv+uBns62JOxeYWPgQZp9H98oLx7Q+NBRQL3DoNs5/s/qdsf+e8pB
         lRZq5WJ2dP4koyX/jbZ+5UXIyfBYpCkCV0qu4C5EQBRr1R4fiCqlczkSs0py+1zTEdPn
         TEkvBhk2WrkpD5NUMEKeIHczpptwIr/848JUbsu9Ie46mqUN4qSey3zqHIAv80S8nZrs
         inGDbxYU1es4eBdMNNotvBHeMutBn3g9sDYhiFqrpS0UkS5xSrDPOoMaFK1RY3duDn65
         ZCF4B4lcGX9iPOCS8tbx8Cad8YmpvJ7eZmUDnJERQ9oz9cCLZfcelSPQ8UFWa9KR3mcb
         b9rQ==
X-Gm-Message-State: AC+VfDwgvS5uXimaY6F40HxSjHIqVy9prB1qZ2dtJBZkc1q+QgITvYNs
        pq01TjDo8LIPafPYu1IVWOrDzt5nfxfGc8cSV4M=
X-Google-Smtp-Source: ACHHUZ4SeTgZwVp9xbt9r8WkNO8LW+MR7fA9doV9DSkOr/bC5m6r+nBHbjgHbz+tZM+MSk/aawBhBw==
X-Received: by 2002:a2e:88d8:0:b0:2af:c9d8:87b4 with SMTP id a24-20020a2e88d8000000b002afc9d887b4mr4444624ljk.29.1686664717906;
        Tue, 13 Jun 2023 06:58:37 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id z6-20020a2e3506000000b002adb98fdf81sm2162821ljz.7.2023.06.13.06.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 06:58:37 -0700 (PDT)
Message-ID: <9c3db237-9bec-36e0-8b0c-28062c631068@linaro.org>
Date:   Tue, 13 Jun 2023 15:58:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 5/8] qcom: pmic_glink: enable altmode for SM8550
Content-Language: en-US
To:     neil.armstrong@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <8f9c549a-e37b-2877-be74-f25304a476fd@linaro.org>
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



On 13.06.2023 15:43, Neil Armstrong wrote:
> On 13/06/2023 13:54, Krzysztof Kozlowski wrote:
>> On 13/06/2023 09:55, Neil Armstrong wrote:
>>> Altmode is also supported for SM8550, allow it.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   drivers/soc/qcom/pmic_glink.c | 6 +-----
>>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
>>> index c87056769ebd..8af06bdc6f5a 100644
>>> --- a/drivers/soc/qcom/pmic_glink.c
>>> +++ b/drivers/soc/qcom/pmic_glink.c
>>> @@ -342,13 +342,9 @@ static const unsigned long pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT
>>>                                  BIT(PMIC_GLINK_CLIENT_ALTMODE) |
>>>                                  BIT(PMIC_GLINK_CLIENT_UCSI);
>>>   -/* Do not handle altmode for now on those platforms */
>>> -static const unsigned long pmic_glink_sm8550_client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
>>> -                               BIT(PMIC_GLINK_CLIENT_UCSI);
>>> -
>>>   static const struct of_device_id pmic_glink_of_match[] = {
>>>       { .compatible = "qcom,sm8450-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
>>
>> Orientation and maybe all of the USB-related properties do not look like
>> sm8450 specific, but PM8350B. That's where CC_OUT pin is. I don't think
>> we represented this correctly, but rather copy-pasted downstream solution...
> 
> We do not interact directly with PM8350B or PM8550B but with pmic_glink who
> does the work work for use, and this is platform specific.
Yep, pmic_glink is totally a firmware construct and not all platforms with
pm8350b or so implement it.

Konrad
> 
> Neil
> 
>>
>> Best regards,
>> Krzysztof
>>
> 
