Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95123626AEF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 18:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiKLRrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 12:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKLRrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 12:47:13 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F9D12743
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 09:47:11 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l14so10449821wrw.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 09:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yeWm7GyGHtOmeOmHiUe2AeKpEt0z3x9o6ccodPf45EQ=;
        b=zkocUwzIaTggBmbQU9Yj7IHmLRx08cuYh1tfWjrm5GSy/lQmcT/0jLjDDzIq8oCbS2
         4sALrb3q7/yKJfTyXlOtpyyi52l8kOq5zlWw4jF4mZBIeV74Jjs3X66VQteoUKv0fiaS
         AoRKqKSy62T4HmTLnXHmq0Gul6gjxJxttHAXTp3DR8MMtmvcv6Cfk5WT41nfETScV8HT
         z6qK49MjZcRfPNBf/7oDjAwdPrdIKUaNOljNuNW1/xFYxoSXSGT1jHBRf006b2LTma6l
         M2pxiuOuJGcYBzSfI63uxuU3W5RJBrjXhyX1PDnFnvs26nM4aBdZv0rEXb3wbY1Wx25i
         cmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeWm7GyGHtOmeOmHiUe2AeKpEt0z3x9o6ccodPf45EQ=;
        b=JaeK7mjs6/z5DlfZvXLMy7IeiSuK/Jqpv/2nCBFsQ+HGzYmvrwXeYDndaK8C89Gbx8
         ZNGuHkjU5mjIMyKP7UW4YooSh0EmOeJ2LzMB8ywxxSeueWu7lwpfIYnLK18UD/ZLhtDD
         dgvbaYbQVB2xyIJNXBL/egGI0ZccingN3QKmC6pAns12BoqUSbrLGqYl2kQ4G5SgYHER
         D1kjeII47itxVdIYbQTzvCge/jdvz4eF39XmrAeNCiYAS2j7cCc/JQ4smsNZkScoprbR
         XMq2hlyVj0YVqKf0M0d62+WMixW/opFZfvj4DAt2rGWF2eoV7m1DG/Y73Td/+FkYO201
         6gOA==
X-Gm-Message-State: ANoB5pkiVzulwi9KbvVIVXUwavBhTQTrDh15G7eWwugty5Eva0sQcA/J
        fwubcsBqoxhfxmzyaooD+GINx9FUP9DoxtcV
X-Google-Smtp-Source: AA0mqf4bdfZkRQ3PAjHyK9onZAhJYX6G5Kl2izXQ4cjWY6Dox/ldzh5wFXJ+ngneeyTK1KmWPGuhtQ==
X-Received: by 2002:a5d:67c4:0:b0:236:2f7f:4c42 with SMTP id n4-20020a5d67c4000000b002362f7f4c42mr3804174wrw.479.1668275229790;
        Sat, 12 Nov 2022 09:47:09 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c4ec900b003cfd10a33afsm6773819wmq.11.2022.11.12.09.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 09:47:09 -0800 (PST)
Date:   Sat, 12 Nov 2022 17:47:05 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, Qais Yousef <qais.yousef@arm.com>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:sched/core 3/19] kernel/sched/fair.c:7263
 find_energy_efficient_cpu() error: uninitialized symbol 'util_min'.
Message-ID: <20221112174705.pymjyzr4nqhkqfoc@airbuntu>
References: <202211121723.P4V3w801-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202211121723.P4V3w801-lkp@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/22 13:16, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> head:   52b33d87b9197c51e8ffdc61873739d90dd0a16f
> commit: 244226035a1f9b2b6c326e55ae5188fab4f428cb [3/19] sched/uclamp: Fix fits_capacity() check in feec()
> config: riscv-randconfig-m031-20221111
> compiler: riscv64-linux-gcc (GCC) 12.1.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> 
> smatch warnings:
> kernel/sched/fair.c:7263 find_energy_efficient_cpu() error: uninitialized symbol 'util_min'.
> kernel/sched/fair.c:7263 find_energy_efficient_cpu() error: uninitialized symbol 'util_max'.
> 
> vim +/util_min +7263 kernel/sched/fair.c

[...]

> util_min/max not initialized if uclamp_is_used() is false.  (I thought
> I had reported this earlier but I don't see it on vger).

Thanks Dan!

It's harmless since util_min/max are ignored in util_fits_cpu() too;
uclamp_is_used() is checked there as well.

I couldn't reproduce, I need to get GCC 12.1.0, but the below ought to cure it.
Let me test it a bit more and send a patch.

Thanks

--
Qais Yousef

--->8---

idiff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4cc56c91e06e..89dadaafc1ec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7217,10 +7217,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
        eenv_task_busy_time(&eenv, p, prev_cpu);
 
        for (; pd; pd = pd->next) {
+               unsigned long util_min = p_util_min, util_max = p_util_max;
                unsigned long cpu_cap, cpu_thermal_cap, util;
                unsigned long cur_delta, max_spare_cap = 0;
                unsigned long rq_util_min, rq_util_max;
-               unsigned long util_min, util_max;
                unsigned long prev_spare_cap = 0;
                int max_spare_cap_cpu = -1;
                unsigned long base_energy;
@@ -7258,10 +7258,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
                         * aligned with sched_cpu_util().
                         */
                        if (uclamp_is_used()) {
-                               if (uclamp_rq_is_idle(cpu_rq(cpu))) {
-                                       util_min = p_util_min;
-                                       util_max = p_util_max;
-                               } else {
+                               if (!uclamp_rq_is_idle(cpu_rq(cpu))) {
                                        /*
                                         * Open code uclamp_rq_util_with() except for
                                         * the clamp() part. Ie: apply max aggregation

