Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E70C6AA8D1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 09:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCDI4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 03:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCDI4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 03:56:46 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75761C5A7;
        Sat,  4 Mar 2023 00:56:45 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id x12so3929872ybt.7;
        Sat, 04 Mar 2023 00:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677920205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UFU63RDASPJk22Kg3GWOjkWMm7mURdn+Uv1+ep8nQs=;
        b=Nlr+YUsO+zzngGAtrEVWUl7L/7sL6wk+eZSMYO7gXA9dWZmF91WgryTgdsJgcWlMH5
         gZNnHtU7LIHQdJOGVc0Z8KsjbjJcHiJmGdHbCwVPlyVsjsYn+UhsnS9OhEAPofTH0/4j
         TRmEh4qmB9T8SsRy9cFHACmQ9KEMq15ZGzgXKgGK7+FRZDAurHqn2I4jP6nfcQj9zseP
         0vfw+7GKrJa2U6CAYYye/TixXo7F31vPxq95MH43Xb7TIC5AqJNusVzxay43SKbcyCj8
         YC53qt4fiOSlTxXW4NMjPxIrohGelCuf+zNjSCCl+sK7CRBK4oeOrimtaMOGX+rk7eeq
         EqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677920205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UFU63RDASPJk22Kg3GWOjkWMm7mURdn+Uv1+ep8nQs=;
        b=QDSBZutbHZYVx3qzRC2ODVJaTTL0xG2h7dS7751UqAceoEEA3kR2TUiLcPKGKscWJ1
         tkLWI40ecjDh0Yrn//wakXLk86U2vaKWVx4u8tk+X59nV1EFt9lI2/pvknAIm5Vr/fq/
         HreS3U2xLHiXH385Gi6cMaW6AlTmU8DLelk5chCdoWHdmh5m1W6IzUAJaT4sETrAQMxi
         gDTYLKU6WgoSVMG9pKQKFFxDUa9rBmISlTwrgAfS2Bib29P1SpxbdsyRFn/MfOKNXXcN
         xx4cWNJt8QwGW1wE/XH2JQVOVEoU5ZT4OC/2XeDFMO9IzYocPW+97VzXhoRWxwUKKCBq
         iQRQ==
X-Gm-Message-State: AO0yUKVy4yLLm1XePqIz4MUkcNdwfKmh8J/qZd7nZHkNKezZ3VdR0dT5
        tW48YWIrrR7HCNDQf5EkBhDI4hQ6dN9xP465Hg0=
X-Google-Smtp-Source: AK7set/lnGPwn38sZt3T9BEU/gA+Gsy147tIajt2F1G6IcS3aB2DqE6p3BezyJyW2wX7TjOOwzlehsWh9EoMWViGCwM=
X-Received: by 2002:a5b:a10:0:b0:87a:957b:fd67 with SMTP id
 k16-20020a5b0a10000000b0087a957bfd67mr2566400ybq.10.1677920204997; Sat, 04
 Mar 2023 00:56:44 -0800 (PST)
MIME-Version: 1.0
References: <20230303151706.57851-1-ubizjak@gmail.com> <20230303151706.57851-3-ubizjak@gmail.com>
 <c63f96bb-2972-b96e-5105-d47c89f8571e@quicinc.com>
In-Reply-To: <c63f96bb-2972-b96e-5105-d47c89f8571e@quicinc.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Sat, 4 Mar 2023 09:56:36 +0100
Message-ID: <CAFULd4Z87YEkmtogBGmnCoAEq1HWeXb3JcJhr0rSnpjyiZ0nXA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ring_buffer: Change some static functions to bool
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 5:34=E2=80=AFPM Mukesh Ojha <quic_mojha@quicinc.com>=
 wrote:

> > -static int rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
> > +static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
> >   {
> >       unsigned long cnt, top, bottom, msb;
> >       unsigned long cnt2, top2, bottom2, msb2;
> > @@ -1490,7 +1488,7 @@ rb_set_head_page(struct ring_buffer_per_cpu *cpu_=
buffer)
> >       return NULL;
> >   }
> >
> > -static int rb_head_page_replace(struct buffer_page *old,
> > +static bool rb_head_page_replace(struct buffer_page *old,
> >                               struct buffer_page *new)
>
> nit: did you miss ret in rb_get_reader_page()?

Indeed, thanks for noticing!

> >   static __always_inline void
> > @@ -5408,9 +5407,8 @@ bool ring_buffer_empty(struct trace_buffer *buffe=
r)
> >   {
> >       struct ring_buffer_per_cpu *cpu_buffer;
> >       unsigned long flags;
> > -     bool dolock;
> > +     bool dolock, ret;
> >       int cpu;
> > -     int ret;
>
> nit: would have been nice if you would not have changed existing stuff
> i.e each variable on a separate line.
> >
> >       /* yes this is racy, but if you don't like the race, lock the buf=
fer */
> >       for_each_buffer_cpu(buffer, cpu) {
> > @@ -5438,8 +5436,7 @@ bool ring_buffer_empty_cpu(struct trace_buffer *b=
uffer, int cpu)
> >   {
> >       struct ring_buffer_per_cpu *cpu_buffer;
> >       unsigned long flags;
> > -     bool dolock;
> > -     int ret;
> > +     bool dolock, ret;
>
> same here

I'll do it in the way you propose in the follow-up revisiton.

> >
> >       if (!cpumask_test_cpu(cpu, buffer->cpumask))
> >               return true;
>
>
> Feel free to add
>
> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

Thanks.

Uros.
