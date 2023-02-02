Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BAC688324
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjBBPyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjBBPys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:54:48 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26005B5B8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:54:41 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so1769084wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 07:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/oko1AtD/XSyITvqWacNf29ZVg1C2BAcH6xewV2Bxwc=;
        b=lH8NhXATnGk9E/V8Qfu020E2KAmUSNQdczW9g4CL3jhDacpSB4MIIRHUB5inx0OSIm
         IKBgIfgv9jmj/oR6dUdkaGsWY9zhVS17mRu6H8s4YRtLWfmS5j6Gxs4Gugm5UoaDIfyd
         /wXKpYcCc4mGSAQuN5IWxB/IhCa8JneXOybHrWolqjlMn61Rt9H5HkPNKav7Sb9ZC1aK
         yiEk1Ng5ZAbMI3iO+l9Ndmsxv9JslBaqFVDyV6q33dWYwWS3UhaCtCXCMZQwci1F6Ks0
         wtECRkbnDLo+3wf4q3Wzd1z1OuLeGvZHG7axNBtmGe+dGcWVQaR6MEvWtwLUwZTpcCan
         TNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/oko1AtD/XSyITvqWacNf29ZVg1C2BAcH6xewV2Bxwc=;
        b=LCLhGYBMpuue5n0JR+Vy93OTRqOCb/SUHx3OhvwIlxze5pmVIOnhyhyT3JFTCSc7p0
         hHwr9enNvzZBdmhc/Lm+mgDv+nFI8qCMP0NdB9pScaW936uH/0p1gXAxO/qK1KctUqCf
         jrepbBh6rL4fuU+TEhbI/a0XX3+KD1F+VBzabC/aXn39n3JuW/JCy7d3OjhMbD27Dnbx
         k0yDFvl0VlJEtraXjqX7qrzxnhc+rOjSoMoA/yJH1VLnQ8Q08jBW2IsgHytp+0r4HrOJ
         YvocDARIsKhBvPexwtuM1z1HvIWji+yD3MAnQeHYZA2OICAS+RypKIP1uxRnRY8thlJc
         WTRQ==
X-Gm-Message-State: AO0yUKUw9JLXP2/ekC4s64Jz1iLHc6JmYxwkSzIkJiC2LvV1QUg5pDeR
        euL65j9P5nMRlQVpTGShJ4wwug==
X-Google-Smtp-Source: AK7set9nxuLA4Rl0qj6e0anHvgyTf+KX0bcf8L9UJihEp9Etud61rhMgWmH5ObfVUKPW6EF2891gAA==
X-Received: by 2002:a05:600c:3d99:b0:3df:6c44:e083 with SMTP id bi25-20020a05600c3d9900b003df6c44e083mr4656044wmb.7.1675353280238;
        Thu, 02 Feb 2023 07:54:40 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id k19-20020a05600c1c9300b003dc43a10fa5sm156215wms.13.2023.02.02.07.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 07:54:39 -0800 (PST)
Message-ID: <ce001aa9-c18e-553c-2b09-fed407348e78@linaro.org>
Date:   Thu, 2 Feb 2023 16:54:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] thermal/drivers/intel: Use generic trip points for
 intel_soc_dts_iosf
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
References: <20230118181622.33335-1-daniel.lezcano@linaro.org>
 <20230118181622.33335-3-daniel.lezcano@linaro.org>
 <CAJZ5v0jbHR03UyJBMmBBYnSsZmGG0OXqLJvMfXxXKVn4Np4Egw@mail.gmail.com>
 <beb367d8-dad7-87d9-7872-b81a4d3492ae@linaro.org>
 <CAJZ5v0hFG1VjzKubWkLYPXeGHN9sMt4SDdC_f-dLseaXpsAOKg@mail.gmail.com>
 <c7c7d71d-28e1-310e-2c8f-e5ae53a09f78@linaro.org>
 <CAJZ5v0hP_5kOG7kE13fTLRgdiQrz7fskeAWBNW48MSD5t7FnvA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hP_5kOG7kE13fTLRgdiQrz7fskeAWBNW48MSD5t7FnvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 15:43, Rafael J. Wysocki wrote:
> On Thu, Feb 2, 2023 at 3:36 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Rafael,
>>
>> On 31/01/2023 20:17, Rafael J. Wysocki wrote:
>>
>> [ ... ]
>>
>>>>> Why should temp be overwritten here?
>>>>
>>>> You are correct. This is wrong.
>>>>
>>>> I think we should call get_trip_temp() before calling update_trip_temp()
>>>> instead of passing a zero temperature parameter
>>>
>>> update_trip_temp() is sort of a misnomer, because it is used for
>>> initializing a trip point for example in
>>> intel_soc_dts_iosf_add_read_only_critical_trip() and in this
>>> particular case get_trip_temp() need not be called before it.
>>>
>>> This driver seems to be in need of a cleanup.
>>
>> Will you take care of this cleanup ?
> 
> I think I can do that, but I'm not sure how much time I will be able
> to allocate for that.  Let me try though.

Great, thanks for your help


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

