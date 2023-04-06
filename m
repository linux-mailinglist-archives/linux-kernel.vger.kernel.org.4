Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9956D8F13
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbjDFGJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjDFGIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:08:53 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736ED7DB2;
        Wed,  5 Apr 2023 23:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NNtznzskect+WASX9KWJsUPMsb4GCWve9v8phcfY6EE=; b=NhiFkK7+qKrc3ZFiSZfO5ZFMGk
        XKHPldEXr6zJYfn+KjGfo2L5t0PFvk5tFE+zMMoTwmeJWvTZAoRd2memCDeECm/kQfLJcyMn166t5
        fkw8LPk3QIShCNUwkVheNc8G//xCp/M4C3j+PW3o0iKw8CjjrWAtRvrXPhNIUNCm+BfZx5LX/yANa
        TcZZ5Rix4esq9tlXs3b1zvjH2e5Guet2ZLao2plJXcAYTP0r3rgzhKIyY8k6jBE8hbCGVAI1VMuR5
        V4m8itU1W4BubGdbD526JCGHMNo82Uh842YXV1+bTg81uFJb/89LULJ2NQnIEX29Mipr1uEoNftiE
        iE8J6Nyw==;
Received: from p200300ccff190e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff19:e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pkInc-0001dh-DZ; Thu, 06 Apr 2023 08:08:44 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1pkInb-000Qqa-3D;
        Thu, 06 Apr 2023 08:08:44 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andreas@kemnade.info,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mazziesaccount@gmail.com,
        hns@goldelico.com
Subject: [PATCH 0/2] leds: Add a driver for the BD2606MVV
Date:   Thu,  6 Apr 2023 08:08:23 +0200
Message-Id: <20230406060825.103187-1-andreas@kemnade.info>
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

Andreas Kemnade (2):
  dt-bindings: leds: ROHM BD2606MVV LED driver
  leds: bd2606mvv: Driver for the Rohm 6 Channel i2c LED driver

 .../bindings/leds/rohm,bd2606mvv.yaml         |  76 +++++++++
 drivers/leds/Kconfig                          |  11 ++
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-bd2606mvv.c                 | 145 ++++++++++++++++++
 4 files changed, 233 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
 create mode 100644 drivers/leds/leds-bd2606mvv.c

-- 
2.39.2

