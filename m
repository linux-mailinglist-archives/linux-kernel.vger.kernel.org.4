Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A696C0F67
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCTKlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCTKlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:41:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1423526599
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=01kwIZYNE8DQcNEdcecmlkCa69Wrbp8wtDAfifO304E=; b=hb6BYNvbZylvmF4hmOn3Kri8lU
        s+XfJsoUQnBn8VA2pCncwOIwHlk1KR63vLCDkr8KJ6vVWuiecyUzMzsfar0g3MKz50tBW6gpFJuv6
        m8rTNvO7jNNqaeWBfFDR45lWbx0nqZwrDZXX9HUI1rSh28pYn5NCQUydidur4xDwai2UcRVU8Fbx+
        /GG0dFQ6Xnzp+fe7Ua+2ohuE9dTduvYzUAZwBrj+GsM8HBWFmsda3O8tXA8Nb9rUbQsqzX4CbdLyJ
        V+HtU+wVlN4Mq6Dk+bY51bEFsuy+5AzsvgclfZqx0cp8VGFebV6xNOV/zGvwj4qZl55Z4hZn4nabZ
        0I8Vro1g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1peCv9-000vdX-7x; Mon, 20 Mar 2023 10:39:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 46F90300392;
        Mon, 20 Mar 2023 11:39:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2454520EEFFF0; Mon, 20 Mar 2023 11:39:17 +0100 (CET)
Date:   Mon, 20 Mar 2023 11:39:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tom Rix <trix@redhat.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/topology: set varaiables sched_energy_mutex,update
 storage-class-specifier to static
Message-ID: <20230320103917.GH2194297@hirez.programming.kicks-ass.net>
References: <20230314144818.1453523-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314144818.1453523-1-trix@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 10:48:18AM -0400, Tom Rix wrote:
> smatch reports
> kernel/sched/topology.c:212:1: warning:
>   symbol 'sched_energy_mutex' was not declared. Should it be static?
> kernel/sched/topology.c:213:6: warning:
>   symbol 'sched_energy_update' was not declared. Should it be static?
> 
> These variables are only used in topology.c, so should be static
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks!
