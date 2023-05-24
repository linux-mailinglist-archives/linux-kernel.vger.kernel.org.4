Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0A070FE73
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbjEXTVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjEXTU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:20:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7316719C;
        Wed, 24 May 2023 12:20:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5EA964051;
        Wed, 24 May 2023 19:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E35C4339B;
        Wed, 24 May 2023 19:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684956042;
        bh=0BW26BnyDlJYQd0cf5O7OSFXRRUfAR0G9SM1qM9yyTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mcxD97bomJT9rSCmKwRlKSYRPQjHECUIA6iMAvlGizL58/JHRYfDN99YPYRxM2/F2
         VdJ9psGQrqcvjY57x9HsPBGYfGv6x412zeJpGL+t3gquvnG16nmfXmU4BU9qqpQeEb
         s2QkJYozMyi7hiCdz07OW6CFKaVxfvTg67kKLMFzH57VYfwXCj4Lvx7EDg6xYIxNLq
         ChzeWy18OVq78AS27qMPKFby+Toinzm8J9ohtTxM9lh0f+vvMaRklu040P6zutGYH2
         JMnRaIYA9ffOVUIXPQ2x7jf/pA5ToI71P1eJpPx+4NFGq/OExCDfr0u9NXHwnCSAJs
         X34cCiXzXhuPw==
Date:   Wed, 24 May 2023 20:20:37 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, sre@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: power: reset:
 atmel,at91sam9260-shdwc: convert to yaml
Message-ID: <20230524-egging-juicy-c9fc153c6158@spud>
References: <20230524123528.439082-1-claudiu.beznea@microchip.com>
 <20230524123528.439082-3-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tsyUzQT+iaIPUW8F"
Content-Disposition: inline
In-Reply-To: <20230524123528.439082-3-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tsyUzQT+iaIPUW8F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 03:35:26PM +0300, Claudiu Beznea wrote:
> Convert Atmel shutdown controller to YAML.
>=20

Same here. Modulo thinking Rob should Ack it because I think this will
re-license the txt binding,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--tsyUzQT+iaIPUW8F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG5jhQAKCRB4tDGHoIJi
0rS2AP4hNlHQpXjR75LYUtdIe5B7WSZ0V7bVh0ogZi91GoOFWQD/XbM3dxMz1Put
DckCzTBWP6f5Rp462l5iem+3dlkDXAo=
=rx/y
-----END PGP SIGNATURE-----

--tsyUzQT+iaIPUW8F--
