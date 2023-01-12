Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC5D6672E2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjALNGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjALNF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:05:58 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3464813E02
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:05:52 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id u19so44532536ejm.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0IszrXcLbv1C0ufOCUrkZd80J905kQzALamm/CPBXfM=;
        b=xlQfeN7xC3TRUc5W1wnqMmOH5bhEryi+j7MuZXvP4NYK/TnRAPocLfCRZXInvZWFax
         j2aQVVtgc6pg/uS4umUG9NHrI70MQ9nlwCBSdckRkQFGoxzIWLZASZhHZ7p+othw1yHF
         eHlDiWlTorZfj3TUaSDPROoYECZ++AJ/hZaW8nCEmLc1mcPKtKwDX2Ic4d86gw+Y1Q0u
         QZME5eeztGxr31yUGxwJR/Kdbyl5+r0LcE9rSyRBlZuQg6PmuvwL2cTEX0iJIVgRDAmE
         UevHO6G74oKqN2zZUXYNQOR1PQ+/42Lmj0uBdNsFdg/lbBQkAAqHvZtxEschn1VXQXJd
         a7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0IszrXcLbv1C0ufOCUrkZd80J905kQzALamm/CPBXfM=;
        b=Ij7d6WLIEwam0Qj56OcrIXS0rRPk4aEsFTVTdf3Aak2NZi1xGolNwTd+7DMpWhgye5
         jx3bhi7yylXX6u6ZXcg0jc8Ir95R7BJesdVPKJ77W//ptubFAB4ETcoRMYxHpZ/poBso
         4KVkTQC3QhD73Dw280MFdONgH7TcmgoaDdzAfCy1ujttlro1thAVGUjvBrveBK3NluVT
         hWuP+BuZrRLKd4F1eHgw/jkWawxSkW1xkeY6uOjLjCqlIt5BdkPuKzl9dTDuwSj6FcrV
         MWUGrv+j+dUvrBsUwcI/qSdLEGss6ki+yrs/g8NBP+d1CPfGpmVvVg2ryBhAq/b25dJN
         XeGA==
X-Gm-Message-State: AFqh2kp6k5n8JCc+FIti6um7LkDi6XZ4Z7Mcg5SehFXRzPZlwKjKQpEc
        uSo0df4VSCQjp3+t0FdjnPBN8A==
X-Google-Smtp-Source: AMrXdXsF3pTGMimbHjkVQwICvApD/N1OZJva+QH5LWTUFwBg/7Pk3pS6B1jaWQYBxxtq/ond66wyeA==
X-Received: by 2002:a17:906:33d0:b0:854:6e3:2388 with SMTP id w16-20020a17090633d000b0085406e32388mr9818022eja.12.1673528750749;
        Thu, 12 Jan 2023 05:05:50 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906318b00b0078d3f96d293sm7427668ejy.30.2023.01.12.05.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 05:05:50 -0800 (PST)
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] phy: qualcomm: Add UFS support for SM8550
Date:   Thu, 12 Jan 2023 15:05:36 +0200
Message-Id: <20230112130542.1399921-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset relies on the following two patchsets:
https://lore.kernel.org/all/20221123104443.3415267-1-dmitry.baryshkov@linaro.org/
https://lore.kernel.org/all/20221222141001.54849-2-manivannan.sadhasivam@linaro.org/

The v1 of this patchset is:
https://lore.kernel.org/all/20221116120157.2706810-1-abel.vesa@linaro.org/

Changes since v1:
 * dropped all UFS unrelated patches and also register offsets
 * switched to sc8280xp bindings, like Johan's suggested.

Abel Vesa (6):
  dt-bindings: phy: Add QMP UFS PHY comptible for SM8550
  phy: qcom-qmp: qserdes-com: Add v6 register offsets
  phy: qcom-qmp: qserdes-txrx: Add v6 register offsets
  phy: qcom-qmp: qserdes-txrx-ufs: Add v6 register offsets
  phy: qcom-qmp: pcs-ufs: Add v6 register offsets
  phy: qcom-qmp-ufs: Add SM8550 support

 .../phy/qcom,sc8280xp-qmp-ufs-phy.yaml        |   1 +
 .../phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h    |  31 ++++++
 .../qualcomm/phy-qcom-qmp-qserdes-com-v6.h    |  82 ++++++++++++++
 .../phy-qcom-qmp-qserdes-txrx-ufs-v6.h        |  30 ++++++
 .../qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h   |  77 ++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 100 ++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |   6 ++
 7 files changed, 327 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h

-- 
2.34.1

