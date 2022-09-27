Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9AB5EC1D6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiI0Lrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbiI0LrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:47:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3961D45F6E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uGEWpFnIH8mgHO70fR55yS14zs/6pUabOLIqb0ujfAg=; b=ZOF+IUsT0szWSaDWWP1iYNhTsl
        /85byAdPGE6I15IKCZW3Y0FOu0b/1mmr1rZBKwEGO9FPbPp9pRRaV7je4c4eXivy0a6mvA6MWgHUf
        BLoL8fw8PQx4cQVoeEBeeypYjwhJRw9TBd5WjMOoOkZxMqulVhl6hHjo7i6kZwM8km79UhUtCQMxF
        FUHJcKsdDCAtLS51OVnEW+B1xMYX+kbmqRsTte2S0YOP/C4Ac7LE1B3hdirprQJ9uRB23lmg6hjUW
        aOm7KBFaz0XOmmoGQrHfIeuH+rpmjBx+Bo/v7FTumiiP0jCQvfaL77fEIhscDPGgKKAA4T12/tiL9
        h++XfYIg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1od93H-00BOP9-FM; Tue, 27 Sep 2022 11:47:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C28730007E;
        Tue, 27 Sep 2022 13:46:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6EDB12BDDA85A; Tue, 27 Sep 2022 13:46:59 +0200 (CEST)
Date:   Tue, 27 Sep 2022 13:46:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH 14/23] thermal: intel: hfi: Update the class of the
 current task
Message-ID: <YzLis/a3aIJnJ2ZE@hirez.programming.kicks-ass.net>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-15-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909231205.14009-15-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 04:11:56PM -0700, Ricardo Neri wrote:
> +union hfi_thread_feedback_char_msr {
> +	struct {
> +		u8	classid;
> +		u64	__reserved:55;
> +		u8	valid:1;
> +	} split;
> +	u64 full;
> +};

Urgh, did you perhaps mean:

	struct {
		u64	classid    :8;
		u64	__reserved :55;
		u64	valid      :1
	};

?

Because yes, GCC does fold that into a single u64, but that's
implementation defined behaviour; the C spec doesn't require one to pack
adjacent bitfields of different types together.

I layout of:

	u8	class;			// offset 0
	u64	__reserver : 55;	// offset 8
	u8	valid : 1;		// offset 16

with a total size of 24 bytes is, AFAIU, a valid result of what you
wrote.
