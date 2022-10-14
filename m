Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9675FE7EF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 06:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJNESl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 00:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJNESi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 00:18:38 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE6F18540F;
        Thu, 13 Oct 2022 21:18:36 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id a2so3735594vsc.13;
        Thu, 13 Oct 2022 21:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a2TDlZ5xXQ65iqd5QWMtMPYq2MPwQ3qfXtGkGk9qg+8=;
        b=ZiyS5aMQZjQH/Evp2092kpbFea0MIVMSy7YVXIhJHRtLrvv09wfefJ//9ztDxwq1+u
         at4g7SW3NYq1gx73DR/LQPoPwMTrYNC1KX9u0J0eKq7lw+VuqJrGRPBv8UJ02ejqpCUD
         fiTkwORFjLAGHCMBJ9p0/HSN/n1Ygo4K+p+2FvNtphfjHsi5RfS9PbEpcL76/0EwClaI
         o6waarUVDn+9/g7WSHfk96Z6WdZZbvJ4UP8dDxTjsn1af/ez8UHAqyUopvX4mQXNrAaw
         cYw77Jz+oaarBUpr7SXccxVpfM+sB/WVkt5HomT1hpZQMzSafDL4SmgUzbzJxCKulSis
         zyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2TDlZ5xXQ65iqd5QWMtMPYq2MPwQ3qfXtGkGk9qg+8=;
        b=v8cg4mYmtEA0aZam00DLgitX5pGyFWH9qw3MJ2w65xh8xnpAyTtNBQoLz6VCcZL+/C
         nLidx2mGcqh7SJyc8Dlc8ZpEXWe6e7x8j4MEx94V/4hd5m5EvlKkDCaQ/AskGWuFj7Pf
         QYi+cabJoq1aWA8TWR5hWwq8npcLvz8RWLVF9FiYmheJwbtoXsNb3CCykqNStAgFsDEv
         bixvYUhEnDkI4LKaRQPdGs1tsWRyCJHQi6EC1QO60SzVQa/nYxnrx84Z7E3T4XKYlEaA
         VSB2C8RvRYI06jwKw1gMoowf1h/2cXj8EUPIUOJ/E8VGAuS+aEHvidVLuzon+9mESO5I
         9HtQ==
X-Gm-Message-State: ACrzQf1V4wLwpGbihJhBQlbLfoU1ZCjk5XkfhH9SblgJ6scdy8Tjit4u
        f78C4iG2KsQA8/nl7ZfeegD6lPS4tc6G0qDz/iM=
X-Google-Smtp-Source: AMsMyM7DP8oGfL+fYBNQVvp0StdQcMtDI0pja5zoOkRUtfuAkQgZE+FicwuyfG/M8YzFMemWv5C6CCv+wbQE/eG4xW4=
X-Received: by 2002:a67:fd18:0:b0:3a6:fc4f:13c9 with SMTP id
 f24-20020a67fd18000000b003a6fc4f13c9mr1923129vsr.84.1665721115686; Thu, 13
 Oct 2022 21:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAKFNMonU3aVqwRdxyFefBJMg0-XC9j8bE-qYZ-9xx-4--NdkGg@mail.gmail.com>
 <mhng-1ec448c6-70ad-4964-9dd0-032892bfb2ef@palmer-ri-x1c9a>
In-Reply-To: <mhng-1ec448c6-70ad-4964-9dd0-032892bfb2ef@palmer-ri-x1c9a>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 14 Oct 2022 13:18:18 +0900
Message-ID: <CAKFNMomKQg+NyA2zgYFNGjtZ6eGYj2buhmWxPP7RaczT5H6dKw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for konis
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 12:51 PM Palmer Dabbelt wrote:
>
> On Thu, 13 Oct 2022 16:06:43 PDT (-0700), konishi.ryusuke@gmail.com wrote:
> > On Fri, Oct 14, 2022 at 6:49 AM Palmer Dabbelt wrote:
> >>
> >> Github deprecated the git:// links about a year ago, so let's move to
> >> the https:// URLs instead.
> >>
> >> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> >> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> >> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> >> ---
> >> I've split these up by github username so folks can take them
> >> independently, as some of these repos have been renamed at github and
> >> thus need more than just a sed to fix them.
> >> ---
> >>  MAINTAINERS | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index d118acdce8b8..c9c396e2d8a0 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -14363,7 +14363,7 @@ L:      linux-nilfs@vger.kernel.org
> >>  S:     Supported
> >>  W:     https://nilfs.sourceforge.io/
> >>  W:     https://nilfs.osdn.jp/
> >> -T:     git git://github.com/konis/nilfs2.git
> >> +T:     git https://github.com/konis/nilfs2.git
> >>  F:     Documentation/filesystems/nilfs2.rst
> >>  F:     fs/nilfs2/
> >>  F:     include/trace/events/nilfs2.h
> >> --
> >> 2.38.0
> >>
> >
> > Ah, that's right, it needs to be fixed.
> >
> > I'll pick this up unless it's decided to apply similar fixes all at once.
> > Thank you.
>
> It's easier on my end if you just pick it up.  Just note the
> "git://github -> https://github.com" typo.  I can send a v2 if you want,
> but IMO it's trival enough to just fix up.
>
> Thanks!
>
> >
> > Ryusuke Konishi

Ah, thanks.   I will fix that typo (the omission of ''.com") myself.

Ryusuke Konishi
