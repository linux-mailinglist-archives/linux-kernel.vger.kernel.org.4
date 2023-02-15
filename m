Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4100697B11
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjBOLro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjBOLrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:47:43 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9193669D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:47:37 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id k16so15981129ejv.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676461656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GHrA9e3gwy1oaxI6a54qm8/8P6kdz6l+7yWvSQcQDZU=;
        b=BspNH+cyetpUGliVhXLo+JZiUdBN8mvj1cMhgeIcGc2uM3fXCxjQqF4zN7UYvpcJ5X
         +zITlYD+RfOC2GxUU+YOEe29iivKNFsZWx3gpmFNfqWj3ny85Odptmc3DY8b24ZdFqNf
         w1Pu7fl1lFwgKS90qZq4W9C00qPN9JWqcFLhr6Ax8QTYJd96+GTBb6OQAT7lO0WkqPpX
         Mq59+mn1WbN55CANJXNVgwb8rh3WSuk4Bves26P+bbmwPL3eJctuTuPRjo3j3cI03jyh
         cUbNXzvG4nsVx61iMqHaZzXVY6k0YLlV5iRYQDQPJzqUr8bAcDtTcZxZEbUVz0IXTuSh
         GJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676461656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHrA9e3gwy1oaxI6a54qm8/8P6kdz6l+7yWvSQcQDZU=;
        b=34vcbU6F6m92VHJnM0uQqMTfP3riuiKHTQ+d1PNvHW3FVqQcVsRei6swQbHSxt+zOV
         ZVhiufUt6B8BEtoanOJZ8bdkC/kp3OhO4uQphNBZXk18XKOwCpGFjyJMI61J+iQtsdqr
         kIxM957CcKtwqnSPr5ibUpJdwxHQlEQ/d0S/7uBez9XESCBLZvy9uo6cMGG6Chvbhx31
         cPQ5Btp+Ua5SvVziJ7AnpO36yHZkGP1dJL5BqeetEZI4l4/H9Quz4QhOrBvfzz3EU2uY
         6WZUU+gxvTpcFMBpb4CXlGnZhcCxzUG4+M+oKAopT47xj416Hi3ERkcWO3CUqk1XmGP0
         Tvdw==
X-Gm-Message-State: AO0yUKXHbv8rW1O8psS+Llapcx0IXL9wJd2uGQ7IviYi3nHnW9DHYUoQ
        bQZjRObmhK5rA/gCfivH23g=
X-Google-Smtp-Source: AK7set8hvJKVD1NmnqmURX+8ZT25FIOOW1YZBQO2LpRgsntYlFIQQ6B7tyCaxlHaNsMUpgTTGl/mkA==
X-Received: by 2002:a17:906:1de:b0:89a:8238:3323 with SMTP id 30-20020a17090601de00b0089a82383323mr2091025ejj.6.1676461656250;
        Wed, 15 Feb 2023 03:47:36 -0800 (PST)
Received: from mineorpe-virtual-machine.localdomain ([37.252.81.68])
        by smtp.gmail.com with ESMTPSA id n4-20020a170906088400b008b126051fbdsm2748787eje.47.2023.02.15.03.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 03:47:35 -0800 (PST)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     dan.j.williams@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, maddy@in.ibm.com,
        peterz@infradead.org, kjain@linux.ibm.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: [PATCH] Fix 'unexpected indentation' during documentation compilation
Date:   Wed, 15 Feb 2023 14:47:17 +0300
Message-Id: <20230215114717.10194-1-ivan.orlov0322@gmail.com>
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

Reformat the 'sys-fs-nvdimm' ABI documentation file to make it
correspond the right format. This patch will fix annoying
'WARNING: Unexpected indentation' message during documentation
compilation process.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-nvdimm | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-nvdimm b/Documentation/ABI/testing/sysfs-bus-nvdimm
index de8c5a59c77f..c50a075ae1d8 100644
--- a/Documentation/ABI/testing/sysfs-bus-nvdimm
+++ b/Documentation/ABI/testing/sysfs-bus-nvdimm
@@ -18,9 +18,11 @@ Description:	(RO) Attribute group to describe the magic bits
 		Each attribute under this group defines a bit range of the
 		perf_event_attr.config. Supported attribute is listed
 		below::
-		  event  = "config:0-4"  - event ID
+
+			event  = "config:0-4"  - event ID
 
 		For example::
+
 			ctl_res_cnt = "event=0x1"
 
 What:           /sys/bus/event_source/devices/nmemX/events
-- 
2.34.1

