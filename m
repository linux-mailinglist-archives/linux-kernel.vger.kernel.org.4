Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA6062F261
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241617AbiKRKT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241636AbiKRKTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:19:23 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9970C91535
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8rRNDeRFgVZir45+ZA1uJGRHB1QAmfECU+I4F8fHpW4=; b=B9scApLAGGkiDAnWaiG7tyH5F9
        cL2PSspCDkX8oebiC4eyXDdN3/pu/WPJU+4j8Qh2u8ZUJ/i8JSqztAaZNsp99Nb5KLu/o/VLWoQMe
        NhFa6NEN+tmuoIf9WwlMEPxNBW6n8mWYKr/l40OdeV8QqSnD9FD6i1Rbapz2bTxfgftM2KpOz+dpX
        404g/3J7udrvAmcdb1Ps8SLucpA6YRlBuYAbDm5gMn6qtkCp8b4tIxlwfCH0TTpL0dnyAZoChNcE+
        5kB9YUn/HwDdQAy69lGracDNf+2sA1VTuvc5tPAQk+K9phf7cizf1Uw4cgS2BzCZ3SQNTXfOSO8gg
        qJiPD29g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovySU-001wqr-G0; Fri, 18 Nov 2022 10:18:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 696CB300462;
        Fri, 18 Nov 2022 11:18:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D0D5201A1023; Fri, 18 Nov 2022 11:18:53 +0100 (CET)
Date:   Fri, 18 Nov 2022 11:18:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bing Huang <huangbing775@126.com>
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, brauner@kernel.org,
        bristot@redhat.com, bsegall@google.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        vincent.guittot@linaro.org
Subject: Re: [RESEND PATCH v3] sched/topology: Add __init for
 init_defrootdomain
Message-ID: <Y3dcDcYLAoovR4PZ@hirez.programming.kicks-ass.net>
References: <20221118034208.267330-1-huangbing775@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118034208.267330-1-huangbing775@126.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 11:42:08AM +0800, Bing Huang wrote:
> From: Bing Huang <huangbing@kylinos.cn>
> 
> init_defrootdomain is only used in initialization
> 
> Signed-off-by: Bing Huang <huangbing@kylinos.cn>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> ---

Thanks
