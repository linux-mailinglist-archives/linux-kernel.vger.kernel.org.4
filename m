Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4374570E255
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237724AbjEWQnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjEWQnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:43:05 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A9719B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:42:51 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id d9d7e6b2-f988-11ed-b3cf-005056bd6ce9;
        Tue, 23 May 2023 19:42:49 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 23 May 2023 19:42:48 +0300
To:     Wells Lu <wellslutw@gmail.com>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, wells.lu@sunplus.com
Subject: Re: [PATCH] pinctrl:sunplus: Add check for kmalloc
Message-ID: <ZGztCHNr1jmpFq0A@surfacebook>
References: <1684836688-9204-1-git-send-email-wellslutw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684836688-9204-1-git-send-email-wellslutw@gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, May 23, 2023 at 06:11:28PM +0800, Wells Lu kirjoitti:
> Fix Smatch static checker warning:
> potential null dereference 'configs'. (kmalloc returns null)

...

>  			configs = kmalloc(sizeof(*configs), GFP_KERNEL);
> +			if (!configs)

> +				return -ENOMEM;

"Fixing" by adding a memory leak is not probably a good approach.

...

>  			configs = kmalloc(sizeof(*configs), GFP_KERNEL);
> +			if (!configs)
> +				return -ENOMEM;

Ditto.

...

It might be that I'm mistaken. In this case please add an explanation why in
the commit message.

-- 
With Best Regards,
Andy Shevchenko


