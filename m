Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCDA5B6B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiIMJvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiIMJvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:51:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18A1580A3;
        Tue, 13 Sep 2022 02:50:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A4476134C;
        Tue, 13 Sep 2022 09:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41990C433C1;
        Tue, 13 Sep 2022 09:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663062658;
        bh=LFc8VLcHvprYH28gDo1PjrF0ebxy+2UO+x/vOTan0wQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=toW6LVrvof6E3mcs+G1NnzlNd+IXWSRQs1dN0ITSZc7EsSpizN6XMa84z0POGWWt6
         JRySY58G6lzpU1n21O8EhKBD1dis8us8urDzbCclbF7ncg9p6lAWZKNNMZLIR+14jQ
         hLFE9SH6WE5/cUGsdDXrZlKTEowc50k+GyrZ8dv7xr1FkQ4Tcvfec/iRsFcKrdmJdF
         CR54kstM97vCriYq11NtVCqfqBuIzsGxKAd8CalYEkYPwyIkSx4bmrkP1bPhw6MZee
         7YSdNwGzhx5PDJWDZG4jlHqoRtBLOpqzbcoziVBMZ2/vgebcV+oByTJ78meXmC82N6
         4Q0nfwBZxAR5Q==
Date:   Tue, 13 Sep 2022 02:50:56 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     yangxingwu <xingwu.yang@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     ndesaulniers@google.com, trix@redhat.com, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] scripts/clang-tools: remove unused module
Message-ID: <YyBSgNbJGRBNIL5I@dev-arch.thelio-3990X>
References: <20220913040753.2198-1-xingwu.yang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913040753.2198-1-xingwu.yang@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 04:07:52AM +0000, yangxingwu wrote:
> remove unused imported 'os' module
> 
> Signed-off-by: yangxingwu <xingwu.yang@gmail.com>

Sure.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Masahiro, are you able to pick this up? The original was not cc'd to
linux-kbuild but it is on lore:

https://lore.kernel.org/20220913040753.2198-1-xingwu.yang@gmail.com/

> ---
>  scripts/clang-tools/run-clang-tools.py | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
> index 1337cedca..bb78c9bde 100755
> --- a/scripts/clang-tools/run-clang-tools.py
> +++ b/scripts/clang-tools/run-clang-tools.py
> @@ -12,7 +12,6 @@ compile_commands.json.
>  import argparse
>  import json
>  import multiprocessing
> -import os
>  import subprocess
>  import sys
> 
> --
> 2.37.2
> 
