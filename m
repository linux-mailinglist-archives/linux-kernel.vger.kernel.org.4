Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3207A735EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 23:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjFSVQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 17:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjFSVQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 17:16:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F410DC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 14:16:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687209402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jeie3GhpDhGt5KA66c8W/BLeUY1w7zIhRb/ALkuu058=;
        b=cJ2RnpbBk6qpmuHdsOyDkEiw6CbQzJqfckkj+wDzewvbibMHomLDapvvE7xmNZf9H5MBmc
        53Up892pgR2YkhfpPaKNqchDDXkaIYL5aNqpBGqYg5hR6B0a+794IY5OMJDwrHsxU9sTOA
        ZIiDzYmq1/pX0ESP318Hq/M4JvdCt5tXFZzfYSKFnu1yrdh0or+AqgXyaXGu9CHxjGiykp
        z8HVEHYBaL/lmT3FAZ+TiYA4gADNq9Q0sR33Q1veMVMcI1ZBoWPZwYBgHcbnbEic0JVEs6
        cmcO+y7+/pvfk0V52XqziJsN4Pf+1IIStpSVgwnKcFBsyg6+Tbt5sQ6y9gubAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687209402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jeie3GhpDhGt5KA66c8W/BLeUY1w7zIhRb/ALkuu058=;
        b=Mva53YtgCVG0sKVucBO3SFBXt6/nhUbNJeem2RbbmJGtel2goSTpX0CCEvATgQpXQP7H2I
        LMmDnSsVzHcplDDA==
To:     Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH 0/2] x86: Clean up ia32_unistd.h
In-Reply-To: <20230619194745.80552-1-brgerst@gmail.com>
References: <20230619194745.80552-1-brgerst@gmail.com>
Date:   Mon, 19 Jun 2023 23:16:41 +0200
Message-ID: <87mt0vp2yu.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian!

On Mon, Jun 19 2023 at 15:47, Brian Gerst wrote:
> Other than one unused macro, ia32_unistd.h is just a wrapper for
> unistd_32_ia32.h, and can be removed.
>
> Brian Gerst (2):
>   x86/syscall/compat: Remove unused macro __SYSCALL_ia32_NR
>   x86/syscall/compat: Remove ia32_unistd.h

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks a lot for doing this (thankless) cleanup work!

       tglx
