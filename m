Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1202B748310
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjGELmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGELmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:42:01 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2A7E3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 04:41:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso10049602e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 04:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688557318; x=1691149318;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sMJ6FKAxt5aeLYEDLDIBzRmbAeHURPB2a+Jv2R6yB5o=;
        b=Eum0AUAO4MzZIKlqJpbVv/iyrRnLHrjCVycK4SYdR+5ulihbU1FrybsJ9Url+WlO4X
         XXxexF4uVC4bU5pfF7DpmKbBzJPifHUC99H5Qf6XV3KYh6NSz1qUgHp1JLlw+rO4rJrg
         wOX2IRVRNt/SG7bNPHfY7bPABKAJwsPI71RBeNM0oR7rVySvuNDOCQyduW6iSLyy+nHt
         R1SHuASGzWIO7xggzPX2JoO/dIBx09LYBVC43HqC/YUmmwyXWhzNxXaVJhhxxUmz/Ch+
         KqTxrpKFpGZY7s/9KJDg/qnkWp5tg+0nl/bWUSK3h0ldmoCvakxlne6RXjVzqXsoYHw1
         p94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688557318; x=1691149318;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMJ6FKAxt5aeLYEDLDIBzRmbAeHURPB2a+Jv2R6yB5o=;
        b=Ga/22bG+oBzhnwD1FijNhTWAh85oiqGqGrwGOENlWOdak79SOt1nxZqz1+JEan+1W2
         ZKIzKU5+hHlPkT15RZ0rYNY1NePIUanKG9YMAT4nBSOQkkZLDtqVBXJddxhpjrRBhPGz
         FUD/CnzwMytb4iAort+jajEq1H5pgnBW5cycBx3I1M39mOgZUDmfYapj/VsuBLH1NW/X
         O5HvVZn8mIcxqYvoT6Mo0LbKNhfjIVICHS4vpWKrq+6HxECV/3tq39uleSuUgUbEfQ/A
         X2rU+h2yuq860ai/a4p1/enRPiRdUP70NGqhk5lk6wV8ne4VLoHIomG0HFFSUyNo6Mvd
         Ryrg==
X-Gm-Message-State: ABy/qLbhi8TWxLtPudh6meUHZcXr2wr+uJcaX7bZOBNFy31XVl/fDVpT
        nOK8Phdt5jTw+8yHsuYAVCC5CaCrc+TiVvb9t0CKDUck
X-Google-Smtp-Source: APBJJlHa+BfgKaDM7NfCIrIB8hb+SDF0DRd8E0ScKjkVKVN2VeH5zW7K9FHJQuF8NU3q3eW8tLoscQ==
X-Received: by 2002:a05:6512:3d09:b0:4f8:6d54:72fb with SMTP id d9-20020a0565123d0900b004f86d5472fbmr13766644lfv.62.1688557317821;
        Wed, 05 Jul 2023 04:41:57 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c028800b003fb416d732csm1916808wmk.6.2023.07.05.04.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 04:41:57 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/3] dt-bindings: second batch of dt-schema conversions
 for Amlogic Meson bindings
