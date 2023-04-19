Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485E46E7F77
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjDSQUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjDSQUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:20:37 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CA42727
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:20:35 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4edbd6cc46bso2864606e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681921234; x=1684513234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ajS5AwxNAy2StLCvTIgtNL2E/BG5ps9eI73QSwxiK0o=;
        b=WgCraIJeytpaVNDyRFYnEcSSd0AK31/l2q4zlRFQPqpG/SfRk6BHFpgSX8NfNdhahQ
         GHJXZoVyf932ZGFKkVGxqpRbmxNgEfQpB5f/9JTEfB96StJgPapjvSrJI51fOUR3+l9c
         FEb6Uzt44RB+SLfbTk6dhjnP7Gyl5khb1G+1Qs5rV0K84vq/aUFEjw6+UNNOrCOiB4k+
         b6qxmoqZP0RfaoM0nWzzdsScx25XX60puYEaANlHfrkp6GlM2/jPEi3W55WdtvfSuVCo
         6IdOvjlzIUGdrWWKzCFCsKZJd90mlEGSYVvIcjWW0jGiMfM5Q3eVjoK4pyU9jb5M6YSC
         dsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681921234; x=1684513234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajS5AwxNAy2StLCvTIgtNL2E/BG5ps9eI73QSwxiK0o=;
        b=NvDPiPidQA9MlHbRnJAKSs4wv0pLnxnYO5TQ+Cp1WCDN3ZnZGx84GZ4PRh2cwI4gUO
         Kool/ACeIgyjP9Xrd0d6mCy/LNm3L5aEPa5hP6Mld8QWSqoIGrOc/DFtbdjZZaoAS1bB
         6OOOMkwpPqAkYL+jPKYHBld8lto/CP/Vq05TNIm+wszrFv36CouRhvu936ukjFCkoxj1
         GA3dxC68SaKI8GteuazbACRwaqChJDni480WGbeuAOYuXrVs1+DJf3QnoEU13he1QCYY
         3E5MNsQCWey4ZIxu6PL8/MP8+qqoJG/k7FqJ0i9f0XNr8SAUGDeWAwq+RosyXtVuMOnP
         kTew==
X-Gm-Message-State: AAQBX9eAUGYek5lSDq+HHLWcQuRDFjW9o3wijqpOT0ew+Fvy0eutx65c
        55yvwWKHLcklawiscftkF3NXTQ==
X-Google-Smtp-Source: AKy350bqi18ppcGPBlkMku8yd3Jx5EyZwDkYGPgR2kbJpG00DnGcpfdYtIrhfwi4ng3KClUhyYSqnw==
X-Received: by 2002:ac2:4942:0:b0:4ec:9df9:f11a with SMTP id o2-20020ac24942000000b004ec9df9f11amr3992000lfi.9.1681921233811;
        Wed, 19 Apr 2023 09:20:33 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id f19-20020ac251b3000000b004db4936c866sm2718538lfk.38.2023.04.19.09.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 09:20:33 -0700 (PDT)
Message-ID: <6862340f-64fa-c0cb-8d20-f8f4d14038e9@linaro.org>
Date:   Wed, 19 Apr 2023 18:20:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] ARM: dts: qcom: msm8974: correct qfprom node reg
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Craig Tatlor <ctatlor97@gmail.com>
References: <20230130-msm8974-qfprom-v1-1-975aa0e5e083@z3ntu.xyz>
 <5664419.DvuYhMxLoT@z3ntu.xyz>
 <383f6aa0-6150-22b5-425a-f9cf13bdbc50@linaro.org>
 <4820647.31r3eYUQgx@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <4820647.31r3eYUQgx@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.04.2023 18:18, Luca Weiss wrote:
> On Mittwoch, 19. April 2023 18:12:04 CEST Konrad Dybcio wrote:
>> On 19.04.2023 18:00, Luca Weiss wrote:
>>> Hi Konrad,
>>>
>>> On Montag, 30. Jänner 2023 21:37:29 CEST Luca Weiss wrote:
>>>> On Montag, 30. Jänner 2023 19:42:51 CET Konrad Dybcio wrote:
>>>>> On 30.01.2023 19:36, Luca Weiss wrote:
>>>>>> On Montag, 30. Jänner 2023 19:30:04 CET Konrad Dybcio wrote:
>>>>>>> On 30.01.2023 19:20, luca@z3ntu.xyz wrote:
>>>>>>>> From: Craig Tatlor <ctatlor97@gmail.com>
>>>>>>>>
>>>>>>>> The qfprom actually starts at 0xfc4b8000 instead of 0xfc4bc000 as
>>>>>>>> defined previously. Adjust the tsens offsets accordingly.
>>>>>>>>
>>>>>>>> [luca@z3ntu.xyz: extract to standalone patch]
>>>>>>>>
>>>>>>>> Fixes: c59ffb519357 ("arm: dts: msm8974: Add thermal zones, tsens and
>>>>>>>> qfprom nodes") Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
>>>>>>>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>>>>>>>> ---
>>>>>>>
>>>>>>> Isn't this a raw vs ecc-corrected values problem?
>>>>>>
>>>>>> Not quite sure what you mean.
>>>>>
>>>>> The QFPROM is split into two parts: one where raw values
>>>>> are stored, and the other one where ECC-corrected copies
>>>>> of them reside. Usually it's at offset of 0x4000. We should
>>>>> generally be using the ECC-corrected ones, because.. well..
>>>>> they are ECC-corrected.. You may want to check if the
>>>>> fuse you're adding reads the same value at +0x4000.
>>>>
>>>> Yeah that actually seems to work...
>>>>
>>>> But downstream's using this +0x4000 only for tsens it seems
>>>>
>>>>    <0xfc4bc000 0x1000> as "tsens_eeprom_physical"
>>>>
>>>> qcom,clock-krait-8974 is using this:
>>>>     <0xfc4b80b0 0x08> as "efuse"
>>>>
>>>> Also seems HDMI driver is using a mix for HDCP stuff
>>>>
>>>>   drivers/video/msm/mdss/mdss_hdmi_util.h:
>>>>     /* QFPROM Registers for HDMI/HDCP */
>>>>     #define QFPROM_RAW_FEAT_CONFIG_ROW0_LSB  (0x000000F8)
>>>>     #define QFPROM_RAW_FEAT_CONFIG_ROW0_MSB  (0x000000FC)
>>>>     #define HDCP_KSV_LSB                     (0x000060D8)
>>>>     #define HDCP_KSV_MSB                     (0x000060DC)
>>>>
>>>> Any clue why Qualcomm used it this way in downstream? I'd rather not
>>>> deviate too much if not for a good reason...
>>>
>>> Any comments on the above?
>>
>> This thread got burried to deep in the mailbox!
>>
>> I see two reasons why they could be using the uncorrected region:
>> - their generators are messed up in general
>>
>> - they may have had an early chip revision once where there were
>>   problems with this and their generators were messed up to
>>   accommodate for it and everybody forgot to fix that
>>
>> No other good explanations as far as I'm aware!
> 
> So, resolution is to use the offsets as declared in downstream, so take this 
> patch to have the full range available?
No, the correct resolution to "fix QFPROM reg" would be to
increase the size to 0x7000-0x4000 = 0x3000, as we should be
using the ECC-corrected entries.

Konrad
> 
> Regards
> Luca
> 
> 
> 
