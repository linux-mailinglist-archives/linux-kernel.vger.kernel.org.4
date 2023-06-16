Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F7E732600
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 05:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjFPDuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 23:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjFPDuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 23:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4CE26B8;
        Thu, 15 Jun 2023 20:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7392D60B82;
        Fri, 16 Jun 2023 03:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76365C433C8;
        Fri, 16 Jun 2023 03:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686887415;
        bh=AXC5dpSEQ4N/06ZWs4qAu4V+k/LkfBBRx7yBQPylb2U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LhooYMnnsqbFES+EtTxMu7IdeX71SQXdvgQyEk4HYiKDTbYALLu2cnp7WzghSlgRD
         rxsue3ACEJraimsQCGwAdZZhLGj7z3V62gz9rFwIvUniHMIN/82gq/9Yb85vGT+w+M
         SAs9MmnZOCcpAqIg39B4PLWc9+fOo/+MnNCstiiQ=
Date:   Thu, 15 Jun 2023 20:50:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: linux-next: manual merge of the block tree with the mm tree
Message-Id: <20230615205014.8d7eb4457ca9bc676a79d2db@linux-foundation.org>
In-Reply-To: <20230616115856.3ce7682c@canb.auug.org.au>
References: <20230616115856.3ce7682c@canb.auug.org.au>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 11:58:56 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Today's linux-next merge of the block tree got a conflict in:
> 
>   mm/gup.c
> 
> between commit:
> 
>   0f3f569eca46 ("mm/gup.c: reorganize try_get_folio()")
> 
> from the mm tree and commit:
> 
>   c8070b787519 ("mm: Don't pin ZERO_PAGE in pin_user_pages()")
> 
> from the block tree.
> 
> I fixed it up (I think - see below) and can carry the fix as necessary.
> This is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

That's getting a bit nasty.  Maybe David's patches are in the wrong tree.
