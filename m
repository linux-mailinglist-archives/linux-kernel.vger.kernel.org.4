Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B571764F900
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 14:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiLQNDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 08:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLQNDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 08:03:08 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A4D15F38
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 05:03:07 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c17so7063886edj.13
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 05:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=69wMVBbMUf7q1wk12sG+5Pbl393b7aseI5S0vJIzBqo=;
        b=ormwcdT2BdleMpLdy4gqlVlc1mstmurpTaIfnr1WDmsyadxmnQMYSs8PBAFW6YqACx
         4P5kvyxXnC0HBvfqN+MSXSK32msdAPxiKPtoYnFtpSziuN0C3ot06tbA5oBfyHYPyU79
         nygG1RIPVbmn0p5uPGuhzAFq1S3wspEYkXFbdtGyfAoBdG1Q5KoxIKDkFfXwm5RDscOF
         Jgo7GjlRif63Nc3wJYWoXvQ9VYUtGQhP8xw5q1JRvxrzZ/W+gKY11+OQ3vN0vm1dY+3W
         5qGfIOJPuZk5O+c5jI05T9JTeAIS57nX31eNPHNzHAygg891smByVPK3E8b0lPJooBv9
         AQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69wMVBbMUf7q1wk12sG+5Pbl393b7aseI5S0vJIzBqo=;
        b=S+QiJdUMnTlLgh7X0vxAHDuEIq34cYrKOHaF3oqxOiI9h0zcjJarUZekvEJarz4tbF
         Xl/sszfT0vvz0Eo9NFbd8Vj03ePuRUWLioHOrrD/kFrPRlnHRb+b+hvbRgR/PsezVRbd
         X9YR+AGbn59URdeRPx0XHYQhoVQ46wNVRHACvmebYmfa7Xcj0/VL/B6QNU2Q+E+KoBEe
         PY5j131ZwaUW5dPhvFSc5srK8ukYsgJsjikrn/sQv/FdfAEbnOf7DrEGMlkZ7zhN+lvK
         ZanisGzip8UdeeSPQff7OqUc5rWwTZcetCDmyXtWMBOoZ9ENRCBS/YTKmhzS/M4vPMCB
         l8Bg==
X-Gm-Message-State: AFqh2krNUmooTSbEnRuc1lS7DXLpXzKIlILQlSBXGdhppjjEruA15ent
        4ShTkozxLxyUrlAgEyZFVVLHfKmFWXZBZ+oO52jlLUKtOW8=
X-Google-Smtp-Source: AMrXdXuTbIqQmiW4ZOSkN3RgCsKPJV/dM2U+IDthtTpbocB1cWwmFDYYovD5AUB8HV6HZ0nzxf2UlpGqUiZl6zEwVrU=
X-Received: by 2002:a05:6402:6c9:b0:473:ae62:40cc with SMTP id
 n9-20020a05640206c900b00473ae6240ccmr1170607edy.374.1671282185881; Sat, 17
 Dec 2022 05:03:05 -0800 (PST)
MIME-Version: 1.0
References: <CAPDLWs-Z8pYkwQ13dEgHXqSCjiq4xVnjuAXTy26H3=8NZCpV_g@mail.gmail.com>
 <Yz/ZWBeNZvKenEVM@kroah.com> <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
In-Reply-To: <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date:   Sat, 17 Dec 2022 18:32:48 +0530
Message-ID: <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
Subject: Re: Reg the next LTS kernel (6.1?)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi,
Any update on 6.1 being set as the next LTS release?

Thanks and regards,
Kaiwan.


On Fri, Oct 7, 2022 at 1:20 PM Kaiwan N Billimoria
<kaiwan.billimoria@gmail.com> wrote:
>
> Thanks Greg.. will wait for it!
>
> On Fri, Oct 7, 2022 at 1:15 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Oct 07, 2022 at 01:07:54PM +0530, Kaiwan N Billimoria wrote:
> > > Greetings!
> > > I'm working on the 2nd edition of the Linux Kernel Programming book
> > > (https://www.amazon.com/gp/product/B07RW915K4/ref=dbs_a_def_rwt_bibl_vppi_i0)
> > > and request your help...
> > >
> > > I'd like to base the book upon as recent a kernel version as is
> > > feasible, of course, with the caveat that it's a long-term (LTS) one
> > > that will be around for a while. Currently, the 5.10 LTS kernel's EOL
> > > date - Dec 2026 - makes it an ideal candidate.
> > >
> > > However, if possible, I'd (also) like to use a 6.x kernel; so, my
> > > question comes down to this: will a 6.1 kernel release occur soon (I
> > > heard it should be around Dec this year)? Will it be an LTS kernel
> > > (again, should be I guess), and, if so, very important for me, what's
> > > the likely EOL date?
> >
> > I usually pick the "last kernel of the year", and based on the normal
> > release cycle, yes, 6.1 will be that kernel.  But I can't promise
> > anything until it is released, for obvious reasons.
> >
> > thanks,
> >
> > greg k-h
