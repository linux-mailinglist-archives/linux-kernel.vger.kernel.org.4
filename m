Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C6D62000F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbiKGVBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiKGVBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:01:14 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827EBCD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:01:13 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso10429882wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 13:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=huoWTfaSBSNabOTu8jLdOIsULUfjwezMDUAEtSsfxiU=;
        b=kYXoRYVlVEcb7RbrPtvjd8OGKkcA9ffT/2fJt6eI1BaARstfQoDIXHaEW0XGJ5juOi
         1oD/TPTdmvY35FBMKX6tlxJfrgTKGWUrnzFgThyvE35jScUMi5rlVWnrbc9HtwDc4Whj
         bCeslbQU1Zdy6UOzVjUo78g3CYWuGtJmYLWVDsk1xVkYhbfqmNPQ8bVhza0Dt3oTUrpo
         arE3yVvUiZ/zPYmA9diWMAVPqTBapEDru+jyK+ZN7gCRPMP5aYoTifnId+GcHTrV0F3Y
         ZWEMTwVPlp75J43a+vQtt+j5vifNqFU+SWFOs/xwe7LQraiHfqH7CenJVmPodJdxkr6v
         soIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=huoWTfaSBSNabOTu8jLdOIsULUfjwezMDUAEtSsfxiU=;
        b=QBDRY0TJLmqwwFySXBQQcDUCpoHTbW1RK5qq3EEPpJvI/yHOCuOOYVUdzqOR1zXjBT
         +EYUnZu/BjvyvbSg6C2vrNHpKG78cLvKOBEA/FcJfk7ea07yWsLQRI3QIl8yMzaFPSxC
         rPkSKEEDCstbwAV5rU1mFqcykFAxpECXcHnUmDbgf587jdvuprjT4f5iDhl8zMfIQIs+
         Xn3SokapA+QhgR87QWshLO1QZ7ClfLlkTRy/FL+25grkNzHRiPuayr5qIVKTCvP7ku2/
         W9Dm6rQe9+Cg6tO9q5lF5X5h3zCPqq6rgV4z7NzgeMjicHs82cStKF94CITFpO97GarJ
         WKkQ==
X-Gm-Message-State: ACrzQf1gK7l9YoZn+PDdKZCcb0xf0DP2X1k1+w7cNNbEb6P075SPHWN9
        358uFHLvOJjwNQClrphQwpI8LxMOIx0327C4gHgI/w==
X-Google-Smtp-Source: AMsMyM6ghanDGPgJzTVEaBMI+EYbhPY7yUJ6fFlyPmv2Gf31wkj1GqQkzY73/8/31MZzytHEVBnPLhhfDWbi+9cIUKc=
X-Received: by 2002:a1c:f214:0:b0:3be:4e7c:1717 with SMTP id
 s20-20020a1cf214000000b003be4e7c1717mr35289744wmc.171.1667854871647; Mon, 07
 Nov 2022 13:01:11 -0800 (PST)
MIME-Version: 1.0
References: <CAMn1gO7tEF+VioB8n0=8vQ4gRPKqSSfPwmbX8ci82D=hBbcfyw@mail.gmail.com>
 <20221107205405.GA419220@bhelgaas>
In-Reply-To: <20221107205405.GA419220@bhelgaas>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 7 Nov 2022 13:00:59 -0800
Message-ID: <CAMn1gO7tian6JZFwS1MxN5PNAYO229Uubc1te_A+qcjiR7myRA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add warning for non-lore mailing list URLs
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 12:54 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Nov 03, 2022 at 06:34:31PM -0700, Peter Collingbourne wrote:
> > On Thu, Nov 3, 2022 at 6:27 PM Joe Perches <joe@perches.com> wrote:
> > > On Thu, 2022-11-03 at 18:07 -0700, Peter Collingbourne wrote:
> > > > On Wed, Oct 19, 2022 at 03:28:43PM -0500, Bjorn Helgaas wrote:
> > > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > >
> > > > > The lkml.org, marc.info, spinics.net, etc archives are not quite as useful
> > > > > as lore.kernel.org because they use different styles, add advertising, and
> > > > > may disappear in the future.  The lore archives are more consistent and
> > > > > more likely to stick around, so prefer https://lore.kernel.org URLs when
> > > > > they exist.
> > > >
> > > > If the commit message contains a line like:
> > > >
> > > > Cc: linux-arm-kernel@lists.infradead.org
> > > >
> > > > this patch causes checkpatch.pl to complain. Would it be possible to
> > > > restrict this to URLs?
> > >
> > > Yes, I believe this would probably work well enough:
> > > ---
> > >  scripts/checkpatch.pl | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 7be93c3df2bcb..fe25642d8bacc 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -3336,7 +3336,8 @@ sub process {
> > >                 }
> > >
> > >  # Check for mailing list archives other than lore.kernel.org
> > > -               if ($rawline =~ m{\b$obsolete_archives}) {
> > > +               if ($rawline =~ m{\b$obsolete_archives} &&
> > > +                   $rawline !~ /^\s*cc:/i) {
> >
> > Can we make this (to|cc): instead? Otherwise developers (like me) who
> > use custom scripts to add To: headers to their patches before passing
> > them to checkpatch.pl will also hit this warning if their patch is
> > being sent To: one of these mailing lists.
>
> Why not make it look for "http" instead of the absence of "cc"?

"https" as well, but yes, that would make more sense to me, and would
be less likely to require user workarounds.

Peter
