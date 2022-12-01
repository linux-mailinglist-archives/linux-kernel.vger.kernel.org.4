Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D812463E962
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 06:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLAFjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 00:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiLAFi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 00:38:59 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0A45AE3C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 21:38:57 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id w37so752706pga.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 21:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oregonstate-edu.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzXcxEhY206rBEzs9pZWVugpUSKJxpd3SA2u/++FFEo=;
        b=nTBGN+TxqobVpNVk5u779lh6sCrYGmQUfTv23baPBaJBsfbFVn2yeMJdZ0OgMVb7cf
         KMq79c/+6kZB/HlT6g+mWoOFQNKAJLxeEbZavIbdNqOd8Zf1b/zTxMf797jvcAhMeaA2
         jfsW9tlfn/m/e5K+1nHHuotMBnA8ibMaEBiiEG6j6u5yuqPazkWLsveIEA3D5r3JAaTj
         T+UZNnfYC6LFPg7nYQvRfeEPvt0Nq1AwI86JWuK2CzMllD/4UqDVsfrk9kMLhe/hf68x
         btbClZmceoUpj1y7TXDYCqMYRE7CkbFQFg5v5T7mdMStAQVPexmBttElEZJChqmxaLBw
         5KNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzXcxEhY206rBEzs9pZWVugpUSKJxpd3SA2u/++FFEo=;
        b=SoPPieObTeoK+ei2DBkz2J2MCkwrK9wEzWMzarldC3QI6uKgGxL0CdHDxVO0r1UdbX
         HSsqjwdMshCVGaS3SdowJoIv0rfCpCC334cssvoPdKscNcxIDwqtRF64K4F8ahuRZWoQ
         D+ossRjz7Al4ejjGzXpuVS8sdPYd6VfGNWXCh1YuX0FlCzmOro82Q7+/+/qzqgFEY68b
         kK8liwBO9gtSJ97BheiqvH/qAnguA2q95unylLyw4OGl15N/UHOZ4H14ULfeEwEoQdHJ
         aDH1KPKCPqmtUac6amtognSPPyqP1tJWwWvYxd7/PnVngXaENxybjCIY57AlovGwOdYn
         Qy5A==
X-Gm-Message-State: ANoB5pkpuolipvtDs8nOthjzMCe8jbg4isl7ttuQ2BhyTmRwFsPbvBmQ
        KEwZIVtnQeQVpP66KDQYxYXq6c1icS2Bmg8APLE=
X-Google-Smtp-Source: AA0mqf5wrrGDIjuBXPbh2ixyzd37b5q+71oNaWfElX1EHUxAIGdrdZnxc5DJjW/ALu85TqfqVWbyUw==
X-Received: by 2002:a63:2043:0:b0:477:5e25:4ca8 with SMTP id r3-20020a632043000000b004775e254ca8mr42709541pgm.511.1669873137434;
        Wed, 30 Nov 2022 21:38:57 -0800 (PST)
Received: from ubu ([76.27.231.73])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902dac400b00189651e5c26sm2514657plx.236.2022.11.30.21.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 21:38:57 -0800 (PST)
From:   Jack Schofield <schofija@oregonstate.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Jack Schofield <schofija@oregonstate.edu>
Subject: [PATCH 2/3] staging: greybus: loopback_test: Remove void function return statement
Date:   Wed, 30 Nov 2022 21:38:51 -0800
Message-Id: <5d465d56a6e3de2cb9d2f34377cbb82678cc67b1.1669872193.git.schofija@oregonstate.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669872193.git.schofija@oregonstate.edu>
References: <cover.1669872193.git.schofija@oregonstate.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Void function return statement is not useful in this case. Issue
reported by checkpatch.

Signed-off-by: Jack Schofield <schofija@oregonstate.edu>
---
 drivers/staging/greybus/tools/loopback_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/greybus/tools/loopback_test.c b/drivers/staging/greybus/tools/loopback_test.c
index 242138c4f6cf..7c1697304ab4 100644
--- a/drivers/staging/greybus/tools/loopback_test.c
+++ b/drivers/staging/greybus/tools/loopback_test.c
@@ -862,7 +862,6 @@ void loopback_run(struct loopback_test *t)
 
 err:
 	printf("Error running test\n");
-	return;
 }
 
 static int sanity_check(struct loopback_test *t)
-- 
2.25.1

