Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9682F721F23
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjFEHLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjFEHKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:10:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016631A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:09:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5148e4a2f17so6903345a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 00:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685948991; x=1688540991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=40CnV0seHNA+3J+ZtxxY5lWq8+DP/bF+vwPGX6memA4=;
        b=nQjOn8M6P984wlmWjWHri0pDo+/njmcKrLFh66hG0uR6pU7+aTHjw36bUCRinAxJii
         KbN3vxAxQMp3KiIyTnDQ/rTQTJZqn6YD7UMNlbPdL+9Np2mqiZU7dfYcVfVNOjHt7TC7
         Sj26M8ZF2kraEKuMLqCzPxbSDwvMk7zuzYhWnUxNEqf/TX72tiT0VtqfxeWfYR5nEvaW
         9ZskfIiLmy0GivRZ36V1afjVWrN7LpyEQGfWq9m7a/zN0/f6bTFSq7NkhsIcjhTvBsdu
         ylVE2XTULgISjxu6NhkgbFzojQhE0qDGaINB/O2Q0HjbD1FFberFqTUCk8UlMuYH59sM
         +gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685948991; x=1688540991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=40CnV0seHNA+3J+ZtxxY5lWq8+DP/bF+vwPGX6memA4=;
        b=bES4WkkKL/nM7xFuAq2vozGDCpH0H5600K4PECjUSz7YmfJsFJVI1+FAh0vhQ1jRoB
         DoNQxQxDbwwmZrO+wy7DCGd4g4nDF3qQ5qzElulg3j2AnJDxuwCJ0HX2XSuTPOH4JYlA
         Kb0LBKojY5WQlS43rfzUuqr8luY2U8WqZkKNP7z7FQpc0c5D6tbDq6LQ7Pub2cKQqLpR
         dYPkERXbqjghw0Ip+J387GwIP8I7isuAZYaMfrOgHuLXFXPRvap1kCS2Lnm18vK65NAR
         Z150ZQvwPfoE1On+o3hbC9fNU/mzatchTFWyPqtqrCT4qFxMZ1I0eNNLaWzntNbFoSQO
         3ZhA==
X-Gm-Message-State: AC+VfDyD8YN8/aOApZDjA1Hm3cunZq2ADZB0MapXyi6S1YZax8l2xtis
        HSawa69oAnmSVOKH1mOvRJA=
X-Google-Smtp-Source: ACHHUZ4avov38OYLaR3Bj09ogtbzgAw+IJvsxh/+I2jNWLZnteyosL/g2MigG3R1N70vvHtsLvmoLg==
X-Received: by 2002:a05:6402:659:b0:516:642e:f92b with SMTP id u25-20020a056402065900b00516642ef92bmr783879edx.1.1685948991066;
        Mon, 05 Jun 2023 00:09:51 -0700 (PDT)
Received: from [147.251.42.107] (nbbroz2.fi.muni.cz. [147.251.42.107])
        by smtp.gmail.com with ESMTPSA id b13-20020a056402138d00b00516654bf182sm334943edv.41.2023.06.05.00.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 00:09:50 -0700 (PDT)
Message-ID: <a5eaa21d-6551-5857-98cd-50578fe59566@gmail.com>
Date:   Mon, 5 Jun 2023 09:09:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS
 volume key
Content-Language: en-US
To:     Coiby Xu <coxu@redhat.com>, Eric Biggers <ebiggers@kernel.org>
Cc:     kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        x86@kernel.org, dm-devel@redhat.com,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Kairui Song <ryncsn@gmail.com>,
        Jan Pazdziora <jpazdziora@redhat.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Young <dyoung@redhat.com>
References: <20230601072444.2033855-1-coxu@redhat.com>
 <20230602213452.GC628@quark.localdomain>
 <f569a35a-bff9-9dbb-2ded-7e02ee060a9a@gmail.com>
 <36mz3gn764ceadfbuhhmoo2zaiqmzplpkdcnszha2hzhmb3i62@sm6hilxryzk4>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <36mz3gn764ceadfbuhhmoo2zaiqmzplpkdcnszha2hzhmb3i62@sm6hilxryzk4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/23 04:31, Coiby Xu wrote:
> Hi Eric and Milan,
> 
> On Sat, Jun 03, 2023 at 11:22:52AM +0200, Milan Broz wrote:
>> On 6/2/23 23:34, Eric Biggers wrote:
>>> On Thu, Jun 01, 2023 at 03:24:39PM +0800, Coiby Xu wrote:
>>>> [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS volume key
>>>
>>> The kernel has no concept of LUKS at all.  It provides dm-crypt, which LUKS
>>> happens to use.  But LUKS is a userspace concept.
>>>
>>> This is a kernel patchset, so why does it make sense for it to be talking about
>>> LUKS at all?  Perhaps you mean dm-crypt?
>>
>> Exactly.
> 
> Thanks for raising the above concern! The use cases like CoreOS and
> Confidential VMs explicitly want kdump to work for LUKS. And correct me
> if I'm wrong, I think the two problems addressed by this patch set only
> apply to LUKS so the kdump part of the kernel only cares about the LUKS
> case. If there are use cases where similar approach is needed, I'll be
> happy to make the solution more generic.
> 
>>
>> I had the same comment almost a year ago... and it still applies:
>> https://lore.kernel.org/all/c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com/
>>
>> Anyway, please fix the naming before this patchset can be read or reviewed!
>>
>> LUKS is user-space key management only (on-disk metadata); the kernel has
>> no idea how the key is derived or what LUKS is - dm-crypt only knows the key
>> (either through keyring or directly in the mapping table).
>>
>> Polluting kernel namespace with "luks" names variables is wrong - dm-crypt
>> is used in many other mappings (plain, bitlocker, veracrypt, ...)
>> Just use the dm-crypt key, do not reference LUKS at all.
> 
> Thanks for the reminding! That comment was on the first RFC version. But
> starting with "RFC v2", there is no longer any interaction with dm-crypt
> (to save a copy of the LUKS volume key for the kdump kernel) and now I
> make cryptsetup talks to the kdump part of the kernel via the sysfs to
> reuse the volume key. So only the kdump part of the kernel needs to know
> LUKS which is what it cares. Thus I don't think there is any kernel
> namespace pollution now.

Hi,

I am sorry if I did understand correctly, but I thought that kdump is part
of the kernel.

I am trying to say that kernel generally has no concept of LUKS;
this is a userspace abstraction for key management.

Even the cryptsetup dm-crypt configuration mapping table generated from LUKS
has nothing LUKS special in it (only in DM-UUID as a name prefix).

So I do not understand why you need to mention LUKS even in kdump part.
Perhaps it is still only a naming problem, nothing more.

All you need is to preserve key and configuration parameters (for dm-crypt).
If it is set by cryptsetup, dmsetup, or any other way is not important - on this
kernel layer, it has nothing to do with LUKS key management metadata.

No problem if you support only LUKS in userspace, but really, all this machinery
should work for any dm-crypt devices. Perhaps your patch even works for it already.

Milan
