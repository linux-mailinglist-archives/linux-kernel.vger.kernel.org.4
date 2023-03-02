Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7178E6A7B39
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 07:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCBGJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 01:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjCBGJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 01:09:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8338CFF07
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 22:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=cksF2J1GHVCqfD2mhu+eRf6JBEUYvRS+b/lAVg5OY4k=; b=xhP5RydDw5msBMoWeLL3EK67tk
        9/bF94WaOLMjcRxAtvS9n2MSPDYOjga7H1qJ/V6Wp96Ccoj0D5rQQwYBmT7WfMHh6PlgpiEGLJK63
        7DvU7v9eh+YGl6h879mLwhIcjLqcRS70AeMEx6LFvgiX/qPBG2+wxvpWAcfx29/+mqCf5z0dVSuWX
        08jg7UGHDgXhQD9F40YV7JMYGv4NAceuoMK8GQ3OaZtFfuoWGlop3sb7ff7DdNOlV+/Y4wKswXIM4
        ldu4FZH/IMrEl2BBs3VEH9UVaNFiVjLiBxjFPF5adPf+8Xs6sxmTFksRLo+i+En+PtIWUJ4mLWwjb
        CYZmqXvw==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXc7h-000z5k-O2; Thu, 02 Mar 2023 06:09:01 +0000
Message-ID: <ae2ff44a-8165-b8c6-8094-c5d337c5f68d@infradead.org>
Date:   Wed, 1 Mar 2023 22:09:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] f2fs: introduce discard_cpuset mount opt
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230302055103.60116-1-frank.li@vivo.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230302055103.60116-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/23 21:51, Yangtao Li wrote:
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 2055e72871fe..dc005f3b784a 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -351,6 +351,8 @@ age_extent_cache	 Enable an age extent cache based on rb-tree. It records
>  			 data block update frequency of the extent per inode, in
>  			 order to provide better temperature hints for data block
>  			 allocation.
> +discard_cpuset=%u		 Set the cpumask of dicard thread, it makes the discard

				                 of discard

> +			 process run faster on a more powerful CPU, or not.
>  ======================== ============================================================

-- 
~Randy
