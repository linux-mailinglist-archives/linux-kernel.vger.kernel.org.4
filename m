Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48565EC4F9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiI0Nxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiI0Nxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:53:33 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183C212E40E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1664286806;
        bh=wOQSCm79AChosleiwmfsR5IN1ZodaJieOpEm/KfINVE=;
        h=From:To:Cc:Subject:Date;
        b=Mtqnpz5vNXxU/h0cal6xO4zVkLyQesV+e5iJfAKZZa4GU9lvILQ4aBXW70PsOyhav
         6OSJJs79Uo9Z3b+eqUJGK8uyKGK23AXRbfN/99l7AnwzW8PgREWsPMx3zr6iQDYY6m
         GSZMh7lO+sRagYFqYagbXyQ1mnPhO/8kAsVf5pnI=
Received: from localhost.localdomain ([111.199.187.40])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id D0F35288; Tue, 27 Sep 2022 21:52:15 +0800
X-QQ-mid: xmsmtpt1664286735ti9aw2fou
Message-ID: <tencent_BAA30488EB06A842C1595097BA2A7FAF9908@qq.com>
X-QQ-XMAILINFO: NKv2G1wnhDBnrr4E/kVfuAaW0EF+dO6VIZgsqtYyK/87TCmjT9CP5srANxSFY9
         j/hcKrE2+e9etoGo+3zm0I4Sl203WVpcvQ8f1JH8Vx6dot5H/R/7aiVxyIMNsftO336neivpG/PL
         9YsClPsZYJNpBkJrcVl/7TLq0o9Kbl6GhypqGmrWiuUN7DMzb1HTehlT6k0lq+3YSbQK5ItmCJZI
         EQG8DeMtb8pBV1FiU33nXSOMrmJmR2UK3AOU26Yh6pRAdjibczIoGEZOCWMczsfCO90usAt/W1J/
         u7vPTJr3F2q53v5sD0mhYHo8Of6V8b+W9abqDqYYDY1ZfqoHc2X7CJoEopmR4L0oedEMxJmzJz8b
         P6g22UeYfTunvgId+ltfMqbXcBs04qvbi6ty5L7aD3bgBv4OlwUcDudLv6pFONR+o0CFacuZGIq4
         qVrJLNCMJi+qmOMYDv1e/yI/nPFprhrPNmJVv3gbuKt1g/jD0uQqTbOxDo9HAuO5Z+WYYa1l8Yre
         jwpwlDo1B2VwSRzl+AQ/veDj+9rL+/91FBeN8JmM6WU5Qig7l+d9pgfjthrsjamIT520d7aNCc8t
         I95vYXsOZgQMxhmaT59DypThHS9wj9m5U3BhcOG6EA0ViUaIccMugj+c0aYbeE1STIq5mAsp40X1
         Lctc1FuvB3ZWaGwgugGcXLZVeEApKPKW1/Q41ytvJtaze4xMfmI5lKPFPVi03HrNCtf4W86MMQMW
         BlFllmXZKk8iHhJ8bA/kviKbwm8z9QLzoqET2U6mO+SQmBW6jCpcJfRAqSLmCDqQXI6rp7VdO5Xm
         EC05TaMm3JjXS7X/Dp1OwEqn+YSbwHq1Wrg8s+c+DNqMNawjnKG4TjgHWnsw4ZDsZ5GpzMtLfEry
         S8AH3Zec0fRy3G2lUHkkf/vfGE0z7oyCk8ykfhEZ24eLYMwgT9YPUEMJ6aEpMi5kUyNDjhqctJUx
         sWwjhi/EoLzvTLHAZndIllWBrKjKMjpE57sjub/0o4wSVovfdMhqG7lAgstqzk5D5Qjqqw5f0=
From:   Rong Tao <rtoax@foxmail.com>
To:     rostedt@goodmis.org
Cc:     Rong Tao <rtoax@foxmail.com>, Jan Kara <jack@suse.cz>,
        Heiko Carstens <hca@linux.ibm.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] samples/Kconfig: fix up indentation
Date:   Tue, 27 Sep 2022 21:52:07 +0800
X-OQ-MSGID: <20220927135208.18662-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up indentation before we get complaints from tooling.

Signed-off-by: Rong Tao <rtoax@foxmail.com>
---
 samples/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index 470ee3baf2e1..2605582d4e8f 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -23,7 +23,7 @@ config SAMPLE_TRACE_CUSTOM_EVENTS
 	  This builds the custom trace event example module.
 
 config SAMPLE_TRACE_PRINTK
-        tristate "Build trace_printk module - tests various trace_printk formats"
+	tristate "Build trace_printk module - tests various trace_printk formats"
 	depends on EVENT_TRACING && m
 	help
 	 This builds a module that calls trace_printk() and can be used to
@@ -47,7 +47,7 @@ config SAMPLE_FTRACE_DIRECT_MULTI
 	  the function addresses.
 
 config SAMPLE_TRACE_ARRAY
-        tristate "Build sample module for kernel access to Ftrace instancess"
+	tristate "Build sample module for kernel access to Ftrace instancess"
 	depends on EVENT_TRACING && m
 	help
 	 This builds a module that demonstrates the use of various APIs to
-- 
2.31.1

