Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F61C70BCD7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjEVMCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjEVMCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:02:10 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0444AE6D;
        Mon, 22 May 2023 05:01:44 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ab094a7c04so2304903a34.3;
        Mon, 22 May 2023 05:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684756903; x=1687348903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Moy/ony+EdvX1jz/+oyrc2kgrzZqbM469cSFPKr3hEA=;
        b=VvAfmXGG4LCS2blRvuSOMomTO9QVwnC5r8y27s4kEIYsxT3JDc8iWUcx658Aaw15fz
         VeQQA+E0iefer7hNm+uuY6YRGYNOYGaH72MtVOZ0TDxL5HA57I2sA/p8nIFpt+Ke1rWX
         gbBaM+YcJM+Mc/aGgvSyF86S3FBOUkRjxuG9nCDebNMuruPtLG0QT6/BhqLvnzu0fJDM
         cbJ9bw8ZGYn8l0Ce3HDAPOqRYr6yx+qWaxvXJO3LwSKLjv8Gylw9pgopLkC+hLjRqeg1
         /ieqOBLAonZnu5477xPpllgMaHhpndNL1hcSogtDPqDhywZF1DimaTGcKD6mMrGkou5X
         aAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684756903; x=1687348903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Moy/ony+EdvX1jz/+oyrc2kgrzZqbM469cSFPKr3hEA=;
        b=VZr85FaTEGcu/+bliabUV3Jw0TKWJUHYUGWCC3KrCgGqefiiDGjQ4hVurd2X+cT8mL
         3RzzEtXyrw718fN+FXELUmlJcyXXb0hcnTL8t50Fyp7NIRmDivhqPd88lr/6H+/q/DS0
         zxy9l3ybfrkMKRUjjoi42UtbJhG2olnVbaAQYDEhJmG9LFyrBPwCn+MRjZ4Bqhhasdxx
         tbyKg/Vi6JVlEDLTKpiafzpER77FDLjmWcNJ2Rmnx0WO/1FQMQMfzQ6AsQ+Vaj24kpsO
         DffthDe9Ci35n821cloQjUITBNLxbCSwmqa5+ywF9axQfYRZNhPIRZoIjpfIpDxHhxAZ
         rCIg==
X-Gm-Message-State: AC+VfDz6In7AQQ5xTPUg/HT6bqWs/VeLmynoTzuYghfClZBMTW8kvCIS
        41bZV+ogih1VfgDev5gehyZixZm4aIIXQGEHpgD2tTpE
X-Google-Smtp-Source: ACHHUZ7m/P2pSYKi3l1YeYP1uJEyK84GWpko5Gc1wppzDZ2LUrEyupnGeX/KdrijLb20qeoNIT8WZMODgMFvhAg/7pE=
X-Received: by 2002:a05:6871:543:b0:17f:7388:4c69 with SMTP id
 t3-20020a056871054300b0017f73884c69mr4956438oal.30.1684756902233; Mon, 22 May
 2023 05:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230405215328.3755561-1-bb@ti.com>
In-Reply-To: <20230405215328.3755561-1-bb@ti.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 22 May 2023 14:01:30 +0200
Message-ID: <CAH9NwWcCyApw2Qp3bd_1uBJQ0gEXewmSg9oY4QQUg_X_+5+m-Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] add VTM nodes to TI's K3 SoCs
To:     Bryan Brattlof <bb@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keerthy <j-keerthy@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Am Do., 6. Apr. 2023 um 00:01 Uhr schrieb Bryan Brattlof <bb@ti.com>:
>
> Hello again everyone!
>
> This patch series adds in basic VTM nodes for all of TI's K3 SoCs. As of
> right now these do not do much other than add thermal entries into the
> sysfs directory and power down the device once it exceeds a critical
> temperature.
>
> Changes from v1: [0]
> - Fixed indexing of thermal nodes[0]
>
> Changes from v2: [1]
> - Updated unit address for am62x's &cbass_wakeup
> - Dropped my j7* patches and cherry-picked Keerthy's
>
> [0] https://lore.kernel.org/all/20230119221322.12563-1-bb@ti.com/
> [1] https://lore.kernel.org/all/20230120003051.9100-1-bb@ti.com/
>

What is missing to get this series landed?

> Thanks for reviewing!
> ~Bryan
>
> Bryan Brattlof (3):
>   arm64: dts: ti: k3-am64-main: add VTM node
>   arm64: dts: ti: k3-am62-wakeup: add VTM node
>   arm64: dts: ti: k3-am62a-wakeup: add VTM node
>
> Keerthy (4):
>   arm64: dts: ti: j784s4: Add VTM node
>   arm64: dts: ti: j721e: Add VTM node
>   arm64: dts: ti: j7200: Add VTM node
>   arm64: dts: ti: j721s2: Add VTM node
>
>  arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi   |  33 ++++++
>  arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi    |   8 ++
>  arch/arm64/boot/dts/ti/k3-am62.dtsi           |   8 +-
>  arch/arm64/boot/dts/ti/k3-am62a-thermal.dtsi  |  47 ++++++++
>  arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi   |   8 ++
>  arch/arm64/boot/dts/ti/k3-am62a.dtsi          |   2 +
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |   8 ++
>  arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi   |  33 ++++++
>  arch/arm64/boot/dts/ti/k3-am64.dtsi           |   3 +
>  .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |   9 ++
>  arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi  |  47 ++++++++
>  arch/arm64/boot/dts/ti/k3-j7200.dtsi          |   2 +
>  .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |   9 ++
>  arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi  |  75 +++++++++++++
>  arch/arm64/boot/dts/ti/k3-j721e.dtsi          |   2 +
>  .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |   9 ++
>  arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi | 101 ++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j721s2.dtsi         |   4 +
>  .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |   9 ++
>  arch/arm64/boot/dts/ti/k3-j784s4-thermal.dtsi | 101 ++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j784s4.dtsi         |   4 +
>  21 files changed, 520 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-thermal.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-thermal.dtsi
>
>
> base-commit: 891db0c48efb48c3af334006f9d7ea6a0aa49cb9
> --
> 2.40.0
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
