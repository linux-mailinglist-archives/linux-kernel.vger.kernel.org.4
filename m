Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E2C728151
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbjFHNZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjFHNZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:25:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21C1E4A;
        Thu,  8 Jun 2023 06:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kT+CSh674tD6IDPwdGpH0CMcraDHp8mLaU8ZvFqdy7U=; b=PCephHGRr5xu+LZk4lGEVP0fm7
        ANXBkWh4Npo9wMyuuVIDitGFbyE+uRenm6VSZMGi/1BEqEcqH9HQm94/2fWPqs3R+Q2CQhXGcl7lU
        0f4CMb1huvyMbgbX88+cmSvz1Fj1AR/Gm0Pfjd4fBv7KCrGqTYnxcC4NSeZzWKip2KrnzQUynGNM2
        TI5rz9l2WwQfvzJcFHy4Up3Pfm7lCfeRGLLxhTJVbAx24pFkr4QqA9vuaqcErfIm/jX61OnF0Tpqn
        wa91sqld+hyydkMilV80kKKitXmxtS5Gpb4QUIZfAsPxVIfX++w3/m2LVZjsdQ0QZ4yuyHNhbtaRc
        JWP5+WgA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q7Fdu-00FV8E-Cc; Thu, 08 Jun 2023 13:25:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F31133001E7;
        Thu,  8 Jun 2023 15:25:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B0AB223FF6AD1; Thu,  8 Jun 2023 15:25:33 +0200 (CEST)
Date:   Thu, 8 Jun 2023 15:25:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf tools: annotation browser from c2c tui
Message-ID: <20230608132533.GL998233@hirez.programming.kicks-ass.net>
References: <20230608084407.140323-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608084407.140323-1-asavkov@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 10:44:05AM +0200, Artem Savkov wrote:
> These patches add ability to start annotation browser from c2c report
> tui. The idea comes from Arnaldo's "Profiling Data Structures" talk [1].
> 
> [1]: http://vger.kernel.org/~acme/prez/linux-plumbers-2022/

So what are the plans for doing IP to datatype::member resolution and
deleting this C2C abomination?

/me still regretting ever letting c2c happen..
