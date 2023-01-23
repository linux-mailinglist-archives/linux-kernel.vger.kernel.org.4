Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95294677C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjAWNa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjAWNaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:30:25 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398D222A10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:30:24 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id az20so30528680ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GNbLj/XmOS18lcQ6X8VOqWOavPYN+fm3m3tQOx//CQY=;
        b=y1I2hXpHlXyGKsjZYDgisHlHbdrEFWMrdHw+LbJUg2u9PZkEeKin8vq7vzHQ5KTcRw
         AwLhJQZ2Ld5yppC0c3LhRYB1CaJibzMyuDPe93tQfyVIJnK4HQ5ZeYlsHQqPFxA4+8pZ
         IYgvWu3JrRyj4qZwRXWyZeV19HzqrLgp8m3t06I1/szGtrp4wxVcdU5ljdVuvUP6n0mm
         pnZr+lzBGgT0nEcV9UekpHf6E4BRgHKjiyMXfZ4RLEvpuIw4/Xkjw1fhs33y0jSyAzTm
         qcBRVahxjqq+IRiVe/abu+UHvm/ar293kZjtI2z8KrJnL6WnV0fzUHCPPyDN5T1S/9Wh
         hXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNbLj/XmOS18lcQ6X8VOqWOavPYN+fm3m3tQOx//CQY=;
        b=JwtIeHXs7ghvsjt3AbjSjL8pjOT63/1ObBBtBgfgIWMcAZIZgBV6YdvjwbYIxeFNcy
         yIYQQgBKL+ZEcoeDw3ZwbeSqH8jd529EeiEdmJNm2bzwRIHl+9h4AEJ5STerZMlz3NeC
         JUcreiK76MV1TD0qGtrZEOPAUTXEmfq6r1tULNBCH34BhHD9JeXATh1yw1oqI4ptd39g
         54brTQIXQw/3LWtu+X1S1YuPaEp8XcCcNJhrrU/n3WMyK8TvRVuVC9NCTgN0bjf6AG5T
         iKpEjPkpdqkV/w64pTUrfFjE+r8fLwF143meU6tJLLLyd3qnyV2/nxFGzXEPDF/gilSB
         cFGw==
X-Gm-Message-State: AFqh2krVwRY6ZqAU+cYtDqrmr9rsQ55rK9wNnwqxUaAC2+aR2xgR01GR
        k/egxAR9gVt6g7xC+RheHupSjQ==
X-Google-Smtp-Source: AMrXdXsO2W7vTKmldyNi2VluWAXyWgl/FTLpjx5ljjPpjsV580GO1FHx9OHRarQY2voFWBfv9iIenA==
X-Received: by 2002:a17:906:5417:b0:877:5dbc:da84 with SMTP id q23-20020a170906541700b008775dbcda84mr19849609ejo.72.1674480622737;
        Mon, 23 Jan 2023 05:30:22 -0800 (PST)
Received: from [172.16.220.87] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id s5-20020a170906c30500b008552bc8399dsm18410066ejz.172.2023.01.23.05.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 05:30:22 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v4 0/3] Add USB/DP combo PHY config for SM6350
Date:   Mon, 23 Jan 2023 14:29:48 +0100
Message-Id: <20230120-sm6350-usbphy-v4-0-4d700a90ba16@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMyLzmMC/zWNywrDIBBFf6W47oRR85Cu+h+lC2PHKiQanKYPQ
 v69UujyXDjnboKpRGJxOmyi0DNyzKlCezwIF2y6E8RbZaFQaZQKgededwgrj0v4gBlcR9qjkoZ
 EdUbLBGOxyYVqpXWa6rgU8vH9O7lcK/uSZ3iEQvafVlJqRCNbjU0/GC1BwrQ627woMp+9jWUJO
 VHj8iz2/QtItfVgtgAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

While this patchset started out as just adding a dedicated init sequence
for SM6350 since USB PHY init didn't work in some cases, now it's also
migrating the phy config and dts over to a new format.

Also note, that the DP portions are pratically untested since TCPM
(type-C port manager) and possibly other components aren't brought up
yet.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v4:
- Fix dp_serdes offsets in driver, add dp_txa & dp_txb fields (as in v2)
- Fix order of resets in dtsi
- Link to v3: https://lore.kernel.org/r/20221130081430.67831-1-luca.weiss@fairphone.com

---
Luca Weiss (3):
      dt-bindings: phy: qcom,qmp-usb3-dp: Add sm6350 compatible
      phy: qcom-qmp-combo: Add config for SM6350
      arm64: dts: qcom: sm6350: Use specific qmpphy compatible

 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         |   1 +
 arch/arm64/boot/dts/qcom/sm6350.dtsi               |  54 +++-----
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 139 ++++++++++++++++++++-
 3 files changed, 154 insertions(+), 40 deletions(-)
---
base-commit: d514392f17fd4d386cfadde7f849d97db4ca1fb0
change-id: 20230120-sm6350-usbphy-87c5e3f0218e

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

