Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36BA6ABFA4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjCFMgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjCFMgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:36:52 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1F22885D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 04:36:51 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s11so37843873edy.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 04:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678106210;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NzhqElhQCwcyvtBrYC9r9nYdgqAwUW/DVf5xm22oBWg=;
        b=wkBwg8qzuDMtgTDjK5S5omZUgi1Z4gkphuXyEGSrUBWwhGiXchoCt6TZvuMiRTZNb/
         5I8AYTngfbLxet2Mv33CKLey4iOSLmQFopsXUzziQMiyCSrn4WxBrASb0mjy8UG47Jx1
         c2sXbKmghxfs9RuKfV63QSfJIqJHNuW8TPYlJM0E20cBvN1N9jDq2HII5G7MmKplGCDg
         vsKRRg+i0d3xQZrhIOENd2FQZ+25Xwn5CMNonZM2UpEThMFmE9+eyPHu8wcWJrE9CKR/
         +HFZ/b7pytnFthcgaR9RESi0n5Vre4rS/S5FtloJhc3x0nGJchjOM9kQ9KVhLf6n8c+3
         mtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678106210;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NzhqElhQCwcyvtBrYC9r9nYdgqAwUW/DVf5xm22oBWg=;
        b=RMbWykCtVBClhsZCFMw6x8Qd3osZ97y1VF/5BbiXexq4ntH1t0m5mDNEYJPEfdRfRm
         RRrlTEyYxlb1ezFi02CmCnysA6Ll7HEdpbuvgmpYxR8m2ND+K2Ye5r6ZK/0EfnyS3rwC
         rQ/54B8WIdkiR3H4FfCywjbWEoU9ykSpMLk1pOvm0IC1utVtH1tJ7Ml2z5a4Y0LgYSbB
         EOI0OgEOhPlqgXasL0wvCv5NvavjeMTNtlDyHuoTeYBsdsK57qPWq1qS2B1BXvn3uNiC
         7VTIBVHHHm1wPCefYCR3h61IhLnwAOB/Ba2F2GIrkMwsYwfqSkwnHO7pJibO4dMUkUVy
         pX+g==
X-Gm-Message-State: AO0yUKXxMYPbeMI+J31G74D/+hP2oAWkiZ7QfTCM5sDKZnztLD9B8oFb
        3Cj1rjxHX9K0Tox5RZ6HCmX0AQ==
X-Google-Smtp-Source: AK7set8Q67RwECSXFAu9jEdC7yPlWMxk4c0N9zRMp7JKPMe0f9V71x40Y+lyas1nnKj4zfzoeZjhQA==
X-Received: by 2002:aa7:d6d5:0:b0:4c3:8bde:c250 with SMTP id x21-20020aa7d6d5000000b004c38bdec250mr10666666edr.33.1678106209747;
        Mon, 06 Mar 2023 04:36:49 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:d85d:5a4b:9830:fcfe? ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id p7-20020a50cd87000000b004aef147add6sm5052914edi.47.2023.03.06.04.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 04:36:49 -0800 (PST)
Message-ID: <3fce171e-3503-3ed9-91a6-7718fa1c12e6@linaro.org>
Date:   Mon, 6 Mar 2023 13:36:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] soc: qcom: icc-bwmon: Handle global registers
 correctly
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230304-topic-ddr_bwmon-v1-0-e563837dc7d1@linaro.org>
 <20230304-topic-ddr_bwmon-v1-2-e563837dc7d1@linaro.org>
 <a85c9c5d-b57d-9212-0e24-1991b5b580b3@linaro.org>
 <56b5e7ff-2dbe-74da-c325-5e5cf546b1ff@linaro.org>
 <2b086263-6b42-b882-6d38-1c4dbc361773@linaro.org>
 <8ab61b63-3d5f-0ea1-3624-5e167832e357@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8ab61b63-3d5f-0ea1-3624-5e167832e357@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 13:17, Konrad Dybcio wrote:
>> That's still nothing to fix - msm8998 was added here only for
>> compatibility reasons for bindings. It wasn't ever tested on MSM8998 and
>> also probably never written in a way that it should work for MSM8998.
> Don't you think making something like
> 
> compatible = "qcom,msm8998-bwmon"
> 
> not actually compatible with MSM8998 is a bit wrong?

I would argue that's the binding problem, but I get your point. Driver
just incorrectly stated that it could work with msm8998.

> 
>  It
>> could work, but that was not the intention. The driver is supposed to
>> work on sdm845 and according to your description - there is nothing
>> wrong with that.
>>
>>>

(...)

>>>
>>>>
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ) {
>>>>> +		/* Map the global base, if separate */
>>>>> +		base = devm_platform_ioremap_resource(pdev, 1);
>>>>
>>>> Wouldn't this now print errors for sdm845, thus introduce dmesg regression?
>>> I explicitly stated this in the cover letter and asked for opinions.
>>>
>>
>> Sorry, long time ago I stopped reading cover letters, maybe except it's
>> top few sentences. Just too many of them and too much of text usually
>> useless. Commits should describe everything as they go to the Git and
>> they should justify their own existence.
>>
>> Anyway, above dmesg error regression is a no. The devices turn out not
>> to be compatible with each other so just adjust the bindings and match
>> each driver by proper compatible string.
> So what am I supposed to do here? Add "qcom,msm8998-actual-msm8998-bwmon"?

No, make msm8998 binding working for msm8998 and add entry for sdm845.


> Otherwise, changing msm8998 data would break 845-8550, unless I added all
> of them to a separate match table.

Exactly.

>  Or I can add some boilerplate C code
> that would not throw a warning, or perhaps try and introduce
> devm_platform_ioremap_resource_optional..
> 
> I guess the last option sounds the best.

Best regards,
Krzysztof

