Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1C869FE75
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjBVW0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjBVW0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:26:49 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE1342BFF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:26:48 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E1AA1EC068E;
        Wed, 22 Feb 2023 23:26:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677104807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CckqgvvmPrDe6wflsMirPaSBLHFMgaErm6FSkK35NQY=;
        b=Vf6VZCVwCO8GdbaE5luLsmQ16m/cABumBzdSLic+zQRnRzlMYq9amJydYEWi0/O6hPDVtS
        f09GqyZI5HjEVyxDcd0gVHnMfP2q22yC5wHz4LsNe7lomCdRX5eDirkk/IXlat9FkcKHgG
        FUvI/9fwQzQXOlP3RCDoMeJFpt7JBxw=
Date:   Wed, 22 Feb 2023 23:26:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Tavis Ormandy <taviso@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: x86: AMD Zen2 ymm registers rolling back
Message-ID: <Y/aWputqWVAN0cJt@zn.tnic>
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
 <Y/XTT59OrLw2as4R@zn.tnic>
 <Y/Xc+yMzI83WZ4V1@zn.tnic>
 <0371ec3d-0899-f94a-7f21-21d805df2927@citrix.com>
 <Y/Xp73KJe3c/1jrn@zn.tnic>
 <Y/aIjUr78yd9U+wl@thinkstation.cmpxchg8b.net>
 <f074e03d-a991-23cd-80d7-162067143034@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f074e03d-a991-23cd-80d7-162067143034@citrix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 10:17:35PM +0000, Andrew Cooper wrote:
> I don't see anything in your code which would cause a change in MXCSR. 
> Which most likely means there's a path in the kernel modifying MXCSR and
> that doesn't sound like a thing that ought to be happening by default.

We were just talking about this internally too. We could trace it to see
what fiddles with MXCSR but meh, bigger fish to fry.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
