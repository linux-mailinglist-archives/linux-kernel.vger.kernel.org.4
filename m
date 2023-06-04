Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E908872170E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjFDMwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDMwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:52:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D8D91;
        Sun,  4 Jun 2023 05:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9293B60CEC;
        Sun,  4 Jun 2023 12:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C487DC433D2;
        Sun,  4 Jun 2023 12:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685883153;
        bh=jioYa8JgZJ877Due+C+TvMM5McsdOwLd9jYmABtS2fc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B+o59eYM0qTv7hoIgWYvZq6XQLgvc1bFaSXYqj/HES+XF9f7cBuYSczYcyl1PywFl
         YSwy/tQWjKkn98S/UEWm4U/PegeVrxt9qOjXZhbPnruyXsOpN1vju0TTGMBLf8IwbF
         zys5ifqsY19OQDt9bp2avP6EnZ7M7ljRrKvhi03jcyzENtyLF/800pki6uSsqEgfIH
         Juo+XRyckUODxofmDd26+CLMd9Dr4+nUUIl/k8VYjqu/QVoe9Acl5gIpllUE+9DDns
         u3SY30tAs9mLRpGmljNQSWAWJE969KCBbkoV+2SXOHSKPQcrbjD/M91EefXQ755+NB
         MBEIFjfRn2B1w==
Date:   Sun, 4 Jun 2023 13:52:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     George Stark <GNStark@sberdevices.ru>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>, kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v2] meson saradc: add iio device attrib to switch
 channel 7 mux
Message-ID: <20230604135228.5a5d743d@jic23-huawei>
In-Reply-To: <CAFBinCA=earf119bN7ohmTQGDzSMeV9qcL8RU9DUYe0195H5=Q@mail.gmail.com>
References: <20230527214854.126517-1-gnstark@sberdevices.ru>
        <20230528161117.197f7e61@jic23-huawei>
        <4d5a7691-68ac-6626-5502-383fad3a9436@sberdevices.ru>
        <CAFBinCA=earf119bN7ohmTQGDzSMeV9qcL8RU9DUYe0195H5=Q@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 22:04:18 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hi George,
>=20
> On Sun, May 28, 2023 at 11:52=E2=80=AFPM George Stark <GNStark@sberdevice=
s.ru> wrote:
> [...]
> > > Based on the limited description we have here, I'm not understanding =
why
> > > you don't just express this as a set of channels. One channel per mux
> > > setting, with the in_voltageX_label providing the information on what=
 the
> > > channel is connected to.
> > >
> > > This is an interesting facility, so good to enable for high precision=
 calibration
> > > but we still want to map it to standards signals.  Userspace doesn't
> > > care that these are all being measured via the same input 7 - which
> > > is itself probably an input to a MUX.
> > >
> > > Jonathan =20
> >
> > Hello Jonathan
> >
> > Thanks for the review.
> >
> > Your idea of exposing the mux setting as iio channels is very
> > interesting and at least worth trying.
> > The sysfs approach was chosen because of the code changes are simple and
> > neat (compare to channels approach).
> > Also calibration by using those mux inputs are already supported in the
> > driver (performed at probe stage) so I expect very special usecases for
> > those mux settings like debug or device production stage tests. In those
> > usescases hardware specific knowledge is required anyway. =20

Agreed that using channels for this is more complex code wise, but the
avoidance of custom ABI is usually worthwhile.  However I get your point
that this is weird debug / corner case paths anyway.
However...


> Another downside to the debugfs approach is user support:
> If someone reports odd values on ADC channel 7 then we need to make
> sure to double check if the mux has been altered from userspace (the
> calibration during initialization ensures to leave channel 7 in a
> consistent state, while a user may change the mux, forget about it and
> then complain that values are wrong).

This problem raises red flags for me.  If the channel wasn't otherwise
useful then treating it as a weird debug thing is fine, but if a normal
read can end up returning weird answers because of leftover configuration
that is custom ABI, so standard code isn't even aware of it, that's bad.

Hence I would not want to see any path under which that can happen.
A read of in_voltage7_raw should continue to return the normal value
whatever this patch adds.

Jonathan

>=20
>=20
> Best regards,
> Martin

