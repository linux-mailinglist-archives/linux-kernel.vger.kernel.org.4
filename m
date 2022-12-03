Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B55641618
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 11:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiLCKte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 05:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLCKt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 05:49:29 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66C726CD;
        Sat,  3 Dec 2022 02:49:27 -0800 (PST)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4EF48723;
        Sat,  3 Dec 2022 10:49:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4EF48723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1670064567; bh=lN8AjR0JyuKJiSmYRuhQjOsxU5FhQ/5UmSdyE4gFS18=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=omcRW7roE/HyH3E0G+nRzbvUkGnaB5nzLMRDmsel+dPUCh0X2k0TFUei/U6Q4gc12
         FaJvXASr9Cx9HUo3OnzWsrfv9Q4m8T3IhxeYN0CqMAIOllfORJnpVdyDRHWk3jDtiJ
         22yGgYvzmT5lhMhgaXyln6poxgYUK6ism7FQDRiVo1akxRNnpSWFBtoPPSpxCsn7Ud
         Obwu4SlWu5bsFMw+PoUjeCKctqO7EcrN+OM0+tSEvEE0sf3z254B2C7VXLq8V8JE0t
         LSngkoU/1OJ2gS5QjTyzX1zdGJNCdg3N4aOfRNrjS4bzQLmeH6eLkkQMTrm22B1uXr
         0AaBVzXIxCxMw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kushagra Verma <kushagra765@outlook.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Fixed a typo in bootconfig.rst
In-Reply-To: <HK0PR01MB2801DA243B726141A97FE92EF8179@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
References: <HK0PR01MB2801DA243B726141A97FE92EF8179@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
Date:   Sat, 03 Dec 2022 03:49:21 -0700
Message-ID: <87tu2coj7y.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kushagra Verma <kushagra765@outlook.com> writes:

> Fixed a typo in the word 'concatenated'.
>
> Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
> ---
>  Documentation/admin-guide/bootconfig.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> index d99994345d41..9355c525fbe0 100644
> --- a/Documentation/admin-guide/bootconfig.rst
> +++ b/Documentation/admin-guide/bootconfig.rst
> @@ -229,7 +229,7 @@ In addition to the kernel command line, the boot config can be used for
>  passing the kernel parameters. All the key-value pairs under ``kernel``
>  key will be passed to kernel cmdline directly. Moreover, the key-value
>  pairs under ``init`` will be passed to init process via the cmdline.
> -The parameters are concatinated with user-given kernel cmdline string
> +The parameters are concatenated with user-given kernel cmdline string
>  as the following order, so that the command line parameter can override
>  bootconfig parameters (this depends on how the subsystem handles parameters
>  but in general, earlier parameter will be overwritten by later one.)::
> -- 
> 2.38.1

Applied, thanks.

jon
