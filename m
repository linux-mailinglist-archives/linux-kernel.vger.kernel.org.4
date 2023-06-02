Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E921C71FAB0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjFBHI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjFBHIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:08:23 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 441961A1;
        Fri,  2 Jun 2023 00:08:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B9DAD8111;
        Fri,  2 Jun 2023 07:08:18 +0000 (UTC)
Date:   Fri, 2 Jun 2023 10:08:17 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Udit Kumar <u-kumar1@ti.com>, Nitin Yadav <n-yadav@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH 2/6] arm64: dts: ti: k3-j721e: Configure pinctrl for
 timer IO
Message-ID: <20230602070817.GI14287@atomide.com>
References: <20230531213215.602395-1-nm@ti.com>
 <20230531213215.602395-3-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531213215.602395-3-nm@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [230531 21:32]:
> There are timer IO pads in the MCU domain, and in the MAIN domain. These
> pads can be muxed for the related timers.
> 
> There are timer IO control registers for input and output. The registers
> for CTRLMMR_TIMER*_CTRL and CTRLMMR_MCU_TIMER*_CTRL are used to control
> the input. The registers for CTCTRLMMR_TIMERIO*_CTRL and
> CTRLMMR_MCU_TIMERIO*_CTRL the output.
> 
> The multiplexing is documented in Technical Reference Manual[1] under
> "Timer IO Muxing Control Registers" and "Timer IO Muxing Control
> Registers", and the "Timers Overview" chapters.
> 
> We do not expose the cascade_en bit due to the racy usage of
> independent 32 bit registers in-line with the timer instantiation in
> the device tree. The MCU timer controls are also marked as reserved for
> usage by the MCU firmware.

Reviewed-by: Tony Lindgren <tony@atomide.com>
