Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E8B733860
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjFPSwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjFPSw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:52:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491CF35AD;
        Fri, 16 Jun 2023 11:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7C1362C7B;
        Fri, 16 Jun 2023 18:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81ACCC433C8;
        Fri, 16 Jun 2023 18:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686941544;
        bh=SnILc4tHzLQ9qrWedm4qlSPGM6MMXgUtHYq78NQdHfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iUqw7j+HeuoziYt9RbZCtqc64v+4G8v1edN3GQo4dVrs8cP0pYDBRLyr3g3RMkjL2
         oPprPOtTyghZTTdiSDa7G2/c3Dc/vDfBXIIr5C7a3Cap2ycoLvw/rpuwKN0vq1yjQr
         4B5WRMfgCFIsAo6ll4rl6MEz/eO4YMqlIcVETg58DdNwK0jvm4P++lNzCliGEOKeEf
         QMhuaPfMlWzxplJPj2Pj3O1JIfiIXMMEHMA+PZR2mpRWL+QuboRLHFkzDxBNNnDVOX
         l80E37UZxLBzpUsiZI6MOaQ+i+7FE8qrrRTe4XqojVDupcp2SR2Ud20w+8bYyELRGD
         KR8K0rWKiE0pg==
Date:   Fri, 16 Jun 2023 19:52:18 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFT PATCH 1/2] stmmac: dwmac-loongson: drop useless check for
 compatible fallback
Message-ID: <20230616-activity-shed-be3c13e5ac71@spud>
References: <20230616103127.285608-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IZVYiw4TzhyBwr89"
Content-Disposition: inline
In-Reply-To: <20230616103127.285608-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IZVYiw4TzhyBwr89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2023 at 12:31:26PM +0200, Krzysztof Kozlowski wrote:
> Device binds to proper PCI ID (LOONGSON, 0x7a03), already listed in DTS,
> so checking for some other compatible does not make sense.  It cannot be
> bound to unsupported platform.
>=20
> Drop useless, incorrect (space in between) and undocumented compatible.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Might be worth noting that dropping it is required to allow the
new loongarch dts stuff to be functional with a sane set of compatibles.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--IZVYiw4TzhyBwr89
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIyvYQAKCRB4tDGHoIJi
0g+bAPwIqFpdSVFR1J6wtacOyxZPUWWrlEBqpTPyxDWe+xdBWwEA2ZuQq95BtjsK
MOqgX/xyqqlAFwqAfioKQf/5rfup/gI=
=hq3B
-----END PGP SIGNATURE-----

--IZVYiw4TzhyBwr89--
