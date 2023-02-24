Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96BD6A14CA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 03:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjBXCJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 21:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBXCJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 21:09:17 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7E12A154;
        Thu, 23 Feb 2023 18:09:16 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id i34so24069906eda.7;
        Thu, 23 Feb 2023 18:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bL6ym21iaTwuVnT9wy2oUPQGdYabrjeuwhSvL5/VRXg=;
        b=a3+T1xo0VdgygwjDxqh9jSFY0Yd+/ZI5k5kY6ymDgMPhsdYrR+ypGiF47UcBqkMZER
         S46TeL6VQA5yFF9czvDVKm5H/vRIfTllhuUkK8cybbzepY3ffU9KOvbKHGDl24Npshw9
         0IlXYpWz+RvV6MHhNGbDaxY9XMhXW0QfKoWV6FiB9st8POaaHj8KiHGEuzYHklQhczeo
         1hDIqv5IFaRbGEV4tbwhOidVOQO+404yd56BCvuOXWYDEwm2oA8RvHC3ZXId3QzEc9dL
         qfVoxzrNG1Fy7IWIQqbaVGF4a36vwhunCue60IdM/af/dNdfnnIMLtzYzZukDMvxVF1r
         MSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bL6ym21iaTwuVnT9wy2oUPQGdYabrjeuwhSvL5/VRXg=;
        b=UOdGdb0pspqEI25mbrBIw1UI/w1Cj8/zkscqWEG9/TvTvhEIBQg3XbXPm+EaXuY4Z6
         FObTtchSsU+39xuknQ5hYvnXI1ny5WeDaMUJhLM+6lHqjuYU2pkR19a/x9CEo4754/d2
         8wCjPy5BNM3yMEzrLQhE/7zVNd6W8vMiN1dvqX2xVoyyL+enRZByfUr79Dp1vUviUVyo
         SHSnfDxJRIo1pDhYNDYq9cQnbN8JSUl79p0fLztpKnJHtaQfEOZcaet5cGhu/27Winot
         ovM8ESYhmIz4wRVvVzWb5FmJyMzaLzf02diXC3Rou3IArU8KTvN7AcXU84jGXozrNfGu
         w1xw==
X-Gm-Message-State: AO0yUKUr9KLBNieeDQz/3tu3qJ4oBZ08CIeQPJ88XmvBFL8O0ziDR4gw
        eIp8XlZbXt3bkSpVsdo67pdAfaKvdwD3Moni7Vw=
X-Google-Smtp-Source: AK7set9WX7zdu3A03AxuYDgAbiCFUReVxc8TUicPoGFcAtWFwkheqsYXOy2bECsmVAN0GuIRfi29thGN0nCiRkGFaD8=
X-Received: by 2002:a17:906:48e:b0:883:2c50:5401 with SMTP id
 f14-20020a170906048e00b008832c505401mr9894295eja.12.1677204554419; Thu, 23
 Feb 2023 18:09:14 -0800 (PST)
MIME-Version: 1.0
References: <20230221180049.2501495-1-carlos.bilbao@amd.com>
 <20230221180049.2501495-2-carlos.bilbao@amd.com> <CAPDLWs99LUCQ47huoiiZmQfAsHX8Esmepu_hSCXWoqcpEoPxKQ@mail.gmail.com>
 <c5317c66-fea2-37da-26ab-091117880d26@amd.com> <CAPDLWs8mXmCXwP=tnKNF+Ffouf+a1HU2FYUgL6Npp+_imWwPjg@mail.gmail.com>
 <2406f0ea-8e54-3b81-ae09-c459786facb0@amd.com>
In-Reply-To: <2406f0ea-8e54-3b81-ae09-c459786facb0@amd.com>
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date:   Fri, 24 Feb 2023 07:38:56 +0530
Message-ID: <CAPDLWs-SNbocyryLqWZGdra6N1WBk+QAoLGwCncM9xr6F_aOFA@mail.gmail.com>
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

