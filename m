Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C2766A135
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjAMRxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjAMRxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:53:08 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB97990E52;
        Fri, 13 Jan 2023 09:46:06 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id s26so2976069ioa.11;
        Fri, 13 Jan 2023 09:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmsvTUFmio4v0mKtkUrFpQ4vzBAcb82FEeJSIjEF71s=;
        b=U/s0xMnR81/kt+dOyKNE3+SF/Xg1rMtiYJe3a91yue5+dpPLj46+WZnGexQ2L+06pj
         l5kV3n62LNq27Brr73MhxdMLHiMgk8IVO34gr56h51iQrTHUFN0ocGcr6fPve2UuttRw
         AGRvDVH6gNe9DwxOuxpkrKoalD1JgVVIuI6EJM8stTVbU25ceitY0SObOH5DUT4y91Fl
         5lOkHw2rMyINmPAzbzAUUWxcmtjZhSzZYQJb2W5a3BfEhe2wkcNGLcqNDQagE+35gBW5
         9nmGN3oh2U+WP71tceOKQoQiCfMQsRfaj85VRPDuZXKoXUBKnoWCkh5ACuIXMj96SXlF
         oPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmsvTUFmio4v0mKtkUrFpQ4vzBAcb82FEeJSIjEF71s=;
        b=iFnEHqB1ZjudjK6aqlJQ/Oky3RGCM+u1ki1xe5W+6+wdb5+1r7d/259sCfjOW4B2Kv
         555ATe5/qHswjfq3lEBym7AvSB/P0MsuWmfrxF+i2nVcmEWmBraN6houtRiSKOx5XsOZ
         DUbGCSHshn3VgY4Hr8jfZJMQTyFYZr1hV/8IsIZU85WFissjR7FMQ/yXSEnTJdxd63X9
         iqfFsJT0eH6qRffgw1NDGlJ8nyuYHcWRjMjxStRcfMGtikevJe+TTMDCN8QWxp0Kn4sa
         9YsRqxPjh/+kvle+tuftuVQPTziRcZfl6e9Vl8/JseMB2ERpRy0aSA1EEv0DPT4SxL7B
         T0mg==
X-Gm-Message-State: AFqh2koLscfKE7VvEC4Y6U9VhhmsyvMweAFDPFV2skccHahGZSv1EudQ
        NposQFVAjmTsV4jsAU1S6KlZEjGXY2j2KyNCoMBMiJwj
X-Google-Smtp-Source: AMrXdXsnqCB44MKYHXk5te+gf4YIXgwpKgqTOW3QNAIW7mAcGQ2b8EbOHH/IB8qOBZ5vCA+CdJyN3CRjrDc3nlPSdgw=
X-Received: by 2002:a05:6602:24d2:b0:6e0:19fa:2328 with SMTP id
 h18-20020a05660224d200b006e019fa2328mr7273105ioe.37.1673631966071; Fri, 13
 Jan 2023 09:46:06 -0800 (PST)
MIME-Version: 1.0
References: <20220415050003.3257645-1-mattst88@gmail.com> <20221019232952.2212729-1-mattst88@gmail.com>
 <CAEdQ38FO0SH80SLQKpLxadOBKn7cuRmZLd=xU8jJguq+MuD+Lw@mail.gmail.com> <CAEdQ38G8_bNzNnvYj2RHoOEufv4P3gKKGxHNgGWGG7_gBrR4dg@mail.gmail.com>
In-Reply-To: <CAEdQ38G8_bNzNnvYj2RHoOEufv4P3gKKGxHNgGWGG7_gBrR4dg@mail.gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Fri, 13 Jan 2023 12:45:54 -0500
Message-ID: <CAEdQ38E8du48Q1KNnRRokftRpMmjUb-anCKX_3Q9n77KfZF-6A@mail.gmail.com>
Subject: Re: [PATCH v2] tools: port perf ui from GTK 2 to GTK 3
To:     linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jelle van der Waa <jvanderwaa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 2, 2022 at 4:11 PM Matt Turner <mattst88@gmail.com> wrote:
>
> On Mon, Oct 31, 2022 at 10:02 AM Matt Turner <mattst88@gmail.com> wrote:
> >
> > On Wed, Oct 19, 2022 at 7:30 PM Matt Turner <mattst88@gmail.com> wrote:
> > >
> > > From: Jelle van der Waa <jvanderwaa@redhat.com>
> > >
> > > GTK 2 is a legacy API and the newer version is GTK 3 which changes a =
few
> > > API functions. gtk_tree_view_set_rules_hint is no longer required sin=
ce
> > > theme's are now responsible to handle this, gtk_vbox_new is deprecate=
d
> > > and replaced by passing the orientation to gtk_box_new. Apart from th=
ese
> > > changes the accessing of the screen changed in GTK which requires usi=
ng
> > > new functions for getting geometry. Lastly the GTK_STOCK_OK define is
> > > deprecated in GTK 3.
> > >
> > > Signed-off-by: Jelle van der Waa <jvanderwaa@redhat.com>
> > > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > > ---
> > > Originally sent in 2019. I've rebased it and given it a test.
> > >
> > > One problem I've noticed is that C++ symbol names are often broken.
> > > E.g.:
> > >
> > > (perf:3254940): Gtk-WARNING **: 21:47:46.663: Failed to set text from
> > > markup due to error parsing markup: Error on line 1 char 95:
> > > =E2=80=9Cstd::char_traits<char=E2=80=9D is not a valid name: =E2=80=
=9C<=E2=80=9D
> > >
> > > Presumably we need to call g_markup_escape_text() somewhere, but I
> > > struggled to find the right place.
> > >
> > > Without the patch, the GTK-2 version repeatedly segfaults, so this is=
 an
> > > improvement regardless.
> > >
> > > v2: Dropped changes to test-all.c. I don't know how to build that
> > >     apparently.
> >
> >
> > Arnaldo, does this work better for you?
>
> Ping=C2=B2

Ping=C2=B3
