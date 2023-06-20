Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B61736EBE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjFTOf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjFTOfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:35:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B48FE68
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:35:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FCB26126D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52C7C433C8;
        Tue, 20 Jun 2023 14:35:38 +0000 (UTC)
Date:   Tue, 20 Jun 2023 10:35:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     zhumao001@208suo.com
Cc:     peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
        ardb@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete unneeded word in comment
Message-ID: <20230620103535.57f18960@gandalf.local.home>
In-Reply-To: <373dff7d57a69ec00de7e206895ddbb9@208suo.com>
References: <20230618143813.15142-1-dengshaomin@cdjrlc.com>
        <20230618143813.15142-2-dengshaomin@cdjrlc.com>
        <373dff7d57a69ec00de7e206895ddbb9@208suo.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jun 2023 22:47:48 +0800
zhumao001@208suo.com wrote:


Subject needs a topic. Please read:

   https://docs.kernel.org/process/submitting-patches.html


> Delete the unneeded word 'with' in comment.
> 
> Signed-off-by: Zhu Mao <zhumao001@208suo.com>
> ---
>   kernel/jump_label.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index d9c822bbffb8..08c42ae723ef 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -493,7 +493,7 @@ void __init jump_label_init(void)
> 
>       /*
>        * Since we are initializing the static_key.enabled field with
> -     * with the 'raw' int values (to avoid pulling in atomic.h) in
> +     * the 'raw' int values (to avoid pulling in atomic.h) in

Broken whitespace.

-- Steve

>        * jump_label.h, let's make sure that is safe. There are only two
>        * cases to check since we initialize to 0 or 1.
>        */

