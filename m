Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA9165D199
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjADLj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjADLj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:39:27 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6778915720
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 03:39:25 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9C8DA1EC02FE;
        Wed,  4 Jan 2023 12:39:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672832363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+gClkcdwaOwO+NXTyvfxCTeJMJYk91I8QSHN3Wevzgs=;
        b=quQLtXte26cDRwWFBo4GkC9dckjhSQ+7NhJMBlpQIboJfuZA1w6TBYWKZbU8YXV/7cAdG1
        phlTL+z3yVchHt1zrSRuPONHejPfOjFqyolTuPMovbH86BPJiJzYfz9BWI/iYf5XE6/lBf
        27nBgU9Te7iQ+7OhbLuukqZMRF6O/tw=
Date:   Wed, 4 Jan 2023 12:39:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Daniel Verkamp <dverkamp@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] x86: also disable FSRM if ERMS is disabled
Message-ID: <Y7VlZsaWz4/b6Phf@zn.tnic>
References: <20220923005827.1533380-1-dverkamp@chromium.org>
 <Yy2U2BW6Tx0imGpK@zn.tnic>
 <CABVzXAk9AXj2Ns7YAh7cCA38t2sGxOEYLv-EfLCoFHr-SUQ2Mw@mail.gmail.com>
 <Yy3yJfz213Lqo4KC@zn.tnic>
 <CABVzXAkO4pU+gpUcWOEWDw+W4id=1WEOgeP5+3tBG_LR6=oa=g@mail.gmail.com>
 <1b184587-128d-e5cc-67e9-1d27feb87213@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b184587-128d-e5cc-67e9-1d27feb87213@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 08:43:51AM +0100, Jiri Slaby wrote:
> Let me resurrect this thread... Our customer has an AMD CPU which has indeed
> both capabilities under normal circumstances. But they have a cool UEFI BIOS
> too. They say:
> 
> """
> In AMD platform, while disalbe ERMS(Enhanced Rep MOVSB/STOSB) in UEFI
> (system setup -> processor -> Enhanced Rep MOVSB/STOSB), the OS can't boot
> normally.

Any particular reason they're disabling ERMS?

What do they set FSRM to?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
