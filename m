Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF39706FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjEQRpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEQRpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:45:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3F8AD19;
        Wed, 17 May 2023 10:45:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4416649C8;
        Wed, 17 May 2023 17:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207C8C433EF;
        Wed, 17 May 2023 17:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684345482;
        bh=JOfsYcy6OILmWF1TSrhXtQke2UV+wOh//Fy9RsfiGWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=indDM2Rlfudqt6j62VjdMxZzpXumKBfrNvghyBQNN2jSM+zibpbXMl/sw/VBAp6bV
         DsabAfaSdeqCj3zrYqkpee4AhZGn1RgIj/cj+xrZH/SjetyspXDOxmQltVEmcE0Dkg
         qPgknrGAOTMGMhNpvIIp8zQYCw1FzJa7eyDSCUPujZm9TGj9MBnFfjD5A9JT+AeTMe
         tt5YyxpI6VyupFlmFCo0DwrhK3kclMT93Cytwvv0n/YwY2f3xdpYxtE/hSkiRYLsxN
         RtKhZgLyCAp0NeXsBau1e1fCnGt2NvQDSOljFC8RER+iBLSvMoyqPMrplG6TdC02JY
         1jIf5mlLI528w==
Date:   Wed, 17 May 2023 18:44:37 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] dt-bindings: rtc: Add Mstar SSD20xD RTC devicetree
 bindings documentation
Message-ID: <20230517-undertone-revolver-26b42b888b12@spud>
References: <20230517144144.365631-1-romain.perier@gmail.com>
 <20230517144144.365631-3-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hmRYluP4qmwWGXld"
Content-Disposition: inline
In-Reply-To: <20230517144144.365631-3-romain.perier@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hmRYluP4qmwWGXld
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Romain,

On Wed, May 17, 2023 at 04:41:43PM +0200, Romain Perier wrote:
> This adds the documentation for the devicetree bindings of the Mstar
> SSD20xD RTC driver.

Bindings describe hardware, not the driver ;)

>=20
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  .../bindings/rtc/mstar,ssd20xd-rtc.yaml       | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/mstar,ssd20xd-r=
tc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/rtc/mstar,ssd20xd-rtc.yaml=
 b/Documentation/devicetree/bindings/rtc/mstar,ssd20xd-rtc.yaml
> new file mode 100644
> index 000000000000..2acd86cce69f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/mstar,ssd20xd-rtc.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/mstar,ssd20xd-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mstar SSD20xD RTC
> +
> +allOf:
> +  - $ref: rtc.yaml#
> +
> +maintainers:
> +  - Daniel Palmer <daniel@0x0f.com>
> +  - Romain Perier <romain.perier@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mstar,ssd20xd-rtc

Is this x a wildcard?
In general, having a specific compatible is preferred, and if there are
other models that are compatible we can list several "fall back" to the
most specific one implemented in a driver.

Thanks,
Conor.

--hmRYluP4qmwWGXld
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGUShQAKCRB4tDGHoIJi
0km7AQC00rlvTSIOtUDQkDas5b4Yqy0qAep7M88KUORcbm0rfgEA1nshhvHT/Kc6
1ep8p5dRCxNjgu5rrZfM59sLfODveAI=
=roYR
-----END PGP SIGNATURE-----

--hmRYluP4qmwWGXld--
