Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B49A5F22F1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 13:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJBL3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 07:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJBL3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 07:29:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F408CB1EC;
        Sun,  2 Oct 2022 04:29:42 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7b3329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7b3:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 050C61EC0651;
        Sun,  2 Oct 2022 13:29:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664710177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mXgB1RZ/V6Z/XyTH7eYqcjjpYOHJfmCLuhQbmYcP9NY=;
        b=kbDs07KIuItGuEwk8YQR5T8RzC8PyRXEJuBnVu5GNiLDiy7/0NF6rLs/CEnNctMs6e25ih
        Ej5vgpO1X26zd10rcGm4BLXe0+SlEKYQt57x0T/64MLF00MP7b3i8i4woUYiCuhG6LpFDH
        C5D62J/H83rvv8J/I1TKzu/NkXkxC0g=
Date:   Sun, 2 Oct 2022 13:29:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>, barebox@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: x86: boot: reserve type_of_loader=13 for
 barebox
Message-ID: <Yzl2HWIiKPHP9F1I@zn.tnic>
References: <20220513143039.2065756-1-a.fatoum@pengutronix.de>
 <YzjDHOWkIoWF+h/R@zn.tnic>
 <5da3593c-1607-9075-e1ac-1e384fd62b93@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5da3593c-1607-9075-e1ac-1e384fd62b93@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 09:15:09AM +0200, Ahmad Fatoum wrote:
> Release cadence is monthly. Starting with release v2015.09.0,
> type_of_loader=0xff was being used. I figured it's about time, we
> allocate an ID for it.

Right, by "explain a bit what it is here" I meant to explain what it
is and add some references to the commit message. I.e., leave enough
breadcrumbs so that people like me can go and find that relevant info
when doing git archeology.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
