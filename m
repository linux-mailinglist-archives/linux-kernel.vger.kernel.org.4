Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3758D733865
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjFPSxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345032AbjFPSw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:52:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49953AA0;
        Fri, 16 Jun 2023 11:52:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FB2D62CE4;
        Fri, 16 Jun 2023 18:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C0BC433C8;
        Fri, 16 Jun 2023 18:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686941575;
        bh=rXAOuleexf719oHBItUk2/1HRdDKOpd0Rj6yJJRrZ0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQptDTGP6Gn5u0IixUqZ1YrSYll9/0BBhDNyEJvj0XDP207w7DKIu1lqUjRY3h37M
         NDtqDTYCvbYbm+ZuqFr2gUpCgyBzb3yhHiHJMnxLmbF4xQ10dku4w4LdXprTP9Y9F/
         JOaCvPMVReWRlrdXG7gjSn/28bkKw59m3f6SQrw28VqOnQ+Mv3H2+vgb4ht5O59MVt
         ZdDiLCFfO38C+BkPtipARwzQEYSoEpDLkfHAhVUI3siXj06po2bpl3az9EUhaIaKro
         1jtf8AqxNos4QbgIptygfz8k4dHPstRcWQh0IJ5K3oCky7TpkvYO79i2lNN0C+ezPt
         KKSySXPPnc3hw==
Date:   Fri, 16 Jun 2023 19:52:49 +0100
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
Subject: Re: [RFT PATCH 2/2] MIPS: dts: loongson: drop incorrect dwmac
 fallback compatible
Message-ID: <20230616-afar-glove-a58d8ea5576e@spud>
References: <20230616103127.285608-1-krzysztof.kozlowski@linaro.org>
 <20230616103127.285608-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v5Uzg8JAkxoXp3OM"
Content-Disposition: inline
In-Reply-To: <20230616103127.285608-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v5Uzg8JAkxoXp3OM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2023 at 12:31:27PM +0200, Krzysztof Kozlowski wrote:
> Device binds to proper PCI ID (LOONGSON, 0x7a03), already listed in DTS,
> so checking for some other compatible does not make sense.  It cannot be
> bound to unsupported platform.
>=20
> Drop useless, incorrect (space in between) and undocumented compatible.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--v5Uzg8JAkxoXp3OM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIyvgQAKCRB4tDGHoIJi
0kPBAP9ge4BqKvCvx5l997dp/dJGtEyDhTnNVPpcziB52eZb+wD/VzpfQUv9mSIf
qO6NQbomXWFOYzC4upKMWuIoMqQ0Egs=
=OY/b
-----END PGP SIGNATURE-----

--v5Uzg8JAkxoXp3OM--
