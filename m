Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6B16ABE83
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCFLpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCFLpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:45:52 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BFF26CCB;
        Mon,  6 Mar 2023 03:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yS+ytLqY5Kuqs1S5nQfCnTNPD061txIdGUAFz6FPQ5s=; b=iQSWKyYHZGeLDqMfVDY/AWWc6N
        xaupPbdfKgOCK5PFXkRVuVJGCJDHrY9kCxpVGtV7D+o/Gn2Mz7j9gR0f4ZTKbbxZR4Wk6bTJRS4M5
        +GK0QM/tFt17gDA9PiA2XEs3hB0ywUcy7Iw/UBD3ObX5HsAX4p2rz2UWSCmoLkPQt79VTOZeJWJim
        ImunN4OJdQWaNSYvRmf7apCiBFB8Ax3AM1NL8C9sr4l0PTEbv2vWDgyxSZIs/pxrp9XYwTjKimlgV
        p5pOzqIM2LEIr7uexDEYVS5JA9P3Pz6Aq23Hn1mYl58fWIbCgc1H2GCrNaGwFd98z2yXIgympMUmi
        1vL+wr7g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pZ9Hd-00Gekm-0G;
        Mon, 06 Mar 2023 11:45:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9C866300328;
        Mon,  6 Mar 2023 12:45:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7EDCB23B586C3; Mon,  6 Mar 2023 12:45:35 +0100 (CET)
Date:   Mon, 6 Mar 2023 12:45:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Manish Bhardwaj <bhardwajmanish18@gmail.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        irogers@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, namhyung@kernel.org
Subject: Re: [PATCH] perf/core: introduced stub APIs for exported APIs
Message-ID: <20230306114535.GC1267364@hirez.programming.kicks-ass.net>
References: <20230305053934.9948-1-bhardwajmanish18@gmail.com>
 <20230305092759.10754-1-bhardwajmanish18@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230305092759.10754-1-bhardwajmanish18@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 02:57:59PM +0530, Manish Bhardwaj wrote:
> Introduced stub APIs for exported APIs so that we can build
> independent module without any error if CONFIG_PERF_EVENT
> feature is disabled in kernel.

WTH would you build these drivers when PERF_EVENT=n ?!?
