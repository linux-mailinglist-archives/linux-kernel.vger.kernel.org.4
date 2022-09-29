Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC55A5EF0E8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbiI2Ixr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbiI2Ixb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:53:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF13139F56
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fenD0+/ZdeusoeMdq5UvYwbRHvtgd17EnOp8zoD8DcI=; b=CLuhNC0gmXqmhMCJa921rlzeC+
        EIbeDdcRp0qnstucECIPxYk6A9reP5jFzVvMmEon9H/zYE9KoW9aCOSCXCpjMLUAOsNuYDFPTAP71
        yfWOw5Bxxw+siYhvO106M5iBDU1jkBUKAl0MUi8dQIVS6C0fwc2aBXI/a6fgD85kKxfuUkfQCPb/H
        KzEvLha4En6xGIlAtZwq2eT+9GYXTvpPNyzYuVtAKaSu2xZZDcpP++J+b2sAJjADgIhwX5RLH5zgs
        JFCWCht3zAbbH5lmerdfDqv7r8jEizSHOJ7yHIsTcD9nsAqCnGaXZ8Mk0LWni862qLo5+iWuHevRv
        6C7U1nrg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odpHz-00D8Gv-4c; Thu, 29 Sep 2022 08:53:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 506CF30007E;
        Thu, 29 Sep 2022 10:52:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 037D0203D391A; Thu, 29 Sep 2022 10:52:57 +0200 (CEST)
Date:   Thu, 29 Sep 2022 10:52:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     namit@vmware.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm/tlb: fix error word 'clleared' to 'cleared'
Message-ID: <YzVc6UwLSwkG7jKX@hirez.programming.kicks-ass.net>
References: <20220928151109.19364-1-xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928151109.19364-1-xhao@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 11:11:09PM +0800, Xin Hao wrote:
> Just correct the wrong word 'clleared' to 'cleared'
> 
> Fixes: c9fe66560bf2 ("mm/mprotect: do not flush when not required architecturally")

Please, don't ever use Fixes on a comment.
