Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CDE6E3CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 01:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjDPXFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 19:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDPXFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 19:05:04 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECA72102
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 16:05:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94971337b10so87022066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 16:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681686302; x=1684278302;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JfCcxv5wLUfMTELXAoE2t5WyF0Xi0PP+u/u08eUy+2I=;
        b=H66VS9lJEjt1KObnvR8249QRKSgoVyagjfpOWBsXehIFrQeIrpo35VJQNHaRkZnFnj
         PUzVpDOpkNsMnvFfsq13xBdZTsZLiH5wf75lR8rog6COXzTNjHJmSyInjs2VFCx5zv9S
         Z6y7/wcGXhbHrt6iRu7gasliOZlQBcom+i3R/y/9/GTfzC6tFrHzX3793v8Lut6Dj8Rk
         2RW1tO96E6lIGHo7yjpUVOLlcLEZkOjrv+D09D4JLyhbemkKzeq8wsWLOM/9uOSZOiId
         a/UkuwzqS6MINzaRWtyOCvQXoQVoyzF3n+PV0o957evCqjaGk3cXD3iflrbEL945i1S9
         jvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681686302; x=1684278302;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JfCcxv5wLUfMTELXAoE2t5WyF0Xi0PP+u/u08eUy+2I=;
        b=gNXAr86N2RIEvc/V0cnyO47aqjGDEGYRy1wUn9loH+ZEwl80dGnM+LqimHB0U4U89q
         bCk1vI6O7XS1yxG4S5yiNWnTdfkR1A3H2mK4hWICrt0KeFjtOCk3gh6MPyMeMXyz7zkB
         36dEQ8x+0c8/sjXne0PKSiMa3jbr4fRRIWhT/a+OUx0mHyG7EzesIWMx5x+5bRmQht7W
         dKUCYTFOSGGsxjAqvP+9Oe2+ihjCpojf68tzw75HuoipOzhRandaAAFjCAOqPu6baxIw
         XTUeSqLrNLpyH0dYkalsWgkWJFXBqmoUwb5V/53UrvTDK8yBsrhOdf2oZMepa9Pm5ad2
         Uu4A==
X-Gm-Message-State: AAQBX9fEvQ2qlfUtE9YzhDuQOuanJvDwabge2i+z2OfuG54saouQhKAV
        1NOPLfDkHKer7TLucvUMFXU=
X-Google-Smtp-Source: AKy350a5cudH4yO6cluPGC+FqL8+sxaXKMlI5R4NcktLq1tvB3/j3aoF4CQHQf0zBPTF1FLP51gheQ==
X-Received: by 2002:a17:906:7a4e:b0:94e:d5d7:67eb with SMTP id i14-20020a1709067a4e00b0094ed5d767ebmr7440893ejo.5.1681686301910;
        Sun, 16 Apr 2023 16:05:01 -0700 (PDT)
Received: from [192.168.10.10] ([37.252.92.4])
        by smtp.gmail.com with ESMTPSA id eq17-20020a170907291100b0094efe88a037sm3503048ejc.9.2023.04.16.16.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 16:05:01 -0700 (PDT)
Message-ID: <d513cd8d-0262-8c4e-d0d9-ec7eea45941a@gmail.com>
Date:   Mon, 17 Apr 2023 03:04:59 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] mm: khugepaged: Fix kernel BUG in
 hpage_collapse_scan_file
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Zach O'Keefe <zokeefe@google.com>
Cc:     Yang Shi <shy828301@gmail.com>, himadrispandya@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, linux-mm@kvack.org,
        skhan@linuxfoundation.org,
        syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20230330155305.423051-1-ivan.orlov0322@gmail.com>
 <20230331013301.ecgkjymaf3ws6rfb@google.com>
 <CAHbLzkoJ2zvKZpqd6NqikpCc8rGR02C87f0fPq8qwb1BF3K+9Q@mail.gmail.com>
 <CAAa6QmTLXSvygQQNk=8C4pB3D2Twy1guzo=+-aXhCqNAE3Q3MA@mail.gmail.com>
 <20230416113335.caeafda1328fdd4bfe2406e8@linux-foundation.org>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20230416113335.caeafda1328fdd4bfe2406e8@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/23 22:33, Andrew Morton wrote:
> 
> Circling back to this fix...
> 
> The BUG() is obviously real.  We're unsure that Ivan's fix is the best
> one.  We haven't identified a Fixes:, and as this report is against the 6.2
> kernel, a cc:stable will be needed.
> 
> According to the sysbot bisection
> (https://syzkaller.appspot.com/bug?id=7d6bb3760e026ece7524500fe44fb024a0e959fc),
> this is present in linux-5.19, so it might predate Zach's
> 58ac9a8993a13ebc changes.  But that bisection claim might be
> misleading.
> 
> And Zach is offline for a few months.  So can people please take a look
> and see if we can get this wrapped up?
> 
> Matthew, the assertion failure is in the
> 
> 	VM_BUG_ON(index != xas.xa_index);
> 
> which was added in 77da9389b9d5f, so perhaps you could take a look?
> 
> Thanks.

I tested the reproducers on the 99cb0dbd47a15 commit, and they do not 
trigger the problematic condition of shared memory truncation or 
hole-punching. I will investigate further, as there have been many 
changes in khugepaged since the 99cb0dbd47a15 commit that could 
potentially affect its behavior.
