Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5F574A2F1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjGFROs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjGFROo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:14:44 -0400
X-Greylist: delayed 1995 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Jul 2023 10:14:33 PDT
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173FC1FC8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 10:14:32 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1qHS2U-006KW9-Jc; Thu, 06 Jul 2023 12:41:06 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id A53C756016B; Thu,  6 Jul 2023 12:41:05 -0400 (EDT)
Date:   Thu, 6 Jul 2023 12:41:05 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ross Maynard <bids.7405@bigpond.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: Fwd: 3 more broken Zaurii - SL-5600, A300, C700
Message-ID: <ZKbuoRBi50i8OZ9d@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ross Maynard <bids.7405@bigpond.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
References: <7ea9abd8-c35d-d329-f0d4-c8bd220cf691@gmail.com>
 <50f4c10d-260c-cb98-e7d2-124f5519fa68@gmail.com>
 <e1fdc435-089c-8ce7-d536-ce3780a4ba95@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1fdc435-089c-8ce7-d536-ce3780a4ba95@leemhuis.info>
X-Spam-Note: SpamAssassin invocation failed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 01:45:57PM +0200, Thorsten Leemhuis wrote:
 > On 06.07.23 05:08, Bagas Sanjaya wrote:
 > >>
 > >> I notice a regression report on Bugzilla [1]. Quoting from it:
 > >>
 > >>> The following patch broke support of 3 more Zaurus models: SL-5600, A300 and C700
 > >>>
 > >>> [16adf5d07987d93675945f3cecf0e33706566005] usbnet: Remove over-broad module alias from zaurus
 > 
 > ...
 > He sometimes shows up on Linux kernel lists, but I doubt he cares about
 > that change after all these years. And I would not blame him at all.

That's about the size of it.  This is pretty near the bottom of my ever-shrinking
list of kernel drivers I care about.

 > Yes, we have the "no regressions" rule, but contributing a change to the
 > kernel OTOH should not mean that you are responsible for all regressions
 > it causes for your whole life. :-)

That said, 12 years later, 16adf5d07987d93675945f3cecf0e33706566005
is still the right thing to do. Adding actual matches for the devices
rather than matching by class will prevent this getting loaded where it
doesn't need to be.

If someone actually cares to get this working, cargo-culting Oliver's
change to add the extra id is likely the way forward.

	Dave

