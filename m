Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4460A6F273A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 02:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjD3A3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 20:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjD3A3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 20:29:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E65C1723
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 17:29:43 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b5465fc13so963690b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 17:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682814583; x=1685406583;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lsYMKfqCzvP1Ey4NLHAS4Ic4V1gf+GAxOwiGxymUAdg=;
        b=mFj0LuyBYkm7EgqhYCh3cfqQNEixVhrvYtA/ohuEju9LN2M82qFqnPFI61492WAdmJ
         PTugXxkDEscO4y971StfL6DvUhaXqtW1xDigrCQOaVYR5BYtSLun5y8Lywns2DI4TXRI
         gkqvFYhWCjZ6qbQSb8QlAXLlwgA66afDAU5Q6/mwGqf/CFGJxPYJjPBEPTKA/JhKESxg
         5kHcwSB8S8Xc9TfcFxg8b3OGvAlg1hGmiSbfFgcjFhwdYexjwy4NxdBxUMHM9QqPSYVs
         1JzW2lX330OyRCIm6ln4bQG3MBWq2VCf9NXHBE+Hy8AzbR8Sa+g2igrPK2ZQjNhl/9Qy
         ++Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682814583; x=1685406583;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lsYMKfqCzvP1Ey4NLHAS4Ic4V1gf+GAxOwiGxymUAdg=;
        b=d6eIOdoALQu1LqkxxhJJKIgLwdqFBG0D84eXiwwKPqo61PVwY7sTE+Gho5PgMhDmOI
         kbmSqNfpemCvYh0CotBJVYSHkpFijXiKTXeGncv384x/B4ofuPninWl+k1jOlOcjlAKV
         6/jTCDeKN013NtLnnCto/ZL5qGtSx6mn0SeyYB85Pr5B5lBUuqeG5xs+KkFkGVjVjycH
         36IMvuO2+IVxJisU/ijuo9+8lZrV6RMFw4/FlmxUtW7jsX9drNgtFWTZncoIZgt3Vs3r
         Mrm9FB0fkH8EfwKTHTdOs7cRZsN7J5NjyCKMpdZaqIcS+4CASZvHC3UpyQ1lh7LtxVSb
         7GQw==
X-Gm-Message-State: AC+VfDwsNnpjMEnP4sXU1NJ8wI6r8FRsTT+VHXpaqcMzbw57YMECqJED
        mOTQPMVib6HR/BgRfFJaHgc=
X-Google-Smtp-Source: ACHHUZ7xEpYrffF0wvBhZ4VgRStTT5SFoyquiC0J81CgaP84jXfQA2aJc8eqdN/fN/5UVwdgyAcOJA==
X-Received: by 2002:a05:6a00:2304:b0:63d:3789:733f with SMTP id h4-20020a056a00230400b0063d3789733fmr15287890pfh.15.1682814582684;
        Sat, 29 Apr 2023 17:29:42 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id y136-20020a62ce8e000000b0063d63d48215sm17411734pfg.3.2023.04.29.17.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Apr 2023 17:29:42 -0700 (PDT)
Message-ID: <1d060b2a-84b5-a3e7-c97d-ac656f244811@gmail.com>
Date:   Sun, 30 Apr 2023 09:29:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] extcon next for 6.4
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>
References: <1d2b9fd2-4a59-cb3b-2fd3-9f6635f3bbf8@gmail.com>
 <3b49bdb2-642e-214b-7334-911721f62ce6@gmail.com>
 <2023042544-cargo-reexamine-ed86@gregkh>
 <305aedea-599a-48b0-e3a9-6f71b75e14d8@gmail.com> <ZEtj1oWqBlmgwc2b@kroah.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Content-Language: en-US
In-Reply-To: <ZEtj1oWqBlmgwc2b@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 4. 28. 15:12, Greg Kroah-Hartman wrote:
> On Wed, Apr 26, 2023 at 03:49:17AM +0900, Chanwoo Choi wrote:
>> Dear Greg,
>>
>> On 23. 4. 25. 22:22, Greg Kroah-Hartman wrote:
>>> On Tue, Apr 25, 2023 at 09:58:47PM +0900, Chanwoo Choi wrote:
>>>> Dear Greg,
>>>>
>>>> Gently ping for v6.4.
>>>
>>> Ouch, something went wrong with your first email and it ended up in my
>>> spam folder in gmail, so sorry about that :(
>>
>> I'm sorry. I'll use the @kernel.org account on next time.
>>
>>
>>>
>>> Is your tree included in linux-next already?
>>>
>>
>> Yes. extcon.git was included in linux-next.
>>
>> And my pull request edited the 'class_create()'
>> Thus, it might have a conflict as following report[1] from Stetphen Rothwell (linux-next.git).
>> [1] https://lore.kernel.org/lkml/ZBhOTW9v9jzJVY7e@kroah.com/
> 
> Ok, I tried to pull this today, but I get the following error:
> 
> Commit: 40f9fc3c2b38 ("extcon: usbc-tusb320: add USB_ROLE_SWITCH dependency")
> 	Fixes tag: Fixes: 19685ae43489 ("extcon: usbc-tusb320: add usb_role_switch support")
> 	Has these problem(s):
> 		- Target SHA1 does not exist
> 
> Are you sure that linux-next actually passed this tree?
> 
> All of these were added to your tree only 12 days ago.  Perhaps we should just
> wait until 6.5-rc1 for the new features, and take the bug fixes now?  Can you
> redo this to make it so I can take the bugfixes after 6.4-rc1 is out, and throw
> away this tree for now?

Dear Greg,

I'm so sorry for my fault. I rebased extcon-next tree based on char-misc.git(v6.3-rc6)
right before sending the pull request. It it the reason to be changed of the commit id.

I'll fix issue and then send the pull request for 6.5-rc1 on later. I'll not rebase
the extcon branch before sending the pull request and use the kernel.org email.

Once again, I'm sorry to bother you.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

