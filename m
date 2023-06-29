Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00004742BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjF2R7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjF2R7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:59:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D065910EC;
        Thu, 29 Jun 2023 10:59:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CFDA615D5;
        Thu, 29 Jun 2023 17:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B9CC433C9;
        Thu, 29 Jun 2023 17:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688061547;
        bh=KWuh+EtlgN9WgsuGzzN5S2e0JO8yjgAdyyzGc2r4JgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lgHCSLr4LI+gd3Bgw18ZI0ef9rt/JfwYNIy0RfQDQHclcOHCK/3jkuqrxGg3i2hCN
         laW6+qyxaq+IANQ6TQVo8u0SfgUrD7wQHpHixdoqkT/gb57iZIvmQOhi2OFJG7LNHi
         QgvIKpmnxXRINqB563yyxCuR56jd9SQLXKtbxqkpknGU8LF1D/utk0DIt0hvZsGTDw
         TNx1MmHpAIo1hxsbPdkwk73Nu0zUU7qxLjdtoE91n7F8XyK2DE0EINbQ5eLv34aScl
         szfL5+Ur+T0EeUVGYsYKgNVC8a+41LALLx+EwoH/jt0NdpZ4leTbJOytOXjnRfxIyQ
         cScB8p/FmyjJg==
Date:   Thu, 29 Jun 2023 18:58:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee@kernel.org>,
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
Message-ID: <998ef8d8-594e-45e3-9aa3-ec9061cf7f11@sirena.org.uk>
References: <ZJry8QTka8m6ag/j@fedora>
 <20230627163344.GG10378@google.com>
 <CAL_Jsq+Z64tuMO8a2Y=2GrXZ8q0L4Z2avCiphsn0HOOC71Dzjg@mail.gmail.com>
 <20230628134013.GH10378@google.com>
 <472a4d86-3bfb-4c2b-a099-f1254dd01e24@sirena.org.uk>
 <20230629072500.GA2110266@google.com>
 <d070eecd-cb3b-4968-803e-1817a1a4359a@sirena.org.uk>
 <20230629155134.GB2110266@google.com>
 <7987cbbe-55bc-49a9-b63a-7f1906bf5f74@sirena.org.uk>
 <CAL_Jsq+AQrv7EGMtEkB-2cBCvA4mLHuMbyQ=f39yQkYPkvfVww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tDYfe0SN7PXC6vv2"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+AQrv7EGMtEkB-2cBCvA4mLHuMbyQ=f39yQkYPkvfVww@mail.gmail.com>
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


--tDYfe0SN7PXC6vv2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2023 at 11:48:34AM -0600, Rob Herring wrote:
> On Thu, Jun 29, 2023 at 10:00=E2=80=AFAM Mark Brown <broonie@kernel.org> =
wrote:

> > That says it's a bit unusual to use a separate branch with a PR, it
> > doesn't say anything about it being the end of the world to pick up
> > parts of a series that are ready without picking up the whole lot,
> > especially when we're getting to the merge window.

> There's some risk the core part could change affecting the sub
> components after you pick it up, or that the author just abandons
> getting the core part upstream and we're left with a dead driver.

Right, I'm suggesting applying the core part without waiting for every
single leaf driver to be lined up rather than the other way around -
that way the core part is stable and the leaf drivers only have issues
with changes in their subsystems that they'll have anyway even with
waiting.  Leaf drivers can be added on top as they're ready and if
something misses a release then it can go through the subsystem, and if
people do end up wandering off then you've still got whatever did get
merged in case someone else wants to pick things up.

> I'm fine if the sub-components are picked up first (and land in next
> first), but the MFD binding picked up first is a problem usually. And
> that has happened multiple times. Also, it does mean the MFD branch
> will have binding warnings, but that's Lee's problem if he cares
> (probably not).

Linus complained about picking up the subcomponents without the core,
especially if the MFD doesn't end up landing in the same release for
whatever reason (which is fair enough, especially when the MFD does
miss).

--tDYfe0SN7PXC6vv2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSdxmIACgkQJNaLcl1U
h9CHYAf9EbdZGwiGICj8MmjmRrU64GcItZ0n3M0NJGW42FIOBaL27H9fX+gTv3m1
6Qzdry927rL0wBh33M+lEVkcwkAyb2Gbb2o6OzVV1V1aY6nHZEBRZKV0dUa28al7
oB8iwZrP4wjzyPOpMgivmlFrIVH1AgigZU0KUOFhTQ17LE9Wo14k7azm/rPUZVkX
RZgrMDBHif8fjRxdjpGVPSfhPF9MefkHZlTOShYS5OxlKr/rNYqMqZcIAKx8Ii2e
02SCG+B+/IOlTBjIMsYUyGfa47pgMq0CAd0Ukx3HFNcWcC6HOw5bjYzKC92IsS5P
pESqhQQwJV8pV7rVWeSv9rp8ZPrGwQ==
=jwih
-----END PGP SIGNATURE-----

--tDYfe0SN7PXC6vv2--
