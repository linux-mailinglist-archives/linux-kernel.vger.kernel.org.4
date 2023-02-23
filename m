Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4075F6A108F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjBWT1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBWT1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:27:05 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B894305CB;
        Thu, 23 Feb 2023 11:27:03 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 05A287DB;
        Thu, 23 Feb 2023 19:27:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 05A287DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1677180423; bh=FTLTlXHPh7OCNugqlntdrnGBtfh20djbZsbB+Ze9a58=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Eq8bc82qh5IggBQ/SvHQ33ErIAXWMjwa5kbpRh8zrtPs81MOu8bpfCuRJhk45zA2f
         NMHra05xOds3h/aCELUjTO24bwBUAtCvLSqLJTbCNKY0mvYpxi2zNYKyy1dRfeoVb8
         eehYIN02Fv7K+Qx4FFOXp+MxTddSyIqe1ngVmU77NX34XKWnmNHfJ5kBMD05LEmjT0
         jpRQVerdRMFgYcBr0wevNbRFzjoVuAnn6i4RLZWJEpU0wg70oHJ6REJRmL/z3K4o6q
         NVhPgwz3ZwU/Joz4Q5z96YSxsQsHaTJxUVDjuGh+bi3X1HwU9DFmz+IFf75pwM5qbl
         jo3tx3oBQyYSw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] docs: locking: refer to the actual existing config names
In-Reply-To: <20230220165749.12850-1-lukas.bulwahn@gmail.com>
References: <20230220165749.12850-1-lukas.bulwahn@gmail.com>
Date:   Thu, 23 Feb 2023 12:27:02 -0700
Message-ID: <877cw85gjd.fsf@meer.lwn.net>
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

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> The config is actually called CONFIG_RT_MUTEXES, not CONFIG_RT_MUTEX.
>
> The config CONFIG_LOCK_TORTURE_TEST should be connected by underscore, for
> the sake of consistent referencing to configs in the kernel documentation.
>
> Address those issues.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  Documentation/locking/locktorture.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/locking/locktorture.rst b/Documentation/locking/locktorture.rst
> index dfaf9fc883f4..7f56fc0d7c31 100644
> --- a/Documentation/locking/locktorture.rst
> +++ b/Documentation/locking/locktorture.rst
> @@ -5,7 +5,7 @@ Kernel Lock Torture Test Operation
>  CONFIG_LOCK_TORTURE_TEST
>  ========================
>  
> -The CONFIG LOCK_TORTURE_TEST config option provides a kernel module
> +The CONFIG_LOCK_TORTURE_TEST config option provides a kernel module
>  that runs torture tests on core kernel locking primitives. The kernel
>  module, 'locktorture', may be built after the fact on the running
>  kernel to be tested, if desired. The tests periodically output status
> @@ -67,7 +67,7 @@ torture_type
>  
>  		     - "rtmutex_lock":
>  				rtmutex_lock() and rtmutex_unlock() pairs.
> -				Kernel must have CONFIG_RT_MUTEX=y.
> +				Kernel must have CONFIG_RT_MUTEXES=y.
>  

Applied, thanks.

jon
