Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A96966A1F5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjAMS0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjAMSZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:25:58 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAE07C3A3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:20:32 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bs20so21843662wrb.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLi7SrRxd72+otZbUTjbUg7uuf8MJx+ZI492kphQBwo=;
        b=hY4kziJpfHy1vtOctv3NChToCMqUGXUqXbqg1OM2zJbgjkU9emQdpTP62JDCauia/A
         IuROxsHnRYFxtrk/PXbFmpm2T07FPetMaZW5YaGPsbyKRgFukO+s3rRLwu2aVd8p/YS2
         9yr32r0a9yZ5hucuHXnVw1XZlmG0TyiXPqBxfySuwn+w1Lgl+RCv7ZSfMe7HPBUDJnZq
         rEKYrYwsm2P2/UqzOVVZ+prImY/JGu6JPSUAe/GKYZ5Br8mVsVWzfmLu8h/gBuNncurr
         3MD5MIAMpTcg5+okW42KStYQYep4Siu3jB/OpDLDRP79cGMvxe5mgzbhKZjkpnyioQkM
         QNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLi7SrRxd72+otZbUTjbUg7uuf8MJx+ZI492kphQBwo=;
        b=efmBSPkHDwAa/wO27DRFAhSDNVDcXSg+6Uh4x9wD6Plprwgr8cAWr7yKWpxv0Ey+NM
         3AjIOSJ452jvZAQeGEeSlX45o+JfA5sCFPwwnrRteIG9PWAdYSvMRcuOwmNSJPIty+/M
         FkS0zTXjgCnHI8M7wtHWE0qatNon0HP0VLUaN4Az2eWLCTHsO9jfIOvbFdE5IorttDMX
         GrP4n9OmeC2+6ZAMS6/nu38QHz/qoEI737O0Juq4FlqMuqqjkYeb8ZqPJmukkU1NiU6Y
         KdqMFYIdnPtG2M45/pSmd3fqRhsvyuA2L0P9dWVNrh2V+uCIg/aV2oZlC3pKothitQgk
         Og2A==
X-Gm-Message-State: AFqh2krlzE6ibdWPz6TfAgWAmsKWjVl5+OF5fc4vNtqLQWD9DBeFbZQJ
        T8QPoPfp0UbwF0I9sklm9McqmP9FQcdiyGCyo8kr56ZG3HUvAw==
X-Google-Smtp-Source: AMrXdXuB6Ye24PSri8zKYQTd8I1EKwfZuLuIuY6Jyso0L67lfb1byQDaj9SGm3eBUjzsmBPwBH1zxlwK5BD1v1kwh58=
X-Received: by 2002:a5d:6e0a:0:b0:242:5caa:5fbf with SMTP id
 h10-20020a5d6e0a000000b002425caa5fbfmr1594395wrz.300.1673634030510; Fri, 13
 Jan 2023 10:20:30 -0800 (PST)
MIME-Version: 1.0
References: <20220415050003.3257645-1-mattst88@gmail.com> <20221019232952.2212729-1-mattst88@gmail.com>
 <CAEdQ38FO0SH80SLQKpLxadOBKn7cuRmZLd=xU8jJguq+MuD+Lw@mail.gmail.com>
 <CAEdQ38G8_bNzNnvYj2RHoOEufv4P3gKKGxHNgGWGG7_gBrR4dg@mail.gmail.com> <CAEdQ38E8du48Q1KNnRRokftRpMmjUb-anCKX_3Q9n77KfZF-6A@mail.gmail.com>
In-Reply-To: <CAEdQ38E8du48Q1KNnRRokftRpMmjUb-anCKX_3Q9n77KfZF-6A@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 13 Jan 2023 10:20:18 -0800
Message-ID: <CAP-5=fWJ4mU67J+peDnvuUaz3ZoaSGx=wfJ1Vnux2ce3T0C8Wg@mail.gmail.com>
Subject: Re: [PATCH v2] tools: port perf ui from GTK 2 to GTK 3
To:     Matt Turner <mattst88@gmail.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Fri, Jan 13, 2023 at 9:53 AM Matt Turner <mattst88@gmail.com> wrote:
>
> On Fri, Dec 2, 2022 at 4:11 PM Matt Turner <mattst88@gmail.com> wrote:
> >
> > On Mon, Oct 31, 2022 at 10:02 AM Matt Turner <mattst88@gmail.com> wrote=
:
> > >
> > > On Wed, Oct 19, 2022 at 7:30 PM Matt Turner <mattst88@gmail.com> wrot=
e:
> > > >
> > > > From: Jelle van der Waa <jvanderwaa@redhat.com>
> > > >
> > > > GTK 2 is a legacy API and the newer version is GTK 3 which changes =
a few
> > > > API functions. gtk_tree_view_set_rules_hint is no longer required s=
ince
> > > > theme's are now responsible to handle this, gtk_vbox_new is depreca=
ted
> > > > and replaced by passing the orientation to gtk_box_new. Apart from =
these
> > > > changes the accessing of the screen changed in GTK which requires u=
sing
> > > > new functions for getting geometry. Lastly the GTK_STOCK_OK define =
is
> > > > deprecated in GTK 3.
> > > >
> > > > Signed-off-by: Jelle van der Waa <jvanderwaa@redhat.com>
> > > > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > > > ---
> > > > Originally sent in 2019. I've rebased it and given it a test.
> > > >
> > > > One problem I've noticed is that C++ symbol names are often broken.
> > > > E.g.:
> > > >
> > > > (perf:3254940): Gtk-WARNING **: 21:47:46.663: Failed to set text fr=
om
> > > > markup due to error parsing markup: Error on line 1 char 95:
> > > > =E2=80=9Cstd::char_traits<char=E2=80=9D is not a valid name: =E2=80=
=9C<=E2=80=9D
> > > >
> > > > Presumably we need to call g_markup_escape_text() somewhere, but I
> > > > struggled to find the right place.
> > > >
> > > > Without the patch, the GTK-2 version repeatedly segfaults, so this =
is an
> > > > improvement regardless.
> > > >
> > > > v2: Dropped changes to test-all.c. I don't know how to build that
> > > >     apparently.
> > >
> > >
> > > Arnaldo, does this work better for you?
> >
> > Ping=C2=B2
>
> Ping=C2=B3

Hi Matt,

did you see Namhyung's comment? It looks possible that we can drop the
infobar feature check for GTK3, which would help simplify the builds.
It seems to make sense to fold that into this change, or to have it as
a patch on top of this. Wdyt?

Thanks,
Ian
