Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521C76DB5C8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjDGV3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 17:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDGV3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:29:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93332BBA1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 14:29:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j14-20020a17090a7e8e00b002448c0a8813so4403435pjl.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 14:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680902974; x=1683494974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R5pwr73HER5r5lm/I7kdT2UE3HZ2H2e0ixPC/w+bENg=;
        b=TyiLNpWgGovqrFVmfzECFC7Gk1j92Xl2ejkRbjqSSGDDfPU2EDGKQmqPbFcYdNGzlo
         DIgVYiIKZ1LzU+N/0jSZOr50kHUbXvQQyvuTt9gY4Vkb9bHKhUZoy7NUzBHPV5nzi9d7
         I0cTHKUC8O+iuCmsfk3WiRvNYgmHdWFNWA0+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680902974; x=1683494974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5pwr73HER5r5lm/I7kdT2UE3HZ2H2e0ixPC/w+bENg=;
        b=qJQkQ8b42xcEbbMxhPFcjwW3XyjTdZ4Ns4ESOr0uiY+GqLlqXbIEBdx8mJpeMHxk8g
         qzQ+PaPNZt+wOfkAFoouY3NEnC8wksoMADzrcK0Yliz1SxciIg9NIqeIETtfjk4P6MHX
         uO/R37Z/B9GQotmQHd5tLHjslMFBtCVt3Fe1oCHnhLBDryEKlCMZcKZjJ+fC6izGMMlA
         v8dI9cb0Vr8WAo5E5Mn3G3R7AzuEEpfBYXksI0PzmeucWc/slK2RZHKxXLSQrMCQ9iWX
         fBk1/qh2q7Tdsizy3eMadSgYmACWcnjvSzs0P9NLAOUrPr7ZIwzzzXViGZaSfVOcDz2C
         CP8w==
X-Gm-Message-State: AAQBX9eP10EXMQ8n3EAXVFqyl9YzrTSdx4biQEPMQoiL6qLe9Q9fHo23
        Yxzjah/UKk9VLnXbgYk3rwu/Kg==
X-Google-Smtp-Source: AKy350bkJqjesu+PiSv3njS1SWT7qA2WhEHH6Qjh9s4Mv7FijOL5LsPmld/9LG6eb2QVgr6dn6/HSg==
X-Received: by 2002:a05:6a20:ba83:b0:e3:763e:555 with SMTP id fb3-20020a056a20ba8300b000e3763e0555mr3840921pzb.57.1680902974075;
        Fri, 07 Apr 2023 14:29:34 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:cad1:6cfe:57e6:8f81])
        by smtp.gmail.com with ESMTPSA id s21-20020a056a00195500b006243e706195sm3443390pfk.196.2023.04.07.14.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 14:29:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: qcom: Add "and" to PIN_CONFIG_INPUT_ENABLE comment
Date:   Fri,  7 Apr 2023 14:29:14 -0700
Message-Id: <20230407142859.1.Ia5d70e320b60d6707c6182879097708e49b8b519@changeid>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment recently added talking about PIN_CONFIG_INPUT_ENABLE is
clearly missing the word "and". Comments live forever, so let's fix
it.

Fixes: e49eabe3e13f ("pinctrl: qcom: Support OUTPUT_ENABLE; deprecate INPUT_ENABLE")
Reported-by: Stephen Boyd <swboyd@chromium.org>
Link: https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/4409769/comment/9a1d5def_e1e71db7/
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/pinctrl/qcom/pinctrl-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 65a172786ae0..c5f52d4f7781 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -517,7 +517,7 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
 			 * The points above, explain why this _should_ be a
 			 * no-op. However, for historical reasons and to
 			 * support old device trees, we'll violate the docs
-			 * still affect the output.
+			 * and still affect the output.
 			 *
 			 * It should further be noted that this old historical
 			 * behavior actually overrides arg to 0. That means
-- 
2.40.0.577.gac1e443424-goog

