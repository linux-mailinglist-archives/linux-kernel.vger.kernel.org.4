Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3D06FC76E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbjEINFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjEINFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:05:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77B310F6;
        Tue,  9 May 2023 06:05:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683637550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=66CwgAKwlAwu0o+HSirJnximEw9Bjlm23mz/HWPXU1s=;
        b=hbxyUDBnvdDjCwEe2fKEwFmkPPF3xy/eLmej2wKSXWr0d9f7bb+QqZDpCdayQQQuLelVkk
        TBajaFgXIRDO/ZagO/eatcnJ1gv/rjzhEDcs0VzmdsJ6YgoRM4296eoJYO7YsDmsXx9LuR
        Vzv/C/PAuDiXr/eriryMsopQnD1Jl6wbF6dd3jY2eGg7b1vqKV7US33B3IWgxbQruXg9cg
        FDP77qfEu0rsvW0T6gNk5AgPFmtZ9Z/i84jmz57RQnVO7Y6qgf49rjv3CnkyKDZWKNGmr2
        hu8dgyS3LbSNbPk0ZZbojg5UckR7EHhnzl3agppxpE88rRnekkpV/3voJ3aeOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683637550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=66CwgAKwlAwu0o+HSirJnximEw9Bjlm23mz/HWPXU1s=;
        b=rrH6jhUO5K6/+9ljImq/xGhfEnagn6yN0AbNdNjZ4urlUv98qTkpEpavwlAhkSMUwyWfNs
        C3Dq88rRNZXyxcAw==
To:     Jason Xing <kerneljasonxing@gmail.com>, paulmck@kernel.org,
        peterz@infradead.org, bigeasy@linutronix.de, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kerneljasonxing@gmail.com, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH] softirq: let the userside tune the SOFTIRQ_NOW_MASK
 with sysctl
In-Reply-To: <20230410023041.49857-1-kerneljasonxing@gmail.com>
References: <20230410023041.49857-1-kerneljasonxing@gmail.com>
Date:   Tue, 09 May 2023 15:05:50 +0200
Message-ID: <87y1lxzmc1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10 2023 at 10:30, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
>
> Currently we have two exceptions which could avoid ksoftirqd when
> invoking softirqs: HI_SOFTIRQ and TASKLET_SOFTIRQ. They were introduced
> in the commit 3c53776e29f8 ("Mark HI and TASKLET softirq synchronous")
> which says if we don't mask them, it will cause excessive latencies in
> some cases.

As we are ripping this out, I'll ignore this patch.
