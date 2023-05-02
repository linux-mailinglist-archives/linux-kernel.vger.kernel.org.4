Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600736F4206
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjEBKxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjEBKxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:53:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E21AE43;
        Tue,  2 May 2023 03:52:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f199696149so21946615e9.0;
        Tue, 02 May 2023 03:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683024775; x=1685616775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0eKN6Hr0G4edMHhhouzATJjO1XXtrTwSyKCJRRXUqE=;
        b=nm/ucSki+JtJnvCn2wD+bINJ6vykRra42C5U7MDdJIYTIGU/Bz+lUqtl1wHrHmaLLD
         T3u2t913CDE1EOLQg2jPQw+IzywCRa0gJdJ/slYGA+Anrc99D77NVEnU2Ky0MP09H5mh
         79KbTCHRq57NdWKEsC7WfA5PyqX0Daz5NUGOwEb3NpT/HhVwawxIjqOtm/ERvrqDBiHe
         /EKOiyhTyEi7xFL2zLlzr3Wt5wWPuIcpOCQMh7OOE9l0tVE5LPzv1DgkxvlE117T8yyq
         65rpGDVpffFdyaUwoJMqLE8Na2vO/joStNAMCstRAo0NpImrs7WPxusO3eXBEvch9uy9
         cR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683024775; x=1685616775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0eKN6Hr0G4edMHhhouzATJjO1XXtrTwSyKCJRRXUqE=;
        b=VhAiKQioK/Yu4o95usVBqyjbFv43yIFjZMZ2F8nGfNsGAU6bPzFJZQwE0qctuzFj4h
         qgLy1d5frmtLnLc3DpBI4MdnT/cfwwTZ/RpiEoumlM8s/fEVbFcnYyHJB5d+lUC2tpUf
         nNVhFVYjniEAYoyt9GryOtGNV0ZxQGXvPl+twDZ3LnlrO1vh5ctx+9fgiRd3KThlzbwu
         G9qSH9iKBKeaBQGuW0Hk3s7UN6mkBm+hFXmiERQf+/61+VOe6WM0AOgz5ejzVBRf8q51
         MlOMNiABlo+X/HU5YeLYdFKBICDdLoPUcvoYjNPLg88M+zPA/1je+3e8/B9bHkEGRjOp
         r9fQ==
X-Gm-Message-State: AC+VfDzKe3TFE4ZK4b8fEVIWZstNbf0NlBlPt9exOIH8m/pGrkJ8pfUn
        zo8owgJqIsDwLFQf2RAd4jUP9ddRpvg=
X-Google-Smtp-Source: ACHHUZ7dMJBh/WMLCiOzm19U40TcGV3xJ78HP0JWuJAbAVkDHk91dAuauGwizFfZGQh+E850CANtoA==
X-Received: by 2002:a7b:c046:0:b0:3f1:9b85:e305 with SMTP id u6-20020a7bc046000000b003f19b85e305mr11816259wmc.34.1683024775471;
        Tue, 02 May 2023 03:52:55 -0700 (PDT)
Received: from [192.168.2.202] (pd9ea3834.dip0.t-ipconnect.de. [217.234.56.52])
        by smtp.gmail.com with ESMTPSA id l10-20020a1c790a000000b003f32f013c3csm9872477wme.6.2023.05.02.03.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 03:52:54 -0700 (PDT)
Message-ID: <4dd1860d-c5bf-cfe4-b4ae-e77207295b92@gmail.com>
Date:   Tue, 2 May 2023 12:52:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/4] dt-bindings: firmware: Add Qualcomm QSEECOM
 interface
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
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
 <20230502083829.qetjuvoilows26m7@bogus>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20230502083829.qetjuvoilows26m7@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/23 10:38, Sudeep Holla wrote:
> On Thu, Mar 09, 2023 at 03:27:01AM +0100, Maximilian Luz wrote:
>> On 3/9/23 02:33, Dmitry Baryshkov wrote:
>>> On 09/03/2023 00:44, Maximilian Luz wrote:
>>>> On 3/8/23 23:16, Rob Herring wrote:
>>>>> On Sun, Mar 05, 2023 at 03:21:18AM +0100, Maximilian Luz wrote:
>>>>>> Add bindings for the Qualcomm Secure Execution Environment interface
>>>>>> (QSEECOM).
>>>>>
>>>>> Pretty sure I already asked, but no answer in the commit message. Why do
>>>>> we need this? You've already declared the platform supports SCM calls
>>>>> with "qcom,scm". Why can't you probe whether you have QSEECOM or not? DT
>>>>> is for non-discoverable h/w we are stuck with.
>>>>
>>>> Yes, you've asked this before but I can only repeat what I've written in
>>>> my last response to your question: I am not aware of any way to properly
>>>> discover the interface at runtime from software.
>>>>
>>>> If it makes you happy, I can put this in the commit message as well...
>>>>
>>>>> Why is software made non-discoverable too?
>>>>
>>>> Please direct that question at the Qualcomm guys who actually designed
>>>> that interface. I can't give you an answer to that, and I'm not all that
>>>> happy about this either.
>>>>
>>>> To reiterate: I've reverse engineered this based on the Windows driver.
>>>> The Windows driver loads on an ACPI HID and it doesn't use any function
>>>> to check/verify whether the interface is actually present. Adding a DT
>>>> entry is the straight-forward adaption to having a HID in ACPI.
>>>>
>>>>> Nodes with only a compatible string are usually just an abuse of DT to
>>>>> instantiate some driver.
>>>>
>>>> If you or anyone here has any idea on how to discover the presence of
>>>> this, please feel free to let me know and I'd be happy to implement
>>>> that. Until then, I unfortunately don't see any other way of dealing
>>>> with this.
>>>
>>> You can probably try requesting QSEECOM version. According to msm-3.18:
>>>
>>>           uint32_t feature = 10;
>>>
>>>           rc = qseecom_scm_call(6, 3, &feature, sizeof(feature),
>>>                   &resp, sizeof(resp));
>>>           pr_info("qseecom.qsee_version = 0x%x\n", resp.result);
>>>           if (rc) {
>>>                   pr_err("Failed to get QSEE version info %d\n", rc);
>>>                   goto exit_del_cdev;
>>>           }
>>>
>>
>> Thanks! I'll give that a try.
>>
>> As I can't test this on a device that doesn't have qseecom, it would
>> probably be a good idea if someone could test this on a device that has
>> qcom_scm but no qseecom (if those even exist) to make sure this doesn't
>> misbehave.
>>
> 
> TBH, this has been going in round for quite sometime. We have been asking
> you to depend on existing platform compatible + a query or a check on the
> version. Since you do have a platform that is working, we can start making
> it min "qseecom.qsee_version" supported and then adjust the version based
> on the testing or the requirement. What do you think ?
Sure, I will add a minimum version check to that.

Regards,
Max
