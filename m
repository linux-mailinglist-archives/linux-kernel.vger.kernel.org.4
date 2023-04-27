Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9786EFF63
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 04:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242724AbjD0Cd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 22:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjD0Cdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 22:33:53 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CD3E41
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 19:33:52 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-51efefe7814so7907169a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 19:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682562832; x=1685154832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ShJY8n4sgoVR0xVA/Xd2B1NN2sZJxLaoIaz/pnbgw4=;
        b=H71h/hfn3UfWcuNd0NqWtMGDK1p4irqp1OLsK2PBpbqCrU1olGOmYEISt7zRvRguoQ
         lLMrTyYsJKkw56AQNKRaPG8uQ0ff3bmeqrNffh2oI8xQAqd3o6wW27IxkjBBZcYxdWyH
         UgqiBp8cTqaOIcHaWBpLBGYUtgvZ9OUNdHStE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682562832; x=1685154832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ShJY8n4sgoVR0xVA/Xd2B1NN2sZJxLaoIaz/pnbgw4=;
        b=aF+Yd/gwwaxIKDvUlwB+mMMZZGQ+6fYqtaLK2y9PM6B1xA93jUua4RIK+oJ3VWRIfy
         omaQHo4x3I0u/arwEb1hFx5pkMrT5gn/AhVdOhuab/HXBXnpWq6zFMwAjKxbIr4QuVG0
         IMEqqHjuoTSX+WPLzOOC10JxsPvGWZIys2Z16sANN6+Z3wuai30JwrOXfDKjkkkjWopr
         pgVcKp8yGF2Nk4OaY918KmY19EG5rH7sSPjKOJEeCoH4ZOv8ZfExGoR2ruePME/R1ePj
         TaIM7oesG2gmYYieWZCh4uNBAqaX3SR8vs+FuhnvbSTYeF2Af8ZWbmsVIjopkdBcQL+7
         Fctw==
X-Gm-Message-State: AC+VfDzVKCr3h4SHUTY9kSpFbj3vmNwUGDIH9McAVyqBwJs5zj2aRkRi
        0yC/1Bndh4YKf4s6vXqznZGJeNXKwVgEUf5WEL+fnA==
X-Google-Smtp-Source: ACHHUZ46CaYRefudIyJaakbxXhRhj6UXjtLQmnSqftSBE9XAQBj+reA5psE5reQJT49ser0Z3bPTbQ==
X-Received: by 2002:a17:903:32ce:b0:1a6:3d8e:face with SMTP id i14-20020a17090332ce00b001a63d8efacemr10938plr.0.1682562831883;
        Wed, 26 Apr 2023 19:33:51 -0700 (PDT)
Received: from datalore.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id iw2-20020a170903044200b0019a91895cdfsm10561029plb.50.2023.04.26.19.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 19:33:51 -0700 (PDT)
From:   Brandon Pollack <brpol@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     masahiroy@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
        keescook@chromium.org, nathan@kernel.org,
        Brandon Pollack <brpol@chromium.org>
Subject: [PATCH] .gitignore: ignore smatch generated files
Date:   Thu, 27 Apr 2023 02:33:45 +0000
Message-ID: <20230427023345.1369433-1-brpol@chromium.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ignore smatch generated files.

Signed-off-by: Brandon Pollack <brpol@chromium.org>

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

