Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE25C737CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjFUHhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjFUHhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:37:31 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8271119A1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:37:26 -0700 (PDT)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 89EE8413A7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687333044;
        bh=0BBJ0LDi0w4ZdUZcsI0xBEfRtekbhARUXPQztwGEa6I=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=IZmsK9ZRONjoiMJJCCihyKwxoC6jcuBEbdBXELCiQnpx3zPz6dQu7r3DDwScyCl3P
         6kM6ZOaRfc3NpUrpyGPU+HLRT9Jkdb71wNaq5/MVz1zGW/SpFf6seLccgLYZncGGgm
         39QnGbmjMd0GhdVO9D8Nlw36DVghcMmbTD/w30X2/OHeBBEkO7ucZmYcfehi8qUmtR
         QioN5iWVvCx0FaXjQWKtLpBbmepkfIZdBH7EZo/L/Swg4BGdeqbxPMvVUlwnTNhviH
         GhVqwDFS5Ve7AQbe/1VxnQmUXCvL9wXMM7PQvu2W2i1MBXxiYeiWNarbmi7t0NOIWi
         IupkbU690TlAg==
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-bffcd3cd439so275293276.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687333042; x=1689925042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BBJ0LDi0w4ZdUZcsI0xBEfRtekbhARUXPQztwGEa6I=;
        b=YnqnuoPPNJzHtFqWkBQdb4xe1pMp270sLSdNixZG3aSCoJhpnfDRPQcL7g2awfZGjl
         KBMnSOuKeZkxDQsPiSLGgXmx75Phat7O4Wg9C3dtXCiflkn4lO7bwZO/R6fVxTPuwc76
         aOdDDV/zNI+VjDcLpKfRNwhnAa8GEXTiEKTY27WbZ5NAt7J5PJEynzHF1/5x1rJFalqS
         cLDY1GEwpVyPIX2xEyUbAyXIyTs9vlur5oyPfbDgr5U3e5dq2qRgzGlNZMbHKoEx4Tt9
         2m1T4PaVz/HJ8XEolriQDcAHYs10udFmr54lIjQQbpehaFAGWbwpn/jq/iFuWVsNpuvA
         5T/Q==
X-Gm-Message-State: AC+VfDymMOyDTpNu5o92rGa0HKKNLGrjgwEa+WUibxOonBjLTwVzEhIX
        tvE0Ury9p7bKJWBRxtUqD4DZ2S3km0jQ4U4D2DSYuMWlNgFzV1gmMClyB2dKpxl1Z5lxyluU04M
        152UnPYZqvlTzUTV+vC5w2j9wo1wIahgmPbd+xDyYOe+6js23TlBJfuHVyQ==
X-Received: by 2002:a25:ac10:0:b0:bcd:783f:2e1b with SMTP id w16-20020a25ac10000000b00bcd783f2e1bmr10541319ybi.42.1687333042487;
        Wed, 21 Jun 2023 00:37:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7tHDZFYaXDSVRucwgmdoRG2vE6TNCRinWiLzj7V6nqen5yfIorS73/gMsFYgOCmS4sSxlKMPYPmux+4ZsBA/Q=
X-Received: by 2002:a25:ac10:0:b0:bcd:783f:2e1b with SMTP id
 w16-20020a25ac10000000b00bcd783f2e1bmr10541309ybi.42.1687333042247; Wed, 21
 Jun 2023 00:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230503064344.45825-1-aleksandr.mikhalitsyn@canonical.com>
 <CAHC9VhTx+6f8riuGOG40HZoaYx3F8Kf3Hm7Eb5k3-An91eMWgg@mail.gmail.com>
 <CAEivzxcVQoA9rN06BtHJzyHCaN60RG1-cyGEEw-P+dp-tCB=QA@mail.gmail.com>
 <CAHC9VhQnOszTFaFVBZACQCDxsuD6JrxDffmmJ-wBudK2MJ2pUA@mail.gmail.com>
 <CAHC9VhSF+j=qFH4M9bt-Q8HUOwk7qLOEkCSve8onUMgADJ7+3A@mail.gmail.com> <CAHC9VhSGhV6SoOeV2h4ehrkUCK9Sds1wx=CGdRSouvnLn0Z3Kg@mail.gmail.com>
In-Reply-To: <CAHC9VhSGhV6SoOeV2h4ehrkUCK9Sds1wx=CGdRSouvnLn0Z3Kg@mail.gmail.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Wed, 21 Jun 2023 09:37:11 +0200
Message-ID: <CAEivzxcbqQj+_Ouo1_csbzc2NHewpQW7zb3mo1Dkr07obK6zKw@mail.gmail.com>
Subject: Re: [PATCH v2] LSM: SafeSetID: fix UID printed instead of GID
To:     Paul Moore <paul@paul-moore.com>
Cc:     mortonm@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 2:30=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jun 8, 2023 at 2:34=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Jun 6, 2023 at 5:13=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Tue, Jun 6, 2023 at 2:50=E2=80=AFPM Aleksandr Mikhalitsyn
> > > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > > > On Thu, May 18, 2023 at 8:59=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > > > On Wed, May 3, 2023 at 2:44=E2=80=AFAM Alexander Mikhalitsyn
> > > > > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > > > > >
> > > > > > pr_warn message clearly says that GID should be printed,
> > > > > > but we have UID there. Let's fix that.
> > > > > >
> > > > > > Found accidentaly during the work on isolated user namespaces.
> > > > > >
> > > > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@can=
onical.com>
> > > > > > ---
> > > > > > v2: __kuid_val -> __kgid_val
> > > > > > ---
> > > > > >  security/safesetid/lsm.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > I'm assuming you're going to pick this up Micah?
> > > > >
> > > > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> > > >
> > > > Dear Paul!
> > > >
> > > > Thanks for your review!
> > > >
> > > > Gentle ping to Micah Morton :-)
> > >
> > > Micah?
> > >
> > > The right thing would be for Micah to merge this via the SafeSetID
> > > tree, however, considering that it's been over a month with no
> > > response, and this patch looks trivially correct, I can pick this up
> > > via the LSM tree if we don't see anything from Micah this week.
> >
> > Searching through all of the archives on lore I don't see any email
> > from Micah past August of 2022.  I'll still stick to the plan of
> > merging this via the LSM tree next week if we don't see any response
> > from Micah, but beyond this patch we may need to consider the
> > possibility that Micah has moved on from SafeSetID.
> >
> >  * https://lore.kernel.org/all/?q=3Df%3Amortonm%40chromium.org

Hi Paul,

>
> This fell through the cracks in my inbox last week, but I just went
> ahead and merged this into lsm/next.

Thanks!

Kind regards,
Alex

>
> After the upcoming merge window closes we'll have to revisit
> SafeSetID's status as "supported", we might need to demote it to
> "maintained" or "odd fixes".
>
> --
> paul-moore.com
