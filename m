Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A3A74ACB6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjGGIUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjGGIUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:20:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216711FE9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 01:20:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-314417861b9so1633716f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 01:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688718048; x=1691310048;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P7nX8phUtgvJlXBdE7HbRkDLu02J23oMaWSNoummNpM=;
        b=ZvRIDUsv9vIYR3vOfIKZHZ/QP+RFnql63YTQ2nv/Djpc5JuPK9rESNbVRWm4JJB6Hw
         kcxszPOe05wTw7dGH+e55op5+Lr9kOqpXCsbic8MTApQWi5qmCy5fQDI/Xo2MRKTRByh
         FOhDdF54NLDI8XZDEM0Co03nzublpIdqEbZhkFNvP9vIkM4dPSASny6nALE5HEU6jsLm
         ksl64aDAdJG5c3N9TsdmZqKF5riLzoXId8iPug1/hJaIJdM9upbbnKUZiNfOK63FHvz7
         /KH6Ss2y7OAGJ17mySEv4H1UoCYj9Wdgdq8ouvYEXgh7vdJ+dIxAsZYU/TDqUXryYE4U
         u4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688718048; x=1691310048;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7nX8phUtgvJlXBdE7HbRkDLu02J23oMaWSNoummNpM=;
        b=hOe1kPMNwWu76hpX6OtcWgMasTEdIQEk78nqGSaszsmDRcxBUIOHLhEyHg8Lx9F3LH
         twgGRdcYQevgO9MGSBMNhsrEO8dh5l/PmAs0uX0MmacgeDbq8Kpb507PjR37D+8DExxt
         WoMaEnRV5q5pzBRnRkKZ0dHCL59kbIcLWyHBxQzJdiKJ24RvrOMT6Iq5aGeRZ1FcxLHI
         +PV6qTJ8wLBuoTGQRAzF9m7TcQ5UyhprYfCHRdcfRA4Jx0GA6/X9zDok/LWXuFm1Lj9r
         ereFr49Mu2MeQVhxZGh3Yvw4uzpFIXL52zV9CxKEn3lxQjv5sDb8r52ZQkh+jFFDXwvR
         TLyQ==
X-Gm-Message-State: ABy/qLZI0mUCxaVaN+34uN0Svv9+UoJ3vlP/s2PTogQC2zDtKyzhbqek
        AV8E2UBVmj4DzrHREPAploQRbA==
X-Google-Smtp-Source: APBJJlHuX5vVM/UKRZ/aziETXd4ETuHeeEBeYfXppfJI2XzCYX/DyG4sM35yPGMIok5s9ak2Lm7IHQ==
X-Received: by 2002:adf:f711:0:b0:30e:3da5:46e5 with SMTP id r17-20020adff711000000b0030e3da546e5mr3619353wrp.59.1688718048582;
        Fri, 07 Jul 2023 01:20:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id a5-20020adffb85000000b00313e4d02be8sm3824395wrr.55.2023.07.07.01.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 01:20:48 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] dt-bindings: pinctrl: amlogic,meson-pinctrl-common:
 add missing properties
Date:   Fri, 07 Jul 2023 10:20:43 +0200
Message-Id: <20230707-topic-amlogic-upstream-pinctrl-fix-bindings-v2-0-2160060446d7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANvKp2QC/52NQQ6DIBREr2JY9zeIVtqueo/GBSLiTxTIh5o2h
 ruXeoSuJm8mmbezaAhNZPdqZ2Q2jOhdAXGqmJ6VswZwLMwEFw2XvIPkA2pQ6+JtyVeIiYxaIaD
 TiRaY8A0DuhGdjaDFIFvdNfIqBSuPgUzZD9uzLzxjTJ4+h3yrf+1/nq0GDpNqWzFelDK3+rGgU
 +TPnizrc85fDZYshucAAAA=
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1669;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=FyjsoTudixydC0nNMdjfVMOeLJOWeJk3gdhNn8W9tE4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkp8revvGyh8h+u4H2kef4fC9pa+RedPwKKGzXjMPa
 X3zF+TSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZKfK3gAKCRB33NvayMhJ0SUdD/
 9MuupduiPkUIemehndLwaP/EAV+x1a1xZQnKh3dtyAmELloWg7peQif3zlirC5c1BdctZJNfUF7lWe
 cSk3/9cFZdd+0FJ/ANgi2kadN+qJ6utMiOO9Na6SzHGnc/JHf68s9963iqzJ7wICkhMK88pz47r/ys
 tMKZWoqiv/Fr47twhZH0fLTf7OMslDxgDrWqtCcX5o4aWE+sYwTzmQkhJbsEx03LzlVvgX6isPa1Zq
 4kA1WIRF1IqvMXZo/PSDWaADi3njfrRPUuEFU1a0cIYMell5xK46CGFrLaN82s9o9Gd8IwBaeK2kNt
 xEHi4UwBMGP8IwuVca0nQG8UmWa4qbS+kQ9pDMI9nt0dlDslO840gQrh5MAmm/2udaBCsG+JdyUzLY
 M/52rnAqJMrOPRj/xQkbeIyWOSn5BMpKFnErnU8cTXYWDbQ7bJrOqYrz+SgDIcsjfKk8iM94s3lA3E
 N8SSJxhx63/GdkI7ztBpkmdPI0F0ouBjPJxf8C11QqDZIE/4Z+HyWdfOVxXn2D2FhU2Rf+QBaFrSOa
 dUOB9VDTVVeyOamlUfOwIe66aErXGXFvLgsgVmM1cNmtTRMLVlGZQJPB3NICdlq56bRqk67syeG0OU
 uLi17EtIDg+GERRxYKzcIuEJ77PFMa6hdwUzZDVTvK6IPkVBz21+lNeqIPRQ==
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

The amlogic DT uses gpio-line-names and gpio-hog, add those
to the yaml converted pinctrl bindings.

This will fix the following dtschema check errors:
arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dtb: pinctrl@40: bank@40: Unevaluated properties are not allowed ('gpio-line-names', 'usb-hub-hog' were unexpected)
arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dtb: pinctrl@4b0: bank@4b0: Unevaluated properties are not allowed ('gpio-line-names' was unexpected)
..

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Added review tags
- Moved line-names out of common and added min/max items for each bindings
- Link to v1: https://lore.kernel.org/r/20230706-topic-amlogic-upstream-pinctrl-fix-bindings-v1-0-fa442d5aae91@linaro.org

---
Neil Armstrong (2):
      dt-bindings: pinctrl: amlogic,meson-pinctrl: allow gpio-line-names
      dt-bindings: pinctrl: amlogic,meson-pinctrl-common: allow gpio hogs

 .../devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml      | 4 ++++
 .../devicetree/bindings/pinctrl/amlogic,meson-pinctrl-common.yaml  | 7 +++++++
 .../bindings/pinctrl/amlogic,meson-pinctrl-g12a-aobus.yaml         | 3 +++
 .../bindings/pinctrl/amlogic,meson-pinctrl-g12a-periphs.yaml       | 3 +++
 .../devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-aobus.yaml  | 4 ++++
 .../devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-cbus.yaml   | 4 ++++
 6 files changed, 25 insertions(+)
---
base-commit: e1f6a8eaf1c271a0158114a03e3605f4fba059ad
change-id: 20230706-topic-amlogic-upstream-pinctrl-fix-bindings-c2b74c637872

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

