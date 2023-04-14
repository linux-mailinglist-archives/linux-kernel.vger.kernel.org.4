Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D416E2855
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDNQax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDNQas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:30:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF015581
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:30:47 -0700 (PDT)
Message-ID: <20230414162841.229672670@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681489845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=flXL5BT+igZd2jFVy2rrUP9R+ZUvsjSeOSfyM1mplgA=;
        b=n8Zzj9XT5skwt0s+kneK6aorlhEumvTdJA1WSfhEMGjZt9ak1fX1XTGgEIFh2ef47XvXrZ
        D7+2OXWHyDTxCYDZ5p6VALUqKfJoXpoRW0HHH0YHBw+oOcRZ1S/FmIpvqk1Vagj3ObQj9O
        XhAb7QEifrAGwZwUy43O7slG3cs7rJDZhH31szz/3jo6JJyL7cvadj/dF6fc3itd5LkmIR
        6Nv7/x9NwJssBpIPCAMK5RFKWXbW08V6A76xgvJN0CpNNlV21rYnVIrD1AXXxkCxtMQj2B
        IQSxB3B+ygO3UeXgyaFYiA3QDhYOPpSMYPwzXOsClYFIdMUFJzjFSzGEFotmQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681489845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=flXL5BT+igZd2jFVy2rrUP9R+ZUvsjSeOSfyM1mplgA=;
        b=rFhSZGVrmAMgJZ7xdunNtmMjUVUhPhUjj/zvrYcV4jB2ZZzAS80Zu3IpGYW+1VuyWt8wim
        2XkCVzBaPz/mNoAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Dave Chinner <dchinner@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ye Bin <yebin10@huawei.com>, linux-mm@kvack.org
Subject: [patch 2/3] cpu/hotplug: Remove export of cpu_active_mask and cpu_dying_mask
References: <20230414162755.281993820@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 14 Apr 2023 18:30:45 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No module users and no module should ever care.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/cpu.c |    2 --
 1 file changed, 2 deletions(-)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2643,10 +2643,8 @@ struct cpumask __cpu_present_mask __read
 EXPORT_SYMBOL(__cpu_present_mask);
 
 struct cpumask __cpu_active_mask __read_mostly;
-EXPORT_SYMBOL(__cpu_active_mask);
 
 struct cpumask __cpu_dying_mask __read_mostly;
-EXPORT_SYMBOL(__cpu_dying_mask);
 
 atomic_t __num_online_cpus __read_mostly;
 EXPORT_SYMBOL(__num_online_cpus);

