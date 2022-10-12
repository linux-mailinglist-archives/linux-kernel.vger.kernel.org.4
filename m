Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90F35FCB04
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJLSx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiJLSxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:53:12 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28393FFFB1;
        Wed, 12 Oct 2022 11:52:51 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u21so25663233edi.9;
        Wed, 12 Oct 2022 11:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rnL+He7Da96VSkLj6A5rMl8m0utiApVsa5fPZkDJuiw=;
        b=HzFBewRpE8fUFWOcHGYuOfhqVI0Nfnkt8/vEyL5k+DEg9Hyc9If0lrsr751hOSRMsq
         bEz2g25YLiNZXG+WAiJ2Dw5asxrROSJOsKoKcUfHRJ49v53j0ZGlfTyusDjArp3+63rD
         8VUNsVVKohB4N+YCgufbZ6AJV0R+mpjhUcj1d+SlsIAGnpxuOxXs5+pv/xusJSoNOtpB
         9YgraalrT7krSm8nHX/qA1yxmeSAhSuHahv0rBLCr9UUkYGGE/+JrZ48fNnisDYpBMbH
         uMIhB4Lm2+Q3hsWQ66Hmzwh2SuokGwiJnzsKlGCc2118Y0BEgd6tLapJRj+otuts3Tn8
         6rxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnL+He7Da96VSkLj6A5rMl8m0utiApVsa5fPZkDJuiw=;
        b=iw6XxHVtau/lhB1SRFVXYGGHXhZ5LSvKkqJD+XCb9jeuIXYgLpB2tCarEfVnVD6CFv
         kUoTXVVjUzEkARtGe99lX/TQAoAhBMjYDVZ2zuOn0RwtW76vS7cLl/ORRv/NfFEqnLg7
         jF8W6pXL70e8Ltuc5yQs7D9TJwMmYW9HbUkldnItRBMXt8BpZEXSMjtesy7CQPd8JRlQ
         TpwWImleJtKS4QQ/ti4tCzR2gVzyTE7fSKjwo+XgiMK+WhOk9I1WNjcQhsToJiJSkyFF
         knGFH3hsy7e4cyrq8bb/hWUYIXbBCQEa6G1dGcDe5BhaQQ05YPrYowzoliGPqPbIBduu
         v97w==
X-Gm-Message-State: ACrzQf1raM55myF/5tvOHhwnGo4gj2yFbuEsoubR2qWYKepcb2kkNSXP
        VhfHNa5/dDE0VigfePPI/8hxtwNQN0M=
X-Google-Smtp-Source: AMsMyM4RDiZzC8pqrZoZY6CtdfmfcVehxClwHi7RbQ4bmXTLf0hueLNlvCsv9K03j/qBJD/RcFSxmA==
X-Received: by 2002:a05:6402:358e:b0:45c:aa8b:f7e9 with SMTP id y14-20020a056402358e00b0045caa8bf7e9mr4390057edc.33.1665600769587;
        Wed, 12 Oct 2022 11:52:49 -0700 (PDT)
Received: from localhost.localdomain ([46.216.9.29])
        by smtp.googlemail.com with ESMTPSA id k6-20020a170906970600b00781dbdb292asm1644410ejx.155.2022.10.12.11.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:52:49 -0700 (PDT)
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
Subject: [PATCH v9 0/2] add device Xiaomi Mi 6 (codename sagit) and board binding
Date:   Wed, 12 Oct 2022 21:52:43 +0300
Message-Id: <20221012185245.1282599-1-dsankouski@gmail.com>
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

