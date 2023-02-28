Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710F76A61B1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjB1VqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjB1Vpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:45:55 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976CD32E7A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:45:30 -0800 (PST)
Received: from [10.10.3.121] (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id 4076240770DE;
        Tue, 28 Feb 2023 21:45:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4076240770DE
Date:   Wed, 1 Mar 2023 00:45:08 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
cc:     Borislav Petkov <bp@alien8.de>, Tavis Ormandy <taviso@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: x86: AMD Zen2 ymm registers rolling back
In-Reply-To: <8eff0a18-7faa-1135-a558-40150f4443e5@citrix.com>
Message-ID: <a9ffb1f6-96ba-dab4-5f54-344e0abef4cd@ispras.ru>
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net> <Y/XTT59OrLw2as4R@zn.tnic> <Y/Xc+yMzI83WZ4V1@zn.tnic> <0371ec3d-0899-f94a-7f21-21d805df2927@citrix.com> <Y/Xp73KJe3c/1jrn@zn.tnic> <4737f149-c5b7-8a51-7cc5-8bda6e98308b@ispras.ru> <Y/5T4ScbM/99DhgT@zn.tnic>
 <3d007f98-a42a-3c0e-8d6a-c86c5d0e25be@ispras.ru> <Y/5VIECduoyCJKP5@zn.tnic> <4d21fe93-7b77-bf5a-9ba8-645256ab0983@ispras.ru> <8eff0a18-7faa-1135-a558-40150f4443e5@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Feb 2023, Andrew Cooper wrote:

> On 28/02/2023 7:29 pm, Alexander Monakov wrote:
> > On Tue, 28 Feb 2023, Borislav Petkov wrote:
> >
> > That I can reproduce the bug even with the latest BIOS, i.e. the microcode
> > in the latest BIOS update does not have the fix, and the linux-firmware.git
> > microcode does not have a patch for this CPU family at all.
> >
> > Hence the question how to get fixed microcode for this CPU family.
> 
> I shouldn't be recommending this, but I've begged AMD many times to be
> better at publishing microcode...
> 
> https://github.com/platomav/CPUMicrocodes
> 
> and you'll need
[snip script]

Thank you, this is good to have. Unfortunately, even with microcode 0x08600109
taken from that repo the issue is reproducible (it is dated 2022-03-28, so
perhaps not really surprising).

Alexander
