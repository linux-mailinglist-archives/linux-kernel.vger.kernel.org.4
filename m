Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A656E3BA2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 21:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjDPTrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 15:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjDPTra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 15:47:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC7A10F1;
        Sun, 16 Apr 2023 12:47:21 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v9so28746560pjk.0;
        Sun, 16 Apr 2023 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681674440; x=1684266440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Meto6gsXNk91gHx8C0HmnEYuyxHZvVGTyKoqO9PiMNc=;
        b=eJYqFrJGLk24WuxpY5JuFFW1v/FDUKlryz7xwHJakzKAdUk+S8VU0iiF5MekiOHc5o
         ur0UALCSXSovdVFI191ofEm/D3GC32OPO80FM+Wl2ols3dif7zxY3rHS4NPa4ErHJ1+e
         Im5jtiI1cWSha24rQLgrnFOHskXJ7t+6nZsR9DLrzGAEgZlcJqB4d+LaUObadc57YyKk
         Lk2zAkOK3KOtE/R+8xcoExUwApUmw8NiA+VOC0Ssmdklx0XPTFVNTfPCSE46CxX0BtJg
         j+lKuwjuySDz3Gq562LEvS4LvcuJiAcH+ymN0qB2auqXrbluYoNCoI83WhOYyhE/Rgoz
         0L1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681674440; x=1684266440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Meto6gsXNk91gHx8C0HmnEYuyxHZvVGTyKoqO9PiMNc=;
        b=G0kbFytODT+cCwT9UC6ruXTSK0CMPYUfsaLgR307lHjhHnw+FC4Nt8pw5xuCaXphEf
         bG3iX0ux78emTYYpW/au0grqE0PDNeKC6U+cKdtGyGhzPfOrJskGsYqNdE3IlVubkJWV
         HalWfWwKaaufOHpsXpywf4oNIxeHuKuXxQh67RHwC360FVYcvJOgRVQ2f+x0TMZ98w9+
         nfOiysf5y/AVcAPSoDhJlOE638kNUsrxSXOf7IKa+oWidOkxAgk8lXS3YJp5RVsY96Or
         0jRm/MBGzXk1gMYq0hhbWSxQwFCI0p08uKtnK2POmF7dAGY3ixeStMQm//PkUu3xhj+8
         qEgA==
X-Gm-Message-State: AAQBX9eNat8otMiSjWxlXfeJNbL/g68cqUdF+iW5CsPdil0lFC3fdYoj
        Izm1zrQrTwkaP9UsIljZMwAVlZr5NAtkvol1CRU=
X-Google-Smtp-Source: AKy350aKLugLJKCU9PBp1YlqTK5QgQQ9+hASlfM5JGJM0fpp7dQty4ffKT0yxtosQ52mF34G7YXYGA==
X-Received: by 2002:a17:903:454:b0:1a0:50bd:31c0 with SMTP id iw20-20020a170903045400b001a050bd31c0mr8920831plb.24.1681674440450;
        Sun, 16 Apr 2023 12:47:20 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.201])
        by smtp.gmail.com with ESMTPSA id jd9-20020a170903260900b001a69b28f5c5sm4490375plb.222.2023.04.16.12.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 12:47:20 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] clk: Add basic register clock controller
Date:   Mon, 17 Apr 2023 03:46:18 +0800
Message-Id: <20230416194624.1258860-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These clocks were provided in `include/linux/clk-provider.h`, but lacks DT
bindings. Add DT bindings for them.

v2: split clock controller and its clocks
v3:
  * rewrite commit message
  * rewrite descriptions in dt-bindings to describe the devices
  * fix format error of dt-bindings

Links:
v1: https://lore.kernel.org/r/20230414181302.986271-1-mmyangfl@gmail.com
v2: https://lore.kernel.org/r/20230416173302.1185683-1-mmyangfl@gmail.com

David Yang (4):
  dt-bindings: clock: Add simple-clock-controller
  clk: Add simple clock controller
  dt-bindings: clock: Add gate-clock
  clk: gate: Add DT binding

 .../devicetree/bindings/clock/gate-clock.yaml |  59 ++++
 .../clock/simple-clock-controller.yaml        |  39 +++
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-gate.c                        |  81 +++++
 drivers/clk/clk-of.c                          | 292 ++++++++++++++++++
 drivers/clk/clk-of.h                          |  26 ++
 6 files changed, 498 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/gate-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/simple-clock-controller.yaml
 create mode 100644 drivers/clk/clk-of.c
 create mode 100644 drivers/clk/clk-of.h


base-commit: 7a934f4bd7d6f9da84c8812da3ba42ee10f5778e
-- 
2.39.2

