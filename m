Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7E27028A0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjEOJbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjEOJa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:30:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D7CE61
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=GDSo6fHJrQxhVodWxQP0Jzm08C1sRZl3ABMN/26j0Lo=; b=Ezrj5IZnq1yfq+IwuHejrWWBPA
        XvKScRi27swMP/MnHdHTXjcJqDYhBR1gq+WixNNmLKKcxNvu7/u9QdAeBp3zel7XahbeZtFHognea
        d2IsO7GVZGeXG4uIpcgMt5fgLJ049en2MjzCe1TB8tTbytr5M9ctNR4ti6oh8+XzMw1ZB87I2vzKo
        WE7eLDNwxNYDf/9rxJdMeA5fIwr5BH2c5FQug8yhNjnGW/pSTIVmFzEDV6GOrPd3VVRCi3zBmRSJR
        oNWF98ktbHXeTp9qR04AC9lkLEg//dnnHHhFNKBZAZhOl8sHZ1nw1NBsLvYUAVDythDscbqKxCULv
        tqRL58JQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pyUXZ-003LiZ-SR; Mon, 15 May 2023 09:30:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6BF5F300244;
        Mon, 15 May 2023 11:30:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3EB27202FCE90; Mon, 15 May 2023 11:30:48 +0200 (CEST)
Message-ID: <20230515092804.120600032@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 15 May 2023 11:28:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, Andrew.Cooper3@citrix.com, jpoimboe@redhat.com
Subject: [PATCH 0/2] x86/alternatives: More nops and some shrinkage
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

I went through my pile after seeing the x86/alternatives tip-bot messages and
found these two stragglers hadn't yet made it out.

