Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3F86C71AF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 21:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjCWUbc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Mar 2023 16:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWUb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 16:31:29 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE86B6A69;
        Thu, 23 Mar 2023 13:31:24 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id x3so91822298edb.10;
        Thu, 23 Mar 2023 13:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679603483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5taPSzEjjbZ4ws8Fl8wTQBMvT7J3MXVU2z5jLI0tXRs=;
        b=NgujQfsJ3BGlfRrFyZcewiZOme6+6ISx+wkGTTKfc/FHSIuT7M0yICQ78PH8lJn5mN
         nsRRsl6D91aZvvGHQYBdPbNESEFbPYf7wkVWstfOaOOoAwN0k670deaxDx3vHGsZkZpg
         jglKN3rTE5NEIaR5sNKTLYtaOsoHolsXLGlHuoKHGRRe3JNYp/XmB2jr6GJM/XFY+8kh
         7SOwcyrYBUqMd7tsR04giuwdbB4cJq+Wbl6WsRd6ezYPsz+LND5sEjEyt4GSuy0j7Cu0
         d22O2jJxmvnNHWy23YgJ9ELQdWRS4jdI/w73mLlgM/KcrNRbGqfnrSRQsa0tqowuDbld
         f3Gg==
X-Gm-Message-State: AAQBX9cOE+C49QD0TJs3vDWRcv44R+g60enxXzQvAk+PC37aI9H3xLeO
        XBOy+z0Q9+wfFjfbr2xx7Zs+0PaLl99dZt/bCqy09smR
X-Google-Smtp-Source: AKy350bqz+EgJnCNKZclFsQr22LptAC+q1U6CeACFZpYEvdrSniQIUGpINGYhGuLBUkM9s0X3b3mXkG+EswPCwpO7N8=
X-Received: by 2002:a17:907:d687:b0:93d:a14f:c9b4 with SMTP id
 wf7-20020a170907d68700b0093da14fc9b4mr181188ejc.2.1679603483238; Thu, 23 Mar
 2023 13:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230322102258.27390-1-andriy.shevchenko@linux.intel.com>
 <20230322102258.27390-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0imGNb8pETxdJmjJ9cSJQedeb=w2dcG6huDB=SpL-ufqA@mail.gmail.com> <ZBxFC6prEE5p4Wu1@smile.fi.intel.com>
In-Reply-To: <ZBxFC6prEE5p4Wu1@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Mar 2023 21:31:11 +0100
Message-ID: <CAJZ5v0g3iJ+QL=mL0a8cfoN9qT_FgM_j803ZWgcYn2AOpCN6AQ@mail.gmail.com>
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

On Thu, Mar 23, 2023 at 1:24 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Mar 22, 2023 at 07:50:55PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Mar 22, 2023 at 11:26 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > > 2) Remove double spaces for consistency.
> >
> > I don't quite agree with this.
> >
> > Double spaces after a period are recognized as end-of-sentence markers
> > by some editors (notably vi), so if they have been used intentionally,
> > I see no reason to replace them.
>
> For the sake of consistency. There places in very same file which do not
> follow this. I can invert and add a space to the rest. Do you prefer that?

Not really.  I just don't think that this is worth the churn.

> The reasoning will be kept the same, though.

Is the lack of consistency in this particular respect really an issue?

I guess you can argue that if there are mixed sentence ending styles
in one and the same comment, it is better to make them consistent,
which I can agree with.  Otherwise I'm not convinced.
