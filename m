Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93E573B732
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjFWM2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjFWM2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:28:20 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD78F1B3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:28:17 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b693afe799so843795ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1687523297; x=1690115297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Lfzft8Qlu9KuiXFqRAce+TPCCogRgWHC0Sv/4lTqOY=;
        b=TockwmMMk1TJFUKWDZ0ebGVXA6Fn6umo2YU8mCYTUMHZ8hwBNeTWEu7iRfcahvxn1I
         am/xw2I6Ra/NCoXDuwwoQoixp/03SNAW/PomXuOkLGw+ViLMIXf+fgPOySEV5O//P8h+
         tvu0lwBHPGqiEo7zY8BhfeiapCzGJ9gfX/vB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687523297; x=1690115297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Lfzft8Qlu9KuiXFqRAce+TPCCogRgWHC0Sv/4lTqOY=;
        b=UvLwBOtwqPCDcP5SGUf/1eywFByz9sHAgU375Dv+nfMdm7HQA9r6mhq8afYdBcrYHI
         FqBm8MIZ4Ljxve1Dcd/bKLHxIT0pQdylqNw0g8TUA1yOHeg63ctE7rjSH6v6Aj4q0dcB
         CxaT/OdCYuJak9O7Rnjwylc1pz0DAQEe55yxSD+sqzN9qgwNdvqwaK551rUcmkLWZKaj
         SqznqomhOZKwbuNupUp/kbGr8jG5x1goXdjYswgyHkKGjYc1zl5HFV2EFXxTVIBcNuUs
         0dfHsTiQJTtEz+rTaXhR3E78mCFz+lXPVPgtTTMzcKWSD5HzqQlOeX9tf33v2zR4bdaq
         Fp6w==
X-Gm-Message-State: AC+VfDyKsPmkFOSAeV1N8areRijWIp7yFOOve1Van8skdeyOi5V+fOuq
        7IFKD0n/x41xNYaDz+G3oAUK585myFZnFThcaHGMyA==
X-Google-Smtp-Source: ACHHUZ5uOG+xfDX2YyPZwahBbssKpKKf6sqmcfXqpXw72yNtcTh4on0X6sdMU0mldu9yTNriGhqtLsGe2b0BNsYZly0=
X-Received: by 2002:a17:902:ea01:b0:1a9:6467:aa8d with SMTP id
 s1-20020a170902ea0100b001a96467aa8dmr25938120plg.1.1687523297091; Fri, 23 Jun
 2023 05:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <PH0PR11MB51262F07CD4739BDCB920483D322A@PH0PR11MB5126.namprd11.prod.outlook.com>
 <CAJqdLrpFcga4n7wxBhsFqPQiN8PKFVr6U10fKcJ9W7AcZn+o6Q@mail.gmail.com>
 <CAJqdLrrVfQx4fWJjpf0Nz7AdiNshdFi7xgXis_iO1jgU0YeGXw@mail.gmail.com> <20230623-baldigen-eisstadion-38bd00a856fb@brauner>
In-Reply-To: <20230623-baldigen-eisstadion-38bd00a856fb@brauner>
From:   Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date:   Fri, 23 Jun 2023 14:28:06 +0200
Message-ID: <CAJqdLrocJkzTFUeESTHwOAHpGcK7Tqx54XsdT-0g8Fm2=_xcnA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 2:24=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, Jun 23, 2023 at 11:23:57AM +0200, Alexander Mikhalitsyn wrote:
> > On Fri, Jun 23, 2023 at 10:34=E2=80=AFAM Alexander Mikhalitsyn
> > <alexander@mihalicyn.com> wrote:
> > >
> > > On Fri, Jun 23, 2023 at 12:28=E2=80=AFAM Von Dentz, Luiz
> > > <luiz.von.dentz@intel.com> wrote:
> > > >
> > > > Hi Stephen, Alexander,
> > >
> > > Dear friends,
> > >
> > > >
> > > > Looks like we have a similar problem as to:
> > > >
> > > > https://lore.kernel.org/lkml/20230524081933.44dc8bea@kernel.org/
> > > >
> > > > That said for unix socket it was decided to not allow it to be buil=
d as module, which is something I don't think we are willing to do for blue=
tooth, so we have to find a way to get around pidfd_prepare, which seems to=
 be called due to the use of scm_recv (it is also used by netlink btw).
> > >
> > > Ugh, yep. That's bad and we can't workaround it like we did for unix =
sockets.
> > >
> > > Originally, Christian had objections against exporting the
> > > pidfd_prepare function [1]
> > >
> > > [1] https://lore.kernel.org/all/20230523-flechten-ortsschild-e5724ecc=
4ed0@brauner/
> > >
> > > +cc Christian
> >
> > Idea. (-: We can introduce a new function like "scm_recv_light" that
>
> Seems fine to me.

Thanks, Christian!

Let's wait for Jakub's comment then :) Then I'll prepare and send a patch.

Kind regards,
Alex
