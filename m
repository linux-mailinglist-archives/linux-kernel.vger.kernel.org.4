Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FA77279FB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbjFHIbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbjFHIbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:31:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9DD26B2;
        Thu,  8 Jun 2023 01:31:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-97458c97333so63473866b.2;
        Thu, 08 Jun 2023 01:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686213091; x=1688805091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jY0TqkytLM8ZaBdorQZOnJVO5Ap/VET/cHHd7xNrEGk=;
        b=ZGw7j+num/A3LhVGeRyKJVy+3ekygcrm/Ee08IxR+GGwphOJ6+3j6soddHHhRKpDiy
         TAjumcI6sFUN2xLvC0Fif+dj7NDNEPygaGxUSTHmtAwS+g4PnPKa+2Mg8dKyxyMcDSxg
         n2EGfaKk1rdkTW+WAdNrDAdDIapk820pPRQ+Wwb+Vdp0SSJOsqdGXBIdKczBt2/8rZDE
         fzedLMGjBHhzwfkiryiOQUvY0QkR7/KaKaaCDLj0jzoz9MEs/6MnQeN36MRphnderJ2p
         NwPPBN7y7xuDy6IOkbibn2/n+auf2m+/O7FSRYrf3H6nW3ZKcUO1lR/v/eZaFfvMBKTt
         kRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686213091; x=1688805091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jY0TqkytLM8ZaBdorQZOnJVO5Ap/VET/cHHd7xNrEGk=;
        b=dIL4748knDmatr7oKMaV9Tl0ll7AYxMEakB5Vz4+R/VuB8zry0ynL5PTwVMel8lerO
         3l3yWHypOyjZklgB0Ltn6+mbsYqMZM0kiiuYjeOqopGrdxIYXuzhoYfm8nczK6AZ8HNt
         HAG/EGEqWPhszJBpchHCgKVnalUe0/e52c1qcQsFYmvDO5js43H8/j6K89txkCwGEWFc
         fCcx0N5Rz0Vp7PtbkpLLukNpmiPKXftTfHrztsBo83yQB4mDw/daSnGg1DZMJw4n4Ft/
         P3O4J+2N+bZJ8XhusJgD6djt3peVn43mhk5pEzjjeB3+X/k8zFlavnmVJccOSeP+U34g
         S2WQ==
X-Gm-Message-State: AC+VfDw3qpqk+aOQN3fl0pEzo0blZvCuQSzYdjhP5Gvwcus/Okd7OWIV
        iV7xygXyWa7UmbR2vSzsWgs=
X-Google-Smtp-Source: ACHHUZ4Cz7kJedYsCUnlh1swxReqp1Ph4vnuY4RYpQexiA3uDVBxnozg95sZT9xzan8LyT7kPLL5Eg==
X-Received: by 2002:a17:907:7282:b0:974:31:ed74 with SMTP id dt2-20020a170907728200b009740031ed74mr7781715ejc.65.1686213090624;
        Thu, 08 Jun 2023 01:31:30 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id y8-20020a170906558800b00974c32c9a75sm373690ejp.216.2023.06.08.01.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 01:31:30 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, michael.roeder@avnet.eu,
        linuxfancy@googlegroups.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Shawn Tu <shawnx.tu@intel.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicholas Roth <nicholas@rothemail.net>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v5 0/3] media: i2c: Add support for alvium camera
Date:   Thu,  8 Jun 2023 10:31:13 +0200
Message-Id: <20230608083127.545750-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

This series add support for Allied Vision Alvium camera.
The Alvium camera is shipped with sensor + isp in the same housing.
The camera can be equipped with one out of various sensor and abstract
the user from this. Camera is connected via MIPI CSI-2.

Working on top of Ideas on Board (branch: ideasonboard/v6.2/isi)
I'm able to test the driver on imx8mp-evk.
I collect also some patches to enable HDMI on imx8mp-evk from Pengutronix
(branch: pengutronix-imx8mp-hdmi)

I collect the patchset required to enable ISI + HDMI on imx8mp-evk into
the following branch from Avnet Silica Software & Services EMEA [1].

Some documentation on testing ISP and ISI of imx8mp-evk here [2].

Thanks all for the great work!

Tommaso Merciai (3):
  dt-bindings: vendor-prefixes: Add prefix alliedvision
  media: dt-bindings: alvium: add document YAML binding
  media: i2c: Add support for alvium camera

 .../media/i2c/alliedvision,alvium-csi2.yaml   |   97 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 drivers/media/i2c/Kconfig                     |   10 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/alvium-csi2.c               | 3479 +++++++++++++++++
 drivers/media/i2c/alvium-csi2.h               |  485 +++
 6 files changed, 4074 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
 create mode 100644 drivers/media/i2c/alvium-csi2.c
 create mode 100644 drivers/media/i2c/alvium-csi2.h

-- 
2.34.1

