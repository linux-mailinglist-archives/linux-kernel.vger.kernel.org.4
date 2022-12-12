Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FAB64AA12
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbiLLWRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiLLWQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:16:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF771ADA5;
        Mon, 12 Dec 2022 14:16:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23317B80E81;
        Mon, 12 Dec 2022 22:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291EBC433F1;
        Mon, 12 Dec 2022 22:16:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Q+Rfj5ew"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670883405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7KeoIAPwed+d+SzN4UkTZwHoxhIIXfI6f+Yf3pSqxKA=;
        b=Q+Rfj5ewra5XXnQpyA7n+18Qu2K2ZugC7OkRrwFah5fQMsg8ftMud2ZGE9HZa2tJEhIMSX
        F82tmd3j74afr/gIeQuIMtlDng477nNYzda8gL+fY7cbSOiBoCi2uAL2Vs3Yj76atFQiVg
        +pyicwHyodR7MdlR7e1bpzIRmfbFGek=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c9e2c4e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Dec 2022 22:16:44 +0000 (UTC)
Date:   Mon, 12 Dec 2022 15:16:43 -0700
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] non-MM commits for 6.2-rc1
Message-ID: <Y5eoS/UfBhovR70j@zx2c4.com>
References: <20221212134425.b20b80955e5e8a4a36ce1b9a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221212134425.b20b80955e5e8a4a36ce1b9a@linux-foundation.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 01:44:25PM -0800, Andrew Morton wrote:
>       wifi: rt2x00: use explicitly signed or unsigned types

Why is this part of your PULL? This was a netdev/wireless tree fix which
was in 6.1-rc5. Kalle wrote that he took it on 21 Oct 2022 in:
https://lore.kernel.org/all/166633563389.6242.13987912613257140089.kvalo@kernel.org/

Jason
