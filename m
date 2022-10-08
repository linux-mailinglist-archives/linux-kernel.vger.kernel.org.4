Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97DE5F861E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 18:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiJHQ4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 12:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJHQ4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 12:56:34 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E00111D;
        Sat,  8 Oct 2022 09:56:33 -0700 (PDT)
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
        by mxout2.routing.net (Postfix) with ESMTP id 697236045F;
        Sat,  8 Oct 2022 16:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1665248191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=05laW2U2aanX1BnyvNjeBV2y8hpKydG+cBolNRJxwCM=;
        b=vqT4Hf95SJowAj4HZsWr9ud9xmbd7UHIfIQ615bWtpsYUSzYjYiRO4zOTHNGzLq5TiqoiH
        wTDgh2Kp6fkquj8gKwQkIoPHrGYFWTXmYWP6+6KVr8Qa6hp5IwmdeyP61LxNUjgfAIyODK
        VxRZ2a/pIm/u35nhx2FvJN2SaYZz5jY=
Received: from frank-G5.. (fttx-pool-217.61.149.60.bambit.de [217.61.149.60])
        by mxbox4.masterlogin.de (Postfix) with ESMTPSA id 86A5F80098;
        Sat,  8 Oct 2022 16:56:30 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add mmc-support for mt7986
Date:   Sat,  8 Oct 2022 18:56:25 +0200
Message-Id: <20221008165627.114782-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 58070d61-a93b-4ada-813c-c801ba3c1945
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This small series adds dt-binding and driver change for supporting
mmc-controller of mt7986.

Sam Shih (2):
  dt-bindings: mmc: Add compatible for Mediatek MT7986
  mmc: mediatek: add support for MT7986 SoC

 Documentation/devicetree/bindings/mmc/mtk-sd.yaml |  1 +
 drivers/mmc/host/mtk-sd.c                         | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

-- 
2.34.1

