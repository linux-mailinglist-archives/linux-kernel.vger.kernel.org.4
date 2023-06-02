Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A5071FAC1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjFBHMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjFBHLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:11:43 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5107A1B3;
        Fri,  2 Jun 2023 00:11:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C62558111;
        Fri,  2 Jun 2023 07:11:41 +0000 (UTC)
Date:   Fri, 2 Jun 2023 10:11:40 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Udit Kumar <u-kumar1@ti.com>
Cc:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        m-chawdhry@ti.com, n-francis@ti.com
Subject: Re: [PATCH v2 2/5] arm64: dts: ti: k3-j7200: Configure pinctrl for
 timer IO pads
Message-ID: <20230602071140.GN14287@atomide.com>
References: <20230601093744.1565802-1-u-kumar1@ti.com>
 <20230601093744.1565802-3-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601093744.1565802-3-u-kumar1@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Udit Kumar <u-kumar1@ti.com> [230601 09:38]:
> There are timer IO pads in the MCU domain, and in the MAIN domain. These
> pads can be muxed for the related timers.
> 
> There are timer IO control registers for input and output. The registers
> for CTRLMMR_TIMER*_CTRL and CTRLMMR_MCU_TIMER*_CTRL are used to control
> the input. The registers for CTCTRLMMR_TIMERIO*_CTRL and
> CTRLMMR_MCU_TIMERIO*_CTRL the output.
> 
> The multiplexing is documented in TRM "5.1.2.3.1.4 Timer IO Muxing Control
> Registers" and "5.1.3.3.1.5 Timer IO Muxing Control Registers", and the
> CASCADE_EN bit is documented in TRM "12.6.3.1 Timers Overview".
> 
> For chaining timers, the timer IO control registers also have a CASCADE_EN
> input bit in the CTRLMMR_TIMER*_CTRL in the registers. The CASCADE_EN bit
> muxes the previous timer output, or possibly and external TIMER_IO pad
> source, to the input clock of the selected timer instance for odd numered
> timers. For the even numbered timers, the CASCADE_EN bit does not do
> anything. The timer cascade input routing options are shown in TRM
> "Figure 12-3224. Timers Overview". For handling beyond multiplexing, the
> driver support for timer cascading should be likely be handled via the
> clock framework.
> 
> The MCU timer controls are also marked as reserved for
> usage by the MCU firmware.

Reviewed-by: Tony Lindgren <tony@atomide.com>
