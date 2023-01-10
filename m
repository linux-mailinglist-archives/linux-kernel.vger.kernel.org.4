Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512B4664C93
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjAJTeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjAJTem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:34:42 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA05555660
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:34:39 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z5so11827825wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hEimIxxtRk92ThJhA07pU4yUBVT2KnfnDiAUWU+EuHA=;
        b=GTOm629YBnb7Gs/j+7JxLE+aXaGt2snAT0xa78h5nabBxPon2FR8SNFrk9z3z165iW
         gvlUs48v7xXUH6aRy+GZbSfsSgt47DgHFhXHbFveziBQwNvRRT1/vwF0algtmNvpbcpi
         0sgAW2SHGoa+ppaS34w1TR5CyL1L7Xrm2VKn0NchOnE/nNcNJ+RWtE+JjHWiiEVcbXw8
         6d18tk+rFme+Fgkx7vIcp7oBHK9hqAMbFZmu1AWpTvQ9/F1Z3FmlHh7tgmRoCgS0/bwc
         ifBMV1UjORgTup9HNyUXG626Qz/+8hjyPbAd3fHoX8rX5bRz2VHO8Cscqx+qy7PJri5K
         ymmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEimIxxtRk92ThJhA07pU4yUBVT2KnfnDiAUWU+EuHA=;
        b=kzHsbx3YNAsKbpWWiHJinivnkfeIJ46ZmxZZmb/8QbtW7/9qDJfEmMMVIuBx3Ucf3V
         mI8yYwZlrvlKO8FECv6CjO+CShu67X4yTvTAE4pqonCT5S4EIrJTZfnBu/P9zChhfdhu
         Op2pBhX2gw1JIHPt1QugwgjF+WSjA+5iyduScxKEaiF9UCgnvcaMpjty0H7GiW7DCzOV
         4jX+cskmXNtEzIr8k8T6XmhmEgGXDbVqBjqZbZoib+sP0NLh8Bvu1OliQoVKbao5rUIo
         5MC2p4EwT1xRX+fUOncxy914+O1MBy0IXhLlUnJAuHX1+VS2ZAQpuqQV9a42yljzOebK
         A9zw==
X-Gm-Message-State: AFqh2krNdNtyLxDuBy+PvrxOPC4Mxu7WyEMnD+pO6AAVIju5mIeWxTTt
        MFi0P/gHE5U5yP20cLFdxQHkhQJ+rBMT33Yf
X-Google-Smtp-Source: AMrXdXuyxYuOGzdwjc8zGLX3TkHkghlrj7tB06afTv1wsfTAUqfhF4bW2zvj6P9d29tI0feyRPwOdg==
X-Received: by 2002:a5d:5405:0:b0:284:8a24:59e6 with SMTP id g5-20020a5d5405000000b002848a2459e6mr31298207wrv.3.1673379278558;
        Tue, 10 Jan 2023 11:34:38 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f3-20020adfdb43000000b00236883f2f5csm12222271wrj.94.2023.01.10.11.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 11:34:38 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] arm64: defconfig: enable modules for Qualcomm SM8550-MTP display
Date:   Tue, 10 Jan 2023 20:34:33 +0100
Message-Id: <20230110-topic-sm8550-upstream-display-defconfig-v1-0-9941c8083f10@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMm9vWMC/x2NwQqDMBBEf0X23IXEEpD+SukhJhtdiEnIqrSI/
 97onObN4c0BQpVJ4NUdUGln4Zwa6EcHbrZpImTfGHrVP5XWCtdc2KEsgzEKtyJrJbugZynR/tBT
 cDkFnq4W6IoyGppttEI4Vpvc3Hxpi7GNpVLg733//pznH7Meo7yOAAAA
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the SM8550 DISPCC and Visionox VTDR6130 panel drivers as module
to enable display on the SM8550 MTP device.

To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

---
Neil Armstrong (2):
      arm64: defconfig: enable SM8550 DISPCC clock driver
      arm64: defconfig: enable Visionox VTDR6130 DSI Panel driver

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230110-topic-sm8550-upstream-display-defconfig-deffeeeee051

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
