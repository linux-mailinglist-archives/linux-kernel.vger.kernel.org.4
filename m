Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EAC5EF396
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbiI2Khn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiI2Khl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:37:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6346A13D1DC;
        Thu, 29 Sep 2022 03:37:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u59-20020a17090a51c100b00205d3c44162so5539108pjh.2;
        Thu, 29 Sep 2022 03:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=VVaJ2WvZLMburg2aIHfT+C0+FDmiDT6jJc/acM+nMq0=;
        b=drW2YEOywaDzYsNVrPwnW7g8e2Yrl+NdE4q8o7pU/qEMabkWBS6deJ2LxhBoxfMjdh
         Maxj+d/WUnaKRWiiYe9W1dvC+DrqDd/VVhI1z+w90t2hkWRqEg4cl55VHrb7irt+YI2l
         /d1QfW5JQt+hn2Mm7UvXb4lqitpJ19krNN/TGERxcGsURkyANaoRzG8lR594UJISRyRd
         nRCzT0Nw15KzcC2swKnoqYKvre99VDKxzeaq/2IDLNwJSzOsjUL6xq6pg7luGFPFiJs3
         QQHyedLjRxDxXYUzHBNcsdrvQul/OfVdSHMRYVKI1WP5fPSsZ0MNA4/HwwxmJ4gO+Y5x
         rm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=VVaJ2WvZLMburg2aIHfT+C0+FDmiDT6jJc/acM+nMq0=;
        b=jUP09V49L7fhg5h86E31HjbO9J+bI6jOLkFessjtCmb6NSOb+2CVsztd+HZo+bYHly
         +qEkTw1eDSfWOK7opN33/gKBP3l8umO/RyEmZDaXnJU5WdZQbK6XzHxoEy6YVUwI4xSi
         CCS9uwHxom28UupjHmac39PFoc7sNiVeDPhKO+5wKvkPL+npWeK/WFTmDlBGnadwH0YU
         SLezhRB3mjPu5fRtx8ra58kHimkt6fdtKSedWp+0RgwIYHIWj0eN2ZvXxp7TifDeIAiV
         t040F/Q+aJ2HNf/iSos/0bCsJg18FXuHNw4E+vQ0tv02/2KykG3F4PepNT/4UXm1qIDs
         0eiQ==
X-Gm-Message-State: ACrzQf0yy7BJmqE50zMi40Fitw7SO+sxoGFrxuz+sbQ6h22sv6wofoSE
        0l8ObLieRyvvwrKfm+VJz1o=
X-Google-Smtp-Source: AMsMyM4bvI8f8h6erzxSMgCphGbmfyqiiwBZb9eLfhOmAyvxOuiT93idYWlxYjxB6SeKN4lnBLdlPw==
X-Received: by 2002:a17:90a:d908:b0:206:122:35d1 with SMTP id c8-20020a17090ad90800b00206012235d1mr2874543pjv.245.1664447860821;
        Thu, 29 Sep 2022 03:37:40 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-73-73-54.emome-ip.hinet.net. [42.73.73.54])
        by smtp.gmail.com with ESMTPSA id k31-20020a17090a4ca200b001ef81574355sm3145861pjh.12.2022.09.29.03.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 03:37:40 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 0/2] Add Richtek RT9467 5A Battery Charger support
Date:   Thu, 29 Sep 2022 18:37:17 +0800
Message-Id: <cover.1664475743.git.chiaen_wu@richtek.com>
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

From: ChiaEn Wu <chiaen_wu@richtek.com>

This patch set is to add Richtek RT9467 5A Battery Charger support.

RT9467 is a switch-mode single cell Li-Ion/Li-Polymer battery charger
for portable applications.

It integrates a synchronous PWM controller, power MOSFETs,
input current sensing and regulation, high-accuracy voltage regulation,
and charge termination. The charge current is regulated through
integrated sensing resistors.

The RT9467 also features USB On-The-Go (OTG) support. It also integrates
D+/D- pin for USB host/charging port detection.

This charger driver is based on a 'linear_ranger' queued patch which adds
'LINEAR_RANGE_IDX' macro for declaring the linear_range struct simply.
https://lore.kernel.org/all/20220920161218.dkkfvfomrruebahi@mercury.elektranox.org/

Thank you,
ChiaEn Wu

ChiaEn Wu (2):
  dt-bindings: power: supply: Add Richtek RT9467 battery charger
  power: supply: rt9467: Add Richtek RT9467 charger driver

 .../power/supply/richtek,rt9467-charger.yaml       |   83 ++
 drivers/power/supply/Kconfig                       |   19 +
 drivers/power/supply/Makefile                      |    1 +
 drivers/power/supply/rt9467-charger.c              | 1239 ++++++++++++++++++++
 4 files changed, 1342 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
 create mode 100644 drivers/power/supply/rt9467-charger.c

-- 
2.7.4

