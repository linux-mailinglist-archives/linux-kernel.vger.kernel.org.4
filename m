Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA308624AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiKJTcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiKJTcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:32:50 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADF245A2E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:32:49 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so5739694pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rjahP2k0wXST/gQjDRK80kG7+zcUCO7+og+DzEnN1Es=;
        b=P7H8M2kUCTQclj/0McLdFAh7N+WCDO6p6/d4mTyd2W1yw7wlDfPJ67g86haRVSTeFr
         s2RDxsA+XkUOCjaA++nVPVyzXmbfRTH4/wskmo+vagNq3O8XjiHkxK0MxjvyEGWHycLz
         2X0jH1jc+lFILikIFr9X+SZcT+rL3zWPd0cmkTD4bshyU5r4mT4IimH1CCw5zdf/eLhL
         eqW0rV7pc7PAMNV/aH7zHcfHsTJhHOjH83dJ7f0Dqz7FlmnHfN89D7GWkxxOXF8kF5vq
         c6gUNQSKQ7wyL8SPFKVELZ0TRxyuq2csiD8qFsz3ChWZmkBYRv3cSmIRmTyxHUGUNDAM
         BWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjahP2k0wXST/gQjDRK80kG7+zcUCO7+og+DzEnN1Es=;
        b=BpTSypgNnf0MIOXPKmGC2NvZT1bcNfNgJ+mX6A59QVfjUHaD6ajv4uWPO2uUl039+Y
         WIU0Se3z1nj1tUy4YfS8yTz9sCMzYtvs4cBM3ElhwMeJ5eqr4ET33ENnpLWFwbndez8W
         ULW/SsLrEbWkxLXRDWttdm0kOPMY6kVXcsx2K9l1MohhMmmQFcgPdQ+DIa2sb2EWnxqK
         MCm5OlkxehYKxntlfYvlurT87I/ZDvtiwx0WclA9XFciDyt9cN2gcoO5AzIoDquhZZO0
         udODu8l7Tnw/p3Ydb1NpSz+VZzQW/oWeFvFjEkoxKAej6pHsEjx5lyTBxHtlJkJwBU4u
         7vnw==
X-Gm-Message-State: ACrzQf36wZp9LGUqbPonGKfN5yjFjlxZgsvO0HL1UucaQ5RPb1Tkdx3d
        QW331Bl+VLYXWvaGpTfnJKDX4kmIEKHl352LRJZX2vOkda8=
X-Google-Smtp-Source: AMsMyM6ZGmBdiDRnzyKViuuKSJmjmSjkZL971srrgl2IDM30pYO+ZSfp4Dqcgz7ybkJnqmvA2K7XXwAKZUuopfFKj98=
X-Received: by 2002:a17:902:f786:b0:180:6f9e:23b with SMTP id
 q6-20020a170902f78600b001806f9e023bmr67048600pln.37.1668108768836; Thu, 10
 Nov 2022 11:32:48 -0800 (PST)
MIME-Version: 1.0
References: <20221109170341.36785-1-steffen.kothe@skothe.de>
 <CAGETcx9fx3TcgeD+pMyp+LuGfd=hOo5_Weeii2W1Mbd1T2Ua0Q@mail.gmail.com> <Y205W3kavB5tIDK3@p50>
In-Reply-To: <Y205W3kavB5tIDK3@p50>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 10 Nov 2022 11:32:12 -0800
Message-ID: <CAGETcx9Z2_Oc-L8Y0x+zuPUEgeaDSnFSFUSU+nxcF5Rxtf6FvQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: dev-needs.sh: Enforce bash usage
To:     Steffen Kothe <steffen.kothe@skothe.de>
Cc:     linux-kernel@vger.kernel.org
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

On Thu, Nov 10, 2022 at 9:48 AM Steffen Kothe <steffen.kothe@skothe.de> wrote:
>
> Am Wed, Nov 09, 2022 at 02:58:15PM -0800 schrieb Saravana Kannan:
> > On Wed, Nov 9, 2022 at 9:04 AM Steffen Kothe <steffen.kothe@skothe.de> wrote:
> > >
> > > Calling the script from a system which does not invoke bash
> > > by default causes a return with a syntax error like:
> > >
> > >         ./dev-needs.sh: 6: Syntax error: "(" unexpected
> > >
> > > /bin/sh invokes on most distributions a symbolic link to a
> > > default shell like dash (Debian) or bash (Ubuntu).
> > >
> > > Since the script depends on bash syntax, enforce the same by
> > > default to prevent syntax errors caused by wrong shell type usage.
> >
> > I wrote this so that it can run on an Android target that runs toybox.
> > Sadly toybox doesn't like have /bin/bash. This will break my use case.
> > So I'll have to Nak this.
>
> Ok, I see.
>
> > I'm open to other ideas though as I'd like to this to work in as many
> > cases as possible. Should we just add a wrapper that has /bin/bash and
> > then sources this file?
>
> I mean, we could leave at least a warning on top above the first
> function via a simple echo.
>
> Sth. like:
>
>         echo "Warning: $0 is only tested for following shell variants
>               [toybox, bash]. Other shells might be not following the
>               specific syntax of this script."
>
>         echo "Shell is: $(readlink /bin/sh)"
>
> I would prevent to add another wrapper to it, because its fairly easy
> to cp this file to a target. An embedded system with a pure POSIX compliant
> shell will never be compatible to this kind of syntax.
>
> What do you think about a more describing approach of the error instead
> of handling it with some weird logic and wrapping?

Are you suggesting we check for the shell being toybox/bash and then
printing this? Always printing it isn't nice because it'll mess up all
the script that expect the output to be just what it is today.

But if you want to add an error check, I'm okay with that.

-Saravana

>
> Cheers,
>         skothe
>
> > Also looks like multiple #! lines aren't supported by bash, so we
> > can't add multiple lines either.
> >
> > -Saravana
> >
> > >
> > > Signed-off-by: Steffen Kothe <steffen.kothe@skothe.de>
> > > ---
> > >  scripts/dev-needs.sh | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/dev-needs.sh b/scripts/dev-needs.sh
> > > index 454cc304fb448..46537859727bc 100755
> > > --- a/scripts/dev-needs.sh
> > > +++ b/scripts/dev-needs.sh
> > > @@ -1,4 +1,4 @@
> > > -#! /bin/sh
> > > +#! /bin/bash
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  # Copyright (c) 2020, Google LLC. All rights reserved.
> > >  # Author: Saravana Kannan <saravanak@google.com>
> > > --
> > > 2.30.2
> > >
> > >
>
> --
> Cheers,
>         Steffen
>
