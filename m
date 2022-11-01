Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9755615389
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 21:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiKAUw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 16:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiKAUwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:52:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF36C1AD8C;
        Tue,  1 Nov 2022 13:52:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v7so3762185wmn.0;
        Tue, 01 Nov 2022 13:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FU4rKyhF5EOMlKF3LPjf/v+NqtgVh2q+3HeQZZdYZXc=;
        b=h6DUCLW4bcvhWlk4H9dT+0bGh+SkyGHgGG/Dh1ItyNpuBj/WZVybdtxohiLFuSyT/M
         eqPmDf87aaotwQiATl58kQQ0axyTSZ8lqmSBAYlo9gFXIP0nC0fuw9Ou3Auj+iEkFWHF
         3YfmE3LwoBDBbvhKRSQBP457Koa5pmCWk+Seo4CeFYMJ2y8Fnta03pZPH96D2WULO+XU
         XhJihb3kusaPqWidAMqnX5MiG3V9BUT0nUA/H+k5ryqa71XjdkEgLBqfDdZbLCIjI69n
         DUt8M04LHN+RExViivMmp8d/a21OgjYpk14/6q7kdylGEjC+hqG82V1qcjILelcEoQw2
         4kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FU4rKyhF5EOMlKF3LPjf/v+NqtgVh2q+3HeQZZdYZXc=;
        b=7M/1RiIzu6gLIyD2OjKbUilfPj1ph5PXoSnLmHSVlpUUzLmpb0vQTwbsX3zWSjT08y
         wfOMd5PKOyLsNu5FGN2JwxJkKtr38vm7DpTDEYJmVdYULctqgBd/ITtai2kdVWYK3syC
         H9Ib0rog0u8xmHaAB/pbx3rOEGGwr2fJ6xz0eO3ZgnIwlQA3P1NgPt76ZZQRgdkHO4s/
         /N+f90wCgSIv3vgS7LNSvRsq5CNT+nBTyo3le3Z1xKC9oqHD9c5J0NsxBR/K703CkUlt
         dmiTVxMGD6AjkUMfkcnmqgTdCrjaAwitVdCWctzI+02H7QFwpB5CoLERcPvfE3/++gbK
         NEhg==
X-Gm-Message-State: ACrzQf3tmG97V7lAy9KQhCCPrHqey9IdamaoegJWS92Ysuw/zbFpJi52
        DFtMzn3CI1+AplPGotfI/vg4x7fGO3+sVw==
X-Google-Smtp-Source: AMsMyM7dsLc7vy5CeFFe4S6XwXjY3CjXinJ+EYdS+XsP3csiL9UWC9DVxC1s33otPZJqOH8nYMcIXw==
X-Received: by 2002:a05:600c:310b:b0:3cf:33c4:bc7 with SMTP id g11-20020a05600c310b00b003cf33c40bc7mr13185680wmo.25.1667335961270;
        Tue, 01 Nov 2022 13:52:41 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-167-8-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.8.167])
        by smtp.gmail.com with ESMTPSA id jb1-20020a05600c54e100b003c6b874a0dfsm11854413wmb.14.2022.11.01.13.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:52:40 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] docs/pinctrl: fix pinctrl_select_state examples
Date:   Tue,  1 Nov 2022 23:51:58 +0300
Message-Id: <20221101205159.1468069-2-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221101205159.1468069-1-lis8215@gmail.com>
References: <20221101205159.1468069-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function requires two arguments.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 Documentation/driver-api/pin-control.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/pin-control.rst b/Documentation/driver-api/pin-control.rst
index 71eefe5a0..19a41c68d 100644
--- a/Documentation/driver-api/pin-control.rst
+++ b/Documentation/driver-api/pin-control.rst
@@ -1238,7 +1238,7 @@ default state like this::
 			return PTR_ERR(foo->s);
 		}
 
-		ret = pinctrl_select_state(foo->s);
+		ret = pinctrl_select_state(foo->p, foo->s);
 		if (ret < 0) {
 			/* FIXME: clean up "foo" here */
 			return ret;
@@ -1411,14 +1411,14 @@ on the pins defined by group B::
 	foo_switch()
 	{
 		/* Enable on position A */
-		ret = pinctrl_select_state(s1);
+		ret = pinctrl_select_state(p, s1);
 		if (ret < 0)
 		...
 
 		...
 
 		/* Enable on position B */
-		ret = pinctrl_select_state(s2);
+		ret = pinctrl_select_state(p, s2);
 		if (ret < 0)
 		...
 
-- 
2.36.1

