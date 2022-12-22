Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A736540DC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbiLVMPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbiLVMPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:15:00 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BFC2A533
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 04:11:45 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x3so1705546pjv.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 04:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=shwwZFvYNRcVxLkvBAhBQlcpsvVebNeekhejxdi6EsE=;
        b=mIj9HkPKpukPMJVGBTu3rBG53HjEHgt8Zdcnws1iZUQHiT4JLzQF3UHkBEg5DqNkou
         gugUeAPE6ZzG6s3Kz8NX1is/cGxgIpYMdepVKZdFehwBuxb4S75VkhaelTeJvUcAxFzl
         JkMGnbOkvsYgyCS1KyBnxRNyVPuqGWoSB8gN8c8/uZ1XJME/epTrVWI2JvWJbL2CPICU
         8NIJx2FI5XywLcjkGJyt4eZs15swf/t5z4eVfiPiZf6pOHlwBtWL5JgnnAX9iuU5qIRl
         QcL+s1LMBLWmTfh8UhnQHixA1B1XjESYESUbSgoUgMBuboi+5RlOlDkWgt/xzPml5g49
         yQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shwwZFvYNRcVxLkvBAhBQlcpsvVebNeekhejxdi6EsE=;
        b=PMeD9UViYXoWFF7akkrl3QnkMymxXbCUqzZZ4MJR2uxQ5L+Zc9VUsXDrfW7CSAx45A
         cccR2sV+QJNP7Y1cbKjQ/Z0Cz+ADmsMWsL4XMA1A0yqFH+CTZ7xQ/BawSnbVFjku40mP
         RxOOeMH/UnJOcQKaF8a12Qsg/Wzh2RtAqCTW3nOARVUj2w0GiVdhJDDRhBof14XE4PQB
         oHQe5McKXkJUNBv04h63fHniUL+5JzpxMjxIpFQjjSO7V32mep9KOKeOwRkNIMLpDAzf
         ItTdjQPlrmfEpknJGevvRysLqsav5C7MuCf0Iprwx74moqxM2hE/pf2z3DaJ+EUwIMjm
         uwcw==
X-Gm-Message-State: AFqh2kpAHdZHEPPfa5Pq/zd8kUilKuWRgu+Ocy78Bmy3NzPPX0Qhn6qs
        rUnR8qZhYppgpv4k8xzZCO0=
X-Google-Smtp-Source: AMrXdXvvyrkpgMQSk22uYI+6Od/kQXEZ0HFqMxvJEtIYNBwNcfO8MwZfE61KrnBhilbwiSvYxJXf5g==
X-Received: by 2002:a17:903:264b:b0:185:441e:90b4 with SMTP id je11-20020a170903264b00b00185441e90b4mr4953030plb.26.1671711104801;
        Thu, 22 Dec 2022 04:11:44 -0800 (PST)
Received: from MBP (ec2-18-117-95-84.us-east-2.compute.amazonaws.com. [18.117.95.84])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902ec8200b0017f72a430adsm418439plg.71.2022.12.22.04.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 04:11:44 -0800 (PST)
References: <20221115140233.21981-1-schspa@gmail.com>
 <m2zgc2vzwx.fsf@gmail.com> <Y5a3rAm21mCf2xrG@bombadil.infradead.org>
 <m2bko8c0yh.fsf@gmail.com> <m2pmcoag55.fsf@gmail.com>
 <Y5kE2eAa8EZUxx5b@bombadil.infradead.org>
 <Y5oqxh2jnarlEKNG@bombadil.infradead.org> <m2o7s55gan.fsf@gmail.com>
 <m2ili43s2v.fsf@gmail.com> <Y6P2MUcTGU9LIrDg@bombadil.infradead.org>
 <m235983p58.fsf@gmail.com> <m2bknv3b1a.fsf@gmail.com>
