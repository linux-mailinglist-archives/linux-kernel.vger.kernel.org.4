Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A855738A90
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjFUQMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjFUQMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:12:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8741981;
        Wed, 21 Jun 2023 09:12:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEE35615D4;
        Wed, 21 Jun 2023 16:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F9BC433C8;
        Wed, 21 Jun 2023 16:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687363946;
        bh=F6AWTtJIxksfHftPRfXL8xSdr4W3uoaros+jmqwGdq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYwWn4Yej83L0Ozvd2Lkm4OKqpaUV5ILjyBa57r0tigAcNRaod1vQaTBv/5Qu2vdV
         H2KuOAbcz4v1xfjU0S6nXg+WcMPr5N6pPDsOnWotoM2yTqAqIe7IaXryPbI3S5Keg6
         g+OiQGHvh2t07cRjUfgsT14zlyghI6hr3XTAU2wvaT3qXHHXCVrI5tBmWwuw1wCw2R
         xlJwXqIsBWcO9kvBOZXWFRLFXClJ/S3e/2Qf2fqG5RJZXaJeaCut3vUen9xmzrON4h
         Fl6uKmH52wx+Sin+NrmApBVm+w1U3GrTVv5D05qCbDIunnd8Bxi+W/OeyYBPCmgbDO
         6TtTVB41yCT9Q==
Date:   Wed, 21 Jun 2023 17:12:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-rockchip@lists.infradead.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        kernel@pengutronix.de, Vincent Legoll <vincent.legoll@gmail.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 22/26] dt-bindings: devfreq: event: rockchip,dfi: Add
 rk3588 support
Message-ID: <20230621-poach-amniotic-2eeb858356c8@spud>
References: <20230616062101.601837-1-s.hauer@pengutronix.de>
 <20230616062101.601837-23-s.hauer@pengutronix.de>
 <20230616-swimwear-prewar-f9dce761d2ec@spud>
 <20230621074159.GN18491@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qqJ18BUnkd3ehpaa"
Content-Disposition: inline
In-Reply-To: <20230621074159.GN18491@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qqJ18BUnkd3ehpaa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 09:41:59AM +0200, Sascha Hauer wrote:
> On Fri, Jun 16, 2023 at 08:05:33PM +0100, Conor Dooley wrote:
> > On Fri, Jun 16, 2023 at 08:20:57AM +0200, Sascha Hauer wrote:
> > > This adds rockchip,rk3588-dfi to the list of compatibles. Unlike eali=
er
> > > SoCs the rk3588 has four interrupts (one for each channel) instead of
> > > only one, so increase the number of allowed interrupts to four.
> > >=20
> > > Link: https://lore.kernel.org/r/20230524083153.2046084-23-s.hauer@pen=
gutronix.de
> >=20
> > It's unclear what the point of this link is.
>=20
> The link was added automatically by b4. I re-applied the series from the
> last one I sent just to be sure that I base my work for the new series
> on the one I sent last time. I didn't remember that b4 adds these links,
> I should have disabled that option.

Ah, I see.

> > My comment still stands about whether only the new compatible should be
> > permitted to have more than one interrupt. I don't recall a response to
> > that question on the last version.
>=20
> My personal take on this is that such additions make the bindings more
> readable by machines, but less by humans. That's why I don't have enough
> intrinsic motivation to make this change.

> Anyway, if you insist then I'll make it for the next round.

No, I don't insist. I just wanted to not be ignored.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--qqJ18BUnkd3ehpaa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJMhZAAKCRB4tDGHoIJi
0glxAP95A4qpgG0Kx3VK40STEaGwGLEnpx8i+Bqq6PpR06Bp+AD/VUNaT9byFCmy
eld/0kBNSGMr59V6XwdGhIG5VMo5ZQk=
=FJnF
-----END PGP SIGNATURE-----

--qqJ18BUnkd3ehpaa--
