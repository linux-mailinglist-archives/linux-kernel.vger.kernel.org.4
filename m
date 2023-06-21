Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0B87388AB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjFUPTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjFUPT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:19:27 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D76212F;
        Wed, 21 Jun 2023 08:16:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3D5E92AE;
        Wed, 21 Jun 2023 15:16:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3D5E92AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1687360584; bh=chmZVYHQWAtp0+YhMwYUVZYO0x+frMZn8RXnhFX2axM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PVouSXL1kcrOYu13TPNsjRz4/U268ui2B5pMykvj90GH6aK215k4u7fddjLupjItN
         3X7Z9N244lgT9Z41aMRF8CrNSHu1/7FdaTojDwDZbe3bIMQUVCxm7sYKJ4H7FbSBAX
         ylDP8zIWvRpjapiwSlShzDku1aivHQyfKEG1+rwtHY5uhUYFpJMnsN8vElmwkKNgGA
         15zKj4BaJyh5VgLYDZY58aVPTzZNn1S/vGphP9binIP2hs8eEWYIxkxw1Shs4vobXx
         hoNd6xJBCcKHLij3RGgfP4c4cEHYeU133TGQkqqlQGNof0WJ4gwvoU04/Hden5yOTE
         VhF3dYRR7puSg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] Documentation: update git configuration for Link: tag
In-Reply-To: <20230619115533.981f6abaca01.I1960c39b1d61e8514afcef4806a450a209133187@changeid>
References: <20230619115533.981f6abaca01.I1960c39b1d61e8514afcef4806a450a209133187@changeid>
Date:   Wed, 21 Jun 2023 09:16:23 -0600
Message-ID: <87352krgl4.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> The latest version of git (2.41.0) changed the spelling
> of Message-Id to Message-ID. Adjust the perl script here
> to accept both spellings.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  Documentation/maintainer/configure-git.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/maintainer/configure-git.rst b/Documentation/maintainer/configure-git.rst
> index 80ae5030a590..ec0ddfb9cdd3 100644
> --- a/Documentation/maintainer/configure-git.rst
> +++ b/Documentation/maintainer/configure-git.rst
> @@ -56,7 +56,7 @@ by adding the following hook into your git:
>  	$ cat >.git/hooks/applypatch-msg <<'EOF'
>  	#!/bin/sh
>  	. git-sh-setup
> -	perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|g;' "$1"
> +	perl -pi -e 's|^Message-I[dD]:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|g;' "$1"
>  	test -x "$GIT_DIR/hooks/commit-msg" &&

Applied, thanks.

jon
