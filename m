Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC74702515
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbjEOGnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238286AbjEOGnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:43:39 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBDC124
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:43:35 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id cb35f6d5-f2eb-11ed-a9de-005056bdf889;
        Mon, 15 May 2023 09:43:27 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Mon, 15 May 2023 09:43:25 +0300
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Johan Hovold <johan@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "maz@kernel.org" <maz@kernel.org>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Message-ID: <ZGHUjUpI-5JWNCAf@surfacebook>
References: <20230512042806.3438373-1-chris.packham@alliedtelesis.co.nz>
 <ZF3pqvOVv6eZl62y@hovoldconsulting.com>
 <2265adee-e003-08ae-e66d-fb41bdd79122@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2265adee-e003-08ae-e66d-fb41bdd79122@alliedtelesis.co.nz>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, May 14, 2023 at 09:57:58PM +0000, Chris Packham kirjoitti:
> On 12/05/23 19:24, Johan Hovold wrote:
> > On Fri, May 12, 2023 at 04:28:06PM +1200, Chris Packham wrote:

...

> > You need a better explanation as to why this is an issue. What does the
> > warning look like for example?
> 
> Ironically I had that in my first attempt to address the issue but was 
> told it was too much detail. So now I've gone too far the other way. 
> I'll include it in the response I'm about to send to LinusW.

You have been (implicitly) told to reduce the scope of the details to have
the only important ones, removing the traceback completely wasn't on the
table.

Citation: "Besides the very noisy traceback in the commit message (read
https://kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages)"

-- 
With Best Regards,
Andy Shevchenko


