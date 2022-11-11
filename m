Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A45625E83
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiKKPjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbiKKPjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:39:32 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DF978788;
        Fri, 11 Nov 2022 07:39:20 -0800 (PST)
Received: from zn.tnic (p200300ea9733e727329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e727:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D48991EC0531;
        Fri, 11 Nov 2022 16:39:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668181158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TdG7wb8HM5MgOVAWd4BsZgaZcW/gFrUw0L4OXVxvb+U=;
        b=NzKVxiLo2bw/ysdw5HhuMvpGG9Lg5g3HMV0ZC93TbjFNIfn8RAiAM7kPRrQ+LAletjbQEn
        NQONnYAOX28IuSCDnv0On3Y7rYydW6SgChHr4S9nYjpl72lrdq+ysCiIG+xtcN/r3RmKcz
        R3il+dxO0gl1sqDpFtGFgp77kv8LpP8=
Date:   Fri, 11 Nov 2022 16:39:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yupeng Li <liyupeng@zbhlos.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "caizp2008@163.com" <caizp2008@163.com>,
        "smf-linux@virginmedia.com" <smf-linux@virginmedia.com>
Subject: Re: [PATCH 1/1] platform/x86/amd: Fix pmc compile dependency errors.
Message-ID: <Y25sohHGkdAn5OZD@zn.tnic>
References: <20221026072531.346013-1-liyupeng@zbhlos.com>
 <0910bcc4-d55f-6f3a-b2df-4e30d164aeeb@redhat.com>
 <721f6a1a-1144-4fe4-e722-2ba2d7200680@amd.com>
 <Y25m8tPTtyfHOCfK@zn.tnic>
 <MN0PR12MB6101AB9F2AD8A41CE3EC5650E2009@MN0PR12MB6101.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MN0PR12MB6101AB9F2AD8A41CE3EC5650E2009@MN0PR12MB6101.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 03:16:10PM +0000, Limonciello, Mario wrote:
> I sent up a patch for it, but Hans hasn't applied it.
> https://patchwork.kernel.org/project/platform-driver-x86/patch/20221108023323.19304-1-mario.limonciello@amd.com/

Yap, that fixes it.

So yeah, Hans, make sure to Cc: stable too when applying.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
