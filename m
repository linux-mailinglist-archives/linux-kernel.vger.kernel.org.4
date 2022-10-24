Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03C360C952
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJYKEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiJYKDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:03:23 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF7AE0700;
        Tue, 25 Oct 2022 02:57:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sc25so11026411ejc.12;
        Tue, 25 Oct 2022 02:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pAx8zlaUjVsueyFoH8eMRt9jigq+pALMNIu5jqg4QQk=;
        b=caqsOQSSaJt6WVgqnE0PzdRddPlCI356oy1U3jxlLWpBUYqRRkyHnbeo3TVeSyE/xS
         yow8Tm1a4Q120tCowFm1SPiQmDCDKssc7IHFMuu3WIbCOkKph1Y3hhYhyfFbubPYljdA
         H8Mi6Tm9zrzhogu0rHhqo1FtWfZGyxrJdm6eodT0mpFEXuxz58OWyQwB6hi+l+NdF9pU
         XnM2LYK9JK+vsul3zDoiPF9KEOXR9rN3brb8Pkdo0zPE6GhUEgjKdoyRlJE/kuwZJDP9
         kOarcXka3e4hF3U+iseGpeanxLZfC7fPMJNukfPbogqShc7RVukPN/aKwiTZ9TQDRMJj
         8Iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pAx8zlaUjVsueyFoH8eMRt9jigq+pALMNIu5jqg4QQk=;
        b=amlfJ64Js2uC62bUVGltg7R6fzc3soPZ/M7BNPf8+yoc+t80QTgfpsxMzpnH9AkB0W
         x9EQtYzmmxuduzKY/NKqT3OS7S8ZyLAHlEE7Ub9eXFqnXySvQ6Yaev+z84DJxn7ekAnu
         uJy82hWvBf+BBk/GHMfYaotAP4AhavirNOJP9aDpstdnBl5j49gDAiFSKpxsmGVGyBHB
         hnGPIOPiywYUmV41bRAAFtpJagL2UMi045KLa2T2dRAPlIoEHYdleaCNssCjpp++U8jO
         tYFfvcdW14GiSO6qfYlPntvPlmBybFuedvf8St4gMQXL8nbtMBDb4sMy9aUJ1RZQEcaw
         uUEA==
X-Gm-Message-State: ACrzQf0QmfcY20bNwnDnYNFRkm+wiCYJXXyi1Ss/WGqJV9uXP+x18dt4
        ymtlabOhx5anvRezgeGbmsM=
X-Google-Smtp-Source: AMsMyM7cHA0V5Del2vqlPCtRjYe2tHkw0XMTTjub7z1QGzqHP12iMAPDu7z4estQ6N4tnoYOHneR5g==
X-Received: by 2002:a17:907:983:b0:77b:6e40:8435 with SMTP id bf3-20020a170907098300b0077b6e408435mr30162199ejc.570.1666691822807;
        Tue, 25 Oct 2022 02:57:02 -0700 (PDT)
Received: from localhost.localdomain (93-42-71-18.ip85.fastwebnet.it. [93.42.71.18])
        by smtp.googlemail.com with ESMTPSA id j10-20020a17090686ca00b007789e7b47besm1130827ejy.25.2022.10.25.02.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 02:57:02 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Hendrik Koerner <koerhen@web.de>
Subject: [PATCH] ARM: dts: qcom: ipq8064: disable mmc-ddr-1_8v for sdcc1
Date:   Tue, 25 Oct 2022 01:38:17 +0200
Message-Id: <20221024233817.27410-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was reported non working mmc with this option enabled.
Both mmc for ipq8064 are supplied by a fixed 3.3v regulator so mmc can't
be run at 1.8v.
Disable it to restore correct functionality of this SoC feature.

Tested-by: Hendrik Koerner <koerhen@web.de>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 90c08b51680a..01ff24560ee6 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -756,7 +756,6 @@ sdcc1: mmc@12400000 {
 				non-removable;
 				cap-sd-highspeed;
 				cap-mmc-highspeed;
-				mmc-ddr-1_8v;
 				vmmc-supply = <&vsdcc_fixed>;
 				dmas = <&sdcc1bam 2>, <&sdcc1bam 1>;
 				dma-names = "tx", "rx";
-- 
2.37.2

