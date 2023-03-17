Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1EF6BE2E5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCQIRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCQIRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:17:10 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7186CD7C2D;
        Fri, 17 Mar 2023 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ShZIhxx3b2bmUH3tJxhB9VV6YIbZXgi+PEoctj65VYM=; b=GE+l9AJr8Pmkch8WJvie9/zXcZ
        jjCT+KodhsSroPp40/tD/SpE+zSy6aYbRYuuFMyquYX8AAWAGTCH4RER3zlg06ZROvJeVQSD8FU5m
        w92i34++XmimYl7jAK0kSyWprMhz6NGovgCXSU/HdE3uKQqLghJAUVDch9E0WF7s6GBIILytkDX0m
        8RwoyljsDIeqfDhQLSk2/7PM4HbC3+6Oi3VO4QUOp29tCnV3jfztzCcKgt0AvJFkNJKhSeFBjxpjl
        DVJCGZwSaeC8x388DsZ7t7ADv7mMmaAHMahZxpSJnbhPG1pogTJTHhGoKKu2/1EI0ECbkMDIPHlmn
        T7tIcuBQ==;
Received: from p200300ccff1235001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff12:3500:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pd5GA-00073H-3k; Fri, 17 Mar 2023 09:16:22 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1pd5G9-00A15O-C6; Fri, 17 Mar 2023 09:16:21 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, marex@denx.de, max.krummenacher@toradex.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 0/2] ARM: dts: Add Tolino Vision
Date:   Fri, 17 Mar 2023 09:16:16 +0100
Message-Id: <20230317081618.2387407-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a basic device tree for the Tolino Vision Ebook reader.
It is equipped with an i.MX6SL SoC.

Andreas Kemnade (2):
  dt-bindings: arm: fsl: add compatible string for Tolino Vision
  ARM: dts: imx: Add devicetree for Tolino Vison

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/imx6sl-tolino-vision.dts    | 490 ++++++++++++++++++
 3 files changed, 492 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6sl-tolino-vision.dts

-- 
2.30.2

