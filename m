Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFCF612C78
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 20:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJ3Tnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 15:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiJ3Tn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 15:43:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1642A1;
        Sun, 30 Oct 2022 12:43:28 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id r12so16359190lfp.1;
        Sun, 30 Oct 2022 12:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pgujNDZPGlGFxorQm6DE6TFrIe8y3qDjqrRjFjswOIg=;
        b=Wsr3MbNqe2yEWuNUIYdOA99DKf0Hs160Of2GNHI2ur8DrFk4vzH3QdkMO3KvFsEZQe
         B2m1FUyA4p4mJ/sxICFjsGy9z+Hm4O+y1H4jI6GsizpK0SK7I4UI0xCgQlK55ydkrKjU
         Z66ggvefC94gWveBjv+X4i46RTCy7dyB+BC/EQ08ozcc5BCFQlKNf46YwmtNRSnLD8PD
         mka/lKLyk0da1SEn3Gtz863u+z3hw2IrCqWCtjevsd1R/6xYcMRohiw79B5tXQQ/pTPI
         jtrFL2UwiktwEhkkGz/pRXFidTvyJqYy9aEbDB89guZQo8BfoDISKGZoAVcQOdKLd+WI
         DfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pgujNDZPGlGFxorQm6DE6TFrIe8y3qDjqrRjFjswOIg=;
        b=nPNN06RguXJXuly0oLhhAJRAbfezxVuHyQUIP4HcggE2u+M142zwfrp2ZcVHztcAuQ
         Ql+nFHlxmnQQ6gwL6hFDluhyUoQQMAtke/tJ2veQ4ceWDPoHcejhOLLpVslLYYkmtxkj
         mVQ5GBoRGI7m51Kc7TVyedbYwOfWVlySOWam0f1HSXlvtmLEria5FVCRlDMUuL5KUbSw
         8pVx+hKdzxEkfmyXj+oTQcqbaltDyaK9m6zEksk/FIWPcfNhIbECRcOLb/VTGVLDtxFk
         Kt0I7FSvh1TSDu6xM13wgKgIW9nbcgfUJVct6lYnNkfQSFZhLH1HKI7WI1wLkUbqQ6CO
         i/rw==
X-Gm-Message-State: ACrzQf0dKHHirq4jzpOUvgbHwxK+WZoB920vg4UoEoXVq8ArvaEGg4dx
        vX71xMXchTBG1KdTpW4OJq+Hwij+wa8=
X-Google-Smtp-Source: AMsMyM42Wv93o6fbJrdNZsseMb1cTZffRoaJ5aJc/1zCbCjCIfSlWlH3On1644w4C+AeYscRsiurfw==
X-Received: by 2002:a05:6512:4019:b0:4a2:f25:4214 with SMTP id br25-20020a056512401900b004a20f254214mr3770495lfb.94.1667159006880;
        Sun, 30 Oct 2022 12:43:26 -0700 (PDT)
Received: from localhost.localdomain (adld223.neoplus.adsl.tpnet.pl. [79.185.7.223])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512202600b0049464d89e40sm937833lfs.72.2022.10.30.12.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 12:43:26 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] Add MSM8976 Device tree
Date:   Sun, 30 Oct 2022 20:42:55 +0100
Message-Id: <20221030194311.197909-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce devicetree for MSM8976 SoC,
most of already supported hardware should be described there.

Adam Skladowski (1):
  arm64: dts: qcom: Add MSM8976 device tree

 arch/arm64/boot/dts/qcom/msm8976.dtsi | 1357 +++++++++++++++++++++++++
 1 file changed, 1357 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8976.dtsi

-- 
2.25.1

