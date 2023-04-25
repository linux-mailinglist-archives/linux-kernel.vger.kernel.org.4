Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C796A6EE85A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbjDYTjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbjDYTjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:39:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4211A72A9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:39:18 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 82E981EC04CC;
        Tue, 25 Apr 2023 21:39:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1682451556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dtDpwhH/eF7nujITf5tyXIA/HB8iR8Wmip3v0q2BBSY=;
        b=NZ1kbLWitUL7dZCwT98uleHuQpLdEpKwrZvGhXP3lvgx1stZMKWG7QFSUF1ToRRw0T9GLf
        gGUxHzxNgonV1Tigds6meySi+463XrAGXaYfUnS6RkJQI0zn2EB8FUeB1Y3ccaluYahtTu
        w4zIYqJ8bHDP3UkQka58P5djpNtGVF0=
Date:   Tue, 25 Apr 2023 21:39:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Battersby <tonyb@cybernetics.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
Message-ID: <20230425193912.GEZEgsYDAsLn0EBAcH@fat_crate.local>
References: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 03:26:53PM -0400, Tony Battersby wrote:
> In stop_this_cpu(), make sure the CPUID leaf exists before accessing the
> leaf.  This fixes a lockup on poweroff 50% of the time due to the wrong
> branch being taken randomly on some CPUs (seen on Supermicro X8DTH-6F
> with Intel Xeon X5650).

Please send the output of

cpuid -r

from that machine.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
