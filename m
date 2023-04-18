Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581546E648F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjDRMuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjDRMuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:50:11 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE1E9167FE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:50:08 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 33ICnaN3014619;
        Tue, 18 Apr 2023 14:49:36 +0200
Date:   Tue, 18 Apr 2023 14:49:36 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/alternatives: fix build issue with binutils before
 2.28
Message-ID: <ZD6R4KtTz9pKsU9n@1wt.eu>
References: <20230418064228.21577-1-w@1wt.eu>
 <20230418100212.GBZD5qpFuxKaz3WtAC@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418100212.GBZD5qpFuxKaz3WtAC@fat_crate.local>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 12:02:12PM +0200, Borislav Petkov wrote:
> On Tue, Apr 18, 2023 at 08:42:28AM +0200, Willy Tarreau wrote:
> > Boris, I understood from your message that 2.28 was the first working version,
> > so that's what I mentioned here. My tests showed that 2.27 wasn't sufficient
> > and that 2.29 was OK.
> 
> No, you have it right above:
> 
> U suffix - 2.27
> L/LL suffixes - 2.28
> 
> I was wondering where to put that info for future reference but didn't
> find a good place so I extended your commit message with it. Now at
> least we have left bread crumbs in case we need it in the future.

I wondered the same which is why I left it in the comment as a warning
for future wanderers.

Thanks!
Willy
