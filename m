Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE6B7253F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjFGGPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbjFGGOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:14:50 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F70AA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:14:48 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-97458c97333so919337866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 23:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686118486; x=1688710486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qLbVbVUg9j5I15+llYMFFF7NMo/S4z5Ys0RB/9uQl58=;
        b=FG7o5Uu3KLda7yKUb03+cnxUWpeKTZ2TPWH2QZ2GkOCHeFctlwRxZkl5ngvgmJP19t
         E7c3SIPRCal7nrrmMpba5L6u3Y2cFJxTvxCvfosDCAFzWYCoSQ3GT7V7xDdkbHL3dWIT
         8dpBIjtW4BkfEvGlqpMeU2jMXqmQ+SACHSYgB1MPtIDKz8YDQB1xD3sxDwS2A2Vr5qdi
         VG23TKkisFswxRzyWS4/46BMXn+21pQ0H/japW3mCyDBF1kKCFuSW/yCmx1+0NomsaqS
         A9FWwv7v4itYvbmSc1xX55JTULymF0rvj3sk0zXban5GsJ8GLBcc1581wYfRQbGD3w+v
         V94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686118486; x=1688710486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLbVbVUg9j5I15+llYMFFF7NMo/S4z5Ys0RB/9uQl58=;
        b=Tw2lR4OUdP/sXpZxEB7m6rPKqJLctRHsMk4qrskPVov9gMgu5dowGC5zcvwU8Kyx1G
         dFlIz7ZVZeX3KQbW5f9y1xKdeF7nDSrtv4ERfYjo4rGU4zCNAGqV3cEoykZ07nEPHz+L
         TPoZeHxU3jlX+KhlvDmDp7K2EN7WP6f763CiedowDO4fwSJluiirEfbMOS0kN0UjMUSO
         pnCiOOLulwvJPDB2TlrduJDXzuUN70NklpB3ZAKEpEn02xaSN1ASrfWMQaFmJD02188Q
         Ma/n2OGDE0lcOBUHGE5kEk+U+bx6DDqPGa8Pu5cYpWqprizvxwSsYGH4enM3naM6yQGn
         SQ4g==
X-Gm-Message-State: AC+VfDwL8+whrfZrCsfjcqhcXpxIKDzaa78nQXzD8PGCSTtaSHHUpk0H
        G87zFfAKT25lt2u7yd7rdK8=
X-Google-Smtp-Source: ACHHUZ51uxuxW9U9f1VRvp0RizzYWoG0e9p/q7tzibsqn8ln24i89Nm+W/E8vW4DMNN/8/X4G/ILVA==
X-Received: by 2002:a17:906:6a15:b0:974:b15:fcda with SMTP id qw21-20020a1709066a1500b009740b15fcdamr4759049ejc.54.1686118486290;
        Tue, 06 Jun 2023 23:14:46 -0700 (PDT)
Received: from [147.251.42.107] (nbbroz2.fi.muni.cz. [147.251.42.107])
        by smtp.gmail.com with ESMTPSA id cd13-20020a170906b34d00b0096b15e4ffcesm6412886ejb.85.2023.06.06.23.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 23:14:45 -0700 (PDT)
Message-ID: <88581a3c-8bd3-f7b2-064c-c809a2152ed3@gmail.com>
Date:   Wed, 7 Jun 2023 08:14:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS
 volume key
To:     Coiby Xu <coxu@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, kexec@lists.infradead.org,
        Baoquan He <bhe@redhat.com>, x86@kernel.org,
        dm-devel@redhat.com, Pingfan Liu <kernelfans@gmail.com>,
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
 <a5eaa21d-6551-5857-98cd-50578fe59566@gmail.com>
 <oosx274kf6kzasncdfdg5a53ut6wey3nlnbho5x3rql2df3zep@c6r6m4whphvh>
Content-Language: en-US
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <oosx274kf6kzasncdfdg5a53ut6wey3nlnbho5x3rql2df3zep@c6r6m4whphvh>
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

