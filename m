Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3CC74965F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbjGFH3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbjGFH3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:29:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6671BEE;
        Thu,  6 Jul 2023 00:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rUwhX9RA+8tYx9//UhZVA2h7/nKb200z/ToeEuZUR34=; b=UU5M9ye/reR7cc8W0lZhVvwiE7
        1qKZnyoaYHe2oyCvbkqyofdCSpXYPS+6Q8yLuG9mpYJg7BxjJx/CcS0dE/OsXJnWHxi2eqMWaT543
        Rg9Qax/y7WARrQUDQXCFqXwKRfArRmUKcwpKqljg4fEh5kB0hXnlY5Dsy9qVXL/FpCntGPlnFnoNl
        NbjY0Oqku45jjny4zlADSMQKvZxiLvPUFnaot/ooFdcb5trws5JxbkE0/ZgchMCgt2iziRurHJXSQ
        eG2eLTwNzpTPNoSaqoN94PWMQmDdeiszrFcgzI0UTuoRN9ClvlF9SOgGa3nb6SrWtReeI12aab+Kl
        fvfcQAdA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHJQI-00DVmV-2I;
        Thu, 06 Jul 2023 07:29:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D4AAB3002E1;
        Thu,  6 Jul 2023 09:29:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9208F200E5EA2; Thu,  6 Jul 2023 09:29:05 +0200 (CEST)
Date:   Thu, 6 Jul 2023 09:29:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Greg Thelen <gthelen@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] perf/x86: Fix lockdep warning in
 for_each_sibling_event() on SPR
Message-ID: <20230706072905.GE2833176@hirez.programming.kicks-ass.net>
References: <20230704181516.3293665-1-namhyung@kernel.org>
 <20230705083833.GE462772@hirez.programming.kicks-ass.net>
 <CAM9d7cidyAD67Qr_bVW4EEm0+_87qv8O0JVmO9dmr6La9PRLSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cidyAD67Qr_bVW4EEm0+_87qv8O0JVmO9dmr6La9PRLSQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 08:11:53AM -0700, Namhyung Kim wrote:
> Yep, looks good.  Do you want me to resend?

Nah, I've got it. Thanks!
