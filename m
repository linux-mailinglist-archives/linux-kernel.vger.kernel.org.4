Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891306ED5FE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 22:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjDXUNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 16:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjDXUNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 16:13:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6D6AB;
        Mon, 24 Apr 2023 13:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=SiIDFSU+Z62/XXEHoFp/GyZ6qQOEWoiUcfBeDnbRlro=; b=Lz7wKaxTd2xFXJnfX+OnBeK30T
        f7G6zAMnxpddqjQIbNU0fpdUtd50O+uwAk9YAweBcXMcu6jF2rdhP8VtLTuYArRb+DV8TGChYgh5j
        1DUI4FWMBvr8A6xTIZj9/CuYkQ/mpkK9QIVpJzgv4F8DGLhiII4MC9Ki8AbYneznrt2b4ClcDDL/7
        VNIncW96J7ayjCipRDQm1/Pi8E1B1gw8sHWL5+k9YXGdQxh4uDwxJWM2lnrIbC4n3HQ1RhlqO/wMb
        SFCpBmiw2nsc5+ur87E2wJ5OnHlrJK/OemD6I+K6Mj90r5C8KcCbbCW3P+H43YFGEmE3mnh09fwys
        0/OkisNg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pr2ZC-00H7Uw-0M;
        Mon, 24 Apr 2023 20:13:42 +0000
Message-ID: <eaff180e-cc09-8997-b7d4-9b0d8c2897d3@infradead.org>
Date:   Mon, 24 Apr 2023 13:13:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH linux-doc v3] docs/doc-guide: Clarify how to write tables
Content-Language: en-US
To:     Joe Stringer <joe@isovalent.com>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net
References: <20230424171850.3612317-1-joe@isovalent.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230424171850.3612317-1-joe@isovalent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/23 10:18, Joe Stringer wrote:
> Prior to this commit, the kernel docs writing guide spent over a page
> describing exactly how *not* to write tables into the kernel docs,
> without providing a example about the desired format.
> 
> This patch provides a positive example first in the guide so that it's
> harder to miss, then leaves the existing less desirable approach below
> for contributors to follow if they have some stronger justification for
> why to use that approach.
> 
> Signed-off-by: Joe Stringer <joe@isovalent.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> v3: Fix grammar mistake
> v2: Simplify recommendation for either simple or grid table syntax
>     Remove example, link to rST user reference
> ---
>  Documentation/doc-guide/sphinx.rst | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
> index 23edb427e76f..cd8ad7904491 100644
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
> +tables is to prefer *simple table* syntax or *grid table* syntax. See the
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
