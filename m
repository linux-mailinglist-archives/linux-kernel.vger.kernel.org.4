Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD026CD2B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjC2HMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjC2HMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:12:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6108410E9;
        Wed, 29 Mar 2023 00:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xVyFzFa0vGHrAzoK/jz4xD2Vhr+N1UszQJF5RqXCysQ=; b=awGwm7B+Dc9X2afPy1X0UCXbbo
        5sZnI1VtVkFg4EIYH77zi++z/viS3LLYdpu1Q37QTVpcjGmiWce91wzD7MhXpt4Xd2O1YIeuYySX5
        G4JmYxR62dK2oNvMU/xHazezdryNooAHnrYiYenCI7rEPQH68Dlt7/pA3Qs+JjF4CxaKXDmO0nlF9
        ruNXUi2gSZPNeGaRDG3CGsdGv89+Z5a9bgKFo2RVzXdyS2d7RQoJdbHyKbO8jyI59qiA3n0LRAtXa
        ovsBaIEILxQTf2scnFYoeYoegBKqXgvt5/Nh35/+XcHVmoBezgE/6+wLrHMRlZ82GZpb7APpmscZ1
        6Yo2g5aA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1phPyF-009Byc-Pi; Wed, 29 Mar 2023 07:11:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD7A23000E6;
        Wed, 29 Mar 2023 09:11:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C11F8201D9955; Wed, 29 Mar 2023 09:11:46 +0200 (CEST)
Date:   Wed, 29 Mar 2023 09:11:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf sched: sync task state macros with kernel
Message-ID: <20230329071146.GD7701@hirez.programming.kicks-ass.net>
References: <20230329035203.6194-1-zegao2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329035203.6194-1-zegao2021@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 11:52:02AM +0800, Ze Gao wrote:
> commit 8ef9925b02c2 ("sched/debug: Add explicit TASK_PARKED printing")
> changes some task state macros, this patch makes perf-sched in sync
> 

Why does perf care? Where do we export raw state values?

That is, I really don't like this being ABI...
