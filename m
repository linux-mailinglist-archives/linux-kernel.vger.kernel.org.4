Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718AA6E3BF3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 22:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjDPUkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 16:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjDPUkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 16:40:05 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23765211B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 13:40:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5067716f9e7so301636a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 13:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681677602; x=1684269602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Gmi/do156Oqurn6On7R7qt3l2vNSWVaalWH+Gn/vpM=;
        b=MoZJUZMV6rloOpwXdLAzDuGOg+XGzhwrmBxevKigjbxIyy6Vsf3l8DgMthmIMu93a3
         koN9dUheLelFz/KezCQN4OvkEgpwc5o/ds6mwGAlCLnnz8TfgWjO27231txGjGbR1jaO
         Ri9VwLug1wkXyrloJIYAtLn22yQhe2C8gWYSyrCL56tB6WqPb4Rq91T4QmjgcMfEqCJ5
         Xmc6Q/iD5VnQXzDrOEy2Kv1z/w2wxMcrZrITGGIUa226V8CoJ+gvRmVNzFvVaLyMk7rX
         +YtPh1OkEVw3zaBdaWvO06CdtYRulj/ulvxpYX3ReF4WA1eqi7RURxDI7jGoCdZdxZ/4
         iEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681677602; x=1684269602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Gmi/do156Oqurn6On7R7qt3l2vNSWVaalWH+Gn/vpM=;
        b=KSJYukM0zkleqN6mhQhYn4wMv+0FLKcvFTkMUGX9njvWso/1g7zrJDrPNtCRv0Vg1F
         q+3dsibRv0N7p3hllNTEiNAA1EBRcbuemMugpMnjGMli6SZ7vdt00mm1vsxpBVr1MYQi
         hWsfxJFgA7dxi2ueey5wRxXpYZu7UtGyOTw6TKFsFDSC/wNFXFR+ApOlRZAp7LdMdvUd
         BPsKWVjR/EIeBffLsLU+i0S8ebbYOIYpraSPSlHZB3sIMLkqc09KnlK7rjol4KxNpj1O
         17a0RqVJTDXVa//y44Ypgu8lSJt8WZZmiNaaclkG0kJhTqy8IzC8ojg+RDzN98jxKs9h
         jTfw==
X-Gm-Message-State: AAQBX9c3oEKiXnZuLVduXOtSxkvQXtS0f8RtaTr+N3Gyp5vJ7qgVscwx
        kD5+8Hh2ezRoblqkU7Im8+an/W5ITWp0nQ==
X-Google-Smtp-Source: AKy350Zl9UbVjnQxDl3btqlMf8RV3X44RulxYOQ2N9ntqnKgRdCPVIMtABj54YobhwzwJahy36T6Cw==
X-Received: by 2002:a17:906:19c:b0:94f:66af:b1f7 with SMTP id 28-20020a170906019c00b0094f66afb1f7mr1551753ejb.1.1681677602426;
        Sun, 16 Apr 2023 13:40:02 -0700 (PDT)
Received: from [192.168.10.10] ([37.252.92.4])
        by smtp.gmail.com with ESMTPSA id qb3-20020a1709077e8300b008c327bef167sm5562437ejc.7.2023.04.16.13.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 13:40:02 -0700 (PDT)
Message-ID: <195d006f-b595-c0d4-24a5-49d8d350745b@gmail.com>
Date:   Mon, 17 Apr 2023 00:39:59 +0400
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

Hello, Andrew!

I have been unable to reproduce the problem with any of the existing 
reproducers on the 3d7cb6b04c3f3115719235cc6866b10326de34cd commit, 
which was detected by the syzkaller bisection. I also tried to test if 
the problem is reproducible on this commit via syzbot, but it did not 
detect the problem. It's possible that the bisection claim is 
misleading, as the issue may not be consistently reproducible.

Why did you mention the 58ac9a8993a13ebc commit? I thought 99cb0dbd47a15 
was considered as a "Fixes". 99cb0dbd47a15 is older than 3d7cb6b04c3f3, 
and the problematic code appeared there, so probably the problem could 
appear in 99cb0dbd47a15 as well.

Please, correct me if I'm missing something.

Kind regards,
Ivan Orlov.
