Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759AC66E03C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjAQOUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjAQOUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:20:32 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378E43B662
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:20:31 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so4938855wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fHE/v4+uK+hhFNGRiRI8Oa2ab1RUtvMhDGA3+YRGHLE=;
        b=yx3j2Bpp8LHeZsYwke9yWaWsEXsl1Uu726mdIDkWhMfC3ejEbQQgF2gPovYBa28Gqd
         Ps+fGV/qlIUWKSs0i79XP+4EYWladvlKco32eLngSjXQKmoe18qyyeUAHvY4xdJqOBrs
         ZXz2clV+UNlhFoPHPMn/dLqfwghOFLYw+V+bjC6YX6o8th2RAkYPfiPkvTa9+fwLT/jL
         AlhPuoEOVTEVQmFOO18BTlCrSdh/SQ9cdXVPx/PUW5TlT8jd40Mjs3jxonLZCAA7wm26
         G7xKkE0b7/x7ImwyZKwsNj5lW6NBke5d4EWEKoeKSJwYTy/Cc0GXVrPyUeIMDqJnaKin
         LKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHE/v4+uK+hhFNGRiRI8Oa2ab1RUtvMhDGA3+YRGHLE=;
        b=DVLNyIjSpMbr/W2aCsrnfO6ja5nGcsfqxuqi6Iaeeni647YmoiY7DuF38jonbrZYVl
         f8qAQoGlb0Nt5wIQYLByOhs+RX+5gCuP0jpQPUqp/5SNt2J9+P3p1QihzhIbfypGuyCk
         3O9W7/Yu1rWwlpHIGdtXex0I4ZNdWuVn+zKXyAb52DgzWohST/p81RspawQt2VOlErhd
         wBHEP/zneWwtPcztuvvDw4N6EigSpJd3AGSrm44O3F7k3ZZ85rsMI32MGm0r1MBbf/wZ
         qciMPMG1yPKzywCmWduC9UiUUv0qQC7Khp7Ph+HM02aqYOeqjXG4qC8QJq/p9NdAs2Tt
         +FbA==
X-Gm-Message-State: AFqh2kpLZp6aSulpbvdGIZP0RZomWdruqHqHEuBb0NTVZ+bnvnhg+Fjo
        0FssIXd35dGXbQ1HWgNcD2rpug==
X-Google-Smtp-Source: AMrXdXs86RTSb1BFxvzXGXbl+Vq7UDVuLIdG2zrOo+T+L1NzXhmxLcw2L4lqgDYVAam/LHTAn+iGUw==
X-Received: by 2002:a7b:c309:0:b0:3d9:f801:bb6 with SMTP id k9-20020a7bc309000000b003d9f8010bb6mr3201564wmj.10.1673965229777;
        Tue, 17 Jan 2023 06:20:29 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600c354800b003cf894dbc4fsm40443133wmq.25.2023.01.17.06.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 06:20:29 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v4 0/6] phy: qualcomm: Add UFS support for SM8550
Date:   Tue, 17 Jan 2023 16:20:09 +0200
Message-Id: <20230117142015.509675-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The v3 of this patchset is:
https://lore.kernel.org/all/20230117125555.163087-1-abel.vesa@linaro.org/

Changes since v3:
 * correctly ordered the compatible in schema file

Abel Vesa (6):
  dt-bindings: phy: Add QMP UFS PHY comptible for SM8550
  phy: qcom-qmp: qserdes-com: Add v6 register offsets
  phy: qcom-qmp: qserdes-txrx: Add v6 register offsets
  phy: qcom-qmp: qserdes-txrx-ufs: Add v6 register offsets
  phy: qcom-qmp: pcs-ufs: Add v6 register offsets
  phy: qcom-qmp-ufs: Add SM8550 support

 .../phy/qcom,sc8280xp-qmp-ufs-phy.yaml        |  1 +
 .../phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h    | 31 ++++++
 .../qualcomm/phy-qcom-qmp-qserdes-com-v6.h    | 82 +++++++++++++++
 .../phy-qcom-qmp-qserdes-txrx-ufs-v6.h        | 30 ++++++
 .../qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h   | 77 +++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 99 +++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |  3 +
 7 files changed, 323 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h

-- 
2.34.1

