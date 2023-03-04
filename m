Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F546AA8BE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 09:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCDInp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 03:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCDIno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 03:43:44 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ABC144B0;
        Sat,  4 Mar 2023 00:43:42 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id s22so6466133lfi.9;
        Sat, 04 Mar 2023 00:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677919421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AJtrzfOJXABRuUYLjgZ/Ez175EK3fM8iENZod5fhwR8=;
        b=WinwBLhM7Hm+M0unucjCo+y2Ad8hoeFi2wbWiTvba8357ZtHRXW9Kx15YS6kq4ITJI
         JcVh3ZZ+70Qnmdg1bkLj3q9NDWfTa9NuvC8S5VQGCrA5H4QNI/Rz7p67/BCzGLwHy3bI
         mn5tmcisrRdOBROPFM2i0PsXaK6qJn3QdpP6K/jWWUsgH+IxyyqoQFi99RMtU5xzQIDa
         yJJ0dPCeMtz1g8iaMmzVTiVHKNTy/8nHphrbzVzGLArnwlyPSiPHpghtrYFwshwMarCu
         Oj7dSip/jTfrqMjI5FlU3N7cxXPU9VlDIraGwbUfwePZeMcDwOKBu+34eRlJoMlFKwF6
         igIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677919421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJtrzfOJXABRuUYLjgZ/Ez175EK3fM8iENZod5fhwR8=;
        b=L9LYXeF4njA8nmMeMMEFVvcCercgRpxk6clYEysff7HdwILLDretcTozbDcJ53fYGQ
         Mkd3gDJ/OfZqsTpFLrSn8bUVsNwenZ9zesYZev8FstpFSukiFfExnbfqGnojsDAUoHzA
         JRJ5J3YKe9Xnt/RiYPEF8LB5gUUHoFpUwjPYxPOviR0iCzxnBRwbmZrWPo8JuiTydP4D
         EQ2igmJB/5Fg61l3iu9Jfa3PeY4eBVfgu3alr/+5eGibBmIadfgzZDUGfReksNyLGL//
         IiX1ai05gqKVliKkfHbRsaJwOToAXCQDDt9AjHy2sHkcMhSGSDhCJO8nMMiIP3ZM+fVh
         2IzQ==
X-Gm-Message-State: AO0yUKUgzUxIos9yTn4KxSx8CM1J0ak4++IgT+/bO6O9+HYN7T0v+H4t
        AYBjZ2shSRiCXf4v8jyNabw=
X-Google-Smtp-Source: AK7set9rkVhsQ0PDDIWYF5Jk85JFb8vw0NlB6ybsAPba0sBtCWP2qvK9KJmQGfB4WfvxgoiDuBx47g==
X-Received: by 2002:a19:a416:0:b0:4dd:a025:d8e with SMTP id q22-20020a19a416000000b004dda0250d8emr1247978lfc.47.1677919420598;
        Sat, 04 Mar 2023 00:43:40 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id u5-20020a2ea165000000b00293cc5f83b4sm693575ljl.27.2023.03.04.00.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 00:43:40 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Tegra DTS improvements
Date:   Sat,  4 Mar 2023 10:43:14 +0200
Message-Id: <20230304084319.18424-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Patches add labels into t30 and t114 dtsi for easier
node referencing. Quotes for mmc devices are replaced
with labels for better tree comprehension. Fixed 
accelerometer mount matrix for TF101. Added 266.5MHz
peripheral opp node for devices which may need it.

---

Chandes from v1:
- added missing sign-off

---

Anton Bambura (1):
  ARM: tegra: Add labels to tegra114.dtsi

Michał Mirosław (1):
  ARM: tegra: Add labels to tegra30.dtsi

Svyatoslav Ryhel (3):
  ARM: tegra: transformer: use labels for mmc in aliases
  ARM: tegra: asus-tf101: fix accelerometer mount matrix
  tegra30: peripherals: add 266.5MHz nodes

 arch/arm/boot/dts/tegra114.dtsi               | 48 +++++++++----------
 arch/arm/boot/dts/tegra20-asus-tf101.dts      |  6 +--
 .../dts/tegra30-asus-transformer-common.dtsi  |  6 +--
 .../arm/boot/dts/tegra30-peripherals-opp.dtsi | 20 ++++++++
 arch/arm/boot/dts/tegra30.dtsi                | 36 +++++++-------
 5 files changed, 68 insertions(+), 48 deletions(-)

-- 
2.37.2

