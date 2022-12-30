Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738D065990D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbiL3Nvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbiL3Nu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:50:58 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC6BDE81;
        Fri, 30 Dec 2022 05:50:55 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id h7-20020a17090aa88700b00225f3e4c992so13230206pjq.1;
        Fri, 30 Dec 2022 05:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IrwYfLgEMI68mkR+EGYtHrh6WCeTp4YOiBrMtjhhtP0=;
        b=Zk2SqgBV19FJGG3f11GWtHe+DfolQ/8cRCfRNugbnaedxxK53zpb32XcNPCTojVG/w
         Nz1joRbzb1Z6Ew2/eMDdgEM992/V+l9Tc50QFytHOzA7B+1O5yF72voqOPsccmyYnLOo
         NMLvovQJn/+UBZq5SqDngiizbiRouee81MNx57Kn+6pQrhf8FYEtpa3lGYTwXsrFO/Lh
         kDFGxEOTLr9+NeeARXBdMu4OQ8RTYI/GsAbOhX8YyEnLEDEKCP6ZT18npf8SFwiIcq8Y
         xXPCKT7PbseWoUlKtmvGOp7VpGLZEWmTbk1ciCAWO5/EIsTEBA9m33m5p0azC2xsnQAq
         wY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IrwYfLgEMI68mkR+EGYtHrh6WCeTp4YOiBrMtjhhtP0=;
        b=eci+GZysoG4syJCeXApprSAp17hC3FAPXu83xBgCQlWmJ4IDYkrhQKHKA/sv7iBmIe
         UkyRdWTdImPCHW1rsEanTp3vOSAHjVCIrQNYbYI+8+dIPiExLZrMCJeEHVdP0zcLEfz2
         yc+G2WaqaUx6RwmTtHigaCKLUgR9WqkLNCf0hZlhlH3+TYIMW8DWikTLuAeebI5nBhz/
         ikIKCFKlsvs4hTeXbw9VERdHGqLldqA/mjK4ZlNnbhTytHEeZSFsTtk6DBoXCKgRtOg8
         QjGGilGERxyfY4HVgCCbV57znQXrVQjXGoHfxS25VbxpUNhqGtBICfvdlZnRc69scv9U
         a/EA==
X-Gm-Message-State: AFqh2kpuUoo2uxKYueDVp/3xuwjLyapu8KaYyz9ObZtwRJWxCnqW++7P
        dxJCi6ANokEOM93QDlw8M0c=
X-Google-Smtp-Source: AMrXdXuYfz5XJQWmhZRJ7u/MxCk6ngMB2Wxh1Ee4wAzgvELx0RR7DHVB4QvBvcc8TZ/6DWfjw+Xlzg==
X-Received: by 2002:a17:90b:2643:b0:223:2865:73aa with SMTP id pa3-20020a17090b264300b00223286573aamr38713800pjb.2.1672408255200;
        Fri, 30 Dec 2022 05:50:55 -0800 (PST)
Received: from debian.me (subs02-180-214-232-7.three.co.id. [180.214.232.7])
        by smtp.gmail.com with ESMTPSA id ge10-20020a17090b0e0a00b00213202d77d9sm12842363pjb.43.2022.12.30.05.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 05:50:54 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id DD91D10417F; Fri, 30 Dec 2022 20:50:50 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Devicetree <devicetree@vger.kernel.org>
Cc:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/2] soc: qcom: dcc: Documentation improv
Date:   Fri, 30 Dec 2022 20:50:29 +0700
Message-Id: <20221230135030.17002-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=939; i=bagasdotme@gmail.com; h=from:subject; bh=GLRC9QwsPxf3VynR+LqmR9KGtjvhslrF16b9h+ROkOg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnr3ix4G8x/PUn9Wu7ku/+uGXZ2eU5v2VR1wkdeaoOIvCRD qqBqRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACYS1MDwv9zjqeSxerepTM6pUdP9nu fZ2b+Y+3DXxuR4VZbAog3KBxgZVn/Jaso+OnH7FQ+Pt/aHvffHZn/IWfL1/hqXe2WNQnsdmQE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DCC (Data Capture and Compare) patchset was sent and partially
merged [1] without Cc'ing linux-doc list for documentation review.
kernel test robot [2] noted htmldocs warnings as a result, which is fixed
in [1/2]. Later, when inspecting the sysfs description, the wording
could have been improved ([2/2]). So here is the improv series.

[1]: https://lore.kernel.org/lkml/cover.1672148732.git.quic_schowdhu@quicinc.com/
[2]: https://lore.kernel.org/linux-doc/202212300426.eMLsZsvA-lkp@intel.com/

Bagas Sanjaya (2):
  soc: qcom: dcc: Fix examples list on
    /sys/kernel/debug/dcc/.../[list-number]/config documentation
  soc: qcom: dcc: rewrite description of dcc sysfs files

 Documentation/ABI/testing/debugfs-driver-dcc | 163 +++++++++++--------
 1 file changed, 96 insertions(+), 67 deletions(-)


base-commit: f02a537357a61e7892587c0f3455f8295cc9075c
-- 
An old man doll... just what I always wanted! - Clara

