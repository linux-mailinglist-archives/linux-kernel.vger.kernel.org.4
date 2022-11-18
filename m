Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6052162EFBE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241513AbiKRIjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241349AbiKRIjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:39:01 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D09825803B;
        Fri, 18 Nov 2022 00:38:39 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B8A23807E;
        Fri, 18 Nov 2022 08:28:33 +0000 (UTC)
Date:   Fri, 18 Nov 2022 10:38:37 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com, Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Len Baker <len.baker@gmx.com>, Liang He <windhl@126.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-clk@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v4 1/2] clk: ti: change ti_clk_register[_omap_hw]() API
Message-ID: <Y3dEjfwJKWFlSFPb@atomide.com>
References: <20221113181147.1626585-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113181147.1626585-1-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dario Binacchi <dario.binacchi@amarulasolutions.com> [221113 18:01]:
> The ti_clk_register() and ti_clk_register_omap_hw() functions are always
> called with the parameter of type "struct device" set to NULL, since the
> functions from which they are called always have a parameter of type
> "struct device_node". Replacing "struct device" type parameter with
> "struct device_node" will allow you to register a TI clock to the common
> clock framework by taking advantage of the facilities provided by the
> "struct device_node" type. Further, adding the "of_" prefix to the name
> of these functions explicitly binds them to the "struct device_node"
> type.

Looks good to me, nice clean-up:

Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
