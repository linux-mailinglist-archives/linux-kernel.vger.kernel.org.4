Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FE8634264
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiKVRWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbiKVRWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:22:03 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E3F79905;
        Tue, 22 Nov 2022 09:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xopA+ReQUsDUbSSdoZR1/j1x5CA0eJOyUg7BC+5CkKw=; b=Lo2Jm2g0Z8O4nJ1DAYm1TuKy6T
        7RrtNsB1uoAh5YFuo6LX4Uszjbc8nb8JLagayHwUC+IN0uW5gbQZyy71MuoEtvJkCxEXasOzKLeFr
        629kXjOjSyVps4K5tt3ENAyonGwh+HbfQ5x9749t4JnyGRiw6/djxuDJZJjheuF2pFWkob2DF0jGv
        H1p+ZTKRMZ8TBPxeDkNZbtINQClevCD6fv9B28nhumyn6TKk+MwsQCR5I7AHlP3IaAxEcueZrZs7i
        H5KaYRwx3Xlv0/R442BrYLRcVbychpeAFyQLJ5AONtQFxu1x7axz5pNzqmokQY41DJt9xA5noEvJe
        eFLOIaaA==;
Received: from [177.102.6.147] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oxWy2-0076XC-KZ; Tue, 22 Nov 2022 18:21:55 +0100
Message-ID: <5d54530f-e039-6b88-9e58-5eb286c8276e@igalia.com>
Date:   Tue, 22 Nov 2022 14:21:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] ftrace: Prevent RCU stall on PREEMPT_VOLUNTARY kernels
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20221115204847.593616-1-gpiccoli@igalia.com>
 <20221116153620.353819e9c6acb1bf39adeca2@kernel.org>
 <d32e7b3d-31f3-9699-1eee-c1e3b2839fe2@igalia.com>
 <20221122104921.0185c58e@gandalf.local.home>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221122104921.0185c58e@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 12:49, Steven Rostedt wrote:
> [...]
> I was traveling for work from Oct 31-Nov 14 and when I got back, I had over
> 300 patches to review in my queue. I'm now down under 100, so hopefully I
> can get to it soon.
> 
> Just may take a bit.
> 
> Thanks,
> 
> -- Steve

No hurries, thanks for your heads-up!
Cheers,


Guilherme
