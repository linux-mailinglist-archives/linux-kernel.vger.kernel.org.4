Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006DC69A2BC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 00:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjBPX4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 18:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBPX4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 18:56:03 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63B610F3;
        Thu, 16 Feb 2023 15:56:02 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7D83B37E;
        Thu, 16 Feb 2023 23:56:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7D83B37E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1676591762; bh=diMbwq1hcd7STRYDtgcrxMgdSmLcQFCfpKLNFzdXGXQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qhNXTgS/dG0RxFbeF8CDH0Sy1rHnFKjjWQq8elgeYKW/NLaUhKsxgVGd/5AoBJ4Oo
         qTfaedBNyG1Qbb9YfnnFb0Zl22Cf4h5Gfkt5RzlYmVjyHP8KJtWUTg4rJf2w+nUH4G
         ZLkvX9IIFcBkhQiWunFer2NggmF/COsfZoX5EWk38Mmv08NcqLG4+BVdum2AP4HXMf
         rNB6M1V1GHtJiIx+BcHoXz8vHxfOWPJ0QTJE7ubg/+alLbr+3Ua+RYEPoCft7TueRB
         4Cw+MYq3tdNF0v2ltKRtfWR6tymE/Kg2wGVfhfkWUI/EQhfQmsuZORV0VAhkDiHMxB
         dmSzs3BXE6UKw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] docs/mm: Physical Memory: correct spelling in reference
 to CONFIG_PAGE_EXTENSION
In-Reply-To: <20230215100808.9613-1-lukas.bulwahn@gmail.com>
References: <20230215100808.9613-1-lukas.bulwahn@gmail.com>
Date:   Thu, 16 Feb 2023 16:56:01 -0700
Message-ID: <87bkltgo6m.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> Commit 5d8c5e430a63 ("docs/mm: Physical Memory: add structure, introduction
> and nodes description") slips in a minor spelling mistake for the config
> PAGE_EXTENSION.
>
> Correct the config name in the physical-memory documentation.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  Documentation/mm/physical_memory.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
> index 3f3c02aa6e6e..f9d7ea4b9dca 100644
> --- a/Documentation/mm/physical_memory.rst
> +++ b/Documentation/mm/physical_memory.rst
> @@ -210,7 +210,7 @@ General
>  ``node_page_ext``
>    For UMA systems that use FLATMEM memory model the 0's node
>    ``node_page_ext`` is array of extensions of struct pages. Available only
> -  in the kernels built with ``CONFIG_PAGE_EXTENTION`` enabled.
> +  in the kernels built with ``CONFIG_PAGE_EXTENSION`` enabled.
>  

Applied, thanks.

jon
