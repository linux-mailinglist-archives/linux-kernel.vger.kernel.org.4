Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41F16D8999
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjDEVfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDEVfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:35:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5681A5259
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:35:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E314E6414C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 21:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BB1C433AF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 21:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680730505;
        bh=cjiTXBmQgK6HvYB6yUnrD3p0Tq770yHiircAii49rZM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dOW9j4OxBqmQA1QRUHtmy+KdjtT8k5pmYnoF8suO17Z0OZ8KX+18Vbw3/tZu50RqJ
         PQjxWsMtduybWuZsYVVz6z66euJDBQ+4oeCknE6Fu9AUfRDaZ5peZkJgbBUZg80GNO
         LUmzJPm3b1tP0xQEj8VsfxSqWp+VrmMLm7OlokNPDJKPfSNFA5MozXqzbXFGmRVU0h
         Q81WlsjgPAKs4GkQtSffn8xLx7NkCqx+mjkoZuK6+JA7WNVhL4iwJ492dmrroiJW5A
         Ika9wbhym4IKyCYVd78vC1reX1wpn2LVR9Ldybqmjmlr3Bu6QTW1F0r0tjXYM0cZ65
         oPr7BgwwffQYQ==
Received: by mail-lf1-f54.google.com with SMTP id y15so48443226lfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 14:35:05 -0700 (PDT)
X-Gm-Message-State: AAQBX9cF0LMbuFJPboRMLYn12/1NOkHkBXDDOEDq10XKYMKDZiv/amal
        5GmY4I73yUm77uD+sh6+5mmFgwyUU1fu4Rnq8hM=
X-Google-Smtp-Source: AKy350Yy0Fr4PxGVRM7fFKCSF0i0pFBVOII0OBWGSkNWnCb9/+flCLz/wEm22fukE5qQ/GEMs4X0LSWo1bwqexjLk6U=
X-Received: by 2002:ac2:4910:0:b0:4eb:c44:ed50 with SMTP id
 n16-20020ac24910000000b004eb0c44ed50mr2400474lfi.9.1680730503081; Wed, 05 Apr
 2023 14:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <bc9e6d82-c7c1-47dc-e91f-57d9b4e2bb0a@intel.com>
 <20230404180917.4fsgkzcdhqvph6io@box.shutemov.name> <CAMj1kXF0XyEOuSUDqgsLSYK8GSkGN1xK3RQ525+BxhG+7+vnCA@mail.gmail.com>
 <20230404202445.6qkl7hz67qgievqz@box.shutemov.name> <CAMj1kXFrm74+zNcSpHJ1kw38PTMOFk1cTx_EAoGFHaG1fYzRTQ@mail.gmail.com>
 <20230404210153.tll2mojlglx4rfsa@box.shutemov.name> <CAMj1kXGvcg-E84h1T_vPi7qxPWxEXBpyuB79KOL+ON7v5YAgJg@mail.gmail.com>
 <e46777d3-adea-90a2-afc4-35f9d7cef50c@intel.com> <CAMj1kXEDYa5YcRj7t9JJmQ21+ierue2q6ADOXUOMjoOGndGRug@mail.gmail.com>
 <969a3d2a-52e7-e60e-5de6-c550c548730d@intel.com> <20230405190636.4mrq2daz6a23yhvr@box.shutemov.name>
 <7dd9297f-b065-2ace-1c77-22dd0126c526@amd.com> <96513ddd-ee87-5fae-cb5c-79d0120fd326@intel.com>
In-Reply-To: <96513ddd-ee87-5fae-cb5c-79d0120fd326@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 5 Apr 2023 23:34:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEMf=qkZv_CroNXmg_VP3ESUWa3Ba8AK4OyNBACsFq74w@mail.gmail.com>
Message-ID: <CAMj1kXEMf=qkZv_CroNXmg_VP3ESUWa3Ba8AK4OyNBACsFq74w@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] x86/efi: Safely enable unaccepted memory in UEFI
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Min M. Xu" <min.m.xu@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jiewen Yao <jiewen.yao@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023 at 23:23, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 4/5/23 13:11, Tom Lendacky wrote:
> >>> The thing that worries me is the "Near future firmware" where someone
> >>> runs a ~6.4 kernel and has a fast boot experience.  They upgrade to a
> >>> newer, "dropped protocol" kernel and their boot gets slower.
> >
> > Right, so that is what begs the question of when to actually drop the
> > call. Or does it really need to be dropped? It's a small patch to
> > execute a boot services call, I guess I don't see the big deal of it
> > being there.
> > If the firmware still has the protocol, the call is made, if it doesn't,
> > its not. In the overall support for unaccepted memory, this seems to be
> > a very minor piece.
>
> I honestly don't think it's a big deal either, at least on the kernel
> side.  Maybe it's a bigger deal to the firmware folks on their side.
>
> So, the corrected table looks something like this:
>
>               |                   Kernel                   |
>               |                                            |
>               | Unenlightened | Enlightened | Dropped UEFI |
> Firmware      |     ~5.19??   |    ~6.4??   | protocol     |
>               |---------------+-------------+--------------|
> Deployed      |   Slow boot   |  Slow boot  |  Slow boot   |
> Near future   |   Slow boot   |  Fast boot  |  Slow boot   |
> Far future    |  2GB limited  |  Fast Boot  |  Fast boot   |
>

I don't think there is any agreement on the firmware side on what
constitutes are reasonable minimum to accept when lazy accept is in
use, so the 2 GiB is really the upper bound here, and it could
substantially less.

>
> But, honestly, I don't see much benefit to the "dropped UEFI protocol".
> It adds complexity and will represent a regression either in boot
> speeds, or in unenlightened kernels losing RAM when moving to newer
> firmware.  Neither of those is great.
>
> Looking at this _purely_ from the kernel perspective, I think I'd prefer
> this situation:
>
>           |            Kernel           |
>           |                             |
>           | Unenlightened | Enlightened |
> Firmware  |     ~5.19??   |    ~6.4??   |
>           |---------------+-------------+
> Deployed  |   Slow boot   |  Slow boot  |
> Future    |   Slow boot   |  Fast boot  |
>
> and not have future firmware drop support for the handshake protocol.
> That way there are no potential regressions.
>
> Is there a compelling reason on the firmware side to drop the
> ExitBootServices() protocol that I'm missing?

The protocol only exists to stop the firmware from eagerly accepting
all memory on behalf of the OS. So from the firmware side, it would be
more about removing that functionality (making the protocol call moot)
rather than removing the protocol itself.
