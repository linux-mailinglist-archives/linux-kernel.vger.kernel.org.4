Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF9560257E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiJRHUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiJRHUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:20:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3D13DF14;
        Tue, 18 Oct 2022 00:20:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so13235418pjl.0;
        Tue, 18 Oct 2022 00:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TlUHZSLgyN+Iy2ZHw1iVdzVnrjwNDaODH3GC5m/bHuI=;
        b=nVrDI3EyMXgMjYivuX8vqyo8cClBAL9BzAKbG9MC7nCPk3K8W/aD/305j/gU8MoM5k
         6o0KNlqwLB0WS+q0GAwHIYT8kOVOiNK9ydLit6nhzzHh66UwXAH9Ul4NOOAASvr6ySFK
         YxRvotPrddkdl5lxBP6kNack4WDURB0q2OEvqW+zmEMI7wnypccxUUWvdXjZcNi8FRLQ
         7pzRGL+aqtbtahk7q8kW5GDwYd5jUUl4u4O1+8CDE4hSJT/opXXCyLlZTWziYm63Y3yT
         pu/Ttg8cRnlAl7tNi/hFICLvo2+cxAt5BDOVjcaF2PUPKGGky02mR1W5+nH/PTpet41W
         Lg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlUHZSLgyN+Iy2ZHw1iVdzVnrjwNDaODH3GC5m/bHuI=;
        b=XbSDcf76bBeQDnyecER1woJoB7XL3mplNILD4kHD1ubaitRq04XJpC3aKgWQOJU7rT
         MWNPSkcfjKIxAqG6xPR9K4bIf2+nbldJq4jRHl3e9tMrgpO08GE2V/bx28Ci3+PgpKC4
         niphX4SGeC+n6e53+/M+6WoeBdlZTKME/BJ/cb70EVr62XrgyCkJOJv6tnVKEsXpYGKM
         Q7jgBpbzRIUlBdSOEJUX/d8MUqV02pjqXxiuHn0xdHuSq57HSeAIZtpyLx6Y3JncwLHZ
         1pu0qzdlzchuiwIRa5HT+O0hpWTSP3kySxHc7YkvASelPaEIfx5rxZ58qI/Eiy+jZk5N
         ylEw==
X-Gm-Message-State: ACrzQf3Ftka6nh4AOulTvbCiJ2Bayi9EpJ8456j2DIL1SQ7HHRRkQAhH
        1M8FLdLOLsXTSU3U7ES2Ki0=
X-Google-Smtp-Source: AMsMyM4gLlyL+JlYeqJ/Nt61Zrspm7QxgQgNVoXaH5OieEUmOXK+54+b9VK5iwCxH1FfixNqR6eQzw==
X-Received: by 2002:a17:90b:1c11:b0:20d:459b:ef0e with SMTP id oc17-20020a17090b1c1100b0020d459bef0emr37731813pjb.129.1666077628758;
        Tue, 18 Oct 2022 00:20:28 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-93.three.co.id. [180.214.233.93])
        by smtp.gmail.com with ESMTPSA id w186-20020a6262c3000000b00561d79f1064sm8413056pfb.57.2022.10.18.00.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 00:20:28 -0700 (PDT)
Message-ID: <087eb324-a38e-331e-c8fd-033818895ccc@gmail.com>
Date:   Tue, 18 Oct 2022 14:20:20 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH V2 2/2] Documentation: kdump: describe VMCOREINFO export
 for RISCV64
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
        k-hagio-ab@nec.com, hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20221014134139.5151-1-xianting.tian@linux.alibaba.com>
 <20221014134139.5151-3-xianting.tian@linux.alibaba.com>
 <Y04bOv49sRsauLb6@debian.me>
 <188e331c-d399-e86d-e894-a2a116deb753@linux.alibaba.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <188e331c-d399-e86d-e894-a2a116deb753@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/22 13:06, Xianting Tian wrote:
> 
> 在 2022/10/18 上午11:19, Bagas Sanjaya 写道:
>> On Fri, Oct 14, 2022 at 09:41:39PM +0800, Xianting Tian wrote:
>>> The following interrelated definitions and ranges are needed by the kdump
>>> crash tool, they are exported by "arch/riscv/kernel/crash_core.c":
>> Better say "..., which are exported by ..."
>>
>>> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>>> index 6726f439958c..8e2e164cf3db 100644
>>> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
>>> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>>> @@ -595,3 +595,33 @@ X2TLB
>>>   -----
>>>     Indicates whether the crashed kernel enabled SH extended mode.
>>> +
>>> +RISCV64
>>> +=======
>>> +
>>> +VA_BITS
>>> +-------
>>> +
>>> +The maximum number of bits for virtual addresses. Used to compute the
>>> +virtual memory ranges.
>>> +
>>> +PAGE_OFFSET
>>> +-----------
>>> +
>>> +Indicates the virtual kernel start address of direct-mapped RAM region.
>>> +
>>> +phys_ram_base
>>> +-------------
>>> +
>>> +Indicates the start physical RAM address.
>>> +
>>> +MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END|KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
>>> +----------------------------------------------------------------------------------------------------------------------------------------------------
>>> +
>>> +Used to get the correct ranges:
>>> +
>>> +  * MODULES_VADDR ~ MODULES_END : Kernel module space.
>>> +  * VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
>>> +  * VMEMMAP_START ~ VMEMMAP_END : vmemmap region, used for struct page array.
>>> +  * KASAN_SHADOW_START ~ KASAN_SHADOW_END : kasan shadow space.
>>> +  * KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END : Kernel link and BPF space.
>> The documentation LGTM, thanks.
>>
>> When the patch subject is fixed,
> Could you tell me what patch subject should be changed to ? thanks

I mean the description, not subject (as in email). That is, fix the description
(see above). The subject shouldn't be changed. Sorry for inconvenience.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

