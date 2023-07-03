Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15108745E9F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjGCOiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjGCOis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:38:48 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1741B5;
        Mon,  3 Jul 2023 07:38:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 37252380;
        Mon,  3 Jul 2023 14:38:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 37252380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1688395127; bh=CJOLB28VY5oy2fUbN32TzvRxNo0jNf8KOEvr1A+cYFA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=a0XA2JZdrPLRiDrd1E8hKH4rbWDu7I/EavXcUVXIVP42pBBR5hMWZ4XxitB007llx
         JIMzwWsaeX/4jUOSjiByvqb4Y27IMFEzfjcOsna9Je924utjCth9DX9Q1butCOXEEc
         hWYrZuAAebYQMTyOWqzAQ1EjbQDRFq0/6ibYyILPqK/8nLVFJTkDgtdtFUob3JXBmD
         1NPGwmrouhVvRouMkBVlO5/r+X8HGrFVdtbkaMpfIanMlWaaodfx9rUrc6TK3K88Te
         6UnS4DdMlbV9EZVr+TkLwlief89aaStjFLz9DGPun+6oVcKXz8sPk8xcfGImsj4Son
         /An+NtMyAEgXQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Heidelberg <david@ixit.cz>, David Heidelberg <david@ixit.cz>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: ACPI: fix typo in ssdt-overlays.rst
In-Reply-To: <20230625103305.115484-1-david@ixit.cz>
References: <20230625103305.115484-1-david@ixit.cz>
Date:   Mon, 03 Jul 2023 08:38:46 -0600
Message-ID: <87edlpjc09.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Heidelberg <david@ixit.cz> writes:

> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/admin-guide/acpi/ssdt-overlays.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/acpi/ssdt-overlays.rst b/Documentation/admin-guide/acpi/ssdt-overlays.rst
> index b5fbf54dca19..5ea9f4a3b76e 100644
> --- a/Documentation/admin-guide/acpi/ssdt-overlays.rst
> +++ b/Documentation/admin-guide/acpi/ssdt-overlays.rst
> @@ -103,7 +103,7 @@ allows a persistent, OS independent way of storing the user defined SSDTs. There
>  is also work underway to implement EFI support for loading user defined SSDTs
>  and using this method will make it easier to convert to the EFI loading
>  mechanism when that will arrive. To enable it, the
> -CONFIG_EFI_CUSTOM_SSDT_OVERLAYS shoyld be chosen to y.
> +CONFIG_EFI_CUSTOM_SSDT_OVERLAYS should be chosen to y.
>  
Applied, thanks.

jon
