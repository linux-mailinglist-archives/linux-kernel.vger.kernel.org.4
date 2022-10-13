Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CD15FDCCB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiJMPDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJMPDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:03:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACE510D697
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+MzWldnwgBgJSCjiF6z01O3p1w9OM+ZVPg3JlePwOqE=; b=jf8HSL+i1oaqzPHaKSu7P/BtQX
        Rcbx5nXeaodJBQtdDBsYSw5TqFKF5j3KZyDudQ7brkNT5YGFdGr8TcguzZPqjz52wFwf27YpkE7+9
        p3tTt1uiIXcMCus/LCIEn1MGUw9Rux1cnOAGVnq8w7ex+j6ajGnFbxtVwg8t3AxH+c3a+K705INjR
        yEZYcA7GC2Yp9X++qOV9NWRGtGt0lGAgwz5gi+EC9bw4sv6X7F3Yf2ezOFE7T3amqVy/awRmdfBjF
        LWtZoTix0efjhFhWDkzv5IKqP2Hd9WkoxHodWis3qZoPqTEt0V15NOEezmtJSPAir5saoCZfGmvXO
        usoBf9qQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oiyoC-0037jM-6h; Thu, 13 Oct 2022 14:03:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A477F3001CB;
        Thu, 13 Oct 2022 16:03:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B39D2BC07BDC; Thu, 13 Oct 2022 16:03:35 +0200 (CEST)
Date:   Thu, 13 Oct 2022 16:03:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Waiman Long <longman@redhat.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:sched/core 14/15] kernel/sched/core.c:9815:43:
 error: passing argument 1 of 'zalloc_cpumask_var_node' from incompatible
 pointer type
Message-ID: <Y0gat422lQEZQgqK@hirez.programming.kicks-ass.net>
References: <202210132143.3ua042iu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210132143.3ua042iu-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 09:49:01PM +0800, kernel test robot wrote:

> > 9815			zalloc_cpumask_var_node(rq->scratch_mask, GFP_KERNEL, cpu_to_node(i));

			zalloc_cpumask_var_node(&rq->scratch_mask, GFP_KERNEL, cpu_to_node(i));

seems to work better.
