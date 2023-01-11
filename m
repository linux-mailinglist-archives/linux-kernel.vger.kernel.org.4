Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36473666662
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 23:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjAKWrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 17:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjAKWrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:47:20 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F310F1EED7;
        Wed, 11 Jan 2023 14:47:19 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 89AE26E3;
        Wed, 11 Jan 2023 22:47:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 89AE26E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1673477239; bh=EhyTd+ajFt5Q+9nlnNhcC9cvFVR0B1AWqmysbOTk7ZM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NN/2Wt4YsxtmjdKckd4wAP+z9SKXrBYB81UXTMeNToDJMfPDaq7ABytYeiWqI91DS
         SaHZ0ShnZanKHPbx5AXhorYMSYQB639xItW6YWAPkuVIPbOjm2lFPBfE6xR2VDU/E3
         u99RRCkKKTN/wcXRolNkCzLFAqtXVdVd0ZyrtnC5LeMDPUy9Jb+FTAEk2z9rbgCw9p
         Kxatk5AGwWd87622B246HMovpNF/ssMf5d/+Uhgwn2/g6Vzb6O7bM7HFhoz3/hEpLU
         hu6iKPqAFJBi7ebCJ/6O3zXZLhzhex2KMzAW/NkCKZbcRuZP8dq+V9sem75etgcGt8
         2GfngjEULrBxw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] doc: fix typo in botching up ioctls
In-Reply-To: <20221230172328.58612-1-federico.vaga@vaga.pv.it>
References: <20221230172328.58612-1-federico.vaga@vaga.pv.it>
Date:   Wed, 11 Jan 2023 15:47:18 -0700
Message-ID: <87tu0wwux5.fsf@meer.lwn.net>
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

Federico Vaga <federico.vaga@vaga.pv.it> writes:

> The type contained a typo `uintprt` -> `uintptr`
>
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  Documentation/process/botching-up-ioctls.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> v1 -> v2 fix the typo in the commit message
>
> diff --git a/Documentation/process/botching-up-ioctls.rst b/Documentation/process/botching-up-ioctls.rst
> index ba4667ab396b..9739b88463a5 100644
> --- a/Documentation/process/botching-up-ioctls.rst
> +++ b/Documentation/process/botching-up-ioctls.rst
> @@ -41,7 +41,7 @@ will need to add a 32-bit compat layer:
>     structures to the kernel, or if the kernel checks the structure size, which
>     e.g. the drm core does.
>  
> - * Pointers are __u64, cast from/to a uintprt_t on the userspace side and
> + * Pointers are __u64, cast from/to a uintptr_t on the userspace side and
>     from/to a void __user * in the kernel. Try really hard not to delay this

Applied, thanks.

jon
