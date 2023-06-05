Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D1672334C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjFEWmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjFEWmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:42:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A2110A;
        Mon,  5 Jun 2023 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=5PldYtjQD5bI94wU78rZshfAstwMA8IHK5qMLh+nxBk=; b=NtrrsbxNV5Sim/2CROqVDyMpv0
        FhIiaRIPqxZD4cRB3iDz7IeJNsY89mP18YuIlLADTz1fz77UzWxtIrVclLDfLqDS9GvOzYcZ1k+Qt
        BW2asj6eHSnWn/Mwaoakq7tkvchXyfZYT1kA06mmhUaVmsWOwDj7+HJd0sFZpRsAZEviLf7kKY+ZD
        9agQPAIkJJOtyN+7GcxYr8Fv4qRWZxh49UernBwNUtJsRRVK3c9InR0b/rf6OZmAjk3vvodnDnCNU
        T2Dmxz8EpfKkMuaf3mJwkpVGEyzYJmPCoPO7EEVt8D1Z5tV0NF/75Tr82GY3IfoDH59kObvao4CpO
        /1nWTTng==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6Ith-00H2ew-2H;
        Mon, 05 Jun 2023 22:41:57 +0000
Message-ID: <17f2f270-abff-8db7-c91e-bece1a61254a@infradead.org>
Date:   Mon, 5 Jun 2023 15:41:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 5/5] block: CONFIG_BLK_DEBUG
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20230605212717.2570570-1-kent.overstreet@linux.dev>
 <20230605212717.2570570-5-kent.overstreet@linux.dev>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230605212717.2570570-5-kent.overstreet@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/5/23 14:27, Kent Overstreet wrote:
> diff --git a/block/Kconfig b/block/Kconfig
> index 86122e459f..611dddb59c 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -165,6 +165,13 @@ config BLK_CGROUP_IOPRIO
>  	scheduler and block devices process requests. Only some I/O schedulers
>  	and some block devices support I/O priorities.
>  
> +config BLK_DEBUG
> +	bool "Extra block layer assertions"
> +	depends on DEBUG_KERNEL
> +	help
> +	Enable extra assertions in the block layer. Currently this is just the
> +	bio iterator code, but may be expanded.

I see that block/Kconfig isn't consistent about indenting help text,
but Documentation/process/coding-style.rst says:

10) Kconfig configuration files
-------------------------------

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.


so please add 2 spaces after the tab at the beginning of the help text
lines (but not the "help" line itself).

-- 
~Randy
