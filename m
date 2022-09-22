Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8557D5E64DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiIVONh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiIVONd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:13:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CD18768F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aBYt055UUb+wOT56a3sdr9XVeyIyRkejUmbCDc/HXxg=; b=DpBfyDE6gE7AgC2KPFHBpJ1mVC
        wZZBmX7IqjyQTk8DC+j36L39onORsqtHEWUdOHVPCXLPMNjg3Zb1qym0yGMmdwj1PcuvR4M0z1lZh
        ZLwt4MW4GR/6STPP/ccvugTnPnhjd6+iCw6Sa4K3u5ffPp6mx1I9FzBn5S47H01iYqT11q8UtDD8b
        CM7dbEKh7VVgbyaSNA6M4xyPZdF/J4ogcXMUh9/8ynakeX3k5lf42XN59FxlHm8tdHvkNOa0DwZfH
        eS5ZzF7HNWhiRXJiO0raB6NiscsZivORxJO1/p2ZcLss5TGAX00xgv93sEmZIL5I2dDd8NVFHhH4T
        YxauYXzg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obMx9-00EyWa-5c; Thu, 22 Sep 2022 14:13:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 727FE300169;
        Thu, 22 Sep 2022 16:13:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 598772BBFE78A; Thu, 22 Sep 2022 16:13:22 +0200 (CEST)
Date:   Thu, 22 Sep 2022 16:13:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com
Subject: Re: [peterz-queue:sched/idle 45/48] vmlinux.o: warning: objtool:
 enter_s2idle_proper+0x78: call to ct_cpuidle_exit() leaves .noinstr.text
 section
Message-ID: <Yyxtgs/jRYcyH43f@hirez.programming.kicks-ass.net>
References: <202209220456.cXRrGXs7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209220456.cXRrGXs7-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 04:34:47AM +0800, kernel test robot wrote:

> >> vmlinux.o: warning: objtool: enter_s2idle_proper+0x78: call to ct_cpuidle_exit() leaves .noinstr.text section
> >> vmlinux.o: warning: objtool: cpuidle_enter_state+0x111: call to ct_cpuidle_exit() leaves .noinstr.text section

include/linux/cpuidle.h:static __always_inline void ct_cpuidle_exit(void)

Dear LLVM folks, ... WTF ?!?
