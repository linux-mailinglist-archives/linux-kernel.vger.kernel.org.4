Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D531D7320DA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbjFOUVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjFOUVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:21:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F532101
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:21:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f76a0a19d4so3130918e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686860504; x=1689452504;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HBnJ2Bgs7NnTPEf+29k5afFhHZznLH3YJWpF/myufg8=;
        b=rhRosn2JrgLJL3Q1sCXeF8kp/wjw6cigH9cy9pqtQajK16RqRLjbcJDBVxNEDLE8Rb
         B2jBgmKP1QRJAA47Cw30RsYi45YQhRVsSy/NiFOVAKueAe068MzuS/E0h/JlMUQSy8oU
         kWrcQOtOr6jjOpbTKh5iEP/x3A0H3/BuoMGjHuUnqaWkUuY1wtwfvUhp2nYqOZLM1Cnn
         2fvqfTPzf+cdP1Xyy+Q9EmXNqGJZ+D+aRvG5CEEGfDn6CHxNJnbdNK/ALEKTxxYYb8KQ
         y+iBt4UyKtm1wN4uV+E4BfW/QnIfJtvTMIfNZP2MPpyMu2Jj1GmUptHMH6F9BNmPFigV
         l8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686860504; x=1689452504;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBnJ2Bgs7NnTPEf+29k5afFhHZznLH3YJWpF/myufg8=;
        b=agKFORJvurCazHzHAq7Hu+/zMqnLI90Nq50hfG2+3T/XqgZtZNf0TavKsch6hZKnUx
         NZc9kr+1wLx303AJ49gVjfpd+6npxy2B6PtJM94dBIwi0oDgc9VLNQHPjv7I1diNKImC
         bYWm/pDEqprnxJLvHkg7+CAowlT9JFTYi48NIVG0bci4jZpnbkSMtjbTWMvkQqfJfNKU
         ciEuFXqxrPEB0RPFNaOpQR6aTCRChz0fdqTRknXdu8y/H2DHY/D6CsFYD2z6/Ibu7wN+
         Fo5quh6vaJdDB9sizQZ8xaf2gg8vX/RJg+Yr/f0/nllOhCA9btf8grdpR31QvA+/RNPV
         LOFQ==
X-Gm-Message-State: AC+VfDzJsAA2VMde2aIX+OrL2qdglaNYMEDTyFjcTTIy4q9RBlN2d1oY
        QTMivkIBsQeSie8BTH3joI2l+w==
X-Google-Smtp-Source: ACHHUZ4tm5UWambBbENZJom/hP8F6JMPK4ZhtdiOrvN5EfawIBP4DVJCelYmU+FAt9DWV8RNotQVrw==
X-Received: by 2002:a19:4f0c:0:b0:4f8:421f:cd37 with SMTP id d12-20020a194f0c000000b004f8421fcd37mr2117173lfb.56.1686860503800;
        Thu, 15 Jun 2023 13:21:43 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id r14-20020ac252ae000000b004f3946030fasm2736470lfm.68.2023.06.15.13.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 13:21:43 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/2] Fix up the boe-tv101wum-nl6 panel driver
Date:   Thu, 15 Jun 2023 22:21:36 +0200
Message-Id: <20230615-fix-boe-tv101wum-nl6-v1-0-8ac378405fb7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANByi2QC/x2NQQ6CQAxFr0K6tsnMgLPwKsZFi0WayGBaRBPC3
 R1cvvy89zdwMRWHS7OByaquc6kQTw30I5WHoN4rQwqpDTmecdAv8iy4rDHEz3vC8syYidqBOCX
 uOqgqkwuyUenHQ57IF7FjeJnUwP/vetv3H7tVHAp/AAAA
To:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        yangcong <yangcong5@huaqin.corp-partner.google.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is two patches fixing things I would normally complain about
in reviews, but alas I missed this one, so I go in and fix it up
myself.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (2):
      drm/panel: boe-tv101wum-nl6: Drop macros and open code sequences
      drm/panel: boe-tv101wum-nl6: Drop surplus prepare tracking

 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 2420 ++++++++++++------------
 1 file changed, 1193 insertions(+), 1227 deletions(-)
---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230615-fix-boe-tv101wum-nl6-6aa3fab22b44

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

