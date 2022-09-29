Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645B05EF937
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbiI2PhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbiI2PgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:36:08 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657F315564D;
        Thu, 29 Sep 2022 08:34:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 68BBE2C5;
        Thu, 29 Sep 2022 15:34:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 68BBE2C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664465659; bh=M7wSrazK3phKFdY5KaKHv7PsNZI3CDixOHSd5gjAo2I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=p0O/beCf50JphNyPJBZvvGIcbB1v0IIfzWdgZveDGLWVC+TcouI7yO0V6fAJl2fRv
         P7SUhuGmcVrKnSznu/rVCfcoBpkTtQWuFv1TlJwHedHScBRJXr1d0cBCG0klpCRPBo
         kIGP9gPqay6o7xuwrunxk3qBvXmRTTCYv29KOFgYZ0p8oKIe8kd97V8bHXhr4/Ihmo
         pqtG8hnHPBKSCNzfRWDvgAr9l/OGn4nraS/BfthLMyFjrA8z3uZT4NSNSyUNai9l1Q
         lMTMURPE8Q8Wq03rqX4qy421Gt8CbYmGOtrzjqKc0x7ZvAdhU1LPF5TxWCEatObnjn
         1lVV4XIF9GURQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        David Vernet <void@manifault.com>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH v3 0/7] Rewrite the top-level index.rst
In-Reply-To: <20220927160559.97154-1-corbet@lwn.net>
References: <20220927160559.97154-1-corbet@lwn.net>
Date:   Thu, 29 Sep 2022 09:34:18 -0600
Message-ID: <87mtaii491.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:

> The top-level index.rst file is the entry point for the kernel's
> documentation, especially for readers of the HTML output.  It is currently
> a mess containing everything we thought to throw in there.  Firefox says it
> would require 26 pages of paper to print it.  That is not a user-friendly
> introduction.
>
> This series aims to improve our documentation entry point with a focus on
> rewriting index.rst.  The result is, IMO, simpler and more approachable.
> For anybody who wants to see the rendered results without building the
> docs, have a look at:
>
>   https://static.lwn.net/kerneldoc/

So I think I'll go ahead and drop this into docs-next shortly.  Thanks
to everybody who has commented.

This, of course, has the potential to create conflicts with other 6.1
work that touches Documentation/index.rst.  Amazingly, as far as I can
tell, there is only one linux-next commit touching that file - the
addition of the Rust docs.  We'll want to be sure that doesn't get lost
during the merge window.  I'll be sure to include a suitable heads-up in
my pull request.

Thanks,

jon
