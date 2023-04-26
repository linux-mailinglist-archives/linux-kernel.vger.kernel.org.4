Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531006EECCF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 05:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbjDZDqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 23:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbjDZDq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 23:46:27 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75D210E0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 20:46:26 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b35789313so4791917b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 20:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682480786; x=1685072786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pl2uexwNM0BU+HfXxm169Pi6HRzQaZUKu4EiKl3STu4=;
        b=gH3JjxvEiiP3G5e218HSJT8pKVy4x7+fb3qVvstO8H9LCBdc9IX+k7CASB3JjfRU7G
         uQRmRGJDi75MuqctIrZ5T2ra9T3ls+k285rqeLrPFehqw2V7q6VLROp5xBIXvXV7vvGF
         X716I6avLKsx+P2x07OtWUevjoCeuq2ACiK3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682480786; x=1685072786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pl2uexwNM0BU+HfXxm169Pi6HRzQaZUKu4EiKl3STu4=;
        b=g9keTEvkVx2AwKLdItbImQHaLMETblYqdGigtB5mvAQfWJvWKemn5qIDOguMCLvzWe
         RMlEVXqZD9Mg+fm26nyk+tkVzVmdxVLwTJAAwykttvY7fQ/8BO+FQcYkyq9CUSPLbDfo
         OC5dLU3474ci/HXID0PA2tlUbA9D4dkIogefTqTphYsOERwHrCo0H6wBpQfQFFuV5BWk
         WFiMC+v85+ue4ucychAKsd0VhmBV8B1jLXp07AYWRRVmbkGLkwPZErAiKG3GKUySScLG
         tEI6EF7W5yk/CKwWJM5GF+3+MTayVLFL+ExdZanKa/sWyV5teQaPl6ycvVYhYwad5TwT
         NAxw==
X-Gm-Message-State: AC+VfDzC5Nbrrva8ZgSfbom8QpjdfeL3vzYiz6f1TDRIDsOmzrL5BLNU
        1gPbYTRBydQyvx7bi4rHH0fOSFUvvjHJ4WPd1Wpy/4hg
X-Google-Smtp-Source: ACHHUZ5GweBYqIGF1SvFSMOnsvaVCbz6+76spCJbg7HFOGhFgHyX9ntjFt333jgD5/xyGmLWoRTDHw==
X-Received: by 2002:a05:6a00:1945:b0:640:defd:a6de with SMTP id s5-20020a056a00194500b00640defda6demr9872442pfk.5.1682480785819;
        Tue, 25 Apr 2023 20:46:25 -0700 (PDT)
Received: from datalore.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id d17-20020a056a0024d100b0063d47bfcdd5sm10110027pfv.111.2023.04.25.20.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 20:46:25 -0700 (PDT)
From:   Brandon Pollack <brpol@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     masahiroy@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
        keescook@chromium.org, wedsonaf@google.com,
        Brandon Pollack <brpol@chromium.org>
Subject: [PATCH] .gitignore: ignore smatch generated files
Date:   Wed, 26 Apr 2023 03:46:18 +0000
Message-ID: <20230426034618.374925-1-brpol@chromium.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ignore smatch generated files.

Change-Id: Id4f2d5c4ea2b4819b4634a8db6fe352b5e38e1f2

---

New to development and looking for tasks to work on to get familiar with
code, I noticed smatch generates some files at the root.  Since this
tool seems frequent for newbies like myself I thought it would be worth
getting rid of the chance of accidentally committing these files.
---
 .gitignore | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.gitignore b/.gitignore
index 70ec6037fa7a..04472c37b6df 100644
--- a/.gitignore
+++ b/.gitignore
@@ -173,3 +173,11 @@ sphinx_*/
 
 # Rust analyzer configuration
 /rust-project.json
+
+# Smatch tree outputs
+smatch_compile.warns
+smatch_db.sqlite
+smatch_warns.txt
+smatch_warns.txt.caller_info
+smatch_warns.txt.sql
+trinity_smatch.[ch]
-- 
2.40.1.495.gc816e09b53d-goog

