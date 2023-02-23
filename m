Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1B86A0079
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjBWBNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjBWBM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:12:59 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2AEDB;
        Wed, 22 Feb 2023 17:12:57 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x10so36874080edd.13;
        Wed, 22 Feb 2023 17:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yCnAecKSgLOg4OmJ3SNmPcBBl6aku449iICNL+KS8yg=;
        b=PLav7alo74Ec4FjsEDYCTSnkvzXGK/yqyiM7xYoylTx4kfEHPZM9/cxwUyeDxyt0mP
         w3TbekUZa7RuEYL3I4hhRdwrDe6sW/gZ7DksrskCSzAVVFR/INhjpE1NyOClejvkrV3A
         hbXG21GV/oEsVCPxZ7AXTy/0pDQSP/UjlBeggzUYbO1Rnk6UiTwI2b8JrwOGBcCFNSp/
         +oB0Nm0X1OPGBWObTdBtO958/8P5hHkl0VKicail+Uixi2TxCZn791Y1AUz4tJcj3Oty
         M2UQcuHDcLThcalWmL5CHJpey8hleuei0IWJAi7cL3yr5s/KAAq9Q9HjHK7DhnNRCIg+
         xA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCnAecKSgLOg4OmJ3SNmPcBBl6aku449iICNL+KS8yg=;
        b=wVqUN6xI1xfph2uTSNNT11SVd3ZRKn0ymx2a1WpFK4kOhImkBZVBzAHGcI6dJdhW8H
         vXNcDyhFXhYhxhAWVfrguF7yWfqPhz0mLL8YtMh9RNPrd8uQsGiDXcbLbegTIwlyFHbH
         BE6p8IsZ/6kQy3H9N9obXyCgg+1B+0T6DuTBUiFhwSNZRmmnDjI7ugl96frxzVRQTs6l
         s2YJvGWY6/+Ga5TuEIhmj//xcGMEKosMsLw62gCFoTiVp+EG5TcAd0Qnwl8DtSoxyVl5
         CI/jzGS/tA+dsMC1nbCjVZkq8L2fwZ78x6tZOqgof2998HlQjBN2gA3mtWmY0U601oD1
         +J5A==
X-Gm-Message-State: AO0yUKW2wrj/1Fbl0KmePL+lh3bPExVQ0ZiUvvwXsn15LvENlqzCvm5h
        /CT62CoSBmPxQw6SNFwBMkHhkQDkVvMVdQadFQU7bB83f7A=
X-Google-Smtp-Source: AK7set8XyJP9u4BHGXGWA/foiZSNXL/IKmCVZr34ZU1eaILBgou26PSTj5JKMroRJw7oRODY57KTd67BoQpVLfPoFG0=
X-Received: by 2002:a17:906:f6c2:b0:8b1:2ebf:386b with SMTP id
 jo2-20020a170906f6c200b008b12ebf386bmr8895778ejb.12.1677114775969; Wed, 22
 Feb 2023 17:12:55 -0800 (PST)
MIME-Version: 1.0
References: <20230221180049.2501495-1-carlos.bilbao@amd.com>
 <20230221180049.2501495-2-carlos.bilbao@amd.com> <CAPDLWs99LUCQ47huoiiZmQfAsHX8Esmepu_hSCXWoqcpEoPxKQ@mail.gmail.com>
 <c5317c66-fea2-37da-26ab-091117880d26@amd.com>
In-Reply-To: <c5317c66-fea2-37da-26ab-091117880d26@amd.com>
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date:   Thu, 23 Feb 2023 06:42:38 +0530
Message-ID: <CAPDLWs8mXmCXwP=tnKNF+Ffouf+a1HU2FYUgL6Npp+_imWwPjg@mail.gmail.com>
Subject: Re: [PATCH 1/1] docs: Add relevant kernel publications to list of books
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, rlove@rlove.org, linux-doc@vger.kernel.org,
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

