Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE615FA47B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJJUDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJJUD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:03:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765B378595
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:03:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C6B5B81084
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BD6C433C1;
        Mon, 10 Oct 2022 20:03:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fdyfYtzk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665432199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=89Q3T3yMhhbVwFxIAvbf+vOWn6AgU2lDiKYeMVH92xs=;
        b=fdyfYtzk4o9H0ewxiOE773p3+LkXx/3gbSnMaV/S4EIJekN8SlJQZRjuNh1e/PHLFfRA4j
        Nc6OvxV39VwS9eJFRpMd/wNaRejgEx2YEEiflTvjxpOxJKB1UHZIrUsOJDnHmTx8cmUVFR
        t3Zg0HwI28nrjxqlCJHNgjyqykAEUr0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 99b97fc5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 10 Oct 2022 20:03:19 +0000 (UTC)
Date:   Mon, 10 Oct 2022 14:03:09 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, ajd@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        christophe.leroy@csgroup.eu, cuigaosheng1@huawei.com,
        david@redhat.com, farosas@linux.ibm.com, geoff@infradead.org,
        gustavoars@kernel.org, haren@linux.ibm.com, hbathini@linux.ibm.com,
        joel@jms.id.au, lihuafei1@huawei.com, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, linuxppc-dev@lists.ozlabs.org,
        lukas.bulwahn@gmail.com, mikey@neuling.org, nathan@kernel.org,
        nathanl@linux.ibm.com, nicholas@linux.ibm.com, npiggin@gmail.com,
        pali@kernel.org, paul@paul-moore.com, rmclure@linux.ibm.com,
        ruscur@russell.cc, windhl@126.com,
        wsa+renesas@sang-engineering.com, ye.xingchen@zte.com.cn,
        yuanjilin@cdjrlc.com, zhengyongjun3@huawei.com
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-1 tag
Message-ID: <Y0R6fcvgGA858TQA@zx2c4.com>
References: <87edvhntv0.fsf@mpe.ellerman.id.au>
 <Y0RxpSFyn9m68zIb@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0RxpSFyn9m68zIb@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 01:25:25PM -0600, Jason A. Donenfeld wrote:
> Hi Michael,
> 
> On Sun, Oct 09, 2022 at 10:01:39PM +1100, Michael Ellerman wrote:
> > powerpc updates for 6.1
> > 
> >  - Remove our now never-true definitions for pgd_huge() and p4d_leaf().
> > 
> >  - Add pte_needs_flush() and huge_pmd_needs_flush() for 64-bit.
> > 
> >  - Add support for syscall wrappers.
> > 
> >  - Add support for KFENCE on 64-bit.
> > 
> >  - Update 64-bit HV KVM to use the new guest state entry/exit accounting API.
> > 
> >  - Support execute-only memory when using the Radix MMU (P9 or later).
> > 
> >  - Implement CONFIG_PARAVIRT_TIME_ACCOUNTING for pseries guests.
> > 
> >  - Updates to our linker script to move more data into read-only sections.
> > 
> >  - Allow the VDSO to be randomised on 32-bit.
> > 
> >  - Many other small features and fixes.
> 
> FYI, something in here broke the wireguard test suite, which runs the
> iperf3 networking utility. The full log is here [1], but the relevant part
> is: 
> 
> [+] NS1: iperf3 -Z -t 3 -c 192.168.241.2
> Connecting to host 192.168.241.2, port 5201
> iperf3: error - failed to read /dev/urandom: Bad address
> 
> I'll see if I can narrow it down a bit more and bisect. But just FYI, in
> case you have an intuition.

Huh. From iov_iter.c:

static int copyout(void __user *to, const void *from, size_t n)
{
        size_t before = n;
        if (should_fail_usercopy())
                return n;
        if (access_ok(to, n)) {
                instrument_copy_to_user(to, from, n);
                n = raw_copy_to_user(to, from, n);
                if (n == before)
                        pr_err("SARU n still %zu pointer is %lx\n", n, (unsigned long)to);
        }
        return n;
}

I added the pr_err() there to catch the failure:
[    3.443506] SARU n still 64 pointer is b78db000

Also I managed to extract the failing portion of iperf3 into something
smaller:

        int temp;
        char *x;
        ssize_t l;
        FILE *f;
        char template[] = "/blah-XXXXXX";

        temp = mkstemp(template);
        if (temp < 0)
                panic("mkstemp");
        if (unlink(template) < 0)
                panic("unlink");
        if (ftruncate(temp, 0x20000) < 0)
                panic("ftruncate");
        x = mmap(NULL, 0x20000, PROT_READ|PROT_WRITE, MAP_PRIVATE, temp, 0);
        if (x == MAP_FAILED)
                panic("mmap");
        f = fopen("/dev/urandom", "rb");
        if (!f)
                panic("fopen");
        setbuf(f, NULL);
        if (fread(x, 1, 0x20000, f) != 0x20000)
                panic("fread");

Jason
