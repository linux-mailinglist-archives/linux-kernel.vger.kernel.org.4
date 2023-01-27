Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B5E67EDDA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjA0Swa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjA0Sw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:52:28 -0500
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AE994;
        Fri, 27 Jan 2023 10:52:27 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id cw4so424833edb.13;
        Fri, 27 Jan 2023 10:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jw63GzPu4GtHBPw24o9RJNE5pYfXgCOIEYBBEaEe0S8=;
        b=uToDeALBsnLIJraZ0sWyS64CrBzZJbtwQMldnvIeGNtpSwKMQjPN1aDbyn4ZE5B+F9
         Ff1bg0XD4TW9nTRmA4NTUsPxt4zOtbEY3Yl0l9IavnNuCOadbMs3f5qe+syqkC4khWif
         gb7qtAGyo6/s7wwCl/CPtasOp4cH3A4p74PrEqYS+47Jl6tfPqYlFNNzu2/GKQ76aDv1
         G9mmGf41KLE+7ZSXvYcZWeAP5nDpdgtmmAXVOIqKcEaDd/KJCe/83SDkVGE4GwedkxDK
         09eh6ZFMf3/Nt3EzPmadpPN5d36DMnIq9i9aP7YZ+s6mexiTCyQ7O7sMg+RP9+7kCJ/W
         2kog==
X-Gm-Message-State: AO0yUKV5BMj7s5rl6d20zTPocVVOS64VOmzL9KE+h21jCSn7pmTQIYQd
        d6EJD0cEJ0dlXpi+cqoWTBxYu5S724NsTzU1Ec8=
X-Google-Smtp-Source: AK7set9Vdi/DhQGJC5Hr+Bj+Arl0dZza8GGHXkQK4NDcqc7sJqTZn3Zl/cudIQBOQxp4fiVjVqNWqqAoZOME+iBchMw=
X-Received: by 2002:a05:6402:175c:b0:4a0:8f64:cddc with SMTP id
 v28-20020a056402175c00b004a08f64cddcmr3162453edx.58.1674845546326; Fri, 27
 Jan 2023 10:52:26 -0800 (PST)
MIME-Version: 1.0
References: <20221118181538.never.225-kees@kernel.org> <202301151037.20CC3F0@keescook>
 <CAJZ5v0hvoAD1WLXzpMobTRSasBqy5dypHTysBU3=ionGgWR6nQ@mail.gmail.com>
 <202301201116.6ED85A70@keescook> <CAJZ5v0hQypNonoqr1V1xqN5bX+pKBF3AR=F-mRynN5yvcS9kyA@mail.gmail.com>
 <202301271032.43B50EB7@keescook>
In-Reply-To: <202301271032.43B50EB7@keescook>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 27 Jan 2023 19:52:14 +0100
Message-ID: <CAJZ5v0iV3vjkVMKOpmTEzHxRHPTeR23daSpDQtbfmgSE4K6AXQ@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Replace fake flexible arrays with flexible array members
To:     Kees Cook <keescook@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 7:33 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jan 27, 2023 at 07:08:39PM +0100, Rafael J. Wysocki wrote:
> > On Fri, Jan 20, 2023 at 8:16 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Fri, Jan 20, 2023 at 07:10:52PM +0100, Rafael J. Wysocki wrote:
> > > > On Sun, Jan 15, 2023 at 7:38 PM Kees Cook <keescook@chromium.org> wrote:
> > > > >
> > > > > On Fri, Nov 18, 2022 at 10:15:51AM -0800, Kees Cook wrote:
> > > > > > Functionally identical to ACPICA upstream pull request 813:
> > > > > > https://github.com/acpica/acpica/pull/813
> > > > >
> > > > > Any update on this? Upstream is currently unbuildable since October.
> > > > >
> > > > > > One-element arrays (and multi-element arrays being treated as
> > > > > > dynamically sized) are deprecated[1] and are being replaced with
> > > > > > flexible array members in support of the ongoing efforts to tighten the
> > > > > > FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> > > > > > with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> > > > > >
> > > > > > Replace one-element array with flexible-array member in struct
> > > > > > acpi_resource_extended_irq. Replace 4-byte fixed-size array with 4-byte
> > > > > > padding in a union with a flexible-array member in struct
> > > > > > acpi_pci_routing_table.
> > > > > >
> > > > > > This results in no differences in binary output.
> > > > >
> > > > > In the meantime, can you take this patch for Linux, and we can wait for
> > > > > ACPICA to catch up?
> > > >
> > > > Applied now (as 6.3 material), sorry for the delay.
> > >
> > > Thanks!
> >
> > Unfortunately, this breaks compilation for the ACPI tools in tools/power/acpi/.
>
> What's the make target to test this?

Just cd to tools/power/acpi in the kernel tree and run make.

> > Apparently, the problem is that DECLARE_FLEX_ARRAY() is not defined
> > when the tools are built, because kernel headers are not used then.
>
> This should exist in the stddef.h tools headers, but perhaps it isn't
> included already?

No, it isn't AFAICS.

> > I guess the changes from your upstream PR need to be backported
> > literally for this to work, so I'll drop this one for the time being.
> > Or please let me know if you have a better idea.
>
> I can send a new version if I can reproduce the build failure you see...

Sure, thanks!
