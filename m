Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2FA6EE357
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjDYNns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjDYNnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:43:46 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A27EE58;
        Tue, 25 Apr 2023 06:43:44 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2a8aea2a654so56107881fa.1;
        Tue, 25 Apr 2023 06:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682430223; x=1685022223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL70Rc7HzGeZUoqLDlSCDrwe16+F8INjLhdwD4sRim0=;
        b=XJ6hTJmA79SxhcWsncYDGRQAHC8yuAJ4yJls/gUbDA28G07pwVjM+vnz6TEAHng0T8
         Vlzwc852rcvUjutLOYfoMcAhZsKP2Yz0N6ASljEexoeUoatymuRIPElCovKV310bOGTf
         nejC4plihdpXPyemrl+t6oeBQ7HhFxEIFyMcMR0MI5DL/lNJ5UzVQ4L9gs8kJeOBI550
         8Hc4/rM3SCrvle7AIpngypcysazAGRzQGRsFWsGdAgYvDp430uxxWV1Tz8/R2bL+Ivpb
         0HMV/vPvOli5pqSK2YAUjZ4fCXkP1nfExku0YsAc8XH7fjSmbSSQXqgXc9fJsIDyMlzk
         hwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682430223; x=1685022223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yL70Rc7HzGeZUoqLDlSCDrwe16+F8INjLhdwD4sRim0=;
        b=H9s1fHFq48Q/fPeD7DTm7XpiLfxsc2j+vOpMBzlGYNkEAwt1JXwsUv8oeMjLfQFWpg
         2x1gs57YXNQt8s2tP7LdkiX5Zv5qJZNWeFM2ItDELJvfuMFdq5sjpdbPMSprffLcxKNM
         EsnF8SRXbZ0m6PZ6PCN4Wq/G1nAp5rEX/G3boYXhGPkTAnHO4Fk41GFYmUXRtlKBNbk9
         K1uaf9xPDz8Lv2GoqMYYSXPsDqyyUbndhR6K3bB/ZSU7KAQ+p3jPAMLZ62ja6qIkI6Jz
         nVIGRmP8qyPjYGg798vC+YktCwzae1Khtn/3j8v9XQt1vCyQlP3P6oOU5fZXIXlYjzIu
         OuEg==
X-Gm-Message-State: AAQBX9fQ/czq1GmzJKJdMCbYpOolnbqGyunNiTYK5Y/CLivzPA9hWA0u
        DRhe4JLDPh6ZfnTQuL9VP+uxZTjvJq7sxg19pVA=
X-Google-Smtp-Source: AKy350aCHamhC0FqIkzUEGC576nU3ilFEoW8UqM8jU1//M55SfNYvUVmQZJyuc/kGkaQuDgiVDE4dWYnJg5EvFG8VXY=
X-Received: by 2002:a2e:8255:0:b0:2ab:d1b:dcb2 with SMTP id
 j21-20020a2e8255000000b002ab0d1bdcb2mr2071882ljh.38.1682430222632; Tue, 25
 Apr 2023 06:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230419151321.6167-1-jorge.lopez2@hp.com> <20230419151321.6167-3-jorge.lopez2@hp.com>
 <ZEJ1f7vOL1zCyNyR@duo.ucw.cz> <6ddd373b-6bcb-85a7-2423-ceea5d3f1246@redhat.com>
In-Reply-To: <6ddd373b-6bcb-85a7-2423-ceea5d3f1246@redhat.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Tue, 25 Apr 2023 08:43:18 -0500
Message-ID: <CAOOmCE8AkvXmD=RJLS_R1z+fmuzt1HSSr9DwnS8=pA4Wtjx7mA@mail.gmail.com>
Subject: Re: [PATCH v10 02/14] HP BIOSCFG driver - biosattr-interface
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 5:31=E2=80=AFAM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 4/21/23 13:37, Pavel Machek wrote:
> > Hi!
> >
> >> Linux Security components are under development and not published yet.
> >> The only linux component is the driver (hp bioscfg) at this time.
> >> Other published security components are under Windows.
> >>
> >> Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> >
> >> +/*
> >> + * ascii_to_utf16_unicode -  Convert ascii string to UTF-16 unicode
> >> + *
> >> + * BIOS supports UTF-16 characters that are 2 bytes long.  No variabl=
e
> >> + * multi-byte language supported.
> >> + *
> >> + * @p:   Unicode buffer address
> >> + * @str: string to convert to unicode
> >> + *
> >> + * Returns a void pointer to the buffer containing unicode string
> >> + */
> >> +void *ascii_to_utf16_unicode(u16 *p, const u8 *str)
> >> +{
> >
> > Does this need to go to library somewhere?
>
> This has already been discussed in earlier submissions
> of the driver, the utf16 format is HP specific (prefixed
> with a 16 bit le lenght, and the 0 length string needs
> special encoding) so despite the name this is not generic.
>
> It should probably be prefixed with hp_ because of this
> though, to avoid potential symbol conflicts when builtin.
>
> (and the same applies to other generic functions).

I will add the prefix 'hp_' to those generic functions such
ascii_to_utf16_unicode.

>
> Regards,
>
> Hans
>
>
