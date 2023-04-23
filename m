Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71DA6EC05C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjDWOXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjDWOXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:23:18 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B2B1993
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:23:17 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-52091c58109so3447402a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682259797; x=1684851797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Rj1yv7n1B1sfzk8KaoZMeSwqJKYV0wulVNjWVVOWYU=;
        b=hBJy+FtMoEAZo8zMCKag/dNCLP8CU5676EocoCGjEyV4px+WfXVLKIWilDEicgEpl8
         5kyyFiLNNMpUhkUJqFrhcFBipodUiVkekklnKgDRgSbio5vYWqJoWn/Mfz04rrH91Ey4
         r3JF9qPJossUsR+k1QtgpOn6TNQsqofRDeWUgbHie2Nhe4GN8S4hBwppKsNoowLGQPk4
         9NxkvbP5vUEvH7mbxEEceb6SU6xR5qETcYFudISWyIs4lcULVdyg8je0QJHQ/mdjrHI6
         qUs/79Wn8DrKlCkrE6BOw+GcB91kWcyrumGbktTI4lS2vbbQ4lPAeiFbdB/pI1WzLB3f
         6RtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682259797; x=1684851797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Rj1yv7n1B1sfzk8KaoZMeSwqJKYV0wulVNjWVVOWYU=;
        b=PJpQNokiVMo5Osxe6xJ5436RH3Feiylh1OkRIly/G+LOZ0FlycPONHVh1H6ur5eR1D
         CzqnXRYwbpJmM0YqFkBUdSCJwyYozeJb7jpQ+50L1Umf79DcnYXjY9/MfVztuFoKG7Ln
         EWgRwIo2mBtnsTAb3e8geK0ppsB7n3n6tQlZm6E1qxcgJSEgngXSjrzfcs6tUi6YKbWQ
         7cEpCmuy0Hi5gi49Bqc2sQLp4jQDuSX4O9YrBWrpHrF4pUs5AkA4AoIJt7pQXxgxkPr9
         FBsXvW410Y5rBj0oFUgL/o+yvDhErXUgzjxYPkZIhYinAH96iToRAt1429Wi3fmv2V6O
         kZmg==
X-Gm-Message-State: AAQBX9cy3oBw0UJRo/hqQOdjZMTn6kqQUyvjVFoX9YqfmqIi81pxI4L2
        smAQgZ/PUXkbgNotu6XcFJ0=
X-Google-Smtp-Source: AKy350bygPf9nrClagPjXCEBlejtnyuOj9PM7DG+QbqlLZLnO+AfkXGI7IQ6bV9pB6zHRW5snALPQA==
X-Received: by 2002:a17:902:ec84:b0:1a6:b012:afb with SMTP id x4-20020a170902ec8400b001a6b0120afbmr13547794plg.48.1682259796988;
        Sun, 23 Apr 2023 07:23:16 -0700 (PDT)
Received: from pop-os.localdomain ([103.251.210.208])
        by smtp.gmail.com with ESMTPSA id ik28-20020a170902ab1c00b001a6d18cb338sm5188532plb.2.2023.04.23.07.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 07:23:16 -0700 (PDT)
Date:   Sun, 23 Apr 2023 19:53:12 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] staging: rtl8192e: Remove unused sens and max_sens
 from r8192_priv struct
Message-ID: <33ed0da2aa36058f7e88fc4e509ebf85d78cbf8b.1682257566.git.yogi.kernel@gmail.com>
References: <cover.1682257566.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1682257566.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'sens' and 'max_sens' fields in the 'r8192_priv' structure are no
longer used by the driver. This commit removes these fields.

Suggested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---

Changes in v4:
    1. Split changes into patch series per feedback from
       gregkh@linuxfoundation.org

Changes in v3:
    -- None

Changes in v2:
    -- None

Changes in v1:
    -- None
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 08145e1f814c..ec9e454299a8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -270,8 +270,6 @@ struct r8192_priv {
 	short	promisc;
 
 	short	chan;
-	short	sens;
-	short	max_sens;
 	bool ps_force;
 
 	u32 irq_mask[2];
-- 
2.34.1

