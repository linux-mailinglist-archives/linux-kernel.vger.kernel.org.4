Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F551601EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 02:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiJRALj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 20:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiJRAKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 20:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDDD86FA4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 17:08:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB48161314
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23EDC433D6;
        Tue, 18 Oct 2022 00:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666051725;
        bh=059ej3N3LCfOk9I0E1+oeuSb34gsOMCdCbfImib7Ma4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kgcD7q1izzkWZUUI1cCZmobXfuTeE1/sxZfdWshlu4cXhKF/qR4WgvcRHz0vHYSwL
         wABdCfXfc8yvF9t+BKmlpLYqzxP7KBBO+78hlGMP74xYMce/hoRcNcAsk9xh5PgPTr
         VCWaF9vR0EsDsirW1dCJzkNSOAfKY4Jeziu2vOnI=
Date:   Mon, 17 Oct 2022 17:08:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 8/8] zram: correct typos
Message-Id: <20221017170844.3284c18376b16713c09b315b@linux-foundation.org>
In-Reply-To: <20221009090720.1040633-9-senozhatsky@chromium.org>
References: <20221009090720.1040633-1-senozhatsky@chromium.org>
        <20221009090720.1040633-9-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  9 Oct 2022 18:07:20 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> Trivial comment typos fixes.
> 
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -759,7 +759,7 @@ static ssize_t writeback_store(struct device *dev,
>  			zram_slot_unlock(zram, index);
>  			/*
>  			 * Return last IO error unless every IO were
> -			 * not suceeded.
> +			 * not succeeded.

That's a pretty awkward sentence.  Why not "unless every IO failed".

If that's indeed what we're doing here.  Sounds odd.  What do we return
if all IOs indeed failed?


