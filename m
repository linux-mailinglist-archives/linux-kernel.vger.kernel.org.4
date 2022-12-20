Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4237652164
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiLTNYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiLTNYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:24:17 -0500
X-Greylist: delayed 475 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Dec 2022 05:24:14 PST
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC4312A85;
        Tue, 20 Dec 2022 05:24:14 -0800 (PST)
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id E6CF52012F;
        Tue, 20 Dec 2022 14:16:17 +0100 (CET)
Received: from sakura (freebox.vlq16.iliad.fr [213.36.7.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ns.iliad.fr (Postfix) with ESMTPS id D5642200B9;
        Tue, 20 Dec 2022 14:16:17 +0100 (CET)
Date:   Tue, 20 Dec 2022 14:16:16 +0100
From:   Maxime Bizon <mbizon@freebox.fr>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Dave Chiluk <chiluk@ubuntu.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [regression] Bug 216753 - 6e 6 ghz bands are disabled since 5.16
 on intel ax211
Message-ID: <20221220131616.GE25155@sakura>
References: <14722778-dda0-cb9f-8647-892493d94a5c@leemhuis.info>
 <2026016246ef719605c9932feeb56b105833593b.camel@intel.com>
 <CAMfi-DRE-u5TNu2zAL-7A-ENHM9EiJeYJ38BL_FMdk6QmW7c9w@mail.gmail.com>
 <9a03c244-adff-afaf-7385-d8e89cd3f338@leemhuis.info>
 <02F8DDF1-EC0D-4EBD-88F5-7E000841C337@holtmann.org>
 <CAMfi-DQfuro4c_VUrFHBTv8sPnwuV8XhTV_W7qswGeCC2t-wzg@mail.gmail.com>
 <19ea39c87df3c54cbc487466f806bc157d0bf563.camel@freebox.fr>
 <0611323c-2088-e6f3-1c38-7cf742dfb60d@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0611323c-2088-e6f3-1c38-7cf742dfb60d@leemhuis.info>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sunday 04 Dec 2022 à 10:37:42 (+0100), Thorsten Leemhuis wrote:

> That makes me (as a outsider that has no real knowledge about the inner
> workings of the Linux Wifi subsystem) wonder: Does it work in Windows?

No it does not.

More precisely, it used to work with older Intel drivers that (I
suppose) ignored this.

But starting from I don't remember which version it stopped working,
same behaviour as Linux.

-- 
Maxime
