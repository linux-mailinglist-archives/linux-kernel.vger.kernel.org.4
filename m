Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1549640FCD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 22:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbiLBVLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 16:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbiLBVLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 16:11:19 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52650B90F7;
        Fri,  2 Dec 2022 13:11:18 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id h15so2583293ilh.12;
        Fri, 02 Dec 2022 13:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3lEvhP44/S2CiLLHgl8RRsozuWPpw/JRf0SJlW9cyA=;
        b=iwpkj4UkgBtW022tAfrfSXwiLhxJwrx4LN6w2uzzbw6OyhP7xZZrXlBHLIum+AwxlI
         KYW3BBqzLiXCVHXGr8RG4C9s3fpd7squHduQHtM2i5skLyyVIYTmKsQEu53pt9iEtlVy
         OuNe/ceg/ulQA8xElq9h3/AuiMLzHvBfJ2B5jV5A6DtMdor9zjJJFDNExpfWPkD/udn4
         T0N/hK7zzPvscpTB+9QSuJiRCUT+SVPXWHq8UNiBglDA8zM5O1EkjcnMXstAsQFpMwxo
         SBff1c1LeYWRwbSEKdykbNQ0wJEuDWuhmmMg+x7DvUbfopuzIbtfMqcn9Smgoe41yHHW
         yj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3lEvhP44/S2CiLLHgl8RRsozuWPpw/JRf0SJlW9cyA=;
        b=8PR7MzkIGcLtqCAAfgVYInqpSvIkrS5h7jfJ394MjnMUp6NWpjU/2zsQn61cUbeimD
         BApGstFJY4FYBh2IAiT1Fg1CUgU41uXGqDdg46GuEqNgGf9oM3x5xksiHeVrUF8sbqQC
         Ea7Cr+SXglaYvrPt8VuuZfw7gTHtg4+o4QZEI++8UhuEFgRFHsT0aF8jgm3mTpvWMDPQ
         K7tvliTMQWM0bjGM0aLwELBXp/SptyMYXhydJ83gPpUB6hjfZ76lvMighRPuMpZ3UF9h
         ZhuWTkf9P4l5EsaQ8RqhzWZrSrESpRhVIZzG9wYPj6IzUiBwelBlLUw1GYPfIl1WDufu
         RiNg==
X-Gm-Message-State: ANoB5pnUlt4BdlwAr+j5LODaOOcbL/pQ7aEi26p2/GkVrqbynP5lupVF
        vAH8Jgt3A4uqir+6F87XMKyobVSNixT22hQqAmGvtoAI
X-Google-Smtp-Source: AA0mqf77afraC/slha5QtvDC1rfoPp+LISqCr7+o58UN5TMl/IlzcCq3CLhKEUYmMhYHqDLF8BO83t9gI67WNcbQExA=
X-Received: by 2002:a92:a30b:0:b0:302:555a:f761 with SMTP id
 a11-20020a92a30b000000b00302555af761mr23477136ili.323.1670015477439; Fri, 02
 Dec 2022 13:11:17 -0800 (PST)
MIME-Version: 1.0
References: <20220415050003.3257645-1-mattst88@gmail.com> <20221019232952.2212729-1-mattst88@gmail.com>
 <CAEdQ38FO0SH80SLQKpLxadOBKn7cuRmZLd=xU8jJguq+MuD+Lw@mail.gmail.com>
In-Reply-To: <CAEdQ38FO0SH80SLQKpLxadOBKn7cuRmZLd=xU8jJguq+MuD+Lw@mail.gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Fri, 2 Dec 2022 16:11:05 -0500
Message-ID: <CAEdQ38G8_bNzNnvYj2RHoOEufv4P3gKKGxHNgGWGG7_gBrR4dg@mail.gmail.com>
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

On Mon, Oct 31, 2022 at 10:02 AM Matt Turner <mattst88@gmail.com> wrote:
>
> On Wed, Oct 19, 2022 at 7:30 PM Matt Turner <mattst88@gmail.com> wrote:
> >
> > From: Jelle van der Waa <jvanderwaa@redhat.com>
> >
> > GTK 2 is a legacy API and the newer version is GTK 3 which changes a fe=
w
> > API functions. gtk_tree_view_set_rules_hint is no longer required since
> > theme's are now responsible to handle this, gtk_vbox_new is deprecated
> > and replaced by passing the orientation to gtk_box_new. Apart from thes=
e
> > changes the accessing of the screen changed in GTK which requires using
> > new functions for getting geometry. Lastly the GTK_STOCK_OK define is
> > deprecated in GTK 3.
> >
> > Signed-off-by: Jelle van der Waa <jvanderwaa@redhat.com>
> > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > ---
> > Originally sent in 2019. I've rebased it and given it a test.
> >
> > One problem I've noticed is that C++ symbol names are often broken.
> > E.g.:
> >
> > (perf:3254940): Gtk-WARNING **: 21:47:46.663: Failed to set text from
> > markup due to error parsing markup: Error on line 1 char 95:
> > =E2=80=9Cstd::char_traits<char=E2=80=9D is not a valid name: =E2=80=9C<=
=E2=80=9D
> >
> > Presumably we need to call g_markup_escape_text() somewhere, but I
> > struggled to find the right place.
> >
> > Without the patch, the GTK-2 version repeatedly segfaults, so this is a=
n
> > improvement regardless.
> >
> > v2: Dropped changes to test-all.c. I don't know how to build that
> >     apparently.
>
>
> Arnaldo, does this work better for you?

Ping=C2=B2
