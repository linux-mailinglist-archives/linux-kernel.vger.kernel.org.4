Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D3D70DF5A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbjEWOe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbjEWOew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:34:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A30218E;
        Tue, 23 May 2023 07:34:47 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30a8dc89c33so1921453f8f.0;
        Tue, 23 May 2023 07:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684852486; x=1687444486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3i1MmRo9IlXQkc30ONLQUcnUbi2JdYKbcGrE+JQbvIg=;
        b=g3LU+IJAqQN71No01lwOpjhPdnSS++pqefvW2AfZ6yFctiNBFQYl0OTSk0p6P6R2Yu
         csuCpZE8PV783x8Rs5bpZFdCCkh1ZTMg1t+8J8hA5tXKjIt2K0PEmcxpyNRm6uyUb6jf
         +5+k5MGrsshyfzUOlnAl/XZYQ7abM4wVI6ubstYfJQ5g+LKQi1bP+KNhuOhiiVZxNdpa
         BPohkLlNHExbyCQG8s2Yv75yj+6smSd0rKKDPiMA/bUmV/S55W9OmYbBcWdVpo4YZlZK
         IT/hGbMLfIdqE+9rrp9brCXTrjeXV1jeHwszGGvCUMq4Yr0KB9HtiJGoVYKPsKAaxsM8
         gIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684852486; x=1687444486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3i1MmRo9IlXQkc30ONLQUcnUbi2JdYKbcGrE+JQbvIg=;
        b=gX0h1cgXuSHfGlpA4ZGw1p4BnQSZlfOASGWyog9jnj3QZfSYN2A2OuYwd3xm8xTGpS
         lOmGuYVdanKQFTNAj68EZZ2VBRHfhR15MNpQQITjg4/2UDTXPqJdNnglLQkREZ4Uj3d/
         VDOVC+r/hSIDPPIOpifpCh9jI+KLjS51+fLEOJgc5hik7F0/Kwz9cUm8z7dfBBcf+qNW
         wKdc9aHWbAwrp6B0I9WuFe701MS2xPgAq4Gxv/s/OTCiZF+mas4hC2Qnh3+qe9KxTmsK
         dp1TT81ulVltwQkgmmDZaq5XLOofXAtcFaUK+nGFWYCVzxfUaWNHCh1ynaZQKxzNr1KM
         UPyg==
X-Gm-Message-State: AC+VfDzWfNV/69HcNI9aY01I1ZelrGG7RFVgIdiwtWSGHSnvsroeUzNm
        zVUCFw2HmQgzN+eQCxKiItsRdL89cSSzzyR5FCXV/3A9SuEETQ==
X-Google-Smtp-Source: ACHHUZ7yUKldLNpyhF38THwFUgL8EUge/GnGpW6AWgE6q23Pnsq9SPgv3BsOuQ058n8L+Op7EQkX96z9dC3Q+2h/+yA=
X-Received: by 2002:adf:f784:0:b0:2ee:f77f:3d02 with SMTP id
 q4-20020adff784000000b002eef77f3d02mr10201521wrp.0.1684852485567; Tue, 23 May
 2023 07:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230523021150.2406032-1-azeemshaikh38@gmail.com>
 <20230523090540.GC2174496@google.com> <ZGyDx4Jg9j2zmjD6@kekkonen.localdomain>
In-Reply-To: <ZGyDx4Jg9j2zmjD6@kekkonen.localdomain>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Tue, 23 May 2023 10:34:34 -0400
Message-ID: <CADmuW3W+-7GeKX2LqvvTW408v6x1o_as5xuUFxrdHf9TyTTsnQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: Replace all non-returning strlcpy with strscpy
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Lee Jones <lee@kernel.org>, Sakari Ailus <sakari.ailus@iki.fi>,
        linux-hardening@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the quick response Lee and Sakari.

On Tue, May 23, 2023 at 5:13=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Lee, Azeem,
>
> On Tue, May 23, 2023 at 10:05:40AM +0100, Lee Jones wrote:
> > On Tue, 23 May 2023, Azeem Shaikh wrote:
> >
> > > strlcpy() reads the entire source buffer first.
> > > This read may exceed the destination size limit.
> > > This is both inefficient and can lead to linear read
> > > overflows if a source string is not NUL-terminated [1].
> > > In an effort to remove strlcpy() completely [2], replace
> > > strlcpy() here with strscpy().
> > > No return values were used, so direct replacement is safe.
> > >
> > > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rlcpy
> > > [2] https://github.com/KSPP/linux/issues/89
> > >
> > > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > > ---
> > >  drivers/leds/flash/leds-as3645a.c |    4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Please resubmit, taking the time to check the subject line please.
>
> I'd say also shorter description will suffice. Nowadays people understand
> the motivation replacing strlcpy() by strscpy() without too much
> elaboration. Lines may be up to 74 characters long, too, and period isn't
> automatically followed by a newline.
>

Let me know if this commit log looks good to you both and I'll send over a =
v2.

Subject: [PATCH] leds: as3645a: Replace all non-returning strlcpy with strs=
cpy

Part of a tree-wide effort to remove deprecated strlcpy()[1] and replace
it with strscpy()[2]. No return values were used, so direct replacement
is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

> I also prefer my @linux.intel.com address, as in MAINTAINERS for this
> driver.

Fyi that the email address mentioned for this driver is not the
@linux.intel.com -
https://github.com/torvalds/linux/blob/44c026a73be8038f03dbdeef028b642880cf=
1511/MAINTAINERS#L3070.
I'm happy to send the v2 patch to sakari.ailus@linux.intel.com if you
prefer that instead.
