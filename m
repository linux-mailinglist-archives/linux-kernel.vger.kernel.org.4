Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD496101CD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbiJ0TiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbiJ0TiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:38:20 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8A57B1D7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:38:19 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id d18-20020a05683025d200b00661c6f1b6a4so1700024otu.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KLlLU6NZcsKagq1M5FJ/dI4gXr9LiGhnPtgl7MOrrrU=;
        b=R/ShnnTJHwGXouQScqwLtgkI6CMuvzdUDVOgHcopbjmRgeRUfVwWoFjt9l/OLqU2cR
         6BbRRFoX31iPyIvm4tL+BF0oBoTwGcozaw16uZE3GNYef1k+odSpQeKRqX5OXNKdlZto
         +Y/3oYjr2BVOWoJWxULKcSjzoPjAQU+PEN4qUmqKeM3uRNXPpo+5eoH3E5IcnLdg/uaG
         LdeBFdyXMGMGWHHVFrAqG4fMtgOcUjVrKSQiG4zLTiIBie2w3hXD7bD4mtPaLD0rBv0a
         l9OoaQ3J1trpMqdVKv6g5GXSdqmZsbK9sKbMUsIRTegPy7KK6a9B6DndYQBcSFgYdqKc
         5ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLlLU6NZcsKagq1M5FJ/dI4gXr9LiGhnPtgl7MOrrrU=;
        b=6xUkHNW1RkvJXtUI9uf1p4WcCnSwqrVDnMIljq4zqgsx9nKZpoFe+uqiVh14XFtlAv
         aqAGf4MIXLYuYK79K8pPP0Bh4HLERSNe/g2ayX1VUHeDsGw5qRqwk0rNfD2LSs0S2AlV
         y0e2U0hSOKaOtGhsLrdJf7zscSejRUpos051Mlzu3p2XAL89hZtlg56+eHhSiHbXpdik
         4TK87s0pjb1Bg7NMy2/M2Lc0cbNk3Zhmvpev2sKvsC9mnA0utiXhRPZNqJNVluRVJS46
         WG23it6hz+10FpSDCoK1PJId5q2lEfueQ+NyfNTXszyMk8c7f1ajZcR41ATn4HNJ93ky
         RBBA==
X-Gm-Message-State: ACrzQf0PDQRUxPWNlaUAEBUulOIPEgMLLUCBVDYlyGzYihV4vEmeDhtY
        s2u9mK23+XH+fBy4KWhKwHQ=
X-Google-Smtp-Source: AMsMyM5b/eoRWJB6TKvKyqrLHoxthHogogb4L5ggBLYx3LjJ77Og8qwzuXSwUKGgEicHexhtCdI5oQ==
X-Received: by 2002:a9d:5e8e:0:b0:65a:275c:7979 with SMTP id f14-20020a9d5e8e000000b0065a275c7979mr25727684otl.3.1666899499229;
        Thu, 27 Oct 2022 12:38:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b8-20020a9d4788000000b00666a5b5d20fsm860766otf.32.2022.10.27.12.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 12:38:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c12e3c4d-b5a4-1f83-73a8-ff115e8bd369@roeck-us.net>
Date:   Thu, 27 Oct 2022 12:38:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
References: <20221027150525.753064657@goodmis.org>
 <f62e19bb-497a-8cf6-93aa-d654d7850356@roeck-us.net>
 <20221027152058.5f75cfd1@gandalf.local.home>
 <20221027152740.532ff26f@gandalf.local.home>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221027152740.532ff26f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 12:27, Steven Rostedt wrote:
> On Thu, 27 Oct 2022 15:20:58 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>>> (many more of those)
>>> ...
>>> [   16.329989]  timer_fixup_free+0x40/0x54
>>
>> Ah, I see the issue here. Looks like the timer_fixup_free() is calling
>> itself and crashing.
>>
>> Let me take a look into that. I didn't touch the fixup code, and there
>> could be an assumption there that it's behaving with the old approach.
> 
> Can you add this and see if it makes this issue go away?
> 

Yes, that fixes the crash. However, it still reports

[   12.235054] ------------[ cut here ]------------
[   12.235240] ODEBUG: free active (active state 0) object type: timer_list hint: tcp_write_timer+0x0/0x190
[   12.237331] WARNING: CPU: 0 PID: 310 at lib/debugobjects.c:502 debug_print_object+0xb8/0x100
...
[   12.255251] Call trace:
[   12.255305]  debug_print_object+0xb8/0x100
[   12.255385]  __debug_check_no_obj_freed+0x1d0/0x25c
[   12.255474]  debug_check_no_obj_freed+0x20/0x90
[   12.255555]  slab_free_freelist_hook.constprop.0+0xac/0x1b0
[   12.255650]  kmem_cache_free+0x1ac/0x500
[   12.255728]  __sk_destruct+0x140/0x2a0
[   12.255805]  sk_destruct+0x54/0x64
[   12.255877]  __sk_free+0x74/0x120
[   12.255944]  sk_free+0x64/0x8c
[   12.256009]  tcp_close+0x94/0xc0
[   12.256076]  inet_release+0x50/0xb0
[   12.256145]  __sock_release+0x44/0xbc
[   12.256219]  sock_close+0x18/0x30
[   12.256292]  __fput+0x84/0x270
[   12.256361]  ____fput+0x10/0x20
[   12.256426]  task_work_run+0x88/0xf0
[   12.256499]  do_exit+0x334/0xafc
[   12.256566]  do_group_exit+0x34/0x90
[   12.256634]  __arm64_sys_exit_group+0x18/0x20
[   12.256713]  invoke_syscall+0x48/0x114
[   12.256789]  el0_svc_common.constprop.0+0x60/0x11c
[   12.256874]  do_el0_svc+0x30/0xd0
[   12.256943]  el0_svc+0x48/0xc0
[   12.257008]  el0t_64_sync_handler+0xbc/0x13c
[   12.257086]  el0t_64_sync+0x18c/0x190

Is that a real problem or a false positive ? I didn't see that
without your patch series (which of course might be the whole point
of the series).

Thanks,
Guenter

