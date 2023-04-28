Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20776F1179
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 07:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345277AbjD1Ft4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 01:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345256AbjD1Ftx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 01:49:53 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D8B72735;
        Thu, 27 Apr 2023 22:49:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DFA3480A4;
        Fri, 28 Apr 2023 05:49:49 +0000 (UTC)
Date:   Fri, 28 Apr 2023 08:49:48 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     "Kumar, Udit" <u-kumar1@ti.com>
Cc:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, m-chawdhry@ti.com, n-francis@ti.com
Subject: Re: [EXTERNAL] Re: [PATCH 1/5] arm64: dts: ti: k3-j7200: Add general
 purpose timers
Message-ID: <20230428054948.GI14287@atomide.com>
References: <20230426103219.1565266-1-u-kumar1@ti.com>
 <20230426103219.1565266-2-u-kumar1@ti.com>
 <20230427080049.GH14287@atomide.com>
 <24ea8982-e2ab-d58d-dedd-f51703d0bb92@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24ea8982-e2ab-d58d-dedd-f51703d0bb92@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kumar, Udit <u-kumar1@ti.com> [230427 10:09]:
> Hi Tony
> 
> On 4/27/2023 1:30 PM, Tony Lindgren wrote:
> > Hi,
> > 
> > * Udit Kumar <u-kumar1@ti.com> [230426 10:38]:
> > > There are 20 general purpose timers on j7200 that can be used for things
> > > like PWM using pwm-omap-dmtimer driver. There are also additional ten
> > > timers in the MCU domain.
> > ...
> > 
> > ....
> > Oh so also the MCU timers now have interrupts, nice. Can you please check
> > if what we have in the comments the other SoCs in the dtsi files for MCU
> > timers not having routable interrupts is correct?
> 
> checked for AM65 and AM64, looks these SOC follow different IT map wrt J7200
> 
> On J7200 reading TRM
> 
> https://www.ti.com/lit/pdf/spruiu1
> 
> Section 9.4.3.1.2 GIC500 SPI Interrupt Map, table Table 9-109.
> 
> MCU_TIMER0_INTR_PEND_0 (848) to MCU_TIMER9_INTR_PEND_0 (857)
> 
> looks to be available for A core.

OK thanks a lot for checking it.

> > Also, should the MCU timers be still tagged with status = "reserved"?
> Will mark status as  reserved

OK thanks,

Tony
