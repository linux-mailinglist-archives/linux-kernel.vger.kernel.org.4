Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5B96B192E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 03:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCIC1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 21:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCIC1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 21:27:08 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0EAC8885;
        Wed,  8 Mar 2023 18:27:06 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso2582363wmi.4;
        Wed, 08 Mar 2023 18:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678328824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NiBJc+JA9BKwOEqfoxTFrlQveSSWtgQVq5rv1cxE6S4=;
        b=jmTnArVt2CUNEJWbqY5aGHoO/zcrbhPWCt+BHWLqKa3otOMhWwKCxB7a1kj2l+DPbj
         foLZdk8OJeEuYIT6VuqptchkigK9eAt1ANz5uLBu07JBCdF4MITdrOAF2BR6yY/Hh4/x
         UWQ+NnpmvU/B2D334kJdv7u02NA/JU65KHt8rJjRmZ9ka2gMP0GZgkHkLuf927T2ltCQ
         1gU6sk7cTGOrGEWfHJE2CtqWEP8A0/2w/1lVxGx0oF3LbbIgaqRryILSt9HTrrui8PJr
         eJtp9v7HRcV/c3C4d+DfIomWZeRXNcVxkYJT/QGyj82vcJdUIgKqKQaIzxAoAdb2Tbw2
         CcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678328824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NiBJc+JA9BKwOEqfoxTFrlQveSSWtgQVq5rv1cxE6S4=;
        b=VHoQuXYYbIXhbQ/Gl9lXJfI4iOyZBbY63Hjpvdg6f5Z4j3SAndXJPJ+hCFKPX3lnM2
         AOl8S9OEeD1F1ih7lH58axrKf6WACwCOmKRRUWNxZWT0PE7C2CyjJSKN/Efsn8pUQ+WX
         IY4qbqIwwvGesGxTwKhvv6EsPcgUt6lj9TuiuMD3pUVhYoeTSLFJbYi6RZOtt5ow8/2U
         kQl1pqw2urDxPR0k9w8SVCagqa8tUYelomV/2rONFptC5z04Wxzp6ZpJV52wjk4WWMC9
         lMqXMp+j6e09ulNfp5EiJn5xom0GQg6NAVZu7xjyqxK7kb2qjz8fSyuXbmGEckhMuu3u
         Nabw==
X-Gm-Message-State: AO0yUKVfggsikYZ1ep8Km69YOzc0WupZdHqTyRLcDW7Q/C7zDlBGTY2O
        plQeM+RbcQUyXibzFKOPSLY=
X-Google-Smtp-Source: AK7set+yUg/5eATw94eWwrMFRUJvnUFMf0SEtj7rRaP0O+/wCpy+h9jGcW8TDAlbtDi10DiEOcmGjw==
X-Received: by 2002:a05:600c:5123:b0:3ea:ecc2:daab with SMTP id o35-20020a05600c512300b003eaecc2daabmr19370990wms.3.1678328824452;
        Wed, 08 Mar 2023 18:27:04 -0800 (PST)
Received: from [192.168.2.202] (pd9ea3a5b.dip0.t-ipconnect.de. [217.234.58.91])
        by smtp.gmail.com with ESMTPSA id s18-20020a05600c45d200b003e8dcc67bdesm1100136wmo.30.2023.03.08.18.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 18:27:03 -0800 (PST)
Message-ID: <951c717b-d094-4190-a04b-3ce9007d1554@gmail.com>
Date:   Thu, 9 Mar 2023 03:27:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 3/4] dt-bindings: firmware: Add Qualcomm QSEECOM
 interface
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <c92a44fe-7057-2d81-41fc-2e84ae60f881@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/23 02:33, Dmitry Baryshkov wrote:
> On 09/03/2023 00:44, Maximilian Luz wrote:
>> On 3/8/23 23:16, Rob Herring wrote:
>>> On Sun, Mar 05, 2023 at 03:21:18AM +0100, Maximilian Luz wrote:
>>>> Add bindings for the Qualcomm Secure Execution Environment interface
>>>> (QSEECOM).
>>>
>>> Pretty sure I already asked, but no answer in the commit message. Why do
>>> we need this? You've already declared the platform supports SCM calls
>>> with "qcom,scm". Why can't you probe whether you have QSEECOM or not? DT
>>> is for non-discoverable h/w we are stuck with.
>>
>> Yes, you've asked this before but I can only repeat what I've written in
>> my last response to your question: I am not aware of any way to properly
>> discover the interface at runtime from software.
>>
>> If it makes you happy, I can put this in the commit message as well...
>>
>>> Why is software made non-discoverable too?
>>
>> Please direct that question at the Qualcomm guys who actually designed
>> that interface. I can't give you an answer to that, and I'm not all that
>> happy about this either.
>>
>> To reiterate: I've reverse engineered this based on the Windows driver.
>> The Windows driver loads on an ACPI HID and it doesn't use any function
>> to check/verify whether the interface is actually present. Adding a DT
>> entry is the straight-forward adaption to having a HID in ACPI.
>>
>>> Nodes with only a compatible string are usually just an abuse of DT to
>>> instantiate some driver.
>>
>> If you or anyone here has any idea on how to discover the presence of
>> this, please feel free to let me know and I'd be happy to implement
>> that. Until then, I unfortunately don't see any other way of dealing
>> with this.
> 
> You can probably try requesting QSEECOM version. According to msm-3.18:
> 
>          uint32_t feature = 10;
> 
>          rc = qseecom_scm_call(6, 3, &feature, sizeof(feature),
>                  &resp, sizeof(resp));
>          pr_info("qseecom.qsee_version = 0x%x\n", resp.result);
>          if (rc) {
>                  pr_err("Failed to get QSEE version info %d\n", rc);
>                  goto exit_del_cdev;
>          }
> 

Thanks! I'll give that a try.

As I can't test this on a device that doesn't have qseecom, it would
probably be a good idea if someone could test this on a device that has
qcom_scm but no qseecom (if those even exist) to make sure this doesn't
misbehave.

Regards,
Max
