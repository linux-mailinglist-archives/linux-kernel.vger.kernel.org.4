Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EDA6F5869
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 14:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjECM7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 08:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjECM7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 08:59:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90342DF;
        Wed,  3 May 2023 05:59:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so6352645a12.1;
        Wed, 03 May 2023 05:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683118772; x=1685710772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MwC+BnPU6BKqxfDtGr6AFGwZArDyvQQ/gezoS0Ber4M=;
        b=Whvtoc/skophwF5/lRnqZvU1HO9Y43Jm5bQ33Y4F+62KIWB5UxTiVA7QWdvdULYFkz
         MwIU3Oe/1xZRIouK++//fKBd/uW1VGOwKoWjzMtRhxvqlMsIkqp8AuYIqvx4ASTqoCRN
         8U6FduvNK59YjQlWcLUaVSPpZWoumSiXY9GqUBrfl+pKq5Rkl3YhjnczZfu4kO4fqqLz
         8cfwzm6C4WBZIRMbmE5xMIBaDSaxqiwnYLzreA5DhoWKx09nB26U970l8mg1c1oWDq5o
         x6LtGx9876/D9WscvZK/IVj6BnbxKfNVkbIBhJCvjq9n1+3YoMzKwt/LN3OZcyiOFhKk
         ho5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683118772; x=1685710772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MwC+BnPU6BKqxfDtGr6AFGwZArDyvQQ/gezoS0Ber4M=;
        b=OsEBdFc1xeIFkPXjW6R6V+XuW7vx4+f7DFSiSmDT8xNyGj2ivS7MvHzN6U3fpzk/ll
         tDdPf67jlDVSCiqEGIOJMq4JZQIWnwyu2ZMPi1vYw1S+s3ngAEVX2YEIg0Gey+CP5X+H
         qlAzV+MRwy+ro0QzfZ+CmJGPKEoVFDtmfZT/J1U0o3kpbLh8iBxZNMu3Q+iqOxOcIfza
         yHEf3XeqGI5n1brpIvowpesmMBXyX3G48E/CBNjH8j0cqSZokoNJYagtycQZAjfQjB9Q
         uHO15whMLoM/5OzVxAKideDlzyXbp78AvEryKGB5Qaqopx+HqUvRxabx8q9t7Fa29Qjl
         Xw9A==
X-Gm-Message-State: AC+VfDw8Iaf6R+qz8u6xJUyn8auJ7alaltc69fK8MlBVqjUX7XenIXO8
        FCdA+X91BQIfqheL7Qk+sWc=
X-Google-Smtp-Source: ACHHUZ72Fpw9/LNn4QH8bRfBYxsRJdfj9uLxypIA46Jhz9l0FywBbW/ZnyfmqNjGGZ+WjHN1Vh41lg==
X-Received: by 2002:a17:907:7f89:b0:94b:769f:3ba3 with SMTP id qk9-20020a1709077f8900b0094b769f3ba3mr1841245ejc.8.1683118771593;
        Wed, 03 May 2023 05:59:31 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id gn2-20020a1709070d0200b009545230e682sm17107696ejc.91.2023.05.03.05.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 05:59:31 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        "Yassine Oudjana linux-arm-msm @ vger . kernel . org" 
        <yassine.oudjana@gmail.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] MSM8996 Pro CBF scaling support
Date:   Wed,  3 May 2023 15:59:13 +0300
Message-Id: <20230503125916.144600-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

MSM8996 Pro has a /4 post divisor on its CBF PLL instead of /2, allowing
it to reach 192000000Hz on the lowest CPU OPPs (compared to 307200000Hz
on MSM8996). Add a compatible string to differentiate between the two and
handle the different divisor in the driver. Finally, add peak bandwidths
to CPU OPPs in msm8996pro.dtsi.

This series depends on the following patch series:
  clk: qcom: msm8996: add support for the CBF clock
  https://lore.kernel.org/linux-arm-msm/20230410200014.432418-1-dmitry.baryshkov@linaro.org/

Yassine Oudjana (3):
  dt-bindings: clock: qcom,msm8996-cbf: Add compatible for MSM8996 Pro
  arm64: dts: qcom: msm8996pro: Add CBF scaling support
  clk: qcom: cbf-msm8996: Add support for MSM8996 Pro

 .../bindings/clock/qcom,msm8996-cbf.yaml      |   4 +-
 arch/arm64/boot/dts/qcom/msm8996pro.dtsi      |  51 ++++++++
 drivers/clk/qcom/clk-cbf-8996.c               | 121 +++++++++++++++---
 3 files changed, 160 insertions(+), 16 deletions(-)

-- 
2.40.0

