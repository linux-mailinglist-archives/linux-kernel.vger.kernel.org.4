Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF5D712CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjEZSnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjEZSnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:43:19 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C843613D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:42:53 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 3c9b1b25-fbf4-11ed-b3cf-005056bd6ce9;
        Fri, 26 May 2023 21:36:33 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 26 May 2023 21:36:32 +0300
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 09/11] serial: sc16is7xx: add I/O register translation
 offset
Message-ID: <ZHD8ME66oRKzc-Kz@surfacebook>
References: <20230525040324.3773741-1-hugo@hugovil.com>
 <20230525040324.3773741-10-hugo@hugovil.com>
 <ZG9FBgX2useVeuWl@surfacebook>
 <20230525113145.35cef67328b63ba4239d2361@hugovil.com>
 <20230525132046.6c48f2fd9235215f01238a04@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525132046.6c48f2fd9235215f01238a04@hugovil.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, May 25, 2023 at 01:20:46PM -0400, Hugo Villeneuve kirjoitti:
> On Thu, 25 May 2023 11:31:45 -0400
> Hugo Villeneuve <hugo@hugovil.com> wrote:
> > On Thu, 25 May 2023 14:22:46 +0300
> > andy.shevchenko@gmail.com wrote:
> > > Thu, May 25, 2023 at 12:03:23AM -0400, Hugo Villeneuve kirjoitti:

...

> > > Wondering if you can always register 8 pins and use valid mask to define which
> > > one are in use?
> > 
> > I will look into it, I think it may be a good idea and could help to
> > simplify things a bit.
> 
> finally, this was the way to go. The resulting code/patch is much simpler and
> elegant this way. Thank you for the suggestion.
> 
> I will submit a V4 with all the changes.

Thank you for trying!

-- 
With Best Regards,
Andy Shevchenko


