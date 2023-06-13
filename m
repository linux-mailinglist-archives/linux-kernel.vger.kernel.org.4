Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCEF72DC89
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241290AbjFMIcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241262AbjFMIch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:32:37 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F9DD2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:32:36 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EBA8C1EC0674;
        Tue, 13 Jun 2023 10:32:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686645155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6P7m16HjSLkfJscuTlcRNl0ZdJBTKG8OShHHGfYxK90=;
        b=DBoTFWVhaW96moOzl2igDodpyJogFSy5jNNNF7S4POTUTGB1Lrm5j+D8I8+gc8tZvj3pdz
        Q/O0mXW1oj1uYK98isab/w76DV0nJmwG8dhwvRSvZLPryggqagTMg5o5w/F3UaVbouFYqL
        UOrxAtVytb9HdjiXGT/8VlG9owXNPgY=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id W7JC76o8M21I; Tue, 13 Jun 2023 08:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686645152; bh=6P7m16HjSLkfJscuTlcRNl0ZdJBTKG8OShHHGfYxK90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T9QR03aGGVAbUFwAtxtE2hXFqG0W6CA5Du0QaagjdBMTrGuC9YZmF6sT7rRIH0c8a
         fLcE12QBTD1fzvnIBITvvkuuzcR53ftf3tH5ldnmFS84bGlAKLZNu9mo/IlSlGs84s
         j0Nkw/iap6PO0e1xh8sq8k2mUGwrJkLUHq7hz4SMWoR6+/LRfS5fAQCkuOrucB3RYz
         BabzbJk1TLiWdgmXU1U5PUH327h1PGJlCAY0Rl1mLVZyednYZTJ0ujIWSP5QelIQ1z
         wRCuJjLj6OBK1CkVTZNSplAiNUW+KcH30D6btZt2lLKsxz7RCmYsSM22y4hXrwil29
         qirOLDNO0GsKadv1l2vYrNsSsHFKiwiQAyX/xThnJaJAGL8uULXDgmA5RVxLGeGmxm
         uVryn90aHvUbiLx45Z2Hfh0s2JmTtSc79aBsA/iNVykoKi2h6zCpqGy99UiNGDo0KU
         BkjhEvLBB39oo2lUAH8moeB7L0OxDV3dqpNVo8Leuawi8WkglLnmKUC/+R+e12nizO
         rlUxVzRGMydkOSTOvAPOPaoW1eKM0MJimF2+hPdXN6UwH+ftD5ZwfH0y+sIaWlmzHQ
         IMtB2YaZwl2qXWGoaHKkRbJC/TDaL/OHT2VX2wCMPsRbuf0CVAAuqlYvHAYhm65yiG
         h2/hyB8/XpewyA8Vdy7tPZWo=
Received: from zn.tnic (p200300eA971Dc5f0329c23FffEA6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5f0:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E928D40E01D0;
        Tue, 13 Jun 2023 08:32:28 +0000 (UTC)
Date:   Tue, 13 Jun 2023 10:32:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/microcode: Add a "microcode=" command line option
Message-ID: <20230613083224.GAZIgpmBjiuSZuYydZ@fat_crate.local>
References: <20230605141332.25948-1-bp@alien8.de>
 <20230605141332.25948-2-bp@alien8.de>
 <87ilbs7lcr.ffs@tglx>
 <20230612154246.GLZIc89v6Q2THgsY8N@fat_crate.local>
 <87a5x47fy0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5x47fy0.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just to sum up what we talked about on IRC:

Early loading already does per-thread loading unconditionally and it
doesn't have a chicken bit. I will do the chicken bit for both loading
methods but keep it out-of-tree if it turns out we need it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
