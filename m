Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63A7682DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjAaNcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjAaNcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:32:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557064860E;
        Tue, 31 Jan 2023 05:32:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E70E261512;
        Tue, 31 Jan 2023 13:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D43FC433D2;
        Tue, 31 Jan 2023 13:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675171936;
        bh=zluzqNhEDMREcE7HOdEzAROjhz7qIrAFoLUueku9epg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EqldAqGluycuPltb9QjJTewitzBFRIqBWPBUXjM7TI8Hk9tvRpmW0bNiUjRshltgn
         j4VOxKyfNdLtfLTcwsVTPquPF9zI1OB7cOHrNMuWBLNpf0jPlDnwxr/Q8S/GRwkEab
         +JpRH8Vuy6dERNa+r94kXD4NZFumvnDpLYQylzTntfsGHE0LJ+QNNomBC78h8a2jd3
         Lwm1NMWbUVHnoGmZRZI0+KN9gPn/JftaylokInYnahWk5A1ARfR7EuZn3dQy239QPg
         DRTPTA3gabSXqUL6ZwonHCuA2k+4xiYxjfjC1Na/k+Ykv6dMZuFxeGjjmuGZF/Sp32
         pxa1nHcmXlPrA==
Date:   Tue, 31 Jan 2023 13:32:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] drivers: regulator: Add ADI MAX77541/MAX77540
 Regulator Support
Message-ID: <Y9kYWfAkVnUFO9nN@sirena.org.uk>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-4-okan.sahin@analog.com>
 <Y8erlpofdk24vwCC@smile.fi.intel.com>
 <MN2PR03MB5168EC97926AB33D4D806FCCE7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
 <MN2PR03MB516865804044A798AEB5B6C0E7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
 <Y9kJEsjkG8h79tcR@smile.fi.intel.com>
 <BY5PR03MB5153C18E65B954E9FEFD96B1E7D09@BY5PR03MB5153.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SyVB6RxR1IPYQ5gk"
Content-Disposition: inline
In-Reply-To: <BY5PR03MB5153C18E65B954E9FEFD96B1E7D09@BY5PR03MB5153.namprd03.prod.outlook.com>
X-Cookie: MS-DOS must die!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SyVB6RxR1IPYQ5gk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 31, 2023 at 01:23:33PM +0000, Sahin, Okan wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> >> static const struct of_device_id max77541_regulator_of_id[] = {
> >> 	{ .compatible = "adi,max77540-regulator", },
> >> 	{ .compatible = "adi,max77541-regulator", },
> >> 	{ /* sentinel */  }
> >> };
> >> MODULE_DEVICE_TABLE(of, max77541_regulator_of_id);

> >> What do you think?

> >If you have got all necessary data from the upper layer, why do you need to have
> >an ID table here? I'm not sure I understand how this OF ID table works in this
> >case.

> I added it since there is regulator node in device tree. With the help
> of devm_regulator_register(..), driver takes parameters of regulator
> node. I also used id to select and to initialize regulator descriptors
> which are chip specific. So far there is no comment about OF ID table
> so I kept it. I thought I need to add both of id table and platform id
> table as name matching is required to initialize platform device from
> mfd.

You probably shouldn't have compatibles for subdevices of a MFD unless
it's some reusable IP that'll appear elsewhere, especially for something
like the regulators where grouping them all into a single device is very
Linux specific.

--SyVB6RxR1IPYQ5gk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPZGFgACgkQJNaLcl1U
h9AMsQf9F35rB6oz1Aj0FUXAVJYnE1F/r7OWDi89yHeoLbiwjYXUtwpxzxzJoe0a
uCfU/5+eH3AnL0gvqSb+6930Oieh7Bdoq38dW/GYORr5h+KZrZXb6cPPrAV0L/Uv
o4mkVKb0EqubUCddiA6uTdf5c+1fWEvgyhk8C4sJJCiKBO2mKbu3RDrF/bSvgLPY
dsz1VFXmBNPRl0/aEQPXVWI/kQ7oi6OpFku+p/G3cMRdKwP2i6M/iMmjPRedP68K
RffMWc02z+qOWCdRrzp4U4KWoTaASVuWzqWbaqodHNKjB1M4g4dLh9hrZ798o2Ea
roefahQsaxhBe0hg38uCJ3DBQoBOhg==
=jgfu
-----END PGP SIGNATURE-----

--SyVB6RxR1IPYQ5gk--
