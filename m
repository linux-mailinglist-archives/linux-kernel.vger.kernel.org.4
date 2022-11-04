Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C93618DB3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 02:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiKDBlI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Nov 2022 21:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiKDBlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 21:41:05 -0400
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C901CFE7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 18:41:03 -0700 (PDT)
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 231461403BF;
        Fri,  4 Nov 2022 01:41:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 349EE19;
        Fri,  4 Nov 2022 01:40:40 +0000 (UTC)
Message-ID: <5f982ebd7223369362e6e27d111704883c4d7e44.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add warning for non-lore mailing list URLs
From:   Joe Perches <joe@perches.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 03 Nov 2022 18:40:57 -0700
In-Reply-To: <CAMn1gO7tEF+VioB8n0=8vQ4gRPKqSSfPwmbX8ci82D=hBbcfyw@mail.gmail.com>
References: <20221019202843.40810-1-helgaas@kernel.org>
         <Y2RlxvPAvzVXtw9t@google.com>
         <8a23b1d3ee853cee73385e8144338f399cbe3165.camel@perches.com>
         <CAMn1gO7tEF+VioB8n0=8vQ4gRPKqSSfPwmbX8ci82D=hBbcfyw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 349EE19
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: xx8geahtz6kg4k8x38xyjfx19uabak3d
X-Rspamd-Server: rspamout08
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18TXSuxzj/vDwrzPBLA9PircB3AGsSMNx0=
X-HE-Tag: 1667526040-381510
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-11-03 at 18:34 -0700, Peter Collingbourne wrote:
> On Thu, Nov 3, 2022 at 6:27 PM Joe Perches <joe@perches.com> wrote:
> > 
> > On Thu, 2022-11-03 at 18:07 -0700, Peter Collingbourne wrote:
> > > On Wed, Oct 19, 2022 at 03:28:43PM -0500, Bjorn Helgaas wrote:
> > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > 
> > > > The lkml.org, marc.info, spinics.net, etc archives are not quite as useful
> > > > as lore.kernel.org because they use different styles, add advertising, and
> > > > may disappear in the future.  The lore archives are more consistent and
> > > > more likely to stick around, so prefer https://lore.kernel.org URLs when
> > > > they exist.
> > > 
> > > If the commit message contains a line like:
> > > 
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > 
> > > this patch causes checkpatch.pl to complain. Would it be possible to
> > > restrict this to URLs?
> > 
> > Yes, I believe this would probably work well enough:
> > ---
> >  scripts/checkpatch.pl | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 7be93c3df2bcb..fe25642d8bacc 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -3336,7 +3336,8 @@ sub process {
> >                 }
> > 
> >  # Check for mailing list archives other than lore.kernel.org
> > -               if ($rawline =~ m{\b$obsolete_archives}) {
> > +               if ($rawline =~ m{\b$obsolete_archives} &&
> > +                   $rawline !~ /^\s*cc:/i) {
> 
> Can we make this (to|cc): instead? Otherwise developers (like me) who
> use custom scripts to add To: headers to their patches before passing
> them to checkpatch.pl will also hit this warning if their patch is
> being sent To: one of these mailing lists.

I think adding "To:" would be odd and unnecessary as it's not
something that would actually be in a patch.

You could use another front-end script to strip those "To:" from
checkpatch inputs.

