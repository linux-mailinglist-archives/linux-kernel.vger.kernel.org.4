Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891C26AE8B1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjCGRSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjCGRSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:18:07 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C2293861;
        Tue,  7 Mar 2023 09:13:46 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 450A42C3;
        Tue,  7 Mar 2023 17:13:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 450A42C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678209225; bh=qSVrBz0WximCcfY4zLzS/VnrBwrJrJcFf9vUaBYwddw=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=ChK59Xbu/KyJsZUyztBsg4QnSamAm/HkOgKeeU7eikkRUVnevEc0Ow+BtugeP42dq
         X7kQVBP1nj6QapHnvZQiKCCeH6Obs7zbDXjNmMcFUrnSm0Y5MFF81IKstpNryfSHtD
         GBUoa03xIXd0FJOadldvRjRuP04AYrjXqW47FmDLfWK4jnFkkaDJ5g0hqhtHDw9Ykh
         TjfKMc+WTJYyXsZtg3JLmkhRvQ1p5vVl7bZPpN0aXVdFSw5iaon9tNhB54vsvEsjy4
         /L1Y92CKQXJ54GfTvERWLj8yVFmdFfsIegbXXahNk0FgT1Z3umyVPIi1ASXmK+WdqI
         vk1HAkmLKW+6Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bru Moreira-Guedes <codeagain@codeagain.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH] coding-style.rst: indentation: Clarify tabs text
In-Reply-To: <20230228222035.k227xb3okt2lbksn@guidai>
References: <20230228222035.k227xb3okt2lbksn@guidai>
Date:   Tue, 07 Mar 2023 10:13:44 -0700
Message-ID: <87356gpjqv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bru Moreira-Guedes <codeagain@codeagain.dev> writes:

> The old text about tabs failed to clearly convey the message that the
> TAB character is used for indentation. It also gives the misleading
> impression that it's trying to "redefine" what a tab (the 0x09 ASCII
> character) is when it says "tabs are 8 characters".
>
> It might be misleading, especially for some autistic readers for whom
> English is not the first language and whose tendency to interpret things
> more literally might be present (i.e., my very own self).
>
> The present patch clarifies the tabs text on such aspects.
>
> Signed-off-by: Bru Moreira-Guedes <codeagain@codeagain.dev>
> ---
>  Documentation/process/coding-style.rst | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 007e49ef6cec..9a0205fa7ed3 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -18,23 +18,25 @@ Anyway, here goes:
>  1) Indentation
>  --------------
>  
> -Tabs are 8 characters, and thus indentations are also 8 characters.
> -There are heretic movements that try to make indentations 4 (or even 2!)
> -characters deep, and that is akin to trying to define the value of PI to
> -be 3.
> +The Linux Kernel uses the TAB character for indentation, as in the K&R
> +style. Tabs are meant to be viewed as 8-characters, and thus
> +indentations are meant to be seen as 8 characters as well. There are
> +heretic movements that try to use spaces for indentation, or make tabs
> +viewed as 4 (or even 2!) characters, and that is akin to trying to
> +define the value of PI to be 5.

I guess I really don't see how this kind of tweaking helps things; this
text has stood for a couple of decades or so without evident
misunderstandings.

...and I'm totally mystified as to why we've redefined pi from 3 to 5?

>  Rationale: The whole idea behind indentation is to clearly define where
>  a block of control starts and ends.  Especially when you've been looking
>  at your screen for 20 straight hours, you'll find it a lot easier to see
>  how the indentation works if you have large indentations.
>  
> -Now, some people will claim that having 8-character indentations makes
> +Now, some people will claim that viewint 8-character tab indentations makes

Adding typos doesn't really help either.

Thanks,

jon
