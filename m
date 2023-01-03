Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB3D65C508
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjACR36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjACR3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:29:54 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53880F5BF;
        Tue,  3 Jan 2023 09:29:54 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E4D111EC0513;
        Tue,  3 Jan 2023 18:29:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672766993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1r4iEnMJZBtQVtQ31Qtnnm94XCWAgBgbs/1DzfmPGXQ=;
        b=Wp8aAQSKaSaJzFRjjha61fGXv7vkl1HOwYxKb8p+0EduGRpLgxUqVZ/g7rc32SBSj6sZ0a
        S8tPK5RS1MMEH5TwLh0E5eG0PD5HXXgLxaMBtmfe9P5f66jXFBebIw0+zTLBr+7VDIhKH4
        Nv+U3qjmiaIPPJuZLg6TrBfITNlVk4s=
Date:   Tue, 3 Jan 2023 18:29:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v14 1/7] x86: lib: Separate instruction decoder MMIO type
 from MMIO trace
Message-ID: <Y7RmDVI/ScoeBO2a@zn.tnic>
References: <20230101162910.710293-1-Jason@zx2c4.com>
 <20230101162910.710293-2-Jason@zx2c4.com>
 <Y7QELo9etPM8Tpx5@gmail.com>
 <Y7RA3bmko0AjO8hQ@zx2c4.com>
 <Y7RfPnyK/25pxpKs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7RfPnyK/25pxpKs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 06:00:46PM +0100, Ingo Molnar wrote:
> > I guess you missed the conversation with Borislav yesterday about that.
> > He mentioned that I'd just take it through random.git when this whole
> > series goes in.
> 
> Please base your tree off on tip:x86/asm then (or pull it in) - it only

My idea was a lot simpler: avoid the tree inter-dependency by us acking this
patch so that it can go through the random.git tree.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
