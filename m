Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDE95F599B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiJESPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiJESPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:15:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599AC3F1F5;
        Wed,  5 Oct 2022 11:15:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bk15so27112722wrb.13;
        Wed, 05 Oct 2022 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=rnL+He7Da96VSkLj6A5rMl8m0utiApVsa5fPZkDJuiw=;
        b=jpuPaxVmWU2hTX1DSf9a0qTxSJkwgHxV18f9Nt6qCnt1NVcivoElCuWfD7qDBSeS0V
         ucGy9rs/b+La54Su9wAHf8cEEWcy5WkWroG834kqF16qIGxYCs5wzmiHKVLekY3Y8mIF
         r9OgZMctieJyP1/4M6KAYb3fu1HlRUhxICklK4U7gJc6ZKHVVMTJwNn0ntURNVgcEekx
         7D4f2BucH1pDqoacYNs84UXRTqSAB3ZCIpK/00Wj6UdT+v6+e7zHxE9B77g5ZazBq0wL
         okwiuaUO/PkKYZfIIVwviaoTBzZShTGRZQnhZMwLGqUZGB6rI4ksAmYt9Y/c0HRMZJR+
         qBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=rnL+He7Da96VSkLj6A5rMl8m0utiApVsa5fPZkDJuiw=;
        b=Csap8CLkVm+tzTHlncmyqjHklzUGEsh34OelteSHjDLsAvtQ1F8Gt8M9eJkKhglqqV
         jYnrfuK7Ypte4rOSAzEuoTn3eb3dCIFG0NnLoUWZFAeWs3RZULnQinb8miNQL0pYbFti
         OiBByUTnn2ifGgZAXVMt8ZWO0b2RB4KJejaYMTZW0QbctORNss+EuMyd5eueukauQQ3/
         doCBAAru8gICfnUj+PsK/26xtCfC54yYxJFetmyR+ixU+seOgx7eXwgMLhN5ARl2m2SO
         Oy5skV1vtSX/RGayzgB3XKywmSvKrIOcy9s6mrTJzMjwHdkLvAefgYW+WzV0znD3xXeC
         BDjQ==
X-Gm-Message-State: ACrzQf1/es5JmG8wDL0nxLkVpCi7ziza6LaXQQ0vvM04X+W9dCI0jO+w
        GN+93rvzTVjfo+RQzQe6A1aay3gDIRc=
X-Google-Smtp-Source: AMsMyM7maW1J0vNKWga6/unb3T6JQYwDC2OtpjW+8nCO6rojgO6oco21wKnqls7aXtlXyhV7q9fyJg==
X-Received: by 2002:adf:f0c1:0:b0:22e:3f43:a5f5 with SMTP id x1-20020adff0c1000000b0022e3f43a5f5mr637561wro.15.1664993741641;
        Wed, 05 Oct 2022 11:15:41 -0700 (PDT)
Received: from localhost.localdomain ([46.216.9.29])
        by smtp.googlemail.com with ESMTPSA id g20-20020a05600c4ed400b003b4ac05a8a4sm4176240wmq.27.2022.10.05.11.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 11:15:41 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v6 0/2] add device Xiaomi Mi 6 (codename sagit) and board binding
Date:   Wed,  5 Oct 2022 21:15:26 +0300
Message-Id: <20221005181528.1038629-1-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for Xiaomi Mi 6 phone (codename sagit)

Dzmitry Sankouski (2):
  dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip
  arm64: dts: qcom: sagit: add initial device tree for sagit

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8998-xiaomi-sagit.dts    | 681 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8998.dtsi          |   8 +
 4 files changed, 691 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts

-- 
2.30.2

