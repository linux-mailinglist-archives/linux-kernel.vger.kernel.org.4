Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF1E62D4DE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239382AbiKQISj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiKQISd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:18:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3588112AC5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6HZaZdYulB8VEm9iCmNPwAQw1UQnXVxXHiG+B84Uifs=; b=B7ET6f7mecPsPI1uv3FTDflr9o
        tLy3vcyrFMMQ99f2OlQQaisrYp5u2Mdg5HocOEOY0w131VAS09Q1xjnrGw9TfnN148TVzEcnqVZWk
        SxdCp71DWhtyhgW7F5PLGXg5m5WkOXvJUlJR9iX2chBCTChTo/yPFPjBpdepZcXbvAP0xU7TNj+HK
        HsPFp0nu3T+5CvdwKNyf01Iwz1uh2imxG138adsYYhux8JUyjndztDVFti7V4oRZAn7JV72NsdARp
        TY0aRQ0F73L7yYQ0TXF/WEl5cjU2jtBCtYep4x+V9jzgMNn1ehDeBs+h60kwrBQsyxvp+jIXnwUr8
        w40zOYpQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ova6K-000nQe-0M; Thu, 17 Nov 2022 08:18:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 40F6E300487;
        Thu, 17 Nov 2022 09:18:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 230712009E422; Thu, 17 Nov 2022 09:18:16 +0100 (CET)
Date:   Thu, 17 Nov 2022 09:18:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [tip:perf/core] BUILD SUCCESS WITH WARNING
 e8d7a90c08ce963c592fb49845f2ccc606a2ac21
Message-ID: <Y3XuSNJseSRckyHn@hirez.programming.kicks-ass.net>
References: <637553b5.ebdZY+lvkXPfAk1E%lkp@intel.com>
 <Y3VYQtTSJDpwKZR5@hirez.programming.kicks-ass.net>
 <a2feaf02-4b36-f86f-b6ff-018aafe81fac@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2feaf02-4b36-f86f-b6ff-018aafe81fac@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 09:26:49AM +0530, Ravi Bangoria wrote:
> Hi Peter,
> 
> >> kernel/events/core.c:11274:4: warning: cast from 'int (*)(struct perf_cpu_pmu_context *)' to 'remote_function_f' (aka 'int (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
> >>
> >> Warning ids grouped by kconfigs:
> >>
> >> clang_recent_errors
> >> |-- hexagon-randconfig-r001-20221116
> >> |   `-- kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompatible-function-type
> >> |-- hexagon-randconfig-r005-20221116
> >> |   `-- kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompatible-function-type
> >> `-- s390-randconfig-r012-20221116
> >>     `-- kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompatible-function-type
> > 
> > Robot guys; why don't I have a report of this warning?
> 
> https://lore.kernel.org/all/202211041643.J58xvn1k-lkp@intel.com

Hurgh, clearly I can't even search :/

> I'll prepare and post a fix.

Already did that last night:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=perf/core&id=3aed27110419792e8e26ba3aed1dd9462975cc6e
