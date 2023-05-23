Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270EB70E5BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbjEWTh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbjEWTh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:37:56 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5291B1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:37:27 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 38ec2e05-f9a1-11ed-a9de-005056bdf889;
        Tue, 23 May 2023 22:37:16 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 23 May 2023 22:37:15 +0300
To:     Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Cc:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        Wells Lu <wellslutw@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl:sunplus: Add check for kmalloc
Message-ID: <ZG0V6_bUaz3Thy0q@surfacebook>
References: <1684836688-9204-1-git-send-email-wellslutw@gmail.com>
 <ZGztCHNr1jmpFq0A@surfacebook>
 <1560e9c0e5154802ab020b9da846d65f@sphcmbx02.sunplus.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1560e9c0e5154802ab020b9da846d65f@sphcmbx02.sunplus.com.tw>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, May 23, 2023 at 05:39:51PM +0000, Wells Lu 呂芳騰 kirjoitti:
> > > Fix Smatch static checker warning:
> > > potential null dereference 'configs'. (kmalloc returns null)

...

> > >  			configs = kmalloc(sizeof(*configs), GFP_KERNEL);
> > > +			if (!configs)
> > 
> > > +				return -ENOMEM;
> > 
> > "Fixing" by adding a memory leak is not probably a good approach.
> 
> Do you mean I need to free all memory which are allocated in this subroutine before
> return -ENOMEM?

This is my understanding of the code. But as I said... (see below)

...

> > >  			configs = kmalloc(sizeof(*configs), GFP_KERNEL);
> > > +			if (!configs)
> > > +				return -ENOMEM;
> > 
> > Ditto.

...

> > It might be that I'm mistaken. In this case please add an explanation why in the commit
> > message.

^^^

-- 
With Best Regards,
Andy Shevchenko


