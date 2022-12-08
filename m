Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240996474A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiLHQtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLHQtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:49:02 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3A484B7B;
        Thu,  8 Dec 2022 08:49:01 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg10so1545705wmb.1;
        Thu, 08 Dec 2022 08:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hsMzTABogzUqVL36MXI4Bwqt7GP8Ha0onsCnHRYRh2Q=;
        b=e+OlhxTZHCHii+mvM9NfCnSblX7FBij0qENhHrczpDVDiCwFtRHDuAdo6XWJ5QF3JE
         7Rv7ISBUuPaQnkTavXdh8PZpXUsyQ5X/rFCbQN6Qi3KSVOst/Hne2jk5T5J/b/4X9L9c
         zRjZsEOwAALYowiKHRW0U3ytsQ75K0Hgf/JEVL56gOyggrjHopg/Oi3Jw5+Er2aeXoMQ
         LxPN54jur8VssuTAOCD7Flubto77DxtNNm/0wCKhZatrNMgRvnHDXDkx2hzpf9c3wKnx
         +p8W7lt7zEGWPaEI29gmfoE6UoAIRs9kmHYvRhchB/b+RLoBX+z6UXaEmyE+xHU/n5We
         uP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsMzTABogzUqVL36MXI4Bwqt7GP8Ha0onsCnHRYRh2Q=;
        b=O3iWD/nh5Zurjbzdblg0baL5BtOJPIFhjBwBHg3v8CcnqWD5109wE+kAOkQCGVnFhP
         QLHnFYeqXVK69mXMUEpTgzxa8b9vkY98DsBcOezmQcl5LISaXpW/fKbaWcJCfGJu6j3B
         ABGdyZfiglogq4fKEAuMZzAnLFpbnsnQWy6PhQf9aWcrKqj/mwcriJ6bJ7vlPMWIIy0a
         kGEBARjyfxWQv/lIecjt/VfiGV9YuGpqrTBPrVonHa5GF/keZoFP3kMKC6qMwufR04nI
         Xtdz36lKBd8lxjAoHBjm0OU58yo2RNaWQgaAk5SHKVABraf1n0OOXclTl25PSMYK2v4+
         pflA==
X-Gm-Message-State: ANoB5pkztUKmSlJyyhldOWtzbHAU3PFpBwt6qQJtsDyBCGao/dVIsRGw
        dwbyJmpap15ro32zhsOqOckuMnqD/Bw=
X-Google-Smtp-Source: AA0mqf5QDcku8ZmuMe+If076NirJOAg6E6rKq1NI+0ipqaoHovwlZ8rCjVLB2oZhe6DwAhF1Qm7V1Q==
X-Received: by 2002:a05:600c:3592:b0:3d1:bc32:2447 with SMTP id p18-20020a05600c359200b003d1bc322447mr2413839wmq.21.1670518140088;
        Thu, 08 Dec 2022 08:49:00 -0800 (PST)
Received: from [10.20.0.4] ([89.36.76.136])
        by smtp.gmail.com with ESMTPSA id t15-20020a7bc3cf000000b003a3170a7af9sm5452003wmj.4.2022.12.08.08.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 08:48:59 -0800 (PST)
Message-ID: <304bce39-2ece-863c-33b3-b432685faa2d@gmail.com>
Date:   Thu, 8 Dec 2022 17:48:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/9] platform/surface: aggregator: Improve target/source
 handling in SSH messages
Content-Language: en-US
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221202223327.690880-1-luzmaximilian@gmail.com>
 <c09c9cef-14ac-2ab3-5e01-13189823a053@redhat.com>
 <CAO-hwJLHzRCJF96gKJwj7zCCPxRLoEw=cQ2w8=yLBOfyZz-c8w@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <CAO-hwJLHzRCJF96gKJwj7zCCPxRLoEw=cQ2w8=yLBOfyZz-c8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 17:24, Benjamin Tissoires wrote:
> On Thu, Dec 8, 2022 at 5:03 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Maximilian,
>>
>> On 12/2/22 23:33, Maximilian Luz wrote:
>>> We have some new insights into the Serial Hub protocol, obtained through
>>> reverse engineering. In particular, regarding the command structure. The
>>> input/output target IDs actually represent source and target IDs of
>>> (what looks like) physical entities (specifically: host, SAM EC, KIP EC,
>>> debug connector, and SurfLink connector).
>>>
>>> This series aims to improve handling of messages with regards to those
>>> new findings and, mainly, improve clarity of the documentation and usage
>>> around those fields.
>>>
>>> See the discussion in
>>>
>>>      https://github.com/linux-surface/surface-aggregator-module/issues/64
>>>
>>> for more details.
>>>
>>> There are a couple of standouts:
>>>
>>> - Patch 1 ensures that we only handle commands actually intended for us.
>>>    It's possible that we receive messages not intended for us when we
>>>    enable debugging. I've kept it intentionally minimal to simplify
>>>    backporting. The rest of the series patch 9 focuses more on clarity
>>>    and documentation, which is probably too much to backport.
>>>
>>> - Patch 8 touches on multiple subsystems. The intention is to enforce
>>>    proper usage and documentation of target IDs in the SSAM_SDEV() /
>>>    SSAM_VDEV() macros. As it directly touches those macros I
>>>    unfortunately can't split it up by subsystem.
>>>
>>> - Patch 9 is a loosely connected cleanup for consistency.
>>
>> Thank you for the patches. Unfortunately I don't have time atm to
>> review this.
>>
>> And the next 2 weeks are the merge window, followed by 2 weeks
>> of christmas vacation.
>>
>> So I'm afraid that I likely won't get around to reviewing
>> this until the week of January 9th.
>>
>>> Hans, Jiri, Benjamin, Sebastian: While patch 8 ("platform/surface:
>>> aggregator: Enforce use of target-ID enum in device ID macros") touches
>>> multiple subsystems, it should be possible to take the whole series
>>> through the pdx86 tree. The changes in other subsystems are fairly
>>> limited.
>>
>> I agree that it will be best to take all of this upstream through the
>> pdx86 tree. Sebastian thank you for the ack for patch 8/9.
>>
>> Jiri or Benjamin may we have your ack for merging patch 7/9 + 8/9
>> through the pdx86 tree ?
> 
> I can give you an ack for taking those through your tree, but I can
> not review the patches themselves because I was only CC-ed to those 2,
> and so was linux-input. Given that SSAM_SSH_TID_KIP is not in my
> current tree I assume it comes from this series.
> 
> Anyway, enough ranting :)

Apologies for that. I should have included you in the CC on at least
patch 2 as well, which introduces this symbol.

FWIW, here's the patchwork link to this series:

   https://patchwork.kernel.org/project/platform-driver-x86/list/?series=701392

Regards,
Max
