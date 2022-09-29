Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00D65EF025
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiI2IRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiI2IRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:17:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A349213E7D6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u0Hy15iCBnLdkyQot31AyAVLdNxrvICJBUaF14ulBgU=; b=JJ09di7rmqaQhOzLaQXlY8j6Qy
        Nk0t79WIwM4aKsmGoR1vNVzlbSRBuFoDt3wOmLi0Yhd7XYYS7QgOm8U1wb+oZ7R9dUXaP/gTlx4bO
        LBPVgC9vTFspQfAD4Cexgtij787J16WJGrJPE27TDMI3NIk5UhBR0TKOx2O5uUMJ6Crposjb+Qv1w
        ksytbaVfcSkAPEjY7Vry7YVoy+CvHBL1by7StJOlbu9nQfzkWGGa4T8PVY2qAprjQJGVDnoKjAilm
        jaDUPIGxa22soaBDOgA0haMHDpJ+tM51DjOLoTOchdFHA3paQxYuJpqZOPFES841U3inL+cjf1DiP
        QyqsMadQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odoh4-00GqUK-Ta; Thu, 29 Sep 2022 08:16:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9CABD30007E;
        Thu, 29 Sep 2022 10:14:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7227E2019F96D; Thu, 29 Sep 2022 10:14:53 +0200 (CEST)
Date:   Thu, 29 Sep 2022 10:14:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com
Subject: Re: [PATCH 0/2] perf/x86/amd/lbr: fix LBR filtering support
Message-ID: <YzVT/TQtkoerDPFV@hirez.programming.kicks-ass.net>
References: <20220928184043.408364-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928184043.408364-1-eranian@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 11:40:41AM -0700, Stephane Eranian wrote:
> Short patch series to address some kernel issues with the AMD LBrv2
> enablement which were introduced in Linux 6.0.
> 
> Stephane Eranian (2):
>   perf/x86/utils: fix uninitialized var in get_branch_type()
>   perf/x86/amd/lbr: adjust LBR regardless of filtering
> 
>  arch/x86/events/amd/lbr.c | 8 ++++++--
>  arch/x86/events/utils.c   | 4 ++++
>  2 files changed, 10 insertions(+), 2 deletions(-)

If you want this in perf/urgent you're missing Fixes tags.
