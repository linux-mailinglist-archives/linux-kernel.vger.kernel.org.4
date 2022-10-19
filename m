Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBE06051AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 22:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiJSU7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 16:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiJSU7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 16:59:50 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BAE36BF3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:59:47 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 187so15568537iov.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZne8BsABy34ud9c/ptUC1xGSRXkefE9UK68qBCg884=;
        b=YSIz1NzBFUypmr5uuivAs5Fi6j4P91APPKbbtuMmvwUNQ/oVJ7yxKqW4swjLxE3+rg
         c3VE9Kuf/hE9l9R/rYhgJ2H8VrX/HOQerHVkkUW6UB0xN0acGfEq+SaNpPPcUElZ+al0
         gpr7vjJ11eu9aeGTS5wVa+L4ku3/tfNkvE7MQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZne8BsABy34ud9c/ptUC1xGSRXkefE9UK68qBCg884=;
        b=b7Bq6mUTkwUK+hpjPGA/wpFbwcNrEaI8JNDyhNd9mAi5IyCNUxxJy/CxQCmvxAOBf4
         hPYMGVqwrPesjpzbpaVS+hCsLmsjXvxn1wQs//UWX3TMbj/0RcKa9XNBXmjgsxTWvM7w
         NnTm8DhLnun0tMXllWe4xzj28u+w3G0N2vB0K0YgkgDkDTFleCsRMJwFPRFcc8jufsW2
         YACOymjQo3r5DGFjqNrKpFpwVxgLAKC1Ml+ptPEDyuPWomLhvxOXtW1dd0gBVpfKemrQ
         RzSXXynE0KOzF4LBsbRHfsBDVz6Wzf4rZhg5LL7VnXKmd49w6TfWF/xr7U607KJ+FsQW
         lMSA==
X-Gm-Message-State: ACrzQf1pqRwcU7n5X7yKTL641q7iyFDmxtLLpNTvkaFQFdXuVOHD+hIW
        LogbVGJowyc8L2txKGU8Hq3itjZ3QXS6kg==
X-Google-Smtp-Source: AMsMyM6yD5WRIbympNkKtlKUVzOIxuZtA1ZlKUunOUfvz8Mf/lLqMPBIFS1A82X+SftUrCfn+3tczg==
X-Received: by 2002:a05:6638:24cf:b0:363:b397:dce5 with SMTP id y15-20020a05663824cf00b00363b397dce5mr8287149jat.26.1666213187251;
        Wed, 19 Oct 2022 13:59:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r28-20020a02aa1c000000b0036384f898a0sm2452438jam.133.2022.10.19.13.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 13:59:46 -0700 (PDT)
Message-ID: <07c574f3-f523-a677-3597-aad4d5546869@linuxfoundation.org>
Date:   Wed, 19 Oct 2022 14:59:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Linux 6.1-rc1 drm/amdgpu regression
Content-Language: en-US
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <efe5a0a4-775e-bc6b-27c2-aa506f5613fa@linuxfoundation.org>
 <BL1PR12MB514408C626FE2D056C293693F72B9@BL1PR12MB5144.namprd12.prod.outlook.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <BL1PR12MB514408C626FE2D056C293693F72B9@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 14:27, Deucher, Alexander wrote:
> [AMD Official Use Only - General]
> 
>> -----Original Message-----
>> From: Shuah Khan <skhan@linuxfoundation.org>
>> Sent: Wednesday, October 19, 2022 4:00 PM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>; Shuah Khan
>> <skhan@linuxfoundation.org>; linux-kernel@vger.kernel.org
>> Subject: Linux 6.1-rc1 drm/amdgpu regression
>>
>> Hi Alex,
>>
>> I am seeing the same problem I sent reverts for on 5.10.147 on Linux 6.1-rc1
>> on my laptop with AMD Ryzen 7 PRO 5850U with Radeon Graphics.
>>
>> commit e3163bc8ffdfdb405e10530b140135b2ee487f89
>> Author: Alex Deucher <alexander.deucher@amd.com>
>> Date:   Fri Sep 9 11:53:27 2022 -0400
>>
>>       drm/amdgpu: move nbio sdma_doorbell_range() into sdma code for vega
>>
>> I see that the following has been reverted in Linux 6.1-rc1
>>
>> commit 66f99628eb24409cb8feb5061f78283c8b65f820
>> Author: Hamza Mahfooz <hamza.mahfooz@amd.com>
>> Date:   Tue Sep 6 15:01:49 2022 -0400
>>
>>       drm/amdgpu: use dirty framebuffer helper
>>
>> However I still see the following filling dmesg and system is unusable.
>> For now I switched back to Linux 6.0 as this is my primary system.
>>
>> [drm] Fence fallback timer expired on ring sdma0 [drm] Fence fallback timer
>> expired on ring gfx [drm] Fence fallback timer expired on ring sdma0 [drm]
>> Fence fallback timer expired on ring gfx [drm] Fence fallback timer expired
>> on ring sdma0 [drm] Fence fallback timer expired on ring sdma0 [drm] Fence
>> fallback timer expired on ring sdma0 [drm] Fence fallback timer expired on
>> ring gfx
>>
>> Please let me know if I should send revert for this for the mainline as well.
>>
> 
> Can you file a bug report (https://gitlab.freedesktop.org/drm/amd/-/issues) and attach your dmesg output?  I'd like to try and repro the issue if I can and provide some patches to test.  I'd like to avoid reverting the patch as that will break the driver for users using vega dGPUs.

Makes sense. I will file the bug and aattach dmesg. Since this is my
primary system, there will be some delay in getting this info. to you
and testing any patches you provide for testing.

thanks,
-- Shuah
