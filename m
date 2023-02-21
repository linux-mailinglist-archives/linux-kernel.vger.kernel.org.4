Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BB969E57E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjBUREf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbjBUREd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:04:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091AA469B;
        Tue, 21 Feb 2023 09:04:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66A41B80E96;
        Tue, 21 Feb 2023 17:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9B2C433EF;
        Tue, 21 Feb 2023 17:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676999038;
        bh=Qnh0EERUxpKQwR06nwCqwR4x3GBsbnbkgHVMUazIAAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NqqMNO1k/8gwXWzWHds8Y5Po1S3dNJqT9piZAYj/t3hMItxadAHciBBsvngEh8wfF
         K4zdR070NAa0r5sMuo4yZmbGwoMz5T25KrNJZQzpZ0FaG1NhsuzkrWA9IvlVz3c8+w
         YO6SwRMYwu52FkDDaoj4P06YI9dPtnqgO89sxQw4SDO4p8fUWxBLPYGV5RfxWVn1ju
         I+JHmtzqn4x2qjpiauoG4yDJnVoLOVv49Yln7YYYC4NCLoK3i+JPceMY1F3xAjiRyd
         70hCQVYEcXSxyNKQ2xND2n5eCo6olbo6+ubQq21e3VB9hIHk+vg2PE530SxdHHR41Q
         zrH/8dRfRbmOQ==
Date:   Tue, 21 Feb 2023 17:03:52 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/19] riscv: dts: starfive: Add initial StarFive
 JH7110 device tree
Message-ID: <Y/T5eL4s8FSlbgQh@spud>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-18-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zV97GbCkITlnNHaF"
Content-Disposition: inline
In-Reply-To: <20230221024645.127922-18-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zV97GbCkITlnNHaF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 21, 2023 at 10:46:43AM +0800, Hal Feng wrote:

> +		S7_0: cpu@0 {
> +			compatible = "sifive,s7", "riscv";
> +			reg = <0>;
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <64>;
> +			d-cache-size = <8192>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <40>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <64>;
> +			i-cache-size = <16384>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <40>;
> +			mmu-type = "riscv,sv39";
> +			next-level-cache = <&ccache>;
> +			riscv,isa = "rv64imac_zicsr_zba_zbb";

I still think that adding just zicsr here is pointless. If you're going
to be specific, why not also mention that you have zifencei too?

> +			tlb-split;
> +			status = "disabled";
> +
> +			cpu0_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};

Rest of this looks fine to me though, thanks for adding the s7
compatible and zba/zbb :)


--zV97GbCkITlnNHaF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/T5eAAKCRB4tDGHoIJi
0krCAP0WvomVWVTumjltZETdZGiWXtffg+jVhmIVSy7BtSwvZAD/erv0jRnX/bvF
4+QnC46U7EwjU++x1eOoHA1kJnAbNgE=
=k2Zd
-----END PGP SIGNATURE-----

--zV97GbCkITlnNHaF--
