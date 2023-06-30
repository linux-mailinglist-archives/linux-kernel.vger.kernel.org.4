Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7AC743504
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjF3G3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjF3G3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:29:32 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279793582;
        Thu, 29 Jun 2023 23:29:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-53fa455cd94so841907a12.2;
        Thu, 29 Jun 2023 23:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688106570; x=1690698570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PAq7BJ48mpqsi8BZO+XAPQUWw6V+9NeCDL8VutkDMfM=;
        b=EA03BEcOuim1I5UzVjtwh4so5IQAPLEiKsFRdfBecOreCy+Gne7HPLZKDWDvONddta
         OSw3PUdOUjYYLjf5a3KaNsd12gC/w5zkL8/P4Vk5K4zNAbn7B4+Q+2UTQQbF7rdkol7s
         gODtN3ocNS+VsACkAV1GZ7c2z32UzPFTbvGa4FEsofAG/xJrGsGIFmX7+DtUsbbvaiUu
         ZDD2uq9xHqR9YkVV5AtrTMseReovfEzZKriOIkLx504O+tz2vbdzbpo9HRgNA6rKypah
         O1C6NN19SLejda/Smeh4bdTeCHcgq7xEJLSwkjhUtRn/+t+a7Uv9QzG9n9aEzXHsUALA
         5DZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688106570; x=1690698570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PAq7BJ48mpqsi8BZO+XAPQUWw6V+9NeCDL8VutkDMfM=;
        b=PU0xtICUm2QNzAPF3TDd92VO2KWfDhXyXYuV09ttsGWYdwwKFkjjLqypFv/2MpQ9aY
         P4wAomgg2gtaZmvrVNQnj++HIfcy25gBcZOWGF/ZbwdNgryFdgOuxsFgfETBm6m2Ee6X
         krOqaZ80OMWRB3eauirRlNAKb795GVf57VPCYIGAvEYKcNdUH0IoIv9mNnARfOLrfWiD
         rb5DBL1RCMLIxLQXUVS7zzRhH9BOGgusyvuntDVxxxXfYu7n/oE6EgqMphT6ZYawhnQd
         IXnD/qng850fgkGjrGlMf12L0nG6Q921g578Am+Z0twGgpgflLGz+mTEMMYGGBVtuQTG
         vNOQ==
X-Gm-Message-State: ABy/qLbJKtpodZXsbCsoFSUPJJraQtlewASdjO88oo9qQ9ghpl2zs/n4
        BHKZKzlnRhUFom2Is7fczb4=
X-Google-Smtp-Source: APBJJlFlRG2eTs1rMzH7koWOJWvQ8XKpyOFRhiRbwYW1+lILqmZnrVd4LwIt4xEiaBBuhilPmzfAyA==
X-Received: by 2002:a17:903:1205:b0:1b3:b998:8007 with SMTP id l5-20020a170903120500b001b3b9988007mr1220475plh.55.1688106570509;
        Thu, 29 Jun 2023 23:29:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p11-20020a1709026b8b00b001b82862d3besm4823934plk.127.2023.06.29.23.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 23:29:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fbe57907-b03f-ac8c-f3f4-4d6959bbc59c@roeck-us.net>
Date:   Thu, 29 Jun 2023 23:29:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Jason Wang <wangborong@cdjrlc.com>
References: <20230629184151.888604958@linuxfoundation.org>
 <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/23 23:16, Linus Torvalds wrote:
> On Thu, 29 Jun 2023 at 22:31, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>
>> arch/parisc/mm/fault.c: In function 'do_page_fault':
>> arch/parisc/mm/fault.c:292:22: error: 'prev' undeclared (first use in this function)
>>    292 |                 if (!prev || !(prev->vm_flags & VM_GROWSUP))
> 
> Bah. "prev" should be "prev_vma" here.
> 
> I've pushed out the fix. Greg, apologies. It's
> 
>     ea3f8272876f parisc: fix expand_stack() conversion
> 
> and Naresh already pointed to the similarly silly sparc32 fix.
> 
>               Linus

Did you see that one (in mainline) ?

Building csky:defconfig ... failed
--------------
Error log:
arch/csky/mm/fault.c: In function 'do_page_fault':
arch/csky/mm/fault.c:240:40: error: 'address' undeclared (first use in this function); did you mean 'addr'?
   240 |         vma = lock_mm_and_find_vma(mm, address, regs);

Guenter

