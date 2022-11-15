Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B4C629924
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiKOMqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiKOMq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:46:29 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2D327CFF;
        Tue, 15 Nov 2022 04:46:28 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id cg5so8579570qtb.12;
        Tue, 15 Nov 2022 04:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gvlQ/2+jbJxaDG4Ge3UxK9lXSrT4XQinBBToDN+BIAo=;
        b=m/Yv4Vyi0Zf7NDXx72Wj5PjsyBiYIIbf6i8H2n+mfSpQMNDGLj5IIJY0B0ZZ4FYizv
         /m6W5hLqS4R7cAcKHykR2lU6ysFt8Pg2B0Q1PBFhZvyW1uzQAj6lhDJnWUl3mIHYbC14
         D9ycIY6YJQhh5M9eldJ6Luk0grQErH9Zcds8RKVcS3QquuY3Epc/BSQeIbOIsQ3eP+/K
         +gOx7FnUNwLJrYN1+c9UPK4u2fvq2e/Y6p3N4GHYBC+1GjjLOy4LIl9wdN1+Z9C7jTiS
         QvvChf4hiqBqCVFl+eyv89Pf+341FIh/WgsBIH4Qt9x4ggfLQPmaFGdfqhrypYqsyXbs
         8P4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvlQ/2+jbJxaDG4Ge3UxK9lXSrT4XQinBBToDN+BIAo=;
        b=7HNurFzcQpUQeQsszOdEcIDfnXfs9BuxuPcakX9mfSKdf2QwU94BpOASTr6dbZOI0J
         GgSGkjwuFDw2MVU2VgJCTnT0Qd9UGQZ6DysKTL9y2peFhHYMvrmEumKS9Bl3F5Mr4tDC
         nABl09YHP2LTpVIfTlyompwyJvO/JW0NP/cEo3JlZYQQshEmKNK85hWVNx6RqQHv3GxH
         IHTbGBtujHpVUxJhygR923NHgC9D70bJn/Agsq3JT+2Y4SBsnjPTQtKQjSovWJEDYA9Q
         tF/+Gk3xYVUIa3rAS7DATYBuO0XvpP3s4GJBuP8NlwJmBmiGha2vcotdR66U/1maGBOg
         fgpw==
X-Gm-Message-State: ANoB5pl9T9v4ac1f68Jt5FqAUpeNQojODlDFUVQN4STUAf2bs9NDSdh/
        h4NPid4l5uYHSLf23+YOM78=
X-Google-Smtp-Source: AA0mqf4Akou2yGGxibTloHYSgopuRq7xgJx3wc6sFwWUrPiyThVG0mF/+SbDW8XOT/U9dZk6RfNdzA==
X-Received: by 2002:ac8:6f13:0:b0:3a5:1fdf:a768 with SMTP id bs19-20020ac86f13000000b003a51fdfa768mr16335408qtb.516.1668516387560;
        Tue, 15 Nov 2022 04:46:27 -0800 (PST)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id w9-20020ac86b09000000b003988b3d5280sm7142899qts.70.2022.11.15.04.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:46:27 -0800 (PST)
Message-ID: <334af9a1281673c0ac43dedccb6c1aea16494827.camel@gmail.com>
Subject: Re: [PATCH v2 0/8] Remove adis_initial_startup usage
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 15 Nov 2022 13:47:56 +0100
In-Reply-To: <20221105150647.2c9cbff7@jic23-huawei>
References: <20221103080847.162509-1-ramona.bolboaca@analog.com>
         <SJ0PR03MB677857576EF31B737F6D3DF599389@SJ0PR03MB6778.namprd03.prod.outlook.com>
         <20221105150647.2c9cbff7@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-11-05 at 15:06 +0000, Jonathan Cameron wrote:
> On Thu, 3 Nov 2022 12:35:31 +0000
> "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
>=20
> > > From: Ramona Bolboaca <ramona.bolboaca@analog.com>
> > > Sent: Thursday, November 3, 2022 9:09 AM
> > > To: jic23@kernel.org; linux-iio@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Cc: Bolboaca, Ramona <Ramona.Bolboaca@analog.com>
> > > Subject: [PATCH v2 0/8] Remove adis_initial_startup usage
> > >=20
> > >=20
> > > Remove 'adis_initial_startup()' usage due to the fact that it
> > > leads to a
> > > deadlock.
> > > The same mutex is acquired twice, without releasing it, once
> > > inside
> > > 'adis_initial_startup()' and once inside 'adis_enable_irq()'.
> > > Instead of 'adis_initial_startup()', use
> > > '__adis_initial_startup()'.
> > >=20
> > > Ramona Bolboaca (8):
> > > =C2=A0 iio: accel: adis16201: Fix deadlock in probe
> > > =C2=A0 iio: accel: adis16209: Fix deadlock in probe
> > > =C2=A0 iio: gyro: adis16136: Fix deadlock in probe
> > > =C2=A0 iio: gyro: adis16260: Fix deadlock in probe
> > > =C2=A0 iio: imu: adis16400: Fix deadlock in probe
> > > =C2=A0 staging: iio: accel: adis16203: Fix deadlock in probe
> > > =C2=A0 staging: iio: accel: adis16240: Fix deadlock in probe
> > > =C2=A0 iio: imu: adis: Remove adis_initial_startup function
> > >=20
> > > =C2=A0drivers/iio/accel/adis16201.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > =C2=A0drivers/iio/accel/adis16209.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > =C2=A0drivers/iio/gyro/adis16136.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > =C2=A0drivers/iio/gyro/adis16260.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > =C2=A0drivers/iio/imu/adis16400.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > =C2=A0drivers/staging/iio/accel/adis16203.c |=C2=A0 2 +-
> > > =C2=A0drivers/staging/iio/accel/adis16240.c |=C2=A0 2 +-
> > > =C2=A0include/linux/iio/imu/adis.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 12 ------------
> > > =C2=A08 files changed, 7 insertions(+), 19 deletions(-)
> > > =C2=A0=20
> >=20
> > You could have placed your v2 changelog in the cover letter.
> > Moreover it's the same for all patches... Anyways:=20
> >=20
> > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> This feels a little backwards.=C2=A0 Normally we'd expect the
> outer function to take the lock and the inner call to not
> do so.=C2=A0 Now it's fine to not take the lock here at all because
> the outer function call is in probe anyway, before we reach
> the point where there should be an concurrency.
>=20
> I wonder if we should instead do this by having
> an unlocked __adis_enable_irq() that is always called
> by __adis_initial_startup().=C2=A0 That would be the fix that
> then needs backporting.
>=20

I did mentioned the same thing in the first version of the series but
did not really pushed for it. Now that you mention, I agree it feels
weird (and wrong from a design perspective) to have the lock,
"silently", taken inside a function starting with double underscore
(which should mean unlocked call).

> Switching the calls from adis_initial_startup() to
> __adis_initial_startup() would then just be a trivial
> optimization to not take locks before they should ever matter.
>=20
> This all hinges on my assumption that the lock isn't useful.
> Am I right on that?
>=20

I think so as all the calls happen during probe before registering the
userspace interface.

- Nuno S=C3=A1

