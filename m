Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8417F63594D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbiKWKLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbiKWKKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:10:51 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAA01181E1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:59:43 -0800 (PST)
Received: from zn.tnic (p200300ea9733e747329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e747:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B61ED1EC064F;
        Wed, 23 Nov 2022 10:59:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669197581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=u1i437lpn9KHKObubQH4yvDnFno57PlU0vp5kJr8sQg=;
        b=hdKt83s76+XYlNj/p8/Nfn9511n4sQ8otsNWD/NlI5yNUyqc77F1aoN0SA4H9IuVgQIEW2
        s6O90LK4ZizdPlM7BL7w8dxtx/lDTz0VfvTEADj7TZVvtk53D5kBshsyUnGTK9kO1ZhJ9o
        1PsSW8q7TuorYr8PVrWhp5m+pcIgi8Y=
Date:   Wed, 23 Nov 2022 10:59:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RDTSCP | IA32_TSC_AUX on x86-32
Message-ID: <Y33vAaDu84tU8jf6@zn.tnic>
References: <Y33r3w6xvEeZH2XY@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y33r3w6xvEeZH2XY@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:46:07AM +0100, Sebastian Andrzej Siewior wrote:
> Is the format OS specific and not for user purpose or could IA32_TSC_AUX
> be setup on 32bit?

I don't see why not.

I mean, we wanna remove 32-bit but if you wanna still improve it...

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
