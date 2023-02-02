Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC8C687E8E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjBBNZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjBBNZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:25:17 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85D28C1F6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 05:25:15 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso3743583wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 05:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kW5GxFMKVLm3HHfRK3v8PPMjbddlT4O3IPT99HE/Mdc=;
        b=CBIqXA7Kgxrf8BHQf5K/34k0csj53P975JOjOt0SDNjojgK3zm6MlxAIjprO/6JQvh
         18ArNoWT+GZTk5CWBXr7gaoehYMyWpAN0Vc/lcTpGf+Ym/Zf08hyaPA93XYZvPfNiLxF
         eJHMcGk2sqvgYFBmj3+JK7huj4YSiuhvnz/W7jvyimf/eAtstRhhMdNHJU4QW7QEaksR
         e1imYZm9BoUYw/2YPiRdB6/+kqZCuCzf/OaNKZlGwUpW4V+QLH1S2+lbppyAWOuDtx7x
         6qJM9SZmaLkA8Y2jcYwDsJzZVfJHYOG4sdTDuvDHAHW8PHq+6jaud66JtGDUGfp72i0z
         ur+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kW5GxFMKVLm3HHfRK3v8PPMjbddlT4O3IPT99HE/Mdc=;
        b=lbiKShsv7QFyGdHwnjroazwRcFA5Xx6TY1yR/T9jWIpB1obfJWbG9hPUaSS4WwhH0I
         CLTSn+vAE+DbKC390dljXZdUOSwb9xxvuCsvGfV4Ijjxd4f+sthch/XzrTxLaVLfee6p
         YJFc5Bh4hK2GgdkLQJsKqFPoovb5TxXPUQmHtTI8IeCi0rLgUZh7McAXV3cYXy7NbUFD
         zp63MXyEo+vnHgTE4AcD+4mqHmns7AuZcAizbIRmBkL14XBIEyylBrYJN58ls7+bnbBC
         svNhokfVdNpX28vKvmPL8eZ9eOElNFyqlgNHz/1HPIC8eouNdI329GzeZlWX7rhjihHl
         +Itg==
X-Gm-Message-State: AO0yUKVWOMad6JVyXuoBSx2ubT00fMYI11tri04liHCtV/evlLuvfXWf
        92P6/GZ+hqPUBOLe76k4mzvTeQ==
X-Google-Smtp-Source: AK7set/umYm3AxRIMiTJLCmzwgUPXHfzHXF9tHlRDDK11lrloBCjQJgDoa+gvL7INbbSCP7tQZIbCA==
X-Received: by 2002:a05:600c:b8e:b0:3da:fa42:bbf2 with SMTP id fl14-20020a05600c0b8e00b003dafa42bbf2mr6088694wmb.28.1675344314431;
        Thu, 02 Feb 2023 05:25:14 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id e22-20020a05600c449600b003db06224953sm4690943wmo.41.2023.02.02.05.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 05:25:13 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/8] sm8550: Add USB HC and PHYs support
Date:   Thu,  2 Feb 2023 15:25:03 +0200
Message-Id: <20230202132511.3983095-1-abel.vesa@linaro.org>
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

This patchset adds support for USB for Qualcomm SM8550 platform.

This patchset is based on top of the following patchset:
https://lore.kernel.org/all/20230202123902.3831491-1-abel.vesa@linaro.org/

Abel Vesa (8):
  dt-bindings: phy: Add qcom,snps-eusb2-phy schema file
  phy: qcom: Add QCOM SNPS eUSB2 driver
  dt-bindings: phy: qcom,qmp-usb: Document SM8550 compatible
  phy: qcom-qmp: pcs-usb: Add v6 register offsets
  phy: qcom-qmp: Add v6 DP register offsets
  phy: qcom-qmp-combo: Add support for SM8550
  arm64: dts: qcom: sm8550: Add USB PHYs and controller nodes
  arm64: dts: qcom: sm8550-mtp: Add USB PHYs and HC nodes

 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    |   1 +
 .../bindings/phy/qcom,snps-eusb2-phy.yaml     |  74 +++
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts       |  22 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |  92 +++-
 drivers/phy/qualcomm/Kconfig                  |   9 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 410 ++++++++++++++++-
 .../phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h    |  31 ++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |   4 +
 drivers/phy/qualcomm/phy-qcom-snps-eusb2.c    | 423 ++++++++++++++++++
 10 files changed, 1061 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-snps-eusb2.c

-- 
2.34.1

