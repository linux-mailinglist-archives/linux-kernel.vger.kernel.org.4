Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A9560B656
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiJXSzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiJXSy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:54:26 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7DA155D92;
        Mon, 24 Oct 2022 10:35:48 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y14so6661672ejd.9;
        Mon, 24 Oct 2022 10:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rnL+He7Da96VSkLj6A5rMl8m0utiApVsa5fPZkDJuiw=;
        b=PWMAzyQCBjOkiF0KARAICjx/FkhFzywfmEco9vOnkNvA/a7mXmtIe/9yWQUdDPngEo
         bmXKIIcUldyzzf2lop+T9gbUjSpXA2ABfc7Y9k64gaG4H/UPT+qQTRd95+8CfKnp9MZV
         PgWz4qgoEMQTXcQU4PFPXYe1y8PW+OJ2RQPTpLpvH4Zk1lf+pPYttgOzJa3OelPkVQpo
         xH4PQ7lwqQfhtYGb7bWeb3PiAhnCqElTzL8O7Hves0uVqF1sQ01ZdmjJJ39bli9dLZBK
         epw5hg/AqUmJikXRC7QOvbCfTVPyLx+7KyJZop+1PKBgymniuC/tZVA/Eho8kBS+QWJ2
         jPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnL+He7Da96VSkLj6A5rMl8m0utiApVsa5fPZkDJuiw=;
        b=KT+SWMWce0XlE+2Pg/uSo9I2ucGmy8KB6k21Fo5qPgCWroRYzzKY/2JQhPOegvpqna
         dOYtW4Zjl6176tTo38kjvJP6JygBGKJRT5giWCp4qOoFs7TwTjCIft9Ju0nil7MWvsGD
         D4iwXU3cT3zcIB5fZibQ5tHzClsDqGw6pa2PVPVi561Fwz1v7qcsKfTmqb7h8H/z7CYZ
         LVAI5M9goMqO6n/XX9mwnossflYwOOHpcxdNEhcKyyEIjJ/aIGWQO2OvmmzAQ1MMLiXZ
         XOPKYeyA8xkctIBcfj6u9oaeXTDAJgVozOtJWUme8H+Ma+Nos1pki15kMFYC9lP9bPF7
         Jkdg==
X-Gm-Message-State: ACrzQf15BF6ux6iyo/zQNDdg7IU2C8ynBovIbiUYJfrBr3PdsE5GYbyR
        lpSynEojwHuNPToYdHsoEuqY1wnW/cE=
X-Google-Smtp-Source: AMsMyM7BB8skGM4KFCTRzz1V3aGh49EYx7q0lPqOzxoD4nOHm8bxrJ5aBJykYDHasSPKxEyojOZHsQ==
X-Received: by 2002:a17:906:5daa:b0:791:8933:f9f0 with SMTP id n10-20020a1709065daa00b007918933f9f0mr28244284ejv.335.1666632859671;
        Mon, 24 Oct 2022 10:34:19 -0700 (PDT)
Received: from localhost.localdomain ([46.216.4.225])
        by smtp.googlemail.com with ESMTPSA id z11-20020a17090655cb00b0078b03d57fa7sm188861ejp.34.2022.10.24.10.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 10:34:19 -0700 (PDT)
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
Subject: [PATCH v10 0/2] add device Xiaomi Mi 6 (codename sagit) and board binding
Date:   Mon, 24 Oct 2022 20:34:07 +0300
Message-Id: <20221024173409.1649376-1-dsankouski@gmail.com>
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

