Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74A566D402
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbjAQCBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbjAQCBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:01:36 -0500
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D408A23315
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673920887;
        bh=I2vm4MRIsf5pQ5CahD50YQYpP2cLY65PJqtTtgqvRb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FeA1CCXXEVI9b6rS5BMxPFNnHYGbpoxlO4aCNGpyfdPOR79/Qo4/6rhrmbs9UBrEx
         2vCKQJoaecvAL8H6ln65R25tBXJAL+9FeG81pbnwj0RdL5qfd2/sFctjwt7QJGALc8
         bwoitiEUL3aG7n6yjMR+YxeAwRO8//C1qo+azADk=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszc1-0.qq.com (NewEsmtp) with SMTP
        id 5701441; Tue, 17 Jan 2023 10:01:23 +0800
X-QQ-mid: xmsmtpt1673920883t6pllruzu
Message-ID: <tencent_6238B3302FB554EC5EEF475F11470C048509@qq.com>
X-QQ-XMAILINFO: M6vtNMKjypDN/Me4jSRtt+E2tDl/QO17ApX8XtBjXWMxfLJJ06crsXIxfrtJho
         59p4yckD2w8ggrIrKRQsOWPiyLfA4bt+fSYeGGDYjYQwDUTemT4NaezGViy9U8z+7k160villQtL
         fIonhjHOdTrfSeZ43LhSQo8mi3IzIOJLkqN3i19ZvS+6sHHwGWzaTT5G68cl940WqDJ8O7Vfvd16
         XKvdARe2bWmJSg7XZerwYw5xIJE569At6VZbuGieYI9hEfGWo/HclDJNDSqKNIa7CNw0BIDhj4E+
         BnXrw+SGTLg5+0IrVEqQUXMNKRWfonEKgqE+TA6t5JVt3NMtKIr0p0lPZxjx9J4zbSy1KL5vT1cR
         Egu7kUyDfyV+5NDB6pEokqj4+bnV1EjZdCY49+V8QrNEzKfF6dmUPFXmwrG0gvzruCJJg/SWS1Sm
         02Zth8dCDdlo19RMPEM0a97l+5vX4F3g6MlwIRWWfTenJ7tmsgRKUXRPuYETAIzXHHwJ8Ry+50bh
         kua5I6gEufy3xT5Nyq51A37CG5afx0Loe3XPIlFfpwOIK98S+K4jeFKVEH4THJoLvqXAXwm+blkn
         IrvM4hPkxqpyR5n4kMcoWpB7TRVdc6dIfNLQcV27jY3xtfnZz1/KKrq0oox7USkgqgfckDj5sMke
         nV2Wg2GrvkU7kVxSsD4Mld0/lHASrYB1ZKgsVR4N5s8i/Z1WQoIBqwn+RvGV+xb9ddrq8mdjymCj
         fwjgntkwaNRXDt7lj/Z5k0tDspRKUfRHDCeFKKtEaIK5VpGoqrQcDU9HlvXfJHlE7QSGSxvtcwOC
         3Mfr2nvq4JAJzfRg2nesGR93Yq8Zg9PVTUjBvQ7A+oj7OjXBOIRKTu10IcZPYbcC/g5Zv90m+aBE
         BOWnVqmvAAB7J/B+7KN7ftuCdR/9WAcNa3zwGhA+0uGj0+mrJGMdCVKaskgDgsUPoGB939UYxOzP
         rjFDsda41PGV7hqyx+pr5IhuacOubBasFck2GCQ3X7fbTbrxYR+g==
From:   Rong Tao <rtoax@foxmail.com>
To:     42.hyeyoo@gmail.com
Cc:     akpm@linux-foundation.org, cl@linux.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
        rongtao@cestc.cn, rtoax@foxmail.com, sdf@google.com,
        vbabka@suse.cz, yhs@fb.com
Subject: Re: [PATCH] mm: Functions used internally should not be put into
Date:   Tue, 17 Jan 2023 10:01:21 +0800
X-OQ-MSGID: <20230117020121.45230-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <Y8U8OfoVwkJPdJcv@localhost>
References: <Y8U8OfoVwkJPdJcv@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, dear Hyeonggon.

If sl*b_def.h is not intended to be used externally. That is to say we should
never include sl*b_def.h in module? The following code will not compile success
since commit 40f3bf0cb04c("mm: Convert struct page to struct slab in functions
used by other subsystems"), but success in older kernel. Especially for modules
that use the kmem_cache structure, this is catastrophic.

	#include <linux/init.h>
	#include <linux/printk.h>
	#include <linux/slab.h>
	#include <linux/slab_def.h>

	static int kernel_init(void)
	{
		printk(KERN_INFO "my init.\n");
		return 0;
	}

	static void kernel_exit(void)
	{
		printk(KERN_INFO "my exit.\n");
	}

	module_init(kernel_init);
	module_exit(kernel_exit);

You are right, if sl*b_def.h is not intended to used externally, Modules that
use kmem_cache structures should not be designed from the outset to use
kmem_cache structures. Or the kernel can use this patch, and these modules can
be compiled successfully.

Best wishes.

Rong Tao
