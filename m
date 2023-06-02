Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B9D720806
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbjFBQ7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbjFBQ7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:59:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26D9C0;
        Fri,  2 Jun 2023 09:59:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8335D6392F;
        Fri,  2 Jun 2023 16:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFE3C433EF;
        Fri,  2 Jun 2023 16:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685725175;
        bh=ZWc5cZxtTS+a1oL1ydW5dbNhJFyKN9X07jEjL3vo4F0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yr1ixOHRpeMSDtrK7hRUT1s/0/qLRE2e3isq8Mfa3h2oRl0Yvt80e8hhTMByt+lNs
         0rVtjxaj6u0ZMI00E1cEVmq5Fh/Erh65RD47dR8e9CVp232dlueC/mcy0NfTqa9Q8j
         QtacFTzHjCSq9Cfmhke84byQZ5VEPFgsPMMQqx32TkjNwezziZCKDy3xg1r2qtOAG5
         6KIbWxykc+s4dN+rEYRKyXLTw4dexOfSy2rd94UX+P0IqBoQqL4xXzyIpEZvAIRiKQ
         yiV8ighGjFeAewoOGgQGegtHeDatgmDsr89MmcaSuWOP5J4EGGfubZp3u+DMuO0jQ+
         sEB3gCeVKXWYg==
Date:   Fri, 2 Jun 2023 17:59:29 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        yanhong.wang@starfivetech.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 1/7] dt-bindings: clock: Add StarFive JH7110 PLL clock
 generator
Message-ID: <20230602-wise-entomb-975a2474d97a@spud>
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
 <20230512022036.97987-2-xingyu.wu@starfivetech.com>
 <20230519135733.GA10188@lst.de>
 <20230519-smokeless-guileless-2a71cae06509@wendy>
 <df43411e-8982-74f5-6148-e7281c37dada@starfivetech.com>
 <20230602183922.649b8e88@blackhole.lan>
 <20230602-drained-wheat-b6c5ea009f16@spud>
 <20230602165713.GA27915@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gTOiipfmNTlMqeKP"
Content-Disposition: inline
In-Reply-To: <20230602165713.GA27915@lst.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gTOiipfmNTlMqeKP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2023 at 06:57:13PM +0200, Torsten Duwe wrote:
> On Fri, Jun 02, 2023 at 05:43:25PM +0100, Conor Dooley wrote:
> > >=20
> > > Can you _please_ point me at that "PLL driver" "in Linux" ?
> >=20
> > It's patch 2 in this series:
> > https://lore.kernel.org/linux-riscv/20230512022036.97987-1-xingyu.wu@st=
arfivetech.com/T/#m4b2d74c36b3bb961a1187ec5cda1a0a0de875f0e
> >=20
> Unfortunately, it's not, AFAICS. I'm looking for the driver that
> will control the PLLs' parameters, grepping for "pll" should yield
> results, to start with. The thing should act on the SYS_SYSCON iomem,
> at 0x13030000. Ideally, a DT node should point it there...

The driver binds against a child node of the syscon @ 1303_0000:
https://lore.kernel.org/linux-riscv/20230512022036.97987-1-xingyu.wu@starfi=
vetech.com/T/#m882de9210850eb6f871cafc3418f3202ba915de8

Am I missing something?

Cheers,
Conor.

--gTOiipfmNTlMqeKP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHof8QAKCRB4tDGHoIJi
0iZeAP94HgEHJBXSFHCDIA1ukvah1gLeQDcWwDzLZAjguwUY7QEAm10ukzpdoakk
IyPtDFhAnVt38/uZdD4pShSOPC8IUg4=
=9Kxn
-----END PGP SIGNATURE-----

--gTOiipfmNTlMqeKP--
