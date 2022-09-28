Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BC55EDA2F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiI1Kfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbiI1KfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:35:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADA82034A;
        Wed, 28 Sep 2022 03:35:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r6so1798487wru.8;
        Wed, 28 Sep 2022 03:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=2EKFXqMd/jHYrZWo2upnC6kyYWp51DY/ODXj5PBookc=;
        b=qj7fqkQnHaGTVP03hnkdR8iYZaPBDLAzvlIlw7/7TeIj5tNlUhKxU5A6vnOVbwHiGp
         8Op7PLXHtJoNqzSltyuYp/DNOqo/fJO1DaSgG2LFP0M8VsKU2RQLOiTsXFlwswO6MSLj
         NRk+I+QC8lyJXJ5p5t8TVb7vqQtTKUhy+Lea9bE1fyuAmrtyxdcpDuTjT6socBUb0Ocl
         8ZjptnrX2T282n1yV+Nv7l/Hkl9r4YV4MEA0VUFNqN3nZHaG0OmvOFGLde4lJX9bdE74
         3m4I30Fe9dBDzYVWPTpF2D8hoCtgRrvHTbE5ZK4Plkw6x+H4sgopZJok2ZJ+oHoPGj3H
         78yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=2EKFXqMd/jHYrZWo2upnC6kyYWp51DY/ODXj5PBookc=;
        b=i8ck0eAkxqt16mPMG7t7xX3YBnUF/B9iuZweA1OJ46ywQMl48R6sfwX8Cd+Sd5/ej+
         VGkrq/8+9VJ8yY1eO9IN5QR1THLyMyaLiy33LLhx6XbSmuLcuC9x4BiwkcRogTctrEC8
         OdP156wRI8Ds47jqIebs4po02E8vloiDAv4Q7Y83uY7DkahHbXqkNu8CJJ2W/XPFraWJ
         KAZS2V5L59O+9RJnj+5FfSLSfMM1bWrXAeXKDv4GJJekiLT0ORkUv6cFNo1GNs+d4JmX
         0514CwqNu2wFSwLtcr/6qsPPoRnuhemmuwLQ5fYHnpopLu/TkL9M8NeujrH57oEYkXKc
         M+ZA==
X-Gm-Message-State: ACrzQf3GeBnU1QFMoEFA0mnbrldRYkAtaOjNVFnlki/uuNS9nRMatsnR
        d58YVUy45iMzabL+8DhDJyMQJZcg+cs=
X-Google-Smtp-Source: AMsMyM7jFkYdRoHbkp2MTZkCad9Y6lvBQOInAB5gp1QwQp4ptKebVAZUdSwuEHGb0ysAUvERbP0Gpg==
X-Received: by 2002:adf:f743:0:b0:22c:c939:bcc with SMTP id z3-20020adff743000000b0022cc9390bccmr1307843wrp.95.1664361310531;
        Wed, 28 Sep 2022 03:35:10 -0700 (PDT)
Received: from localhost.localdomain ([46.216.9.29])
        by smtp.googlemail.com with ESMTPSA id x4-20020adfdcc4000000b0022b11a27e39sm3974476wrm.1.2022.09.28.03.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 03:35:10 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] add device Xiaomi Mi 6 sagit and board binding
Date:   Wed, 28 Sep 2022 13:33:17 +0300
Message-Id: <20220928103319.621698-1-dsankouski@gmail.com>
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

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
To: linux-kernel@vger.kernel.org
CC: Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
CC: Bjorn Andersson <bjorn.andersson@linaro.org> (maintainer:ARM/QUALCOMM SUPPORT)
CC: Konrad Dybcio <konrad.dybcio@somainline.org> (reviewer:ARM/QUALCOMM SUPPORT)
CC: Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
CC: linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
CC: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)

Dzmitry Sankouski (2):
  arm64: dts: qcom: sagit: add initial device tree for sagit
  dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip

 .../devicetree/bindings/arm/qcom.yaml         |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8998-xiaomi-sagit.dts    | 682 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8998.dtsi          |   6 +
 4 files changed, 691 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts

-- 
2.30.2

