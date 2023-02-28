Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69A06A5F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjB1T31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB1T30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:29:26 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EC215541
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:29:24 -0800 (PST)
Received: from [10.10.3.121] (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id 549B640770DC;
        Tue, 28 Feb 2023 19:29:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 549B640770DC
Date:   Tue, 28 Feb 2023 22:29:23 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Tavis Ormandy <taviso@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: x86: AMD Zen2 ymm registers rolling back
In-Reply-To: <Y/5VIECduoyCJKP5@zn.tnic>
Message-ID: <4d21fe93-7b77-bf5a-9ba8-645256ab0983@ispras.ru>
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net> <Y/XTT59OrLw2as4R@zn.tnic> <Y/Xc+yMzI83WZ4V1@zn.tnic> <0371ec3d-0899-f94a-7f21-21d805df2927@citrix.com> <Y/Xp73KJe3c/1jrn@zn.tnic> <4737f149-c5b7-8a51-7cc5-8bda6e98308b@ispras.ru> <Y/5T4ScbM/99DhgT@zn.tnic>
 <3d007f98-a42a-3c0e-8d6a-c86c5d0e25be@ispras.ru> <Y/5VIECduoyCJKP5@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Feb 2023, Borislav Petkov wrote:

> On Tue, Feb 28, 2023 at 10:24:40PM +0300, Alexander Monakov wrote:
> > No, on the contrary, if there were no updates I would not be able to
> > see microcode version increase after updating.
> 
> So what are you saying then?

That I can reproduce the bug even with the latest BIOS, i.e. the microcode
in the latest BIOS update does not have the fix, and the linux-firmware.git
microcode does not have a patch for this CPU family at all.

Hence the question how to get fixed microcode for this CPU family.

Alexander
