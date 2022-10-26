Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FAB60DB5C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiJZGdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbiJZGdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:33:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C71FAC392;
        Tue, 25 Oct 2022 23:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666766000; x=1698302000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YSQ0taVVnmjRJNC9c/piCsW0RLRL2qeZ0FLqsRlzPpU=;
  b=MIL9DccK0p0AeRXcCnwZJsL2l/b5rwdDlsPcmdZqtSPYAVZBzlndmaJ+
   v13bkkYbllStTkMxzf6wKvJ3HEH3x/MonwXAwcNqz1Fzw98ldWk6xtL/U
   1CMAqZnDjF1u/2JX/y9sJENA30MEiUzvtsaZwKbHu1G2iQb/UTINnxTLF
   a93LkwyV/TQVAhzhfWxJCktS5JtW2FuP/TrI/eIBIaSza9+vPL3oPXeb/
   +j6viFTJdzu80TU+Be1tPhIwGc0SlOa5I5AVgGRnoDKcNRGdIX1Slzl1r
   404Pv+diyIIuWRw1U9NpkqPRdCnBC0Jgu7OSF/SRXC3v1z3/zlBeeMPl8
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="120386793"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2022 23:33:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 25 Oct 2022 23:33:18 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 25 Oct 2022 23:33:16 -0700
Date:   Wed, 26 Oct 2022 07:33:02 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <Padmarao.Begari@microchip.com>
CC:     <conor@kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <Daire.McNamara@microchip.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [RFC] riscv: dts: microchip: add OPPs to mpfs
Message-ID: <Y1jUnrzH9sCW/kIi@wendy>
References: <20221024193647.1089769-1-conor@kernel.org>
 <bf68f00675b5cbc6ba8099496ddb68ed20e84f05.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bf68f00675b5cbc6ba8099496ddb68ed20e84f05.camel@microchip.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 05:54:16AM +0000, Padmarao.Begari@microchip.com wrote:
> Hi Conor,
> > On Mon, 2022-10-24 at 20:36 +0100, Conor Dooley wrote:
> > 
> > From: Conor Dooley <conor.dooley@microchip.com>
> > 
> > The U-Boot dts for mpfs defines three OPPs which are missing from the
> > Linux dts. For ease of synchronisation of the two, add the missing
> > OPPs
> > to the Linux dt too.
> > 
> > CC: Padmarao Begari <padmarao.begari@microchip.com>
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > 
> > Hey Padmarao,
> > I've been trying to pick off the bits that're different between the
> > Linux
> > & U-Boot dts. Do you remember why we added OPPs to the U-Boot dts but
> > didn't propagate them elsewhere?
> > 
> 
> Initially We added OPPs to the Linux dts for the CPU Frequency and
> Voltage scaling while bringing up the Linux on an Emulation Platform
> and the Icicle Kit for PolarFire SoC and same dts used for the U-Boot
> but the U-Boot dts upstreamed first.

Right. So do we know if they're even correct values for an actual
PolarFire SoC?

> >  arch/riscv/boot/dts/microchip/mpfs.dtsi | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi
> > b/arch/riscv/boot/dts/microchip/mpfs.dtsi
> > index 0a9bb84af438..9d9ff7174341 100644
> > --- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
> > +++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
> > @@ -23,6 +23,7 @@ cpu0: cpu@0 {
> >                         reg = <0>;
> >                         riscv,isa = "rv64imac";
> >                         clocks = <&clkcfg CLK_CPU>;
> > +                       operating-points-v2 = <&cluster0_opps>;
> >                         status = "disabled";
> > 
> >                         cpu0_intc: interrupt-controller {
> > @@ -51,6 +52,7 @@ cpu1: cpu@1 {
> >                         clocks = <&clkcfg CLK_CPU>;
> >                         tlb-split;
> >                         next-level-cache = <&cctrllr>;
> > +                       operating-points-v2 = <&cluster0_opps>;
> >                         status = "okay";
> > 
> >                         cpu1_intc: interrupt-controller {
> > @@ -79,6 +81,7 @@ cpu2: cpu@2 {
> >                         clocks = <&clkcfg CLK_CPU>;
> >                         tlb-split;
> >                         next-level-cache = <&cctrllr>;
> > +                       operating-points-v2 = <&cluster0_opps>;
> >                         status = "okay";
> > 
> >                         cpu2_intc: interrupt-controller {
> > @@ -107,6 +110,7 @@ cpu3: cpu@3 {
> >                         clocks = <&clkcfg CLK_CPU>;
> >                         tlb-split;
> >                         next-level-cache = <&cctrllr>;
> > +                       operating-points-v2 = <&cluster0_opps>;
> >                         status = "okay";
> > 
> >                         cpu3_intc: interrupt-controller {
> > @@ -136,6 +140,7 @@ cpu4: cpu@4 {
> >                         tlb-split;
> >                         next-level-cache = <&cctrllr>;
> >                         status = "okay";
> > +                       operating-points-v2 = <&cluster0_opps>;
> >                         cpu4_intc: interrupt-controller {
> >                                 #interrupt-cells = <1>;
> >                                 compatible = "riscv,cpu-intc";
> > @@ -166,6 +171,24 @@ core4 {
> >                                 };
> >                         };
> >                 };
> > +
> > +               cluster0_opps: opp-table {
> > +                       compatible = "operating-points-v2";
> > +                       opp-shared;
> > +
> > +                       opp-600000000 {
> > +                           opp-hz = /bits/ 64 <600000000>;
> > +                           opp-microvolt = <1100000>;
> > +                       };
> > +                       opp-300000000 {
> > +                           opp-hz = /bits/ 64 <300000000>;
> > +                           opp-microvolt = <950000>;
> > +                       };
> > +                       opp-150000000 {
> > +                           opp-hz = /bits/ 64 <150000000>;
> > +                           opp-microvolt = <750000>;
> > +                       };
> > +               };
> >         };
> > 
> >         refclk: mssrefclk {
> > --
> > 2.38.0
> > 
