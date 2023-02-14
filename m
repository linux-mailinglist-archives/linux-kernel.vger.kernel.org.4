Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE8E696AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjBNRKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjBNRKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:10:06 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F6F8A75
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:10:03 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id y69so2792703iof.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1676394603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7Okgp0g5sZnhGVN5BSnDnYNcSRWmBw2rpZ3KAUXn5g=;
        b=AjZXgc0lko9anBMaicDsIcZOqqI9sBHS8srbZa6cDKAX5Y7XGZvR6UHeciQZdhPX2W
         R06xkNvQ2J2e+okTq5abS/hIqUG0WmjcLxJM3qXk0Sdrf9MHKVJhf/YcQlyqHoCUY31h
         Ro7Pk525hprGLIaQDV0XNdG5HAtQifsGVlFpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676394603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7Okgp0g5sZnhGVN5BSnDnYNcSRWmBw2rpZ3KAUXn5g=;
        b=kczOOBGIJmQwnLmOgij0cuCbiwGG3gPkRSlyRrPZHUvo36kIbS2cif5WJ+n3e3zH6H
         6ng5UF2HSM0V9QQoaBq6hteKXAZHkCq4M34wTc8V9L+b8m9qH8QEHaZcoAT3jwToOTg4
         u/Zo9PsoDL/glbnXrWzcCFgTXK1Ri1f6Y9aiM12X+iKG/BXs1ANtErsBamp9FsAgtF54
         5vHC4kWpvAJa0elyqjqZC/skYzPuWbCA7y0gklzelDGG3RfsB/VoC+GFqzyJpJ1Bornr
         9xa3cv7aXGlIOZ7sNtvLUOynWwkukH1/wukSFUKqEaIKF9cFKOEb3bhAM0TGfRGmGqgz
         l+gA==
X-Gm-Message-State: AO0yUKWmABYSioI930bep8Sqz5+lB41tVavwHYVQH9raFjPJvChxZPix
        o89NrnWI7tsQDitOfRXKshpEyg==
X-Google-Smtp-Source: AK7set+xYio7oOhkTrsxXJaynXVcnsv0plfLgn6aQ+0eK8Tft/oqVrIzd3qqTEkzqTfs0t4N9Sgfxw==
X-Received: by 2002:a05:6602:380f:b0:6cc:8b29:9a73 with SMTP id bb15-20020a056602380f00b006cc8b299a73mr2461287iob.1.1676394603149;
        Tue, 14 Feb 2023 09:10:03 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s26-20020a6bdc1a000000b00740710c0a65sm427519ioc.47.2023.02.14.09.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 09:10:01 -0800 (PST)
Message-ID: <f536ecc2-1889-6df6-43d3-1a04dc8f1b14@linuxfoundation.org>
Date:   Tue, 14 Feb 2023 10:10:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] selftests/mount_setattr: fix redefine struct mount_attr
 build error
To:     Seth Forshee <sforshee@kernel.org>
Cc:     shuah@kernel.org, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230213183149.231779-1-skhan@linuxfoundation.org>
 <Y+rMtlvx31w7eWCA@do-x1extreme>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Y+rMtlvx31w7eWCA@do-x1extreme>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 16:50, Seth Forshee wrote:
> On Mon, Feb 13, 2023 at 11:31:49AM -0700, Shuah Khan wrote:
>> Fix the following build error due to redefining struct mount_attr by
>> removing duplicate define from mount_setattr_test.c
>>
>> gcc -g -isystem .../tools/testing/selftests/../../../usr/include -Wall -O2 -pthread     mount_setattr_test.c  -o .../tools/testing/selftests/mount_setattr/mount_setattr_test
>> mount_setattr_test.c:107:8: error: redefinition of ‘struct mount_attr’
>>    107 | struct mount_attr {
>>        |        ^~~~~~~~~~
>> In file included from /usr/include/x86_64-linux-gnu/sys/mount.h:32,
>>                   from mount_setattr_test.c:10:
>> .../usr/include/linux/mount.h:129:8: note: originally defined here
>>    129 | struct mount_attr {
>>        |        ^~~~~~~~~~
>> make: *** [../lib.mk:145: .../tools/testing/selftests/mount_setattr/mount_setattr_test] Error 1
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   tools/testing/selftests/mount_setattr/mount_setattr_test.c | 7 -------
>>   1 file changed, 7 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
>> index 8c5fea68ae67..582669ca38e9 100644
>> --- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
>> +++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
>> @@ -103,13 +103,6 @@
>>   	#else
>>   		#define __NR_mount_setattr 442
>>   	#endif
>> -
>> -struct mount_attr {
>> -	__u64 attr_set;
>> -	__u64 attr_clr;
>> -	__u64 propagation;
>> -	__u64 userns_fd;
>> -};
>>   #endif
> 
> The difficulty with this is that whether or not you need this definition
> depends on your system headers. My laptop doesn't have definitions for
> either __NR_mount_setattr or struct mount_attr, so for me the build
> works without this patch but fails with it.
> 

The header search looks up system headers followed by installed headers in
the repo (both in-tree and out-of-tree builds). kselftest builds do depend
on headers_install. Did you building after running headers_install?

> I suppose we could fix this universally by using a different name for
> the struct in the test, e.g.:
> 

This is not a good way to for a couple of reasons. This masks any problems
due to incompatibility between these defines.

thanks,
-- Shuah

