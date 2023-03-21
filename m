Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6D96C2F53
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjCUKph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCUKpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:45:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4753D558D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:45:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00EDBAD7;
        Tue, 21 Mar 2023 03:46:16 -0700 (PDT)
Received: from [10.163.89.43] (unknown [10.163.89.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 428F13F71E;
        Tue, 21 Mar 2023 03:45:29 -0700 (PDT)
Message-ID: <ae0f64c2-8a3a-a077-d03d-58af2ed69f90@arm.com>
Date:   Tue, 21 Mar 2023 16:15:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: Support CMDLINE_EXTEND
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230320211451.2512800-1-chris.packham@alliedtelesis.co.nz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230320211451.2512800-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/23 02:44, Chris Packham wrote:
> Support extending the bootloader provided command line for arm64
> targets. This support is already present via generic DT/EFI code the
> only thing required is for the architecture to make it selectable.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  arch/arm64/Kconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1023e896d46b..3c837b085f21 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2228,6 +2228,12 @@ config CMDLINE_FROM_BOOTLOADER
>  	  the boot loader doesn't provide any, the default kernel command
>  	  string provided in CMDLINE will be used.
>  
> +config CMDLINE_EXTEND
> +	bool "Extend bootloader kernel arguments"
> +	help
> +	  The command-line arguments provided by the boot loader will be
> +	  appended to the default kernel command string.
> +
>  config CMDLINE_FORCE
>  	bool "Always use the default kernel command string"
>  	help

LGTM, FWIW

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
