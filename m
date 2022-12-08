Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664A76468E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 07:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLHGJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 01:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHGJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 01:09:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756039AE00;
        Wed,  7 Dec 2022 22:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=IouOJhYsJRR92hwgDzyBCpNlX2nskfbFvVhQT042CPI=; b=i+3wPArKnvDiG9y/DB0vHbj/na
        qslhAIXoM4MORqAXfjRa8hUgKP79gAluYtS5l+pl+CFcbxKo6S4jloBh4eCUIN54MSEXjHFqGukAO
        Yejby9/9vbn+in/dKkpDpNE1OrFWML4Zlq+wncNclfdl/DId8mdO1WSxZ0q8tOwMYnOkaNP8za5Ol
        B+JQ1YgiN0I14RU94oiunBf3JNPbcX9IZCaqTFhivvB9tWxN0ocJ4NPjpXj0YqhtX6emVJIfIGseY
        2oGEKW1W7UEpn11ppkFd8ByZI1EKOoSSEypcIYuVQCAlAtUoXg0O6s/J5dcK8H2cuaJrKDbhVEw2r
        b9mJGnbw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p3A69-0030t8-KX; Thu, 08 Dec 2022 06:09:33 +0000
Message-ID: <b54d9dd6-8bf5-3327-61ae-7fff7e320988@infradead.org>
Date:   Wed, 7 Dec 2022 22:09:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] docs: mm/page_owner: fix spelling mistakes
Content-Language: en-US
To:     Chen Xiao <abigwc@gmail.com>, corbet@lwn.net
Cc:     akpm@linux-foundation.org, yejiajian2018@email.szu.edu.cn,
        caoyixuan2019@email.szu.edu.cn, zhangyinan2019@email.szu.edu.cn,
        akiyks@gmail.com, rppt@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1670479443-8484-1-git-send-email-abigwc@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1670479443-8484-1-git-send-email-abigwc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/22 22:04, Chen Xiao wrote:
> Fix several spelling mistakes in page_owner documentation.
> 
> Signed-off-by: Chen Xiao <abigwc@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/mm/page_owner.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/mm/page_owner.rst b/Documentation/mm/page_owner.rst
> index 1275149..0f4cb59 100644
> --- a/Documentation/mm/page_owner.rst
> +++ b/Documentation/mm/page_owner.rst
> @@ -52,7 +52,7 @@ pages are investigated and marked as allocated in initialization phase.
>  Although it doesn't mean that they have the right owner information,
>  at least, we can tell whether the page is allocated or not,
>  more accurately. On 2GB memory x86-64 VM box, 13343 early allocated pages
> -are catched and marked, although they are mostly allocated from struct
> +are caught and marked, although they are mostly allocated from struct
>  page extension feature. Anyway, after that, no page is left in
>  un-tracking state.
>  
> @@ -178,7 +178,7 @@ STANDARD FORMAT SPECIFIERS
>  	at		alloc_ts	timestamp of the page when it was allocated
>  	ator		allocator	memory allocator for pages
>  
> -  For --curl option:
> +  For --cull option:
>  
>  	KEY		LONG		DESCRIPTION
>  	p		pid		process ID

-- 
~Randy
