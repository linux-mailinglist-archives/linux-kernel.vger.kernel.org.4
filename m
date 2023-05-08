Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2AB6FB532
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbjEHQh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjEHQhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:37:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAA11FD5;
        Mon,  8 May 2023 09:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8537762DC4;
        Mon,  8 May 2023 16:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E103DC433D2;
        Mon,  8 May 2023 16:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683563837;
        bh=No13imuIZB8iPKIc3FPlMAlNo8ULEWUh1zQtfnpcBGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vqg3FmxfO7ymJGx6725FjOdi/YUqPtYikEADOIUaV079c/OiMpIyyR6aD8BtlZqCg
         o6e6DzFt5rM2lkMfUDV1BXWCdvoRkEgQQ8jMKLx84Z1rXi3d/29Wfq6bCUPi2ZAzJC
         4yL/21PiGI2CYB9Jsfx6wyEC8NepKH5eo4DpSGoh63H1swHW6L9AGRqRmlz08k1ogG
         EkRYBnHjz62y9TatjG/ewsJWPve+LATc/6bZiB8ME629g+lRN/N+g5TDu7k7HmiNMa
         jv+eEjro8AVLXSXbkH6a8wc0oyGA6OzxbSgIOowN8v8vW9MeFCR3Qk/zVOliXRulSq
         gfZ94qHPT8IPQ==
Date:   Tue, 9 May 2023 00:26:10 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor@kernel.org>
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
Message-ID: <ZFkiotPacIMUghDP@xhacker>
References: <20230507182304.2934-1-jszhang@kernel.org>
 <20230507182304.2934-4-jszhang@kernel.org>
 <20230507-calamari-gentleman-bbe62af06f92@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230507-calamari-gentleman-bbe62af06f92@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2023 at 10:35:12PM +0100, Conor Dooley wrote:
> Hey Jisheng,
> 
> On Mon, May 08, 2023 at 02:23:02AM +0800, Jisheng Zhang wrote:
> 
> > +		c910_0: cpu@0 {
> > +			compatible = "thead,c910", "riscv";
> > +			device_type = "cpu";
> > +			riscv,isa = "rv64imafdc";
> 
> Does this support more than "rv64imafdc"?
> I assume there's some _xtheadfoo extensions that it does support,
> although I am not sure how we are proceeding with those - Heiko might
> have a more nuanced take.
> 
> > +		reset: reset-sample {
> > +			compatible = "thead,reset-sample";
> 
> What is a "reset-sample"?

This node is only for opensbi. The compatible string is already in
opensbi. Do we also need to add dt-binding for it in linux?

> 
> > +			entry-reg = <0xff 0xff019050>;
> > +			entry-cnt = <4>;
> > +			control-reg = <0xff 0xff015004>;
> > +			control-val = <0x1c>;
> > +			csr-copy = <0x7f3 0x7c0 0x7c1 0x7c2 0x7c3 0x7c5 0x7cc>;
> > +		};
> > +
> > +		plic: interrupt-controller@ffd8000000 {
> > +			compatible = "thead,c910-plic";
> > +			reg = <0xff 0xd8000000 0x0 0x01000000>;
> > +			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>,
> > +					      <&cpu1_intc 11>, <&cpu1_intc 9>,
> > +					      <&cpu2_intc 11>, <&cpu2_intc 9>,
> > +					      <&cpu3_intc 11>, <&cpu3_intc 9>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <1>;
> > +			riscv,ndev = <240>;
> > +		};
> > +
> > +		clint: timer@ffdc000000 {
> > +			compatible = "thead,c900-clint";
> 
> "c900"? That a typo or intentional. Hard to tell since this compatible
> is undocumented ;)

Per my understanding, this node is only for opensbi too. Add will add
dt-binding in v2.

> 
> > +			reg = <0xff 0xdc000000 0x0 0x00010000>;
> > +			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
> > +					      <&cpu1_intc 3>, <&cpu1_intc 7>,
> > +					      <&cpu2_intc 3>, <&cpu2_intc 7>,
> > +					      <&cpu3_intc 3>, <&cpu3_intc 7>;
> > +		};
> > +
> > +		uart0: serial@ffe7014000 {
> > +			compatible = "snps,dw-apb-uart";
> > +			reg = <0xff 0xe7014000 0x0 0x4000>;
> > +			interrupts = <36>;
> > +			clocks = <&uart_sclk>;
> > +			clock-names = "baudclk";
> 
> dtbs_check complains about this clock name.
> > +
> > +		dmac0: dmac@ffefc00000 {
> 
> dma-controller@
> 
> As I mentioned in the other patch, please clean up the dtbs_check
> complaints for v2.
> 

Thanks for the reminding.
