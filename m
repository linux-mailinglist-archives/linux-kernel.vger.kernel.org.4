Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA7F5BD9EC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 04:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiITCQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 22:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiITCQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 22:16:44 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AF036DC1;
        Mon, 19 Sep 2022 19:16:42 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id a14so696435ild.0;
        Mon, 19 Sep 2022 19:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=uhElhL1iGj7D7c7p5uNqiCIgPSuLaW+aX2botzGI+o8=;
        b=qSl4iV/SedCK1cwzqsQNrcyK8zslOHREIr/BTbO0Sz+kFmmyTNjHEkBLX5et8IMnot
         o0oqJGOgLTewou5Wwf92oR3jq2Vjd/9mwEL/UUI7XJpmR81ttjqe3K6qXPNqpf9/co8X
         Qz+VSYw+Z7vpAkdXgQzmjcQaC/oJWtqx6inQetLYKH+gYFZMsl2srf6ejT+jtd12IsrB
         hoIuIVEBYaYf6e/s6WDcBIAVi5SSa1okcpxCY0yZULHbpsF6sLbiKEZ5D6OdbjlNKe0i
         meIGzRRp8WTvo/mEmB++NngoLF3tE9Pu08yQ/fMbuBYvKQ+yfwTtAtwWWAg/ZzdFm1t9
         jOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=uhElhL1iGj7D7c7p5uNqiCIgPSuLaW+aX2botzGI+o8=;
        b=mr21tiOUGd6DX2WjzpU9WFXHdXUP7/hJ5DqsZKucGwE/XrI79PD04AshV1qX8hwrW+
         ro9HoHoj+IAHdJkGTm58FHph68PXlAOUf371ae8xkVi5dAosAjPsnQzUK9PhOfRvrp+G
         k+r6ZLdMLcwxQGySCVrlOQfbxhCUmi6c7UdHokfV3Y5FszLtYwklpBzu2PRmA+rOE9jO
         Q5XenALwiansa4Grier7md4VLReenHxdkIPsCTy6mZkK6gW5ZJ/1Jx1zrzlHkcOKHuvM
         SVcWL8ccUp5d2CkbMqiisEWS5Ib4Sy3BS1kLHYLD8NGMpkL7Qy2roereYMMQUb+JuQYV
         vIOA==
X-Gm-Message-State: ACrzQf1NZnKkuRchjYuGjMPGo8Xgrn1FT/FGERiUFwLUfV13STuOhukB
        oSQo5Yk83SixkHa1MaZB/IlXLu+rnfg=
X-Google-Smtp-Source: AMsMyM5Srq6rEgrYm95RYIywOZiVe+PuBXT6IJMOcybpBatQjWV+Uni0nYNdj/+0HISlbHEsSzc6iQ==
X-Received: by 2002:a05:6e02:b4c:b0:2f1:e54d:9870 with SMTP id f12-20020a056e020b4c00b002f1e54d9870mr8544867ilu.214.1663640201733;
        Mon, 19 Sep 2022 19:16:41 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::58d4])
        by smtp.gmail.com with UTF8SMTPSA id j184-20020a0263c1000000b00346a98b0a76sm141422jac.77.2022.09.19.19.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 19:16:41 -0700 (PDT)
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
Subject: [PATCH v3 0/3] SDM670 Pin Control Driver
Date:   Mon, 19 Sep 2022 22:16:33 -0400
Message-Id: <20220920021636.1634-1-mailingradian@gmail.com>
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

Changes since v2:
 - remove quotes from pinctrl.yaml# in dt-bindings
 - constrain gpio-reserved-ranges to 1-76 items (includes ufs_reset)
 - indentation in dt-bindings example
 - cite downstream kernel source
 - remove MODULE_AUTHOR (most imported pinctrl drivers don't have this)

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

 .../bindings/pinctrl/qcom,sdm670-tlmm.yaml         |  138 ++
 drivers/pinctrl/qcom/Kconfig                       |    9 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-msm.c                 |    3 +-
 drivers/pinctrl/qcom/pinctrl-msm.h                 |    4 +
 drivers/pinctrl/qcom/pinctrl-sdm670.c              | 1373 ++++++++++++++++++++
 6 files changed, 1527 insertions(+), 1 deletion(-)


