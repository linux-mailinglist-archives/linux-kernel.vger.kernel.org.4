Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DE06DD101
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjDKEgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjDKEgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:36:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0BC10DC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:36:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED80961A1B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06084C433D2;
        Tue, 11 Apr 2023 04:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681187779;
        bh=1P2KNZzmPBQ/jvFABigQoqWTKQltEhWgYJBtKz3MZKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xafP8tEBL+FHQKa8mDTMg+iZRLQPxVNwMhB0AgPseJ3hM7dFpvWNr3aVFZqSxAwAj
         TW9xlfyotihADUkqhTJXY3C8JqWmStXYLoObk5zEyUolPJq1iGqJkFfIKeMpNUIqK5
         YheGwCwNBLu3KVwDPNbm6ITkDI47dhyEm/3ZMTQg=
Date:   Mon, 10 Apr 2023 21:36:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     yizhou.tang@shopee.com
Cc:     neilb@suse.com, tj@kernel.org, wufengguang@huawei.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tangyeechou@gmail.com, chunguang.xu@shopee.com, yue.zhao@shopee.com
Subject: Re: [PATCH] mm: Fix memcg writeback for rt tasks
Message-Id: <20230410213618.0d8b2b19a15376dfd49e3c53@linux-foundation.org>
In-Reply-To: <20230403165708.352841-1-yizhou.tang@shopee.com>
References: <20230403165708.352841-1-yizhou.tang@shopee.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  4 Apr 2023 00:57:08 +0800 yizhou.tang@shopee.com wrote:

> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> Neil said he didn't know what was wanted for realtime in the commit
> message of commit a37b0715ddf3 ("mm/writeback: replace PF_LESS_THROTTLE
> with PF_LOCAL_THROTTLE"). I think we need to distinguish between the
> global writeback and memcg writeback in domain_dirty_limits() for the
> rt tasks.

Why do you think this?

> Fixes: a53eaff8c119 ("MM: increase safety margin provided by PF_LESS_THROTTLE")

In what way does it fix it?  Please describe the user-visible effects
of this change.


