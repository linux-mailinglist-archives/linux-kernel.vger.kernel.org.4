Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7509B64171A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 14:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLCNme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 08:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLCNmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 08:42:32 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EADA1FF99
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 05:42:31 -0800 (PST)
Received: from zn.tnic (p200300ea9733e766329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e766:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BD9EB1EC0688;
        Sat,  3 Dec 2022 14:42:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670074949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3OkboOdtBIuEaACyZ7ukF7EY+b+p0wAmPGIlUk6E6jY=;
        b=J6JYn0X7bcI8A5l+APU4cJJsV1l4drmH9Uj1sn0aoLA4l5N01LC2m5eXDaVZNgAmkVUyyx
        uvS0lGBHXUAOkw00fgYpYY8OvdcRQ8FUR2o2ZWzA21nb2gPBnIxP9bd7bv3VoPfvB24WIj
        qUxYBN2v4KQxnLmF3YQ1MxaRnLtTPQk=
Date:   Sat, 3 Dec 2022 14:42:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, alison.schofield@intel.com,
        reinette.chatre@intel.com
Subject: Re: [Patch V1 1/7] x86/microcode/intel: Remove redundant microcode
 rev pr_info()s
Message-ID: <Y4tSQOjOe05ZywcT@zn.tnic>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-2-ashok.raj@intel.com>
 <87cz91pr8d.ffs@tglx>
 <Y4qX0uGWhqWO3vee@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y4qX0uGWhqWO3vee@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 04:26:58PM -0800, Ashok Raj wrote:
> This code in collect_cpu_info() simply checks with a static variable "prev",
> but when multiple CPUs are running this in parallel it is racy and we notice

For the future:

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

I've fixed it up and the rest now.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
