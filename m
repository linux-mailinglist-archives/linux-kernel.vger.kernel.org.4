Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684E5618F6B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 05:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiKDEKE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Nov 2022 00:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiKDEKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 00:10:01 -0400
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693EB1EEF7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 21:10:00 -0700 (PDT)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 0D577C03BA;
        Fri,  4 Nov 2022 04:09:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 8CEC98000E;
        Fri,  4 Nov 2022 04:09:56 +0000 (UTC)
Message-ID: <780c6d84dc1a90fb29ea56541ccd7510d14086ba.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Add check for array allocator family
 argument order
From:   Joe Perches <joe@perches.com>
To:     Liao Chang <liaochang1@huawei.com>, apw@canonical.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, bagasdotme@gmail.com,
        pbonzini@redhat.com
Date:   Thu, 03 Nov 2022 21:09:55 -0700
In-Reply-To: <20221104040020.16389-1-liaochang1@huawei.com>
References: <20221104040020.16389-1-liaochang1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: u5ysdwpx8poc113yg4843oth31amo8jk
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 8CEC98000E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/pO7dBlpcnZxfYTYSnuzlZ0M7Eak8OTfg=
X-HE-Tag: 1667534996-170433
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-11-04 at 12:00 +0800, Liao Chang wrote:
> These array allocator family are sometimes misused with the first and
> second arguments switchted.
> 
> Same issue with calloc, kvcalloc, kvmalloc_array etc.
> 
> Bleat if sizeof is the first argument.
> 
> Link: https://lkml.org/lkml/2022/11/3/668

You might use the -next version of checkpatch on this and find out
it's generally better to use lore links like:

https://lore.kernel.org/lkml/5374345c-7973-6a3c-d559-73bf4ac15079@redhat.com/

> Signed-off-by: Liao Chang <liaochang1@huawei.com>

Acked-by: Joe Perches <joe@perches.com>

cheers, Joe

> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1e5e66ae5a52..a9a9dc277cff 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7128,7 +7128,7 @@ sub process {
>  		}
>  
>  # check for alloc argument mismatch
> -		if ($line =~ /\b((?:devm_)?(?:kcalloc|kmalloc_array))\s*\(\s*sizeof\b/) {
> +		if ($line =~ /\b((?:devm_)?((?:k|kv)?(calloc|malloc_array)(?:_node)?))\s*\(\s*sizeof\b/) {
>  			WARN("ALLOC_ARRAY_ARGS",
>  			     "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
>  		}

