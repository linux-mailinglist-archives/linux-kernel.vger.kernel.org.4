Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E316AA5B0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 00:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCCXig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 18:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCCXic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 18:38:32 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CA61A953
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 15:38:29 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id by13so3932680vsb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 15:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VW/Jgy7OPnDt1x0GvM0FJ+v1d2CV3W+TQXV2zzgAUYc=;
        b=6L8Onv7uDrP+1ncPNxj3EvpzXBhaPph1umg1oLhH+8pB0D1D6hHgpn9Bipleq5f75e
         e9kYubQcbMH9Yv4JqkZJy76O50hopYR6ngtbymXsAJa0HuJfcJZ4rMIbmW5fDd2Ai81h
         O9+kV5MmbxxQ6mdZ74cmJKcTf5AjReMgRqd1ILY3K0TpGPMG+dx/7rbRsDBhjnS9wiG/
         5zGbmx0qmWrjKH8TwAkPmQuSAfW3zmFGc5fP3uxIZ9kZUF/lKikDjaa05vSaWQtLtCJt
         OjlqV6LOM2AfVbYrEHMASHWD11sNYtXJzAdR8eT8sUvX2uG15OrESh1mAb0ZJWtEidVV
         nbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VW/Jgy7OPnDt1x0GvM0FJ+v1d2CV3W+TQXV2zzgAUYc=;
        b=6G1PIdnsieX7Wr0ybQtRtMIJRPIiczbQ5Q2AiDcV4CbEaGbv/+5fUhsF0tqZbFvgs3
         5DVvSLka+lqEQLLaQFJH8UoZO0LwCoAyFsa0eVbErOl5g5waucISVrsmdB/o2Z+y4J3G
         KQ0/xbvm1R6GbEF52fuCSS/hnsfpR674OrkBfIq5fOT50xvXBSDn+YcP/rHEnc4Ygp1L
         yGXab97t0SfQAwzwy3m/8ciBgnUEXNEgTOoDm8K+fEWdEdIzKhR6KzZpJ7oddS96K+hS
         JpQ/mhQ+kFOpnc/8RurpAhwQFCeNcQhn+wxgdHM919M0uMAu1BHv9I0ilnT7rwdOl3wg
         nfig==
X-Gm-Message-State: AO0yUKWLMJrLrluLKEdrs8GsKx50LBQuZ+IzshaiDuj7q71ns8a10ZwK
        PWcEN3MIlAqQzQYxygMGjyj+aMpG/eIvb2Oe8dZ5AQ==
X-Google-Smtp-Source: AK7set9IauOkDqQ+Y4mwefS66UxFj7YpcBQV+wZXSDdEET7WIU5/gMC8mOPhWpo5ynJN1d7hGME0F6KvzBaL6kqDKis=
X-Received: by 2002:a67:7304:0:b0:411:c1a2:9ea2 with SMTP id
 o4-20020a677304000000b00411c1a29ea2mr2265285vsc.4.1677886708981; Fri, 03 Mar
 2023 15:38:28 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2SC_Q3RWdeO9-mKDYC_TK8_vzefvGz_++O8StJer_h3Q@mail.gmail.com>
 <CAPDyKFq23_vCunapQ=OHFFGXs5a8_cr8w7hBUP=HQ5f2zaTBUg@mail.gmail.com>
