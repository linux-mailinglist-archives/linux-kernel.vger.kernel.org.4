Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30CB6F3169
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 15:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjEANI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 09:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEANIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 09:08:54 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20182138
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 06:08:53 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-77d2062efebso444560241.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 06:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682946532; x=1685538532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NYwDNlVM38PNhi3rHJukoiDrX1975QXxtjMJh6hnqI=;
        b=igYd+zxsDMC2pbUwaH1pDL/17El8SJgJz5Y1isRIhjL3J6yPK3BaflkxoUT2MMmsFI
         1WPUiOtaHwxL7u7o8Bt7vwZZjObRZGZL3XZP0//Kd0pjQae6lRhxhTdxac3lAFfHCQRL
         Xm124kW3xTawS+cnKPq2KR5HTXDdrOa+brw4K1EOgSwzuBAdDPu8aZX6sXfM73cpYQXe
         WFk5feuWxnRymiC9ZEBfkH/YuUk6cQyivJghvTWOnabuK477T778iUamf1oV97En/UU+
         1GHcoUyhpwzcIjAyBGXFcNXFuG+4BjeckMao1sbPQix2+4T1VCFY3CTrscH0oyEu89MW
         ifCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682946532; x=1685538532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NYwDNlVM38PNhi3rHJukoiDrX1975QXxtjMJh6hnqI=;
        b=Lf+AhPyBikhfUs7npbrzcEOmbpjxmVaegDaYpVOPfUx+nkHaLWF8kHAyAmdH9DKqfJ
         nye7yGM+GbYMmUaB+uWF3B7tzXbstfAeUqsph4lSLWs1D4yIbCISCACzsQPdre6XBajp
         S/NUYOOIAlcvYTHUj34/pSZmTMG1retDWfblSLmgPJlS+ar5Ywx0RaugGUxAid7tHJfC
         uy8sJa6Tilf3VEEQUeohV7u1qQx5c2tk1GZVtUhGknSg7oKCBiM6S+W8c4ccFn4gJUUa
         aYEfK+poahf6Usd3jsHPAQ8GVj7O+MIr8cyYeEsVqL4g07ZuW+2NXq3yKNKIoA7+/yse
         l6dA==
X-Gm-Message-State: AC+VfDxyR2vttU7ChikzRYCRs3pVIRQdcGPc6Im/ZdoXZPxAKWxHxWIG
        uduIQYOtlv/GvM7g17GhDSS0vEfsLIaNZ4nT9o8=
X-Google-Smtp-Source: ACHHUZ7RW1jtGkDqZVkU9kZMJFBhSI9gSf13aBqrcgKZJhCwwsRQKbtUClZoXLWHjHFT3DZFKPe8IFWhIFEEMDveLgk=
X-Received: by 2002:a1f:3d43:0:b0:440:39a5:6c6b with SMTP id
 k64-20020a1f3d43000000b0044039a56c6bmr5041041vka.8.1682946532092; Mon, 01 May
 2023 06:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAAJw_ZsbTVd3Es373x_wTNDF7RknGhCD0r+NKUSwAO7HpLAkYA@mail.gmail.com>
 <ZE9B4avbDtIXOu4O@debian.me>
In-Reply-To: <ZE9B4avbDtIXOu4O@debian.me>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Mon, 1 May 2023 21:08:41 +0800
Message-ID: <CAAJw_Zt2G8RLG_+ak3c34v-PCsc2A235qQxa74EUa5ObzRmCsg@mail.gmail.com>
Subject: Re: linux-6.4 alsa sound broken
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Linux ALSA Subsystem Development 
        <alsa-devel@alsa-project.org>,
        Linux Regressions <regressions@lists.linux.dev>
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

On Mon, May 1, 2023 at 12:36=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On Mon, May 01, 2023 at 11:59:12AM +0800, Jeff Chua wrote:
> > Latest git pull from Linus's tree ... playing a simple sound file will
> > resulted in a lot of echo.
> >
> > Running on Lenovo X1 with ..
> > 00:1f.3 Audio device: Intel Corporation Alder Lake PCH-P High
> > Definition Audio Controller (rev 01)
> >
> > I've bisected and reverted the following patch fixed the problem.
> >
> > commit 9f656705c5faa18afb26d922cfc64f9fd103c38d
>
> Thanks for the regression report. However, where is your dmesg and/or ALS=
A log
> when the regression occurs? What is the playback test file?

There's no error in dmesg.

Test file is /usr/share/sounds/alsa/Side_Right.wav

>
> FYI, 9f656705c5faa1 ("ALSA: pcm: rewrite snd_pcm_playback_silence()") is
> originated as [1/2] of patch series that pokes around the auto-silencer. =
The
> other patch ([2/2]) got NAKed since autofilling buffer should have been d=
one in
> alsa-lib (still to be discussed) [1].
>
> Anyway, I'm adding this to regzbot:
>
> #regzbot ^introduced 9f656705c5faa1
> #regzbot title Much echoing when playing sound files on Intel Alder Lake =
PCH-P Audio Controller
>
> Thanks.
>
> [1]: https://lore.kernel.org/all/bb342e84-b468-8adc-6688-88da2c857da1@per=
ex.cz/
>
> --
> An old man doll... just what I always wanted! - Clara
