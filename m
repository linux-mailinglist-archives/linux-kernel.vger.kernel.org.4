Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C99747842
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 20:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjGDSYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 14:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjGDSYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:24:44 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE9B10D7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 11:24:41 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6a0d91e80so96307811fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 11:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688495079; x=1691087079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIoWXiCDvyrdD0PlGIH9uBYUwk4NwoKlrz1+aonWS9I=;
        b=M4RIp3ELKW+0IZehEFRd5Ovtpu/99+dRrm8oNnzMCSRbRsSI9gPUGLI7BaNMspxMzs
         +h0qLFR9xDoHW+eOHnA9CZdit4HtUmkbkj6lNCPFMp3owv9lBLxhIr7Y71Cj2WyDyylY
         Xid3AjzKGJAk2YWejyYlXUwOm/JuIpKmaWnYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688495079; x=1691087079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIoWXiCDvyrdD0PlGIH9uBYUwk4NwoKlrz1+aonWS9I=;
        b=Q2j5vNffitcTlzkG8E8+GhNtoT10iHmyLqu4Y0r4MGz8Xn0q0PaNLniXe3ZdftO8bZ
         vyzwgyQP+pdWuWdJ9OAUSoiexpgNu4t4SlKKQgra1ZLTFCh2qEvAuzf48GcYCFt3IBus
         P+5PBzyNOlutHXrUcSqSN/L+oEAfKLk6buXtMsQPRc4nVbkxwcSFQgE64OS2rrTgfJcA
         S1W8T9Qh2Rxrhxo55vd/sfCK4HN4E/G93hC8kZUNLlQAspojqyWRhob2Q5sfTmDv4SHk
         eF149CNCtXi+5YtAcarFqBlFCSJE/GTCmw6MfF9nYJqy6xBEtsv0OPx7rvSI/HoKm7SV
         YB5w==
X-Gm-Message-State: ABy/qLanHJkkZZhCZZrx3Y7iuipG2ct+PflgrQ0rYy/0AhpJjn9Rn79C
        XUHkitIOBVIysEcD1BUtsa6GULwxjMDEMhagicYCaA==
X-Google-Smtp-Source: APBJJlEBEP9q2e5axD8moG+WHwoVD/qiBNosgrIAyujf4hPffDilLHJdG/46ad6TiK76WI5cxrcKfK0n/4N7wlZzoOg=
X-Received: by 2002:a2e:9258:0:b0:2b6:c3b8:3a9f with SMTP id
 v24-20020a2e9258000000b002b6c3b83a9fmr10538422ljg.29.1688495079486; Tue, 04
 Jul 2023 11:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230503064344.45825-1-aleksandr.mikhalitsyn@canonical.com>
 <CAHC9VhTx+6f8riuGOG40HZoaYx3F8Kf3Hm7Eb5k3-An91eMWgg@mail.gmail.com>
 <CAEivzxcVQoA9rN06BtHJzyHCaN60RG1-cyGEEw-P+dp-tCB=QA@mail.gmail.com>
 <CAHC9VhQnOszTFaFVBZACQCDxsuD6JrxDffmmJ-wBudK2MJ2pUA@mail.gmail.com>
 <CAHC9VhSF+j=qFH4M9bt-Q8HUOwk7qLOEkCSve8onUMgADJ7+3A@mail.gmail.com>
 <CAHC9VhSGhV6SoOeV2h4ehrkUCK9Sds1wx=CGdRSouvnLn0Z3Kg@mail.gmail.com> <CAEivzxcbqQj+_Ouo1_csbzc2NHewpQW7zb3mo1Dkr07obK6zKw@mail.gmail.com>
In-Reply-To: <CAEivzxcbqQj+_Ouo1_csbzc2NHewpQW7zb3mo1Dkr07obK6zKw@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 4 Jul 2023 11:24:27 -0700
Message-ID: <CAJ-EccM+4z840NRhGG8eJTAZm4RspD=hhO=QKKXSZA2TXQPm3A@mail.gmail.com>
Subject: Re: [PATCH v2] LSM: SafeSetID: fix UID printed instead of GID
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 12:37=E2=80=AFAM Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> On Wed, Jun 21, 2023 at 2:30=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Thu, Jun 8, 2023 at 2:34=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Tue, Jun 6, 2023 at 5:13=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > On Tue, Jun 6, 2023 at 2:50=E2=80=AFPM Aleksandr Mikhalitsyn
> > > > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > > > > On Thu, May 18, 2023 at 8:59=E2=80=AFPM Paul Moore <paul@paul-moo=
re.com> wrote:
> > > > > > On Wed, May 3, 2023 at 2:44=E2=80=AFAM Alexander Mikhalitsyn
> > > > > > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > > > > > >
> > > > > > > pr_warn message clearly says that GID should be printed,
> > > > > > > but we have UID there. Let's fix that.
> > > > > > >
> > > > > > > Found accidentaly during the work on isolated user namespaces=
.
> > > > > > >
> > > > > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@c=
anonical.com>
> > > > > > > ---
> > > > > > > v2: __kuid_val -> __kgid_val
> > > > > > > ---
> > > > > > >  security/safesetid/lsm.c | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > I'm assuming you're going to pick this up Micah?
> > > > > >
> > > > > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> > > > >
> > > > > Dear Paul!
> > > > >
> > > > > Thanks for your review!
> > > > >
> > > > > Gentle ping to Micah Morton :-)
> > > >
> > > > Micah?
> > > >
> > > > The right thing would be for Micah to merge this via the SafeSetID
> > > > tree, however, considering that it's been over a month with no
> > > > response, and this patch looks trivially correct, I can pick this u=
p
> > > > via the LSM tree if we don't see anything from Micah this week.
> > >
> > > Searching through all of the archives on lore I don't see any email
> > > from Micah past August of 2022.  I'll still stick to the plan of
> > > merging this via the LSM tree next week if we don't see any response
> > > from Micah, but beyond this patch we may need to consider the
> > > possibility that Micah has moved on from SafeSetID.

Sorry guys, this is my first time checking my @chromium.org email in a
couple months. I have indeed moved on from being regularly plugged in
to the goings on of the linux-security-module mailing list. @Paul
Moore whatever you think is the best way forward here is good for me,
I can't really make any promises that I'll be checking this mailing
list on a regular basis.

> > >
> > >  * https://lore.kernel.org/all/?q=3Df%3Amortonm%40chromium.org
>
> Hi Paul,
>
> >
> > This fell through the cracks in my inbox last week, but I just went
> > ahead and merged this into lsm/next.
>
> Thanks!
>
> Kind regards,
> Alex
>
> >
> > After the upcoming merge window closes we'll have to revisit
> > SafeSetID's status as "supported", we might need to demote it to
> > "maintained" or "odd fixes".
> >
> > --
> > paul-moore.com
