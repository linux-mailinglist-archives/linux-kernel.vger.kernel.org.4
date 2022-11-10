Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F1B623F46
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiKJKCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiKJKCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:02:18 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD622DE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:02:17 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7bc329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7bc:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9C2B01EC0426;
        Thu, 10 Nov 2022 11:02:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668074535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XDhBjDXCzbycjnwrT7jhbVqkJO/S6Vr2zrhG8Lfpxzc=;
        b=DLRSSkxQdnVoq7iYZJrZ9Cy37nXMqGVLIW9c1o/uuJ6Fx8GezRZQiX4L3NZK4sXiAAQv+y
        Ds7edzbjIQTlI/jEn7ixGtOWBtfNY4n4PeNreC1MdvwGW2Je/lXfxshgI9JmPAZcUa97pQ
        fb/ZJb7U+znkwW/Ig2rkVEFQeFcuGH8=
Date:   Thu, 10 Nov 2022 11:02:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH v7 2/5] x86: Add cmdline_prepare() helper
Message-ID: <Y2zMJ5mRaW/h52Ug@zn.tnic>
References: <cover.1664886978.git.baskov@ispras.ru>
 <603dc95beb44340aa1787328589ff2e073b251e1.1664886978.git.baskov@ispras.ru>
 <Y2wvjmpwpOWsc5WT@zn.tnic>
 <7e718c64442469cce6b68988c607a240@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e718c64442469cce6b68988c607a240@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 11:59:49AM +0300, Evgeniy Baskov wrote:
> Well, my version takes one less copy... But clarity is more important
> in the kernel, I guess.

Yap, you guessed right.

I'd prefer to have the code plain and simple and easy to "reload" into
my L1 instead of having to parse it again in months, years from now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
