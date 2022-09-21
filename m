Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D495BF562
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 06:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiIUEhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 00:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiIUEhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 00:37:45 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7537748C90;
        Tue, 20 Sep 2022 21:37:44 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so12953981pjq.3;
        Tue, 20 Sep 2022 21:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=IthdYJe60bFyURI0bdrVfgyUuZ54Csc/E5/4SXVUQtA=;
        b=GmxgHvxPbjE9bd9M5EP0CpwYwop0OfUbAXZIVAISyM3Vr9OV9GGDBsmG2x80sDU+Ak
         1ZL+ND1jqNjAjpwweDAZ1+9hTWzkrlYi9wdacin/7J6y+8SlOE28tyJ00pf+7/6tBBO3
         HOUSWsT0+VA8dqAH07De6AdhxASPEJeKgj87U7eah7fUkFDrklMAGYRxZDAG5+ciwH+g
         aNFvBwBn5IlMBGRAXTQs9sU9EgItm6dr7gsytDAM5rK3bAs4yZdtZHXriXDLDUmnefWP
         iE5L0ylYIkGh3M3n5R9gmyBuDztSrQjT45tQEDxrcHs5wLOirLR7DKCQZ5Fcmw6xFow8
         EC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=IthdYJe60bFyURI0bdrVfgyUuZ54Csc/E5/4SXVUQtA=;
        b=q1R3oc+TjAr2gNuDPG9V1kEmOL2W6A8G63bpGa7o9KXvLDWghze2PJQk85Br1snUbX
         QTwqA3Msb2KcwBthZRmGbsB6MmM2IJCwbymFW6LWyBrEDWQxcLDWWuI8sTl8DQlKzm4I
         fUn8u21Zf8SNd4OL0qLURs95afdAnE0fkp6wml3n2Z5mm4ugWCpHNbmsS3cohrSf+Gzo
         jzq8bMRRx/kzh2HduRFEyfeobvGLB4rkVKB3CFM718D5HiIc0gWV6gGqmb+RsFpIXkZI
         4qxEHkKM3DrH2HInO175HXMUTrNtUw9vYwUCSUETciPOZFZgT7jMWOybtt1CXKoL8gue
         V5Bg==
X-Gm-Message-State: ACrzQf28xe1yQ8RaXdiYpNSCs9JKG0XXEgDw9Dync+AhYQRZ1RQoG/ei
        yfs68Uv6XV7hNqypuDhnN8FQ4hI3OOdjfg==
X-Google-Smtp-Source: AMsMyM5X+UdKAgDovIUm1VBIZQZuKINbBVW3CEw2rox32muSUdtkx7l67GN27zhkUSP5Qyalhs68Yw==
X-Received: by 2002:a17:90b:4c8f:b0:202:bcbb:1984 with SMTP id my15-20020a17090b4c8f00b00202bcbb1984mr7351573pjb.64.1663735063404;
        Tue, 20 Sep 2022 21:37:43 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:8a0f:392d:db19:673c:627a])
        by smtp.googlemail.com with ESMTPSA id t185-20020a6378c2000000b0042c0ffa0e62sm821182pgc.47.2022.09.20.21.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 21:37:42 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>
Subject: [PATCH v4 0/4] remoteproc: qcom: Add support for pronto-v3
Date:   Wed, 21 Sep 2022 10:06:44 +0530
Message-Id: <20220921043648.2152725-1-sireeshkodali1@gmail.com>
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

This patch series adds support for the pronto-v3 remoteproc found on the
MSM8953 platform. It also converts the documentation for wcnss to YAML.

Changes since v3:
 * Fixed example dt in conversion patch failing dt_bindings_check
 * Made sure patch series reaches all maintainers, v3's cover went
   missing

Changes since v2:
 * Fixed email for maintainer
 * rm qcom,wcnss-pil.txt
 * Add more details in commit message for qcom,pronto compatible
 * Fixed dt_binding_check errors

Link to v2: https://lkml.org/lkml/2022/9/8/1199

Sireesh Kodali (3):
  dt-bindings: remoteproc: qcom: Convert wcnss documentation to YAML
  dt-bindings: remoteproc: qcom: wcnss: Add qcom,pronto compatible
  dt-bindings: remoteproc: qcom: wcnss: Add compatible for pronto v3

Vladimir Lypak (1):
  remoteproc: qcom: qcom_wcnss: Add support for pronto-v3

 .../bindings/remoteproc/qcom,wcnss-pil.txt    | 177 -----------
 .../bindings/remoteproc/qcom,wcnss-pil.yaml   | 288 ++++++++++++++++++
 drivers/remoteproc/qcom_wcnss.c               |  13 +
 3 files changed, 301 insertions(+), 177 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml

-- 
2.37.3

