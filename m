Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5627381AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjFUJ2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjFUJ2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:28:01 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C3F19BB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:26:32 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b47742de92so48778111fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687339590; x=1689931590;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=re9WCz4H13D40XSzeAyHx5fCix8Cg4J0Ee8QgOUQuT0=;
        b=GMmxJ1YCaiXF5kZ2Ja+WePNK+ZIPDbA8ZHsemdGIrpwEFnmT1WHuaXvutqE9vnmhjo
         bDnx3HipilReckxTSkm8W95QkhLqvNTQv3g6gg4LeovCqUScmS4Dm0s2qjJjZM5wF0eN
         Av1gSMmyTEEoK9Z2L0JffcJ9Civ/wjf4nnDCmLlgKof1SCkZg3A4PouFbI9Fc0Gw/uyW
         4kvOVYwMt+NEhYr5F1Wn/dgV2B044j0rp7QAyD0NAkL9YcM6n0C/Fu4p/vXJJcEtEJ7E
         6m8uXzA6b0Qs8PWArD5H+zIT9Oo9ekILLrC7bpqnOa1pY5KxBWBtRqm3dhBn3lzg/628
         F1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339590; x=1689931590;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=re9WCz4H13D40XSzeAyHx5fCix8Cg4J0Ee8QgOUQuT0=;
        b=ZCKQitV7DIzO7AjbepzRSI6nDUV/7Nm7S2Gu7sJkwRaSVxMROs2/VLs6riVHUOpI9N
         QYoKcREtfReX0gcpgkCvQ+NdI7maoSXDj5pqYi3UnvV9N+pHC3lXdR8+ErBL8u3diTUJ
         /5XpMhyTZEZvdfB4GEl9kO+vudOAsCUAdQp/MoQ2r7hcVFpHa5lxw6bGaMirerkFRsfz
         mxZXRY1BTtx7tsdD/AzYluQHirg1Sy7oNZiXQVjlo6BSfrhVndZ4be37/zOHKhSCoL63
         dh4Nym8WtAFcZIYgfqANrA9qWJvveTeECHTANwTsID1wMMJ76hSdHggSId9pyBnBQKfS
         K9LQ==
X-Gm-Message-State: AC+VfDx9qJQvxxATP5Nem1McGmjAbH0oByqqgHCt1k8efA8Rn6yVZzi6
        W8OFVDBvPqCSY/tpr8B524Pgrp8S5CNM0cr6Ak8=
X-Google-Smtp-Source: ACHHUZ58tV60/jf+wRQdI/GcTTGcfiQe77Op6a4yhZwgerhTLga/xGCChPbIhBe1AM+r0dXuBtNmFg==
X-Received: by 2002:a2e:91c7:0:b0:2b4:6f70:c396 with SMTP id u7-20020a2e91c7000000b002b46f70c396mr6131206ljg.44.1687339589956;
        Wed, 21 Jun 2023 02:26:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n8-20020a05600c294800b003f90a604885sm4435068wmd.34.2023.06.21.02.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:26:29 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 21 Jun 2023 11:26:25 +0200
Subject: [PATCH 1/3] dt-bindings: display: msm: sm8350-mdss: document
 displayport controller subnode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-topic-sm8x50-upstream-mdss-bindings-dp-subnode-v1-1-8bf386b373eb@linaro.org>
References: <20230621-topic-sm8x50-upstream-mdss-bindings-dp-subnode-v1-0-8bf386b373eb@linaro.org>
In-Reply-To: <20230621-topic-sm8x50-upstream-mdss-bindings-dp-subnode-v1-0-8bf386b373eb@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Foss <rfoss@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=914;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=TjGzGqa7j6xVxSr3WjxySjU5IBZ7vg9i0xPyCqvFJi0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkksJCb2CsPo8fWtFtkNdnkOj1Cj90XZDCp0vGBqUi
 89CoPx2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJLCQgAKCRB33NvayMhJ0ey6D/
 4p0mvBdmW6d4uPRJz6Lj+ohsDtEXzF3RC7piur4ugP57SqZuR15Wx9eucM4cYwfQsQ7mJvu6MMFsba
 3ICwQLcY++kSZYwDawFC7Wcg3681LZUbhr6JGZCzaZ7+HT7hy9/kd7lCmgh79XNR7WkgyMMqR8O2Iw
 AIgWAW5AEfqTz1dOmF5hddGTEDR6qBLh2dFjVZFzq/bxobPf/TTtv/ERpTd5T6j0GAbYRjztVyxlS+
 4/2txB6UZMVbFJoRuUb2fnyRO9AfPz2G3RT6B1tzChcnrq3kl2YXHmWXg/2FlSWsEaa2BnVtqIe75u
 z7f8WXgMkQybIa0XUHYm3GYjuED+EvSIHt/raQSdQw2xxiX2WicMC7UZbOkrNIoq7fVoKf52PFzPAH
 ihuvy/r0ISSwyyYoeDfgqINxSzymRQniOKGTUSiGUWhZor2KCzf/r3auK3PkCYjE8orgcre5pwGB86
 bGOD/4oVuyvSCahjePs7EqxKBIlzWR6agpXAORMg1OLv7nYYSCgyk9wdn0KZNvNKk/aSA0UFkv7mIg
 nxKuwjWfDzKpsgHAFOuot4LNYdUj4E6+gKAAQyDC1EtAZbKuNrnrj5KfkH5A06qgvh4w3X7miElfNb
 Vbj63mzWr1zE6hHflOtG8v2V8r4NtleYfXKfwaTwACYdN0azrtdzQAIMknHw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the optional document displayport controller subnode
of the SM8350 MDSS.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml
index 79a226e4cc6a..f2cbeb435f1b 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml
@@ -52,6 +52,12 @@ patternProperties:
       compatible:
         const: qcom,sm8350-dpu
 
+  "^displayport-controller@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        const: qcom,sm8350-dp
+
   "^dsi@[0-9a-f]+$":
     type: object
     properties:

-- 
2.34.1

