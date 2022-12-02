Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1084E640CC6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiLBSCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiLBSCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:02:01 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Dec 2022 10:01:58 PST
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A36CE51D8;
        Fri,  2 Dec 2022 10:01:57 -0800 (PST)
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 91E7920055;
        Fri,  2 Dec 2022 18:42:13 +0100 (CET)
Received: from sakura (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 816D920041;
        Fri,  2 Dec 2022 18:42:13 +0100 (CET)
Message-ID: <19ea39c87df3c54cbc487466f806bc157d0bf563.camel@freebox.fr>
Subject: Re: [regression] Bug 216753 - 6e 6 ghz bands are disabled since
 5.16 on intel ax211
From:   Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:     Dave Chiluk <chiluk@ubuntu.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 02 Dec 2022 18:42:13 +0100
In-Reply-To: <CAMfi-DQfuro4c_VUrFHBTv8sPnwuV8XhTV_W7qswGeCC2t-wzg@mail.gmail.com>
References: <14722778-dda0-cb9f-8647-892493d94a5c@leemhuis.info>
         <2026016246ef719605c9932feeb56b105833593b.camel@intel.com>
         <CAMfi-DRE-u5TNu2zAL-7A-ENHM9EiJeYJ38BL_FMdk6QmW7c9w@mail.gmail.com>
         <9a03c244-adff-afaf-7385-d8e89cd3f338@leemhuis.info>
         <02F8DDF1-EC0D-4EBD-88F5-7E000841C337@holtmann.org>
         <CAMfi-DQfuro4c_VUrFHBTv8sPnwuV8XhTV_W7qswGeCC2t-wzg@mail.gmail.com>
Organization: Freebox
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2022-12-02 at 11:18 -0600, Dave Chiluk wrote:

Hello,

> The 6ghz band becomes disabled as soon as I upgrade to the 5.16+
> linux-stable kernels. So from a user perspective this really is a
> case of a kernel upgrade breaking user-space.  This is what led me
> down this rabbit hole here.
 
FWIW

I have the same issue on a Lenovo T14 gen2 laptop with built-in ax210
card, and sold as Wifi-6E compliant.

The exact patch you mention causes the issue, so it seems my bios does
not return the correct values either.

I recompiled the kernel with all those cmd_allow_xxx bitmaps set to ~0
and 6Ghz works fine.

-- 
Maxime



