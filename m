Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19B55E8610
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 00:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiIWWug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 18:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbiIWWud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 18:50:33 -0400
X-Greylist: delayed 2346 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Sep 2022 15:50:31 PDT
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765A5A0268;
        Fri, 23 Sep 2022 15:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pfvJ513xEuv8iXDNoGYIRg2YAS3obpRNQdZvIOCM8eg=; b=o+Gkqdq4QWxrzQO/05DchGBbyl
        oo6f/Q2IWcIG8f9EujS6xysMoWGeZIgJs8VZe3bxWxZ3uqQr2YNR6Ukwp3qREsBBl4kDTvq9a3McU
        +VkNPaBGUpCQxbCTxTGBjncKtYHPIkvk62soprDu1EO55cKnrcn4pgT6PjhPiTMJfVjoU35jy08Tl
        TSDwI1KoW3tXisGQQ8K9Cze34ncq4uFFsAyRP7HxYyhc/0lwY7FgBv4qWq5S68ItmGIpllKfbcCeE
        9EStNx/62sfWvJ/n7gXpRH0jcZvE1PZuodfAsf8+0eNVUxDqZXQwG8tq4zfowpiWBmOXb96WK3Wy/
        IJF9Cm4g==;
Received: from p200300ccff0974001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff09:7400:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1obqt9-0004Jq-Lk; Sat, 24 Sep 2022 00:11:15 +0200
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1obqt9-0070ol-5h; Sat, 24 Sep 2022 00:11:15 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, marcel.ziswiler@toradex.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolecrivain@gmail.com,
        m.felsch@pengutronix.de
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 0/2] ARM: dts: add Kobo Aura 2
Date:   Sat, 24 Sep 2022 00:11:10 +0200
Message-Id: <20220923221112.1671392-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a basic device tree for the Kobo Aura 2 Ebook reader.
It is equipped with an i.MX6SL SoC.

Andreas Kemnade (2):
  dt-bindings: arm: fsl: add compatible string for Kobo Aura 2
  ARM: dts: imx: Add devicetree for Kobo Aura 2

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/imx6sl-kobo-aura2.dts       | 556 ++++++++++++++++++
 3 files changed, 558 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6sl-kobo-aura2.dts

-- 
2.30.2

