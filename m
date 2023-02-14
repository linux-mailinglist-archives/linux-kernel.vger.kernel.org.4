Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4C16971E3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjBNXhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjBNXhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:37:09 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF8F2BEF3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 15:37:07 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id bl9so6479063iob.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 15:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mZdjpB1hiR4KdFF9IW1WmBupIcjtLh3KZAHATvyECZc=;
        b=hTAoWB2LQ9OA67yieHFQdvaCwbt9cNBIAg/X3DTK4gP9hE5H2rbBfPjwZe62bTp6mK
         9i7tGy9YcyRUg0zuQpqI2dhnX2KAkntai21DmZNEqYhjB1hJ6RdKc7mI+PxW/QtleGoi
         8ko5/pP2kAcKhYb19v3+WjeezjUxjYqKxRBLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZdjpB1hiR4KdFF9IW1WmBupIcjtLh3KZAHATvyECZc=;
        b=W5o6Xaw3evanWjAMTCNvnn5h7tuR7BU8CGib5SghGiHgKoNytQ4uqEaeRg7Un6KXMk
         IKSahwwzJQxQsotkmdlm0os9Hu104BXeyZyRjuis5RcK/vg7DDUj81h4J9ZxE9KMKmjd
         pQAeMJOhGcwNt0t9lLeNX8JDHHx0KFk2UHbOpk1OHg9KPZZZNvagy0OGDxi3etI+Whv0
         U2VYfdhy+UMHtQ4qC+QffLCceNnxk7SwLx0snLntWAdkw4dcsREW5icGJ/SLtJms3+h3
         +dX2TMOgGKWOs1gz/kZfFkorV4G54A0VFbAQDVbkZJ+V9QXa5RZGkNuzRx2RAws8E5Ns
         guLw==
X-Gm-Message-State: AO0yUKXRzcFhzeHc1Jd6ngQyW5kYc9+lWHacfTlItM/yf2qhkh+tdANU
        Rt33eCZyumJtipYohQcvD1v6n8hz1bDns48O
X-Google-Smtp-Source: AK7set/4/pIQOLdtIr2u+j9NEMRLql2ZuJXi2Ce/0glFkqfSzRfp2NVpFKuVnFsC3x9IfmqqHBjplA==
X-Received: by 2002:a05:6602:1415:b0:70a:9fce:853c with SMTP id t21-20020a056602141500b0070a9fce853cmr424774iov.2.1676417827031;
        Tue, 14 Feb 2023 15:37:07 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u14-20020a02aa8e000000b003a9595b7e3asm5322393jai.46.2023.02.14.15.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 15:37:06 -0800 (PST)
Message-ID: <dda181d1-8a5b-adb4-6665-016f50e51487@linuxfoundation.org>
Date:   Tue, 14 Feb 2023 16:37:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] selftests/mount_setattr: fix redefine struct mount_attr
 build error
Content-Language: en-US
To:     Seth Forshee <sforshee@kernel.org>
Cc:     shuah@kernel.org, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230213183149.231779-1-skhan@linuxfoundation.org>
 <Y+rMtlvx31w7eWCA@do-x1extreme>
 <f536ecc2-1889-6df6-43d3-1a04dc8f1b14@linuxfoundation.org>
 <Y+vzB1OTXr+zTCV7@do-x1extreme>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Y+vzB1OTXr+zTCV7@do-x1extreme>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 13:45, Seth Forshee wrote:
> On Tue, Feb 14, 2023 at 10:10:00AM -0700, Shuah Khan wrote:

>>>
>>
>> The header search looks up system headers followed by installed headers in
>> the repo (both in-tree and out-of-tree builds). kselftest builds do depend
>> on headers_install. Did you building after running headers_install?
> 
> I wasn't aware they depend on headers_install. Why doesn't
> Documentation/dev-tools/kselftest.rst mention this in the section that
> describes how to run tests?
> 

It ahs always been a dependency. If you were to compile from the
main (root) Makefile as below - headers_install get done before
test compile:

make kselftest-all TARGETS=mount_setattr

> It seems what I really need to fix the build is to include
> linux/mount.h, which works for me with or without headers_install,
> because I have the struct in /usr/include/linux/mount.h. And I suppose
> the makefile should use KHDR_INCLUDES. So maybe the changes below should
> also be included.
> 

Yes. Makefile change to use KHDR_INCLUDES is already done. Please
take a look at linux-kselftest next - this was done as part of a
tree-wide change.

If including linux/mount.h is thr correct solution, please send me
the patch on top of linux-kselftest next and I will pull it in.
  
> However I know Christian has said that there are challenges with
> including the mount headers. He wrote this test, so I'd like to hear his
> thoughts about adding the include. He's on vacation this week though.
> 

Sounds good.

thanks,
-- Shuah

