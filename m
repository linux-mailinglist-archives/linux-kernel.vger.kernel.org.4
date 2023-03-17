Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183766BF5EE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCQXEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCQXET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:04:19 -0400
X-Greylist: delayed 469 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Mar 2023 16:03:57 PDT
Received: from albireo.enyo.de (albireo.enyo.de [37.24.231.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503DD3AA0;
        Fri, 17 Mar 2023 16:03:56 -0700 (PDT)
Received: from [172.17.203.2] (port=47891 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        id 1pdIzQ-001qjd-6U; Fri, 17 Mar 2023 22:56:00 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.94.2)
        (envelope-from <fw@deneb.enyo.de>)
        id 1pdIzP-000Qvx-TG; Fri, 17 Mar 2023 23:55:59 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Retire IA64/Itanium support
References: <20230215100008.2565237-1-ardb@kernel.org>
Date:   Fri, 17 Mar 2023 23:55:59 +0100
In-Reply-To: <20230215100008.2565237-1-ardb@kernel.org> (Ard Biesheuvel's
        message of "Wed, 15 Feb 2023 11:00:03 +0100")
Message-ID: <87y1nvng1s.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ard Biesheuvel:

> The IA64 port of Linux has no maintainer, and according to a report from
> its only remaining user [0], it has been broken for a month and nobody
> cares.
>
> Given that keeping a complex but unused architecture alive uses up
> valuable developer bandwidth, let's just get rid of it.
>
> This supersedes my patch proposing to mark it as 'dead', which received
> no replies from anyone that wants to keep it alive. [1]

Is this still going ahead?

In userspace, ia64 is of course full of special cases, too, so many of
us really want to see it gone, but we can't really start the removal
process while there is still kernel support.
