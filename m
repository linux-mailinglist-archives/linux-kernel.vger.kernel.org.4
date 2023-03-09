Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AE56B1DC2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCIIWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCIIVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:21:39 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08EF91B49
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:19:07 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id i28so1297662lfv.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678349946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwuFFblgA/6mMh+9BhT85lbNG/sqegQy2duoDGSIQzY=;
        b=KvzjMf/JWO1pBjPq8a237X8jOMAkKVrhwqi88Jb3jqqRA9HT+QKBToafEYaJcwQ5uy
         ZgR5keAiqmRosWx44y1VkuBxN4z8KKFgZnXRpdBQe9AgdJfV7jylZ4GXf6KYgx29k0g7
         80aWd9cM+/q0SW2vcaiJniNT/FkYiSlDRby/AjL9gfsxAucAptaBOLXCcvpPGTo2OFSj
         /kWJ3/G7ccvk2wHLC8OfcxMMVToLgML5qvyx5nOGuCOupkHBcy74zDbzJf/uxON2hbfv
         3wDnEyUp3rLuyXA45qbbacZyXRF7gcp3HtdilipmWb9yO4Ai4lNsCclIBx1z4UXkkd1W
         NsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678349946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwuFFblgA/6mMh+9BhT85lbNG/sqegQy2duoDGSIQzY=;
        b=1/zMi3SdRzbiVI8IAJ+Um8g+C98jbMZrxXh7nZXPE5kRp3rBKIE6RVoCwlGpgHVlnx
         9bn33zTzFewcWdHDP6+Dr8AKG39FJVHcCS81JHhkMKreTeFyzbxG1rq72/hAhiihc7Qh
         eLPnMk3LdyxasqkzrQVUHrsULGzIREEf+0dOxfGeUEtd1zxwlJRtnCJdEh+UUSYuMUUk
         ySpXpOHTel3rg91O4iTKoj0gH2ZNebdViCZNjQoIBGZOg0kleuw/DKRyvNs5ETobjg7q
         9203iR4Ptgoomt+Ds9qAfjbHtlzXFWYxPcCwclzulcoQc3Vy6ePl7hizGSUyoPoHjT81
         aZug==
X-Gm-Message-State: AO0yUKUKheZAtWeRaG9T9Bn3WgfP95MYTjJxQaZET4R6u93FX2rsIxaf
        kWBuZhbD7wKC3RGPbLEXSaJT1S/M7NDUTPyVvJ4=
X-Google-Smtp-Source: AK7set+yMMwDK7D5K2YeJPTs3/fhE5EnmWs3IGS5Bb/1p+BXyEKSlu/uKKpxH6iBWN1zteMsPitjYg==
X-Received: by 2002:ac2:555e:0:b0:4e3:448:c000 with SMTP id l30-20020ac2555e000000b004e30448c000mr5427853lfk.33.1678349945763;
        Thu, 09 Mar 2023 00:19:05 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id y2-20020ac24462000000b004b5adb59ed5sm2565614lfl.297.2023.03.09.00.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 00:19:05 -0800 (PST)
Message-ID: <57b436d2-79f9-a7c1-ab97-0b555beb6468@linaro.org>
Date:   Thu, 9 Mar 2023 10:19:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 3/4] dt-bindings: firmware: Add Qualcomm QSEECOM
 interface
Content-Language: en-GB
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230305022119.1331495-1-luzmaximilian@gmail.com>
 <20230305022119.1331495-4-luzmaximilian@gmail.com>
 <20230308221657.GA3935330-robh@kernel.org>
 <93657561-d545-7ead-7f6c-dd2c62aab319@gmail.com>
 <c92a44fe-7057-2d81-41fc-2e84ae60f881@linaro.org>
 <951c717b-d094-4190-a04b-3ce9007d1554@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <951c717b-d094-4190-a04b-3ce9007d1554@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 04:27, Maximilian Luz wrote:
> On 3/9/23 02:33, Dmitry Baryshkov wrote:
>> On 09/03/2023 00:44, Maximilian Luz wrote:
>>> On 3/8/23 23:16, Rob Herring wrote:
>>>> On Sun, Mar 05, 2023 at 03:21:18AM +0100, Maximilian Luz wrote:
>>>>> Add bindings for the Qualcomm Secure Execution Environment interface
>>>>> (QSEECOM).
>>>>
>>>> Pretty sure I already asked, but no answer in the commit message. 
>>>> Why do
>>>> we need this? You've already declared the platform supports SCM calls
>>>> with "qcom,scm". Why can't you probe whether you have QSEECOM or 
>>>> not? DT
>>>> is for non-discoverable h/w we are stuck with.
>>>
>>> Yes, you've asked this before but I can only repeat what I've written in
>>> my last response to your question: I am not aware of any way to properly
>>> discover the interface at runtime from software.
>>>
>>> If it makes you happy, I can put this in the commit message as well...
>>>
>>>> Why is software made non-discoverable too?
>>>
>>> Please direct that question at the Qualcomm guys who actually designed
>>> that interface. I can't give you an answer to that, and I'm not all that
>>> happy about this either.
>>>
>>> To reiterate: I've reverse engineered this based on the Windows driver.
>>> The Windows driver loads on an ACPI HID and it doesn't use any function
>>> to check/verify whether the interface is actually present. Adding a DT
>>> entry is the straight-forward adaption to having a HID in ACPI.
>>>
>>>> Nodes with only a compatible string are usually just an abuse of DT to
>>>> instantiate some driver.
>>>
>>> If you or anyone here has any idea on how to discover the presence of
>>> this, please feel free to let me know and I'd be happy to implement
>>> that. Until then, I unfortunately don't see any other way of dealing
>>> with this.
>>
>> You can probably try requesting QSEECOM version. According to msm-3.18:
>>
>>          uint32_t feature = 10;
>>
>>          rc = qseecom_scm_call(6, 3, &feature, sizeof(feature),
>>                  &resp, sizeof(resp));
>>          pr_info("qseecom.qsee_version = 0x%x\n", resp.result);
>>          if (rc) {
>>                  pr_err("Failed to get QSEE version info %d\n", rc);
>>                  goto exit_del_cdev;
>>          }
>>
> 
> Thanks! I'll give that a try.
> 
> As I can't test this on a device that doesn't have qseecom, it would
> probably be a good idea if someone could test this on a device that has
> qcom_scm but no qseecom (if those even exist) to make sure this doesn't
> misbehave.

I could not find a vendor dts which doesn't have the qseecom device 
(checked the source trees from 3.4 to the latest revisions).

-- 
With best wishes
Dmitry

