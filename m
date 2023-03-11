Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9CE6B58DD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 07:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjCKGMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 01:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCKGMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 01:12:13 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C402612D428
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:12:11 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id u9so29187696edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678515130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rVC8LiGnUfG6nH76f2ANmYFw3KtTCvNV7A7+6I82Gks=;
        b=Og7FiROuZ05YCLv2EfXCEia1iQhtPv/bti70tBPQ44KDDZoAs5Um29S+pPuhla/doW
         mo/LYVkXv2odN9UJ0Bn50cJX58XBcgRD+UZ9vIOV6Z8im7BhcJ27H+Ou1z4OL8qVbquy
         6DUvOSKNEb3cOZlEzdXmY431h0NQaFhNcnxoBZFjd6V51Sg0l0p+cANRuTf0ApWY7LkC
         kB760xeH2xFRuDNqKnYTL4+zmAfh+wCBnYsKtoxABXltDIuQiKAqHaDQZvckAOJFGVkz
         Nug6iXfwq04SADdIWcyA2ScaGoBvzdJkD9SLRL+9Uk3az+lZE4+LKyI/2MuNKpSgjZDZ
         nE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678515130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rVC8LiGnUfG6nH76f2ANmYFw3KtTCvNV7A7+6I82Gks=;
        b=i99xr5cqUy4tVczYklp3kpXXI+UV3gmGGLVbrBlbRVd0U2RkM0cSrJB1Gfp9mXrY8u
         qAtXqkcZw66O6DOBwHDo0MQ5rKuzL9C8dsGFJs4D5ckkNT99+Z1BOKUSzY79/LoD6z4d
         CUaAEbLnplfQBKnM2x7KS2h2Hinooc9nfJ10p9dzMC6Kwe+GYHp1XROkEMnm0mj5TU8W
         vcc21Q/9ECKxkfXnrGY0aqPVNs3SY+o01hnNhBC1y5RCdHQ0cP3Sv/lMSKR2R6TLHJFm
         YOfIHOK35FYzzA+cOexeDcYsNbQ2iQmxUe4kq9EcTawGUsgYq69nrYs2oBtAYSTlvMXj
         KVGA==
X-Gm-Message-State: AO0yUKUP/xFUiVhqStFmxCtxG8HoWYxv45WfJvn359B4HyqDOT7v6qZx
        iEOOvNDQbhKXbEKcu4al0+s=
X-Google-Smtp-Source: AK7set8K606JzvAv5mqcU/f2BrqbeSpWXF7RngXN9y8ZyHVKNxPGmXOrxixkhn/2bYUOn1H7UHRSSA==
X-Received: by 2002:a05:6402:1e8e:b0:4bc:3ff2:dbe7 with SMTP id f14-20020a0564021e8e00b004bc3ff2dbe7mr9501767edf.1.1678515129970;
        Fri, 10 Mar 2023 22:12:09 -0800 (PST)
Received: from [192.168.10.15] ([37.252.81.68])
        by smtp.gmail.com with ESMTPSA id s7-20020a508d07000000b004af6c5f1805sm786410eds.52.2023.03.10.22.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 22:12:09 -0800 (PST)
Message-ID: <bfd3eecf-4af2-184c-ff52-5509791fbf49@gmail.com>
Date:   Sat, 11 Mar 2023 10:12:07 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] 9P FS: Fix wild-memory-access write in v9fs_get_acl
Content-Language: en-US
To:     Siddh Raman Pant <code@siddh.me>
Cc:     ericvh <ericvh@gmail.com>, lucho <lucho@ionkov.net>,
        asmadeus <asmadeus@codewreck.org>,
        linux_oss <linux_oss@crudebyte.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+cb1d16facb3cc90de5fb 
        <syzbot+cb1d16facb3cc90de5fb@syzkaller.appspotmail.com>,
        v9fs-developer <v9fs-developer@lists.sourceforge.net>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
References: <20230310202619.433269-1-ivan.orlov0322@gmail.com>
 <186cf19b619.4777c80c154603.5258165448157616593@siddh.me>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <186cf19b619.4777c80c154603.5258165448157616593@siddh.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/23 09:16, Siddh Raman Pant wrote:
> On Sat, 11 Mar 2023 01:56:19 +0530, Ivan Orlov wrote:
>> KASAN reported the following issue:
>> [...]
>>
>> Calling '__v9fs_get_acl' method in 'v9fs_get_acl' creates the
>> following chain of function calls:
>>
>> __v9fs_get_acl
>>        v9fs_fid_get_acl
>>                v9fs_fid_xattr_get
>>                        p9_client_xattrwalk
>>
>> Function p9_client_xattrwalk accepts a pointer to u64-typed
>> variable attr_size and puts some u64 value into it. However,
>> after the executing the p9_client_xattrwalk, in some circumstances
>> we assign the value of u64-typed variable 'attr_size' to the
>> variable 'retval', which we will return. However, the type of
>> 'retval' is ssize_t, and if the value of attr_size is larger
>> than SSIZE_MAX, we will face the signed type overflow. If the
>> overflow occurs, the result of v9fs_fid_xattr_get may be
>> negative, but not classified as an error. When we try to allocate
>> an acl with 'broken' size we receive an error, but don't process
>> it. When we try to free this acl, we face the 'wild-memory-access'
>> error (because it wasn't allocated).
>>
>> This patch will modify the condition in the 'v9fs_fid_xattr_get'
>> function, so it will return an error if the 'attr_size' is larger
>> than SSIZE_MAX.
>>
>> Reported-by: syzbot+cb1d16facb3cc90de5fb@syzkaller.appspotmail.com
>> Link: https://syzkaller.appspot.com/bug?id=fbbef66d9e4d096242f3617de5d14d12705b4659
>> Signed-off-by: Ivan Orlov ivan.orlov0322@gmail.com>
> 
> You should also test with Syzkaller if it gave a reproducer.
> Check the following docs to know about it:
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
> 
>> ---
>>   fs/9p/xattr.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
>> index 50f7f3f6b55e..d6f7450107a8 100644
>> --- a/fs/9p/xattr.c
>> +++ b/fs/9p/xattr.c
>> @@ -35,7 +35,7 @@ ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
>>   		return retval;
>>   	}
>>   	if (attr_size > buffer_size) {
>> -		if (!buffer_size) /* request to get the attr_size */
>> +		if (!buffer_size && attr_size <= (u64) SSIZE_MAX) /* request to get the attr_size */
>>   			retval = attr_size;
>>   		else
>>   			retval = -ERANGE;
> 
> You should use EOVERFLOW for overflow error. Make a new conditional
> instead of using AND. Also, the explicit u64 cast for SSIZE_MAX can
> be dropped for better readability.
> 
> Thanks,
> Siddh
> 
>> -- 
>> 2.34.1
>>
>> _______________________________________________
>> Linux-kernel-mentees mailing list
>> Linux-kernel-mentees@lists.linuxfoundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees

Thank you for the review! I will modify the patch according to your 
comments, resend it as v2 version and test it via syzkaller.
