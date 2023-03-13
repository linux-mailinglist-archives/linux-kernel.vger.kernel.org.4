Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1641A6B75CE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCMLUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCMLTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:19:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0A21CAD0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:19:42 -0700 (PDT)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1DA781EC0622;
        Mon, 13 Mar 2023 12:14:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678706066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=q4K/luGIvNlfTYgfX/OXMxPl2jFxTBSD3xwYqJRQPEY=;
        b=CipRRVa/2qmn3LcWD77C8VUGaZquEytQi1frTALmD5bexg9E4SDyHPGr4DFP/405GeMfNt
        91ikntoQQWDaF/x9KMzorsBapf0JESpdRo7AgrqRbRJosh0KF09q67LKDMUeYDdORpihDw
        6TyhL9MQ5SmX6qfucskTKG2Uog0XYgc=
Date:   Mon, 13 Mar 2023 12:14:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Saurabh Singh Sengar <ssengar@microsoft.com>
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "johan+linaro@kernel.org" <johan+linaro@kernel.org>,
        "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rahul.tanwar@linux.intel.com" <rahul.tanwar@linux.intel.com>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
Subject: Re: [EXTERNAL] Re: [PATCH] x86/ioapic: Don't return 0 as valid virq
Message-ID: <20230313111425.GDZA8Fkar9Z9BzSImD@fat_crate.local>
References: <1677785686-2152-1-git-send-email-ssengar@linux.microsoft.com>
 <20230312204019.GBZA44s28AOAfAcRuy@fat_crate.local>
 <PUZP153MB074987B356FCB28933B87CCBBEB99@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PUZP153MB074987B356FCB28933B87CCBBEB99@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 03:29:32AM +0000, Saurabh Singh Sengar wrote:
> To be specific in our system which is a guest VM we don't need IO-APIC and hence
> there is no device tree node for it. It is observed that we get irq 0 assigned to PCI-MSI.

This should be added to your commit message: what guest VM is that and
why should the kernel support it.

Why doesn't it need an IO-APIC and why does the current code need to be
changed just for your guest VM?

What else needs to be changed so that your VM works?

Where is that VM's documentation and why can't that VM be fixed *not* to
need kernel changes? IOW, why can't that VM emulate an IO-APIC like the
others do...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
