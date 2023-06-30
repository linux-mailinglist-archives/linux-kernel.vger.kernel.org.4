Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E011D744192
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjF3Rsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjF3Rsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:48:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5209F2D4A;
        Fri, 30 Jun 2023 10:48:46 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="352275048"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="352275048"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 10:48:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="787792137"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="787792137"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jun 2023 10:48:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qFIET-001AaS-1x;
        Fri, 30 Jun 2023 20:48:33 +0300
Date:   Fri, 30 Jun 2023 20:48:33 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Reichel <sre@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-oxnas@groups.io,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v2 00/15] ARM: oxnas support removal
Message-ID: <ZJ8VcZq2s5XrxJge@smile.fi.intel.com>
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 06:58:25PM +0200, Neil Armstrong wrote:
> With [1] removing MPCore SMP support, this makes the OX820 barely usable,
> associated with a clear lack of maintainance, development and migration to
> dt-schema it's clear that Linux support for OX810 and OX820 should be removed.
> 
> In addition, the OX810 hasn't been booted for years and isn't even present
> in an ARM config file.
> 
> For the OX820, lack of USB and SATA support makes the platform not usable
> in the current Linux support and relies on off-tree drivers hacked from the
> vendor (defunct for years) sources.
> 
> The last users are in the OpenWRT distribution, and today's removal means
> support will still be in stable 6.1 LTS kernel until end of 2026.
> 
> If someone wants to take over the development even with lack of SMP, I'll
> be happy to hand off maintainance.
> 
> It has been a fun time adding support for this architecture, but it's time
> to get over!
> 
> Now arch/arm parts are removed, now it's time to remove the remaining stuff.

For all non-DT patches
Acked-by: Andy Shevchenko <andy@kernel.org>

I always like negative statistics of a magnitude order!

-- 
With Best Regards,
Andy Shevchenko


