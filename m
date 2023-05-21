Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7A470AFF2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 21:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjEUTdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 15:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjEUTdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 15:33:09 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEB2E0;
        Sun, 21 May 2023 12:33:07 -0700 (PDT)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 6D3CA240002;
        Sun, 21 May 2023 19:33:00 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Jacob Chen <jacob-chen@iotwrt.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND 0/2] media: rockchip: rga: Add rk3568 support
Date:   Sun, 21 May 2023 21:32:51 +0200
Message-ID: <2386524.2IynHR6iFi@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <168466589373.900480.8086350880534437090.b4-ty@sntech.de>
References: <20230119-rk3568-rga-v1-0-43d4d14365e6@pengutronix.de>
 <168466589373.900480.8086350880534437090.b4-ty@sntech.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2141483.da5uFje5fu";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2141483.da5uFje5fu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Date: Sun, 21 May 2023 21:32:51 +0200
Message-ID: <2386524.2IynHR6iFi@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <168466589373.900480.8086350880534437090.b4-ty@sntech.de>
MIME-Version: 1.0

On Sunday, 21 May 2023 12:44:58 CEST Heiko Stuebner wrote:
> On Fri, 20 Jan 2023 10:14:21 +0100, Michael Tretter wrote:
> > The RGA2 on the Rockchip rk3568 is the same core as the RGA2 on the
> > Rockchip rk3288.
> > 
> > This series adds the necessary device tree binding and node in the device
> > tree to enable the RGA2 on the Rockchip rk3568.
> > 
> > I tested the driver with the GStreamer v4l2convert element on a Rock3
> > Model A board.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/2] media: dt-bindings: media: rockchip-rga: add rockchip,rk3568-rga
>       commit: 9b12ceb5a80d1fb45d293265de100e33b5843943
> [2/2] arm64: dts: rockchip: Add RGA2 support to rk356x
>       commit: 0c3391f8bb06b744df521651534cd99e3d77e0a8

https://lore.kernel.org/all/TY3P286MB26115F60D273E840D36A610598CA9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM/

indicated that there was a problem with device >= 4GB (RAM?):
> Since we have the over-4GB problem now, should we mark this problem as a
> TODO or something?

I thought that was the reason that these patches weren't picked up before?

I have no insight into this problem, so I can't comment on the technical
aspects, but I had made a note for myself 'locally' about it.
--nextPart2141483.da5uFje5fu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZGpx4wAKCRDXblvOeH7b
brDNAQCQRk0uL8qr7RMJLjC56GL9KRq/TtmKBlnQUaSGchIxVQEAxlugcLBQ9jQf
I7iu5nMhGOwfgEn3VBfHPtIgbDurnQk=
=qohm
-----END PGP SIGNATURE-----

--nextPart2141483.da5uFje5fu--



