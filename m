Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EBD5E5431
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiIUUJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiIUUJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:09:04 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5534EA3D3F;
        Wed, 21 Sep 2022 13:09:03 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DE4A2536;
        Wed, 21 Sep 2022 20:09:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DE4A2536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663790943; bh=UmtzTfo4/0xLh6E30ZF1ufnH7+LQRzfKsIVJ7wUASaU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LCqmoQDdBoKvFfQZOMqL0glMhFPVqs5X9bggwK+PwtxyNsXIZNdE9CmOFUpytY6TQ
         50cCTxW3rqtuL2ccGFfNgzfBq8nBnBJPd07DIwLetBw3AwglMXRV4wNz3+mhVzV8Fi
         DmyZdQtcOfnose9CzZSqZ9hTL3H8WnXVYgjtc9nsoSDsg90mtRvJthjUWA8u7L/Ctd
         JhXZ2/OHH3/a5F7yERJBKMxNboqOb/sFjgQOr4GPEtcfO8d/eDVyhvHZ4s6OKR5qgP
         cAhHx9AqB84Z/SqVtFCRZlZ3SxHhl0nI4YtdNMwdvvXuENxyZrmzNzVdn5Vnd1mqzo
         FjETVWJ1+Sk+g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lin Yujun <linyujun809@huawei.com>, bp@suse.de,
        keescook@chromium.org, aarcange@redhat.com,
        daniel.sneddon@linux.intel.com, longman@redhat.com,
        lukas.bulwahn@gmail.com, peterz@infradead.org,
        kim.phillips@amd.com, linyujun809@huawei.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] Documentation/hw-vuln: Update spectre doc
In-Reply-To: <20220830123614.23007-1-linyujun809@huawei.com>
References: <20220830123614.23007-1-linyujun809@huawei.com>
Date:   Wed, 21 Sep 2022 14:09:02 -0600
Message-ID: <87h710v6ap.fsf@meer.lwn.net>
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

Lin Yujun <linyujun809@huawei.com> writes:

> commit 7c693f54c873691 ("x86/speculation: Add spectre_v2=ibrs
> option to support Kernel IBRS") adds the "ibrs " option  in
> Documentation/admin-guide/kernel-parameters.txt but omits it to
> Documentation/admin-guide/hw-vuln/spectre.rst, add it.
>
> Signed-off-by: Lin Yujun <linyujun809@huawei.com>
> ---
>  Documentation/admin-guide/hw-vuln/spectre.rst | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
> index 2ce2a38cdd55..c4dcdb3d0d45 100644
> --- a/Documentation/admin-guide/hw-vuln/spectre.rst
> +++ b/Documentation/admin-guide/hw-vuln/spectre.rst
> @@ -613,6 +613,7 @@ kernel command line.
>                  eibrs                   enhanced IBRS
>                  eibrs,retpoline         enhanced IBRS + Retpolines
>                  eibrs,lfence            enhanced IBRS + LFENCE
> +                ibrs                    use IBRS to protect kernel
>  
Applied (after reformatting the "commit" line to prevent linux-next
warnings), thanks.

jon