In-Reply-To: <CAPDyKFq23_vCunapQ=OHFFGXs5a8_cr8w7hBUP=HQ5f2zaTBUg@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 3 Mar 2023 15:38:15 -0800
Message-ID: <CAJ+vNU3RU_hM=H4Efh4WP7+d5LRJ7JeLsoSEfJeikXXE-pnH1w@mail.gmail.com>
Subject: Re: mmc: core: Disable card detect during shutdown
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Robert Richter <rric@kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Jan Glauber <jan.glauber@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 2:37=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> + Robert
>
> On Thu, 2 Mar 2023 at 00:32, Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > Greetings,
> >
> > I've encountered a hang on shutdown on octeontx (CN8030 SoC, THUNDERX
> > architecture) that I bisected to commit 66c915d09b94 ("mmc: core:
> > Disable card detect during shutdown").
> >
> > It looks like the OMP5 Pyra ran into this as well related to a
> > malfunctioning driver [1]
> >
> > In the case of MMC_CAVIUM_THUNDERX the host controller supports
> > multiple slots each having their own CMD signal but shared clk/data
> > via the following dt:
> >
> > mmc@1,4 {
> >         compatible =3D "cavium,thunder-8890-mmc";
> >         reg =3D <0xc00 0x00 0x00 0x00 0x00>;
> >         #address-cells =3D <0x01>;
> >         #size-cells =3D <0x00>;
> >         clocks =3D <0x0b>;
> >
> >         /* eMMC */
> >         mmc-slot@0 {
> >                 compatible =3D "mmc-slot";
> >                 reg =3D <0>;
> >                 vmmc-supply =3D <&mmc_supply_3v3>;
> >                 max-frequency =3D <35000000>;
> >                 no-1-8-v;
> >                 bus-width =3D <8>;
> >                 no-sdio;
> >                 no-sd;
> >                 mmc-ddr-3_3v;
> >                 cap-mmc-highspeed;
> >         };
> >
> >         /* microSD */
> >         mmc-slot@1 {
> >                 compatible =3D "mmc-slot";
> >                 reg =3D <1>;
> >                 vmmc-supply =3D <&mmc_supply_3v3>;
> >                 max-frequency =3D <35000000>;
> >                 no-1-8-v;
> >                 broken-cd;
> >                 bus-width =3D <4>;
> >                 cap-sd-highspeed;
> >         };
> > };
> >
> > mmc_add_host is only called once for mmc0 and I can't see any printk
>
> That looks wrong. There needs to be one mmc host registered per slot,
> otherwise things will, for sure, not work.
>
> I suggest you have a closer look to see what goes on in thunder_mmc_probe=
().
>

Ulf,

Sorry, I was mistaken. Each slot does get its own mmc host.

I find that with thunderx_mmc I can reproduce this hang on shutdown
even if I just have a single slot with broken-cd defined.

I wonder if it has to do with thunder_mmc_probe getting called
multiple times because it defers due to gpio/regulator not yet being
available:
[    6.846262] thunderx_mmc 0000:01:01.4: Adding to iommu group 1
[    6.852143] thunder_mmc_probe
[    6.855622] thunder_mmc_probe scanning slots
[    6.860137] mmc_alloc_host: mmc0 init delayed work
[    6.864938] cvm_mmc_of_slot_probe mmc0
[    6.868695] cvm_mmc_of_slot_probe mmc0 Failed: EPROBE_DEFER
[    6.874269] mmc_free_host: mmc0
[    6.877481] thunder_mmc_probe Failed: EPROBE_DEFER
...
[    7.737536] gpio_thunderx 0000:00:06.0: Adding to iommu group 16
[    7.745252] gpio gpiochip0: (gpio_thunderx): not an immutable chip,
please consider fixing it!
[    7.754096] gpio_thunderx 0000:00:06.0: ThunderX GPIO: 48 lines
with base 512.
...
[    7.946636] thunder_mmc_probe
[    7.950125] thunder_mmc_probe scanning slots
[    7.954597] mmc_alloc_host: mmc0 init delayed work
[    7.959399] cvm_mmc_of_slot_probe mmc0
[    7.963158] cvm_mmc_of_slot_probe mmc0 Failed: EPROBE_DEFER
[    7.968732] mmc_free_host: mmc0
[    7.971963] thunder_mmc_probe Failed: EPROBE_DEFER
...
[    7.998271] reg_fixed_voltage_probe
[    8.001773] reg-fixed-voltage mmc_supply_3v3: reg_fixed_voltage_probe
[    8.008360] reg-fixed-voltage mmc_supply_3v3: mmc_supply_3v3
supplying 3300000uV
[    8.015851] thunder_mmc_probe
[    8.019318] thunder_mmc_probe scanning slots
[    8.023794] mmc_alloc_host: mmc0 init delayed work
[    8.028596] cvm_mmc_of_slot_probe mmc0
[    8.032488] mmc_add_host: mmc0
[    8.060655] cvm_mmc_of_slot_probe mmc0 ok
[    8.064678] thunderx_mmc 0000:01:01.4: probed
[    8.069041] mmc_rescan: mmc0 irq=3D-22

> > debugging added to __mmc_stop_host (maybe because serial/console has
> > been disabled by that point?).
>
> The serial console should work fine at this point, at least on those
> systems that I have tested this code with.
>
> Perhaps you added the debug print too late in the function, if the
> calls to disable_irq() or cancel_delayed_work_sync() are hanging?
>

This was something to do with busybox reboot. I switched to using
sysrq (echo o > /proc/sysrq-trigger) to reboot and now I can see my
printk's

> >
> > It appears that what causes this hang is the 'broken-cd' which enables
> > the detect change polling on mmc1. I have the ability to flip the CMD
> > signal routing thus making mmc0 the microSD and mmc1 the eMMC and when
> > I do that there isn't an issue so I think what happens is in the case
> > where mmc polling is enabled on mmc1 but not mmc0 (as above) the
> > polling causes a hang after __mmc_stop_host() is called for mmc0.
>
> The code in __mmc_stop_host() has been tested for both polling and
> gpio card detections. That said, it looks to me that there is
> something weird going on in the cavium mmc driver.
>
> What makes this even tricker, is that it's uncommon and not
> recommended to use more than one mmc slot per host instance.
>

that was my mistake... there is one host instance per slot and I see
this even if I only have 1 slot as long as polling is enabled.

now that I can see my printk's I can confirm it hangs when
_mmc_stop_host calls the cancel_delayed_work_sync:
# echo o > /proc/sysrq-trigger
[  210.370200] sysrq: Power Off
[  210.373147] kernel_shutdown_prepare
[  210.896927] mmc_rescan: mmc0 irq=3D-22
[  213.038191] mmc_host_classdev_shutdown mmc0
[  213.042384] __mmc_stop_host: mmc0 cd_irq=3D-22
[  213.046658] __mmc_stop_host: mmc0 calling cancel_delayed_work_sync
^^^ never comes back

If I comment out the call to cancel_delayed_work_sync in
__mmc_stop_host then shutdown does not hang so I think it has
something to do with mmc_alloc_host setting up the polling multiple
times.

Best Regards,

Tim



> >
> > Any ideas?
>
> I hope the above thoughts can point you in a direction to narrow down
> this problem.
>
> >
> > Best Regards,
> >
> > Tim
> >
> > [1] https://lore.kernel.org/all/55A0788B-03E8-457E-B093-40FD93F1B9F3@go=
ldelico.com/
>
> Kind regards
> Uffe
