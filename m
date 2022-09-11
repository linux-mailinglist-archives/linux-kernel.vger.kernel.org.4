Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C5C5B5012
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 18:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiIKQrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 12:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIKQrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 12:47:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DD62250D;
        Sun, 11 Sep 2022 09:47:48 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u18so11155286lfo.8;
        Sun, 11 Sep 2022 09:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=HA8nCOkAXI5pWr8NFRVcvP55LL8wQ30TATKKXBfMRyc=;
        b=DxbH2ZufBCubLKCARbp0AtY6qiRL3bqH90OBBrqcb+7cKV487M+lN8gndTCeRd8meK
         UMZ53331umiv8/SxccsV9+wuA5LkqQ7COuQhPuKnWd6gQ8PszLUUurtcYeRR9vw00j9E
         bUmlSe7rFOl2fCIWIum4A0daapmr4XuKCMeAw1XBRjpP8MgJPw92OOkZ7wDbza/bHI6h
         EOa2jouzLHuGYONrOLfjvY7EJ3IfKhKlkLkzN8VKYCeEmr/jN7BZdXvjIKmTksrhP1Ti
         kuUogtc+Bmh59ACeZvHDB97JBJghXwAVDk7zP1+g4eS4kzUQJcvsatbx749NISqmbz/l
         h/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=HA8nCOkAXI5pWr8NFRVcvP55LL8wQ30TATKKXBfMRyc=;
        b=tCRXQj1YWJs+4EXelaBV+JDydqBLP+HOOy3/CB2JlpD6FEC0xSMiziy/7Spj3ETV81
         icd4sh9C2Mx2QavBnSYxbmw4pmfXucMyxwgRSrd6aXMNqz1W33jcEuscQKERAZcKzlss
         /VuPzJo8IKwWvxGJRyQH9jLVAzZ09D4z4izTbD2F3Hq5bSTVRmizvyKVrDDx0UsDXdE9
         9/DZM8vHm99ulX1UdKthbPgZOOo5lkMHLXW5VbOyQQ40msvl4+AO2jPnkzH26uurr3NZ
         RZOJry0u4rZynNdAEw1eE2dXQOBFdPFFLr/CA4ekcEn3G5coANYuk0xi4xpRiDfNBcKW
         sjVw==
X-Gm-Message-State: ACgBeo1mBlZ0FBQu72+GTkaQv35Sp8f7G28Vry8YmHWlA2PS+xppsI1I
        OGypErEs+Vz65ATY0FpxB/HWHXJRuUUOMA==
X-Google-Smtp-Source: AA6agR6jPn7ZnXiofy86/eT+/HFxp4+3XPCj9LGowRvuJFpj0MicEk1o403HrgX83+C7lcmEZWf5Rw==
X-Received: by 2002:ac2:4e10:0:b0:49a:d44b:426 with SMTP id e16-20020ac24e10000000b0049ad44b0426mr144007lfr.234.1662914867090;
        Sun, 11 Sep 2022 09:47:47 -0700 (PDT)
Received: from localhost.localdomain (adld177.neoplus.adsl.tpnet.pl. [79.185.7.177])
        by smtp.gmail.com with ESMTPSA id h1-20020a0565123c8100b004979e231fafsm664501lfv.38.2022.09.11.09.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 09:47:46 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Add DISPCC driver for SM6115
Date:   Sun, 11 Sep 2022 18:46:17 +0200
Message-Id: <20220911164635.182973-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduce support for SM6115 display clock controller,
this driver is based on QCM2290 one.

Changes since v1
================
1. Changed bindings file names to Vendor,SoC-IP format.
2. Changed include in dispcc-sm6115 to reflect name change of bindings.

Changes since v2
================
1. Changed maintainer email.
2. Converted driver to use .index instead of fw_name.
3. Removed parents which had no passed clock.
4. Updated YAML to reflect changes above.
5. Adjusted driver based on Bjorn's feedback.

Adam Skladowski (2):
  dt-bindings: clock: add QCOM SM6115 display clock bindings
  clk: qcom: Add display clock controller driver for SM6115

 .../bindings/clock/qcom,sm6115-dispcc.yaml    |  70 ++
 drivers/clk/qcom/Kconfig                      |   9 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/dispcc-sm6115.c              | 608 ++++++++++++++++++
 .../dt-bindings/clock/qcom,sm6115-dispcc.h    |  36 ++
 5 files changed, 724 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml
 create mode 100644 drivers/clk/qcom/dispcc-sm6115.c
 create mode 100644 include/dt-bindings/clock/qcom,sm6115-dispcc.h

-- 
2.25.1

