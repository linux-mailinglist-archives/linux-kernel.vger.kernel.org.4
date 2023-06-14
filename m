Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB917305F3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbjFNRUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238639AbjFNRTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:19:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037E4269F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:19:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DEEA644FA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 17:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BE5C433C8;
        Wed, 14 Jun 2023 17:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686763183;
        bh=B2y9bmcP7tpJWy0pHMIaMfPhf9VB+e1w/X1rsmerLtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XvilYZZrW59zpQNUEiKO/ts0AhzQwlA87YbLoIm7nwzGbaW2Zw1Cj0aHttF2Bp/EC
         IqH35PL/CVgm2KNXPLY2T58EvKiAzn8BTzp8S67jBT5VASlcpMOCQjiwPkWqSrIbmn
         uzkM5VBZTdnE4/Qds/1J+FsFiF/x82YzLyD+m92GyJNdta/uZnXdHXEwxr/u+tSf5e
         /b7lTcntmN6eJaWGjTJI1uFx31nQUtK0iMpFre+uEGZbO5kHxNjTW6PjPCXsF+fnAk
         VYswQGxciZYAljg6vy0gNBabxpwAxRmK2589n2aY1arar3i0cjKtbFn2X9rS5FxStE
         AFf8Raa/cvzJQ==
Date:   Wed, 14 Jun 2023 18:19:39 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>
Cc:     Rob Herring <robh@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 0/8] ARM: dts: stm32: lxa-tac: add Linux Automation
 GmbH TAC
Message-ID: <20230614-dandelion-dyslexic-1c24772d69cd@spud>
References: <20230614123222.4167460-1-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eyeSLLXa+gNciXe3"
Content-Disposition: inline
In-Reply-To: <20230614123222.4167460-1-l.goehrs@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eyeSLLXa+gNciXe3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2023 at 02:32:14PM +0200, Leonard G=F6hrs wrote:

>   - Split addition of shineworld lh133k compatible into separate
>     vendor-prefix patch and panel-mipi-dbi-spi.yaml patch as suggested
>     by Conor Dooley.
>     Did not carry over the Reviewed-by: Rob Herring <robh@kernel.org>
>     from the original patch due to the split.

FWIW, if Rob was happy with it as-was, he probably overrules me!
Although, clearly no reason to revert back to how it was now.

--eyeSLLXa+gNciXe3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIn2qwAKCRB4tDGHoIJi
0oFyAP48Sq4qwNGCGRGv7Goo22IX7HgqhJiIQLrJ71dX2ZvcoQD9FQOSwxysC1Rd
m+tdYhYOnfdfPijqPdNRjhazLhS1Jgw=
=J+eD
-----END PGP SIGNATURE-----

--eyeSLLXa+gNciXe3--
