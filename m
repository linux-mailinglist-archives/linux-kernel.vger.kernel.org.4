Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B155F6046
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 06:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiJFEsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 00:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiJFEsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 00:48:03 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F62880501;
        Wed,  5 Oct 2022 21:48:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e11-20020a17090a77cb00b00205edbfd646so3301147pjs.1;
        Wed, 05 Oct 2022 21:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=cqozkcdy1i/H5aOkc5ySqk5Pl8xtgOw0l/BQI1/9P4c=;
        b=OawMhD7oEUpclrETGGdRvETuw6Y0jZuuP7uv7+e1rIYqTWBMn7gO45HbIZduDt8oa7
         Z7vx35bRNtglmkwWm6cee7/rxIEV0IBM6mbXvlWBaQUlbPf94ruIrnY9QiHVmoBfHFUa
         Tbqr3/ER6PgwAY7bewEBmqdlc3IXJpe5hNgokotaPWpjABC7dYSfoX/nlinREsiFxwLm
         cXx/BLMn8Yb5l5FZYijoHWwmM2RYU2vxFCS7p8Y6VY7wJDfw5lyqaG0Sz402Ehn1pW6J
         w/jtuVmE4/LIHyGKduINhdRbalOZN29w69YlN5IN361NNmYeGa84rhVxAqGcd+70XOe0
         6W/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=cqozkcdy1i/H5aOkc5ySqk5Pl8xtgOw0l/BQI1/9P4c=;
        b=pzzW2IP6zpJsuP4L6i4I6lT2LoWYBCE7Y659HU/kIYzqHD4hZow+g4NQMAaK9pYoWz
         zXRI2ekH4vMEsHpA4l8rpRAtCiMQra9QYbGtr2Gqj7y2RD0AKMwbnpXIGxvWrquf8s5Y
         n2goIkTqiWmCZTnjFMev/iNKNZRbuKn7L1sEtApPFbdbk0aPMWE62no3DXcmq7TR+bWX
         OAmaaJZPCuieQX/RN4Xq8UP1Ur0AGOzUqmQ36xW2qFUBO7eYNvO/yw8cst44Ifqbrmvs
         6FA6x2LqxJf/+fNPYH8AwMM3Cgk2knvJKQ4pYlK57SgGrgvSJ+AbW+8tyNVwmRz/C2OA
         c5WA==
X-Gm-Message-State: ACrzQf1oHTkBRGC3BeLWQdoYxzI+2FK4KuNJS9R3MCFhNPQuhKDdad4C
        TomnMz8sBBdUSjWUwGbASPDZjrA30nc=
X-Google-Smtp-Source: AMsMyM4YUR0R64HhslYhamgxDewyUbp9eieOzxWnzQZUJRh5f3ejvZgNgIyoX3lVsWgA4TSizqQ43Q==
X-Received: by 2002:a17:902:dad2:b0:179:ee21:22a8 with SMTP id q18-20020a170902dad200b00179ee2122a8mr2838054plx.70.1665031681265;
        Wed, 05 Oct 2022 21:48:01 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:5d7c:350b:1ad7:ecfb:8fec])
        by smtp.googlemail.com with ESMTPSA id f7-20020aa79d87000000b0056232f5fba0sm2187448pfq.155.2022.10.05.21.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 21:48:00 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmitry.baryshkov@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>
Subject: [PATCH v2 0/2] remoteproc: qcom: Add support for MSM8953 ADSP
Date:   Thu,  6 Oct 2022 10:17:43 +0530
Message-Id: <20221006044745.286264-1-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the ADSP PIL as found on the MSM8953
platform. It is a subset of a previous patch series.

Changes since v1:
 * Properly rebased driver patch, no longer introducing deleted symbols

Link to previous series:
https://lkml.kernel.org/lkml/2d68e610-e8ae-9e08-257a-3c94c3697334@linaro.org/t/

Sireesh Kodali (2):
  remoteproc: qcom: pas: Add MSM8953 ADSP PIL support
  dt-bindings: remoteproc: qcom: adsp: Add ADSP on MSM8953

 Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 5 +++++
 drivers/remoteproc/qcom_q6v5_pas.c                          | 1 +
 2 files changed, 6 insertions(+)

-- 
2.37.3

