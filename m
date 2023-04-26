Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CD56EF7AE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 17:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241237AbjDZPVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 11:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjDZPVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 11:21:10 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E373AA5;
        Wed, 26 Apr 2023 08:21:07 -0700 (PDT)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 20AD7E0007;
        Wed, 26 Apr 2023 15:21:02 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCHv7 00/11] Introduce RK806 Support
Date:   Wed, 26 Apr 2023 17:20:52 +0200
Message-ID: <4046459.irdbgypaU6@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20230307153617.643260-1-sebastian.reichel@collabora.com>
References: <20230307153617.643260-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15156774.uLZWGnKmhe";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart15156774.uLZWGnKmhe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCHv7 00/11] Introduce RK806 Support
Date: Wed, 26 Apr 2023 17:20:52 +0200
Message-ID: <4046459.irdbgypaU6@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20230307153617.643260-1-sebastian.reichel@collabora.com>
References: <20230307153617.643260-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0

On Tuesday, 7 March 2023 16:36:06 CEST Sebastian Reichel wrote:
> The Rockchip RK3588 Evaluation Boards as well as the Rock 5
> boards and probably most other RK3588 boards use SPI connected
> RK806 PMICs. Downstream this is handled by a new driver, but
> apart from being SPI connected this chip is quite similar to
> the other Rockchip PMICs (and RK806 is promoted to also support
> I2C). Thus this series instead updates the RK808 driver(s).

I don't know if it's relevant or useful, but I tested whether this patch set 
would cause a regression on the Rock64 (rk3328), Quartz64 Model A and Quartz64 
Model B (both rk3566) and I can say that it does NOT cause a regression.

If it is relevant or useful, feel free to add my 
Tested-by: Diederik de Haas <didi.debian@cknow.org>
--nextPart15156774.uLZWGnKmhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZElBVAAKCRDXblvOeH7b
bpGeAQDVEucvNJq97OpS0XFTOdR/bKYyYfigTND6d8xdEy8dwQEAlXAQCwktcor7
LINeGsc3EDltinvqJVhMSBCpC5sPkAI=
=AyOI
-----END PGP SIGNATURE-----

--nextPart15156774.uLZWGnKmhe--



