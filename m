Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA6E644C51
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 20:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLFTPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 14:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiLFTPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 14:15:11 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E724047C;
        Tue,  6 Dec 2022 11:15:10 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p8so25189073lfu.11;
        Tue, 06 Dec 2022 11:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfFKOBr66s1CwYSG2TTOFX37oTDo5VCSWbNTI8/Kwv4=;
        b=FbR73fIsdMR2GPrgHhHD+UTq9hQpNRGnvsBYxAjUFp6pfvgZr0f3krQfwdG05HyEy1
         GrqzuNBjEozr5uCrq355J5hfAROhjBeuriFoK7Wx/8Y+5uepSm64UppuyPyZyBXJu7sb
         t6hTT7Q7l6Yc3Vsc/E0zrw8cEhE1vTktFBImAKIE213k6f94zcrTVKWhHa3F6N2u+JYs
         YXCI/iRDp+4YGirsctZXJg5BTeMwuqg8KGgarVtxG2GiWC/WVUXJvhMIOaR5YNxPHSiS
         U1SMKtmtkVQdQSiGjdGkp6vMI05YWsRoFBqIh9b+qKNbsMfSXUli4dHVKTvkNWaIWHYj
         PQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfFKOBr66s1CwYSG2TTOFX37oTDo5VCSWbNTI8/Kwv4=;
        b=Bq+fjXkV9XCW52L0vzfKYvXgTw2AmDobiKRcI9TbvZ3OCUNop4knXEfa2yzpRo2f00
         aV6eqyj1SYDN4Ow3/I7kOV1ha9XI+0jpz2nZe/1crr6QtOZFVcLe1JLyvVVI5B6G20pt
         srbnA8eHVIlCV51P6TQl0/JG3ZsQ/4tIwDWhCdKck0sqayPIwstuUkpNXWuXgSUX5rDa
         K77zWWKYBxZjpDoZbwbc4T3Z72tz0NeFNksGsz1WGqGCyu//5TMVOF/HOFzsEiPxHWX4
         1uQFCGh4lVm2MekKy/K7T7sdD7+AfnO1HN1LogXT5zlgM53ICh0LYnSYbHPRQxpFhyfL
         zlzA==
X-Gm-Message-State: ANoB5pkokmyqVR7IATEvQoXD9OjJk9dXH1EJVJrLtKVHURSgaaoAUvfc
        SPmOpezqF8XtdFHR9XgABHHJV1ZfmKXdmWgwVtQ=
X-Google-Smtp-Source: AA0mqf6ETBMrhmv2FnJL6/8iC29PFIRvFowg7iEsc9rHdp3yWtBwlqKEvdeK6CW7hUEfF3YvW0no1zsbDZQmKY5m740=
X-Received: by 2002:a19:760b:0:b0:4b5:67d8:e3c2 with SMTP id
 c11-20020a19760b000000b004b567d8e3c2mr4872095lff.166.1670354108416; Tue, 06
 Dec 2022 11:15:08 -0800 (PST)
MIME-Version: 1.0
References: <20221206070029.7342-1-fmdefrancesco@gmail.com> <Y472ipY908pHip+B@linutronix.de>
In-Reply-To: <Y472ipY908pHip+B@linutronix.de>
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Date:   Tue, 6 Dec 2022 20:14:52 +0100
Message-ID: <CAPj211tzOzk7JBmCOaNUekx4APv+khnKk0pxLqOJppUAp0A+8A@mail.gmail.com>
Subject: Re: [PATCH] mm/highmem: Add notes about conversions from kmap{,_atomic}()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
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

On marted=C3=AC 6 dicembre 2022 09:00:10 CET Sebastian Andrzej Siewior wrot=
e:
> On 2022-12-06 08:00:29 [+0100], Fabio M. De Francesco wrote:
> > diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rs=
t
> > index 0f731d9196b0..9523e92299f6 100644
> > --- a/Documentation/mm/highmem.rst
> > +++ b/Documentation/mm/highmem.rst
> > @@ -100,10 +101,21 @@ list shows them in order of preference of use.
> >
> >    (included in the "Functions" section) for details on how to manage
nested
> >    mappings.
> >
> > -* kmap_atomic().  This permits a very short duration mapping of a sing=
le
> > -  page.  Since the mapping is restricted to the CPU that issued it, it
> > -  performs well, but the issuing task is therefore required to stay on
that
> > -  CPU until it has finished, lest some other task displace its mapping=
s.
> > +* kmap_atomic(). This function has been deprecated; use
kmap_local_page().
> > +
> > +  NOTE: Conversions to kmap_local_page() must take care to follow the
> > mapping +  restrictions imposed on kmap_local_page(). Furthermore, code
> > between the +  map/unmap operations may implicitly depended on the side
> > effects of +  kmap_atomic(), such as disabling pagefaults, migration,
> > and/or preemption. +  Such conversions should be changed to make explic=
it
> > calls for those +  requirements.

Sebastian, thanks for taking a look at my patch and replying.

>   Furthermore, code between the kmap_atomic() and kunmap_atomic()
>   functions may implicitly depended

I suppose it should be "depend"? Shouldn't it?

>   on the side effects of kmap_atomic()
>   namely disabling pagefaults or preemption or both.

I agree with you for rephrasing, mainly because it is
written in poor English.

However, I still have doubts about why you deleted "migration".
AFAIK, __kmap_local_pfn_prot() always takes care of disabling migration for
HIGHMEM enabled kernels.

How about !HIGHMEM, where kmap_local_page() is an indirect call to
page_address()? Did you mean that, if the code between kmap_atomic() and
kunmap_atomic() depended on migrate_disable() (in PREEMPT_RT) we should alw=
ays
just stay safe and call preempt_disable() together with conversion to
kmap_local_page()?

If so, I understand and I again agree with you. If not, I'm missing somethi=
ng;
so please let me understand properly.

Aside from the above, I'm not sure whether you deleted the last phrase befo=
re
your suggestion. What about making it to become "For the above-mentioned
cases, conversions should also explicitly disable page-faults and/or
preemption"?

Thanks again for noticing my mistakes.


Fabio

>
> > +  [Legacy documentation]
> > +
> > +  This permits a very short duration mapping of a single page.  Since =
the
> > +  mapping is restricted to the CPU that issued it, it performs well, b=
ut
> > +  the issuing task is therefore required to stay on that CPU until it =
has
> > +  finished, lest some other task displace its mappings.
> >
> >    kmap_atomic() may also be used by interrupt contexts, since it does =
not
> >    sleep and the callers too may not sleep until after kunmap_atomic() =
is
>
> Sebastian
