Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855A3672325
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjARQ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjARQ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:27:20 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336AC58950
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:25:16 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g10so25102975wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DSvzqFsjwda+qkukhh0BsNuLrf3fRHWPVuUceF1d9qc=;
        b=HmSAZLFhiXT3wQ4Ry5QOGEstKuQl5JTokzUjNLDgaifHsW3Uerazdv/ztFeMA00fW7
         IbJttoEvcsJRn6Z9DdTriQEb7t9kLx207IgE3JnBRgHL+TP6fhJwOjO23l7rGMq1w3y3
         ZIwpNdULS6/LAEkdj9bO6ioyse0ZAssjt5a2FLIH1BtMmRf8xAExBzTTO91vNZk/JE5y
         Emf5IvM9jkhPtEYuz/DFimOqRiBJy0yEhEotYCBzC1cEKyH9SytQnYdbBgHPq/SVZvg+
         5eNgErpKfuE8m0c7LW+N+bT7rkyaAW1ADShOIR18Xs0JlaY3YZqf68id89pxs4Bk5kUY
         1bEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSvzqFsjwda+qkukhh0BsNuLrf3fRHWPVuUceF1d9qc=;
        b=vWK5ZT/YDaZbOc6vJza/9PsEXg6OaQWcQH5vptko/MnmnxSWg3up7vlKzGLNa4esv7
         JhAKLXy90S/sSZX45pe+ZW1YYJ1Nmy2nuRY8E8ENEgjXyzyAVe82iaeK1WyueRcQl4jT
         sHXsUXS3t5lss7jNOZYOKLtE5ND9FJ/I1dc57qXRxv7cwDIB/ws97pEiHqvc+RsFWr3f
         YaqyLo6GNWi+hAyU3qtFZFxl720Rr6r1UHVlPflMu3DMHPUouLB8xgl7GhkabaFBMuqG
         a+2NVRFkSFDGmyDyAcWImnX19qEQ5MJoZs/v2MqR97tnB+SHgzInNPnDUDpzxvWNQ2SB
         aRJw==
X-Gm-Message-State: AFqh2kphS5tfG7lgzKxruBlc7v5gwiwz1UZBEMNKHZL9PeNRb34DIdUT
        bKsp2gm2j0mcYLDPLMbUe+aKKg==
X-Google-Smtp-Source: AMrXdXtNqzAOP/3o49Wq6Qlfdt+22yvpyunGOiLpYxTCA6sK79Ir9WoOpX9hpko8gKeRT7uFhtrmNQ==
X-Received: by 2002:a05:600c:214f:b0:3cf:7197:e67c with SMTP id v15-20020a05600c214f00b003cf7197e67cmr7255391wml.25.1674059114747;
        Wed, 18 Jan 2023 08:25:14 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b003db012d49b7sm3670695wms.2.2023.01.18.08.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:25:14 -0800 (PST)
From:   neil.armstrong@linaro.org
Subject: [PATCH v3 0/3] arm64: dts: qcom: Add ADSP, CDSP & MDSS support to
 SM8550 and MTP board
Date:   Wed, 18 Jan 2023 17:25:11 +0100
Message-Id: <20221115-topic-sm8550-upstream-dts-remoteproc-v3-0-815a1753de34@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGcdyGMC/53NsQ6CMBDG8VcxnT3DtVSKk+9hHEo5pQm05FpID
 OHdbdwcdbp8N/z+m0jEnpK4HDbBtPrkYyhDHQ/CDTY8CXxftpCVlIioIcfZO0iT0bqCZU6ZyU7Q
 5wRMU8w0c3SgpdF9U6Eh1YpCdTYRdGyDGwoWlnEsz8GnHPn1Sa9Yzu3HyopQgWpaIofYmxqvow+
 W4ynyU9xLYZX/qLKorXk09twp3an6S933/Q0NnWUHNAEAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the aDSP, cDSP and MPSS Subsystems found in
the SM8550 SoC.

The aDSP, cDSP and MPSS needs:
- smp2p support nodes to get event back from the subsystems
- remoteproc nodes with glink-edge subnodes providing all needed
resources to start and run the subsystems

In addition, the MPSS Subsystem needs a rmtfs_mem dedicated
memory zone.

Finally the firmwares file paths are added in the MTP board DT.

This patchset depends on:
- bindings changes at [1]

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

[1] https://lore.kernel.org/all/20221114-narmstrong-sm8550-upstream-remoteproc-v4-0-54154c08c0b7@linaro.org

---
Changes in v3:
- Rebased on linux-next
- Link to v2: https://lore.kernel.org/r/20221115-topic-sm8550-upstream-dts-remoteproc-v2-0-98f7a6b35b34@linaro.org

Changes in v2:
- Dropped dependency on MPSS DSM patchset
- Added DSM memory to MPSS memory-region
- Added DTB firmware name to firmware-name property
- Added reviews and fixes according to Konrad reviews
- Link to v1: https://lore.kernel.org/r/20221115-topic-sm8550-upstream-dts-remoteproc-v1-0-379eec11d841@linaro.org

---
Abel Vesa (1):
      arm64: dts: qcom: sm8550: Add interconnect path to SCM node

Neil Armstrong (2):
      arm64: dts: qcom: sm8550: add adsp, cdsp & mdss nodes
      arm64: dts: qcom: sm8550-mtp: enable adsp, cdsp & mdss

 arch/arm64/boot/dts/qcom/sm8550-mtp.dts |  18 ++
 arch/arm64/boot/dts/qcom/sm8550.dtsi    | 338 ++++++++++++++++++++++++++++++++
 2 files changed, 356 insertions(+)
---
base-commit: f3381a7baf5ccbd091eb2c4fd2afd84266fcef24
change-id: 20221115-topic-sm8550-upstream-dts-remoteproc-5285d7018e39

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
