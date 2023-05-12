Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21867700156
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239926AbjELHWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjELHWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:22:23 -0400
X-Greylist: delayed 900 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 May 2023 00:22:20 PDT
Received: from mail.sdinet.de (hydra.sdinet.de [136.243.3.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5247C10C6;
        Fri, 12 May 2023 00:22:20 -0700 (PDT)
Received: from aurora64.sdinet.de (aurora64.sdinet.de [193.103.159.64])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: haegar)
        by mail.sdinet.de (bofa-smtpd) with ESMTPSA id 9D5733401FC;
        Fri, 12 May 2023 08:57:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdinet.de; s=mail;
        t=1683874625; bh=6V4gSAQO2IHnC05FAsTRzHrehfn2e9Gr95HmyFdkEZ4=;
        l=973; h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=nFzgDA0NqI0FoB/3tA+vPTXZ8dWvnI87mqyt2/8DGGEyS4KSfJRP0kxbj7VKGmEwH
         SStqCaJG484boLL6stis/bBGyf79pomLmY8dMXed8911P9zi9SZf7EtppzR0deYByV
         wDXbNFzXoKgbZ7UKoPJvZzQlHwWHXKS5TR60o14/V6BfKW3g8UB1/0H7Y9+uJKvRmT
         LGhAk/uN52vfgiz01Cn9hEVcxqzcWkzs/EEXMkRnydDznOaoqyZNvQqX2ls4Eg5JAJ
         docl6fagCZqjjFNBbFD1J+SJptM0peIeEg/W295jjUKwzFHm/8VjH7m/qzpN87Kgqr
         rcL+PQ93qz5ag==
Date:   Fri, 12 May 2023 08:57:15 +0200 (CEST)
From:   Sven-Haegar Koch <haegar@sdinet.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Diederik de Haas <didi.debian@cknow.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        David Airlie <airlied@redhat.com>,
        Karsten Keil <isdn@linux-pingi.de>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Sam Creasey <sammy@sammy.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Jan Kara <jack@suse.com>,
        =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Pavel Machek <pavel@ucw.cz>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Kalle Valo <kvalo@kernel.org>,
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Deepak R Varma <drv@mailo.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Dan Carpenter <error27@gmail.com>,
        Archana <craechal@gmail.com>,
        "David A . Hinds" <dahinds@users.sourceforge.net>,
        Donald Becker <becker@scyld.com>,
        Peter De Schrijver <p2@mind.be>
Subject: Re: [PATCH 04/10] net: ethernet: 8390: Replace GPL boilerplate with
 SPDX identifier
In-Reply-To: <1eb3b5cb-5906-4776-74a2-820b5b05949c@linux-m68k.org>
Message-ID: <2738e88d-16e9-15c7-37ea-4c2dc4f69181@sdinet.de>
References: <20230511133406.78155-1-bagasdotme@gmail.com> <20230511133406.78155-5-bagasdotme@gmail.com> <1eb3b5cb-5906-4776-74a2-820b5b05949c@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023, Greg Ungerer wrote:

> On 11/5/23 23:34, Bagas Sanjaya wrote:
> > Replace GPL boilerplate notice on remaining files with appropriate SPDX
> > tag. For files mentioning COPYING, use GPL 2.0; otherwise GPL 1.0+.

> > --- a/drivers/net/ethernet/8390/hydra.c
> > +++ b/drivers/net/ethernet/8390/hydra.c
> > @@ -1,10 +1,8 @@
> > +/* SPDX-License-Identifier: GPL-1.0-only */
> > +
> >   /* New Hydra driver using generic 8390 core */
> >   /* Based on old hydra driver by Topi Kanerva (topi@susanna.oulu.fi) */
> >   -/* This file is subject to the terms and conditions of the GNU General
> > */
> > -/* Public License.  See the file COPYING in the main directory of the
> > */
> > -/* Linux distribution for more details.
> > */
> > -
> >   /* Peter De Schrijver (p2@mind.be) */
> >   /* Oldenburg 2000 */

GPL-1.0-only does not sound correct.

c'ya
sven-haegar

-- 
Three may keep a secret, if two of them are dead.
- Ben F.
