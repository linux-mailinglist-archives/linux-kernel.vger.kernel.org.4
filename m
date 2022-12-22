Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566786541E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbiLVNbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiLVNbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:31:40 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9F65FC1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:31:39 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id c7so1211571pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M9AOTspnzS63f7kZcAgxpIv7jWjlVbIrVgKjR+w8Mgo=;
        b=Rfi5VqDGO9usqpGX1sY3c7nqjL+S9mczwYS9pRIdnTVKkaaTBNRojQ1yfLvk+rcNi8
         R+8J+mG5ZSGH9dGMh/0JZ3a6X7Fz4L5VE6nt/3W+jiPW7vNx1LlP42jwa2v841u/fQ8l
         P4swMhu0RI9yZqZlPZADMWMXU6GGEfQIb5re4i0F2N5VaHnmh8f+OwM6nsnt8FnXhcad
         hFx6kO95zEpMJAZeBhbTpbA5qQDrYX69viO959PvGm5w6xvWuckMdD5HJ+50w8mAuQds
         TZi1SA3XUoWLcJLvRVu+W7EJP0fy9WHeUWWVhv978tMDShwhc0El0NyO7hwIsvS4Gxtv
         UVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9AOTspnzS63f7kZcAgxpIv7jWjlVbIrVgKjR+w8Mgo=;
        b=rZ01juCunwoNC1lAPUlu4UBdBiqK7eMdso2NcIbYeLweFUDwwWz4widqlRAKsg6OQ3
         qA93a22EADdbJbCCuK2E2HBA1+ZcTUSu9kvebp4TH/2WWcMilHCVH5Bu+GPXDYyTJnj9
         v6qYAadpvDWPpPsaKy/BdgHrt5ndz3J4qrSRbTQDH2GI707u7LkeB00cV9wcHZRdVysZ
         Mp/GEi85kcZx8fLDMdG0nicdi389H7sKfCe4mAVpQ3ye/r9ZL7LZYX4e8YQ0AqW8MhIf
         qTh3Ciueev6yRAlQczpXfH3kWYa9793Dbd7V7S3yHssglOHWVEj2Ljj2UMFIFY6bQXwy
         sBnw==
X-Gm-Message-State: AFqh2koHuDjafCxKl1fK0RE+e05SRHJOaGD/UydQu6O6oi2WiJpWIM2p
        kJPk4chcATpaRa4LCw/5FSCN
X-Google-Smtp-Source: AMrXdXuMUb9imbzsYfTE5En5nuHtn/TmzHDACIlyvsGN0hE5lVGaisW6wgzm2Fyqg9E+Iq7B7w4ISg==
X-Received: by 2002:a62:1855:0:b0:577:213e:8cab with SMTP id 82-20020a621855000000b00577213e8cabmr6209285pfy.16.1671715898726;
        Thu, 22 Dec 2022 05:31:38 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.99])
        by smtp.gmail.com with ESMTPSA id f66-20020a623845000000b00573a9d13e9esm737467pfa.36.2022.12.22.05.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 05:31:37 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bhelgaas@google.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/3] Qcom: Add GIC-ITS support to SM8450 PCIe controllers
Date:   Thu, 22 Dec 2022 19:01:20 +0530
Message-Id: <20221222133123.50676-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Hello,

This series adds GIC-ITS support to SM8450 PCIe controllers for receiving
the MSIs from endpoint devices.

The GIC-ITS MSI implementation provides an advantage over internal MSI
implementation using Locality-specific Peripheral Interrupts (LPI) that
would allow MSIs to be targeted for each CPU core.

This series has been tested on SM8450 based dev board that works using an
out-of-tree dts where the MSIs from endpoint devices are distributed across
the CPU cores.

Thanks,
Mani

Changes in v2:

* Swapped the Device ID for PCIe0 as it causes same issue as PCIe1
* Removed the definition of msi-map and msi-map-mask from binding
* Added Ack from Krzysztof

Manivannan Sadhasivam (3):
  dt-bindings: PCI: qcom: Update maintainers
  dt-bindings: PCI: qcom: Document msi-map and msi-map-mask properties
  arm64: dts: qcom: sm8450: Use GIC-ITS for PCIe0 and PCIe1

 .../devicetree/bindings/pci/qcom,pcie.yaml    | 14 +++++++++----
 arch/arm64/boot/dts/qcom/sm8450.dtsi          | 20 +++++++++++++------
 2 files changed, 24 insertions(+), 10 deletions(-)

-- 
2.25.1