Date:   Wed, 05 Jul 2023 13:41:50 +0200
Message-Id: <20230705-b4-amlogic-bindings-convert-take2-v2-0-22be915ddc3b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP5WpWQC/5WOQQ7CIBBFr2JYO4bSLsSV9zBdAB3oRAQzVKJpe
 nexN3D53uK/v4qCTFjE5bAKxkqFcmqgjgfhZpMCAk2NhZKql0pqsAOYR8yBHFhKE6VQwOVUkRd
 YzB0VoHLGn7FzXe9F27GmIFg2yc1tKb1ibPLJ6Om9h29j45nKkvmz/6jdz/6TrB1IcINHLQc9o
 dfXSMlwPmUOYty27Qsa11jZ6AAAAA==
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1879;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ELXNXQ2lCoHuiuKKR6vdSI7dEdq5DYtEahIi1J2eLN4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkpVcDjQWnGo3L1uu76syI1GtIv82Y4ql5xMKgg1RS
 xN/ZWgGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZKVXAwAKCRB33NvayMhJ0SpvEA
 CIfPQmKspuKclTFFdRIGB5QTmUJZm1bShKqV39aY4xWbA9WX3zwMQbV/GsurFMjpi38bo3FVrFhdqi
 SLI+E/9rGbFNMkAVEMlIq5f+/y/Owy1yZ0zJvDrtQPhBsH0O/aQ72xVWP6BC1ombHLphpQyu7XI/Bj
 /eh7gyDTNwLOWw1b+Qhkw/0UJ1x6qlwENPRaRh9GlDSjtVUl7mWpnuYM2QCzAHv7K0/cI+evOXX611
 ZS3WOS+ZdK3zfNwFHov95QCT2lUfJ1h/tqMHlV6Gjg/Pn6s9N+gj2SiQmAmKh3xq1CKEGrsGh2fZT2
 vXrhNcsHSypAInTTRBy/h1GQWJ0/FOFra3M4ITBnurQxCX777Eb8eLkcD7kVc9XOx0he/pkPf56gpx
 GaDXwJx9YHTBA8dnrsjPr6xXRXIglAbf2J9f0eJ2zlvOXNNR9IpQlGgaqIotjC5Wm591atQrSDpz+z
 K28FUGxpL9ChYtRdXwb/WC6VoFW9XSsvC+eI8uYd7hd/8WuMKA4LPKYaKglFNs/zYzci7dYaX0WjvX
 1aCQceL9EruzdD3/Qrezeq49AKUX9iwsP/3DTu99aFrIPL2fuwqP72Ky5T35qjbZVgbahrx+Z2xlWe
 5bGD9xZa/NcieJ3Bh07wDYfl7TofxACFzov/xdeKfakrud5udE1MEBOOSBiA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Batch conversion of the following bindings:
- amlogic,gxbb-clkc.txt
- amlogic,gxbb-aoclkc.txt

And in addition document the System Control registers top node.

DT fixups will be posted once those conversion are fully reviewed.

With this serie, the in-review and applied bindings documentation, the
the following arm64 compatible are yet to be documented in dt-schema:
 ['amlogic,axg-audio-clkc']
 ['amlogic,g12a-audio-clkc']
 ['amlogic,sm1-audio-clkc']
 ['amlogic,g12a-tohdmitx']
 ['amlogic,sm1-tohdmitx', 'amlogic,g12a-tohdmitx']
 ['everest,es7154']
 ['everest,es7241']
 ['ti,tas5707']
 ['linux,spdif-dir']
 ['gpio-fan']
 ['pwm-fan']

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- rebased on next-20230705
- dropped applied patches
- dropped example in clk bindings
- fixed clk bindings
- fixed sysctrl bindings and moved patch to the end
- Link to v1: https://lore.kernel.org/r/20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org

---
Neil Armstrong (3):
      dt-bindings: clock: amlogic: convert amlogic,gxbb-clkc.txt to dt-schema
      dt-bindings: clock: amlogic: convert amlogic,gxbb-aoclkc.txt to dt-schema
      dt-bindings: soc: amlogic: document System Control registers

 .../bindings/clock/amlogic,gxbb-aoclkc.txt         |  64 ---------
 .../bindings/clock/amlogic,gxbb-aoclkc.yaml        | 101 +++++++++++++
 .../bindings/clock/amlogic,gxbb-clkc.txt           |  53 -------
 .../bindings/clock/amlogic,gxbb-clkc.yaml          |  37 +++++
 .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml  | 160 +++++++++++++++++++++
 5 files changed, 298 insertions(+), 117 deletions(-)
---
base-commit: e1f6a8eaf1c271a0158114a03e3605f4fba059ad
change-id: 20230209-b4-amlogic-bindings-convert-take2-e2caf8e1c13f

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

