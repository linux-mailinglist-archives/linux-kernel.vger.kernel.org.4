Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725E37441E6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjF3SIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjF3SI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:08:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2FE19C;
        Fri, 30 Jun 2023 11:08:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32DA0617AC;
        Fri, 30 Jun 2023 18:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD727C433C0;
        Fri, 30 Jun 2023 18:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688148506;
        bh=7RgNICGUd57kbxZR+bdP1T3AWfyjL5MDZIC0ZkQs8bA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OHHHqacKZysWHbeof64j+ADM+POnBhML0hQ1kwQA+eigj6h3bmtNG8yZBdtlFOnJL
         74eJd5B9/flzIVC6UPWbFuVqFLJxS3mY1fT6GTIeOKc1FiLhtbptXAb52tBBzFrbh9
         iHS9sUtaTVgH4R7mlKBgSEveR/q4KGVXcOkTwDHZJhFMAn7KupSLpKsBFsU0Q9ONuN
         ukOk2NnBVYOKnbS2BMg9jfoP/TDKeJjrlZGw/YswtDPak35tFynIfFiq4TnI5KUYoh
         LLnnZQORjLWhelYVIOjo700vN5EJCdrEsBoN4xwVGcDV/KqqcUE5RbMb76oC0Onb30
         8GLYRenfsW4Qw==
Date:   Fri, 30 Jun 2023 19:08:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 1/9] dt-bindings: clk: g12a-clkc: add CTS_ENCL clock
 ids
Message-ID: <20230630-unwashed-gothic-36201c97fa42@spud>
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v6-0-fd2ac9845472@linaro.org>
 <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v6-1-fd2ac9845472@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QFQMml9cy3EPdzM8"
Content-Disposition: inline
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v6-1-fd2ac9845472@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QFQMml9cy3EPdzM8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2023 at 06:29:08PM +0200, Neil Armstrong wrote:
> Add new CLK ids for the CTS_ENCL and CTS_ENCL_SEL clocks
> on G12A compatible SoCs.
>=20
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--QFQMml9cy3EPdzM8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ8aFAAKCRB4tDGHoIJi
0pMdAP470puPbIEhFPzVh9r1odFpTvbwxCMSXUJcJ+ePo6UYXgEAt2GMNyLnDczi
4C+3TomZUq+P+WQKKiLXT9UKwHFlOAQ=
=hMX/
-----END PGP SIGNATURE-----

--QFQMml9cy3EPdzM8--
