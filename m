Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D7B70A140
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjESVJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjESVJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:09:11 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D301B3;
        Fri, 19 May 2023 14:09:10 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f13bfe257aso4109115e87.3;
        Fri, 19 May 2023 14:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684530549; x=1687122549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s5NRxZLxubgldjF9VZV7rtaGRK/0FvxR2s2/hGhwZtM=;
        b=dMgzzdYBObJj3NA6JG3Xxf+SaFVXojGG0qTcVbCtm+o8RGNUWP6eX1RFcjynPopq2Y
         g3ihKV6p/2qrptd8qqGNYKtLH3Cf8sVp0w2XsKQpXVEuyQ56qknnm01geyRiiPE1jXLE
         vnzXhm8A58XFM6o4iGAIeDbL8hxdY1tuze0ED2Q4v5Bey2LQ/c526xTlqK3c9ui+q93l
         L/MFPmlnttWrAwuYT5XvTRDJKmCbj/NCxYZ9b8u59nv7Fp/cWJsaeKO0ik32RpOPeCwj
         6XOGjeRpWeH5ieSorTkrzzNrfrs64RjQmyySjqT8QsjxaE32saak6lDdS6MS6gmyiSCp
         dJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684530549; x=1687122549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s5NRxZLxubgldjF9VZV7rtaGRK/0FvxR2s2/hGhwZtM=;
        b=UgVqB5k7iiiBG3WSW2KPlou0PTgmPiXLT2ViFvSDGOLFJ2amPRdYFnoDkyBkdYalK3
         FkRHfnNVC7TupeCU3MxEJXKSF6GwCC25FO0O7SLmzxucO/4/GBXCostsq8WQ08dd0R8d
         3sVhTM3PHG0Z7tRoeYEsSFBp7JdMd4Vpy471P2ktI4F+f6qtbv81WnhEX5n8n5deWmfT
         vCWpeAFyQHuC7wq1s7O/RBp4warvitw8Uv/LkugGYZgPwtOwvL/3pzWp3bdjRjYp711+
         e6B7ky77GH8S+mtEPGtqX6YopGpMaKpqgoWqSbcOZFDLnWReF4CB2x3UCtu0FU9hexof
         Oq1Q==
X-Gm-Message-State: AC+VfDzrGGQJikIy5KPniKJnwyTA79YnhNF1UmLJsrP/37qr8Xr56+74
        fWhmRfFHgYslnW/8jrGo0Rh7spdAMGU=
X-Google-Smtp-Source: ACHHUZ41m6/ioxf6xqImWeCkaRh8eejimbGFcOgS1wGGne0XmSipk6HusphMaJhRNT/XrvLvyKBjsA==
X-Received: by 2002:ac2:5506:0:b0:4dd:a73f:aede with SMTP id j6-20020ac25506000000b004dda73faedemr1279448lfk.10.1684530548582;
        Fri, 19 May 2023 14:09:08 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id i14-20020ac2522e000000b004f3945751b2sm30043lfl.43.2023.05.19.14.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 14:09:08 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] PMU, rpm-stats and IMEM for MSM8226
Date:   Sat, 20 May 2023 00:08:57 +0300
Message-Id: <20230519210903.117030-1-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series adds PMU, rpm-stats and IMEM nodes for MSM8226.
It also defines and enables reboot modes for samsung,matisse-wifi.

Matti Lehtimäki (5):
  dt-bindings: sram: qcom,imem: Document MSM8226
  ARM: dts: qcom: msm8226: Add PMU node
  ARM: dts: qcom: msm8226: Add rpm-stats device node
  ARM: dts: qcom: msm8226: Add IMEM node
  ARM: dts: qcom: apq8026-samsung-matisse-wifi: Add reboot-mode node

 .../devicetree/bindings/sram/qcom,imem.yaml   |  1 +
 .../dts/qcom-apq8026-samsung-matisse-wifi.dts | 10 +++++++++
 arch/arm/boot/dts/qcom-msm8226.dtsi           | 22 +++++++++++++++++++
 3 files changed, 33 insertions(+)

-- 
2.34.1

