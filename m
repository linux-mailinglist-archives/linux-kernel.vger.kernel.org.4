Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC4E6B676A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 16:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCLPGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 11:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCLPGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 11:06:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9CD39BAE;
        Sun, 12 Mar 2023 08:06:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93C30B80C92;
        Sun, 12 Mar 2023 15:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EA1C433D2;
        Sun, 12 Mar 2023 15:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678633602;
        bh=dQ4INd4LkPkMY+DVoLoy/dQlXlQQMT+9up2+uloKNMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QZFoUULHHAGAsCWI4G/Az4VU+W6SLgAMqaWwkpSYhJktZpK5f+V+Pm5uaiUFWQH6B
         BRy18v1XHCE8Cwc504dbHgnGUCoeOliArVMqH/5xMHB9zQIvcqZTUYB3fnKuMnU69s
         38DqJO1BtwXAt+H8zBVnn/SSU59dnITNyvJ3rjpg=
Date:   Sun, 12 Mar 2023 16:06:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Solar Designer <solar@openwall.com>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org, Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Re: [PATCH v3 2/7] Documentation/security-bugs: misc. improvements
Message-ID: <ZA3qfwrmtQihkfTy@kroah.com>
References: <20230305220010.20895-1-vegard.nossum@oracle.com>
 <20230305220010.20895-3-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230305220010.20895-3-vegard.nossum@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 11:00:05PM +0100, Vegard Nossum wrote:
> This mostly just clarifies things and moves a few things around in
> preparation for the subsequent changes.
> 
> Most notably, pull the "security@kernel.org" address up into the first
> paragraph as this the most vital piece of information in the whole
> document.
> 
> Also fix a few markup issues.

When you have "also" in a patch changelog, that usually means this
should be a separate patch.  Can you just fix up the markup issues first
please?

Also, a few minor comments below:

> 
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/process/security-bugs.rst | 37 ++++++++++++++-----------
>  1 file changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
> index 82e29837d589..f1326d4e9718 100644
> --- a/Documentation/process/security-bugs.rst
> +++ b/Documentation/process/security-bugs.rst
> @@ -1,36 +1,41 @@
>  .. _securitybugs:
>  
> -Security bugs
> -=============
> +Reporting security bugs
> +=======================
>  
>  Linux kernel developers take security very seriously.  As such, we'd
>  like to know when a security bug is found so that it can be fixed and
>  disclosed as quickly as possible.  Please report security bugs to the
> -Linux kernel security team.
> +Linux kernel security team at security@kernel.org, henceforth
> +"the security list".  This is a closed list of trusted developers who
> +will help verify the bug report and develop a patch in case none was
> +already proposed.
>  
> -Contact
> --------
> +While the security list is closed, the security team may bring in extra
> +help from the relevant maintainers to understand and fix the security
> +vulnerability.
>  
> -The Linux kernel security team can be contacted by email at
> -<security@kernel.org>.  This is a private list of security officers
> -who will help verify the bug report and develop and release a fix.
> -If you already have a fix, please include it with your report, as
> -that can speed up the process considerably.  It is possible that the
> -security team will bring in extra help from area maintainers to
> -understand and fix the security vulnerability.
> +Note that the main interest of the kernel security list is in getting
> +bugs fixed and getting patches reviewed, tested, and merged; CVE

It's not "main interest", it is the "only task" of it.  That's all the
list does, nothing else.

> +assignment, disclosure to distributions, and public disclosure happen on
> +different lists with different people.

How about this rephrasing:

	The only tasks of the kernel security list are to triage
	reported potential security bugs, generate and test a fix, and
	get the fix merged into Linus's and the stable kernel trees.
	The security list does not deal with CVE assignment or any sort
	of disclosure at all.

thanks,

greg k-h
