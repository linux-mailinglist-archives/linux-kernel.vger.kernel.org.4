Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F486D5C13
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjDDJio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbjDDJiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:38:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA8019BC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:38:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680601099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0DN55bSNTQFajH9UQ/ZPWNclui6hp3/dzUXrzibB4e8=;
        b=nLmjDCn+I8gKh1U6nup+PQOxkEIwwA5YaBFi6iv6Gi5SbuROVA4VgAny39IDeH9hZ1JIQ8
        EyXyXzpJpX/zbwOacFeMw7mwuu5JzGhbiF3b6RR9Z84ox2bKX4mQ8A3vzrtXzfGBaS3iLF
        Cs8jqOSO0AAzGHfLGrTEQfh8pWo3hIS+DryuDfi/hymJ+UPWBQ1C6mtyxd2UBUCOTDg6+e
        C+nyAZjsFz4+vfmpD2nmBOxt79GsU5KmChWDSMiVHGibjjjmDI2eUGR/Wp1lR12f4VYvxg
        heyez4urTQwcjMyfhUU6StPikyikmalcdrZoy6u3pWJ2urIt1PlpN7vCr6U8ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680601099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0DN55bSNTQFajH9UQ/ZPWNclui6hp3/dzUXrzibB4e8=;
        b=mNm+u/MFMwBwZ9t9EQ2Tsp/yvJ1Qa/SQNUQVXZL4K1u6JA/OW/xTAlSZ/ut0IGMFqy/BPV
        fQl1nyKmy3SgrbBQ==
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, vincent.guittot@linaro.org, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, ankur.a.arora@oracle.com
Subject: Re: [PATCH 8/9] irqentry: define irqentry_exit_allow_resched()
In-Reply-To: <20230403052233.1880567-9-ankur.a.arora@oracle.com>
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
 <20230403052233.1880567-9-ankur.a.arora@oracle.com>
Date:   Tue, 04 Apr 2023 11:38:18 +0200
Message-ID: <87pm8kq96d.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02 2023 at 22:22, Ankur Arora wrote:
> Allow threads marked TIF_ALLOW_RESCHED to be rescheduled in irqexit.
>
> This is only necessary under !preempt_model_preemptible() for which
> we reuse the same logic as irqentry_exit_code_resched().

This tells what this patch is doing but completely fails to explain why
this is necessary and useful.

Thanks,

        tglx
