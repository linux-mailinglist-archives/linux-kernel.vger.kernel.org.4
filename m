Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7281E6C0EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCTKdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjCTKcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:32:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609CE23A7E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T4qG7maVMwor9LVKYZmPMVk7R8iW4VegowUe3JA+Kgw=; b=V+1owgNaHvlFM8aszmaPn6kVGT
        CoKhawZaXwPq8cp9f6tUcu3PBrlyKBYnZS9OBxFG7fZB2VgsJeS439utDaSD1P1rRtwzUnjOBGvZo
        pkXKSOEdVq7MKx7W1zrBv5zcVUccclGTFYkqsjQZquYYF01/u28aQ09R58/eyupd18S2wlU7mbNOq
        hvXjvSHDTnbetIXF7YPNDRjSXBurj50L3rZckXugb2kxF++42iQjmqGloWpvj0chEQQjsWMZ3Sjm4
        QE/qEJ4QPlpuD8WIvbjmLfyJQ3zAFjurMFrvhnFZGtS4O5Vh5qZN8QSY9dWrDw3r/AlMQuK3zBvi8
        MVm15enw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1peCoa-003tPn-0l;
        Mon, 20 Mar 2023 10:32:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AAFEA300137;
        Mon, 20 Mar 2023 11:32:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BD3D20EEFFEF; Mon, 20 Mar 2023 11:32:30 +0100 (CET)
Date:   Mon, 20 Mar 2023 11:32:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        eranian@google.com
Subject: Re: [PATCH 1/3] perf/x86/intel: Add Granite Rapids
Message-ID: <20230320103230.GG2194297@hirez.programming.kicks-ass.net>
References: <20230314170041.2967712-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314170041.2967712-1-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 10:00:39AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> From core PMU's perspective, Granite Rapids is similar to the Sapphire
> Rapids. The key differences include:
> - Doesn't need the AUX event workaround for the mem load event.
>   (Implement in this patch).
> - Support Retire Latency (Has been implemented in the commit
>   c87a31093c70 ("perf/x86: Support Retire Latency"))
> - The event list, which will be supported in the perf tool later.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Thanks!
