Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E2468DE27
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjBGQo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjBGQoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:44:25 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9F046BD;
        Tue,  7 Feb 2023 08:44:24 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 58EC21EC042F;
        Tue,  7 Feb 2023 17:44:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675788263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Wf6EXE8MgWaf7bVHOvRI0kZ2JeI5v6n9K1M463GjUsg=;
        b=Wt4dYqH77AlUz9FWGKp6uGPEhOiTXgzbK8Y3JZAr//o/uC2GNMjXOk9XmS6dwG2AgFZ5D+
        Jby/7vyMBrBKqVFPpcfaRB+nSW1AJmqfz114lvvqRLzwW59vMbLa4LLf4+fleSET4yQfMT
        7Igs9+AopfPCqIT/LEi/iGGMwunP6Hc=
Date:   Tue, 7 Feb 2023 17:44:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>, llvm@lists.linux.dev,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: x86/include/asm/arch_hweight.h:49:15: error: invalid input size
 for constraint 'D'
Message-ID: <Y+J/4kGuIqb8qeob@zn.tnic>
References: <CA+G9fYuSWodh1teau4jGG_P15yT-ev1+bS7HAAmMu5D5J-d2vw@mail.gmail.com>
 <Y+J8SobyVojJWuFv@dev-arch.thelio-3990X>
 <Y+J8rtEBlSTsCBLa@zn.tnic>
 <Y+J+UQ1vAKr6RHuH@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+J+UQ1vAKr6RHuH@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 09:37:37AM -0700, Nathan Chancellor wrote:
> Clang does its semantic analysis before optimization, so it cannot dead
> code eliminate that chunk before it checks the validity of the asm
> constraints, that is just how the pipeline is structured as far as I
> understand it. That is one of the biggest and longest standing
> differences between clang and GCC that we know about, the upstream link
> in the issue below has some more info.
> 
> https://github.com/ClangBuiltLinux/linux/issues/3
> 
> I am not super familiar with the internal details of LLVM and clang as
> other folks are though so I could be wrong or missing something :)

Thanks and wow, that's issue #3. Like wow that's old. And reading Nick's
text, it sure does sound like that's the one.

Fun.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
