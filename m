Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A29868D391
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjBGKHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjBGKHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:07:03 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A409CDF7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:07:00 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ba1so8925503wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lWt2r353lcFyJnQUncfOB++Pmrrgf9R+tGpN58P0m6I=;
        b=eKw67NCl9+1Ga31tu6pQD8Th4u85QdCRBin47mHIwzxkTV8hqnzfV4mSU1hddCYVMh
         BqztHvWUqJWFKDpzsBZBUU1yU5PWJh3maTyqOdwOxOBO9ZWmQtqlyhr2rRDiscIt0R94
         VBjKsrtCXZyT4HUKnF0aRAaqeB7emr8eKKzG2sctcIt8vVcHfeyoGxBg2QvMpnwBFDBt
         lsFQvgCayzN8dqvPU+fbp4Mfjg6jL7RISxll3ccEi9cmFD6VxzyvvCaIACApLoZTG/GK
         5/H0MgH3NmztkpsDUBjo6FCJRPHQyzkLPNQT05SYgJeetijfCc3rOXXBQz2lqx5Diurt
         lmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWt2r353lcFyJnQUncfOB++Pmrrgf9R+tGpN58P0m6I=;
        b=Lc73ZoBfS6TTxNKHhMur85Op8MExByTD5WE86Nsenk19AWxgzRhcCFEvKa4zRofdoR
         YvjsvSPAEHhlypE9Qxb9CKmNiNYOMYV8KqtIq/beFvcKJELbnYsXLp94hrhxGN2J3/Ic
         8xOVpbdhaHepaZTKtmO6B8zgwa3jhJaTyg1AsWKSO1fovNX26NeLxzO4R8MIdSfzOjn7
         ckoTWN34lgceOcfBYCHY/XUtaYvJt0T8BnyXib2XNu+W8To56V2flIFimvURxiWw8Cmb
         0KJsgif3StEH6EcT/2W2ZleNiJPAA4tK5miA48m34j4B8X+JspSNaolzDLNEoi5vhndP
         Y6nQ==
X-Gm-Message-State: AO0yUKUvz7hNxgkxnEdatELOX4NsYDTUGUL48hOcNERqWioZxgw1MPyS
        Yv6kurPgt85NKe3MgpCigEFqRw==
X-Google-Smtp-Source: AK7set+m66FNJ1KJXjcXKx7eHujdOhfBjLnHWAwsyXUcUb40gk06cQeiyl9M5dHajYwWT3vxWhuowQ==
X-Received: by 2002:a5d:48cc:0:b0:2bf:b710:5760 with SMTP id p12-20020a5d48cc000000b002bfb7105760mr1710433wrs.69.1675764418897;
        Tue, 07 Feb 2023 02:06:58 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600002ab00b002bfb5ebf8cfsm11428205wry.21.2023.02.07.02.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 02:06:58 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] arm64: dts: qcom: various sm8550 DT fixes
Date:   Tue, 07 Feb 2023 11:06:56 +0100
Message-Id: <20230207-topic-sm8550-upstream-sm8550-dt-fix-v1-0-698d132ab285@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMAi4mMC/zWNQQrCMBBFr1Jm7UCSGqNepbhI0tEG2jRkUhFK7
 +4guHyPz/s7MNVEDPduh0rvxGnNAvrUQZx8fhGmURiMMr0yymFbS4rIy9VahVvhVskvfx4bPtM
 Hndbn3l2iudkAUgqeCUP1OU7Syts8iyyVZPu7Hh7H8QXNCbdwigAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes PON compatible and DSI controllers compatible properties.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      arm64: dts: qcom: sm8550: fix DSI controller compatible
      arm64: dts: qcom: pmk8550: fix PON compatible

 arch/arm64/boot/dts/qcom/pmk8550.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 49a8133221c71b935f36a7c340c0271c2a9ee2db
change-id: 20230207-topic-sm8550-upstream-sm8550-dt-fix-7114376c295b

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

