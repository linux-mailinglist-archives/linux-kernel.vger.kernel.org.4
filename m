Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA40B687202
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 00:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjBAXlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 18:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBAXlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 18:41:45 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2175DC36;
        Wed,  1 Feb 2023 15:41:43 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0ADD2739;
        Wed,  1 Feb 2023 23:41:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0ADD2739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1675294902; bh=rRz1X/7SrI7swcn1nO8bgO/CfZmEmLtebmoOOoByqaU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VR2L4QU0GxufyWH0UkAmjWkdaNnGBRCvMJdq3e0STRXb5NQ+roEelUcyf9edGPSfA
         rycL0x/HDELG4NHkJEDr2hZy0bfMbn9qMloDq6kR2LuZjvGCTCqYevWBAyUVpheRF7
         1CDmtesQy9WM30PSKrwxGIj7H1zWhrQbh5hkM//aJdL7LtWi+jOKQj7v25T+dd3R3p
         M7fyjEdwgm8a/knSdNAoWofyPdIfig1crbGP6tMiJvAGAlSDZ1UpFFKcC4wXZTRzBE
         3G1M0VqM7pNsTFKvAbPwe+z4TqmHGYk2biELVVcNsXj44TyPCXe+V9yovgZeC7BkeG
         u4kY0vu6TJlHQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     sshefali021@gmail.com, kstewart@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs: add workload-tracing document to admin-guide
In-Reply-To: <Y9nkqhAS6EW2Lu8Z@debian.me>
References: <20230131221105.39216-1-skhan@linuxfoundation.org>
 <Y9nkqhAS6EW2Lu8Z@debian.me>
Date:   Wed, 01 Feb 2023 16:41:41 -0700
Message-ID: <875yclx8ay.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On Tue, Jan 31, 2023 at 03:11:05PM -0700, Shuah Khan wrote:
>> Add a new section to the admin-guide with information of interest to
>> application developers and system integrators doing analysis of the
>> Linux kernel for safety critical applications.
>> 
>> This section will contain documents supporting analysis of kernel
>> interactions with applications, and key kernel subsystems expectations.
>> 
>> Add a new workload-tracing document to this new section.
>> 
>> Signed-off-by: Shefali Sharma <sshefali021@gmail.com>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>> Changes since v2: Addressed review comments on v2
>
> I think you haven't addressed my comments there [1], so I have to
> write the improv:

Bagas, could you *please* stop this?

> diff --git a/Documentation/admin-guide/workload-tracing.rst b/Documentation/admin-guide/workload-tracing.rst
> index 5fad64b4ebd66f..ac60ff9dec8f0e 100644
> --- a/Documentation/admin-guide/workload-tracing.rst
> +++ b/Documentation/admin-guide/workload-tracing.rst
> @@ -27,10 +27,10 @@ Methodology
>  ===========
>  
>  `strace <https://man7.org/linux/man-pages/man1/strace.1.html>`_ is a
> -diagnostic, instructional, and debugging tool and can be used to discover
> -the system resources in use by a workload. Once we discover and understand
> -the workload needs, we can focus on them to avoid regressions and use it
> -to evaluate safety considerations. We use strace tool to trace workloads.
> +diagnostic, instructional, and debugging tool and can be used to
> +discover the system resources in use by a workload by tracing it. Once
> +we discover and understand the workload needs, we can focus on them to
> +avoid regressions and use it to evaluate safety considerations.

Do you realize how long it takes to look at this kind of stuff to decide
whether it is an "improv" or not?  In this case, it decidedly is not,
but somebody has to spend a bunch of time to try to figure out what you
were doing.

>  This method of tracing using strace tells us the system calls invoked by
>  the workload and doesn't include all the system calls that can be invoked
> @@ -43,7 +43,7 @@ outlined here will trace and find all possible code paths. The completeness
>  of the system usage information depends on the completeness of coverage of a
>  workload.
>  
> -The goal is tracing a workload on a system running a default kernel without
> +The goal is to trace workloads on a system running a default kernel without
>  requiring custom kernel installs.

Why do you think that these sorts of trivial changes are worth the
trouble?

I have asked you numerous times to please stop harassing our
contributors.  I am asking yet again.  We have no need for a
self-appointed officer to police documentation patches; you are simply
adding impedance to a process that people already find difficult to
navigate.

If you want to help the kernel project, we welcome you, but you need to
find a way to actually *help*.  As I have asked before, please stop
worrying about what others are doing and focus on making positive
contributions yourself.

Thank you.

jon
