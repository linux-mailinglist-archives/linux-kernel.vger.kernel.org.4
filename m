Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB06E6647F8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjAJSAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbjAJR7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:59:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EAD13D58;
        Tue, 10 Jan 2023 09:59:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43903B818FE;
        Tue, 10 Jan 2023 17:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F4DC433EF;
        Tue, 10 Jan 2023 17:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673373555;
        bh=fV4tgwEHUZrqCe8pSCxTpwxja8PdnJ49yErnHxLMzZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ux0gIXcb32eZQ+VJkQV5YzTdErZ+iLCv6Ztzdv6boC99j5YoS/U7ue1guyDP/o77m
         6/aspDHnxPBtHxFXAx3V+Se1yvRFnheRvYP8mCOpSlEbc6vDTLk6kampkQX0MiN9tc
         7PTGr/C3EM4r3SV6PbeCTchppQ0oU9nhxn09WwWP+KgADS5Pvbo8O6QdtxtYSPxfKV
         n//4QriXlHuBVyzcmFALTvMjiZoGz/5IUW1bOORbe8zLyUCG4+CEwR90xM53wXRIbO
         t7PyqOCkujfmzDWWO9avNYQeP5Rv2P7ijpHcN1qylVteFwouLLYwMk2S6KTQUOb2ev
         k24XLRuH8Vzlg==
Date:   Tue, 10 Jan 2023 17:59:09 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] riscv: dts: starfive: Add StarFive JH7110
 VisionFive 2 board device tree
Message-ID: <Y72nbfJxYdO2AojI@spud>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-8-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Lvt1uqxBssUo8Paq"
Content-Disposition: inline
In-Reply-To: <20221220011247.35560-8-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Lvt1uqxBssUo8Paq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 20, 2022 at 09:12:47AM +0800, Hal Feng wrote:

> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};

So I think this is wrong, and the stdout-path should be uart3 instead.
Per the QSG [0], GPIO5/6 are the suggested UART Tx/Rx to use.
This appears to map to uart3 rather than uart0.
FWIW, uart3 is also the stdout-path for the v1, see:
arch/riscv/boot/dts/starfive/jh7100-common.dtsi

At least, that change is what I needed to do in order to use the
JH7110_VisionFive2_upstream branch, AFAICT matches what you've got in
this series.

Thanks,
Conor.

0 - https://doc-en.rvspace.org/VisionFive2/PDF/VisionFive2_QSG.pdf

--Lvt1uqxBssUo8Paq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY72nbQAKCRB4tDGHoIJi
0qOpAP0XaPuoCjnjBd2DOhVJt9puz02Zx9VxaQSIpQ27IoXGygEAmbwyT809PgL7
chpp1xSSsvRQMEhF7XLXxr6OXPz3LwQ=
=ILQb
-----END PGP SIGNATURE-----

--Lvt1uqxBssUo8Paq--
