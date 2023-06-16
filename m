Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7375A7330A5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344945AbjFPMBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjFPMBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:01:15 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49677273F;
        Fri, 16 Jun 2023 05:01:12 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 345E22168C;
        Fri, 16 Jun 2023 14:01:08 +0200 (CEST)
Date:   Fri, 16 Jun 2023 14:01:02 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Judith Mendez <jm@ti.com>
Cc:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Schuyler Patton <spatton@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 4/4] DO_NOT_MERGE arm64: dts: ti: Enable MCU MCANs for
 AM62x
Message-ID: <ZIxO/uo7FICKsmdb@francesco-nb.int.toradex.com>
References: <20230419223323.20384-1-jm@ti.com>
 <20230419223323.20384-5-jm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419223323.20384-5-jm@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 05:33:23PM -0500, Judith Mendez wrote:
> On AM62x there are no hardware interrupts routed to GIC interrupt
> controller for MCU MCAN IP, A53 Linux cannot receive hardware
> interrupts. Since an hrtimer will be used to generate software
> interrupts, add MCU MCAN nodes to dtsi and default to disabled.
> 
> AM62x does not carry on-board CAN transceivers, so instead of
> changing DTB permanently use an overlay to enable MCU MCANs and to
> add CAN transceiver nodes.
> 
> If an hrtimer is used to generate software interrupts, the two
> required interrupt attributes in the MCAN node do not have to be
> included.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>

[...]

> +	mcu_mcan1: can@4e00000 {
this should be mcu_mcan0

> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x4e00000 0x00 0x8000>,
> +			  <0x00 0x4e08000 0x00 0x200>;

[...]

> +	mcu_mcan2: can@4e10000 {
mcu_mcan1

> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x4e10000 0x00 0x8000>,
> +			  <0x00 0x4e18000 0x00 0x200>;

Francesco
