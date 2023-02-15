Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D76697CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjBONDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjBONDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:03:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9101C5AF;
        Wed, 15 Feb 2023 05:03:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B37961BBA;
        Wed, 15 Feb 2023 13:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D457FC433EF;
        Wed, 15 Feb 2023 13:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676466214;
        bh=uNeSxlNUerIBJp/2E8cVJBa11CchRCvR6876KB8SaVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oj+0wMYuhWy8fBDfMQhmdEas1aKKh+bHsrac1zNoydeuVOUFtLO/Ap++LCKiKvIrB
         TsWX6Dg6M5hPiH6LRCXKslPp9+oFVj1xLnV7JsHidbPCXY6vzRKUj36/U7MzbrjN7Z
         DtU+UYY1NBCBTGM7IvBKSQ0EhRXrUAynHD1CTVk7yKNG2N+9KXoQwYKkqVq5sVg0iK
         TrSOMLL8Kaa5Uu/MKqPIL1AnplO24G7EwhHTpBErFg7PxvbfiHB3C+7YicaDKkZwHx
         hl3gLCMLA95WMZfv2TLkT6OzvhSJEWNvR3ZYuFmnwQ1Dl+kT51lskEGpD3uSM+J5Pb
         MBeH5fL66i4GA==
Date:   Wed, 15 Feb 2023 13:03:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang@richtek.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, u0084500@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add bindings for Richtek
 RT5739
Message-ID: <Y+zYIyaWt1tQcUt7@sirena.org.uk>
References: <1676426457-1389-1-git-send-email-cy_huang@richtek.com>
 <1676426457-1389-2-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Hi4zuMaYk07hpsnT"
Content-Disposition: inline
In-Reply-To: <1676426457-1389-2-git-send-email-cy_huang@richtek.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Hi4zuMaYk07hpsnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 15, 2023 at 10:00:56AM +0800, cy_huang@richtek.com wrote:

> +  richtek,vsel-active-high:
> +    description: |
> +      If property is present, use the 'VSEL1' register group for buck control.
> +      Else, use the 'VSEL0' register group. This depends on external hardware
> +      'VSEL' pin connecton.
> +    type: boolean

I would expect this to be GPIO controlled rather than fixed in
the design, at least for some systems?  The name suggests it's
supposed to control the polarity of a GPIO too.  Sadly we don't
really have good infrastructure for fixed GPIOs AFAIK...  ideally
this would be a GPIO and then if we need to hold it high then
there would be some binding we could connect to the GPIO that
says that.  We don't have that though so for now a fixed property
might be OK.

--Hi4zuMaYk07hpsnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPs2CIACgkQJNaLcl1U
h9AtKgf/XlyM1GvFkjJurb2mJomJyyUrwIiPKnK3wPdVOiQRXoTqtOm2gtnzWpKd
bmzHNfC/j+wEk+IhBoH8V38NNU/qsTMdJuerHk/0MU7xmEu6hY1A1uzBPlszjCtj
VEeiA7Bl0CDyhDz35/MVokIMmfkfCD4XWnVUvIXLDIWu5YFESxdyiZwGKlM1IrNb
cWFhjHF9aQ28aZUfxyI8d6dGXaA2CbAAEPOyYT32Uzc1S81PLYbvxhQDOPYVvTqQ
5yohkR0PvhqreklJiVLB47LYptQq4StNasbINAgVwWN4ZyEAc1q459VR33qQAI8c
6UsDoyMRgDGnbE/q8wO50q1we0hwMw==
=QkTn
-----END PGP SIGNATURE-----

--Hi4zuMaYk07hpsnT--
