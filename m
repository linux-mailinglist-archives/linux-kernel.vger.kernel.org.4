Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D14362D841
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiKQKk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiKQKkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:40:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09411D4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:40:20 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7de329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7de:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 32FA51EC06BD;
        Thu, 17 Nov 2022 11:40:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668681619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=v9d53AMzTDNJ48lo/Z9ImVNxZHde105TUW89d9bRoz0=;
        b=Jg6+fCBZLqD17u2TtLzeelEUAWzeXc0x7LjkP2hr3BP66WcGb14lhCrVZCbLzu8hgoVNQI
        SEkIGz87qTWAv+dEw/jByTWHF4M+KaL7AoUjdYSIttFEHmNSuT2TSWMLahqKXC/Bo+FmyD
        wve3QlNaewQo4MX3XNnKMtxiW8OaBHo=
Date:   Thu, 17 Nov 2022 11:40:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, nslusarek@gmx.net,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Fix sys_perf_event_open() race against self
Message-ID: <Y3YPjo5wdKGVw7c5@zn.tnic>
References: <20220520183806.GV2578@worktop.programming.kicks-ass.net>
 <700710fc-1ac1-1b39-0e63-eb86adb4b984@amd.com>
 <Y3Vkmvi2vib7fwHn@zn.tnic>
 <7bf54a3f-07f7-5471-f6c2-88d3d9bc7a5e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7bf54a3f-07f7-5471-f6c2-88d3d9bc7a5e@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 04:03:54PM +0530, Ravi Bangoria wrote:
> The issue was because of multiple event contexts involved. However,
> it's no longer the case with reworked event context.

I got that but it wouldn't hurt to have this test regardless, no?

More testing is pretty much always better...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
