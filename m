Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8431D659476
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 04:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiL3Dqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 22:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiL3Dql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 22:46:41 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A762315F3F;
        Thu, 29 Dec 2022 19:46:40 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso19821847pjb.1;
        Thu, 29 Dec 2022 19:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dcbgyVzX1AakNIfgCknQO6z8uXwqIr1k4tKwKLcxd00=;
        b=pklG5H0ujIMSGHPrz5f392GnfLVvCavb7UnXgXbwxCvoCoRB9M7LQ+ES2Uq5cO40QW
         zxL49m/i9o26O22wk3cLsKrZtQEBGbR4AOeHk+rNMlSJscboK0iJWsV2akNj/1K75eBP
         AJYtLFvQusmaSaVMrKPu7x6GxpGwiE4F5zDwakOE5z+Vc2E6hJNcNsMOw4zF7qjtRoTe
         juf7/PEgy0OWcCbJrZKT9MRiJh+SwUtiu8dzNC51PvCQlB4ihqxzHkzb68hZtB+8d0oD
         lvRT4cK2RbmhtcH58dQrt8WFWujJV1KwwhzYdy3r6qoh7Tsf9dvVogJ3ANaDXQK/zFbJ
         f+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcbgyVzX1AakNIfgCknQO6z8uXwqIr1k4tKwKLcxd00=;
        b=qbkWACpG3aNCTZuxI1bvavv16qoPYU/1odC/Qk6lDoXd0CMa3jAQp7l9t6ANoI4PKC
         qZeobii+AP4Hk5NsPkazcbt6lTH6Uqkd1zopA3J9OIMxI4SG6AvZHYZShTcYX9/JSomk
         lCemvnTtcY+HQ7Y3mTHiyUEMVS6lOFqGStOouFBGTjSf4afGqp3hRdpDgqxF7sjy3OhQ
         5E4kV69bC1JZJ+IhtldFdD5xSaUOwSdRlIYsqXbeuDR30xuO135znnih7GIIgU5/OeHS
         hObmS4R2BWWN2+uL2gcZa1kpLZIAVP1EyafoQMrHYN0JpR0FVHI2eeqpWspsrTXYLF1f
         MZxw==
X-Gm-Message-State: AFqh2ko4ZDJAp6D8ZAGEE/q0Scy04MLeCYWXSERngmuV0N/W0/1fBomw
        WG/YrRRFRAjPJbwDnxo13No=
X-Google-Smtp-Source: AMrXdXt7HWhsGwuJumx9XdAE72UEwfwkFyMbG+KQoBy7NyVAfV4fylX7Prt/foKQDOE6URRX3FUMaw==
X-Received: by 2002:a05:6a21:3d13:b0:ae:7f1d:1912 with SMTP id bi19-20020a056a213d1300b000ae7f1d1912mr43866177pzc.38.1672372000164;
        Thu, 29 Dec 2022 19:46:40 -0800 (PST)
Received: from xiaxiShen-ThinkPad.. (c-65-50-153-147.hs.gigamonster.net. [65.50.153.147])
        by smtp.gmail.com with ESMTPSA id r25-20020aa79639000000b00574ab0e053bsm5777161pfg.187.2022.12.29.19.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 19:46:39 -0800 (PST)
From:   XiaxiShen <shenxiaxi26@gmail.com>
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        XiaxiShen <shenxiaxi26@gmail.com>
Subject: [PATCH] pr_info("I changed uvcvideo driver in the Linux Kernel\n");
Date:   Thu, 29 Dec 2022 19:46:34 -0800
Message-Id: <20221230034634.7809-1-shenxiaxi26@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: XiaxiShen <shenxiaxi26@gmail.com>
---
 drivers/media/usb/uvc/uvc_driver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index e4bcb5011360..60778a5a2b4e 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2082,6 +2082,8 @@ static int uvc_probe(struct usb_interface *intf,
 		(const struct uvc_device_info *)id->driver_info;
 	int function;
 	int ret;
+	pr_info("I changed uvcvideo driver in the Linux Kernel\n");
+
 
 	/* Allocate memory for the device and initialize it. */
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-- 
2.34.1

