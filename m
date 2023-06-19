Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D5A735F53
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 23:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjFSVnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 17:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFSVnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 17:43:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E078E1BB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 14:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=jVRfJtFn83s1N4xVDwJhe2fgGy5164bT09HyVkzuVvo=; b=PLXs0hClPHjAb9AoBqpIgt1qXX
        v4Xvi0KjORPJHXyRrIbeE5R78IIL9SsgdzYzfzaqoDb1oWExXlHbtX9rP+SPkME7BJ4lmVQK3HTrp
        fZFySv1MgkAnvTUlM9hV0FDK82DymeuNgT/Wf2q3cF/5SanivFlLsJrUlLVVYqVxf+FmZv8KXVC6y
        VEAflJfKIa69Vf2rlgE4XjjquS3wsMb2kNzkCos4gjkzkAmtccI5pWFO31KqQol5/ozQha6Q1b4lt
        g7hSyzEnbf/O1uYJEsv9KVBual8PAQ0304LjbeBZ+h8mvivPABU+oSvlv2Z5r6DWQY/1mmLBdjXdI
        DBZBZHLg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBMf6-009XdE-2l;
        Mon, 19 Jun 2023 21:43:49 +0000
Message-ID: <95f4416d-854e-c91d-c401-2ef9488d83ba@infradead.org>
Date:   Mon, 19 Jun 2023 14:43:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/5] x86: Make IA32_EMULATION boot time configurable
Content-Language: en-US
To:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz
References: <20230616125730.1164989-1-nik.borisov@suse.com>
 <20230616125730.1164989-2-nik.borisov@suse.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230616125730.1164989-2-nik.borisov@suse.com>
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



On 6/16/23 05:57, Nikolay Borisov wrote:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 53bab123a8ee..8bec431c97ce 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -3038,6 +3038,15 @@ config IA32_EMULATION
>  	  64-bit kernel. You should likely turn this on, unless you're
>  	  100% sure that you don't have any 32-bit programs left.
>  
> +config IA32_EMULATION_DEFAULT_DISABLED
> +	bool "IA32 emulation disabled by default"
> +	default n
> +	depends on IA32_EMULATION
> +	help
> +	  Make IA32 emulation disabled by default. This prevents loading 32bit

	                                                                 32-bit

> +	  processes and access to 32bit syscalls. If unsure, leave it to its

	                          32-bit

> +	  default value.

-- 
~Randy
