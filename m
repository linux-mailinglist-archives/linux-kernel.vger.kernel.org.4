Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EF961F7A7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiKGPal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiKGPae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:30:34 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F0613D20
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:30:32 -0800 (PST)
Received: from zn.tnic (p200300ea9733e71f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e71f:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 25C211EC0716;
        Mon,  7 Nov 2022 16:30:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667835031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QUo3Yz5ia9UMUQGTPgPFcFGdU9WNRAlf7H3KnO5VN4Q=;
        b=HSFUJUttLvRpbfId/bjL5ZOhWnD0ziekIu2cal3mX1/0FzlHMJUDZuIrjQE2BEdl5d5t5U
        37fg/Jlc8bCYy639dA15egpFLCta5pEMAC81JKOPBcbeYaZmSSuHpe8QQ4bob6rGZ188FE
        TwNW0iUgT9yWcx2SAP+ILxgHImghNGI=
Date:   Mon, 7 Nov 2022 16:30:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Fei Li <fei1.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        dave.hansen@intel.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, Yu1.Wang@intel.com, conghui.chen@intel.com,
        fengwei.yin@intel.com
Subject: Re: [PATCH v2] x86/acrn: Set X86_FEATURE_TSC_KNOWN_FREQ
Message-ID: <Y2kkk+XqBP3u6ObI@zn.tnic>
References: <20221101053019.174948-1-fei1.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221101053019.174948-1-fei1.li@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 01:30:19PM +0800, Fei Li wrote:
> If the TSC frequency is known from the acrn_get_tsc_khz(),
> the TSC frequency does not need to be recalibrated.

What if the HV has unstable TSCs? How do you handle that?

> Avoiding recalibration by setting X86_FEATURE_TSC_KNOWN_FREQ.

Pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details on how to
write your commit message.

> This patch also removes `inline` for acrn_get_tsc_khz() since
> it doesn't make sense.

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
