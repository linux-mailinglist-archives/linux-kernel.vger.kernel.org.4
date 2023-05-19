Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142F6709B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjESPRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjESPRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:17:02 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9300DCF;
        Fri, 19 May 2023 08:17:01 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3DABE536;
        Fri, 19 May 2023 15:17:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3DABE536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684509421; bh=CK6rRcjDmy59SAWk5ogUPHgX/+aOB52LGzE5tSHwm6g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bLWvdKK+WFSXvmaz58gi3ugXKzO6raXMduOFBnX5WxH+sXHsYkkuVqBftrLqH/1Zi
         eOBvoE4iLqIUYodItyE7dy43AIxlOObiCNjxaMcMaybS3r8N2BGWPXcWQ7Z3xHBi2O
         SUjwLlvVfuvWzakgDuDHGe+QsmhZq0rz9q2YDSAivHExqq1xjJ2xyYrjPGCuRKshGw
         2JeeuczENBfFoDHk3B4pTusxr+oxch9VlwzS+oiYC6xzFNs57JmNb49+DZ5KJjOVwc
         N/J21spsvRqR5duNeBIeJxWUfWrU7k0Hl6hHaLb23gVtN0KJo7162XBsmz8t8tz8jL
         WABbANxwWcDqQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-doc@vger.kernel.org,
        workflows@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [RFC] MAINTAINERS: direct process doc changes to a dedicated ML
In-Reply-To: <20230511020204.910178-1-kuba@kernel.org>
References: <20230511020204.910178-1-kuba@kernel.org>
Date:   Fri, 19 May 2023 09:17:00 -0600
Message-ID: <87353snyfn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> It's hard to keep track of changes to the process docs.
> Subsystem maintainers should probably know what's going on,
> to ensure reasonably uniform developer experience across
> trees.
>
> We also need a place where process discussions can be held
> (i.e. designated mailing list which can be CCed on naturally
> arising discussions). I'm using workflows@ in this RFC,
> but a new list may be better.
>
> No change to the patch flow intended.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> I've been pondering the lack of cross-maintainer communication
> as the kernel grows, and I hope this could help bring us together
> a little. Plus twice over the last 2 weeks someone popped up on
> netdev with what I personally considered incorrect interpretation
> of the process docs, so it'd be nice to CC a list on my replies
> so I can be corrected, in case I'm wrong.
>
> Opinions more than welcome!
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1c78e61a3387..58239fbc7007 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6223,6 +6223,12 @@ X:	Documentation/power/
>  X:	Documentation/spi/
>  X:	Documentation/userspace-api/media/
>  
> +DOCUMENTATION PROCESS
> +M:	Jonathan Corbet <corbet@lwn.net>
> +S:	Maintained
> +F:	Documentation/process/
> +L:	workflows@vger.kernel.org
> +

Applied, thanks.

jon
