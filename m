Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0A46774CE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 06:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjAWFX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 00:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjAWFXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 00:23:16 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDEC9778
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 21:23:14 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 123so13425960ybv.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 21:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yVahiR5GbRFLglpgMess3734NR8CpcGx3B7LKqSwSfA=;
        b=uO5Q3qWL3y/oXtLPDeC861cJDPT7U9TMKWxMvkCabRSYopUdAUJu/pIyCbde2i1Cyu
         oDxp5En/4fssbpbcxm9T/RZB/9kFwaHdZwgzo0qz2wZecEsYPsYCY3gezK9UM7d1q2Up
         I2C9FKvy/ntPbvwXwE8+bVnJXjMrMSR9zBibV9MXN8PKAyJUwNBigEKC3oktj2CAt9UM
         Yuo77i0P8iYPOBWIcJWMRKJi68KfNDPyHGlBEzhwZozwrabzhhuJmluwwB0hu9ZDEfKy
         zGbJXZSka7BwDXV1slEpU3VSfyknkOFgBrxV56+npq15eqNSbEaArniW3GeIFP48YgT/
         +AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVahiR5GbRFLglpgMess3734NR8CpcGx3B7LKqSwSfA=;
        b=Vb54uXCKqsykgVwY7tJWpq3FKRhhvKLIRXzTWdWlUw9TCGmGGN9KCuz+imfghMgVY2
         oJrGoxA9A2hG6fdu0yWJbnyE2Ob4FyH66mhMPWd4dQ71RXSHUsguPMHXaoO4imCUz86u
         SImzhiPoaAMULLCxK4x5Dp9WdIlnw/UT2yvuUdItXxzuImJNkeGmMY6wrFVvZJJOSCc5
         8vBBBDL+6H5Iq5QUTzTSXIXrr0CXgFOWNW0gm9lV4BY2bAh+797cnLRTDschcug87BpL
         AMk19p4Ah76OUioo/D6YLxXYn70Sm62LSxPBiTmj5RItfqrQoTBVwvMNZfx7WOQdPkHV
         0QJA==
X-Gm-Message-State: AFqh2kou3U0PiAENq+E4E7KtCf75xFTc3BCgXmSQrpwqVjhwVex08pqv
        J220yO3i28RJ8mOXbI7mt6x1wB/5tP6cpRmWxLMoNxWC6nxZkg==
X-Google-Smtp-Source: AMrXdXs1wih338sXdTWU4DDmWoH0T59zITSrUXi1mDfRaiD7PCLB3SkSCY4KEZiSqoToNdkR9HrJTJ9Wb0YRrNoUyTY=
X-Received: by 2002:a5b:305:0:b0:709:9335:236e with SMTP id
 j5-20020a5b0305000000b007099335236emr2153469ybp.288.1674451393914; Sun, 22
 Jan 2023 21:23:13 -0800 (PST)
MIME-Version: 1.0
References: <20220905104542.2368950-1-dmitry.baryshkov@linaro.org> <d5ab81794ef1c666e947ed1f23570c175bf7d9d4.camel@perches.com>
In-Reply-To: <d5ab81794ef1c666e947ed1f23570c175bf7d9d4.camel@perches.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 23 Jan 2023 07:23:03 +0200
Message-ID: <CAA8EJpoiZWorTg=-TtvieFXGqaNFhRJkmkMd=6T2SxCyuGvH8w@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: move duplicate sign off to separate warning type
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sept 2022 at 16:59, Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2022-09-05 at 13:45 +0300, Dmitry Baryshkov wrote:
> > Some maintainers prefer to allow duplicate signatures if that provides
> > additional details about the patch flow. E.g. if the original patch
> > author pulls the patch from the patchwork into the kernel branch, this
> > can result in duplicate SOB tags from him, however this reflects the
> > patch flow (one SOB for being the author, one SOB for pulling the patch,
> > adding (and maybe fixing) tags and pushing the patch further.
>
> I think that's poor process, but whatever...

Gracious ping. We'd like to ask to get this in or to understand how to
properly handle/modify our process.
Thank you.

>
> >
> > To facilitate easily handling this kind of warnings, separate duplicate
> > SOBs into the separate warning class ('DUPLICATE_SIGN_OFF').
> >
> > Cc: Rob Clark <robdclark@gmail.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  scripts/checkpatch.pl | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 79e759aac543..f95d4ac19901 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -3115,7 +3115,7 @@ sub process {
> >                       $sig_nospace =~ s/\s//g;
> >                       $sig_nospace = lc($sig_nospace);
> >                       if (defined $signatures{$sig_nospace}) {
> > -                             WARN("BAD_SIGN_OFF",
> > +                             WARN("DUPLICATE_SIGN_OFF",
> >                                    "Duplicate signature\n" . $herecurr);
> >                       } else {
> >                               $signatures{$sig_nospace} = 1;
>


-- 
With best wishes
Dmitry
