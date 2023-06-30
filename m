Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5B0743ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjF3L05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjF3L0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:26:53 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC361B1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:26:51 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5704fce0f23so18356007b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688124410; x=1690716410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZicOvf9bDN4v7xxXHEcxX/D7CBL3Gv0y/6DJ76/RtpU=;
        b=nr+0qeBnsO0LpFZUv3yLUD2H793smM2ShCQmOJ8jSQ5ovo+SrbqQCuOFvWQc6eC/Tg
         mfdwp6h8mPk+Suf838p2/LVSoxOQ+i+dglfsAgJ/vTHH1x9fVHIyDkLX1xTgGCoueo5A
         JJK7t9MhytFIuMmIPJTrxWl/fcevbd2NhGlbIpSveCm9ZaZnu6cXFCmfC0iemSFsG0SS
         4D7LpmmjslV6bPq82EAx5tCRCm1EDPGgA9OQr6opIRCq6YW3EMfRwz8AMmf8IyS5gbK9
         IRPpFpfySROLopvKjsda5hzU9kHDl/ZJ4hXBDJR7gr948YnNxqYjA96VlBlHXwM5Unac
         KE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688124410; x=1690716410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZicOvf9bDN4v7xxXHEcxX/D7CBL3Gv0y/6DJ76/RtpU=;
        b=H9sfEwCVt6LRKtw3s4LaekRQOGNTRbVE5n2E8srBx6+4P7OY+wblkc8Ovb4W+2PauB
         aUp8BdGyGNTDA5m79JRB90UUH3xLEvtYlRagQoohpCIo09vfRs9Wcl7z2ky9134jWWy5
         UhOGfkQDJxcysBzy7vqRORQLQbN3q/5DbveG0oCM1NxLxElWehGERVhuGm2mm3epZ6dh
         ZdLa1MenPb9jpLbNrEiOvk/qLq3RsmqemeUq5BwOdMKUe+yQ7yC8NS71uFXOxtJNGnI9
         bywKeWLx2orohAWrp39rU45voGNYvjf3x47x+mO3mrDANSefInwhkWJdFxu4vllqNG+D
         Bd/g==
X-Gm-Message-State: ABy/qLaNq6wmrKhgtPNTQ4HLUG4dudiy0BhfKYLXjwoRX9SOrCCAWif3
        UluZkC8oQnW6W+o90O+9jDClH0wiJLXjFi6HP+G/uBvqJvlEX08NkP8=
X-Google-Smtp-Source: APBJJlGWl+Zz2b36QIag6H3aK/0BNoriFADaghtw2KYGG+i6kE/6uWTfVRFY1+G9TpLfkHrhaUNTQRHOVWpf337++e4=
X-Received: by 2002:a81:6783:0:b0:577:617c:8cd with SMTP id
 b125-20020a816783000000b00577617c08cdmr507282ywc.35.1688124410564; Fri, 30
 Jun 2023 04:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230329202148.71107-1-dennis@kernel.org> <ZCTOMVjW+pnZVGsQ@snowbird>
 <CAMuHMdVK2zPnyB9s0uYwoKj0xspa0CRzqPjhrj-YFqVNdXxEkg@mail.gmail.com>
In-Reply-To: <CAMuHMdVK2zPnyB9s0uYwoKj0xspa0CRzqPjhrj-YFqVNdXxEkg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 30 Jun 2023 13:26:14 +0200
Message-ID: <CAPDyKFqtgCK5Wb_fZ9+VVK1F-LWYL+htMvQ9JPpp0zPjzBZ9gw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: inline the first mmc_scan() on mmc_start_host()
To:     Dennis Zhou <dennis@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
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

