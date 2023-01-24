Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D208667A599
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjAXWU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjAXWUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:20:51 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952BA48A1B;
        Tue, 24 Jan 2023 14:20:43 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0C8B8739;
        Tue, 24 Jan 2023 22:20:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0C8B8739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674598843; bh=BFuMfm2b/s+EbxALlbvXjniNZ5TTunbX1CSvm2qW0fE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UII91CncQrnQQvKvjNPN2T6N1IsKFU7gfAE0phP1+fT0Kc2PCtZ4J/EbxhvAxm+lG
         AZj3JWcd1BNvVdqPDA/IhBmMyxX6FtCirfHoecZGi5wEEvVpaDUKf+Ay1oy9+yAwCx
         La0kbOdLLOA7QqFGeZ65Gm2QqNFj3Ket3smHsnxEPYFtJpiWXuVqk/SZ0ilqMNFRlf
         JSgAvNYzdJrV4c6HimI4Ecx6B8FDIUPbWSbEWjxpOA+ZMlfTLw7pqa+gP85nWu5fgo
         kbWs+pz6s7fjqN/CdpixL4EotCX+rpBQQhYqO056+ECHw+gCAXJyZSzFch6Myw+2Va
         y8XulmEf1gG1A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>, ogabbay@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: Re: [PATCH] docs: accel: Fix debugfs path
In-Reply-To: <1674145568-31513-1-git-send-email-quic_jhugo@quicinc.com>
References: <1674145568-31513-1-git-send-email-quic_jhugo@quicinc.com>
Date:   Tue, 24 Jan 2023 15:20:42 -0700
Message-ID: <87mt67fubp.fsf@meer.lwn.net>
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

Jeffrey Hugo <quic_jhugo@quicinc.com> writes:

> The device specific directory in debugfs does not have "accel".  For
> example, the documentation says device 0 should have a debugfs entry as
> /sys/kernel/debug/accel/accel0/ but in reality the entry is
> /sys/kernel/debug/accel/0/
>
> Fix the documentation to match the implementation.
>
> Fixes: 8c5577a5ccc6 ("doc: add documentation for accel subsystem")
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>  Documentation/accel/introduction.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/accel/introduction.rst b/Documentation/accel/introduction.rst
> index 6f31af1..11cade5 100644
> --- a/Documentation/accel/introduction.rst
> +++ b/Documentation/accel/introduction.rst
> @@ -69,7 +69,7 @@ The accelerator devices will be exposed to the user space with the dedicated
>  
>  - device char files - /dev/accel/accel*
>  - sysfs             - /sys/class/accel/accel*/
> -- debugfs           - /sys/kernel/debug/accel/accel*/
> +- debugfs           - /sys/kernel/debug/accel/*/
>  
Applied, thanks.

jon
