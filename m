Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D6E660E37
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 12:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjAGLH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 06:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAGLHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 06:07:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027A3633BC
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 03:07:22 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 955E51EC0589;
        Sat,  7 Jan 2023 12:07:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673089641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0i6K0pG76pJHv0ZwqzFVF+QAwoB1CdaSL07tYFcG50U=;
        b=qW9yj7BXjcZ4Lkp87A93fNt/AI/RGZUW2la/jC8kcvwED2axT9Gm8pmQWoMxB0HfLFFxin
        MJcd71tq9uIE6RSNzDUttBJT/ws3vMWhnI6AHMxfrS5GllA+htv335q4LNynMg3+ed/2A2
        N8vWKPkcuN4z06rq5fq5uV8JzyWBD28=
Date:   Sat, 7 Jan 2023 12:07:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com
Subject: Re: [BUG Report] undefined reference to `convert_to_fxsr'
Message-ID: <Y7lSZerjPghqllWp@zn.tnic>
References: <50aa72a7-043d-8091-78de-458cbcc6c356@huawei.com>
 <Y6w49Y1d3lpv3KFn@zn.tnic>
 <23e2907c-5188-5ac6-3db8-1c5a12120bf2@huawei.com>
 <Y62vbjBzHF4rmh1V@zn.tnic>
 <e041533c-4005-b9bc-3985-02224985aa28@huawei.com>
 <Y67IlthBqaX69RwN@zn.tnic>
 <64fe1be4-954f-fe6f-44f0-59b572548663@huawei.com>
 <Y7dZwWsiUfHKxN3S@zn.tnic>
 <d312c572-f232-a4e9-2ecc-023050528a29@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d312c572-f232-a4e9-2ecc-023050528a29@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2023 at 10:10:18AM +0800, Miaohe Lin wrote:
> And I cloned the code from https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git. It's a

No, please read my mail properly:

"What is that compiler you're using? Where did you get the package from? Does it
have some out-of-tree patches in it?"

I'm not asking you about the kernel but the *compiler*!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
