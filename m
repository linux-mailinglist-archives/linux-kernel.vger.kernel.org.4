Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A0462EC4B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 04:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbiKRDJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 22:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbiKRDJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 22:09:43 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735BB8D499
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 19:09:38 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b21so3417083plc.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 19:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=microgate-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QvQYYn6CnSvHRnlZDbLhcsyyvXrpp3K5Tbix7T4+wJw=;
        b=qitBcLdK1p9dZoDC6VQxVcnthRbkU4g+rdNME9oYF656ZCpfJuP4Ly+bpERRSUKcZU
         UEsr9wRFrRkUCbLuN7VyS0D3uRNWI/M7XUBgmxY0ybV3WqKDDYEK4b6doMYbucy6guKN
         xMM9ypC00v9fm8eM1OcZReXihHVuXYzeG6fhvlXQAdvl1pWWjaPKimXjtITKwmFcUlwk
         TOmbpDHCb4ITeCvbU63+mis8ZytOYqELLJm9BIdd2gWcFWjAMnGCkVaC/OipsGdE4olq
         Hu5bFXqguoBdwVXuisAOdqEVc0u58VexzRvSdMUMhry7VBYtHEkyAu7bcVu4OZ37PKqC
         s+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QvQYYn6CnSvHRnlZDbLhcsyyvXrpp3K5Tbix7T4+wJw=;
        b=f+o7vMduqmBs9gzxZN2XS7xZGl3O35BONzFUJTnF8bwW4BrvDqaQNO19V8EB7j1C5+
         gV4VGvaZ439Pe9xWVuQICCcUwEXKRH4cG9535imA4HKUfOfPDYTwqiVjr/uQYesQL+vI
         pZNtZCirb2DKqx0cJR7QD9QwZrnoo6XQw4nn01KUgN9kLB0BE5+jFfLPoUKyTFIkgMi/
         A4nSmxfB3gbCebD8xuIt1VeAWqGD/n6x+8ffknXsLMiODQqtWsNsFVAifRx07b9mfFnV
         z6PPvB0viBFqp6fB0ymzwEcD3cyNwjdzUCvtAO+8z7vNfDezvv07tgkbptfeFhyZqeZa
         GI9A==
X-Gm-Message-State: ANoB5pk6Rpi7Ji07cs/AK8KkHBBvtRbISVTqljPAp3D3HLdpuYP0T0tU
        yqJvhy8cYF23uAWoe/t3LZU4dw==
X-Google-Smtp-Source: AA0mqf53Gj6BQCHQVg/+19JpxIJvV0fRIq7Bm1eiQnv/Vmo/8Nuiqa7unOQJuW+91FUl5tYMTySOqQ==
X-Received: by 2002:a17:903:3304:b0:187:2dc3:27c with SMTP id jk4-20020a170903330400b001872dc3027cmr5436943plb.148.1668740977955;
        Thu, 17 Nov 2022 19:09:37 -0800 (PST)
Received: from [192.168.1.86] (c-208-53-111-167.customer.broadstripe.net. [208.53.111.167])
        by smtp.gmail.com with ESMTPSA id ix9-20020a170902f80900b001782a0d3eeasm2190688plb.115.2022.11.17.19.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 19:09:37 -0800 (PST)
Message-ID: <dc4d3cba-0562-8a94-12f0-5c110bf6b10b@microgate.com>
Date:   Thu, 17 Nov 2022 19:09:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: [PATCH v2] tty:synclink_gt unwind actions in error path
Content-Language: en-US
To:     Zhengchao Shao <shaozhengchao@huawei.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     akpm@linux-foundation.org, weiyongjun1@huawei.com,
        yuehaibing@huawei.com
References: <20221114010734.314910-1-shaozhengchao@huawei.com>
From:   Paul Fulghum <paulkf@microgate.com>
In-Reply-To: <20221114010734.314910-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


synclink_gt.c:hdlcdev_open() does not properly
unwind actions in error path.

Unwound action 1: try_module_get(THIS_MODULE)

Change d4c63b7c7450 added try_module_get()/module_put()
to stop WARN_ON if modprobe -r removes synclink_gt while net
device is open. This is same as drivers/wan/farsync.c.
Other generic HDLC hardware drivers do not do this.
On unload, synclink_gt calls
drivers/wan/hdlc.c:unregister_hdlc_device()
which calls down to
net/sched/sch_generic.c:dev_shutdown() triggering
WARN_ON(timer_pending(&dev->watchdog_timer));
if net device is open.

try_module_get/module_put, a disfavored pattern, is replaced
by a call to dev_close() for open net device
before calling unregister_hdlc_device() when driver unloads.
This pevents WARN_ON.

Unwound action 2: drivers/wan/hdlc.c:hdlc_open()

This is moved to after driver level init/checks with proper
rollback of previous actions. This is a more sensible
ordering as the most common error paths are at the driver level
and the driver level rollbacks require less processing than
hdlc_open()/hdlc_close().

Fixes: d4c63b7c7450 ("synclink_gt fix module reference")
Fixes: 705b6c7b34f2 ("[PATCH] new driver synclink_gt")
Suggested-by: Zhengchao Shao <shaozhengchao@huawei.com>
Tested-by: Paul Fulghum <paulkf@microgate.com>
Signed-off-by: Paul Fulghum <paulkf@microgate.com>
---
V1 -> V2: improve description, add dev_close call

 drivers/tty/synclink_gt.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 25e9befdda3a..5921703f7228 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -70,6 +70,7 @@
 #include <linux/bitops.h>
 #include <linux/workqueue.h>
 #include <linux/hdlc.h>
+#include <linux/inetdevice.h>
 #include <linux/synclink.h>
 
 #include <asm/io.h>
@@ -1433,16 +1434,8 @@ static int hdlcdev_open(struct net_device *dev)
 	int rc;
 	unsigned long flags;
 
-	if (!try_module_get(THIS_MODULE))
-		return -EBUSY;
-
 	DBGINFO(("%s hdlcdev_open\n", dev->name));
 
-	/* generic HDLC layer open processing */
-	rc = hdlc_open(dev);
-	if (rc)
-		return rc;
-
 	/* arbitrate between network and tty opens */
 	spin_lock_irqsave(&info->netlock, flags);
 	if (info->port.count != 0 || info->netcount != 0) {
@@ -1461,6 +1454,16 @@ static int hdlcdev_open(struct net_device *dev)
 		return rc;
 	}
 
+	/* generic HDLC layer open processing */
+	rc = hdlc_open(dev);
+	if (rc) {
+		shutdown(info);
+		spin_lock_irqsave(&info->netlock, flags);
+		info->netcount = 0;
+		spin_unlock_irqrestore(&info->netlock, flags);
+		return rc;
+	}
+
 	/* assert RTS and DTR, apply hardware settings */
 	info->signals |= SerialSignal_RTS | SerialSignal_DTR;
 	program_hw(info);
@@ -1506,7 +1509,6 @@ static int hdlcdev_close(struct net_device *dev)
 	info->netcount=0;
 	spin_unlock_irqrestore(&info->netlock, flags);
 
-	module_put(THIS_MODULE);
 	return 0;
 }
 
@@ -1742,6 +1744,11 @@ static void hdlcdev_exit(struct slgt_info *info)
 {
 	if (!info->netdev)
 		return;
+	if (info->netcount) {
+		rtnl_lock();
+		dev_close(info->netdev);
+		rtnl_unlock();
+	}
 	unregister_hdlc_device(info->netdev);
 	free_netdev(info->netdev);
 	info->netdev = NULL;
-- 
2.34.1

