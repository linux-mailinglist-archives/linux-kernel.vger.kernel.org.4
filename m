Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250F26054DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJTBRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiJTBRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:17:23 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B8614D8CA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:16:54 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id e15so16041990iof.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JnQOI3JWp7SXWPSReamQB4RFtAu5Vv0pd/V8+uGydZk=;
        b=ZgEgsh5n9ts2p8p1nciPXMTf4Z0plZE3ifLKT2Dgyeeg/JgxCRc2DkMp5a/Rg0THNX
         LH1fPTmVU7yS/+Hc8KKUr//ABfSbWbBd+yeYDZY1PQTl2SVCzpPgQag9IDuMuAsnQjQ6
         CbczFBrKPPHZi9GtpNtQ1MQM8GqtX8OFNgUqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnQOI3JWp7SXWPSReamQB4RFtAu5Vv0pd/V8+uGydZk=;
        b=uZR1tndHFkjE55kWac/oBcxFE8qUuoZbPetdn3negs7I2TzgXttzRLO2+BjJDxfBTg
         mzweGT/NcvFHVH7Ynlev1rP74VOlKTiRrEMLiteaTWPJ8MEBEj19x3YpTuZ/gCkfeerp
         dLYizJ8+D3Y/gHSoGoV5FpLCby0mpV6PhoYWzsB3nWEw/fBNssM/AP1iYhaPOMqaDFTr
         dTnf+EIRT3ZF1D9OZO2Ei5xvSVZO6bfEO23WxqNvfT51157yofWVmL1RcvifiX6S/7Lj
         nSh6KLLmS1XX6R91BItQeW8AQJc40kaZMAvlTYWUyf9bVqdVOOdhy4D6YECD1bWzYiuE
         9M4A==
X-Gm-Message-State: ACrzQf3uuoB5lcXNvYLTHqc1CnXuPeorlUU7YRfnWyEJ0oGMoSOq07cT
        mQfbTUCrgHFx3EJ0VdrzcRpuLkx4EBZlvQ==
X-Google-Smtp-Source: AMsMyM7PPUqXOhP+/7iEm6ku5ltSODVSKIvdLD9C7jIH1S5SazSNLfCWqu/1vctVkcqlgNdvhGJKog==
X-Received: by 2002:a05:6638:3c49:b0:363:c8dc:fb2f with SMTP id bg9-20020a0566383c4900b00363c8dcfb2fmr8598426jab.119.1666228594069;
        Wed, 19 Oct 2022 18:16:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x3-20020a029703000000b0035ad8fd5ce9sm2703864jai.147.2022.10.19.18.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 18:16:32 -0700 (PDT)
Message-ID: <bf250f10-fecf-7d42-e308-e817ee7a6a3a@linuxfoundation.org>
Date:   Wed, 19 Oct 2022 19:16:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Linux 6.1-rc1 drm/amdgpu regression
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <efe5a0a4-775e-bc6b-27c2-aa506f5613fa@linuxfoundation.org>
 <BL1PR12MB514408C626FE2D056C293693F72B9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <07c574f3-f523-a677-3597-aad4d5546869@linuxfoundation.org>
 <BL1PR12MB5144DF4E69621E99F99F1DA3F72B9@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <BL1PR12MB5144DF4E69621E99F99F1DA3F72B9@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 15:24, Deucher, Alexander wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Shuah Khan <skhan@linuxfoundation.org>
>> Sent: Wednesday, October 19, 2022 5:00 PM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>; linux-
>> kernel@vger.kernel.org; Shuah Khan <skhan@linuxfoundation.org>
>> Subject: Re: Linux 6.1-rc1 drm/amdgpu regression
>>
>> On 10/19/22 14:27, Deucher, Alexander wrote:
>>> [AMD Official Use Only - General]
>>>
>>>> -----Original Message-----
>>>> From: Shuah Khan <skhan@linuxfoundation.org>
>>>> Sent: Wednesday, October 19, 2022 4:00 PM
>>>> To: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>; Shuah Khan
>>>> <skhan@linuxfoundation.org>; linux-kernel@vger.kernel.org
>>>> Subject: Linux 6.1-rc1 drm/amdgpu regression
>>>>
>>>> Hi Alex,
>>>>
>>>> I am seeing the same problem I sent reverts for on 5.10.147 on Linux
>>>> 6.1-rc1 on my laptop with AMD Ryzen 7 PRO 5850U with Radeon Graphics.
>>>>
>>>> commit e3163bc8ffdfdb405e10530b140135b2ee487f89
>>>> Author: Alex Deucher <alexander.deucher@amd.com>
>>>> Date:   Fri Sep 9 11:53:27 2022 -0400
>>>>
>>>>        drm/amdgpu: move nbio sdma_doorbell_range() into sdma code for
>>>> vega
>>>>
>>>> I see that the following has been reverted in Linux 6.1-rc1
>>>>
>>>> commit 66f99628eb24409cb8feb5061f78283c8b65f820
>>>> Author: Hamza Mahfooz <hamza.mahfooz@amd.com>
>>>> Date:   Tue Sep 6 15:01:49 2022 -0400
>>>>
>>>>        drm/amdgpu: use dirty framebuffer helper
>>>>
>>>> However I still see the following filling dmesg and system is unusable.
>>>> For now I switched back to Linux 6.0 as this is my primary system.
>>>>
>>>> [drm] Fence fallback timer expired on ring sdma0 [drm] Fence fallback
>>>> timer expired on ring gfx [drm] Fence fallback timer expired on ring
>>>> sdma0 [drm] Fence fallback timer expired on ring gfx [drm] Fence
>>>> fallback timer expired on ring sdma0 [drm] Fence fallback timer
>>>> expired on ring sdma0 [drm] Fence fallback timer expired on ring
>>>> sdma0 [drm] Fence fallback timer expired on ring gfx
>>>>
>>>> Please let me know if I should send revert for this for the mainline as well.
>>>>
>>>
>>> Can you file a bug report
>> (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitl
>> ab.freedesktop.org%2Fdrm%2Famd%2F-
>> %2Fissues&amp;data=05%7C01%7CAlexander.Deucher%40amd.com%7C61b
>> 64b1be7294b27eb2308dab214dbe2%7C3dd8961fe4884e608e11a82d994e183d
>> %7C0%7C0%7C638018099904584274%7CUnknown%7CTWFpbGZsb3d8eyJWIj
>> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
>> 000%7C%7C%7C&amp;sdata=ZYA0bWZAGsxB91Bqcg1YAI704LhpISQX63bE67
>> UVO%2Bs%3D&amp;reserved=0) and attach your dmesg output?  I'd like to
>> try and repro the issue if I can and provide some patches to test.  I'd like to
>> avoid reverting the patch as that will break the driver for users using vega
>> dGPUs.
>>
>> Makes sense. I will file the bug and aattach dmesg. Since this is my primary
>> system, there will be some delay in getting this info. to you and testing any
>> patches you provide for testing.
>>
> 
> Actually I think I see what's wrong.  Can you try the attached patch?
> 

This patch worked. Clean boot without any warns and timer expiry messages
from drm/amdgpu.

thanks,
-- Shuah

