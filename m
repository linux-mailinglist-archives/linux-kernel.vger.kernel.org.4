Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B4C6A1C07
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjBXMS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBXMS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:18:26 -0500
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C875D45C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:18:25 -0800 (PST)
Received: from localhost (88-113-24-128.elisa-laajakaista.fi [88.113.24.128])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 54d54290-b43d-11ed-a2f4-005056bdd08f;
        Fri, 24 Feb 2023 14:18:23 +0200 (EET)
From:   andy.shevchenko@gmail.com
Date:   Fri, 24 Feb 2023 14:18:22 +0200
To:     andy.shevchenko@gmail.com
Cc:     Jerome Neanne <jneanne@baylibre.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, tony@atomide.com, lee@kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
Subject: Re: [PATCH 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
Message-ID: <Y/irDl8GuKv0EPK6@surfacebook>
References: <20230224113837.874264-1-jneanne@baylibre.com>
 <20230224113837.874264-2-jneanne@baylibre.com>
 <Y/iqhsEIvHgnZ+5l@surfacebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/iqhsEIvHgnZ+5l@surfacebook>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Feb 24, 2023 at 02:16:06PM +0200, andy.shevchenko@gmail.com kirjoitti:
> Fri, Feb 24, 2023 at 12:38:36PM +0100, Jerome Neanne kirjoitti:

...

> > +#include <linux/of.h>

Forgot to add that there is no user of this header.

-- 
With Best Regards,
Andy Shevchenko


