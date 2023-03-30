Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998566D1094
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 23:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjC3VLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 17:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjC3VLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:11:33 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03055E04A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 14:11:32 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so21178250pjz.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 14:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680210691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ts/+7LQ/a90MvbSUsF1wWZw6aBmGhxvSMeOp9K0n6B4=;
        b=OA+qXoJPXeplznwBkYYzDfj3rlnWfYKi9SSiS1c3UEoZPKGOu/MfTcJGHYlitYfJij
         Kx9b6usnN3Ay4rlLsCO9CMxZorkqibXar+hxVnABKEPiPL+gVXPLNKz8UiAGp3bVw2Kx
         4i4xt0Rx9F6lk44/U++iK1hflPnxClyGgeuzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680210691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ts/+7LQ/a90MvbSUsF1wWZw6aBmGhxvSMeOp9K0n6B4=;
        b=GzEqVbAtIoa9I3/pitkI0Foq54XUd0Ig3XwVjrCOWnfYuqfhSJeg+G4LOvCamQWstz
         iMwOED9spFVOgB2rxzYueOXAocbW3uCxFnxCBoIEsQnBe80BDsLV6VgTmY7DEvEIw/i5
         RZuvJ+SSMxt2zGDsksMxVcHtccwE2RUd89/CH0dmMSH9Ex5NVHE/zgXOippjz6mmk7b7
         UKtGoRlxCADPPDkagsutQB7LOLe6x4yE0OkijBTUvfwgSKDLTtKHuiauhozRio6BTnb7
         M0D86wxBizg03jRzeANz6l9+EtPkA+oaiAXxp/rOioagn+g4OhNoul42GmFSkOfQw9MT
         wN9Q==
X-Gm-Message-State: AAQBX9cd1q6mq8uyMQCLqf9bljpDQN26uVOcJ316DIENzdIJDm3V6xDu
        oNO5rQ70hCF8Hdq2I+w3EtR5mQ==
X-Google-Smtp-Source: AKy350aKbPAA/imN45S5d9F5KqLZwNk8NkRnjAxPmVE/Yxy548Sm0c6CEhdWYp6rXcp9Q3vwR/VLTw==
X-Received: by 2002:a17:903:70f:b0:19e:bc8e:6421 with SMTP id kk15-20020a170903070f00b0019ebc8e6421mr20352821plb.47.1680210691365;
        Thu, 30 Mar 2023 14:11:31 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:ba73:62df:d346:fc37])
        by smtp.gmail.com with ESMTPSA id c20-20020a170902b69400b0019f1027f88bsm123897pls.307.2023.03.30.14.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 14:11:30 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: qcom: Add reviewer for Qualcomm Chromebooks
Date:   Thu, 30 Mar 2023 14:11:00 -0700
Message-Id: <20230330141051.1.If8eb4f30cb53a00a5bef1b7d3cc645c3536615ec@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
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

Developers on the ChromeOS team generally want to be notified to
review changes that affect Chromebook device tree files. While we
could individually add developers, the set of developers and the time
each one has available to review patches will change over time. Let's
try adding a group list as a reviewer and see if that's an effective
way to manage things.

A few notes:
* Though this email address is actually backed by a mailing list, I'm
  adding it as "R"eviewer and not "L"ist since it's not a publicly
  readable mailing list and it's intended just to have a few people on
  it. This also hopefully conveys a little more responisbility for the
  people that are part of this group.
* I've added all sc7180 and sc7280 files here. At the moment I'm not
  aware of any non-Chromebooks being supported that use these
  chips. If later something shows up then we can try to narrow down.
* I've added "sdm845-cheza" to this list but not the rest of
  "sdm845". Cheza never shipped but some developers still find the old
  developer boards useful and thus it continues to get minimal
  maintenance. Most sdm845 device tree work, however, seems to be for
  non-Chromebooks.

Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..b4e9c5bda234 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2604,6 +2604,12 @@ F:	include/dt-bindings/*/qcom*
 F:	include/linux/*/qcom*
 F:	include/linux/soc/qcom/
 
+ARM/QUALCOMM CHROMEBOOK SUPPORT
+R:	cros-qcom-dts-watchers@chromium.org
+F:	arch/arm64/boot/dts/qcom/sc7180*
+F:	arch/arm64/boot/dts/qcom/sc7280*
+F:	arch/arm64/boot/dts/qcom/sdm845-cheza*
+
 ARM/RDA MICRO ARCHITECTURE
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.40.0.348.gf938b09366-goog

