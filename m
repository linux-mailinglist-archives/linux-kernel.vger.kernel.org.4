Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D0467DE28
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 08:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjA0HDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 02:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjA0HCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 02:02:49 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EF929153;
        Thu, 26 Jan 2023 23:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1674802964; x=1706338964;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iWLA5X+z2szCpuIcfK7TgiJXdpI5JtwJHnnLtFet9aE=;
  b=bwfujCRWeDYLGdXNJmRiXzoOTmkNR/6qF3JH05GxUI5aC24vjRyrMAWM
   Tvvh6lqOFPe68wmuqkxpYsqjBzlWA6CZLFGN0Js9u7XTLSE+JWhIop1ds
   YhwshoJdLlKPwxqVy1B+TnlyPxg5o8grQ4JnmIFb+p84c8LmGfyrnj5N+
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Jan 2023 23:02:43 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 23:02:43 -0800
Received: from [10.216.47.84] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 26 Jan
 2023 23:02:37 -0800
Message-ID: <27472a10-7e14-de7e-6cec-b7a75647fcaa@quicinc.com>
Date:   Fri, 27 Jan 2023 12:32:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 01/35] Documentation: arm64: correct spelling
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
 <20230127064005.1558-3-rdunlap@infradead.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230127064005.1558-3-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/2023 12:09 PM, Randy Dunlap wrote:
> Correct spelling problems for Documentation/arm64/ as reported
> by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>   Documentation/arm64/booting.rst    |    2 +-
>   Documentation/arm64/elf_hwcaps.rst |    2 +-
>   Documentation/arm64/sve.rst        |    4 ++--
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff -- a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
> --- a/Documentation/arm64/booting.rst
> +++ b/Documentation/arm64/booting.rst
> @@ -223,7 +223,7 @@ Before jumping into the kernel, the foll
>     For systems with a GICv3 interrupt controller to be used in v3 mode:
>     - If EL3 is present:
>   
> -      - ICC_SRE_EL3.Enable (bit 3) must be initialiased to 0b1.
> +      - ICC_SRE_EL3.Enable (bit 3) must be initialised to 0b1.
>         - ICC_SRE_EL3.SRE (bit 0) must be initialised to 0b1.
>         - ICC_CTLR_EL3.PMHE (bit 6) must be set to the same value across
>           all CPUs the kernel is executing on, and must stay constant
> diff -- a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
> --- a/Documentation/arm64/elf_hwcaps.rst
> +++ b/Documentation/arm64/elf_hwcaps.rst
> @@ -14,7 +14,7 @@ Some hardware or software features are o
>   implementations, and/or with certain kernel configurations, but have no
>   architected discovery mechanism available to userspace code at EL0. The
>   kernel exposes the presence of these features to userspace through a set
> -of flags called hwcaps, exposed in the auxilliary vector.
> +of flags called hwcaps, exposed in the auxiliary vector.
>   
>   Userspace software can test for features by acquiring the AT_HWCAP or
>   AT_HWCAP2 entry of the auxiliary vector, and testing whether the relevant
> diff -- a/Documentation/arm64/sve.rst b/Documentation/arm64/sve.rst
> --- a/Documentation/arm64/sve.rst
> +++ b/Documentation/arm64/sve.rst
> @@ -175,7 +175,7 @@ the SVE instruction set architecture.
>   When returning from a signal handler:
>   
>   * If there is no sve_context record in the signal frame, or if the record is
> -  present but contains no register data as desribed in the previous section,
> +  present but contains no register data as described in the previous section,
>     then the SVE registers/bits become non-live and take unspecified values.
>   
>   * If sve_context is present in the signal frame and contains full register
> @@ -223,7 +223,7 @@ prctl(PR_SVE_SET_VL, unsigned long arg)
>   	    Defer the requested vector length change until the next execve()
>   	    performed by this thread.
>   
> -	    The effect is equivalent to implicit exceution of the following
> +	    The effect is equivalent to implicit execution of the following
>   	    call immediately after the next execve() (if any) by the thread:
>   
>   		prctl(PR_SVE_SET_VL, arg & ~PR_SVE_SET_VL_ONEXEC)
> 

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
