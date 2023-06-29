Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6D4742417
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjF2KjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjF2KjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:39:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5621719;
        Thu, 29 Jun 2023 03:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31AB4614B4;
        Thu, 29 Jun 2023 10:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0118C433C0;
        Thu, 29 Jun 2023 10:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688035141;
        bh=LT9sQu3sBE6MeeU7W2CcEtZVUtDNU15gwVQl3P4L+rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ahl/LM9sX2m0wBNtg9WRjubZY2LLH+/7DQMP+yMiAI9dB4SwWa/yTI8GSjXSFaruR
         y9OWAbMsxLRPa/jvVbEdJ0ua8VZXGeWi/xHL2CtA8JM+4L9wIXclhhGUQNFqgZ4qYi
         8nMNYW8au9ABod6S2oYZDH9Q7m7xtnU0K7B7COC+hm8z1Z7swluxvnkourk865Prus
         c7VpjLtLGxWQjGgXRHaFGXuTal5eWMe1SULjwMoDEU672LRrsfMURhubM9Z6fMZQuS
         kgEABuSe+0lS4siE0uI/AbPXulkezt44IOgMY63TDeNNGPov7COYuVm0YL6DoiAHrn
         EJw5u/dSSKP9Q==
Date:   Thu, 29 Jun 2023 11:38:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        "Sahin, Okan" <Okan.Sahin@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <d070eecd-cb3b-4968-803e-1817a1a4359a@sirena.org.uk>
References: <20230621171315.GL10378@google.com>
 <20230626175443.GA3446604-robh@kernel.org>
 <20230627135615.GF10378@google.com>
 <CAL_JsqL3T6pjnTFgFvbYMeATD6cjhc-Sm0vZW2cv5k+w9Oxjuw@mail.gmail.com>
 <ZJry8QTka8m6ag/j@fedora>
 <20230627163344.GG10378@google.com>
 <CAL_Jsq+Z64tuMO8a2Y=2GrXZ8q0L4Z2avCiphsn0HOOC71Dzjg@mail.gmail.com>
 <20230628134013.GH10378@google.com>
 <472a4d86-3bfb-4c2b-a099-f1254dd01e24@sirena.org.uk>
 <20230629072500.GA2110266@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="slMax2aHJcAmlvoZ"
Content-Disposition: inline
In-Reply-To: <20230629072500.GA2110266@google.com>
X-Cookie: Surprise due today.  Also the rent.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--slMax2aHJcAmlvoZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 29, 2023 at 08:25:00AM +0100, Lee Jones wrote:
> On Wed, 28 Jun 2023, Mark Brown wrote:

> > As I mentioned before the number of resends of what are frequently very
> > similar serieses (eg, two PMICs from the same vendor in flight at the
> > same time) was causing me real issues with tags going AWOL and things
> > getting lost in the noise.

> As much as I empathise with each of these points (I feel it too), the
> alternative seems to be causing more issues for more people.  With that
> in mind, I'm going to revert back to how we've been doing things for a
> long time now.  Please try to Ack and forget.  If a contributor fails to
> apply a previously issued tag, we'll have to bring that up at the time.

The thing that's causing a lot of the issues here is that you're only
applying the serieses en masse, blocking things on getting absolutely
everything lined up (including this time over a merge window).  I really
don't understand why you feel you're forced to batch everything together
like this.

--slMax2aHJcAmlvoZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSdXz0ACgkQJNaLcl1U
h9CYEgf+K8srDgv971qBaPL/U8ocHN7gG0JxkI0/h/Ax6C3PBmoPp9vF4f2IleaR
v51nTp/6Lq1SPS17XPz0v0Xf4kwfLfYUv1LryRUFh0bEsI49PKl9anUW8IV7exPs
TnG1Vay3EjprUKmzYzmTR9jH1EuSDn2iocRcjI2CfyY9MYby9TjtFyI/Hv3MtU0h
pMI9JtNGLxmQnoTCW2aC5mc4/UfZJtQ0BEDziu+9R97Cw9h3Lj9ygXV/5GE/KI8J
C+oTj3YDBcPSOIm7i2mr+JpstEf5zqfZAW1obLehIa1ZIENpIClmZ/UxJjB7atnY
pRkRC7/RC2WyqfuDLo5yupgbcAEuIg==
=b6uW
-----END PGP SIGNATURE-----

--slMax2aHJcAmlvoZ--
