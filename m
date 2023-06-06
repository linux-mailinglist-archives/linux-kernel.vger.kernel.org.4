Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9CB723DA3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbjFFJea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbjFFJeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:34:13 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7077210F5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:33:50 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 3cf5f6e5-044d-11ee-abf4-005056bdd08f;
        Tue, 06 Jun 2023 12:33:48 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 6 Jun 2023 12:33:47 +0300
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] pinctrl: moorefield: Fix open-drain pin mode
 configuration
Message-ID: <ZH79e1hglvJxGZhf@surfacebook>
References: <20230605154523.11799-1-andriy.shevchenko@linux.intel.com>
 <20230606051547.GX45886@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606051547.GX45886@black.fi.intel.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Jun 06, 2023 at 08:15:47AM +0300, Mika Westerberg kirjoitti:
> On Mon, Jun 05, 2023 at 06:45:22PM +0300, Andy Shevchenko wrote:
> > Currently the pin may not be configured as open-drain in some
> > cases because the argument may be 0 for the boolean types of
> > the pin configurations. Fix this by ignoring the argument.
> > 
> > With that, allow to actually restore pin to the push-pull mode.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thank you!

> BTW, looking at the two drivers they seem to have a lot of
> commonalities. Perhaps it makes sense to consolidate?

Yes, that's the plan, perhaps for the next cycle.

-- 
With Best Regards,
Andy Shevchenko


