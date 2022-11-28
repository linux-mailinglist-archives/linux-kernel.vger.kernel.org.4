Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78ADB63B1EA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiK1TLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbiK1TLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:11:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3212E12D0C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:11:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C26F16136F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D7EC433D6;
        Mon, 28 Nov 2022 19:10:57 +0000 (UTC)
Date:   Mon, 28 Nov 2022 14:10:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        kirill.shutemov@linux.intel.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, x86@kernel.org
Subject: Re: [PATCH] x86/asm: Remove unused COMPILE_OFFSETS macro from
 asm-offsets.c
Message-ID: <20221128141056.29ccafd6@gandalf.local.home>
In-Reply-To: <Y4T4msSXCNnfPCMG@google.com>
References: <20221128091506.gp4l6klznqhigjxv@box.shutemov.name>
        <20221128101117.3614401-1-mailhol.vincent@wanadoo.fr>
        <20221128111112.dzavip4eqqgpyrai@box.shutemov.name>
        <CAMZ6RqJ0EgbLcz97ujqEzF1MBsH045W0Cu8mMuR0WCx_cTemCQ@mail.gmail.com>
        <20221128124513.76392c3d@gandalf.local.home>
        <b98429d8-6d18-cf0b-6ca0-d9d6472d21f9@redhat.com>
        <Y4T4msSXCNnfPCMG@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 18:06:18 +0000
Sean Christopherson <seanjc@google.com> wrote:

> > > IIRC, the reason for adding that was because that logic was screwing up
> > > asm-offsets.c. I'm not sure it screws up kvm-asm-offsets.c though.
> > > 
> > > This is one of those cases I wish I commented that code better :-/  
> > 
> > I don't think KVM includes linux/ftrace.h or asm/ftrace.h at all.  
> 
> >From include/linux/kvm_host.h  
> 
>   #include <linux/ftrace.h>
> 
> Even if that didn't exist, saying that XYZ never includes a header is a dangerous
> business, it's all too easy to indirectly include headers in the kernel, now or
> in the future.

But going back to the original intent of COMPILE_OFFSETS. I believe it was
because some code that did not work with the auto generation of compiler
offsets and was a way to hide them.

I do not know if it is still an issue or not today.

-- Steve
