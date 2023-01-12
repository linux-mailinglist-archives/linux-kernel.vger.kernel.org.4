Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7096678DD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240370AbjALPQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjALPPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:15:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC0C1CFF7;
        Thu, 12 Jan 2023 07:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MC/NVyEC+LEfhcig7OxVywPKp5aS+P3s0NbcBgzZCAk=; b=aNCu7F2YwBL/HEzz4B15O41UW+
        2KiaggPnSe6QcACfAlzDtIKdmMHDnOW27eQ7TS/uDDlMS9Wpo3tYiyEnNRszL1tLu0RUnbxEXKXNe
        QmIy27GybnFFY3twkx/BwwFILXNhar9gX1gOi6WdxjEYstkKO7ABBVUaFMwcHNk7b+07drk8Wu67S
        pCVmTEzFeBR/Uba5Uoy6ocPYy6qYUOKzNK8USwFxkE81CxA69KFHcKzesUz2ujT3B9vRw9NBEKUsT
        zauaLowom3qpGhulX8lgt3voxpq9aAqbPnM3FkXMhybL750pOH33mBo17yiPP8zRyyy3K7cd5y3GQ
        gFwsecuA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFzAF-00591M-3r; Thu, 12 Jan 2023 15:06:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5BEFB30084B;
        Thu, 12 Jan 2023 16:06:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1535F2CCCCB1B; Thu, 12 Jan 2023 16:06:33 +0100 (CET)
Date:   Thu, 12 Jan 2023 16:06:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com
Subject: Re: [PATCH v6 11/14] kernel: events: Export
 perf_report_aux_output_id()
Message-ID: <Y8Ah+djAEpSfIF5s@hirez.programming.kicks-ass.net>
References: <20221123195010.6859-1-mike.leach@linaro.org>
 <20221123195010.6859-12-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123195010.6859-12-mike.leach@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 07:50:07PM +0000, Mike Leach wrote:
> CoreSight trace being updated to use the perf_report_aux_output_id()
> in a similar way to intel-pt.
> 
> This function in needs export visibility to allow it to be called from
> kernel loadable modules, which CoreSight may configured to be built as.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  kernel/events/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4ec3717003d5..ad388552f1d5 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9231,6 +9231,7 @@ void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
>  
>  	perf_output_end(&handle);
>  }
> +EXPORT_SYMBOL_GPL(perf_report_aux_output_id);
>  
>  static int
>  __perf_event_account_interrupt(struct perf_event *event, int throttle)
> -- 
> 2.17.1
> 
