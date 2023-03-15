Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648E26BB6AB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjCOOzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjCOOyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:54:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B77A0B30;
        Wed, 15 Mar 2023 07:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=7ZNK08MerGzRX2ZaSmuVczeFjiWX83v3VJCjASMeBtc=; b=tln7V1X7eVe2a/4sanzpC3mYAt
        EUSdqOCOovKT90F+2SeDKPwqMJHq9fFOHxRx7uJOcCJaWvHH0wIJ27t21QmKbgWdzNjxHLVmyZ7fL
        4451Q8YffAZoRx9S0R6gtxbnUEmH0FPsgiYFxuJgHS/OqMN5Yoqh/eTLhYzlBO2wESxEp8Ei0lGqE
        rraeYxyWNATk7MbupvFXozSeaAj3xhhazU5aVHa17h3DMuhu6eHnavgM1emoK1+DtWpheV4O0xlLI
        oEVkkUfWCdbOBDjetBZ83Ki54HqdMCU14a8B8fvr1qXENR14x4BaIWHRwhkpSCwRh4R3ptiJ7zD0o
        262IquLQ==;
Received: from [2601:1c2:980:9ec0::21b4]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pcSVM-00DgIT-1Z;
        Wed, 15 Mar 2023 14:53:28 +0000
Message-ID: <64f9d9a6-0acb-f65e-18a1-44fd4cb56ece@infradead.org>
Date:   Wed, 15 Mar 2023 07:53:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Documentation: kernel-parameters: Remove meye entry
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Staging Drivers <linux-staging@lists.linux.dev>
Cc:     Jonathan Corbet <corbet@lwn.net>, Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>
References: <20230315100246.62324-1-bagasdotme@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230315100246.62324-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/23 03:02, Bagas Sanjaya wrote:
> Commit ba47652ba65523 ("media: meye: remove this deprecated driver")
> removes meye driver but forgets to purge its kernel-parameters.txt
> entry, hence broken reference.
> 
> Remove the entry.
> 
> Link: https://lore.kernel.org/all/202302070341.OVqstpMM-lkp@intel.com/
> Fixes: ba47652ba65523 ("media: meye: remove this deprecated driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  This patch is based on staging-next tree, because the driver removal
>  touched drivers/staging/.
> 
>  Documentation/admin-guide/kernel-parameters.txt | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6221a1d057dd58..e54d4ce7870c00 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3184,9 +3184,6 @@
>  			deep    - Suspend-To-RAM or equivalent (if supported)
>  			See Documentation/admin-guide/pm/sleep-states.rst.
>  
> -	meye.*=		[HW] Set MotionEye Camera parameters
> -			See Documentation/admin-guide/media/meye.rst.
> -
>  	mfgpt_irq=	[IA-32] Specify the IRQ to use for the
>  			Multi-Function General Purpose Timers on AMD Geode
>  			platforms.
> 
> base-commit: 458219ca9246076971961d695eef9eb56e05fcf7

-- 
~Randy
