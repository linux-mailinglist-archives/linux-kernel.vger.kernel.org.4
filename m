Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5CA6EBADE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 20:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjDVScB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 14:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDVSb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 14:31:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361A11726;
        Sat, 22 Apr 2023 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Trk4E1QX06OXD2M/GUSHWRLdm5Cqab+v5Rdy0NiLloQ=; b=y4Ot7/1yEy0Ma052H8oXXR+Kun
        ofrX9SDpeoW45zo5VqRPfk6BUOxIi/gJDDfHo1nlH70MBUjbj+kL5RTSQIhPySx9G7QUTXP+m5liT
        gWvYnbDoxSpp9M2tgo1BxzvK5+BmovbGvx3dmb4rfJj3roJqAGt0Way5+44BJFUjh5VzpqEQOc+J/
        BLY3wrAIIWfhl9puHU+MHssVUeFH/NZ2Umnf5rCUvx7yn3pTUEg+e/ai7sD1Ut0uvrFv0IrewdOf6
        ctPREpIqHze56JKkrYHJ9hH1qZ/gsKVZq6RpvLRPCyQch5/zkgbboPJ5496cjQQZ3/weGZZJeQ0P/
        j9BEGFJg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pqI1b-00DEk5-01;
        Sat, 22 Apr 2023 18:31:55 +0000
Message-ID: <a1d39a73-9793-2e1f-550a-aa3495cd9414@infradead.org>
Date:   Sat, 22 Apr 2023 11:31:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH linux-doc v2] docs/doc-guide: Clarify how to write tables
Content-Language: en-US
To:     Joe Stringer <joe@isovalent.com>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net
References: <20230422175256.3396430-1-joe@isovalent.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230422175256.3396430-1-joe@isovalent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/22/23 10:52, Joe Stringer wrote:
> Prior to this commit, the kernel docs writing guide spent over a page
> describing exactly how *not* to write tables into the kernel docs,
> without providing a example about the desired format.
> > This patch provides a positive example first in the guide so that it's
> harder to miss, then leaves the existing less desirable approach below
> for contributors to follow if they have some stronger justification for
> why to use that approach.
> 
> Signed-off-by: Joe Stringer <joe@isovalent.com>
> ---
> v2: Simplify recommendation for either simple or grid table syntax
>     Remove example, link to rST user reference
> ---
>  Documentation/doc-guide/sphinx.rst | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
> index 23edb427e76f..77ac7dc27715 100644
> --- a/Documentation/doc-guide/sphinx.rst
> +++ b/Documentation/doc-guide/sphinx.rst
> @@ -313,9 +313,18 @@ the documentation build system will automatically turn a reference to
>  function name exists.  If you see ``c:func:`` use in a kernel document,
>  please feel free to remove it.
>  
> +Tables
> +------
> +
> +ReStructuredText provides several options for table syntax. Kernel style for
> +tables is prefer *simple table* syntax or *grid table* syntax. See the

   tables is to prefer
or
   tables prefers

Otherwise LGTM. It's good to have positive examples, not just negative ones.

Thanks.

> +`reStructuredText user reference for table syntax`_ for more details.
> +
> +.. _reStructuredText user reference for table syntax:
> +   https://docutils.sourceforge.io/docs/user/rst/quickref.html#tables
>  
>  list tables
> ------------
> +~~~~~~~~~~~
>  
>  The list-table formats can be useful for tables that are not easily laid
>  out in the usual Sphinx ASCII-art formats.  These formats are nearly

-- 
~Randy
