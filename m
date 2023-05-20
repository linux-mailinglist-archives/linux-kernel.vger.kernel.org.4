Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78C670A83A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 14:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjETM6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 08:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjETM6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 08:58:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13682116;
        Sat, 20 May 2023 05:58:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FC3760AFF;
        Sat, 20 May 2023 12:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB432C433EF;
        Sat, 20 May 2023 12:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684587496;
        bh=WzLOnS8kzGIbprSfZlyNNfBG8QnbzdeZRhoxDyMoyrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mf2dfG3VsMC1BsJB1sEqHWWCtB10GCwOHoOSVHXJ292fbuU5Kyca+wdtI/bOfoiON
         cp+Po2AmQ4XYhaSjtLDDQIQg1Xw9aWhden/JXJ0GC74U5UP6UXPxyfpelNNgsC9jau
         uVPMXhhnA7pObFVj9S0g1K4q+EZnM3qElYuHPlkBFWypl0qLYDLn5+Sa9l0rs8oiMa
         QBHCs0VqEJmsjwMxrCIz94XlG2IOfnhefks9jVjeVFqcecKtPKchPyYaZY+zU+EuCv
         JpM0xdCUa1h09imlYDaXrh1LpVYcPH+HPnMYVJza9/5i7VOEmoDolPhJKiejTMqPQb
         1itPcuuC9EjFw==
Date:   Sat, 20 May 2023 13:58:10 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ayan Kumar Halder <ayan.kumar.halder@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        geert+renesas@glider.be, mazziesaccount@gmail.com,
        conor.dooley@microchip.com, j@jannau.net, mailingradian@gmail.com,
        me@iskren.info, lpieralisi@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: Add Cortex-R52 to the list of enum
Message-ID: <20230520-apple-hamstring-2118e172cd71@spud>
References: <20230518152730.82954-1-ayan.kumar.halder@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CdlCP2MJ8bAkn4CQ"
Content-Disposition: inline
In-Reply-To: <20230518152730.82954-1-ayan.kumar.halder@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CdlCP2MJ8bAkn4CQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 04:27:30PM +0100, Ayan Kumar Halder wrote:
> As a pre-requisite for porting Xen on a Cortex-R52 based System-on-chip, =
we
> need to add "cortex-r52" to the list of enum.
>=20
> Signed-off-by: Ayan Kumar Halder <ayan.kumar.halder@amd.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--CdlCP2MJ8bAkn4CQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGjD3gAKCRB4tDGHoIJi
0rjPAQCXFLPt8nqDKNxhLc4OHCKpGilLHIsGf9pazW0V6WETfAEAn5HPPzB8bsOn
KnyAv7J5eKStm1VkRXJQIFGwpDAvAQQ=
=n1vn
-----END PGP SIGNATURE-----

--CdlCP2MJ8bAkn4CQ--
