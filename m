Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F358264BD12
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbiLMTR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbiLMTRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:17:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68445120A8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:17:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E767AB815B1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 19:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B4CC433EF;
        Tue, 13 Dec 2022 19:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670959050;
        bh=oQXZwLpEHai9jIJPJXjlwzNaTMDa9dkWWo0SoGbc+jw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c3hwuUoTS1nYS74nAYE15G6ufa1d8mbLQGLmD0fIG3cSe19dTDwanL2uGifbWSDQA
         6Dnn+NMMr4QtV4gse2Jsjb0y5gPXG3ixDuEEBCSXAlIlkq2ni+KPgKGGlBle2vCrNc
         7ZKlPNkCnsV5CojmO7mSa61aOiNgpgbYd6oi8TPrFYZv8Hh7+iAJtpaSyRTq2yDU3P
         kl1vtvkeXvL5cAjPARciDVEWFfFyXHWB4SFt4HAX9zYYXMV+x7zzN/UvtifQTs4ami
         uHqdk8UNPxzVZ6g+YRFjyXoGAmCBhW/Hz2wlV5WL7NDcT2di2SfNGPtpvtj5ge/yzu
         +EKgtvV0EudxQ==
Date:   Tue, 13 Dec 2022 11:17:28 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: add support for counting time of submit discard
 cmd
Message-ID: <Y5jPyEiAtDPx7VSI@google.com>
References: <0cc89bf7-ea7c-d6e9-5ba9-548181de4c82@kernel.org>
 <20221213122121.18685-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213122121.18685-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13, Yangtao Li wrote:
> Hi Jaegeuk,
> 
> >>> Again, w'd better to consider this functionality only when DEBUG_FS 
> >>> is enabled.
> >> 
> >> BTW, why can't we use iostat to get the discard latencies?
> > 
> > Agreed.
> 
> Let me spend some time on this. So, I guess this patch can't catch up with the merge window.
> And I still have some patches that have not been picked, can you take a look, hope they can
> catch up with the window.
> 
> How long is the 6.2 merge window left and when will you send the f2fs 6.2 pull request?

I cut off the patches for this merge window. Please consider next release.
BTW, could you please send a patch set instead of random posts? It's quite hard
to find which one was merged or not.

Thanks,

> 
> Thx,
> Yangtao
