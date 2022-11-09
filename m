Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C16962252D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiKIIRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIIRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:17:36 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 782D41BE81;
        Wed,  9 Nov 2022 00:17:34 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C035180FB;
        Wed,  9 Nov 2022 08:07:46 +0000 (UTC)
Date:   Wed, 9 Nov 2022 10:17:32 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang He <windhl@126.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-clk@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 1/2] clk: ti: add of_ti_clk_register() helper
Message-ID: <Y2tiHNLPiAwV6oEn@atomide.com>
References: <20221106154612.3474940-1-dario.binacchi@amarulasolutions.com>
 <Y2thuiR3UVEeLCQO@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2thuiR3UVEeLCQO@atomide.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [221109 08:06]:
> * Dario Binacchi <dario.binacchi@amarulasolutions.com> [221106 17:36]:
> > The ti_clk_register() function is always called with the parameter of
> > type struct device set to NULL, since the functions from which it is
> > called always have a parameter of type struct device_node. Adding this
> > helper will allow you to register a TI clock to the common clock
> > framework by taking advantage of the facilities provided by the
> > struct device_node type.
> 
> Makes sense to me.
> 
> Do you have a patch to make use of this I can test with?

I mean a patch to convert the ti_clk_register() callers to use this or
what's your plan?

Regards,

Tony
