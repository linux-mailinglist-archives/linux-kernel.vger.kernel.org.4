Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A046F9E9C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 06:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjEHEM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 00:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjEHEMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 00:12:46 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B53156B9;
        Sun,  7 May 2023 21:12:44 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-55a2691637bso60916277b3.0;
        Sun, 07 May 2023 21:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683519164; x=1686111164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxdv+tiHHxtMSCUmmF2nhE4zPo46/gCC6/c5WgX+QIo=;
        b=Wd58uvQPNeDTpMwH6WaqgsBQ3GRiTlydZigfGn7McqrCSg65FggvmsmYZJxu2TqIsD
         V3U61Kj8rQskRyvJycoTQJg7BXAqLDmWRIbTlPdSzWmFtj1ZgdY684GdORVm2FbZt/n/
         i+7HT95uhhoubyH3klQ4Bf7whs1G/TiT/sCXjz6RZBS4MJl3ifkdA5vk8a6QYCNgO4Ts
         iQrWKzq5KlutWxcWypQX7drRSaK4AsURwelA1L5ItRk2UDClmzuHqVMfw9JhywZKYsRB
         0OamDe9CYNgPGFjOuA7Kg4HjHMNbssRIMR8doCRnT9pQk3jdRHS6TiTUoFgSPM5GuH+u
         35Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683519164; x=1686111164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxdv+tiHHxtMSCUmmF2nhE4zPo46/gCC6/c5WgX+QIo=;
        b=gTiWB2XO+dDIL3VP3/7mwHiGpJy4VoR5RbFiDr9nC5Stxp8lZOmpmLSKztlACW73bt
         ZGK6Z8ouuKFTKzPRmQaVm88Wc0NWAuVTANNf1EvFCDnVyuvfWopGwNZT/duz4d0bX9mt
         3oN1zNGLRA3dPcaheD9Bnh/+gG966c2K9WjE6wIAAHzQNsIuMVzIvsihgu0bDNKkz5OP
         sH7OtTB5iVh80Zziu0EhZD52qdrUbXyYvBZV0SbYNlPRXN8UDjxp7N1XpJZwy5R/fLIP
         dJco4woaJgKv+GvxQgYX9tyPwHoV5sNpfew/2ZjdZfqlF1mSLFkFX1FITEg3f8vxeLQz
         Bvfw==
X-Gm-Message-State: AC+VfDx5WXm3mvUOpIIjgwhsQXQkaA0zUxA2CZA2jWn1uHHIeGkXYRue
        SOEpyYoXwUeBSDhC6VUJS2nIBXcGKQ7EDj6Y3y4=
X-Google-Smtp-Source: ACHHUZ45lHALaQcQvMDQx70o3+FskyEF6hIFCBV4J2FjWZpgLxb3FLsABol3CIdeafjYfjUXc14rPi7G0RPYg4RVFYM=
X-Received: by 2002:a81:a015:0:b0:55a:4117:a8f2 with SMTP id
 x21-20020a81a015000000b0055a4117a8f2mr9831603ywg.4.1683519163750; Sun, 07 May
 2023 21:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230428012235.119333-1-raghuhack78@gmail.com>
 <3235466.44csPzL39Z@suse> <ZFLaG8jHHXmRp67w@aschofie-mobl2>
 <2755196.BEx9A2HvPv@suse> <ZFPN340/UstRWtmR@aschofie-mobl2>
In-Reply-To: <ZFPN340/UstRWtmR@aschofie-mobl2>
From:   RAGHU H <raghuhack78@gmail.com>
Date:   Mon, 8 May 2023 09:42:36 +0530
Message-ID: <CAGWUp4oJsmwObs=Q8UYZP-0F6BO+gE1+YZYbYvg=G75WGWbLWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cxl/mbox: Remove redundant dev_err() after failed
 mem alloc
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

Just checked the response to this patch, sorry for responding late here.

I will take a note on all the points raised and will follow the
guidelines in future patches, and will correct this patch too.

Regards
Raghu


On Thu, May 4, 2023 at 8:53=E2=80=AFPM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Thu, May 04, 2023 at 12:46:37PM +0200, Fabio wrote:
> > On gioved=C3=AC 4 maggio 2023 00:03:07 CEST Alison Schofield wrote:
> > > On Wed, May 03, 2023 at 08:32:37PM +0200, Fabio wrote:
> > > > On venerd=C3=AC 28 aprile 2023 03:22:34 CEST Raghu H wrote:
> >
> > [...]
> >
> > > > >
> > > > > Signed-off-by: Raghu H <raghuhack78@gmail.com>
> > > >
> > > > Is "Raghu H" the name you sign legal documents with?
> > >
> > > Fabio,
> > > Rather than asking a specific question to determine if this is a
> > > valid SOB, let's just point folks to the documentation to figure
> > > it out themselves.
> > > I'm aware that the 'sign legal documents' test
> > > has been used in the past, but kernel only actually requires a
> > > known identity.
> > >
> > > https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html=
#sign-you
> > > r-work-the-developer-s-certificate-of-origin
> > > https://github.com/cncf/foundation/blob/659fd32c86dc/dco-guidelines.m=
d
> >
> > Alison,
> >
> > Thanks for your suggestions.
> >
> > I have just a couple of questions about this issue...
> >
> > 1) How do we know that the "real name", which the Linux official docume=
ntation
> > refers to, should be interpreted in accordance to the document pointed =
by the
> > second link you provided?
> >
> > I mean, how can we be sure that the official documentation should be
> > interpreted according to the second link, since it doesn't even cite th=
at
> > document from CNCF?
> >
> > Can you provide links to documents / LKML's threads that state agreemen=
t of
> > our Community about the "relaxed" interpretation by CNCF?
>
> Citation is hidden it git history. See:
> d4563201f33a ("Documentation: simplify and clarify DCO contribution examp=
le language")
>
> >
> > 2) It looks that some maintainers (e.g., Greg K-H) still interpret "[] =
using
> > your real name (sorry, no pseudonyms or anonymous contributions.)" in a
> > "strict" and "common" sense.
>
> See the commit log above. The language was updated to say
> "using a known identity (sorry, no anonymous contributions.)"
>
> >
> > Can you remember that Greg refused all patches from "Kloudifold" and wh=
y? If
> > not, please take a look at the following two questions / objections fro=
m Greg:
> > https://lore.kernel.org/linux-staging/ZCQkPr6t8IOvF6bk@kroah.com/ and
> > https://lore.kernel.org/linux-staging/ZBCjK2BXhfiFooeO@kroah.com/.
>
> The second link above is Greg recognizing that known pseudonyms are
> allowed.
>
> >
> > It seems that this issue it's not yet settled.
> > Am I overlooking something?
>
> Hey, I'm not meaning to jump on you for asking Raghu the question.
> I realize you are being helpful to someone who is submitting their first
> patch. I'm just saying to make the submitter aware of the guideline and
> put the burden on them to make sure they're using a known identity.
>
> Sometimes, what one person thinks of as 'common' is not. Let's refer to
> the docs and not add out personal or historical layers of interpretation
> on top of it. (The legal doc signing question may not apply to everyone.)
>
> Alison
>
> >
> > Again thanks,
> >
> > Fabio
> >
> > > > If not, please send a new version signed-off-by your full legal nam=
e.
> > > > Otherwise... sorry for the noise.
> > > >
> > > > Thanks,
> > > >
> > > > Fabio
> >
> >
> >
