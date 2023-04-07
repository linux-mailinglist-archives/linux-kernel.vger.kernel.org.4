Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED7F6DA872
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 07:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjDGFJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 01:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjDGFI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 01:08:57 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2324C20;
        Thu,  6 Apr 2023 22:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/8ob2zKXGw6AFOuUFfRUi8yj3VGYr+2YVTkTpSoB8Pw=; b=HBfCzdSGMwdcXZuWaguxAzKqDZ
        faVN0pRzoOBhE3X5XnAw3y2tP4kvGD88TtdjZgk1wD1natpLVMFsCRPYp4WN8NdK0ZtUvp28zaT3/
        ehLH8EwnINCrqZ6SpF2+WN+l16uLm/AHHjlP/i1Zg1UGHPzaQgdIsLiQ3BLFMOQ6FrajdrvT3E53J
        1S04K7Of/h0Tm7JgYBfz/rOvyoL1VW4U/sC6x3qIcDwFxpPVUWuJ9ErwfDdqC7zfNAQbxufCbLmyX
        TMhFBfw8GWAskSaUWkmwt2MzTepnYF5H0rc0KOLj/JfidOmU15YK7W2RZxn5hs7T6cQgrmDGL+P5W
        6mV4dBgQ==;
Received: from p200300ccff0cf1001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:f100:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pkeKT-0003rz-O6; Fri, 07 Apr 2023 07:08:45 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1pkeKT-000iQg-15;
        Fri, 07 Apr 2023 07:08:05 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andreas@kemnade.info,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: [PATCH v2 0/2] leds: Add a driver for the BD2606MVV
Date:   Fri,  7 Apr 2023 07:08:01 +0200
Message-Id: <20230407050803.170773-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding description and the corresponding driver for
the BD2606.

Changes in V2:
- Add Datasheet link
- use fwnode api
- remove childnode count check, that will bail out
  anyways later.
- add enable-gpios to binding but not to driver due to lack of
  testing ability

Andreas Kemnade (2):
  dt-bindings: leds: ROHM BD2606MVV LED driver
  leds: bd2606mvv: Driver for the Rohm 6 Channel i2c LED driver

 .../bindings/leds/rohm,bd2606mvv.yaml         |  83 ++++++++++
 drivers/leds/Kconfig                          |  11 ++
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-bd2606mvv.c                 | 143 ++++++++++++++++++
 4 files changed, 238 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
 create mode 100644 drivers/leds/leds-bd2606mvv.c

-- 
2.39.2