On Thu, Feb 23, 2023 at 6:45 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>
> On 2/22/23 19:12, Kaiwan N Billimoria wrote:
> > On Wed, Feb 22, 2023 at 7:44 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
> >>
> >> On 2/22/23 05:08, Kaiwan N Billimoria wrote:
> >>> Hi Carlos,
> >>>
> >>> On Tue, Feb 21, 2023 at 11:30 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
> >>>>
> >>>> For the list of kernel published books, include publication covering kernel
> >>>> debugging from August, 2022 (ISBN 978-1801075039). Also add foundational
> >>>> book from Robert Love (ISBN 978-1449339531) and remove extra spaces.
> >>>>
> >>>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> >>>> ---
> >>>>    Documentation/process/kernel-docs.rst | 29 ++++++++++++++++++++++-----
> >>>>    1 file changed, 24 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
> >>>> index 1c6e2ab92f4e..ce461d981d0a 100644
> >>>> --- a/Documentation/process/kernel-docs.rst
> >>>> +++ b/Documentation/process/kernel-docs.rst
> >>>> @@ -75,13 +75,31 @@ On-line docs
> >>>>    Published books
> >>>>    ---------------
> >>>>
> >>>> +    * Title: **Linux Kernel Debugging: Leverage proven tools and advanced techniques to effectively debug Linux kernels and kernel modules**
> >>>> +
> >>>> +      :Author: Kaiwan N. Billimoria
> >>>> +      :Publisher: Packt Publishing Ltd
> >>>> +      :Date: August, 2022
> >>>> +      :Pages: 638
> >>>> +      :ISBN: 978-1801075039
> >>>> +      :Notes: Debugging book
> >>>> +
> >>>>        * Title: **Linux Kernel Programming: A Comprehensive Guide to Kernel Internals, Writing Kernel Modules, and Kernel Synchronization**
> >>>>
> >>>> -          :Author: Kaiwan N. Billimoria
> >>>> -          :Publisher: Packt Publishing Ltd
> >>>> -          :Date: 2021
> >>>> -          :Pages: 754
> >>>> -          :ISBN: 978-1789953435
> >>>> +      :Author: Kaiwan N. Billimoria
> >>>> +      :Publisher: Packt Publishing Ltd
> >>>> +      :Date: 2021
> >>>> +      :Pages: 754
> >>>> +      :ISBN: 978-1789953435
> >>>> +
> >>>> +    * Title: **Linux System Programming: Talking Directly to the Kernel and C Library**
> >>>> +
> >>>> +      :Author: Robert Love
> >>>> +      :Publisher: O'Reilly Media
> >>>> +      :Date: June, 2013
> >>>> +      :Pages: 456
> >>>> +      :ISBN: 978-1449339531
> >>>> +      :Notes: Foundational book
> >>>>
> >>>>        * Title: **Linux Kernel Development, 3rd Edition**
> >>>>
> >>>> @@ -92,6 +110,7 @@ Published books
> >>>>          :ISBN: 978-0672329463
> >>>>          :Notes: Foundational book
> >>>>
> >>>> +
> >>>>    .. _ldd3_published:
> >>>>
> >>>>        * Title: **Linux Device Drivers, 3rd Edition**
> >>>> --
> >>>> 2.34.1
> >>>>
> >>>
> >>> Thanks very much.
> >>>
> >>> A request to incorporate a few minor changes (I applied these small
> >>> changes on the latest linux-next I could find):
> >>
> >> Sure, I will send v2 with your changes and signature.
> > Thanks again.
> > I have no issue though with your SoB, pl do retain it... (sorry for
> > the trouble).
> >
> > Also, do you think specifying the free download URL for the LKP Part 2
> > book's a good idea?
>
> Yes, that sounds like a good idea as long as it is a legal download. If you
> share the link with me I will include it in the near future in the
> successive patches of this file.
It's definitely legal. The link is:
https://github.com/PacktPublishing/Linux-Kernel-Programming/blob/master/Linux-Kernel-Programming-(Part-2)/Linux%20Kernel%20Programming%20Part%202%20-%20Char%20Device%20Drivers%20and%20Kernel%20Synchronization_eBook.pdf

Thanks,
Kaiwan.
>
>
> > T&R,
> >>
> >>>
> >>> Signed-off-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
> >>> ---
> >>>    Documentation/process/kernel-docs.rst | 13 +++++++++++--
> >>>    1 file changed, 11 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/Documentation/process/kernel-docs.rst
> >>> b/Documentation/process/kernel-docs.rst
> >>> index 1c6e2ab92f4e..f7ecc04b509b 100644
> >>> --- a/Documentation/process/kernel-docs.rst
> >>> +++ b/Documentation/process/kernel-docs.rst
> >>> @@ -75,11 +75,20 @@ On-line docs
> >>>    Published books
> >>>    ---------------
> >>>
> >>> +   * Title: **Linux Kernel Debugging: Leverage proven tools and
> >>> advanced techniques to effectively debug Linux kernels and kernel
> >>> modules**
> >>> +
> >>> +          :Author: Kaiwan N Billimoria
> >>> +          :Publisher: Packt Publishing Ltd
> >>> +          :Date: August, 2022
> >>> +          :Pages: 638
> >>> +          :ISBN: 978-1801075039
> >>> +          :Notes: Debugging book
> >>> +
> >>>        * Title: **Linux Kernel Programming: A Comprehensive Guide to
> >>> Kernel Internals, Writing Kernel Modules, and Kernel Synchronization**
> >>>
> >>> -          :Author: Kaiwan N. Billimoria
> >>> +          :Author: Kaiwan N Billimoria
> >>>              :Publisher: Packt Publishing Ltd
> >>> -          :Date: 2021
> >>> +          :Date: March, 2021
> >>>              :Pages: 754
> >>>              :ISBN: 978-1789953435
> >>>
> >>
> >> Thanks,
> >> Carlos
>
> Thanks,
> Carlos
