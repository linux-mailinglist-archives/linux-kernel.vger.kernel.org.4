Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE7B715BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjE3KeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjE3Kdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:33:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93B7126;
        Tue, 30 May 2023 03:33:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50E4460C87;
        Tue, 30 May 2023 10:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8455EC433D2;
        Tue, 30 May 2023 10:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685442826;
        bh=Fln3Mnh+80acgeHumKpr0UR+mx8aRBQanCGCmvcj6dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/yWFIcy7CFlAqu0bhA7C9Jz0Ig8CU44fogGfkgP3yLjE0WUmsYsWm+prUozHNWra
         qMmpvQseC/lYmHINYfLFcU1JJ6DjvVzLI1H86rO+cREwqx7lfejrNfTmN0y7WHcfeH
         BCC6OaIBiOeetzisYBi281hXqqYT1tP4ERJRiY4ZvgpRwB5Kyt2RaK3x6cC1pBLbSj
         Fk5b5otjNFDYIG78h7BdI2VjymKekOHKrvM2gVATpabjk8JPuGM/njcEunvntfFCB3
         NvJvr57w1udDStSh3dQjXQXPyoAV+Hgr32k1vZ/V36WbhvCkEXsuVYHdRAZFR8Y31Y
         1vISdIHEiUh6Q==
Date:   Tue, 30 May 2023 11:33:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH v1 2/3] spi: cadence-quadspi: Add clock configuration for
 StarFive JH7110 QSPI
Message-ID: <eb68722b-bcab-4aa1-aa4e-54bfe95ef414@sirena.org.uk>
References: <20230526062529.46747-1-william.qiu@starfivetech.com>
 <20230526062529.46747-3-william.qiu@starfivetech.com>
 <fecc9d6a-022e-49d9-a452-8a63c409ebf3@sirena.org.uk>
 <042c560d-1f36-8e97-3796-7423245592f4@starfivetech.com>
 <86555925-b8dd-29a8-60cd-5c2ff2c1432a@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0IjcTOaConsRfQgO"
Content-Disposition: inline
In-Reply-To: <86555925-b8dd-29a8-60cd-5c2ff2c1432a@starfivetech.com>
X-Cookie: I've read SEVEN MILLION books!!
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0IjcTOaConsRfQgO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 30, 2023 at 10:05:38AM +0800, William Qiu wrote:
> On 2023/5/29 14:44, William Qiu wrote:
> > On 2023/5/26 23:36, Mark Brown wrote:

> >> Nothing ever disables or unprepares this clock as far as I can tell?
> >> Perhaps also consider using the clk_bulk_ APIs.

> > I will add in next version.

> 	Now I want to replace the original devm_clk_get API in the
> driver with devm_clk_bulk_get_all API, which can achieve compatibility,
> but it seems that it is not good for other ip with only one clock, so I
> want to ask about that can I replace it? Or define that inside jh7110?

You could always specify a different array of clocks depending on which
compatible the driver sees, just like you'd conditionally request clocks
individually.

--0IjcTOaConsRfQgO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR10QQACgkQJNaLcl1U
h9A/Pgf+PyO6n0Sai2vAqhannyjrJNScSAcfT759fOsLtw54OcwCbpqbZa77wgiH
PjCzh72zQSXZ0AnoaovIQ+Pfyhm+M8KSWkeP95AhiBCJQr2kbMf6zpMxJaCIwN55
fwXAlxbea49Avm2qG2zwQOnV2b3p8qFPC76xxmHETmN/mx2p9AQFmIHZhuQcRAFM
4B0OCyT+QQ01lSmM9kNL0dttXDSUk1DbdlqGu8LIg3IkbsI2btCTER46cD7I8aI/
daiysOn9wEgibBlWwfDsTwmIVd1d+y1EmB3GBE0ip6StyEjNBYmBF5pEIeIyM34C
QeXxr61Al49hA3BFWJP8vJ+bRq/c4Q==
=tDOm
-----END PGP SIGNATURE-----

--0IjcTOaConsRfQgO--