On Wed, Feb 22, 2023 at 7:44 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>
> On 2/22/23 05:08, Kaiwan N Billimoria wrote:
> > Hi Carlos,
> >
> > On Tue, Feb 21, 2023 at 11:30 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
> >>
> >> For the list of kernel published books, include publication covering kernel
> >> debugging from August, 2022 (ISBN 978-1801075039). Also add foundational
> >> book from Robert Love (ISBN 978-1449339531) and remove extra spaces.
> >>
> >> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> >> ---
> >>   Documentation/process/kernel-docs.rst | 29 ++++++++++++++++++++++-----
> >>   1 file changed, 24 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
> >> index 1c6e2ab92f4e..ce461d981d0a 100644
> >> --- a/Documentation/process/kernel-docs.rst
> >> +++ b/Documentation/process/kernel-docs.rst
> >> @@ -75,13 +75,31 @@ On-line docs
> >>   Published books
> >>   ---------------
> >>
> >> +    * Title: **Linux Kernel Debugging: Leverage proven tools and advanced techniques to effectively debug Linux kernels and kernel modules**
> >> +
> >> +      :Author: Kaiwan N. Billimoria
> >> +      :Publisher: Packt Publishing Ltd
> >> +      :Date: August, 2022
> >> +      :Pages: 638
> >> +      :ISBN: 978-1801075039
> >> +      :Notes: Debugging book
> >> +
> >>       * Title: **Linux Kernel Programming: A Comprehensive Guide to Kernel Internals, Writing Kernel Modules, and Kernel Synchronization**
> >>
> >> -          :Author: Kaiwan N. Billimoria
> >> -          :Publisher: Packt Publishing Ltd
> >> -          :Date: 2021
> >> -          :Pages: 754
> >> -          :ISBN: 978-1789953435
> >> +      :Author: Kaiwan N. Billimoria
> >> +      :Publisher: Packt Publishing Ltd
> >> +      :Date: 2021
> >> +      :Pages: 754
> >> +      :ISBN: 978-1789953435
> >> +
> >> +    * Title: **Linux System Programming: Talking Directly to the Kernel and C Library**
> >> +
> >> +      :Author: Robert Love
> >> +      :Publisher: O'Reilly Media
> >> +      :Date: June, 2013
> >> +      :Pages: 456
> >> +      :ISBN: 978-1449339531
> >> +      :Notes: Foundational book
> >>
> >>       * Title: **Linux Kernel Development, 3rd Edition**
> >>
> >> @@ -92,6 +110,7 @@ Published books
> >>         :ISBN: 978-0672329463
> >>         :Notes: Foundational book
> >>
> >> +
> >>   .. _ldd3_published:
> >>
> >>       * Title: **Linux Device Drivers, 3rd Edition**
> >> --
> >> 2.34.1
> >>
> >
> > Thanks very much.
> >
> > A request to incorporate a few minor changes (I applied these small
> > changes on the latest linux-next I could find):
>
> Sure, I will send v2 with your changes and signature.
Thanks again.
I have no issue though with your SoB, pl do retain it... (sorry for
the trouble).

Also, do you think specifying the free download URL for the LKP Part 2
book's a good idea?
T&R,
>
> >
> > Signed-off-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
> > ---
> >   Documentation/process/kernel-docs.rst | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/process/kernel-docs.rst
> > b/Documentation/process/kernel-docs.rst
> > index 1c6e2ab92f4e..f7ecc04b509b 100644
> > --- a/Documentation/process/kernel-docs.rst
> > +++ b/Documentation/process/kernel-docs.rst
> > @@ -75,11 +75,20 @@ On-line docs
> >   Published books
> >   ---------------
> >
> > +   * Title: **Linux Kernel Debugging: Leverage proven tools and
> > advanced techniques to effectively debug Linux kernels and kernel
> > modules**
> > +
> > +          :Author: Kaiwan N Billimoria
> > +          :Publisher: Packt Publishing Ltd
> > +          :Date: August, 2022
> > +          :Pages: 638
> > +          :ISBN: 978-1801075039
> > +          :Notes: Debugging book
> > +
> >       * Title: **Linux Kernel Programming: A Comprehensive Guide to
> > Kernel Internals, Writing Kernel Modules, and Kernel Synchronization**
> >
> > -          :Author: Kaiwan N. Billimoria
> > +          :Author: Kaiwan N Billimoria
> >             :Publisher: Packt Publishing Ltd
> > -          :Date: 2021
> > +          :Date: March, 2021
> >             :Pages: 754
> >             :ISBN: 978-1789953435
> >
>
> Thanks,
> Carlos
