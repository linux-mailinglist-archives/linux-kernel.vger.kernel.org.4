Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D165F206B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 00:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiJAWqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 18:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiJAWp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 18:45:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B0B3FA1F;
        Sat,  1 Oct 2022 15:45:57 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7b3329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7b3:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1FBFA1EC0657;
        Sun,  2 Oct 2022 00:45:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664664352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=78ArbpS+MX7FxuZXq49R157qE0Wc8Xe7wlyjEwfZans=;
        b=EddN4d5SoC1sFt620IUcnZsknZ3P+dlpL5H+cYZkJofAn6uB6+nXDQrmbGtY1krLjZhFzf
        haIm1nyN2qI8dlSKYRlQ1KoqcM+LtkTbU1YAhEZtav1t6Cei0ACeyuVn33GJHirguwBYzP
        LkLNLlSLb7oHSjnZqQgGnqAdRh+lXQQ=
Date:   Sun, 2 Oct 2022 00:45:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>, barebox@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: x86: boot: reserve type_of_loader=13 for
 barebox
Message-ID: <YzjDHOWkIoWF+h/R@zn.tnic>
References: <20220513143039.2065756-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220513143039.2065756-1-a.fatoum@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 04:30:39PM +0200, Ahmad Fatoum wrote:
> barebox built as EFI payload has been booting Linux on x86 with
> type_of_loader=0xff since v2015.09.0.

What is barebox?

That https://en.wikipedia.org/wiki/Barebox ?

That version number v2015 - am I to understand it that it has been
booting Linux since the year 2015?

In any case, it would be useful to explain a bit what it is here.

> Reserve 13, the next free id, so this can be used instead.

Sure, I guess, why not.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
