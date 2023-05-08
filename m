Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86356F9F51
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 07:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjEHFzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 01:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjEHFzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 01:55:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1657F1990E
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 22:54:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6436e004954so4301371b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 22:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683525271; x=1686117271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=07MlugNYLtbOHXwFN9O72PeX4UMEVPANxn9ti2sf2kU=;
        b=mzG7eMJqaMNeji/kwLH4F7l9HZshZkvTHircCdVRIJ2kqMAk7qF+0dyd1D6z5npSmO
         TEcMUdrzuRYTG0j4Xj4a/MGCfu1VXHElTAxw0PMMvi6LHWUZHVKTaoE/HBFO4LBBTHKr
         38tqIZCSvguGKnIgfE66k4LvstKDxn2FiFKfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683525271; x=1686117271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07MlugNYLtbOHXwFN9O72PeX4UMEVPANxn9ti2sf2kU=;
        b=TAWoIvXqblioOtsZlTgMgFH99NqbUD6xxcq92Bw3ezvCyrcxN+SVPGneHg7wW+f0eN
         Vr/63ZJy2+rDPEAZ8Bvwo7vhhgKnE622bvx5eX+Ee9LkHVk1zuZ1i2fVqZ0f93ElQFwR
         w7DuxQW3f4QaqZQs4GHm7xCpQx+m+TugA2p8vKPLxAsIIzqnKmiME0zvHEHv9OW9pldY
         0Dm/HuDDnW6AfBucs2LeBkWfCuNXsMLy+k3OhekhD/VwVB7cUN/s3kh92EoSs/7VDl/y
         AejGm/ggWl+09xff7R/O3JrZQyEDYTfgUunPVSpEu1fqDhJ3PmCpe14mnQEjeE44yTRx
         38rg==
X-Gm-Message-State: AC+VfDyXP2THMPF1Kw5gYmWvjnYTu3L41ZyncMxXDWPj6dS7I5zPjnCA
        C5uAFHreQG0wR89Jxus9iLAtj+TlcwTt/8hTZvDNyg==
X-Google-Smtp-Source: ACHHUZ4wV4PJImiUTZdzG1mzBijS0/JIL9UtrrkiVBbu/FhnvHTZubTb1WqUvBzC/eQIdKYcipYltA==
X-Received: by 2002:a05:6a00:2310:b0:642:fbed:2808 with SMTP id h16-20020a056a00231000b00642fbed2808mr12126263pfh.25.1683525271663;
        Sun, 07 May 2023 22:54:31 -0700 (PDT)
Received: from datalore.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id v6-20020a62a506000000b00642ea56f070sm5294266pfm.30.2023.05.07.22.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 22:54:31 -0700 (PDT)
From:   Brandon Pollack <brpol@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, masahiroy@kernel.org, ojeda@kernel.org,
        alex.gaynor@gmail.com, keescook@chromium.org, nathan@kernel.org,
        Brandon Pollack <brpol@chromium.org>
Subject: [PATCH v2] .gitignore: ignore smatch generated files
Date:   Mon,  8 May 2023 05:52:28 +0000
Message-ID: <20230508055226.3183447-1-brpol@chromium.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ignore smatch generated files.

Change-Id: I8ca4002128e53024ea8a3daef908ec5e49cec65c
Signed-off-by: Brandon Pollack <brpol@chromium.org>

---
v2: Removed trinity stuff

New to development and looking for tasks to work on to get familiar with
code, I noticed smatch generates some files at the root.  Since this
tool seems frequent for newbies like myself I thought it would be worth
getting rid of the chance of accidentally committing these files.
---
 .gitignore | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.gitignore b/.gitignore
index 47229f98b327..fd8572cb7db7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -171,3 +171,10 @@ sphinx_*/
 
 # Rust analyzer configuration
 /rust-project.json
+
+# Smatch tree outputs
+smatch_compile.warns
+smatch_db.sqlite
+smatch_warns.txt
+smatch_warns.txt.caller_info
+smatch_warns.txt.sql
-- 
2.40.1.521.gf1e218fcd8-goog

