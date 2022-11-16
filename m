Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCC762BEA9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiKPMvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbiKPMvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:51:36 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EE5192B0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:51:35 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id v7so11839980wmn.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xvewyL9Srcl/UYiOCULojIpYPvNQi7FyRT20YzMudhI=;
        b=PD2BHh+aYaR8MwPg9mY0opbbfUHjaJ8kDacSGtCRy6U00OuAbqnl+u0rwZJ3xtHiHL
         ijFLr+8jr37MlaCBdAaTHgZodiZaPjiXX6YD6MEeVWjrHh2o+ZSXFJjdommW5OXX0Uhj
         OWUBHMV8TmU02OtQ4KCoufNSGRW5Eqb0iDUk4PplwfMdGvYrGXd7ZcjM2xIMVlAKd1Ij
         ELDl8UYNDvVzvr4FOVBN0waFAABw6PegiGKIM4bQXFP3K6umlAsLW5MJYPw9SVipTs/X
         eECGA1jKxJZ8IFu/eBWU3NrQnpk6AfwKLv/oFJgTjKJ0tKA4HhE1RQIVXlEGR0NhqTxi
         MFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvewyL9Srcl/UYiOCULojIpYPvNQi7FyRT20YzMudhI=;
        b=XaWBamDAWWPHF+C1/VUPv3oSDpOkf3wGoswJ1DKIL6TsWKzw7tDecQl3IUoZ8OGfUI
         Eb3EesPJ43sscqy8QoVn7WSNXVYeCSlO8yvfaL0bDjAhQf4r5Szo+xCOg5LFsb4Ic+/w
         vEc81ND+t+jhBvtpC2zsHunkk0MQ+N4S7wzTyGqHI3Uuon2t/XpMrLH9RRVNmbduCuau
         c8K1I+aEBoRoxEsTEr7UxBlShaqVGNtfwNzvt6as3nvgqIDMkwjf/cyf3KqHEgo/Wuq/
         axDocJMSJHSmrCPE2uJhTJw0O/MhJViuwfV+JpTbGXIFdU9UYJxGlZpC5Z8zjVhJin0l
         MqsA==
X-Gm-Message-State: ANoB5plog+uWsOR3+4LpaS5axGEd9Ge05Fi3M6kbhtABamkp0md5SsaG
        Z7ACV2yDCmZ9lBzjf6o7hV/IiYgGQfsbdg==
X-Google-Smtp-Source: AA0mqf4G3T9A4M5CHKjZxKJesLF6GKiHLKgZViXHZ7lz1f8U4MBR5cscgGLGmLpwEm9f1Jz2BqRm9g==
X-Received: by 2002:a1c:e914:0:b0:3cf:d055:9138 with SMTP id q20-20020a1ce914000000b003cfd0559138mr1988307wmc.140.1668603093771;
        Wed, 16 Nov 2022 04:51:33 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id d16-20020a5d6450000000b0022cc0a2cbecsm15386776wrw.15.2022.11.16.04.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:51:33 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: qcom: sm8550: Add UFS HC and PHY
Date:   Wed, 16 Nov 2022 14:51:10 +0200
Message-Id: <20221116125112.2788318-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds UFS HC and PHY support to SM8550 platform and to its
MTP board.

This patchset depends following patchsets:
[1] https://lore.kernel.org/all/20221116103146.2556846-1-abel.vesa@linaro.org/
[2] https://lore.kernel.org/all/20221116114526.2679041-1-abel.vesa@linaro.org/


Abel Vesa (2):
  arm64: dts: qcom: sm8550: Add UFS host controller and phy nodes
  arm64: dts: qcom: sm8550-mtp: Add UFS host controller and PHY node

 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 22 +++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi    | 76 +++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

-- 
2.34.1

