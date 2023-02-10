Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2636D691768
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 04:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjBJDza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 22:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjBJDz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 22:55:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7656E9A7;
        Thu,  9 Feb 2023 19:55:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C4BEB822DC;
        Fri, 10 Feb 2023 03:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E0AC433EF;
        Fri, 10 Feb 2023 03:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676001325;
        bh=A3FGqFCiaGYGnqMOLqbsejjK6iWL+IHx0fwVh85GdkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VxIeUkHU4rcCrzIwMRSfcgGjCBhvBYVGv82P0rlRwaW5x8KWydDsZ2FTTV6O1fOqv
         E8+a8uifo4eat7MpZJRM/HJPGEo3MCAR5gs+AF0wv8focR0lz2X1JPaXamLdBKCEW7
         +jGFDOPF88PqLQiH0d0xIZiBcMwdy9KV5kUQSV3GLs+daVY9ScLJb97CqQHrwpny0m
         n/VqVK0k/wXm/hPQj78a8lK7dIOVdL1uU0zejQej++/u72of01AvGGtnVuDqL5oh0O
         KJqlLZ9gZq1mmXPUy5FgQld/obRMD1D8FvMdm7LVt5L3ZSEgFvsVj4A1dGOVD0u8L9
         GKXQYfBUstXDg==
Date:   Fri, 10 Feb 2023 05:55:21 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 23/24] Documentation: x86: correct spelling
Message-ID: <Y+XAKUjZQRByJJyL@kernel.org>
References: <20230209071400.31476-1-rdunlap@infradead.org>
 <20230209071400.31476-24-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209071400.31476-24-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 11:13:59PM -0800, Randy Dunlap wrote:
> Correct spelling problems for Documentation/x86/ as reported
> by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: linux-sgx@vger.kernel.org
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/x86/boot.rst    |    2 +-
>  Documentation/x86/buslock.rst |    2 +-
>  Documentation/x86/mds.rst     |    2 +-
>  Documentation/x86/resctrl.rst |    2 +-
>  Documentation/x86/sgx.rst     |    2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff -- a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
> --- a/Documentation/x86/boot.rst
> +++ b/Documentation/x86/boot.rst
> @@ -1105,7 +1105,7 @@ The kernel command line should not be lo
>  code, nor should it be located in high memory.
>  
>  
> -Sample Boot Configuartion
> +Sample Boot Configuration
>  =========================
>  
>  As a sample configuration, assume the following layout of the real
> diff -- a/Documentation/x86/buslock.rst b/Documentation/x86/buslock.rst
> --- a/Documentation/x86/buslock.rst
> +++ b/Documentation/x86/buslock.rst
> @@ -32,7 +32,7 @@ mechanisms to detect split locks and bus
>  --------------------------------------
>  
>  Beginning with the Tremont Atom CPU split lock operations may raise an
> -Alignment Check (#AC) exception when a split lock operation is attemped.
> +Alignment Check (#AC) exception when a split lock operation is attempted.
>  
>  #DB exception for bus lock detection
>  ------------------------------------
> diff -- a/Documentation/x86/mds.rst b/Documentation/x86/mds.rst
> --- a/Documentation/x86/mds.rst
> +++ b/Documentation/x86/mds.rst
> @@ -60,7 +60,7 @@ needed for exploiting MDS requires:
>     data
>  
>  The existence of such a construct in the kernel cannot be excluded with
> -100% certainty, but the complexity involved makes it extremly unlikely.
> +100% certainty, but the complexity involved makes it extremely unlikely.
>  
>  There is one exception, which is untrusted BPF. The functionality of
>  untrusted BPF is limited, but it needs to be thoroughly investigated
> diff -- a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -487,7 +487,7 @@ this would be dependent on number of cor
>     depending on # of threads:
>  
>  For the same SKU in #1, a 'single thread, with 10% bandwidth' and '4
> -thread, with 10% bandwidth' can consume upto 10GBps and 40GBps although
> +thread, with 10% bandwidth' can consume up to 10GBps and 40GBps although
>  they have same percentage bandwidth of 10%. This is simply because as
>  threads start using more cores in an rdtgroup, the actual bandwidth may
>  increase or vary although user specified bandwidth percentage is same.
> diff -- a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
> --- a/Documentation/x86/sgx.rst
> +++ b/Documentation/x86/sgx.rst
> @@ -245,7 +245,7 @@ SGX will likely become unusable because
>  limited. However, while this may be fatal to SGX, the rest of the kernel
>  is unlikely to be impacted and should continue to work.
>  
> -As a result, when this happpens, user should stop running any new
> +As a result, when this happens, the user should stop running any new
>  SGX workloads, (or just any new workloads), and migrate all valuable
>  workloads. Although a machine reboot can recover all EPC memory, the bug
>  should be reported to Linux developers.


Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
