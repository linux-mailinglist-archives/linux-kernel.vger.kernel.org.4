Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16B86D38BF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 17:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjDBPS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 11:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjDBPSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 11:18:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5985CD50C;
        Sun,  2 Apr 2023 08:18:21 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B69FD1EC0464;
        Sun,  2 Apr 2023 17:18:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680448699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Mwbu0BOdpcYqXKzNyR5HnigTzatDNuF8xi3A7B6y2jE=;
        b=ZqMrzBPCc8nwlqiXjiOHgWOSCEwabSblwHfY0XGG6kadYYyMzdKQjLHCB9StWtCgqlk9+L
        1JqmkZrLVmociui2Jf0K2f9SfwsaAxCvKo/bVritU7GEY3mj2nOFAR7HuWA8cS1tzw/1hl
        SUbCsP+PD2XTxUDGz7Hg1VKlnwWbQiY=
Date:   Sun, 2 Apr 2023 17:18:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Guy Durrieu <guy.durrieu@cegetel.net>
Cc:     Kishon Vijay Abraham I <kvijayab@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Santosh Shukla <santosh.shukla@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Borislav Petkov <bpetkov@amd.com>,
        Leo Duran <leo.duran@amd.com>, 1033732@bugs.debian.org
Subject: Re: [PATCH v2] x86/acpi/boot: Do not register processors that cannot
 be onlined for x2apic
Message-ID: <20230402151815.GBZCmct1V23I9lntIy@fat_crate.local>
References: <20230105041059.39366-1-kvijayab@amd.com>
 <c02a2a2f-2b40-e13e-ac40-e5d19a66b5ba@cegetel.net>
 <D2229CD1-CD5F-49E9-A0F5-BAB3940B6BFB@alien8.de>
 <961f96d3-df1c-483d-f681-42a291d88740@cegetel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <961f96d3-df1c-483d-f681-42a291d88740@cegetel.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 03:13:05PM +0200, Guy Durrieu wrote:
> Yes it does.

Thanks for testing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
