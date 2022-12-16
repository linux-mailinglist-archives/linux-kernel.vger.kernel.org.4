Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E580764EC3E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiLPNpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiLPNpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:45:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47F02672;
        Fri, 16 Dec 2022 05:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tRSHPghmRy6NeQCjqXSt9x2GIr1K5Rb63TLQzTSd66A=; b=NjcxNEkZKM0zzYoKl17AhzcpaX
        c9rZzppHS4A/rfaS29uOZPqlsK2Z+5kM4l7Ao/P9SyarapNE3bZFiuFQA91jLmKC5zvO8ef+Kanxz
        GWGSKd4ct5zXiNhMr2d1sxhRsW+YIHdP+TCToVtVnV4Pgawlc0/sEQTGkp0e+auc+JANXLuHA5m9O
        L8nrqlCxtiuKAfkjtUAdvS0HUBytGq/iQkTSK3+9cTI7RKh5VuKq68s2D/gDbzqWukHO1HP00K813
        F9swQwhHsc4lN4VpaWoPajRzp86q7OkUX/NilJwtl23Szf7gvwOu6jOUKdfbtTLwYdSXLd0doA2df
        QMGYub1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p6B1q-00FVNs-S2; Fri, 16 Dec 2022 13:45:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E080730027E;
        Fri, 16 Dec 2022 14:45:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C072D201D93F3; Fri, 16 Dec 2022 14:45:23 +0100 (CET)
Date:   Fri, 16 Dec 2022 14:45:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, ravi.bangoria@amd.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/core: Fix cgroup events tracking
Message-ID: <Y5x2czKE+csXI9B8@hirez.programming.kicks-ass.net>
References: <20221207124023.66252-1-zhouchengming@bytedance.com>
 <1a2faca7-f77b-a131-b51d-cf2705594862@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a2faca7-f77b-a131-b51d-cf2705594862@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 07:25:25PM +0800, Chengming Zhou wrote:
> Hello, ping :-)

I just queued it for perf/urgent. Thanks
