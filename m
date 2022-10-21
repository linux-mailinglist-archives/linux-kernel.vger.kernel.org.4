Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34701606E87
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 05:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJUDvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 23:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJUDve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 23:51:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B47B1A5B38;
        Thu, 20 Oct 2022 20:51:33 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so4137591wma.3;
        Thu, 20 Oct 2022 20:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m+Kr/MzF5u2E20xH4CoeQwe3kOmIaEmxjZH+0nXcHeE=;
        b=p3uaTyIQP7g9FxfYR7NXJIrfKCU/pZL6qKlbfI7ijXJi9ot8J9VEP/xatK+x3MsbKn
         6gFlWA71cBcVioweaWscKMv/4sbAJf+zwpRThpDneXXj/FOEHkZatl7IB7oOe4sLkk14
         9y7iozX4Z4SAY3FdoAN4vgsF9cN+iIuzR363mk2/q/z1iZl9F6TMxjdjlShILmOOgAAQ
         xagQoSWhSHmA9FcghH3Y627vpzGhYqwReC+MhtFD455u/dVbphWst7Tjkw9jY/SpawMy
         CWu6JpsadLNW5JOCaROZKkHmrkBZ/tkoFOLZUaRld6smcz87EDRTXLwDCuWjTre7PWcu
         vfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+Kr/MzF5u2E20xH4CoeQwe3kOmIaEmxjZH+0nXcHeE=;
        b=zEE2lY0FbNOsjeFONFDYCLv0vK6+oaz7Xn5w2nkaOFdbLDHhxj/pF0YTZNB46fixlW
         QmExKjylJVqqRZyt1Pe6h3aNM3z3IIylqraPwTHrA5dMqD95Um3cGyN5+I4crhMPD1bJ
         aEFtis856niQCR6pkd/xKXcs3H/QzavEtAWwVhuS0bfbw2fRhkLltWMQh5p1mPxLVudX
         shGAhmFxuj6zEVnxmFk4Hxt085KoLwx0cCit+1/TFboPf7BG248IZ0XoVj3zM1dQK4nM
         xDBV7FQFl3cvka0RPvdU6f+vJbmir427O9AfDpGnYKddUAoOTr3tDbvxmAQ/gu6sS9g2
         SaxQ==
X-Gm-Message-State: ACrzQf1Yr7QgvBRHWKvnNFyiB1nhyIVxuIzc4XNPJLnD6NsKSdHbq7af
        ic6Ws0d43SG+rdU22JAxqcuwm5l3FwHV/IdZraXkRZalMAk=
X-Google-Smtp-Source: AMsMyM5QYO4vLIbh6iZPB4gJoE1h+uJEDSGynqO1hjhFnL3C5FSBtSzCf3V6Z92IzwVn57KPtszjhvRs615JYPBqjZU=
X-Received: by 2002:a1c:a1c3:0:b0:3c6:b709:aa49 with SMTP id
 k186-20020a1ca1c3000000b003c6b709aa49mr11593399wme.197.1666324291485; Thu, 20
 Oct 2022 20:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJNi4rM0K=-wgJrS0iLMkam77JTO7oRxcP9VkHGbuTiVGBovMA@mail.gmail.com>
 <20221020111439.76e72230@gandalf.local.home> <CAJNi4rMVUzfZJPge=ncaULD87wLQ4TwWS=oKDuC1hZMoWi0OjA@mail.gmail.com>
 <20221020221255.5b3dffe1@gandalf.local.home>
In-Reply-To: <20221020221255.5b3dffe1@gandalf.local.home>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Fri, 21 Oct 2022 11:51:20 +0800
Message-ID: <CAJNi4rPPDp0xeEmqMBqX-pBqgAX7Biivyd+P_zhC7Y0-K3W0VQ@mail.gmail.com>
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

On Fri, Oct 21, 2022 at 10:12 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 21 Oct 2022 09:43:14 +0800
> richard clark <richard.xnu.clark@gmail.com> wrote:
>
>
> > Ah, as you can see that I did it, but the result is not what I
> > expected :-). Help?
>
> Looking at the code, I see it does indeed only look at builtin tracepoints.

What the logic behind is not to implement a function like
'for_each_tracepoints' instead of 'for_each_kernel_tracepoint' to find
all the TPs defined by both builtin kernel and external kernel
modules, just like we can find all the kernel symbols and exported
symbols from external module?

>
> But if you want one module to have access to the tracepoints of another,
> then you can have the first one export it.
>
> EXPORT_SYMBOL_TRACEPOINT_GPL(function_event_a);
>
> And then module b should have access to it.
>
Yes, but module b needs to register a new probe call back function for
the new TPs defined by module a in my case, so first it needs to find
the TPs defined by module a. Any comments?

> -- Steve
