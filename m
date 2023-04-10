Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DA06DC613
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjDJLIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjDJLIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:08:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A92525C;
        Mon, 10 Apr 2023 04:08:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D66AC61AF0;
        Mon, 10 Apr 2023 11:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5865AC433EF;
        Mon, 10 Apr 2023 11:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681124920;
        bh=ArhLNj5Da1vG4683hDuOk+VIyhMk9aziMJIUTnYJPsY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CqGgtjJckSFvYDfbwSSsG0FnASEvhZhUgh4N8gYanNn/E38/8dDVv7MwDk9AAmaUy
         o/3rca0l7m9F5hD1x/KUUbL4v13SGDwDdguHWDoEqfHduM5IM+yxmWaKrh3wM6jwwc
         VZggFI5pmQgj63kR9WruQrLXYR178UwHhXrpO1kcoFSZPKLKJl/U3cuSQTF6uCI+MU
         qTCQoENX5Ok+g+TaY5HPuNEe/rVa2JDLLwhVQ3xNPqsDeyQY/No+kHmyHmsQmu6j4u
         IL+7AYNU0gFWxnmQZi8bQXfUtE6TrT/pvV4ksgvNfACaa4itFfF4tFyf6v2fnc6JQ5
         oCn3uKhqFJ+PA==
Date:   Mon, 10 Apr 2023 12:23:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrea Merello <andrea.merello@iit.it>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] doc: Make sysfs-bus-iio doc more exact
Message-ID: <20230410122357.010a04c9@jic23-huawei>
In-Reply-To: <CAHp75VdO5B0dwG3RedZ7iuij3gCB+UfnLHgKvrbSpbzBh3DORA@mail.gmail.com>
References: <cover.1677331779.git.mazziesaccount@gmail.com>
        <41eafb0caa510cddf650cf5ff940639a184f3005.1677331779.git.mazziesaccount@gmail.com>
        <20230408113258.15a39576@jic23-huawei>
        <CAHp75VdO5B0dwG3RedZ7iuij3gCB+UfnLHgKvrbSpbzBh3DORA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Apr 2023 12:47:58 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Apr 8, 2023 at 1:18=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>  On Sat, 25 Feb 2023 15:56:16 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote: =20
>=20
> ...
>=20
> > Applied to the togreg branch of iio.git and pushed out as testing
> > (in this case to be mostly ignored by 0-day ;) =20
>=20
> One fix is needed?
>=20
> ...
>=20
> > >  Description:
> > >               Raw (unscaled) phase difference reading from channel Y
> > > -             that can be processed to radians.
> > > +             Units after application of scale and offset are radians=
. =20
>=20
> The previous chunks and confusion in reading the above suggest that
> period after Y must be added.
Fixed.  Thanks

>=20
> > >  What:                /sys/bus/iio/devices/iio:deviceX/in_massconcent=
ration_pm1_input
> > >  What:                /sys/bus/iio/devices/iio:deviceX/in_massconcent=
rationY_pm1_input =20
>=20

