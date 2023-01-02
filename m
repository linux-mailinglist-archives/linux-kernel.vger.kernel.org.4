Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E8465B843
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 00:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbjABXjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 18:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjABXjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 18:39:32 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6563FE23
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 15:39:31 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0EDA66D6;
        Mon,  2 Jan 2023 23:39:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0EDA66D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1672702771; bh=8YRBcnpHYeyj/vv1z+6HDIBo66YYk3oBWr5/pH+qKdc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=htqX12WSUGu72JcCTyiZxiR/BeZZnxOwg4winrpyf5wzWLLxlX8LdW++qry2C9+TQ
         QP+9QR41vLxnNXEtDHLUA4vnAqMhzvOHWd/gOC833iCT1HKS81mHx8gSvrP0IQEV3v
         P5OmfmqfBy87r6anM7yk0pSap2sI6l5GItOS9owCw5M5bPOd5Z42RFC5kZnHfrNY2U
         OTDNySx6KuQmvdX/W3ZkneSgj36lH9dRbUG1JGC37pAxKTWtb/QJy4gPx5SaEhDsgK
         OCujv0HyJLM1BAScoEBh4Iq25JMWHun1WE7RMTiZvfAXdPB6cn9p9aWQRkhENbuvME
         kKogzU7VTD3xA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wang Yong <yongw.kernel@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, changbin.du@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     Wang Yong <yongw.kernel@gmail.com>
Subject: Re: [PATCH] Documentation: x86: fix typo in x86_64/mm.rst
In-Reply-To: <20221228100141.382325-1-yongw.kernel@gmail.com>
References: <20221228100141.382325-1-yongw.kernel@gmail.com>
Date:   Mon, 02 Jan 2023 16:39:30 -0700
Message-ID: <871qoch5fx.fsf@meer.lwn.net>
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

Wang Yong <yongw.kernel@gmail.com> writes:

> change "64Gb" to "64GB".
>
> Signed-off-by: Wang Yong <yongw.kernel@gmail.com>
> ---
>  Documentation/x86/x86_64/mm.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/x86/x86_64/mm.rst b/Documentation/x86/x86_64/mm.rst
> index 9798676bb0bf..35e5e18c83d0 100644
> --- a/Documentation/x86/x86_64/mm.rst
> +++ b/Documentation/x86/x86_64/mm.rst
> @@ -140,7 +140,7 @@ The direct mapping covers all memory in the system up to the highest
>  memory address (this means in some cases it can also include PCI memory
>  holes).
>  
> -We map EFI runtime services in the 'efi_pgd' PGD in a 64Gb large virtual
> +We map EFI runtime services in the 'efi_pgd' PGD in a 64GB large virtual
>  memory window (this size is arbitrary, it can be raised later if needed).

Applied, thanks.

jon
