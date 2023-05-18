Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90704708A00
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjERVCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjERVCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:02:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD84E115;
        Thu, 18 May 2023 14:02:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6153565224;
        Thu, 18 May 2023 21:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD91C433D2;
        Thu, 18 May 2023 21:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684443730;
        bh=dG9KGkwnVBL2/+dISO9tPB3QBs7KKkNCCeDRptlnaxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LnfsM4wAfszJ/tjCSKiARr2+tU525tH8OXmB69pIGnIJ2pPTcTojqfySF5eH17DkH
         41uWVG6fYdY5Tw3xhjGsKm1F79PRCH0JA6sqx0owU/IKQ4pfTI0KukrA6WcRhdo6Mc
         hCnRKEOb4nlIlEumZ34MbbxnRGH+iEcWt6l42dB4pUjwRTGOH3gs2TM7gE+bp2YJZU
         5XZuAnb+0syhVsBUSIR8mfrGdFTVlL+DCy5aWsu4Tvmdhzey5nXGPzbjx0rEjq6oEA
         660HJuZV/3yQDDUTDOWVkzRMNIpJvMSGIw5jQLr1/1a2ludLFLS+belE65vsUjJ4KV
         6E9Jku6fJNxlQ==
Date:   Thu, 18 May 2023 22:02:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Yangtao Li <frank.li@vivo.com>,
        Wei Fu <wefu@redhat.com>, Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH v2 6/9] riscv: dts: add initial T-HEAD TH1520 SoC device
 tree
Message-ID: <20230518-slider-pointless-14c1e653cc1c@spud>
References: <20230518184541.2627-1-jszhang@kernel.org>
 <20230518184541.2627-7-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aofeKfy/KZUnV2RS"
Content-Disposition: inline
In-Reply-To: <20230518184541.2627-7-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aofeKfy/KZUnV2RS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 19, 2023 at 02:45:38AM +0800, Jisheng Zhang wrote:
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&c910_0>;
> +				};
> +
> +				core1 {
> +					cpu = <&c910_1>;
> +				};
> +
> +				core2 {
> +					cpu = <&c910_2>;
> +				};
> +
> +				core3 {
> +					cpu = <&c910_3>;
> +				};
> +			};
> +		};

We actually don't need to add these anymore, I fixed our topology
detection :) No harm to keep it though!

> +		cpurst: cpurst {
> +			compatible = "thead,reset-th1520";
> +			entry-reg = <0xff 0xff019050>;
> +			entry-cnt = <4>;
> +			control-reg = <0xff 0xff015004>;
> +			control-val = <0x1c>;
> +			csr-copy = <0x7f3 0x7c0 0x7c1 0x7c2 0x7c3 0x7c5 0x7cc>;
> +		};

I figure this will be no surprise to you:
arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dtb: soc: cpurst: {'compatible': ['thead,reset-th1520'], 'entry-reg': [[1099494953040]], 'entry-cnt': [[4]], 'control-reg': [[255, 4278276100]], 'control-val': [[28]], 'csr-copy': [[2035, 1984, 1985, 1986, 1987, 1989, 1996]]} should not be valid under {'type': 'object'}
arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dtb: cpurst: control-reg:0: [255, 4278276100] is too long

> +		dmac0: dma-controller@ffefc00000 {
> +			compatible = "snps,axi-dma-1.01a";
> +			reg = <0xff 0xefc00000 0x0 0x1000>;
> +			interrupts = <27 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&apb_clk>, <&apb_clk>;
> +			clock-names = "core-clk", "cfgr-clk";
> +			#dma-cells = <1>;
> +			dma-channels = <4>;
> +			snps,block-size = <65536 65536 65536 65536>;
> +			snps,priority = <0 1 2 3>;
> +			snps,dma-masters = <1>;
> +			snps,data-width = <4>;
> +			snps,axi-max-burst-len = <16>;
> +                        status = "disabled";
    ^^^^^^^^^^^^^^^^^^^^^^^
These are spaces :(

> +		};

Cheers,
Conor.


--aofeKfy/KZUnV2RS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGaSTQAKCRB4tDGHoIJi
0uMoAQCBw0zNKchg9GvcORqcH1KUqfPdzjJFZkl1FjcZJuZKzgEA0Uni0Kk00pQ7
Uo5y1A3imHMXoThfyp/695rWmPg+5g8=
=Ppsm
-----END PGP SIGNATURE-----

--aofeKfy/KZUnV2RS--
