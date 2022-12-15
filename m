Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DAA64D64F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLOGC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiLOGC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:02:57 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0469E537CF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:02:57 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id s186so4529375oia.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=mjJjR91vA2be9aYlFAfbu7zZRpzcF0RQ7qc8y7D9ogk=;
        b=adpy9IJwGbgxosC3NwZWtuodCBngxheQ1jpLs5DEr0iJAWVwcar+T78vJjxWvhMRRc
         zSbmg/SUjBr8EswK0WeyUUMR0LTQOlABGAPxNj3sNQGftQLY+SY9kFFVGa0NC51Tv+CZ
         58HUgytFeG3/T5nq+wZTDcTIebRtDR9ovbz7WJmmFVZDKGbSnDN8ON4ZkcRIPz1ARqF8
         fIUCYp9LC3cHHsSbuocvTirt02DjUUuDG3NukhkBCja2lDqNXC329hghWAzFw90tAcOU
         SGsuhp6Ttl+k2n1QZmBYIOKvQpVDfMHDBJcl4a5c+Cdj4iIT7f8ZLx2Nn9FNdiA6TPef
         /UIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjJjR91vA2be9aYlFAfbu7zZRpzcF0RQ7qc8y7D9ogk=;
        b=vM5xgLK2V0/7K4FcUfiZn/Gt91VjzNMg7UbOmD4CdkwppXKSfqr2i+DeZ2x9wDOXFy
         4+it0K9k5OD5x+P+asyw9VXu1aW7AHw6X59zmuvSfsjLNZRkRQeM3DDbiQqcbWEjDOhT
         jekAJbJRwvdk6eivf2sgh4w/nHBnayMQBI9MNpjUe/KGIIItxp6rt04bHSoYc8DM5Kfq
         h869jAlTI4ucs0k7LwyNLF84GmfCAXbkmCUgxM2Sum9Vw8K4PbjD/Rsk/YbCKSsJzBnC
         Q16DMGCrRet4rYKxeSA37DImEuAOzrutFcANagG4wbXq38ZiVi6b8Eh3LyM2Dox9mJ/l
         3IAQ==
X-Gm-Message-State: ANoB5pnTeCg0d86oh0dubjbf1HUYDqIKcVhd0vBz2smMbwjOuBNgFrTG
        7//luNZPw1jHybjntPtv0xI=
X-Google-Smtp-Source: AA0mqf5HMfNDMQ2/EnlRB1FEaeQ/N10K/NPI85/Ix066dVkaM9myTgd/ZS1ZEBcPFsKKrV1Wxn7MxQ==
X-Received: by 2002:aca:c046:0:b0:35e:d69f:ff68 with SMTP id q67-20020acac046000000b0035ed69fff68mr385429oif.30.1671084176293;
        Wed, 14 Dec 2022 22:02:56 -0800 (PST)
Received: from MBP ([68.74.118.125])
        by smtp.gmail.com with ESMTPSA id v2-20020a05683018c200b006706cd202b0sm3189268ote.11.2022.12.14.22.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 22:02:55 -0800 (PST)
References: <20221214134656.21228-1-schspa@gmail.com>
 <Y5orL90JpH6LUd4D@bombadil.infradead.org>
User-agent: mu4e 1.8.10; emacs 29.0.60
From:   Schspa Shi <schspa@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        syzbot+10d19d528d9755d9af22@syzkaller.appspotmail.com,
        syzbot+70d5d5d83d03db2c813d@syzkaller.appspotmail.com,
        syzbot+83cb0411d0fcf0a30fc1@syzkaller.appspotmail.com,
        syzbot+c92c6a251d49ceceb625@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] umh: fix out of scope usage when the process is
 being killed
Date:   Thu, 15 Dec 2022 13:11:39 +0800
In-reply-to: <Y5orL90JpH6LUd4D@bombadil.infradead.org>
Message-ID: <m24jtx9pbp.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Luis Chamberlain <mcgrof@kernel.org> writes:

> On Wed, Dec 14, 2022 at 09:46:56PM +0800, Schspa Shi wrote:
>> When the process is killed, wait_for_completion_state will return with
>> -ERESTARTSYS, and the completion variable in the stack will be unavailable,
>> even freed. If the user-mode thread is complete at the same time, there
>> will be a race to use a unavailable variable.
>> 
>> Please refer to the following scenarios.
>>             T1                                  T2
>> ------------------------------------------------------------------
>> call_usermodehelper_exec
>>                                    call_usermodehelper_exec_async
>>                                    << do something >>
>>                                    umh_complete(sub_info);
>>                                    comp = xchg(&sub_info->complete, NULL);
>>                                    /* we got the completion */
>>                                    << context switch >>
>> 
>>     << Being killed >>
>> 	retval = wait_for_completion_state(sub_info->complete, state);
>> 	if (!retval)
>> 		goto wait_done;
>> 
>> 	if (wait & UMH_KILLABLE) {
>> 		/* umh_complete() will see NULL and free sub_info */
>> 		if (xchg(&sub_info->complete, NULL))
>> 			goto unlock;
>>         << we can't got the completion, because T2 take it already >>
>> 	}
>> 	....
>> 	return retval;
>> }
>> 
>> /**
>>  * the completion variable in stack is end of life cycle.
>>  * and maybe freed due to process is recycled.
>>  */
>>                                    -------- BUG here----------
>>                                    if (comp)
>>                                        complete(comp);
>> 
>> To fix it, we can add an additional wait_for_completion to ensure the
>> completion object is completely unused. And this is what
>> kthread_create_on_node does to handle this race.
>> 
>> Reported-by: syzbot+10d19d528d9755d9af22@syzkaller.appspotmail.com
>> Reported-by: syzbot+70d5d5d83d03db2c813d@syzkaller.appspotmail.com
>> Reported-by: syzbot+83cb0411d0fcf0a30fc1@syzkaller.appspotmail.com
>> Reported-by: syzbot+c92c6a251d49ceceb625@syzkaller.appspotmail.com
>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>> ---
>
> Please fix the commit log a bit more with the cotext I provided, *if*
> on the other thread the community agrees with the approach to be
> compartamentalized. I am still not sure why this would fix the
> UAF after thinking about it some more, and the issue would mean
> there likely could be a generic fix / issue to consider.
>

I think a syntactic sugar for a complete api can be added here for a
generic usage.

> So for now I'd like more review of this race and the proposed fix
> as I mentioned in the follow-up threaad in your v1 patch. Let's
> follow up there and see how that discussion goes.
>

Ok, let's talk about this on the v1 patch's thread.

>   Luis

-- 
BRs
Schspa Shi
