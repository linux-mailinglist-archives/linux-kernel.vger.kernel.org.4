Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506B76870D0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 23:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjBAWGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 17:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBAWGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 17:06:11 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564576A73D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 14:06:07 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A36541EC0589;
        Wed,  1 Feb 2023 23:06:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675289165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=b3gZvM6huGXVVG3W2e9OcDbnQ7rK6QGd/aRpIVIu8L0=;
        b=TgvlxR0P6qI7FX9YTui2pqgClEP3qMs71ZIqb+82M+ClDqmUAbhtSdF0i7SZWieuGPcsEx
        J948xMgzco1EMOgYOy00feB2hGuCK8ES1YrFcOqQ8ueDasQ4I9p/cYXg81FxLEj5YCnohS
        tLAPM2/eIxD7eVFWqQeXX1TtMU/2W+8=
Date:   Wed, 1 Feb 2023 23:06:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>,
        "Li, Aubrey" <aubrey.li@intel.com>
Subject: Re: [Patch v3 Part2 1/9] x86/microcode: Taint kernel only if
 microcode loading was successful
Message-ID: <Y9riTY4KOK+6tMt5@zn.tnic>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-2-ashok.raj@intel.com>
 <Y9kAlKFfdek2rq6g@zn.tnic>
 <Y9lHDWjjnqdletL3@a4bf019067fa.jf.intel.com>
 <Y9l4FdvytLqMc3jm@zn.tnic>
 <Y9mcCxYK/VPB0ATM@a4bf019067fa.jf.intel.com>
 <Y9perwfaheZqAJWl@zn.tnic>
 <Y9reDitxHgzcrsOY@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y9reDitxHgzcrsOY@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 01:47:58PM -0800, Ashok Raj wrote:
> While reworking I thought while at this, there is a chance to fix other
> things.

Your call. The more you're "fixing" other things, the longer it takes
for your minrev thing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
