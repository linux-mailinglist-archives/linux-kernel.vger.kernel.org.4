Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194F56B4F42
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCJRmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjCJRmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:42:10 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AFF12DC0D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:41:24 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id a2so6400097plm.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678470083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9i01GHUbBCk3rnTRWnFMgPlkOeiOaiqgzdCZVZASJxs=;
        b=IECSjKaVJTupiu7cziuQExZtGqDUR877vSWtG6NaFDHfm0fLdIWPGaGudpvpqieV2Q
         2SwruSxTo/Dc+bCgJEx7kJQ0gTpUqbINF0apdm/2fxMGakqMEeu1FCLeiVpSmg/DlSXc
         klxi3OHIww37WozkkjHY4EGDF86u06cxDbZLk9zMde+izrNUc0YxDn0SNGx+jGpIocA8
         n7XnYaIh3WzfP7y0cHeP7iJCdgJqlgiF20sYwiQpU+OIlE42L2wUC69M157Zb66u4+jq
         UVXaaUKgNgXbpdUP/7wvcyatiDUzkhw/KfyQxJMCXZSMLRPu3jWTlSOf/89cfVcKNTIk
         dnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678470083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9i01GHUbBCk3rnTRWnFMgPlkOeiOaiqgzdCZVZASJxs=;
        b=BI+NxBtIUdpVFh9LG/mw+otO3uoWbu8sho2ipWiSZfySjv1iMDuYS9PjYteLKPbjG9
         hNWgHlSgqwSMRrwD3PrEM249tMq/QysOSWM+uM2sPv00wJ+FnrTuVefXQn8D3LbRmLwJ
         YPmHb89qexlVWJ/RkyBc1YfISmb4iQAL9lpn54+sT5CiTUuLf000fwe5zHMq1OMaPBho
         UNU8xs/qfX64sT0QyCk2ymx2sAWI+XHAkyIaSoONUJHqr6nsi37sC767zgEZhLXuyL/2
         bEDJptoTL0tiDeq14pae+rEah7TUCN4BnZs7ycq8UNj/K2TWGrRiJQkAbvvgRONbII1e
         wpWw==
X-Gm-Message-State: AO0yUKVZ08m/FudNbtB/aBC6Xutw6bz0eWjyxOK4K427VLkebFcGu/38
        NKxXLxr0T4B44vbgKwB3PtNGsK0UrvOr8egTXCw4UA==
X-Google-Smtp-Source: AK7set+B943YKtR8tOTl36xpuw9/f7/8OomUcUBm+hMbC1PQDc3TJfFM/qdNItwupJpJWPycii8cIXVvL5+5QhY/SsU=
X-Received: by 2002:a17:90a:c688:b0:22c:89b:8e97 with SMTP id
 n8-20020a17090ac68800b0022c089b8e97mr1183720pjt.1.1678470082815; Fri, 10 Mar
 2023 09:41:22 -0800 (PST)
MIME-Version: 1.0
References: <20230301214952.2190757-1-saravanak@google.com> <aca28784-c526-566b-dd7c-9cfda17e697a@foss.st.com>
In-Reply-To: <aca28784-c526-566b-dd7c-9cfda17e697a@foss.st.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 10 Mar 2023 09:40:46 -0800
Message-ID: <CAGETcx8K47t6X4biCYq+m8NcQFrUMyXvHknCRYUkuUbkw1_i6g@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Remove use of fw_devlink_purge_absent_suppliers()
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 9:21=E2=80=AFAM Fabrice Gasnier
<fabrice.gasnier@foss.st.com> wrote:
>
> On 3/1/23 22:49, Saravana Kannan wrote:
> > Yongqin, Martin, Amelie,
> >
> > We recent refactor of fw_devlink that ends with commit fb42378dcc7f
> > ("mtd: mtdpart: Don't create platform device that'll never probe"),
> > fw_devlink is smarter and doesn't depend on compatible property. So, I
> > don't think these calls are needed anymore. But I don't have these
> > devices to test on and be sure and the hardware I use to test changes
> > doesn't have this issue either.
> >
> > Can you please test these changes on the hardware where you hit the
> > issue to make sure things work as expected?
>
>
> Hi Saravana,
>
> Sorry for the late reply,

Thanks for testing!

