Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1256C61417C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJaXWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJaXWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:22:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EA614D04;
        Mon, 31 Oct 2022 16:22:08 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so8980433wmb.0;
        Mon, 31 Oct 2022 16:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HPln8cZrTJI9IlvTgVYiB81yc2/HZy8AJl6SALomc7g=;
        b=BhJwWNXyXjenkn7QmixrNbEGKTZCHfo6H15ehPc5UgDZz7h3Quypz83trXpYUAnoYR
         eHWb5386xWfKP0r1TiMis/lU/AvTJpqRxoKRXaS6q3AM5qhgvUmlTWNC+pSzCakl4e6O
         p5LbM6W5xjt16znhT55ahyJ+VEHVsCq2T0TerqTwQObuFLtroG8ZAiy9cGqgNtySqsuO
         JeFjzI1WWOLcQwcvNL0/DeS/o9KPCNp4QUTL5v3FAJgpkzTB64g0OvpjUwEVQwN5ZfE3
         2S+4Zo7RbSEQox0sAiR/EpH0wqsQiO8wgn+R1DS/PgDWSxf+HV8j/CMDiD/SU67V0NLs
         tnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPln8cZrTJI9IlvTgVYiB81yc2/HZy8AJl6SALomc7g=;
        b=0nF/XMPeM72k6lpL3JIfG9Q9SEdmP3H99CBNGhJE+vV72iLz5pBcfdj7WUsiazCmnD
         U3YzOblJ02kBBZdJfrpFSxSeF5SHtz/cc8W2HitlR9SIgeg/s8V+CGTLU4i68lXBxqGL
         PYFZyfWkXhTDCVZqbz2+r9CEqeSy0W/4CVwfY74QPfkv7w7wJO033vCHkFodVykTwxkZ
         fcFOBR98M42gsUgSrHCCpa+2J2kdAeCJihN5uss9Wo9j5nM+oPbYK9nd0PaHWU+1/9BG
         ALqsJTByHlyWPC0l6YGp7Phg67H71Ty7l5YphnZHfT1A5xT5ZKB0vVKc7AGML1xYxIq1
         PMqQ==
X-Gm-Message-State: ACrzQf39XrAXmFIJ6KNCS9VbzC6dfVBOJCid+TdZ5p8cU8pLqGHbbS7i
        gn0HU7TiN8qCjSBJTObmVKU=
X-Google-Smtp-Source: AMsMyM5eunrcrDDl+uT8jaqG6FVy7tSvokJkfl3aXVjR+vCeOtQ9jrV/L/qH4PnfoTKp/ZnXJVQs+A==
X-Received: by 2002:a1c:2743:0:b0:3b3:4066:fa61 with SMTP id n64-20020a1c2743000000b003b34066fa61mr20243785wmn.79.1667258526729;
        Mon, 31 Oct 2022 16:22:06 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:15da:d6ab:ec79:436])
        by smtp.gmail.com with ESMTPSA id l24-20020a1c7918000000b003cf7928e731sm2190343wme.9.2022.10.31.16.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:22:06 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Shawn Tu <shawnx.tu@intel.com>, Jacopo Mondi <jacopo@jmondi.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 0/9] media: i2c: ov5645 driver enhancements
Date:   Mon, 31 Oct 2022 23:21:53 +0000
Message-Id: <20221031232202.131945-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

The main aim of this series is to add Runtime PM support to the sensor
driver alongside some cleanups and fixes.

v3 -> v4
* Fixed comments pointed by Sakari for runtime PM patch
* Fixed spaces for example node in DT binding
* Fixed comments pointed by Marco
* Included Acks from maintainers for the DT patches

v2 -> v3
- Included patch#1 [2] as part of this series
- Patched all in-tree DTS for dropping the clock preoperty to
  avoid dt warnings
- Fixed review comments pointed by Sakari and Laurent for the Runtime
  PM patch
- Now sending the error code of first error while stream off.
- Included RB tags from Laurent

v1-> v2
- patch #1 is infact a v3 [1] no changes
- patch #2 fixed review comments pointed by Sakari
- patch #3 [0] no changes 
- patches #4 and #5 are new

[0] https://patchwork.linuxtv.org/project/linux-media/patch/20220927202005.750621-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[1] https://patchwork.linuxtv.org/project/linux-media/patch/20220919153540.178732-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[2] https://patchwork.kernel.org/project/linux-media/patch/20220919143350.176746-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar


Lad Prabhakar (9):
  media: i2c: ov5645: Drop fetching the clk reference by name
  ARM: dts: imx6qdl-pico: Drop clock-names property
  ARM: dts: imx6qdl-wandboard: Drop clock-names property
  arm64: dts: renesas: aistarvision-mipi-adapter-2.1: Drop clock-names
    property
  media: dt-bindings: ov5645: Convert OV5645 binding to a schema
  media: i2c: ov5645: Use runtime PM
  media: i2c: ov5645: Drop empty comment
  media: i2c: ov5645: Make sure to call PM functions
  media: i2c: ov5645: Call ov5645_entity_init_cfg() before registering
    the subdev

 .../devicetree/bindings/media/i2c/ov5645.txt  |  54 -------
 .../bindings/media/i2c/ovti,ov5645.yaml       | 104 ++++++++++++
 arch/arm/boot/dts/imx6qdl-pico.dtsi           |   1 -
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi      |   1 -
 .../aistarvision-mipi-adapter-2.1.dtsi        |   1 -
 drivers/media/i2c/ov5645.c                    | 148 +++++++++---------
 6 files changed, 179 insertions(+), 130 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov5645.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml

-- 
2.25.1

