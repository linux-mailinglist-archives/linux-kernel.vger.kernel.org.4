Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3ADE62489B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiKJRuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiKJRuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:50:00 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F723C6CE;
        Thu, 10 Nov 2022 09:49:59 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5so1609426wmo.1;
        Thu, 10 Nov 2022 09:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BdBVXocSnFGsbcNId82TAu2zb7JGiMOw9Hh/Hs4GgV4=;
        b=ISXDYr7ctt69RJPDy8JEQboP41ce+EvX64xL6JA+TXVs8P98ZbaC+bHMegKhnF/lLV
         RjFUNJgXTmciOQSVKg2Iz34bUWZouKJgcLLfirX5fFFU28UkY25aWKAI8QvgrvGoh5Ev
         5GvMop8qAIv2qWG2/ECQO44uLqxwzHEyDORrjI73S+11Ek0wgaELHS4E2JXqYX3ixuSl
         XU2IWqspQ0IDR9heNvAze7+XHfJlgW7FJODVkeEuVnWw/oOiW4HH1hvTviuSmP1JPpcp
         hYAi8/vQnX2g+7c/8T+fc0KZ/gOVBoCAVw4yuaVDfHOqOVFHdJJMcRqrHjNGNKc3aAMK
         eaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdBVXocSnFGsbcNId82TAu2zb7JGiMOw9Hh/Hs4GgV4=;
        b=rWn5VXw9Z7qXJa+Wh9chALf7K63CCXkgPgEYWzlW0jnKeYmLrk8viYYy407paBw31R
         XPl8QcntuDUz2nlkraprUAyomXqNj0d/PStJzI7LynBmGrjjacdgPmrWLekyMDgOaFdM
         VJEGn89ZWjPcJWhgLqmpBIDtx3JbzPf1OUV/lGo9uzqqf4C2IbF2LLkCg3z/9E7dYGgA
         DZkybm7OK71CmmkYBZcLewklUM9tUARjeFZe73hoBGnBtV1UJmemZ5B8EUeYl2tQMzvu
         l9fqKeWUdltI/59fpEiMOAxw7oYMS9/7km8aubAJLjElKP77G5+xarzD/d7Ae7ugfXPv
         n8Gw==
X-Gm-Message-State: ACrzQf3BW0npmchfxU3OxyafKN1bJv/mY93J336/lYEs5bC5eW943VwO
        9pmPFK4q74lWDVo/frEYO2A=
X-Google-Smtp-Source: AMsMyM5044apPm6teirK4PsKgHKiAs2Vk/tL5/9+MLuye+TGFQSqPZCI54PW38cMEs+v8tPU058ZmQ==
X-Received: by 2002:a05:600c:a4b:b0:3b9:859d:7ed6 with SMTP id c11-20020a05600c0a4b00b003b9859d7ed6mr54719981wmq.169.1668102597818;
        Thu, 10 Nov 2022 09:49:57 -0800 (PST)
Received: from localhost.localdomain ([94.73.35.109])
        by smtp.gmail.com with ESMTPSA id q19-20020a1ce913000000b003b49ab8ff53sm272113wmc.8.2022.11.10.09.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:49:57 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, mairacanal@riseup.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] HID: uclogic: Standardize test name prefix
Date:   Thu, 10 Nov 2022 18:49:55 +0100
Message-Id: <20221110174955.398885-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Commit 961bcdf956a4 ("drm/tests: Change "igt_" prefix to "drm_test_"")
introduced a new naming convention for the KUnit tests present in the
DRM subsystem: "drm_test_<module>_<test name>".

This naming convention is very convenient because it allows to easily
run all subsystem tests or all driver tests using kunit.py's wildcards.

Follow the naming conventions used in the DRM subsystem adapted to the
HID subsystem: "hid_test_<module>_<test name>".

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params-test.c | 4 ++--
 drivers/hid/hid-uclogic-rdesc-test.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params-test.c b/drivers/hid/hid-uclogic-params-test.c
index 57ef5d3e4b74..bfa7ccb7d1e8 100644
--- a/drivers/hid/hid-uclogic-params-test.c
+++ b/drivers/hid/hid-uclogic-params-test.c
@@ -136,7 +136,7 @@ static void uclogic_parse_ugee_v2_desc_case_desc(struct uclogic_parse_ugee_v2_de
 KUNIT_ARRAY_PARAM(uclogic_parse_ugee_v2_desc, uclogic_parse_ugee_v2_desc_cases,
 		  uclogic_parse_ugee_v2_desc_case_desc);
 
-static void uclogic_parse_ugee_v2_desc_test(struct kunit *test)
+static void hid_test_uclogic_parse_ugee_v2_desc(struct kunit *test)
 {
 	int res;
 	s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
@@ -175,7 +175,7 @@ static void uclogic_parse_ugee_v2_desc_test(struct kunit *test)
 }
 
 static struct kunit_case hid_uclogic_params_test_cases[] = {
-	KUNIT_CASE_PARAM(uclogic_parse_ugee_v2_desc_test,
+	KUNIT_CASE_PARAM(hid_test_uclogic_parse_ugee_v2_desc,
 			 uclogic_parse_ugee_v2_desc_gen_params),
 	{}
 };
diff --git a/drivers/hid/hid-uclogic-rdesc-test.c b/drivers/hid/hid-uclogic-rdesc-test.c
index 3971a0854c3e..b429c541bf2f 100644
--- a/drivers/hid/hid-uclogic-rdesc-test.c
+++ b/drivers/hid/hid-uclogic-rdesc-test.c
@@ -187,7 +187,7 @@ static void uclogic_template_case_desc(struct uclogic_template_case *t,
 KUNIT_ARRAY_PARAM(uclogic_template, uclogic_template_cases,
 		  uclogic_template_case_desc);
 
-static void uclogic_template_test(struct kunit *test)
+static void hid_test_uclogic_template(struct kunit *test)
 {
 	__u8 *res;
 	const struct uclogic_template_case *params = test->param_value;
@@ -203,7 +203,7 @@ static void uclogic_template_test(struct kunit *test)
 }
 
 static struct kunit_case hid_uclogic_rdesc_test_cases[] = {
-	KUNIT_CASE_PARAM(uclogic_template_test, uclogic_template_gen_params),
+	KUNIT_CASE_PARAM(hid_test_uclogic_template, uclogic_template_gen_params),
 	{}
 };
 
-- 
2.25.1

