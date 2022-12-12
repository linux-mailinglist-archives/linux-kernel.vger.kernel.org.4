Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2BE64AA3B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiLLW2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiLLW16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:27:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E121113F5E;
        Mon, 12 Dec 2022 14:27:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3D2061237;
        Mon, 12 Dec 2022 22:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063F0C433F0;
        Mon, 12 Dec 2022 22:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670884075;
        bh=mUOfQc533DZXpAH/j5qvopFJ3sk+EudlagVpWNeWq5Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=awngYhuwOj4O334dvKbdpJ7b7N1lXnBgFkewacFwb7Ay5zBThpCmOEekVXwUit+qu
         CgGJspgRJlgPApnmH8E8D75nnD0e9kceAaw8wU0k1CiskNkUuHGj9rR1poB5PFpB0n
         r062GFMYJbTPO/FuGSA62YUUuXfSh453OdtTYq/g=
Date:   Mon, 12 Dec 2022 14:27:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] non-MM commits for 6.2-rc1
Message-Id: <20221212142754.5f699c4ff515fd9d42768fb2@linux-foundation.org>
In-Reply-To: <Y5eoS/UfBhovR70j@zx2c4.com>
References: <20221212134425.b20b80955e5e8a4a36ce1b9a@linux-foundation.org>
        <Y5eoS/UfBhovR70j@zx2c4.com>
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

On Mon, 12 Dec 2022 15:16:43 -0700 "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:

> On Mon, Dec 12, 2022 at 01:44:25PM -0800, Andrew Morton wrote:
> >       wifi: rt2x00: use explicitly signed or unsigned types
> 
> Why is this part of your PULL? This was a netdev/wireless tree fix which
> was in 6.1-rc5. Kalle wrote that he took it on 21 Oct 2022 in:
> https://lore.kernel.org/all/166633563389.6242.13987912613257140089.kvalo@kernel.org/
> 

Huh.  I guess git quietly accepts the identical commit, so Stephen
never told me and my test-merge-with-Linus-latest also came up clean. 
Which leaves it to me to manually handle these things, and that's
unreliable.

Is there some way of telling git to complain about identical changes
when doing a trial merge?
