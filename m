Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8D55B9D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiIOOd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIOOdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:33:23 -0400
X-Greylist: delayed 1393 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Sep 2022 07:33:21 PDT
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04E28980F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 07:33:21 -0700 (PDT)
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.94.2)
        (envelope-from <laforge@gnumonks.org>)
        id 1oYpZ6-009Bko-MN; Thu, 15 Sep 2022 16:10:04 +0200
Received: from laforge by localhost.localdomain with local (Exim 4.96)
        (envelope-from <laforge@gnumonks.org>)
        id 1oYpUT-001NPd-0g;
        Thu, 15 Sep 2022 16:05:17 +0200
Date:   Thu, 15 Sep 2022 16:05:17 +0200
From:   Harald Welte <laforge@gnumonks.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Hyunwoo Kim <imv4bel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Paul Fulghum <paulkf@microgate.com>, akpm@osdl.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH] pcmcia: synclink_cs: Fix use-after-free in mgslpc_ioctl()
Message-ID: <YyMxHRXUTft4bG28@nataraja>
References: <20220913052020.GA85241@ubuntu>
 <a8a9fd74-4ee5-4619-8492-be7139e6d48e@www.fastmail.com>
 <20220915020834.GA110086@ubuntu>
 <f41c2765-80e0-48bc-b1e4-8cfd3230fd4a@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f41c2765-80e0-48bc-b1e4-8cfd3230fd4a@www.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Sep 15, 2022 at 09:35:51AM +0200, Arnd Bergmann wrote:
> There is a good chance that we can remove both now, along with the
> synclink_cs. The scr24x driver is from 2016, but of course the
> hardware is much older. The cm4040/cm4000 drivers are from 2005.
> My guess is that the hardware still exists in actively used systems,
> but none of them get upgraded to modern kernels any more.

It is probably true.  But the same argument can be made about all of the
PCMCIA drivers.  It's been a long time since any new mass-market hardware
with PCMCIA slots has been produced.  Even if you count in the (non-express)
cardbus, the same argument holds true.

I personally haven't used any of those cm4000/cm4040 in ages.  But what
particularly the last decade of my professional career has taught me:
There are typically always more users of legacy tech out there than you
would imagine.  The question is whether those users are relevant enough
for today's kernel maintainers to care.  This isn't meant to sound
bitter - I'm just stating facts.  It can be a valid "developer resource
economic" decision to not care.

Regards,
	Harald

-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