> On behalf of Amelie, I did some testing on STM32MP15 DK2 board, on top
> of commit fb42378dcc7f, and also with your series applied.
> For reference, it's based on: arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
>
> I noticed some error messages on this board, since the 12 patch series,
> around the I2C PMIC device links:
>
> [    3.585514] i2c 1-0033: Failed to create device link with 1-0033
> [    3.590115] i2c 1-0033: Failed to create device link with 1-0033
> [    3.596278] i2c 1-0033: Failed to create device link with 1-0033
> [    3.602188] i2c 1-0033: Failed to create device link with 1-0033
> [    3.608165] i2c 1-0033: Failed to create device link with 1-0033
> [    3.614278] i2c 1-0033: Failed to create device link with 1-0033
> [    3.620256] i2c 1-0033: Failed to create device link with 1-0033
> [    3.626253] i2c 1-0033: Failed to create device link with 1-0033
> [    3.632252] i2c 1-0033: Failed to create device link with 1-0033
> [    3.639001] stpmic1 1-0033: PMIC Chip Version: 0x10
> [    3.645398] platform 5c002000.i2c:stpmic@33:regulators: Fixed
> dependency cycle(s) with /soc/i2c@5c00200
> 0/stpmic@33/regulators/boost
> [    3.655937] platform 5c002000.i2c:stpmic@33:regulators: Fixed
> dependency cycle(s) with /soc/i2c@5c00200
> 0/stpmic@33/regulators/buck2
> [    3.667824] platform 5c002000.i2c:stpmic@33:regulators: Fixed
> dependency cycle(s) with /soc/i2c@5c00200
> 0/stpmic@33/regulators/buck4
> [    3.719751] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators:
> Failed to create device link with 1-0033
> [    3.728099] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators:
> Failed to create device link with 1-0033
> [    3.737576] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators:
> Failed to create device link with 1-0033
> [    3.747216] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators:
> Failed to create device link with 1-0033
> [    3.756750] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators:
> Failed to create device link with 1-0033
> [    3.766382] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators:
> Failed to create device link with 1-0033
> [    3.775914] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators:
> Failed to create device link with 1-0033
> [    3.785545] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators:
> Failed to create device link with 1-0033

You can ignore all the "Failed to create device link" errors. They are
just error logs for stuff that was being ignored silently before. So
that's no functional regression AFAIK. I'll fix them separately if
necessary. And I'm sure you'll see these messages even without my
fw_devlink refactor series.

> Strangely some of the regulators seems to have "Fixed dependency", but
> not all.

Yeah, that's fine too -- that's just fw_devlink being verbose about
not enforcing probe ordering between devices in that cycle because it
can't tell which one of the dependencies is not a probe requirement.
Maybe I'll make it a dbg log if it's confusing people.

> Regarding the typec stusb160x I noticed the message below. It seems
> correct, right ?
>
> [   15.962771] typec port0: Fixed dependency cycle(s) with
> /soc/usb-otg@49000000/port/endpoint

I don't know if there is a cyclic dependency in your DT or not. But
this message itself is not an issue.

> But sometimes (lets say 1/5 times) during boot, when I have a cable
> already plugged in, it looks like there's some race condition. The dwc2
> driver reports some error logs in a loop, indefinitely, up to the
> watchdog resets the platform :-(.

Can you try this series (the one you are testing) without my
fw_devlink refactor that ends with commit fb42378dcc7f? Trying to make
sure we can reproduce the issue Amelie was fixing before I claim my
refactor series fixes it.

> [   16.288458] dwc2 49000000.usb-otg: Mode Mismatch Interrupt: currently
> in Host mode
> [   16.288490] dwc2 49000000.usb-otg: Mode Mismatch Interrupt: currently
> in Host mode
> [   16.310429] dwc2 49000000.usb-otg: Mode Mismatch Interrupt: currently
> in Host mode
>
> It probably just points some already existing race condition here. Maybe
> it isn't even linked to this patch. But I have no evidence at this
> stage. I hope I can investigate further on this one, hopefully I can
> free up some time for that.

If you never pick up this series, are you not having any of these 1/5
times boot issues? I wouldn't expect my changes to add any races, but
I'll wait to see what you find here.

Thanks,
Saravana

>
> Best Regards,
> Fabrice
>
> >
> > Yongqin, If you didn't have the context, this affected hikey960.
> >
> > Greg,
> >
> > Let's wait for some tests before we land these.
> >
> > Thanks,
> > Saravana
> >
> > Cc: Yongqin Liu <yongqin.liu@linaro.org>
> > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
> > Cc: Amelie Delaunay <amelie.delaunay@foss.st.com>
> >
> > Saravana Kannan (4):
> >   usb: typec: stusb160x: Remove use of
> >     fw_devlink_purge_absent_suppliers()
> >   usb: typec: tipd: Remove use of fw_devlink_purge_absent_suppliers()
> >   usb: typec: tcpm: Remove use of fw_devlink_purge_absent_suppliers()
> >   driver core: Delete fw_devlink_purge_absent_suppliers()
> >
> >  drivers/base/core.c           | 16 ----------------
> >  drivers/usb/typec/stusb160x.c |  9 ---------
> >  drivers/usb/typec/tcpm/tcpm.c |  9 ---------
> >  drivers/usb/typec/tipd/core.c |  9 ---------
> >  include/linux/fwnode.h        |  1 -
> >  5 files changed, 44 deletions(-)
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
