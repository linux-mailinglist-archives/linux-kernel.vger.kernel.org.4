Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C9C61054E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbiJ0WCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbiJ0WCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:02:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460A2A2AA7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6+VZzsdxBrBrErFu84sINYJyQuWEbeDZZXKnI9VHrwI=; b=PYg6SVV8jrKEP58y8U4lw4FB35
        Bme5qyNxD2FHZ7jlmuvsaGJOJMZDiYZqsWiyPOSW75ZLMALXXmBnK8xnewATXmGZ1mUHDX2pt4OLF
        EBn/J7J08HEE0wrC+LUzH7BzsusQnmeCnHTjBPsXUeNmB40QOEFACQuHKq2ZnDDEnPkGR3SGc5GXd
        NTWCSdg5XfLzuf4ixKUaQXq3anQJmQuka5JhHxOJ8fyWmINL4reaB0qFTaxBD3yjDQws21p+MlQTg
        b0rZUr7YGSfu4mpZb9wKMKHwJxJYbSxegYxxIBvug2ghqZVujvqNKnaI57OdG9idtucEPs9zepDZ+
        IXnstMUw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ooAwv-000fZo-QP; Thu, 27 Oct 2022 22:02:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C918F300411;
        Fri, 28 Oct 2022 00:01:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88C9B2C4502E9; Fri, 28 Oct 2022 00:01:59 +0200 (CEST)
Date:   Fri, 28 Oct 2022 00:01:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [tip:perf/core] BUILD SUCCESS
 dc39beffcfc19a8dd2a09c5818dcd1a4e9099033
Message-ID: <Y1r/15SeteYfbFbA@hirez.programming.kicks-ass.net>
References: <635aef44.eRNqJ814AXKXgqPJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <635aef44.eRNqJ814AXKXgqPJ%lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 04:51:16AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
> branch HEAD: dc39beffcfc19a8dd2a09c5818dcd1a4e9099033  perf: Optimize perf_tp_event()

The robot is still broken:

  202210272227.jWuKg5y6-lkp@intel.com
