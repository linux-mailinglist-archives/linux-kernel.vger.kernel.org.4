Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE2F5FD3CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 06:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJME2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 00:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiJME2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 00:28:03 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B4812D0F;
        Wed, 12 Oct 2022 21:28:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id l1so737362pld.13;
        Wed, 12 Oct 2022 21:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fYIg2WzOf03nIwqbYuPMBWLrzXyBCEb4x8ZfCAzdDu0=;
        b=PB6hHHSd3+SuFQWbK6NTZO7GxvFQskAA6dAhhOpKXIzIUkmu0LDVSisLFpRfraApmG
         ZQr5Am381sO9KaXYV2ZKKu9wvLU3AbfnWAkzzT0tRFUGRa9vSE3ZEmZMglCl3Ta286jg
         jXu9WVFnTVSW7ZG1uCv1WtWuyY0vV7/OnWMZe9i52CU6A7rQrBcKyM4V/FLx2U5rf/a8
         swUHsQQdoCBr3EgLWrkYla+bJwmH6bt8bRmlkB7UBBBnL1FTQ8eNdO1ro1LXzr91V77a
         halV0HUwoBpAI/3S/viSP8KUMVGXnLRPnMHuzSL/gjIzRZKJ56ZOXUg4hLThRv9qEM06
         Akiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYIg2WzOf03nIwqbYuPMBWLrzXyBCEb4x8ZfCAzdDu0=;
        b=7utCaIUmp+Owuwl5B6p3RuiATar+vylSs/LlPIqkUHi+qW8yS05daC/PVyhPTp4sB7
         qxidtOPiPQ8E/NEeJXtVOGyMSCfpw3x+vLPdOkBwfPsqqcEA2YjDW3+9fEEzw7Nc6q9c
         jxShQgP9TrPH5BC42CaRzlzxagxyHwHY2y0AWW2q1tFE9XV2qRexA+koqccKS80uPzn9
         xbS22u0GBrA6gXJqwhKuo8unIgWhPjv8lw331O+UYLbfmhF2ZCFcnB3VvGYn8uxnrP3X
         fYaV8R4RHmLG1GPkPPDXllT/kCEByq3S63HA0PUrp8HICNLwM5wNBBwtZu+D1k64ZILn
         tQ0Q==
X-Gm-Message-State: ACrzQf0Z3G2hHovGZmU24BaGt6AcjbYz89IUD/48THg7JYtthfkCwMpj
        UkkG97sgnj7hX3EfCvNmQpz8Vk8FcWx25g==
X-Google-Smtp-Source: AMsMyM5vIGCV8Tqdy5wnHnZQgZA4M21IavJpM74n0vLZn8SisXMe4S2DLvBTrkVJaZKPYwH2gdkMVw==
X-Received: by 2002:a17:902:f706:b0:184:7a4c:fdd0 with SMTP id h6-20020a170902f70600b001847a4cfdd0mr6715091plo.98.1665635280609;
        Wed, 12 Oct 2022 21:28:00 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:b6fa:b70b:65a4:a699:40c8])
        by smtp.googlemail.com with ESMTPSA id y9-20020a17090aca8900b001faafa42a9esm2192007pjt.26.2022.10.12.21.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 21:27:59 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmitry.baryshkov@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>
Subject: [PATCH v4 0/2] remoteproc: qcom: Add support for MSM8953 ADSP
Date:   Thu, 13 Oct 2022 09:57:47 +0530
Message-Id: <20221013042749.104668-1-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.38.0
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

Changes since v3:
 * Made ordering of compatible strings lexical in driver patch

Link to v3: https://lkml.org/lkml/2022/10/8/204

Sireesh Kodali (2):
  remoteproc: qcom: pas: Add MSM8953 ADSP PIL support
  dt-bindings: remoteproc: qcom: adsp: Add ADSP on MSM8953

 Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 5 +++++
 drivers/remoteproc/qcom_q6v5_pas.c                          | 1 +
 2 files changed, 6 insertions(+)

-- 
2.38.0

