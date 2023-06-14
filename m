Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDA972F928
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243995AbjFNJaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244070AbjFNJ3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:29:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEB72682;
        Wed, 14 Jun 2023 02:29:24 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1792E1EC00F4;
        Wed, 14 Jun 2023 11:29:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686734963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8k+6jJEVJoZTqOUj9QUvqXMUO9GXbLi0/V6q/gD+tFs=;
        b=N55rm25dRExNAQMQyvons6hy3uKjD5/JJ1q6q47RRHFh/5VABi+/WBznUW5NBQ4vGKdY84
        xcaaTe2RCWgHaOu247f32/HhvJ9o2y+aALstSq9orpjYOXX2FgPzJQjhDaRMaEoO3GYTKI
        ajRS7JoUa8jslwq0iFiXKdwrJNIfnQY=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id n0BT1l2euxVO; Wed, 14 Jun 2023 09:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686734957; bh=8k+6jJEVJoZTqOUj9QUvqXMUO9GXbLi0/V6q/gD+tFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eqMIfI0RGo7ICofz9EdmvsqSMf4nAqwkM5xkCFW+YWfgXnvZ77XQgqpV0AMYJ9DXv
         T9tse8DP+pvQ/3oLE8z8Et3oNw6l7v+Kj0HkhbAq5+Y9pMnepBSOZO8UtJFHfDnFj5
         9a332CHdqQY0SR5WA9Tlnp3HaN88KNlp64YBOSyBtEsRlgJmbHMp4r9eK2kFhNDy62
         g+tWPqNCyqH5fmWbWbWNgqXlKsJHBzyzTpfJ7XPS58pOx6oE4pJMOuuhsE1jKMkveN
         S3NKCUHSk3dyJ4Owa+bFN5+g0Hzo4IwZ4n5/iSn1FRlD95XyhNMhisyk41lthsFJWN
         Tam7jPTpfMzuh9uZicpI73juxgJ1qk8tUXz1J18NFCQ5kLnu3beq09/Wwie0z9PFuN
         eVNf6K6b8DTcchTeskwD76PIWQ+87BSCzRGL/Gn6mGnyxjwTrgl3uoynJj9Tbn+XB0
         CjPBBjN3e8L2CAOWD1gg+ZijSBtzJStIOnEYxCdHUlqsQxyIOiPCbUjPMqNJQxxSwp
         qCZTNxT/rBiBVm1ewM9m9CnB/G4hwKd5HJSNyJQSrSOhEYCVILK1v0LrWMwFiE80hO
         UzF/tf2Ry4gQOhM2VdCwAnE+z6YW/B7UlRUpHovMHxoNAtvKSJjqRANXJI4etgzNL1
         8QwOAiaKxOAYFU288tLPywCs=
Received: from zn.tnic (p200300EA971Dc5F7329c23ffFeA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5f7:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A09940E018C;
        Wed, 14 Jun 2023 09:28:45 +0000 (UTC)
Date:   Wed, 14 Jun 2023 11:28:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [patch 01/17] init: Provide arch_cpu_finalize_init()
Message-ID: <20230614092838.GQZImIRoYexfx6qojn@fat_crate.local>
References: <20230613223827.532680283@linutronix.de>
 <20230613224544.957805717@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230613224544.957805717@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just typos:

On Wed, Jun 14, 2023 at 01:39:22AM +0200, Thomas Gleixner wrote:
> check_bugs() has become a dump ground for all sorts of activities to

"dumping ground"

> finalize the CPU initialization before running the rest of the init code.
> 
> Most are empty, a few do actual bug checks, some do alternative patching
> and some cobble a CPU advertisment string together....

advertisement

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
