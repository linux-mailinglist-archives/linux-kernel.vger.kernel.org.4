Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC4B628C41
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbiKNWnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237785AbiKNWnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:43:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279EF1B1E1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:43:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7938612AC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4580C433D6;
        Mon, 14 Nov 2022 22:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668465797;
        bh=Kyz7qXuHynhQNXUcms0YHezaQG/cvY+bbnSMn1E0ask=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MO+qZBVWvwRQ/8M2pT83gXnfysTCZjaN6YzLmcpLZZr9usR9i/KtWzhLy3c6W/IQY
         QK3lpto+p4FWHkKyTaR54jLoq1OafEmPFM4qjVo6WNolBkO4WZFPEMPmMfdh1CCb1/
         xZ4SImOBxfA4ZSDc9eJyDxLsZs47hL0jQqx3KJlrhZ27ykBfyrJMfbg0NalB4JBpoi
         PLEaglg10VpX8Ua54J8OBkIKiqGFSGcsOA7Rxoz5UtuFfeZzBILmF1uG+WOMYJZHln
         rpCEcI5ak08TTJ7ydmG0WdLg7j8gipS4bYQWVgs33+Fm7PyTWc7V/684lUQKZttsne
         loLf0C/LxGZjA==
Date:   Mon, 14 Nov 2022 16:43:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] checkpatch: add warning for non-lore mailing list URLs
Message-ID: <20221114224315.GA939630@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO7tian6JZFwS1MxN5PNAYO229Uubc1te_A+qcjiR7myRA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 01:00:59PM -0800, Peter Collingbourne wrote:
> On Mon, Nov 7, 2022 at 12:54 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Thu, Nov 03, 2022 at 06:34:31PM -0700, Peter Collingbourne wrote:
> > > On Thu, Nov 3, 2022 at 6:27 PM Joe Perches <joe@perches.com> wrote:
> > > > On Thu, 2022-11-03 at 18:07 -0700, Peter Collingbourne wrote:
> > > > > On Wed, Oct 19, 2022 at 03:28:43PM -0500, Bjorn Helgaas wrote:
> > > > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > > >
> > > > > > The lkml.org, marc.info, spinics.net, etc archives are not quite as useful
> > > > > > as lore.kernel.org because they use different styles, add advertising, and
> > > > > > may disappear in the future.  The lore archives are more consistent and
> > > > > > more likely to stick around, so prefer https://lore.kernel.org URLs when
> > > > > > they exist.
> > > > >
> > > > > If the commit message contains a line like:
> > > > >
> > > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > >
> > > > > this patch causes checkpatch.pl to complain. Would it be possible to
> > > > > restrict this to URLs?
> > > >
> > > > Yes, I believe this would probably work well enough:
> > > > ---
> > > >  scripts/checkpatch.pl | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > index 7be93c3df2bcb..fe25642d8bacc 100755
> > > > --- a/scripts/checkpatch.pl
> > > > +++ b/scripts/checkpatch.pl
> > > > @@ -3336,7 +3336,8 @@ sub process {
> > > >                 }
> > > >
> > > >  # Check for mailing list archives other than lore.kernel.org
> > > > -               if ($rawline =~ m{\b$obsolete_archives}) {
> > > > +               if ($rawline =~ m{\b$obsolete_archives} &&
> > > > +                   $rawline !~ /^\s*cc:/i) {
> > >
> > > Can we make this (to|cc): instead? Otherwise developers (like me) who
> > > use custom scripts to add To: headers to their patches before passing
> > > them to checkpatch.pl will also hit this warning if their patch is
> > > being sent To: one of these mailing lists.
> >
> > Why not make it look for "http" instead of the absence of "cc"?
> 
> "https" as well, but yes, that would make more sense to me, and would
> be less likely to require user workarounds.

Maybe like this?  (On top of my previous attempt, which is in -next)


commit d15f85247948 ("checkpatch: warn only for URLs to non-lore archives")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon Nov 14 16:33:12 2022 -0600

    checkpatch: warn only for URLs to non-lore archives
    
    Previously we warned for anything that contained the archive hostname, but
    some email addresses also contain those hostnames, and we'd rather not warn
    about those.  Only warn if we see "http" before the archive hostname.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    ---
    
    Sample commit for testing with "checkpatch -g":
    
      5e91e57e6809 Cc: linux-arm-kernel@lists.infradead.org

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1c3d13e65c2d..78cc595b98ce 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3336,7 +3336,7 @@ sub process {
 		}
 
 # Check for mailing list archives other than lore.kernel.org
-		if ($rawline =~ m{\b$obsolete_archives}) {
+		if ($rawline =~ m{http.*\b$obsolete_archives}) {
 			WARN("PREFER_LORE_ARCHIVE",
 			     "Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html\n" . $herecurr);
 		}
