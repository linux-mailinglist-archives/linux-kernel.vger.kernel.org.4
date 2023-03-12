Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4ED6B6766
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 16:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjCLPAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 11:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCLPAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 11:00:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023DD6595;
        Sun, 12 Mar 2023 08:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8976960F55;
        Sun, 12 Mar 2023 15:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66963C4339C;
        Sun, 12 Mar 2023 15:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678633216;
        bh=ZKLZWWUf13H8OtsIbDMqRJL2t9MQ0NyceTd5vY7rjHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oEL2J0a+cxwiqcVg3A/gcx1WySi2V+IWaQKtMRvCuWeBecCMzCVHS2DR1dytlUFHg
         NJbUXc9CWCaohROP4EQhE2dJS0x0VpZq+oip1LwdJ0XkJIs3f8PbmCBY8bZf/YQj6d
         tT3PflPmOR/4T50wqHtLkM5UotTbuGf/hFFqxHpI=
Date:   Sun, 12 Mar 2023 16:00:14 +0100
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
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jiri Kosina <jikos@kernel.org>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Tsugikazu Shibata <tshibata@ab.jp.nec.com>,
        Minchan Kim <minchan@kernel.org>,
        Jeimi Lee <jamee.lee@samsung.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v3 1/7] Documentation/security-bugs: move from
 admin-guide/ to process/
Message-ID: <ZA3o/vPJSGXDYxE2@kroah.com>
References: <20230305220010.20895-1-vegard.nossum@oracle.com>
 <20230305220010.20895-2-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230305220010.20895-2-vegard.nossum@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 11:00:04PM +0100, Vegard Nossum wrote:
> Jiri Kosina, Jonathan Corbet, and Willy Tarreau all expressed a desire
> to move this document under process/.
> 
> Create a new section for security issues in the index and group it with
> embargoed-hardware-issues.
> 
> I'm doing this at the start of the series to make all the subsequent
> changes show up in 'git blame'.
> 
> Existing references were updated using:
> 
>   git grep -l security-bugs ':!Documentation/translations/' | xargs sed -i 's|admin-guide/security-bugs|process/security-bugs|g'
>   git grep -l security-bugs Documentation/translations/ | xargs sed -i 's|Documentation/admin-guide/security-bugs|Documentation/process/security-bugs|g'
>   git grep -l security-bugs Documentation/translations/ | xargs sed -i '/Original:/s|\.\./admin-guide/security-bugs|\.\./process/security-bugs|g'
> 
> Notably, the page is not moved in the translations (due to my lack of
> knowledge of these languages), but the translations have been updated
> to point to the new location of the original document where these
> references exist.

Thanks for this one, I've applied it to my tree as everyone agrees it is
needed.

greg k-h
