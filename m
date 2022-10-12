Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84635FC8A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiJLPtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJLPto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:49:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2830F5FA9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:49:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35148B819D9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAF3C433C1;
        Wed, 12 Oct 2022 15:49:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TVcwb+sD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665589771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sEJY6kxGt3K++qEJpsc82OJ4BtmSZSN54gq2VlWEBFg=;
        b=TVcwb+sDiv8pHFo7VlU5G+0n06uXQRtfazmJRQkwxofpxQuTnqwjnla23JrH+kUx6rXalQ
        uW3ocUuza5aZz+IzZsDvCOKjhFvAd3c9STVpJ+vgfeTnDB6mktPxI3L9cP0wCwMtpFVf8g
        RD/TmAoe8WPmTDokIRmk0Sao6J6g4Q4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c7a935e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 12 Oct 2022 15:49:30 +0000 (UTC)
Date:   Wed, 12 Oct 2022 09:49:26 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ajd@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, christophe.leroy@csgroup.eu,
        cuigaosheng1@huawei.com, david@redhat.com, farosas@linux.ibm.com,
        geoff@infradead.org, gustavoars@kernel.org, haren@linux.ibm.com,
        hbathini@linux.ibm.com, joel@jms.id.au, lihuafei1@huawei.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lukas.bulwahn@gmail.com, mikey@neuling.org, nathan@kernel.org,
        nathanl@linux.ibm.com, nicholas@linux.ibm.com, npiggin@gmail.com,
        pali@kernel.org, paul@paul-moore.com, rmclure@linux.ibm.com,
        ruscur@russell.cc, windhl@126.com,
        wsa+renesas@sang-engineering.com, ye.xingchen@zte.com.cn,
        yuanjilin@cdjrlc.com, zhengyongjun3@huawei.com
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-1 tag
Message-ID: <Y0biBtCUtc2mowbQ@zx2c4.com>
References: <87edvhntv0.fsf@mpe.ellerman.id.au>
 <20221012141827.GA2405914@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221012141827.GA2405914@roeck-us.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 07:18:27AM -0700, Guenter Roeck wrote:
> NIP [c000000000031630] .replay_soft_interrupts+0x60/0x300
> LR [c000000000031964] .arch_local_irq_restore+0x94/0x1c0
> Call Trace:
> [c000000007df3870] [c000000000031964] .arch_local_irq_restore+0x94/0x1c0 (unreliable)
> [c000000007df38f0] [c000000000f8a444] .__schedule+0x664/0xa50
> [c000000007df39d0] [c000000000f8a8b0] .schedule+0x80/0x140
> [c000000007df3a50] [c00000000092f0dc] .try_to_generate_entropy+0x118/0x174
> [c000000007df3b40] [c00000000092e2e4] .urandom_read_iter+0x74/0x140
> [c000000007df3bc0] [c0000000003b0044] .vfs_read+0x284/0x2d0
> [c000000007df3cd0] [c0000000003b0d2c] .ksys_read+0xdc/0x130
> [c000000007df3d80] [c00000000002a88c] .system_call_exception+0x19c/0x330
> [c000000007df3e10] [c00000000000c1d4] system_call_common+0xf4/0x258

Obviously the first couple lines of this concern me a bit. But I think
actually this might just be a catalyst for another bug. You could view
that function as basically just:

    while (something)
    	schedule();

And I guess in the process of calling the scheduler a lot, which toggles
interrupts a lot, something got wedged.

Curious, though, I did try to reproduce this, to no avail. My .config is
https://xn--4db.cc/rBvHWfDZ . What's yours?

Jason
