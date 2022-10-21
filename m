Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9EA606D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 03:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJUBnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 21:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJUBn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:43:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552AB2347B8;
        Thu, 20 Oct 2022 18:43:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i9so2470649wrv.5;
        Thu, 20 Oct 2022 18:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpYQmEfgAGQTHw4tMpaVY1Q6B3yGgHLEQFKQ4dAqAIo=;
        b=cG25X1pkbLoUkBTSBIoWf9hSUfzV64HGt1vha+d2d2GI/DzT6AYG+w3h/7tRs1kd7a
         2BjJfqCRMDrwAvF8QqXoXOpmDJY3/Eo9R8r/xXzOH0+lI+DJ4HL8hDxsIZ141wXtvMKL
         g63zCr3zHXWvckZPtRyTQFzBqY0KYuyCD0rj7hc7n7T1Rr5nbwiYOHX+oXAT/JQWFbNL
         36B1Owpb0tr+YGsCXH2Y6DBGwqEyW3H2dFpSOq0UOwtYfnBB/TbxYjfsxxoDdeNMiz1b
         WQ4qNjRQt+6dJUJchmBlYwdUdvWrUU6ArtslbFbWzgbRPpkpoCa7cUPXYNKvA6PvNn3f
         26nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpYQmEfgAGQTHw4tMpaVY1Q6B3yGgHLEQFKQ4dAqAIo=;
        b=tdk8eW0VYtZfllVLeqFphVukZJRuMqauzWOc8HHkaKD9AjmYj+7Ll+HJ2Qmp+TMhfi
         gFS6NTwbYYkFrXoOWzpY+NZknZQOLDDP97bf4rs2iww5QSA1FxdG5al9mtvQlHbMDO89
         p6p3YRPurbbrLrWII0DWLH7MDrnre5VGDwrovyuh9GfflWlF08aRe+wGwzBbYIMOiArz
         YFe23WHo4yk4eaolfM3YnegUhsVUD0lIW19KUEzPv8fxe2ksKnFVAgrF08X2EEyy8izK
         Rs+9VsCV97uktPx9jWZTE+E3AlDVRiEKxLTSpH9+9geTDZ0fp9mhCwwiJrjQnvmybamV
         IvsQ==
X-Gm-Message-State: ACrzQf2sF6jxFRcFyYss2MuJAVYlnt0gqC+wMElze5VENh/bm+1NgHcm
        B6AIdknivxsXQf/J3PCCUnNgLLBYrb0g6SQRMk8=
X-Google-Smtp-Source: AMsMyM4BaZyXszjxvTRu7nWdRXLuZZytRCLl53li+Y97UOXo/1etITiL6OVLfVghpf4uBw974kAqHvNamNiQn28KKeI=
X-Received: by 2002:a5d:59a4:0:b0:230:eaa4:88d7 with SMTP id
 p4-20020a5d59a4000000b00230eaa488d7mr10796878wrr.35.1666316605763; Thu, 20
 Oct 2022 18:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAJNi4rM0K=-wgJrS0iLMkam77JTO7oRxcP9VkHGbuTiVGBovMA@mail.gmail.com>
 <20221020111439.76e72230@gandalf.local.home>
In-Reply-To: <20221020111439.76e72230@gandalf.local.home>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Fri, 21 Oct 2022 09:43:14 +0800
Message-ID: <CAJNi4rMVUzfZJPge=ncaULD87wLQ4TwWS=oKDuC1hZMoWi0OjA@mail.gmail.com>
Subject: Re: Question about 'for_each_kernel_tracepoint(...)' function
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     bristot@kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 11:14 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 20 Oct 2022 17:32:57 +0800
> richard clark <richard.xnu.clark@gmail.com> wrote:
>
> > Hi,
> > Can this function only find the trace points defined in the kernel
>
> It should find all tracepoints.
I defined an event trace point in module B(in the header file):
...
#define TRACE_SYSTEM    cus_tp
...
TRACE_EVENT(function_event_a,
        /* all the data struct parameter is in form of pointer instead
of object */
        TP_PROTO(enum event ev),
        TP_ARGS(ev),
        ...
);

After the module B inserted, the output is:

root@robotics:/sys/kernel/debug/tracing# cat available_events | grep func
cus_tp:function_event_a

Then I inserted module A with below code snippet:

void fc(struct tracepoint *ktp, void *priv)
{
    pr_info("events: %s\n", ktp->name);
}

static int module_A_init(void)
{
    for_each_kernel_tracepoint(fc, NULL);
    return 0;
}

Then I insert the module A into the system with module B is inserted,
the dmesg shows:

root@ robotics:/home/robotics/evt-tp# dmesg | grep func
[149421.718576] events: call_function_entry
[149421.718578] events: call_function_exit
[149421.718579] events: call_function_single_entry
[149421.718581] events: call_function_single_exit

So Steve you can see that the 'for_each_kernel_tracepoint' doesn't
find the event tp defined in module B, but that tp indeed shows in
/sys/kernel/debug/tracing/available_events.

Any comments about that?

>
> > image? I want to define a trace event in my kernel module A, then B
> > module to register a probe callback function for that event TP in A. I
> > want to kick off a timer in A and call the traced function
> > periodically, thus I can monitor the events happening in A from B.
>
> You could also export the tracepoint from A and reference it directly in B.
>
> >
> > Can I do that, is it possible?
> >
>
> Try it and find out. Why ask?

Ah, as you can see that I did it, but the result is not what I
expected :-). Help?

Richard

>
> -- Steve
