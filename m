Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112936F9BF9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 23:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjEGVfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 17:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjEGVfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 17:35:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FB32113;
        Sun,  7 May 2023 14:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9711A61D22;
        Sun,  7 May 2023 21:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA98C4339C;
        Sun,  7 May 2023 21:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683495318;
        bh=NdcD+9ij+DOpkLob2FE8gAcGrtbnol7u+fW5Ls8BxTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nhKKmRi0ny4VVMdAikGPgyZsaYig2yu7iCJGXn81dqF1HzqjVGMXGHo2sqgYUgSSb
         sf3Se+AS0s+mR+vmq6DOv37rsTClJHsafIAJATyKXCC6X6JZVUmBFR92AjmgsY1u4Q
         4WlBkVXcgkyNGM4xF2Z/xvdimWNiBpeoHFdrA6aDRL2R/IXYpug1pQs4/2tJ86rMGn
         Q8l4z+KXPU7Ip/XJqW/xCyUswiWGtpBA467TyQHD23/tbvxVBxj5KX9G8eA7yK4CT/
         3eHz4m5RXOmpDvmfjlqIOL3wFVUqGGlivBkdAOLeWWLG6S2R1GluXQcKYcF7aIhuwZ
         qP5qm4yBrDw+A==
Date:   Sun, 7 May 2023 22:35:12 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        heiko@sntech.de
Subject: Re: [PATCH 3/5] riscv: dts: add initial T-HEAD light SoC device tree
Message-ID: <20230507-calamari-gentleman-bbe62af06f92@spud>
References: <20230507182304.2934-1-jszhang@kernel.org>
 <20230507182304.2934-4-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OKce/XdTtjQB3lJP"
Content-Disposition: inline
In-Reply-To: <20230507182304.2934-4-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OKce/XdTtjQB3lJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Jisheng,

On Mon, May 08, 2023 at 02:23:02AM +0800, Jisheng Zhang wrote:

> +		c910_0: cpu@0 {
> +			compatible = "thead,c910", "riscv";
> +			device_type = "cpu";
> +			riscv,isa = "rv64imafdc";

Does this support more than "rv64imafdc"?
I assume there's some _xtheadfoo extensions that it does support,
although I am not sure how we are proceeding with those - Heiko might
have a more nuanced take.

> +		reset: reset-sample {
> +			compatible = "thead,reset-sample";

What is a "reset-sample"?

> +			entry-reg = <0xff 0xff019050>;
> +			entry-cnt = <4>;
> +			control-reg = <0xff 0xff015004>;
> +			control-val = <0x1c>;
> +			csr-copy = <0x7f3 0x7c0 0x7c1 0x7c2 0x7c3 0x7c5 0x7cc>;
> +		};
> +
> +		plic: interrupt-controller@ffd8000000 {
> +			compatible = "thead,c910-plic";
> +			reg = <0xff 0xd8000000 0x0 0x01000000>;
> +			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>,
> +					      <&cpu1_intc 11>, <&cpu1_intc 9>,
> +					      <&cpu2_intc 11>, <&cpu2_intc 9>,
> +					      <&cpu3_intc 11>, <&cpu3_intc 9>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			riscv,ndev = <240>;
> +		};
> +
> +		clint: timer@ffdc000000 {
> +			compatible = "thead,c900-clint";

"c900"? That a typo or intentional. Hard to tell since this compatible
is undocumented ;)

> +			reg = <0xff 0xdc000000 0x0 0x00010000>;
> +			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
> +					      <&cpu1_intc 3>, <&cpu1_intc 7>,
> +					      <&cpu2_intc 3>, <&cpu2_intc 7>,
> +					      <&cpu3_intc 3>, <&cpu3_intc 7>;
> +		};
> +
> +		uart0: serial@ffe7014000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0xff 0xe7014000 0x0 0x4000>;
> +			interrupts = <36>;
> +			clocks = <&uart_sclk>;
> +			clock-names = "baudclk";

dtbs_check complains about this clock name.
> +
> +		dmac0: dmac@ffefc00000 {

dma-controller@

As I mentioned in the other patch, please clean up the dtbs_check
complaints for v2.

Cheers,
Conor.


--OKce/XdTtjQB3lJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFgZkAAKCRB4tDGHoIJi
0gJkAP9TyzjHcuAsWbOpJ8RnqioUEWne+Q8oDh+GeealrSC1hAEAjWjGDNcOBF7i
EgCMKjbIUEwwPx/9ox6mnCrgpzj20gA=
=Xg5D
-----END PGP SIGNATURE-----

--OKce/XdTtjQB3lJP--
