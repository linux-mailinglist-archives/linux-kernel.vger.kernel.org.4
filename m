Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2AE642318
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 07:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiLEGvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 01:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiLEGvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 01:51:45 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F48120BC;
        Sun,  4 Dec 2022 22:51:43 -0800 (PST)
Date:   Mon, 5 Dec 2022 14:51:16 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670223101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nn8i4Q+q4Hh2rs3eznePR5yQ1tk1+KZhU8FkQgcnNAE=;
        b=J2y9Gkt8iE7aK5MCo5BLD7+1KW14EKKslnt1aUd6uYzeshCkM3IV8jRZ7s26ocPiSa9bpU
        ZXYK1Zbt5OQX8kjqqHLffrJBMo7j9mCf6JOvwkZaEfSUzED4RDUYO63VZGipkhdjwPQPgr
        OvJ/l8FVduX78MKbRPTVlJAUkeNk0tk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Wu XiangCheng <wu.xiangcheng@linux.dev>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Yanteng Si <siyanteng@loongson.cn>,
        Alex Shi <alexs@kernel.org>, Wu XiangCheng <bobwxc@email.cn>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/zh_CN: Fix '.. only::' directive's expression
Message-ID: <Y42U5BL9KSFQeCMm@bobwxc.mipc>
References: <20221205032622.8697-1-akiyks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221205032622.8697-1-akiyks@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-12-05 (一) 12:26:24 +0900 Akira Yokosawa 曰：
> Commit febe6c2f859e ("docs/zh_CN: Add translation
> zh_CN/doc-guide/index.rst") translated ".. only::" directive too much.
> Use the one as found in the original doc-guide/index.rst.
> 
> Fixes: febe6c2f859e ("docs/zh_CN: Add translation zh_CN/doc-guide/index.rst")
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Wu XiangCheng <bobwxc@email.cn>
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Cc: Alex Shi <alexs@kernel.org>
> ---
> Hi,
> 
> I came across this error while grepping ".. only::" under Documentation/.
> 
>         Thanks, Akira

Thanks, good catch!

Reviewed-by: Wu XiangCheng <bobwxc@email.cn>

> ---
>  Documentation/translations/zh_CN/doc-guide/index.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/translations/zh_CN/doc-guide/index.rst b/Documentation/translations/zh_CN/doc-guide/index.rst
> index 5151953c196f..78c2e9a1697f 100644
> --- a/Documentation/translations/zh_CN/doc-guide/index.rst
> +++ b/Documentation/translations/zh_CN/doc-guide/index.rst
> @@ -19,7 +19,7 @@
>     contributing
>     maintainer-profile
>  
> -.. only::  子项目与HTML
> +.. only::  subproject and html
>  
>     目录
>     ====
> 
> base-commit: f8e9e32f7d04336666d66893f2da1347dd8263b1
> -- 
> 2.25.1
> 

-- 
Wu XiangCheng	0x32684A40BCA7AEA7