User-agent: mu4e 1.8.10; emacs 29.0.60
From:   Schspa Shi <schspa@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org,
        syzbot+10d19d528d9755d9af22@syzkaller.appspotmail.com,
        syzbot+70d5d5d83d03db2c813d@syzkaller.appspotmail.com,
        syzbot+83cb0411d0fcf0a30fc1@syzkaller.appspotmail.com
Subject: Re: [PATCH] umh: fix UAF when the process is being killed
Date:   Thu, 22 Dec 2022 20:09:38 +0800
In-reply-to: <m2bknv3b1a.fsf@gmail.com>
Message-ID: <m21qor3afi.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Attaching the full test program in case anyone wants to add some
comments.

/*
 * complete-uaf.c --- UAF test for complete
 *
 * Copyright (C) 2022, Schspa Shi, all rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#define pr_fmt(fmt) "complete-uaf-test:" fmt

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/errno.h>
#include <linux/proc_fs.h>
#include <linux/seq_file.h>
#include <linux/spinlock.h>
#include <linux/random.h>
#include <linux/delay.h>
#include <linux/atomic.h>
#include <linux/kthread.h>
#include <linux/slab.h>
#include <linux/completion.h>

struct test_work {
	struct completion *complete;
	struct pid *caller_pid;
	unsigned long delay_time;
	int id;
};

#define MAX_WAIT_TIMEOUT (50)

static atomic_t test_instance_count;

static bool use_fix = false;
module_param(use_fix, bool, 0444);
MODULE_PARM_DESC(use_fix, "Use fix");

static void mdelay_with_yield(unsigned long timeout_ms)
{
	unsigned long start = jiffies;

	do {
		yield();
	} while (jiffies_to_msecs(jiffies - start) < timeout_ms);

	return;
}

static void test_work_complete(struct test_work *workdata)
{
	struct completion *comp = xchg(&workdata->complete, NULL);

	/* Sleep for 1 millisecond to simulate preemption */
	msleep(100);
	if (comp)
		complete(comp);

	kfree(workdata);
}

static int completion_thread(void *data)
{
	struct test_work *workdata = data;

	mdelay_with_yield(workdata->delay_time);

	/* Simulate an external kill signal */
	kill_pid(workdata->caller_pid, SIGKILL, 1);

	test_work_complete(workdata);

	return 0;
}

static int complete_uaf_test_proc_show(struct seq_file *m, void *v)
{
	struct task_struct *thread;
	DECLARE_COMPLETION_ONSTACK(done);
	struct test_work *workdata;
	int retval;
	int id;

	workdata = kzalloc(sizeof(*workdata), GFP_KERNEL);
        if (!workdata) {
		return -ENOMEM;
	}

	id = atomic_inc_return(&test_instance_count);

	workdata->complete = &done;
	workdata->id = id;
	workdata->delay_time = get_random_u32() % (MAX_WAIT_TIMEOUT);
	workdata->caller_pid = get_pid(task_tgid(current));

	thread = kthread_run(completion_thread, workdata,
			"complete_uaf_test_kthread-%d", workdata->id);
	if (IS_ERR(thread)) {
		seq_printf(m, "kthread create failed with status %ld",
			PTR_ERR(thread));
		kfree(workdata);
		return PTR_ERR(thread);
	}

	retval = wait_for_completion_killable(&done);
	if (retval) {
		if (xchg(&workdata->complete, NULL))
			goto exit;

		if (use_fix) {
			wait_for_completion(&done);
		}
	}

	seq_printf(m, "test %d success\n", id);
exit:
	return 0;
}

static int __init complete_uaf_test_init(void)
{
	proc_create_single("complete_uaf_test", 0, NULL,
			complete_uaf_test_proc_show);

	return 0;
}

module_init(complete_uaf_test_init);
MODULE_AUTHOR("Schspa <schspa@gmail.com>");
MODULE_LICENSE("GPL v2");


-- 
BRs
Schspa Shi
