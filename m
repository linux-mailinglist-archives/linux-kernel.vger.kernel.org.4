Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7E96F2A4B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 20:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjD3SWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 14:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjD3SWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 14:22:11 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72111BCB;
        Sun, 30 Apr 2023 11:22:03 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 685FECA164;
        Sun, 30 Apr 2023 18:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1682878891; bh=EqCQmLnIkfv58mUVxR6jXSasRDJzVQotPjwU6fboKSc=;
        h=From:Subject:Date:To:Cc;
        b=GmGMwt3kCCu1el3ssohEaVoPdIB9JWRPPfbPDb5up6LdRM+XQnHANNS5zV6S+nw74
         DmKJWaW1Ec79/NazLzggj8zLGeo3D83ttpAxFgjIx4vmchPeLKBYBRj92Isg1dHVAA
         DlROko6TebF+4FnrgOys/195bmPgRARFaYKVKns4=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/5] Improvements for drv260x driver and add to Huawei
 Watch
Date:   Sun, 30 Apr 2023 20:20:52 +0200
Message-Id: <20230430-drv260x-improvements-v1-0-1fb28b4cc698@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAISxTmQC/x2NQQ6CMBAAv0L27JJSsKl+hXgoZZU9tMWuaTCEv
 1s8TjKT2UEoMwncmx0yFRZOsUJ3acAvLr4Iea4MWuleDb3CORdt1IYc1pwKBYofQdKdtbfBKX/
 1UNPJCeGUXfTLGb99ChgkWK0NmrZvv6e0Znry9n+Pj+P4AR51czqLAAAA
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=EqCQmLnIkfv58mUVxR6jXSasRDJzVQotPjwU6fboKSc=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkTrGdv/cLH2J33SfjK8Myr2s/aw9qaNnCnITdU
 65i/sEjS2OJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZE6xnQAKCRBy2EO4nU3X
 VuqkEADEOh+K7+K/jc3ONnTXDDtsyQ8jx9efM7Fuu9ZvKd0p2PsIB/vdMJUwBPacQGQzb5u2smv
 wYHeCAq7d0b4xi+pVvzD8AgCvwmunXAcDKef1tlOENSmbFD1sEYq+PpKPsdhVFvOrhhZo0WQZLb
 mHkiGegM+U0QGNaNfPVu6qPUBbb6LwzQPY8XEf9RdsPLKRw59NaV6TEkGxBBNlGGOPdL7U0moqo
 g1yJ2IMY1WVCcUc1Yp5Vm16NeLbtQmMfy4kjZqIAEjWo7REahShk3MXWcSJwsyDQYXjfqJAK2BT
 TXcqQu9J0R3IFKHhX4SF2RuTH0yymuqNBqNK7VWd/MS+hXbfzWNHjDG0jJQAvy+JTJVNdfeDtUa
 TaC0zH9CIkZlKmsFOTGaMHro7DzINlBMQe19sby9Wdddf/xoEqRc/DL9h4OGAEkNm+fznKltjKy
 os3q4zo/FAJY1Ku7HRkUmjODoBnTG+kwqSJb/eeW01hsAIFFavpnrIq39p0rBVPQ5eIgIwVJ5Ql
 HJDo8HDhmjS4eGpWr/F96gPEndmCDkdOkw6JI6ak60OdwKjXii1OWV6gF4EmxApH+bHRGajklzP
 YQjtz+OgK0qr9H241AXbxJBd26IS5Jrz4IObUyQn6V/hl/R9WQ8/4rUj2k3uAygejLi7ID4CAkY
 S+MfT4hjrG4GdSw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up some issues with the driver I've noticed while working on it,
then fix the magnitude handling which previously resulted the driver
discarding the upper 8 bits of the magnitude value, and finally we can
add the drv260x to the APQ8026 Huawei Watch.

While the "fix magnitude handling" commit technically changes behavior
and could change behavior of existing user space applications that deal
with this quirky behavior, it's definitely not correct and results in
very unexpected behavior if the user space doesn't look out for it
(meaning only use 0x00-0xFF magnitude, and also know that the magnitude
was interpreted as signed value, see more details in the commit message
there).

There's currently only one other upstream user of the driver,
qcom/msm8996-xiaomi-gemini where I've added the dts authors to this
patch series (Raffaele & Yassine) and some tests on that device would be
nice since it's operating in LRA mode, mine does in ERM mode.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (5):
      Input: drv260x - fix typo in register value define
      Input: drv260x - sleep between polling GO bit
      Input: drv260x - remove unused .reg_defaults
      Input: drv260x - fix magnitude handling
      ARM: dts: qcom: apq8026-huawei-sturgeon: Add vibrator

 arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts | 28 +++++++++++
 drivers/input/misc/drv260x.c                       | 56 ++++------------------
 2 files changed, 37 insertions(+), 47 deletions(-)
---
base-commit: fa55d47c433364df7361fd4f9b169b5845b06914
change-id: 20230430-drv260x-improvements-e218894a0c5c

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

