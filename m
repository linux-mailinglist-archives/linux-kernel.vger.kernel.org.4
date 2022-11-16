Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADBB62CCD8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiKPVjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238819AbiKPVit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:38:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E466264
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FM3p1nVfRqDAuKDuE2d24zj9qT1/NTb8hurbFDn8qk4=; b=dziECNOfxJF4BmE5oBl3ExeiNM
        ykI4rogx0soP4gvKt+QYL7ODWkAn3OUsiNAEBZiwJCHa2g+6ZfbxyPS9OmFBHukL+MhAR19ZOYFml
        byx0YOPcMGPqNDZkMuoTA9uQPL2tIchPxSwaQr+9YXyO1mPelzhk+8BL57MyyTKsdiC54fMYGIq9o
        CDkw4eWikaJ2+ZW78OuxG2Eds/Cp0POUXBzEEbifq9ULuBVsFHjADFYRG0pfRyOCP7QB3QdMI+HM0
        LAsTBccl7VWS05tPjn8lPOZ6NdIUTirVPW+m3J9CJbhy43wu8m1EVgE209N2QgAUKE9FtStV0Q9Az
        JOqt1efA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovQ6t-000GAU-5u; Wed, 16 Nov 2022 21:38:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32D93300642;
        Wed, 16 Nov 2022 22:38:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE5572052EE17; Wed, 16 Nov 2022 22:38:10 +0100 (CET)
Date:   Wed, 16 Nov 2022 22:38:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [tip:perf/core] BUILD SUCCESS WITH WARNING
 e8d7a90c08ce963c592fb49845f2ccc606a2ac21
Message-ID: <Y3VYQtTSJDpwKZR5@hirez.programming.kicks-ass.net>
References: <637553b5.ebdZY+lvkXPfAk1E%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <637553b5.ebdZY+lvkXPfAk1E%lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 05:18:45AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
> branch HEAD: e8d7a90c08ce963c592fb49845f2ccc606a2ac21  perf: Fix possible memleak in pmu_dev_alloc()
> 
> Warning: (recently discovered and may have been fixed)
> 
> kernel/events/core.c:11274:4: warning: cast from 'int (*)(struct perf_cpu_pmu_context *)' to 'remote_function_f' (aka 'int (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
> 
> Warning ids grouped by kconfigs:
> 
> clang_recent_errors
> |-- hexagon-randconfig-r001-20221116
> |   `-- kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompatible-function-type
> |-- hexagon-randconfig-r005-20221116
> |   `-- kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompatible-function-type
> `-- s390-randconfig-r012-20221116
>     `-- kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompatible-function-type

Robot guys; why don't I have a report of this warning?

Also, this very much isn't caused by this patch, this is a pre-existing
issue.
