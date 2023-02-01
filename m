Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F19685ECC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 06:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjBAFSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 00:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBAFSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 00:18:04 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083AFEB62
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 21:18:02 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id lu11so10677270ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 21:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQzkVS8kfSVfXjueCcII9oQ2E2FRyG2mNoKI4xIksC0=;
        b=VvZYpSIgaZNjZGyngc8Btx/IDu2MhrcgPUykaW0GDud3gQzBy0xJ0djkypZrX/KZyq
         SFJ8T1oELNRICA7tU8CIl3kWaDrt7qqfSLEOVvjWAQIAsQf6dsP0csZD9YsbUVgFzRim
         v9TpL2FP7qkzFKktXMc5i/eYVidlWR2lb1jq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQzkVS8kfSVfXjueCcII9oQ2E2FRyG2mNoKI4xIksC0=;
        b=Vv6/szuBCtXdWEjvmWpa63DTAWGSypYns8GEavqJRUjND458/sWovqFvRyCP1EyH3N
         pd0ws7mt4/N3N2UjwjwccZ55qhQoInnGYTUyeTN+C21u182fWkYXNxgjBL+cWDzvlL/r
         yiyC55liaUCoWnM3DgBnM8bn8I9h1cVR+BQPQPT9UkEcLa9pUdMJmjf7MfXX7RohzZ+u
         EIuFTuq+9BpsVpsxIJPsb5NKnf+EQUb0ZFHlNunbegOln/rcOV8flwOjlsUD3l+6frC0
         S6VH/E0qV4xFtEUtaNzv5bH8irnGI+9dF5wByfapMvQ6c7Pi3MpHnzIhkqkEW2/7S2F5
         iVFw==
X-Gm-Message-State: AO0yUKXEGHITmdYJu/GHeI3GEvxCAa1AS7j9n84jzBn4fIKZ7A3eIxwF
        CjAx2BeMxtWx3fHddxKbntjaC4PjAjQnR4uRKMM=
X-Google-Smtp-Source: AK7set/uvP0kUEIv8M0caEy5i61/i+TWjGDyUJIZ8jECU5n2CpCvUo5xep6UREzjsirKLh3Icw1thUvpqc5kNAiW4oc=
X-Received: by 2002:a17:906:1653:b0:88a:7cf5:5d33 with SMTP id
 n19-20020a170906165300b0088a7cf55d33mr326339ejd.100.1675228680433; Tue, 31
 Jan 2023 21:18:00 -0800 (PST)
MIME-Version: 1.0
References: <20230129041547.942335-1-j.neuschaefer@gmx.net> <Y9X2Ur6oHTsFtCmW@probook>
In-Reply-To: <Y9X2Ur6oHTsFtCmW@probook>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 1 Feb 2023 05:17:47 +0000
Message-ID: <CACPK8XfGq++R6Rroi4ZRBKj6QgTJx5kzOeO3wK5Uk8VHzUe35g@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: Add wpcm450_defconfig for Nuvoton WPCM450
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     openbmc@lists.ozlabs.org, Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jan 2023 at 04:36, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.n=
et> wrote:
>
> On Sun, Jan 29, 2023 at 05:15:46AM +0100, Jonathan Neusch=C3=A4fer wrote:
> > This defconfig aims to offer a reasonable set of defaults for all
> > systems running on a Nuvoton WPCM450 chip.
> >
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > ---
>
> Sorry, I hadn't noticed that v3 already made it into linux-next.
>
> @Joel: I'll leave it up to you to decide whether you keep v3 or replace
> it with v4 (although given the upcoming merge window, I guess keeping v3
> is safer).

I sent v4 to the soc maintainers.

Cheers,

Joel

>
>
> Best regards,
> Jonathan
>
> > v4:
> > - Add Joel's R-b
> > - Disable CPU_FREQ
> > - Update for Linux 6.2: Enable CONFIG_SPI_WPCM_FIU, disable
> >   CONFIG_LEGACY_TIOCSTI
> > - Disable CONFIG_KEXEC, which isn't generally useful for the BMC usecas=
e
> >
> > v3:
> > - https://lore.kernel.org/lkml/20221101112134.673869-1-j.neuschaefer@gm=
x.net/
> > - Regenerate for 6.1-rc1 and enable a few Nuvoton-specific options as
> >   well as the PECI subsystem
> >
> > v2:
> > - Regenerate for 5.19-rc1
> > ---
> >  MAINTAINERS                        |   1 +
> >  arch/arm/configs/wpcm450_defconfig | 211 +++++++++++++++++++++++++++++
> >  2 files changed, 212 insertions(+)
> >  create mode 100644 arch/arm/configs/wpcm450_defconfig
> [...]
