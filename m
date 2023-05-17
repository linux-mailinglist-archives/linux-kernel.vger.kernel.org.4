Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F1B706999
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjEQNUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjEQNTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:19:52 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFDB1FFE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:19:50 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ac770a99e2so7533231fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684329588; x=1686921588;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OODF9wHSCYG54VVweDgKeLp3U0OSPmTomqN20PFs+v4=;
        b=c5F8lWdA8er+GioAFIIpWBSM+ENoKEBZFRo2n0NaOgnPJbtvms2bBc0l9oKHrFJY6w
         sj2XTPTXQPpA8DorFvErDfm3RmX+HDb1YjCC3Oa9nlzI+fyS8YfHm6s2kvZW0W61E1wz
         HLqGS2WAw2KpT6TOmNLVptCCIih/GCvMrCrdhRiTF4/GxaOSO9G3Bbc4oW/Fep0tzELs
         8jg09OzywpT6NuWVtYt49ts+nHv57Y8/uF+Dok47j11MBGN3yyvtMCexSsI8BlUjwyEB
         bF/bWOv8toDKj0DyHdnHpdbQ6aYMA6xrCBpPWugS9pTzqu50c3HfabyUcSKZcHnqc3Oq
         aB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684329588; x=1686921588;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OODF9wHSCYG54VVweDgKeLp3U0OSPmTomqN20PFs+v4=;
        b=hg3G+jleA/elP+Fzkt1e7xlYqyL4f6Jj9hujtNHF3Zk3MEyaDBeWPD6t2LnXDx+n8O
         LcYQN10RffofLls2oe9IWZiovWcW34n3/M7I9GmiTTTDPe3TAN0+XpThdGFkTod6Dtpb
         oslJgVR/aN1QtLy8iGO91RNvwIKrN1aG/Iplz7U6sr8eC1o8cNfAvu4InFuAdQk4iBdy
         XSSCJ8A5S1r5TkhgwwEmTYnYydFiLZZ8O6RltgXxRAlHs4d8NEIwb/qNTDMM/t16NvKY
         v2AqogpDSnqm+4HoaIWSq6OUhoGQsnE1x8iOBU3gzNruqb4vNn1hRRmAwPEyJqe0TDg2
         zRGQ==
X-Gm-Message-State: AC+VfDyhK1nONSaz5BAYmkuNXkXXzSTYwcbY3Ak5obpOo+60K/OpIxod
        75kiQtibQOC8uT9Ge4AM4X6MFCC6E4asJPZNCrI=
X-Google-Smtp-Source: ACHHUZ5YHoV1sc0sDvIJe7GzTEZBYcyI9a8bSVuSNOj6PyJTPckaEaNmb5LBIlmjq+pwlCJRL81pGg==
X-Received: by 2002:a2e:9cda:0:b0:2ac:dd01:e169 with SMTP id g26-20020a2e9cda000000b002acdd01e169mr9624045ljj.40.1684329588536;
        Wed, 17 May 2023 06:19:48 -0700 (PDT)
Received: from [10.167.154.1] ([2a00:f41:c93:874f:be7b:fb6c:26f9:307c])
        by smtp.gmail.com with ESMTPSA id f7-20020a2e9187000000b002adadef95c0sm3007457ljg.124.2023.05.17.06.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 06:19:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/3] More RPMhPD levels + sm8550
Date:   Wed, 17 May 2023 15:19:42 +0200
Message-Id: <20230517-topic-kailua-rpmhpd-v1-0-cd3013d051a6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG7UZGQC/x2N0QrCMAwAf2Xk2cDWbij+iviQpdEGa1fSTYSxf
 7f4eAfH7VDFVCpcux1MPlp1yQ2GUwccKT8FNTQG1zvfT8MZ16Uo44s0bYRW3rEEDG7kkSd/YU/
 Qypmq4GyUObY2byk1WUwe+v2vbvfj+AHfoVmsegAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684329587; l=899;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=aDhFrmJ9bpodLJ2PsX/rq6abMHr5lkvazPml98G0+2E=;
 b=s2gQuNI95KZ6KxdNWjb+ZtlvuHxijBCqBeKkr6RxKItkZLr6qS+aXsAxza3TpJgErX/mIbiCC
 6xTku+nd/M2CnadFzvyjhvBZMX+dtjcjfFERToU9fJs1bF5FtkB42X6
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring in missing RPMhPd levels from downstream and add ones we'll
need for GPU on SM8550.

Patch 1 adds the missing ones with an easy-to-read diff, patch 2
reformats the block and patch 3 adds the necessary levels to 8550 dt.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (3):
      dt-bindings: power: qcom,rpmpd: add missing RPMH levels
      dt-bindings: power: qcom,rpmpd: Format RPMh levels better
      arm64: dts: qcom: sm8550: Add missing RPMhPD OPP levels

 arch/arm64/boot/dts/qcom/sm8550.dtsi   | 36 +++++++++++++++++++++++++-------
 include/dt-bindings/power/qcom-rpmpd.h | 38 +++++++++++++++++++++-------------
 2 files changed, 52 insertions(+), 22 deletions(-)
---
base-commit: 065efa589871e93b6610c70c1e9de274ef1f1ba2
change-id: 20230517-topic-kailua-rpmhpd-d24c4c538c3a

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

