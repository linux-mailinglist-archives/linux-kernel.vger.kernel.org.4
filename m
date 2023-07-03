Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B08745CB2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjGCM7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjGCM7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:59:23 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C01CA;
        Mon,  3 Jul 2023 05:59:23 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-579d5d89b41so28328217b3.2;
        Mon, 03 Jul 2023 05:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688389162; x=1690981162;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1dr4HQZ0ybmeQ6CjGlpt9Gr7qhnsRYi0VYGFtrd/Jo0=;
        b=D16Idpx2//9PttSQGyKl3HqArfUyqy16bxOy9Mf3li5RWR9EMB4eT9ksxx22AZeN6v
         pqW+OVJ0Wz5/ZDgnIOYBIWcY0nWWuG0KklX4Gcw9JQFQs/hQLy4sy0IiONeet5ADkkK+
         g/XCyr81rynnVIlDKoWuE6753xutfw4woO7s9LwRFGEp6HI9bb0/thY/WLUCxyuDBAUB
         obzPpaHtr/BYtqvJXHxc2Q7jjteAcA4H6vdnhw0ltjpDGxmKdpqOBzPjV79U4JoesdVM
         IKvL+jH5pHkRzbcWVN6fLchZHXhqDIV87RHLBHPr0/DDb28z3Zo9pPp/2ViEN/E9KIBa
         0c7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688389162; x=1690981162;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1dr4HQZ0ybmeQ6CjGlpt9Gr7qhnsRYi0VYGFtrd/Jo0=;
        b=FLRpONsEZISw6CYEK3QOWO/M0VUhk7EsSRkgSdpz0YaJiLC8xstxMlUAaOJ2EfHWhf
         ufPVDuiW5QAR3IPQSgHY7dGp/D0Ubln0EPbOaCxYx+qJ2ZA3cin9FMgco5un+WIXvDxN
         RhFVPcSHqT0M79snYjWfpEq6+MKDZ97WwqOysjtZCDR3KGvtbu2T8QJ7QS3q7KUqsA6H
         /2/pORuI/GGt2ZX7wYZ4EU9Ygt11DI9qDZM78EICsN+ECabwGDmNInMQr/AmmQhFmeoK
         ZHe9jN02CT0XAnQQ0iFSspMKFjmtZORhr5vFqJoZR+Dj4543NPz+cMH+Hkix+pwK2hUq
         CWJQ==
X-Gm-Message-State: ABy/qLZc/PrtYvGVTzY+44K3AmTM8lxkoeVE9DUs8vWktQ2/d2iU3FOp
        13TzRowY2mjHfXF/0rV1qfCUto1/C5I=
X-Google-Smtp-Source: APBJJlGUqaPIkZmp3nuwF1k4F7nznp3iQcro+DUawGP1F6w3+MosNO5Eifq6dFqfi2BcNHdtt+VULA==
X-Received: by 2002:a81:68c6:0:b0:559:f18d:ee94 with SMTP id d189-20020a8168c6000000b00559f18dee94mr8862369ywc.10.1688389162069;
        Mon, 03 Jul 2023 05:59:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m15-20020a0dca0f000000b00578942e2a86sm1534329ywd.60.2023.07.03.05.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 05:59:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <36986dd6-4973-65a2-3490-84d3c0967adc@roeck-us.net>
Date:   Mon, 3 Jul 2023 05:59:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Helge Deller <deller@gmx.de>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John David Anglin <dave.anglin@bell.net>
References: <20230629184151.888604958@linuxfoundation.org>
 <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <2023063001-overlying-browse-de1a@gregkh>
 <0b2aefa4-7407-4936-6604-dedfb1614483@gmx.de>
 <5fd98a09-4792-1433-752d-029ae3545168@gmx.de>
 <CAHk-=wiHs1cL2Fb90NXVhtQsMuu+OLHB4rSDsPVe0ALmbvZXZQ@mail.gmail.com>
 <CAHk-=wj=0jkhj2=HkHVdezvuzV-djLsnyeE5zFfnXxgtS2MXFQ@mail.gmail.com>
 <9b35a19d-800c-f9f9-6b45-cf2038ef235f@roeck-us.net>
 <CAHk-=wgdC6RROG145_YB5yWoNtBQ0Xsrhdcu2TMAFTw52U2E0w@mail.gmail.com>
 <2a2387bf-f589-6856-3583-d3d848a17d34@roeck-us.net>
 <CAHk-=wgczy0dxK9vg-YWbq6YLP2gP8ix7Ys9K+Mr=S2NEj+hGw@mail.gmail.com>
 <c21e8e95-3353-fc57-87fd-271b2c9cc000@roeck-us.net>
 <CAHk-=wj+F8oGK_Hx6YSPJpwL-xyL+-q2SxtxYE0abtZa_jSkLw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review - hppa argument list too long
In-Reply-To: <CAHk-=wj+F8oGK_Hx6YSPJpwL-xyL+-q2SxtxYE0abtZa_jSkLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/23 23:20, Linus Torvalds wrote:
> On Sun, 2 Jul 2023 at 22:33, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Here you are:
>>
>> [   31.188688] stack expand failed: ffeff000-fff00000 (ffefeff2)
> 
> Ahhah!
> 
> I think the problem is actually ridiculously simple.
> 
> The thing is, the parisc stack expands upwards. That's obvious. I've
> mentioned it several times in just this thread as being the thing that
> makes parisc special.
> 
> But it's *so* obvious that I didn't even think about what it really implies.
> 
> And part of all the changes was this part in expand_downwards():
> 
>          if (!(vma->vm_flags & VM_GROWSDOWN))
>                  return -EFAULT;
> 
> and that will *always* fail on parisc, because - as said multiple
> times - the parisc stack expands upwards. It doesn't have VM_GROWSDOWN
> set.
> 
> What a dum-dum I am.
> 
> And I did it that way because the *normal* stack expansion obviously
> wants it that way and putting the check there not only made sense, but
> simplified other code.
> 
> But fs/execve.c is special - and only special for parisc - in that it
> really wants to  expand a normally upwards-growing stack downwards
> unconditionally.
> 
> Anyway, I think that new check in expand_downwards() is the right
> thing to do, and the real fix here is to simply make vm_flags reflect
> reality.
> 
> Because during execve, that stack that will _eventually_ grow upwards,
> does in fact grow downwards.  Let's make it reflect that.
> 
> We already do magical extra setup for the stack flags during setup
> (VM_STACK_INCOMPLETE_SETUP), so extending that logic to contain
> VM_GROWSDOWN seems sane and the right thing to do.
> 
> IOW, I think a patch like the attached will fix the problem for real.
> 
> It needs a good commit log and maybe a code comment or two, but before
> I bother to do that, let's verify that yes, it does actually fix
> things.
> 

Yes, it does. I'll run a complete qemu test with it applied to be sure
there is no impact on other architectures (yes, I know, that should not
be the case, but better safe than sorry). I'll even apply
https://lore.kernel.org/all/20230609075528.9390-12-bhe@redhat.com/raw
to be able to test sh4.

Guenter

