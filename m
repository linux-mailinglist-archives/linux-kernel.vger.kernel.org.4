Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBB45BBA98
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 23:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiIQVJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 17:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIQVJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 17:09:30 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B949018F;
        Sat, 17 Sep 2022 14:09:27 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z191so20127698iof.10;
        Sat, 17 Sep 2022 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=BLLRyXQzjk3cHhUtOeo6hoECfEc8gJl/wU/cfBvCwHc=;
        b=DwP55UR6ZPr2sDVyNTcQTnkQVjAPLmm+DVlLFgxmuY7h5B7qngwo+7r6MN46Pjb68p
         HepN4ytNAtivg36ZSd1jkMZhexr2Vetrc6N8n1L6XAjHBpsuY1lplm4Zcu+KdAYszuvM
         xezKdZzvBuuYlZkC/XvJBBicJ5c6s5wNN/d8I2DB9wmd4tQ/dFXxoFJCMt4ASneJY2D4
         kaBXg8HXOuZdf8JnfNKuz/vawGFWFSIVknG1hbNPg3wwv291NlKggU1pwAdHgOf3F31G
         IJ+ICJuy4+0S0EUaCZc8hpOYlo+/btHCDSu21WzqSUtYe4opLkHulPe0ymrIx43CFu7N
         MB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=BLLRyXQzjk3cHhUtOeo6hoECfEc8gJl/wU/cfBvCwHc=;
        b=74u5j/v+VEpnZTn0y5Z/rfQeDhfemG2JHrNwPP6nc06LwA+mYwq8acVFwMB1AtlaXD
         BphI2+Ah3zznWiAr2dcmloBQjG6bFS5eGvkSKvzSu5rgWrzX9mR+bOFkGui4DoL0ul0s
         KwZFkcnpj3gvEDLv9XN6wx+kGKukh49CN1TwvgqijPec+KmoQw8r8j+XcrdQ/I8HnoGj
         H9ykTwVyOAAB6dTLuGyN9nFJegDIUXU2a8oU7DsOduqvwYFCR4gY1IHcm+83ZsB6cEsO
         QjJ7TGB4Ni7+md5Ztdv/60aDEpJVH7HBXd11GBbPVeHpoMWjBIFBeO14dzgkDKWW0YSy
         aYLA==
X-Gm-Message-State: ACrzQf1m2euhUeaYnhzljG+YMLbYIOGQ10XWe83Dnp5zUjwdp79jIrRy
        a8BPwnAsCHlZ1eE9AY4U/qAjM6oFBQk=
X-Google-Smtp-Source: AMsMyM4numtaK7EEr4npH8kp/z8f+HW6g6df+oVMgsB4etqRG9b5mq401rABX+RrQSH7a7yJ+XxRqQ==
X-Received: by 2002:a05:6638:2402:b0:35a:1e83:e43b with SMTP id z2-20020a056638240200b0035a1e83e43bmr5170474jat.146.1663448966946;
        Sat, 17 Sep 2022 14:09:26 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::2542])
        by smtp.gmail.com with UTF8SMTPSA id g131-20020a025b89000000b00359ae384ffbsm3737713jab.19.2022.09.17.14.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 14:09:26 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 0/3] SDM670 Pin Control Driver
Date:   Sat, 17 Sep 2022 17:09:12 -0400
Message-Id: <20220917210915.194840-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Changes since v1:
 - add a field in msm_pinctrl_soc_data to accomodate the needs of the
   driver and device dts
 - apply changes made to existing tlmm dt documentation
 - add reserved gpios array
 - rename device tree compat string to qcom,sdm670-tlmm
 - remove dependency on ACPI
 - move MODULE_DEVICE_TABLE macro call up
 - add missing pins (fixes most of the debugfs problems)
 - move qup0_pins down
 - add whitespace between UFS_RESET macro and pins array

This patch series adds the driver for the Qualcomm Snapdragon 670 TLMM
(Top-Level Mode Multiplexer) and introduces a new field so that SDM670-
related device trees can reserve their own gpios.

 .../bindings/pinctrl/qcom,sdm670-tlmm.yaml         |  135 ++
 drivers/pinctrl/qcom/Kconfig                       |    9 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-msm.c                 |    3 +-
 drivers/pinctrl/qcom/pinctrl-msm.h                 |    4 +
 drivers/pinctrl/qcom/pinctrl-sdm670.c              | 1374 ++++++++++++++++++++
 6 files changed, 1525 insertions(+), 1 deletion(-)


