Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7A663F275
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiLAOQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiLAOQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:16:33 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54867C7716
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:16:29 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d3so1743693plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 06:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G8JTeHACPwdFVMcbaC6yQ3WteUvkFssvw4+UCeCx36I=;
        b=ch0xUG9YOubXjD0wvTuXNd+CTBjc5WKR4mSRv+MGMOWfTkeRhQAVmw7STqtcL7EMY8
         dyOlsSVwqpzW5EcEciBskC4L7QLQOSxxFoBUwGHZPlJRDmB/i4aF3E1LiUvc5rDVhY7d
         v5L+ClmbUrifTxk6iYfUhqRvngpao5LH+QhBMiVwDMjaKTk9Dao/4xkChijMWCEbWjFz
         /AFiYMmibkb4OtjcX8Ch8ggyCNJn3tvzemoUCqnJ0+aoqItp9FSDXT4sY6regtdUte2p
         LLibUXQVBMQuv9+1vCXVYsAQzecaXO+5yj7gj9Oxm/0f0jrfqXlEj+L0WKWNTlmMzgT6
         Q4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8JTeHACPwdFVMcbaC6yQ3WteUvkFssvw4+UCeCx36I=;
        b=Vd5yd5gLjT1mlzIflYBfEQXiZd5SJgiC0oKSoD6m52pIGZX+9rjCtRM983LgIthw62
         DK/zLLwVXYJWcgBguo7jJhZqN9QyxM3Lkom4jCv10dT+TQ0TrJ57xQmGpokzd0flFPDX
         n6i8B6t7M/ZJpW9NTliyt2Dsx/y/WCq69k0+7+AJF2dNOxUT4UsnJv8Q+nR5b0EoT7HR
         WjUNPsZI+weonlWYhcos2FXBhWkw0gvh9Ft7mm4cv71f7pPC49YcaLaEDa3E9E1/5zvR
         vm6SzttAwEb62uCVq8HQZ4FNr+E1Hv/fcmmaZ3Nuv/ic7YUftCQ7oDPlusjnIt3XSozz
         hA/w==
X-Gm-Message-State: ANoB5plyeVYpXhfsFAq1WTYZ8eWHwaxTj7C6YPx7WvfDr8HVA00R9dw3
        hf9itPHFT/bvd/7d7womEasjrQ==
X-Google-Smtp-Source: AA0mqf7Kqf2NvXbWUbYDgBGqPALaEBBCxfn18BJA3lPSL8XaZKmexl9qRIE5fYgfO2A/p9iIG7SbBQ==
X-Received: by 2002:a17:903:1246:b0:189:63f2:d584 with SMTP id u6-20020a170903124600b0018963f2d584mr33499319plh.156.1669904188728;
        Thu, 01 Dec 2022 06:16:28 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c61:2814:c945:522d:e948:beb1])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ff0200b0018975488514sm3663041plj.126.2022.12.01.06.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 06:16:28 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        a39.skl@gmail.com
Subject: [PATCH 0/4] Add SoC ID support for a few more Qualcomm SoCs
Date:   Thu,  1 Dec 2022 19:46:15 +0530
Message-Id: <20221201141619.2462705-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds SoC IDs for Qualcomm SM8150, SA8155,
SM6115 / SM4250 (and variants) SoCs to the socinfo driver and dt-bindings.

Bhupesh Sharma (4):
  dt-bindings: arm: qcom,ids: Add SoC IDs for SM8150 and SA8155
  soc: qcom: socinfo: Add SM8150 and SA8155 SoC IDs to the soc_id table
  dt-bindings: arm: qcom,ids: Add SoC IDs for SM6115 / SM4250 and
    variants
  soc: qcom: socinfo: Add SM6115 / SM4250 SoC IDs to the soc_id table

 drivers/soc/qcom/socinfo.c         | 6 ++++++
 include/dt-bindings/arm/qcom,ids.h | 6 ++++++
 2 files changed, 12 insertions(+)

-- 
2.38.1

