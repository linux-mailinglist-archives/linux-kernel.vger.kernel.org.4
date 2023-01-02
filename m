Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2A865B303
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 14:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjABN7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 08:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbjABN7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 08:59:10 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14602655D
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 05:59:04 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id u2so6010293qvo.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 05:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GCk78n4Uus8aW/x1lvt8d+3ggwnZ1YPtWJtydirpuFc=;
        b=hcGrJ3ovPUJBVD4piuKPDPb0e73N2Lmdw0dVdyQXEAnqzAHlBaZUENmLhX4tKRdLLc
         ozi97+i7MIh51HE+BdeAdtSDdc5qY9BVK2t9WIBjlJ86abtanZ6pXSKXi10SWq5ryP8h
         Izj2uOhAE4ZS47u95JL204yRMc2W7pmwRSeIVdcyRkUydAJCo+rvbz9QSOBLmATgnnhI
         uzshgXpF4LTWy1ogAPINJPLKDGr5deWjEyuxEY/mhsSXPNnyTc+hrf170UeKxHajsdDF
         EJkpQAbVD8r5JkYXyQNt+bcOEde/xCFbcthYGRbWIidI5mxfjz22hiHrVLpkVQ0fGZG5
         EbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCk78n4Uus8aW/x1lvt8d+3ggwnZ1YPtWJtydirpuFc=;
        b=EiU1uhItPt5o+9J98JTKNa0JHFXIIj9qvafP804rwkhBSAEEj6h3crPTun0X6v4Wo+
         zAG8Agt0l4IRDfVr2vljtfjKqT+6B4Kmir6VjX2hI9LwWD/uxeynsfyqBnxo0tpBpt4v
         cOaPvANgRjnfNkkvlEihAeUIsodsn+c0iCJL+BLOWVbP9cxA99c8icSlsC6MDeb/YNQ6
         HmuaN95cFlR7oyy+2pYREMX9tJdSMjbRRDJnmnY8/+/qdzjKuEj/tfuWsTPwxBwO9xCK
         UkgudV/zeU3zgUc7/EvuV6ATL9qzc/4PdnYxJfTO9kxWSG5CE3DyByKaK2mw+6PncvIZ
         wLlA==
X-Gm-Message-State: AFqh2kpkRg2B2ttUcIdf1nphS9vKI/tGkySbE3yZxSjz1J1uNPGmvyyP
        HQ42fHfALrgFtzdIFs0nIVV6Ui4CQv/qgg==
X-Google-Smtp-Source: AMrXdXv8PYSBg/SBKXFElaKD2vGiViX728JS+mZyWvkaZ/TUBcjg/6S0ARzGlQ4xHdQPa2ji9HRSQQ==
X-Received: by 2002:a05:6214:c6c:b0:51e:4235:7ce6 with SMTP id t12-20020a0562140c6c00b0051e42357ce6mr76474398qvj.46.1672667944021;
        Mon, 02 Jan 2023 05:59:04 -0800 (PST)
Received: from Slackware.localdomain ([154.16.192.76])
        by smtp.gmail.com with ESMTPSA id m4-20020a05620a290400b006fb8239db65sm20591477qkp.43.2023.01.02.05.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 05:59:03 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     unixbhaskar@gmail.com, linux-kernel@vger.kernel.org
Cc:     paulmck@kernel.org
Subject: [PATCH] tools: rcu: Added check for argument and usage function
Date:   Mon,  2 Jan 2023 19:21:57 +0530
Message-Id: <20230102135155.20326-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inducted some argument check as well put the important information in a
function for better usecase.

cc: paulmck@kernel.org

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
  Paul, pardon my brevity. Chances might be there that I might have
  misunderstood the requirement.
 tools/rcu/extract-stall.sh | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/rcu/extract-stall.sh b/tools/rcu/extract-stall.sh
index e565697c9f90..d71617d0e565 100644
--- a/tools/rcu/extract-stall.sh
+++ b/tools/rcu/extract-stall.sh
@@ -1,11 +1,27 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0+
-#
-# Extract any RCU CPU stall warnings present in specified file.
-# Filter out clocksource lines.  Note that preceding-lines excludes the
-# initial line of the stall warning but trailing-lines includes it.
-#
-# Usage: extract-stall.sh dmesg-file [ preceding-lines [ trailing-lines ] ]
+
+# Terminate the script, if the argument file is missing
+
+if [[ $# -eq 0 ]];then
+
+	echo You are suppose to pass the dmesg file as an argument.
+	usage
+	exit 1
+fi
+
+# This is an usage function to spit out information about properly use this
+# script
+
+usage() {
+
+      echo Extract any RCU CPU stall warnings present in specified file.
+      echo Filter out clocksource lines.  Note that preceding-lines excludes
+      echo The initial line of the stall warning but trailing-lines includes it.
+
+      echo $0 dmesg-file [ preceding-lines [ trailing-lines  ]  ]
+
+}

 echo $1
 preceding_lines="${2-3}"
--
2.38.1