On Tue, 27 Jun 2023 at 19:20, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>
> Hi Dennis,
>
> On Thu, Mar 30, 2023 at 1:48=E2=80=AFAM Dennis Zhou <dennis@kernel.org> w=
rote:
> > When using dm-verity with a data partition on an emmc device, dm-verity
> > races with the discovery of attached emmc devices. This is because mmc'=
s
> > probing code sets up the host data structure then a work item is
> > scheduled to do discovery afterwards. To prevent this race on init,
> > let's inline the first call to detection, __mm_scan(), and let
> > subsequent detect calls be handled via the workqueue.
> >
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
>
> Thanks for your patch, which is now commit 2cc83bf7d41113d9 ("mmc:
> core: Allow mmc_start_host() synchronously detect a card") in
> linux-next/master mmc/next next-20230614 next-20230615 next-20230616
>
> I have bisected the following failure on Renesas Salvator-XS with R-Car H=
3
> ES2.0 to the above commit:
>
>     renesas_sdhi_internal_dmac ee140000.mmc: timeout waiting for
> hardware interrupt (CMD0)
>     renesas_sdhi_internal_dmac ee140000.mmc: timeout waiting for
> hardware interrupt (CMD1)
>     renesas_sdhi_internal_dmac ee140000.mmc: timeout waiting for
> hardware interrupt (CMD0)
>     renesas_sdhi_internal_dmac ee140000.mmc: timeout waiting for
> hardware interrupt (CMD1)
>     mmc0: Failed to initialize a non-removable card

Thanks for reporting!

After I had a closer look, I realize that all the renesas/tmio drivers
are suffering from the similar problem. A host driver must not call
mmc_add_host() before it's ready to serve requests.

Things like initializing an irq-handler must be done before
mmc_add_host() is called, which is not the case for renesas/tmio. In
fact, there seems to be a few other host drivers that have the similar
pattern in their probe routines.

Note that, even if the offending commit below triggers this problem
100% of the cases (as the probe path has now becomes synchronous),
there was a potential risk even before. Previously, mmc_add_host()
ended up punting a work - and if that work ended up sending a request
to the host driver, *before* the irq-handler would be ready, we would
hit the similar problem. I bet adding an msleep(1000) immediately
after mmc_add_host() in tmio_mmc_host_probe(), would then trigger this
problem too. :-)

That said, I am going to revert the offending commit to fix these
problems, for now. Then I will try to help out and fixup the relevant
host drivers  - and when that is done, we can give this whole thing a
new try.

Any objections or other suggestions to this?

Kind regards
Uffe

>
> Reverting the commit fixes the issue for me.
>
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -2185,10 +2185,8 @@ int mmc_card_alternative_gpt_sector(struct mmc_c=
ard *card, sector_t *gpt_sector)
> >  }
> >  EXPORT_SYMBOL(mmc_card_alternative_gpt_sector);
> >
> > -void mmc_rescan(struct work_struct *work)
> > +static void __mmc_rescan(struct mmc_host *host)
> >  {
> > -       struct mmc_host *host =3D
> > -               container_of(work, struct mmc_host, detect.work);
> >         int i;
> >
> >         if (host->rescan_disable)
> > @@ -2249,6 +2247,14 @@ void mmc_rescan(struct work_struct *work)
> >                 mmc_schedule_delayed_work(&host->detect, HZ);
> >  }
> >
> > +void mmc_rescan(struct work_struct *work)
> > +{
> > +       struct mmc_host *host =3D
> > +               container_of(work, struct mmc_host, detect.work);
> > +
> > +       __mmc_rescan(host);
> > +}
> > +
> >  void mmc_start_host(struct mmc_host *host)
> >  {
> >         host->f_init =3D max(min(freqs[0], host->f_max), host->f_min);
> > @@ -2261,7 +2267,8 @@ void mmc_start_host(struct mmc_host *host)
> >         }
> >
> >         mmc_gpiod_request_cd_irq(host);
> > -       _mmc_detect_change(host, 0, false);
> > +       host->detect_change =3D 1;
> > +       __mmc_rescan(host);
> >  }
> >
> >  void __mmc_stop_host(struct mmc_host *host)
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
