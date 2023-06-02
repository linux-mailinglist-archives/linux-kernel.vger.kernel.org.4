Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE79071FAAE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjFBHH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjFBHHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:07:55 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A223C1AD;
        Fri,  2 Jun 2023 00:07:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1D9FA8111;
        Fri,  2 Jun 2023 07:07:26 +0000 (UTC)
Date:   Fri, 2 Jun 2023 10:07:24 +0300
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
Subject: Re: [PATCH 1/6] arm64: dts: ti: k3-j721e: Add general purpose timers
Message-ID: <20230602070724.GH14287@atomide.com>
References: <20230531213215.602395-1-nm@ti.com>
 <20230531213215.602395-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531213215.602395-2-nm@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [230531 21:32]:
> There are 20 general purpose timers on j721e that can be used for
> things like PWM using pwm-omap-dmtimer driver. There are also
> additional ten timers in the MCU domain which are meant for MCU
> firmware usage and hence marked reserved by default.
> 
> The odd numbered timers have the option of being cascaded to even
> timers to create a 64 bit non-atomic counter which is racy in simple
> usage, hence the clock muxes are explicitly setup to individual 32 bit
> counters driven off system crystal (HFOSC) as default.
> 
> These instantiation differs from J7200 and other SoCs with the device
> IDs and clocks involved for muxing.

Reviewed-by: Tony Lindgren <tony@atomide.com>