On 6/6/23 13:02, Coiby Xu wrote:
> On Mon, Jun 05, 2023 at 09:09:49AM +0200, Milan Broz wrote:
>> On 6/5/23 04:31, Coiby Xu wrote:
>>> Hi Eric and Milan,
>>>
>>> On Sat, Jun 03, 2023 at 11:22:52AM +0200, Milan Broz wrote:
>>>> On 6/2/23 23:34, Eric Biggers wrote:
>>>>> On Thu, Jun 01, 2023 at 03:24:39PM +0800, Coiby Xu wrote:
>>>>>> [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS volume key
>>>>>
>>>>> The kernel has no concept of LUKS at all.  It provides dm-crypt, which LUKS
>>>>> happens to use.  But LUKS is a userspace concept.
>>>>>
>>>>> This is a kernel patchset, so why does it make sense for it to be talking about
>>>>> LUKS at all?  Perhaps you mean dm-crypt?
>>>>
>>>> Exactly.
>>>
>>> Thanks for raising the above concern! The use cases like CoreOS and
>>> Confidential VMs explicitly want kdump to work for LUKS. And correct me
>>> if I'm wrong, I think the two problems addressed by this patch set only
>>> apply to LUKS so the kdump part of the kernel only cares about the LUKS
>>> case. If there are use cases where similar approach is needed, I'll be
>>> happy to make the solution more generic.
>>>
>>>>
>>>> I had the same comment almost a year ago... and it still applies:
>>>> https://lore.kernel.org/all/c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com/
>>>>
>>>> Anyway, please fix the naming before this patchset can be read or reviewed!
>>>>
>>>> LUKS is user-space key management only (on-disk metadata); the kernel has
>>>> no idea how the key is derived or what LUKS is - dm-crypt only knows the key
>>>> (either through keyring or directly in the mapping table).
>>>>
>>>> Polluting kernel namespace with "luks" names variables is wrong - dm-crypt
>>>> is used in many other mappings (plain, bitlocker, veracrypt, ...)
>>>> Just use the dm-crypt key, do not reference LUKS at all.
>>>
>>> Thanks for the reminding! That comment was on the first RFC version. But
>>> starting with "RFC v2", there is no longer any interaction with dm-crypt
>>> (to save a copy of the LUKS volume key for the kdump kernel) and now I
>>> make cryptsetup talks to the kdump part of the kernel via the sysfs to
>>> reuse the volume key. So only the kdump part of the kernel needs to know
>>> LUKS which is what it cares. Thus I don't think there is any kernel
>>> namespace pollution now.
>>
>> Hi,
>>
>> I am sorry if I did understand correctly, but I thought that kdump is part
>> of the kernel.
> 
> Yes, there is the kernel part of the kdump although there is also the
> userspace part to make the feature complete:)
> 
>>
>> I am trying to say that kernel generally has no concept of LUKS;
>> this is a userspace abstraction for key management.
>>
>> Even the cryptsetup dm-crypt configuration mapping table generated from LUKS
>> has nothing LUKS special in it (only in DM-UUID as a name prefix).
>>
>> So I do not understand why you need to mention LUKS even in kdump part.
>> Perhaps it is still only a naming problem, nothing more.
>>
>> All you need is to preserve key and configuration parameters (for dm-crypt).
>> If it is set by cryptsetup, dmsetup, or any other way is not important - on this
>> kernel layer, it has nothing to do with LUKS key management metadata.
>>
>> No problem if you support only LUKS in userspace, but really, all this machinery
>> should work for any dm-crypt devices. Perhaps your patch even works for it already.
> 
> Thanks for the explanation! After reflecting on your words for some
> time, I realize I had an implicit assumption. I assumed is if I use a
> name like dm_crypt_key instead of luks_volume_key, I need to support all
> mappings like plain, bitlocker, veracrypt as mentioned by you and this
> could mean much more efforts. So I'm not motivated to do that as
> currently users only request kdump to work for LUKS.

Thanks, I think it is perfectly fine to implement just subset here.

> But maybe I can divide the efforts into the kernel part and userspace
> part. For the kernel part, almost no effort is needed since only
> renaming is needed as pointed out by you. For the userpace part, maybe
> it's OK to support preserving key only for LUKS2 in cryptsetup as hinted
> by your last paragraph? Does it look good to you from the viewpoint of
> the maintainer of cryptsetup?

My comment was just about proper naming in kernel, it is of course up to you
what you want to support in userspace (and even in kernel, extensions can
be added later).

Only LUKS2 uses keyring for volume key in dm-crypt as default option anyway.
I do not think you need any cryptsetup patches, all you need is to write
decrypted volume key from LUKS metadata with
   cryptsetup luksDump ---dump-volume-key -volume-key-file <out> <device>
(or any code equivalent with libcryptsetup), am I correct?

Milan
