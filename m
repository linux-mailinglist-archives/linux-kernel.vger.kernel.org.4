Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55798665CA7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbjAKNdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbjAKNc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:32:26 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDF61C428;
        Wed, 11 Jan 2023 05:29:35 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso12631540wms.5;
        Wed, 11 Jan 2023 05:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GGntp21EzMJFsymR3ELJSH+wxpQ0cPvhTTj67WV8gAo=;
        b=Okqtl7jApidFjlYLuVonkSJKndKq31b6k+CZ1VF2b2KGDbbFVHiZaKBI0mSJF/Yqw+
         boGWcdLXDFJ/Q7VAVhX/1A68vtehPWK1hVvhiKqz27dRzuJTSLPxAnlY435MeU+40jr8
         qn6xTghv5anWH+bEEKExBJqZO7n37bAY2uEX0vDMAtGxLp0+QizfVlxxo9XHa/s6FHV4
         CynJWRspnFOzRRdmoy3bgp1LbFFTl+9PHkE12pMhCVh38Rz879yanORIXihQibdJPBLn
         +HY9flFr/qNrTVbEhIdwGfVI7LQZJ+O3e8k4bWCsZwVRMsk6fbkYu3njy+7TDEEkbSYM
         fRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGntp21EzMJFsymR3ELJSH+wxpQ0cPvhTTj67WV8gAo=;
        b=GyAHK764Eue/2xvutfMLEEVoyc5sk1tRt69zLu/F1eGTY/J1FngHi9FwWtjkHeg3tP
         BOZGR1SpI1Ned4EaSKDCEFGVDa5kstFzdFeRgVJTDFNvNzME5ZU9AUN3I8L6oJp6w+0w
         oAVSN/NA4d5+DTTvbO4yxAgUkN5lKIW25iicXBEvypNLZbgzqUeGvzKLxxMV/qUQIFUP
         +URGKRVxjGsG5GTguKXlZw+BDDva/jUCC152oIFcyZllZEXQXXHNxv/s/iHcJM65rqyj
         btXIQe8Nlri8bIPqxpo5FRl7rj3+jSCes8kfSQ83/BonltVgLqv50DhdYeKI5iMjUUZG
         P1YA==
X-Gm-Message-State: AFqh2kr7FoCZjJRMemL/EBwc3xhi4anh1tRjm0X8MLJHBDQArCa7C8xz
        RYv9rhGpQEicrc/qEopbUMvshPnVHE4=
X-Google-Smtp-Source: AMrXdXs+X5hqHrk1Q8kuazEb7WaueJXYQhbsV0/7ogNkV2uC9j3h7MVaEnWAaKT30/JPD9rQvzDYrg==
X-Received: by 2002:a05:600c:3b28:b0:3da:516:19ed with SMTP id m40-20020a05600c3b2800b003da051619edmr2529840wms.29.1673443774451;
        Wed, 11 Jan 2023 05:29:34 -0800 (PST)
Received: from [192.168.2.202] (pd9ea33ef.dip0.t-ipconnect.de. [217.234.51.239])
        by smtp.gmail.com with ESMTPSA id a10-20020adfdd0a000000b002bb6b45ab57sm11912443wrm.85.2023.01.11.05.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 05:29:33 -0800 (PST)
Message-ID: <2c8c887f-3935-77e6-9d0e-283226ad357c@gmail.com>
Date:   Wed, 11 Jan 2023 14:29:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 03/16] platform/surface: aggregator: move
 to_ssam_device() to use container_of_const()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
 <20230111113018.459199-4-gregkh@linuxfoundation.org>
 <d66843b0-5420-7237-c8e1-73bc402bff70@gmail.com> <Y76oPCJyHktT+Ni9@kroah.com>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <Y76oPCJyHktT+Ni9@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/23 13:14, Greg Kroah-Hartman wrote:
> On Wed, Jan 11, 2023 at 01:02:01PM +0100, Maximilian Luz wrote:
>> On 1/11/23 12:30, Greg Kroah-Hartman wrote:
>>> The driver core is changing to pass some pointers as const, so move
>>> to_ssam_device() to use container_of_const() to handle this change.
>>> to_ssam_device() now properly keeps the const-ness of the pointer passed
>>> into it, while as before it could be lost.
>>>
>>> Cc: Maximilian Luz <luzmaximilian@gmail.com>
>>> Cc: platform-driver-x86@vger.kernel.org
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> ---
>>>    include/linux/surface_aggregator/device.h | 5 +----
>>>    1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
>>> index 46c45d1b6368..24151a0e2c96 100644
>>> --- a/include/linux/surface_aggregator/device.h
>>> +++ b/include/linux/surface_aggregator/device.h
>>> @@ -229,10 +229,7 @@ static inline bool is_ssam_device(struct device *d)
>>>     * Return: Returns a pointer to the &struct ssam_device wrapping the given
>>>     * device @d.
>>>     */
>>> -static inline struct ssam_device *to_ssam_device(struct device *d)
>>> -{
>>> -	return container_of(d, struct ssam_device, dev);
>>> -}
>>> +#define to_ssam_device(d)	container_of_const(d, struct ssam_device, dev)
>>>    /**
>>>     * to_ssam_device_driver() - Casts the given device driver to a SSAM client
>>
>> A small note in addition to the comment by Hans: I think it might be a
>> good idea to convert the to_ssam_device_driver() function as well. I
>> could also send this in as a follow-up patch.
> 
> Sure, that can be a follow-on patch as it's not needed here.

Perfect, I'll do that.

As Hans' comment is now addressed, everything looks good to me.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

