Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE896A73CD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCASug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCASue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:50:34 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F1F303C2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 10:50:33 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y11so10881235plg.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 10:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EjySFxB3u/yJmF2L0v+RXLMEaLGvfkABUreehEPy5PQ=;
        b=mgDVJNJ8VEJ2ueKGgq3JfaokAscdSPqv2DLxGgE1XmKplb1bc2HUZYl9+pLS0KVVVr
         IgMXwL71UCpY1a66RblhTCXQVN8AsdlzLOlnlTcV2C2FsCAgOWBpl1dbsaxKSMQwtOKw
         ahrMcAu2whjZKc9SF8kb99HK8G/03tCImQI8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjySFxB3u/yJmF2L0v+RXLMEaLGvfkABUreehEPy5PQ=;
        b=S4YVE5R/qpIDxdW8fM3mgrkv3jlDBfxj+ZndQAKaZ2q2KctjRSiUqZoKRgil+HzJhf
         Fvx33mVsNQzmxvKue9DHt/6w8eDzkMKfMaOpAcpZKxRVVlswTM+i+G03FyVYUUNU+edg
         kC3DstxQqr1nIbiIJIJd0J+IdhjjkvhcFHYWeTfyGVkJlXRyxWy2PGNcw2mhblPH5wvz
         v4D/pXTtgaCeOWuy3qPTx9Jryjlo+y5tmONJu0eL65qVnXncFXXsr/93TPEmLDyYRsSt
         U/qfTvvisFNGsWmZZ2BwIWrnOnU4mF0fXRap5dNra9908+9BD6sd79WjjEK/aaF5bpVe
         3zOg==
X-Gm-Message-State: AO0yUKV6ifhPf6qMTnWJkuTIXEUE0Uw2e3QRQBLTgwrm+wCAo+1vezim
        +IqRupOucVPUCu+L7AlTQa0GOw==
X-Google-Smtp-Source: AK7set9xrPfAg/LyDUfuKea8pYAEKZ7H/mBw5ppo/zgswkvRYZSeAVahAYgRDaZHaevxq3qRwaM4xA==
X-Received: by 2002:a17:902:f54e:b0:19c:da7f:a238 with SMTP id h14-20020a170902f54e00b0019cda7fa238mr9362595plf.31.1677696633278;
        Wed, 01 Mar 2023 10:50:33 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:f4ac:1f4d:6f3b:f98])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902780500b0019a8530c063sm8761982pll.102.2023.03.01.10.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 10:50:32 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     mka@chromium.org, swboyd@chromium.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] arm64: dts: qcom: sc7180: Delete a few unused trogdor dts files
Date:   Wed,  1 Mar 2023 10:50:02 -0800
Message-Id: <20230301185007.1101006-1-dianders@chromium.org>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general on ChromeOS we try hard not to throw away perfectly good
hardware, even if it has a few quirks. Many people keep early versions
of boards around indefinitely and keep using them for testing /
development if the feature they're working on doesn't need the latest
and greatest. This is the reason why there are so many sc7180-trogdor
device tree files.

That being said, _very_ early hardware tends not to be kept. -rev0
hardware tends (not always) to be prototype hardware and often comes
as a pile of parts. People are really only willing to put up with this
for so long. Even if it's not a pile of parts, -rev0 tends to be a
very small production run and isn't widely distributed. That means
that, by and large, we can eventually drop support for -rev0. Here,
we'll do that for kingoftown and wormdingler, and lazor.

While looking at the -rev0 of mrbland, I noticed that mrbland appears
to be long dead and unlikely to be revived. Let's just fully delete
it.


Douglas Anderson (4):
  arm64: dts: qcom: sc7180: Delete wormdingler-rev0
  arm64: dts: qcom: sc7180: Delete kingoftown-rev0
  arm64: dts: qcom: sc7180: Delete lazor-rev0
  arm64: dts: qcom: sc7180: Delete mrbland

 arch/arm64/boot/dts/qcom/Makefile             |  10 +-
 .../dts/qcom/sc7180-trogdor-kingoftown-r0.dts |  38 ---
 ...n-r1.dts => sc7180-trogdor-kingoftown.dts} |   0
 .../boot/dts/qcom/sc7180-trogdor-lazor-r0.dts |  34 --
 .../qcom/sc7180-trogdor-mrbland-rev0-auo.dts  |  22 --
 .../qcom/sc7180-trogdor-mrbland-rev0-boe.dts  |  22 --
 .../dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi |  36 --
 .../qcom/sc7180-trogdor-mrbland-rev1-auo.dts  |  22 --
 .../qcom/sc7180-trogdor-mrbland-rev1-boe.dts  |  24 --
 .../boot/dts/qcom/sc7180-trogdor-mrbland.dtsi | 320 ------------------
 .../sc7180-trogdor-wormdingler-rev0-boe.dts   |  22 --
 .../sc7180-trogdor-wormdingler-rev0-inx.dts   |  22 --
 12 files changed, 1 insertion(+), 571 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts
 rename arch/arm64/boot/dts/qcom/{sc7180-trogdor-kingoftown-r1.dts => sc7180-trogdor-kingoftown.dts} (100%)
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-auo.dts
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-boe.dts
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-auo.dts
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-boe.dts
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts

-- 
2.39.2.722.g9855ee24e9-goog

