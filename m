Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84275603516
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJRVo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJRVo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:44:58 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBA826497;
        Tue, 18 Oct 2022 14:44:56 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9BECD2E5;
        Tue, 18 Oct 2022 21:44:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9BECD2E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1666129496; bh=MY+hBC9HFABaPCkP4Q5+2IaoGbZLglpOmW5k2aA3Qek=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WnorCfT00sbFegkNLmv1QStObP45jqDGNtiKztaQkt51F7BPvV11+PXVe6ywGNqrU
         g2TfoniDJqcPhybWVvIwRjDVxpA8TAFbHE/jicYlb1lTCKFwseZlg9a6P9H1m7rZyX
         cDNDC0G8C3+XM0GvQ3iOICHOuvu3UnMER+Xv1jGNzu8vU1+00efqoscGIFuK6xo9a2
         aAgM+XyapXBzBwmARTNKNIkbIFrvbT8H4ZssWkDHWppQRjGKJpjG2IvJQC7mASMiWe
         GlHdznU1iaihDC6IyyKN5Z4Q4EZLhk3KP/08cvnVQlslrIozp8qVh1foJgDzxyd9Vl
         EAWNmpbwpb41g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mushahid Hussain <mushi.shar@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mushahid Hussain <mushi.shar@gmail.com>
Subject: Re: [PATCH] Documentation: Fix spelling mistake in hacking.rst
In-Reply-To: <20221017112026.88324-1-mushi.shar@gmail.com>
References: <20221017112026.88324-1-mushi.shar@gmail.com>
Date:   Tue, 18 Oct 2022 15:44:56 -0600
Message-ID: <87o7u8dcx3.fsf@meer.lwn.net>
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

Mushahid Hussain <mushi.shar@gmail.com> writes:

> Fix `botton half locks` to `bottom half locks`.
>
> Signed-off-by: Mushahid Hussain <mushi.shar@gmail.com>
> ---
>  Documentation/kernel-hacking/hacking.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/kernel-hacking/hacking.rst
> index 9a1f020c8449..1717348a4404 100644
> --- a/Documentation/kernel-hacking/hacking.rst
> +++ b/Documentation/kernel-hacking/hacking.rst
> @@ -120,7 +120,7 @@ You can tell you are in a softirq (or tasklet) using the
>  .. warning::
>  
>      Beware that this will return a false positive if a
> -    :ref:`botton half lock <local_bh_disable>` is held.
> +    :ref:`bottom half lock <local_bh_disable>` is held.

Applied, thanks.

jon
