Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7536E230A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjDNMVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjDNMUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:20:48 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF53B77B;
        Fri, 14 Apr 2023 05:20:27 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 256E01C0AB3; Fri, 14 Apr 2023 14:20:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1681474826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3QG2Ko7KVwO1McL5pTu64Lvelxxosscbcu6kRtxeZSM=;
        b=DaJbRUDnHeaNzdV6LD9IOjV9Z6mdmj6Na13QaFgKHkAyrhh/g6IIfg6rklJS5Q9fZOPAb4
        V2EMjIQCrKwTZZfXIgKASTxCy2qCtm/PamPntYD/pY1ngqRv8ExfmvhvUUODxEE5UNFJB9
        STejM0ARASJgtl3sIq/1ZUVGdRHTzuI=
Date:   Fri, 14 Apr 2023 14:20:25 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Wadim Egorov <w.egorov@phytec.de>
Cc:     upstream@lists.phytec.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        riku.voipio@iki.fi, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, lee@kernel.org
Subject: Re: [PATCH v3] dt-bindings: leds: Convert PCA9532 to dtschema
Message-ID: <ZDlFCep0BtFq5KC9@duo.ucw.cz>
References: <20230412140552.451527-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="G7pu2ifmalLGK6gI"
Content-Disposition: inline
In-Reply-To: <20230412140552.451527-1-w.egorov@phytec.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G7pu2ifmalLGK6gI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2023-04-12 16:05:51, Wadim Egorov wrote:
> Convert the PCA9532 LED Dimmer to dtschema.
> While at it, update the example to match recommended node names and
> the link to the product datasheet. Also add GPIO properties since
> the driver allows to use unused pins as GPIOs.
>=20
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>

Acked-by: Pavel Machek <pavel@ucw.cz>

BR,
									Pavel
								=09
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--G7pu2ifmalLGK6gI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZDlFCQAKCRAw5/Bqldv6
8sv1AJsGDdde0FOxmf0c8+IgkPkV9TgF9ACeN0oZuYY0M/0Ua0h2s9J6CfyBbV8=
=RPTT
-----END PGP SIGNATURE-----

--G7pu2ifmalLGK6gI--
