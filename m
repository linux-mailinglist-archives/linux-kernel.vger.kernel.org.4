Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A226AAB91
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 18:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjCDRUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 12:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCDRUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 12:20:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12771E073;
        Sat,  4 Mar 2023 09:19:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DA59B808CA;
        Sat,  4 Mar 2023 17:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A2BC433EF;
        Sat,  4 Mar 2023 17:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677950395;
        bh=SK7Kwhhi/uD/G7RidXbseM1UAmXNuUfv51NQ/U3YKJg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rh0wM4+Ml+ReF6Qhs2k32vLNSULLA70mmDWbx2mUMySoqjawNnGB6mX7xaL7UJNso
         mqkwU+LxrRIp5w8IfkL4768a6u+APrr1D6l/5qxoq6LozxY5VprzAZhMFT/VL8FhpA
         PAYFZEByZkw6niCsNA3xbg1dVe/7nZM4dfQS2J+jW9DnOZVYs9HZhu7yUWTSmOJEVM
         QNS/vTiYNF2OZ1967KViRQ8JdNJEu0vV3ezLPVQl9D9u3oMW+8J4nn0vmaHbr4FxtZ
         UqDGrBPuOhxpVkCmqo+a0TTgxJdSp3ci3LaXNYEJI/iC/P7F4WMnuwmJgxj7CFLknd
         Wtl6i1BVuZenw==
Date:   Sat, 4 Mar 2023 17:19:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: Add TI ADS1100 and ADS1000
Message-ID: <20230304171950.5a411037@jic23-huawei>
In-Reply-To: <b635b91e-1dcc-71ba-95d1-1f87a20dbaf2@metafoo.de>
References: <20230228063151.17598-1-mike.looijmans@topic.nl>
        <20230228063151.17598-2-mike.looijmans@topic.nl>
        <Y/9vez/fzLD5dRVF@smile.fi.intel.com>
        <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.0685d97e-4a28-499e-a9e3-3bafec126832@emailsignatures365.codetwo.com>
        <a2ba706f-888b-0a72-03a5-cbf761dfaf19@topic.nl>
        <87bc192e-45ae-9480-5e84-8fe0adfc12e7@metafoo.de>
        <b635b91e-1dcc-71ba-95d1-1f87a20dbaf2@metafoo.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2023 05:20:38 -0800
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 3/2/23 05:16, Lars-Peter Clausen wrote:
> > On 3/1/23 23:49, Mike Looijmans wrote: =20
> >>
> >> =20
> >>> ...
> >>> ...
> >>> =20
> >>>> +static int ads1100_runtime_suspend(struct device *dev)
> >>>> +{
> >>>> +=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev =3D=20
> >>>> i2c_get_clientdata(to_i2c_client(dev));
> >>>> +=C2=A0=C2=A0=C2=A0 struct ads1100_data *data =3D iio_priv(indio_dev=
);
> >>>> +
> >>>> +=C2=A0=C2=A0=C2=A0 ads1100_set_config_bits(data, ADS1100_CFG_SC,=20
> >>>> ADS1100_SINGLESHOT);
> >>>> +=C2=A0=C2=A0=C2=A0 regulator_disable(data->reg_vdd); =20
> >>> Wrong devm / non-devm ordering. =20
> >>
> >> Don't understand your remark, can you explain further please?
> >>
> >> devm / non-devm ordering would be related to the "probe" function. As=
=20
> >> far as I can tell, I'm not allocating resources after the devm calls.=
=20
> >> And the "remove" is empty. =20
> >
> > Strictly speaking we need to unregister the IIO device before=20
> > disabling the regulator, otherwise there is a small window where the=20
> > IIO device still exists, but doesn't work anymore. This is a very=20
> > theoretical scenario though.
> >
> > You are lucky :) There is a new function=20
> > `devm_regulator_get_enable()`[1], which will manage the=20
> > regulator_disable() for you. Using that will also reduce the=20
> > boilerplate in `probe()` a bit
> >
> > - Lars
> >
> > [1] https://lwn.net/Articles/904383/
> > =20
> Sorry, just saw that Andy's comment was on the suspend() function, not=20
> remove(). In that case there is of course no need for any devm things.=20
> But still a good idea to use `devm_regulator_get_enable()` in probe for=20
> the boiler plate.
>=20
You can't because (annoyingly) devem_regulator_get_enable() doesn't
provide you access to the struct regulator that you need to be able
to turn it of for power management.
That case only works for the leave the power on all the time cases.

Jonathan
