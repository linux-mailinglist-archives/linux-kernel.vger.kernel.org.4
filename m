Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FB2711933
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241650AbjEYVeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjEYVeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:34:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3025099;
        Thu, 25 May 2023 14:34:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1ACB64B51;
        Thu, 25 May 2023 21:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBA4C433EF;
        Thu, 25 May 2023 21:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685050457;
        bh=zZK1RRwMzH2sbsee7VnC7rlgcun9B4/SN/dI3FKVvrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sYy8VE1VD0cAgEQuQim7zpsjY9TurkTcJPM8V//GYjopKthjG7swTE5W5MfBkiymv
         gptEA5LzE3IQ95cBxZ2YaS+ouWHeojSMRaBTKoUhsGIXRsxsxPjsX6TPztQfMhMldh
         SuTIH5cGrlLwRkrvhRW0H4JvwkVdYq4GVx9hTsSWN0X+ERFX/OkNNQPf1/WVd/JLgX
         /AFo9muWJpPvbUiV5Vkz+O+/FB7GMsA1yaEPll0FSZXSUItNyIjw43FnpK+hMSGlrj
         gSxpoHHqT3QTPfco7ev8HFXnGS/mrM0GTn+0tO7TzsMQgFzKyLBSEnWqD1V1v0qzTR
         X5t+2G3DdOoZw==
Date:   Thu, 25 May 2023 22:34:10 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: Re: [PATCH v6 5/7] dt-bindings: usb: Add StarFive JH7110 USB
 controller
Message-ID: <20230525-shopper-handbrake-27fc06aede32@spud>
References: <20230518112750.57924-1-minda.chen@starfivetech.com>
 <20230518112750.57924-6-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SLOnlnkMNKq6BWyy"
Content-Disposition: inline
In-Reply-To: <20230518112750.57924-6-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLOnlnkMNKq6BWyy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 07:27:48PM +0800, Minda Chen wrote:
> StarFive JH7110 platforms USB have a wrapper module around
> the Cadence USBSS-DRD controller. Add binding information doc
> for that.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Peter Chen <peter.chen@kernel.org>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../bindings/usb/starfive,jh7110-usb.yaml     | 115 ++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/starfive,jh7110=
-usb.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/usb/starfive,jh7110-usb.ya=
ml b/Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
> new file mode 100644
> index 000000000000..24aa9c10d6ab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/starfive,jh7110-usb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 wrapper module for the Cadence USBSS-DRD controll=
er

I think you told Krzysztof you'd rename this to "StarFive JH7110 Cadence
USBSS-DRD SoC controller"?

Otherwise, it looks like all the stuff from him and Rob have been sorted
out, so other than $title this is
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor..

--SLOnlnkMNKq6BWyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG/UUgAKCRB4tDGHoIJi
0v75AP9K+Svm5FyZzmMv+llB8XO317ghvBO5MrADfge2KP6pPwEAl0bZpPNFfw8m
AK1S29TZeiBbhbcxD8KECfWuk1118AQ=
=3/eV
-----END PGP SIGNATURE-----

--SLOnlnkMNKq6BWyy--
