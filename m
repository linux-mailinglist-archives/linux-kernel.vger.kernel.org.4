Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A714362A136
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiKOSVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiKOSVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:21:16 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED7E1740D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:21:16 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so14620410pjk.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=microgate-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pds9DPhUuKKKwvTuZXTljs6vTvJYl9KVSRCAhBrnBDU=;
        b=XSJ48EZAmzrhON5KIzsx1sxTghHHiJCpHMvI6da5Y5nBSDzfo73ldS4p01NFCUzgec
         Vvgu5l6g3X5QotkYlQnYyR4S8nBLUXi8edlKHPFwyeERuO9b8tvSJQnhUKAlK8GSuR7B
         z3vJOw05/rZXMsjPnNPX3fXmNCymQGoHGQTsZyJZzzrKyxftL0C/yJuE2UHg8c4uv27X
         eDANDl9Ibo9GBBKYU/Jtg7DMbFPzj89hlJcqHsW0WMK+wpNu6Vh8jVu525qdmSeBngma
         dzBFyQAFHggoGJzuxTEoG592l2fgy2UMhHAZrMi87CPDeM6ywa8EOgMr14jpRDtzZQPQ
         UvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pds9DPhUuKKKwvTuZXTljs6vTvJYl9KVSRCAhBrnBDU=;
        b=DrgCx1k/RtIiYCgUyytvrQRsT5A0NEwm5Gv+4yxLxtzUY4KM85/iy1DDObGeRb18TM
         2nQKD0b5GYkAPun69PkvulMkboWwLG5cAAf0R3lZuHnoww1FX7SUT6DL9EaGEV4J73tD
         CL7yPPs3SZBel/HP/PlB0R65gESpZOuVBLLWNhTGFQzjnfW6fvFq2NnvopSaoYV1FIUj
         Wy6Y9VjUJlRjTqiZ0EqOmUohHYv8TaPNYoGBuZA5KUVO0nscrebpY/aZvKrhIhW+Yhop
         /Hp+yRhpjBSUdQa9HQdHOppD5nHWs51M4hzdmEXQ/L5VWVEnjSkTvN3YUaiIBKsJOnnJ
         6zTw==
X-Gm-Message-State: ANoB5pkGrOtbiM7WSxN2re6e3+ETGd0Mij6u8R9Foo/9xnCR1uxZ82KT
        SQ379JWGn2FVD7OEkiGryOoGFA==
X-Google-Smtp-Source: AA0mqf7nJ3CZOrXfIX/cW9S5ogmqnJEH8YGX6wwT73ElcR3GtxQ942KYyw7unOjlxRnRMzb6o8QMVQ==
X-Received: by 2002:a17:90b:3c11:b0:218:8f2:5af9 with SMTP id pb17-20020a17090b3c1100b0021808f25af9mr1749128pjb.65.1668536475613;
        Tue, 15 Nov 2022 10:21:15 -0800 (PST)
Received: from [192.168.1.86] (c-208-53-111-167.customer.broadstripe.net. [208.53.111.167])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090a8b1200b0020d39ffe987sm8645310pjn.50.2022.11.15.10.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 10:21:15 -0800 (PST)
Message-ID: <2b501d50-6777-a34f-7373-6648ed418794@microgate.com>
Date:   Tue, 15 Nov 2022 10:21:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: [PATCH] tty: synclink_gt: unwind actions in error path of net device
 open
Content-Language: en-US
To:     Zhengchao Shao <shaozhengchao@huawei.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     akpm@linux-foundation.org, weiyongjun1@huawei.com,
        yuehaibing@huawei.com
References: <20221114010734.314910-1-shaozhengchao@huawei.com>
From:   Paul Fulghum <paulkf@microgate.com>
In-Reply-To: <20221114010734.314910-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hdlcdev_open() in synclink_gt.c did not fully unwind actions
in the error path. The use of try_module_get()/module_put() is 
unnecessary, potentially hazardous and is removed. The synclink_gt 
driver is already pinned any point the net device is registered, a 
requirement for calling this entry point.

The call hdlc_open() to init the generic HDLC layer is moved to
after driver level init/checks and proper rollback of previous
actions is added. This is a more sensible ordering as the
most common error paths are at the driver level and the driver
level rollbacks require less processing than
hdlc_open()/hdlc_close().

This has been tested with supported hardware.

Suggested-by: Zhengchao Shao <shaozhengchao@huawei.com>
Signed-off-by: Paul Fulghum <paulkf@microgate.com>

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 25e9befdda3a..72b76cdde534 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -1433,16 +1433,8 @@ static int hdlcdev_open(struct net_device *dev)
      int rc;
      unsigned long flags;

-    if (!try_module_get(THIS_MODULE))
-        return -EBUSY;
-
      DBGINFO(("%s hdlcdev_open\n", dev->name));

-    /* generic HDLC layer open processing */
-    rc = hdlc_open(dev);
-    if (rc)
-        return rc;
-
      /* arbitrate between network and tty opens */
      spin_lock_irqsave(&info->netlock, flags);
      if (info->port.count != 0 || info->netcount != 0) {
@@ -1461,6 +1453,16 @@ static int hdlcdev_open(struct net_device *dev)
          return rc;
      }

+    /* generic HDLC layer open processing */
+    rc = hdlc_open(dev);
+    if (rc) {
+        shutdown(info);
+        spin_lock_irqsave(&info->netlock, flags);
+        info->netcount = 0;
+        spin_unlock_irqrestore(&info->netlock, flags);
+        return rc;
+    }
+
      /* assert RTS and DTR, apply hardware settings */
      info->signals |= SerialSignal_RTS | SerialSignal_DTR;
      program_hw(info);
@@ -1506,7 +1508,6 @@ static int hdlcdev_close(struct net_device *dev)
      info->netcount=0;
      spin_unlock_irqrestore(&info->netlock, flags);

-    module_put(THIS_MODULE);
      return 0;
  }

