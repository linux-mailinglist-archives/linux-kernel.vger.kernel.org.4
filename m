Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1F469F8E4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjBVQVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjBVQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:21:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891D023874;
        Wed, 22 Feb 2023 08:21:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 444C0B815DF;
        Wed, 22 Feb 2023 16:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CF8C433D2;
        Wed, 22 Feb 2023 16:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677082865;
        bh=ALNETdEU51PEu4CJMI2w79XWUtJson+3tIz0ylLmfd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J+/hddGy5uSeo2pwuvQqp4AfW6D/B5i/huBD1/LXKTnhJMGMxcnT/pPUK99l+FukY
         n4SoeynAHNk/FN5V1C/zotYdzK137etP/ovcW/YV4iL5CLIEvdn/UsJYPCCXFain5U
         gQcE93wCiM+Efer+r9C02QjOZVRC1JlrtCMrrKzg29SM3rWNaYDzB3Nt/3HkUmTG1D
         faJEqqLYWFfWD/Jcm+30/24/+JGybc9ik6VTNEzqa6yt97lQsEvyQMaY4izwSSflsy
         HsXqnxMvKDlqvGuJHc+XSLW6ve/BZ0EhqD4G8yrndcvOLClrNfV9LA+U+xEuGTMzvw
         k+nx/JQcM+ZOg==
Date:   Wed, 22 Feb 2023 09:21:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sangmoon Kim <sangmoon.kim@samsung.com>
Cc:     bagasdotme@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Subject: Re: [PATCH v2] docs: kbuild: remove description of KBUILD_LDS_MODULE
Message-ID: <Y/ZA7kqeWtWAcVZu@dev-arch.thelio-3990X>
References: <1666a6a9-4757-0e1d-f807-618c95e0b6ae@gmail.com>
 <CGME20230222104856epcas1p3a6ff45f90292df33ef5fd8216b812f64@epcas1p3.samsung.com>
 <20230222104719.16374-1-sangmoon.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222104719.16374-1-sangmoon.kim@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 07:47:19PM +0900, Sangmoon Kim wrote:
> Commit 596b0474d3d9 ("kbuild: preprocess module linker script")
> removes KBUILD_LDS_MODULE, yet the variable is still mentioned in
> kbuild documentation. Remove the reference to the now-nonexistent
> variable.
> 
> Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Thank you for your review.
> 
> Changes in v2:
>  - Update the commit message.
> 
>  Documentation/kbuild/makefiles.rst | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
> index 38bc74eaa547..468e7830c1c3 100644
> --- a/Documentation/kbuild/makefiles.rst
> +++ b/Documentation/kbuild/makefiles.rst
> @@ -1250,11 +1250,6 @@ When kbuild executes, the following steps are followed (roughly):
>  
>  	The linker script with full path. Assigned by the top-level Makefile.
>  
> -    KBUILD_LDS_MODULE
> -
> -	The module linker script with full path. Assigned by the top-level
> -	Makefile and additionally by the arch Makefile.
> -
>      KBUILD_VMLINUX_OBJS
>  
>  	All object files for vmlinux. They are linked to vmlinux in the same
> -- 
> 2.17.1
> 
