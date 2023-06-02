Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B731071FAB9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjFBHKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbjFBHKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:10:38 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62939197;
        Fri,  2 Jun 2023 00:10:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CD4748111;
        Fri,  2 Jun 2023 07:10:34 +0000 (UTC)
Date:   Fri, 2 Jun 2023 10:10:33 +0300
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
Subject: Re: [PATCH 5/6] arm64: dts: ti: k3-j784s4: Add general purpose timers
Message-ID: <20230602071033.GL14287@atomide.com>
References: <20230531213215.602395-1-nm@ti.com>
 <20230531213215.602395-6-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531213215.602395-6-nm@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [230531 21:32]:
> There are 20 general purpose timers on j784s4 that can be used for
> things like PWM using pwm-omap-dmtimer driver. There are also
> additional ten timers in the MCU domain which are meant for MCU
> firmware usage and hence marked reserved by default.
> 
> Though the count is similar to J721e/J7200/j721s2, the device IDs
> and clocks used in j784s4 are different with the option of certain
> clocks having options of additional clock muxes. Since there is very
> minimal reuse, it is cleaner to integrate as part of SoC files itself.
> The defaults are configured for clocking the timers from system
> clock(HFOSC0).

Reviewed-by: Tony Lindgren <tony@atomide.com>
