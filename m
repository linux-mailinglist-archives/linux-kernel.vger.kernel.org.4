Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABFE6A12A7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 23:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjBWWOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 17:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBWWOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 17:14:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB294D61C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 14:14:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29A6BB81B41
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 22:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BC9C433EF;
        Thu, 23 Feb 2023 22:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677190453;
        bh=RnxJHlPSWRXarvU6ci0Mz5dmpGYg7Zjh1l9wX/cv30M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l/ntovU3NtfPjS+czoCRJ0u5ePToTMKi23Qbsnk5OlRXd1gSSBI/P0KR311Yi+ZiQ
         KksHW8pvmowntaiJuXUbS5r4rE2uconEZZ4BfGqt6IUY4/cbSAfcZr01rAbVzE4DTj
         5X+z2pArUDjtqBuwESdvMZL7V2E6G1HjYLlqjEgI=
Date:   Thu, 23 Feb 2023 14:14:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wupeng Ma <mawupeng1@huawei.com>
Cc:     <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, <bp@suse.de>, <toshi.kani@hp.com>,
        <suresh.b.siddha@intel.com>,
        <syzbot+5f488e922d047d8f00cc@syzkaller.appspotmail.com>
Subject: Re: [RFC PATCH 1/1] x86/mm/pat: Clear VM_PAT if copy_p4d_range
 failed
Message-Id: <20230223141412.cdf900eef1cd191895a650ed@linux-foundation.org>
In-Reply-To: <20230217025615.1595558-1-mawupeng1@huawei.com>
References: <20230217025615.1595558-1-mawupeng1@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2023 10:56:15 +0800 Wupeng Ma <mawupeng1@huawei.com> wrote:

> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> x86/mm/pat: Clear VM_PAT if copy_p4d_range failed.
> 
> Syzbot reports

Thanks.  It would be nice to have a Link: to this report - I cannot
find that email anywhere :(


