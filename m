Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2944F6D5FF0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjDDMNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbjDDMLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:11:04 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B10630F2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:08:06 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id AA6AB3200904;
        Tue,  4 Apr 2023 08:08:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 04 Apr 2023 08:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1680610085; x=1680696485; bh=Bw/h1Rh4E0vT8Nc1IFmxcu4JEtmmInnw9fc
        s0rCMMao=; b=RqfDu87pHoRhmKtJIy++Lgz1sL5nBYETIomgBeI+GAvdqfkqWEZ
        GNMxgr4GLq78DQoT3mbP7EXhcQwnDsW7nUtpFTOLHCKnttuN6DFTpj/Oia/uwY/f
        DGbQHEZo+RIwA6h2X9c5UH1GOONbvbm97reYBs2g7FulZvs/78RZb0a08Y1YSp2e
        u7tS3Xk0BT+a0xcMaSg2BmFoTBQCfecGz4Z5GpTizwQA3biP032cQ/6HugdnY2TS
        gb2TtaQF1C6Rp5AzyKJH+TEHOv4Ymj7wffUccIBeHkMHccVzIWeZ0zc25mAkqxwj
        7D7BwdiDAEAR2k6+mSeAtKgPAHf8XOPVR+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680610085; x=1680696485; bh=Bw/h1Rh4E0vT8
        Nc1IFmxcu4JEtmmInnw9fcs0rCMMao=; b=C1nRnXZubnNTUZtq/1GWW+F3fVRSQ
        Epy9qwg5jUXNu1Brvfy8iubkikf7NvYdXf/i1i/wwOdBMtpRyWvO/6GHxfw0hwJV
        g7hV0zeI75A7zuiY4i6ha8QekB+e9lx+tcX8pE7kEqMtDHAk+12rXXU3eqGRjO8/
        NFkVwrNnBn7mHgroLIKiq1Fsa8CEjVWLtIPUv5vWLz0FcJ6VMTkPs5N7+RdAt/Y8
        8G9zs0dOfOV8x8dKiK5nwkno5AUpmmSRMuMoiVqgpA4jxZSHC+OJAU3ZvmjU6bYW
        yhb4t3GFwCwZfsFM6JBPgrtv11pHlPcJp3ax3+tFDuZJ/7BVBD0dhlBbg==
X-ME-Sender: <xms:JBMsZAK_cIDBjaSLIvdwBZ9N-BjzR6pA9J_FyRHnwmh2Wmi6fMRx9Q>
    <xme:JBMsZAI8axXDy2WifvAQpRjnZeCo0lrMlMxtJDoR8qyR0MHiUhdT3IkPQhPR2oa4I
    up4iztOnZBFkBgrFXk>
X-ME-Received: <xmr:JBMsZAuxynsbWuWoeM_GsCyTcmooayTx4g4UAXn6GahIOEzLBBs7IrWM2GHtnXKyoorSXJVI5GkjaA2brJZmlmmPu3MV8Tx0W2X5Eok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeflohhshhcuvfhrihhplhgvthhtuceojhhoshhhsehjohhs
    hhhtrhhiphhlvghtthdrohhrgheqnecuggftrfgrthhtvghrnhepudeigeehieejuedvte
    dufeevtdejfeegueefgffhkefgleefteetledvtdfftefgnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhoshhhsehjohhshhhtrhhiphhlvg
    htthdrohhrgh
X-ME-Proxy: <xmx:JBMsZNavZNUYlFP-S3-Vm-vwqp5GOGd0e8CkRJx_LsV9l8-lyO_laA>
    <xmx:JBMsZHbmZDsN1B8AyhJVNKgWBZkRI5Wsc71bw_uhn7FU6jJxtHeRiw>
    <xmx:JBMsZJDAsjr6yqdyEIuXiEAX--4Q9sMqG66BabdxDDaKTcmyC-QUyg>
    <xmx:JRMsZGVCD1zLqjWT2rFo6eYlkBchYmVWsF6XM2rjCZKRoG7hVHxG3g>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 08:08:02 -0400 (EDT)
Date:   Tue, 4 Apr 2023 21:07:59 +0900
From:   Josh Triplett <josh@joshtriplett.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH] prctl: Add PR_GET_AUXV to copy auxv to userspace
Message-ID: <ZCwTHxzUAMOzXFi7@localhost>
References: <b11a591e085f1cd06adb454b1f7cde676d317318.1680585798.git.josh@joshtriplett.org>
 <202304041715.c3b7aJd4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202304041715.c3b7aJd4-lkp@intel.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 05:58:51PM +0800, kernel test robot wrote:
> reproduce (this is a W=1 build):

Right, I *really* need to start doing W=1 builds. (Am I missing
something, or did kernel builds once emit warnings about type mismatches
on `min` by default?)

> >> kernel/sys.c:2383:23: warning: comparison of distinct pointer types ('typeof (sizeof (mm->saved_auxv)) *' (aka 'unsigned int *') and 'typeof (len) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]

Will fix in v2.
