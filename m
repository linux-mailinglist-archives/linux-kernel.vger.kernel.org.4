Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB75628C58
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbiKNWud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiKNWua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:50:30 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C3F167F1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:50:29 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id k8so21129345wrh.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MLbo5g9uLgPvSVRf/+x9JU41DKk9JcOB/vtan5wpg84=;
        b=gJF1GgGqGydpygwbbvg4oQdwApWF+6YL+7NMVLd4Il6cSp3xQY7Gp9pUm6mojJCOZJ
         SL7Q0HG5BoGcabhcpGfJ4yKNfsOzen2p3nAC4AawMaQa2RPldiKUvwx/IW29i6FNis+C
         9wDeEFV8Rtx3nwdm2AsuCMi7QidPw2xsrIn5dw4TLT9PEiXXoq6E6olOt+GeiizBpv0W
         xzOm3634abeNAQb5LnaZxMK+kxV46IbKIEvQHA1wO9EUisZck5ewJ5LkG4qM6nX8Js+a
         7VwJpnse+TYRYQ97//5BDdFDiWNXXy+6wTAiSmLKcycHcL2dBYf3ojhNsAzvV0VTaBGY
         kAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLbo5g9uLgPvSVRf/+x9JU41DKk9JcOB/vtan5wpg84=;
        b=NJNmNJuUGEfRqhPErnz0GmU0dQGUa3RjUWoM3Z7CURFF2a3mod+rSFx5nPuCRdaVjz
         63CI9+95gBay2uiNrzuOQwxYVN6Y1Yl2ofB3kJAhAV5bUX/cnrPO2X+Jduah+eYJxYcM
         ce47wY+hsQ/RId2LUmexPkI1gaB4fbdp6s/myT+ZZDnEFxw/Hw7MbunpmeiHDA9ZFxW/
         e1gEPMHABYg/SvCaGRpYLSaLoezhQKY3xmFG/RAT2mgBXx9mqVM94N53bHz0pJO9PGjr
         ujLhKdi/byQT3TjMO2znaAnva23wDx9wTgWOGhGgntRQRaHYmglao6gFnQ/ScT1kmGJq
         LcTQ==
X-Gm-Message-State: ANoB5pmShXaGV7CiSDSCaUtshoCSQp01gD/mMdiswsT3+mZes81SLuFu
        hJu1gzUJHlf9mbTt4UjtED0XmtwigKIKjnDQousHKw==
X-Google-Smtp-Source: AA0mqf5U+0K300y6nWXjV860H9hr2P8whmEMsrVFzQJrj0wER13OWqFSU5d728vGQHn7MK5Qzuwd+0S7H+cirytWenU=
X-Received: by 2002:adf:dc86:0:b0:22a:88fa:4b77 with SMTP id
 r6-20020adfdc86000000b0022a88fa4b77mr8595184wrj.182.1668466227750; Mon, 14
 Nov 2022 14:50:27 -0800 (PST)
MIME-Version: 1.0
References: <CAMn1gO7tian6JZFwS1MxN5PNAYO229Uubc1te_A+qcjiR7myRA@mail.gmail.com>
 <20221114224315.GA939630@bhelgaas>
In-Reply-To: <20221114224315.GA939630@bhelgaas>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 14 Nov 2022 14:50:16 -0800
Message-ID: <CAMn1gO4_5TiVB2Z=qi8LrBoQOnnxr1sFiwx8f5qPURtH-CjC2Q@mail.gmail.com>
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

On Mon, Nov 14, 2022 at 2:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Nov 07, 2022 at 01:00:59PM -0800, Peter Collingbourne wrote:
> > On Mon, Nov 7, 2022 at 12:54 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Thu, Nov 03, 2022 at 06:34:31PM -0700, Peter Collingbourne wrote:
> > > > On Thu, Nov 3, 2022 at 6:27 PM Joe Perches <joe@perches.com> wrote:
> > > > > On Thu, 2022-11-03 at 18:07 -0700, Peter Collingbourne wrote:
> > > > > > On Wed, Oct 19, 2022 at 03:28:43PM -0500, Bjorn Helgaas wrote:
> > > > > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > > > >
> > > > > > > The lkml.org, marc.info, spinics.net, etc archives are not quite as useful
> > > > > > > as lore.kernel.org because they use different styles, add advertising, and
> > > > > > > may disappear in the future.  The lore archives are more consistent and
> > > > > > > more likely to stick around, so prefer https://lore.kernel.org URLs when
> > > > > > > they exist.
> > > > > >
> > > > > > If the commit message contains a line like:
> > > > > >
> > > > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > > >
> > > > > > this patch causes checkpatch.pl to complain. Would it be possible to
> > > > > > restrict this to URLs?
> > > > >
> > > > > Yes, I believe this would probably work well enough:
> > > > > ---
> > > > >  scripts/checkpatch.pl | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > > index 7be93c3df2bcb..fe25642d8bacc 100755
> > > > > --- a/scripts/checkpatch.pl
> > > > > +++ b/scripts/checkpatch.pl
> > > > > @@ -3336,7 +3336,8 @@ sub process {
> > > > >                 }
> > > > >
> > > > >  # Check for mailing list archives other than lore.kernel.org
> > > > > -               if ($rawline =~ m{\b$obsolete_archives}) {
> > > > > +               if ($rawline =~ m{\b$obsolete_archives} &&
> > > > > +                   $rawline !~ /^\s*cc:/i) {
> > > >
> > > > Can we make this (to|cc): instead? Otherwise developers (like me) who
> > > > use custom scripts to add To: headers to their patches before passing
> > > > them to checkpatch.pl will also hit this warning if their patch is
> > > > being sent To: one of these mailing lists.
> > >
> > > Why not make it look for "http" instead of the absence of "cc"?
> >
> > "https" as well, but yes, that would make more sense to me, and would
> > be less likely to require user workarounds.
>
> Maybe like this?  (On top of my previous attempt, which is in -next)
>
>
> commit d15f85247948 ("checkpatch: warn only for URLs to non-lore archives")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Mon Nov 14 16:33:12 2022 -0600
>
>     checkpatch: warn only for URLs to non-lore archives
>
>     Previously we warned for anything that contained the archive hostname, but
>     some email addresses also contain those hostnames, and we'd rather not warn
>     about those.  Only warn if we see "http" before the archive hostname.
>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Peter Collingbourne <pcc@google.com>

Peter
