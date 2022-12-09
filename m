Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D8C6485FB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiLIP4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLIP4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:56:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34FF5FF9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:55:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59F746227C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 15:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30431C433EF;
        Fri,  9 Dec 2022 15:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670601358;
        bh=J8o6E+k/8LtCUpKKa8lOQZkdxr+zp18CG3T6nSOV1sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kSchAmwR3VDys2ljiTS32Vw4Cvkc/1wX8Tp5njW218146mNFNsIEWLCf2sVL2mDXK
         +9z2Lb+unsNJf6V/Za1XM+cMx0Njy7ll+z+2C6q7FqHhVBiRpWZqgXN7s+GxwpM6QK
         2qk4cQylmwReNP/GHBfUpup6iZpKjJQEj3IkVV3iv7aZRzUvy9v1vDq8jms8o6Hrc3
         kHqjXkP+fGX2pFdKY4b8DuzKVV9vCcSb2ZgTA+yQuGz4Y+nbNI1OMJEBVHTTw6o2QO
         TpL1NM3ITAXFMZWZRCkS/6aFWW6ew4iZMueeygjGWl3RF4WXBBe1UPBmXfSN72yZ9o
         hvfNqK8VE+iLA==
Date:   Fri, 9 Dec 2022 08:55:56 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH] x86/vdso: Conditionally export __vdso_sgx_enter_enclave
Message-ID: <Y5NajERIilxBrobj@dev-arch.thelio-3990X>
References: <20221109000306.1407357-1-nathan@kernel.org>
 <Y5M8SZEN1N5Dt15X@dev-arch.thelio-3990X>
 <87r0x8d6mr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0x8d6mr.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 02:54:52PM +0100, Thomas Gleixner wrote:
> On Fri, Dec 09 2022 at 06:46, Nathan Chancellor wrote:
> > Ping? The default switch was remerged a couple of days ago so builds
> > with tip of tree LLVM are going to be broken again:
> >
> > https://github.com/llvm/llvm-project/commit/241dbd310599e3c1a0f1b0c9ced14c8b8760539e
> 
> Sorry. That fell through the cracks. I'll take care of it.

Thanks Thomas! I get you all are always busy so I appreciate the quick
response.

Cheers,
Nathan
