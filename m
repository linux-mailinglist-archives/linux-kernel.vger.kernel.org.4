Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7227D6649FE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbjAJS3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239332AbjAJS15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:27:57 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD0258307;
        Tue, 10 Jan 2023 10:23:10 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E6E5B1EC0528;
        Tue, 10 Jan 2023 19:23:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673374989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZmuEELBMorsapkkhcWcDu0/8ygp6XadNugGKGkiLFRA=;
        b=ijGU1kTHM3RbRrGLN8eVo+QfGdwOIIL1+9yfKLWfzp3S9kcYhJ/PKgCvdgu09FFczJxqz3
        c3gS9uFX0/Jc+I86lLa0JLj3Df2BTP17ym4MCuGyQlwvG3lmZtxLjm/8bKEwF6STUpXamX
        8y2nT3eykBC59tnVQZ+oZFKpOSNQQS4=
Date:   Tue, 10 Jan 2023 19:23:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kishon Vijay Abraham I <kvijayab@amd.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Santosh Shukla <santosh.shukla@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Borislav Petkov <bpetkov@amd.com>,
        Leo Duran <leo.duran@amd.com>
Subject: Re: [PATCH v2] x86/acpi/boot: Do not register processors that cannot
 be onlined for x2apic
Message-ID: <Y72tCRasZS6AUXDa@zn.tnic>
References: <20230105041059.39366-1-kvijayab@amd.com>
 <CAJZ5v0g1Mu8ip68one_gsAR3xmyua+6m1uJqb3n92xxYWeR+FA@mail.gmail.com>
 <Y7dNjHXJJwzCtYOY@zn.tnic>
 <CAJZ5v0iq1_kSOXuBcteXrCJR0NyyBVXcio_L=47oKrACT1oaZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iq1_kSOXuBcteXrCJR0NyyBVXcio_L=47oKrACT1oaZQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 02:03:48PM +0100, Rafael J. Wysocki wrote:
> Just please let me know if I need to take care of it. :-)

You don't. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
