Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE43573FA96
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjF0Kzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjF0Kzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:55:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413AF268D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:55:32 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fba9daf043so1234575e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687863331; x=1690455331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBb5URQN0kKPJGX9e65RQhKm85RHTpZ2JS4kUJzomcs=;
        b=dj7GHGZnTDG/FnGE3uZfDBmMlrZCetCOq1VfSfOQhX76nTh0ySpdlJxWwsUNQhu+ka
         8AhaCFYYmZUWMZvbon9Z+Fsg2vZ6St7+UdYz0ayPc5qPd16SH/Yub4ay+7pvvn1MLcTm
         6TYvzRibjGxeyB5rRRQbnxwCLPcPwHf7SSP2QDqagGMICgF0SFwiAeJ7zh61v3kvCXMZ
         agazkGMt72Cp9dKH8NN7GsbIoVbqAjAX0LL+8dkHo2PIZensoQE5HAFi7DrzsnhPb6ak
         eJegCZiUP314M2p7nzkN2vtvr0VePon+at4/0aqSCg93g9+sf5DFz4w1wJH/Me+s5zeG
         VABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687863331; x=1690455331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBb5URQN0kKPJGX9e65RQhKm85RHTpZ2JS4kUJzomcs=;
        b=OLfcSRaK+Xo9fOLNFotYtQQu/AhkhSRWtfiObVcjrDE4hshsyArB9xdsXgD8RnyaUo
         B3lZGFw/R6lssawnmFo0mgQLxutjt3MK5RW4yGYD+J8YvhDTVPPiJNAaXzB+5kh3+lzh
         cgUpRSZ+y2rVa8HYNZwABsBb3BYW6IW3kE8bC2yVRFWo/ERd14f1622wjZICtOGLM9/r
         rFwZbO9CFpWycCfDEdLFUiU+Cl7uyFAkGgmNGVNhGreMwOSsodsV0+H6w9Xk4cNahqm8
         8W5KafUSQ7gc31HJbA81I6+qYiRWFtCWeVTXxSbrj2BRIpHRavrX7o4NDIT7i/GxScJj
         Znkg==
X-Gm-Message-State: AC+VfDx8DwutkZ1HVME/QHHd3kdnSpiT6qNrqGQ/5R690ZlmVUm3fYXR
        k0ZfbeZL9ZJZod5+2BNjXIxg/FQashRft5YEWZp13mE9ur6zaw==
X-Google-Smtp-Source: ACHHUZ6Nub3lyZD6Zpipd6CDx1GlU9GPN7JjXdnPtj1sdd9MPHyejyogmbI/vCxN6ebr2rYNX13L+wsIId9OWChC5uA=
X-Received: by 2002:a5d:4489:0:b0:313:ef08:c83b with SMTP id
 j9-20020a5d4489000000b00313ef08c83bmr5946932wrq.56.1687863330593; Tue, 27 Jun
 2023 03:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230627095616.5333-1-dg573847474@gmail.com> <87jzvpfcli.wl-tiwai@suse.de>
In-Reply-To: <87jzvpfcli.wl-tiwai@suse.de>
From:   =?UTF-8?B?5Y+25r6E6ZSL?= <dg573847474@gmail.com>
Date:   Tue, 27 Jun 2023 18:55:19 +0800
Message-ID: <CAAo+4rV6qbUftFFDX0q1+tkbmZNrY7nN2b12B4GhsjJ64k6PVg@mail.gmail.com>
Subject: Re: [PATCH] ALSA: sb: fix potential deadlock on &chip->mixer_lock
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh yes, sorry for not considering that one.

Best regards
Chengfeng

Takashi Iwai <tiwai@suse.de> =E4=BA=8E2023=E5=B9=B46=E6=9C=8827=E6=97=A5=E5=
=91=A8=E4=BA=8C 18:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 27 Jun 2023 11:56:16 +0200,
> Chengfeng Ye wrote:
> >
> > As &chip->mixer_lock is also acquired by the irq snd_sb8dsp_interrupt()
> > which executes under hard-irq context, code executing under process
> > context should disable irq before acquiring the lock, otherwise
> > deadlock could happen if the process context hold the lock then
> > preempt by the interruption.
> >
> > As the ALSA Driver document described, PCM prepare callbacks are not
> > executed with irq disabled by default, thus the acquiring of
> > &chip->mixer_lock should be irq disabled.
> >
> > Possible deadlock scenario:
> > snd_sb8_playback_prepare
> >     -> spin_lock(&chip->mixer_lock);
> >         <irq interrupt>
> >         -> snd_sb8dsp_interrupt()
> >         -> snd_sb8_capture_trigger()
> >         -> spin_lock(&chip->mixer_lock); (deadlock here)
> >
> > This flaw was found using an experimental static analysis tool we are
> > developing for irq-related deadlock.
> >
> > The tentative patch fix the potential deadlock by spin_lock_irqsave().
> >
> > Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
>
> I believe it's a false-positive.  There is already a call
>         spin_lock_irqsave(&chip->reg_lock, flags);
> beforehand.
>
>
> thanks,
>
> Takashi
