Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFFB6C7D85
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjCXLzj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Mar 2023 07:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjCXLzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:55:33 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FD52384C;
        Fri, 24 Mar 2023 04:55:33 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id b20so7039968edd.1;
        Fri, 24 Mar 2023 04:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679658931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNsKfjAOpIO8JhcnVTvMdig7UkXSU1Jnj3TMrTCyGns=;
        b=hmDkoXri3IJqMn9SMlevuwYktcRNESjR0c8rWTYkQczcnospDSCqHwtPqcsEaK/7Co
         YvC4dzFXxeCzEsZFrDt40RnB3DSZTsuKWnYr7CAI4JmuY2HOotm9VJmEuBCHWQzVh938
         1cob5RMrcj6R5ri4w6XCQGqVulPSjhHAfUKP7OJ2bMRFKOMl+JTDSEK3XPvX8caiMj7G
         g48P+jbtClomkOuRN0/1nSb4OKCEdgwAs78thM6SNMj05F1bJEoNOsjDtPM88KtocOr9
         fuRLJ68NgCtXUrkoDugkkdhhPSUnEQG4ErZToMfXSz647zEvCTvEfdQ3ElaizNds0rVx
         093g==
X-Gm-Message-State: AAQBX9f0kCsPzx/nB/YOL/9ElGaa3CVFeHA9O85lX5R5psXAPI2kMKLX
        +ZoOGH6wtFS56TexNBmPfFunZbuNFPtug0/eebxgBWDG
X-Google-Smtp-Source: AKy350YyE864GXibhry+Ib+EH3AV27baEi8VKqPkrtaA/MPz61SXDRXYSGGGKonp9zbroUOmMGIuKjUJL2LglFFiVr0=
X-Received: by 2002:a17:907:d02:b0:931:6921:bdbb with SMTP id
 gn2-20020a1709070d0200b009316921bdbbmr1224231ejc.2.1679658931556; Fri, 24 Mar
 2023 04:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230322102258.27390-1-andriy.shevchenko@linux.intel.com>
 <20230322102258.27390-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0imGNb8pETxdJmjJ9cSJQedeb=w2dcG6huDB=SpL-ufqA@mail.gmail.com>
 <ZBxFC6prEE5p4Wu1@smile.fi.intel.com> <CAJZ5v0g3iJ+QL=mL0a8cfoN9qT_FgM_j803ZWgcYn2AOpCN6AQ@mail.gmail.com>
 <ZB1n7Om3oqE0eRo6@smile.fi.intel.com>
In-Reply-To: <ZB1n7Om3oqE0eRo6@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Mar 2023 12:55:20 +0100
Message-ID: <CAJZ5v0ggr7DJtP6iY8osaNQh3EVdgoipXJ2hoAq+nkPidxadPQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ACPI: SPCR: Amend indentation
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 10:05 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Mar 23, 2023 at 09:31:11PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Mar 23, 2023 at 1:24 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>
> > > On Wed, Mar 22, 2023 at 07:50:55PM +0100, Rafael J. Wysocki wrote:
> > > > On Wed, Mar 22, 2023 at 11:26 AM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > > > > 2) Remove double spaces for consistency.
> > > >
> > > > I don't quite agree with this.
> > > >
> > > > Double spaces after a period are recognized as end-of-sentence markers
> > > > by some editors (notably vi), so if they have been used intentionally,
> > > > I see no reason to replace them.
> > >
> > > For the sake of consistency. There places in very same file which do not
> > > follow this. I can invert and add a space to the rest. Do you prefer that?
> >
> > Not really.  I just don't think that this is worth the churn.
>
> Ah, that's fine.
>
> > > The reasoning will be kept the same, though.
> >
> > Is the lack of consistency in this particular respect really an issue?
> >
> > I guess you can argue that if there are mixed sentence ending styles
> > in one and the same comment, it is better to make them consistent,
> > which I can agree with.  Otherwise I'm not convinced.
>
> Okay, do you agree with the first patch in the series?

I do.  In fact, I've applied it already.

> Then I can redo this one by dropping these particular
> changes.

Yes, please.
