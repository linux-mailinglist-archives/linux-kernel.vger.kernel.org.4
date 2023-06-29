Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9582742C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjF2Sno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjF2Snk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:43:40 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CBE2681;
        Thu, 29 Jun 2023 11:43:36 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout2.routing.net (Postfix) with ESMTP id DA0925FD39;
        Thu, 29 Jun 2023 18:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1688064213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xsKoa5ClLaGgZAsOra2e5wFriYLbf/iu32Moq+TLna0=;
        b=BsI6oEu+oq0P1beccCVZAJi9yGquXvGiWCzgXhi1bVhi5GiSG9VVdJBfn5C/BxzqNtBwBD
        MXUXaXMIKHRnefJ/f4Yo6FfntJWpLkbRrC7kEBlU/7/2lMTcuoMUnUr7yl5h7FB+8Xoln1
        eMoFqGlw6Ln0zzcLTomv7JasOQjZfGI=
Received: from frank-G5.. (fttx-pool-157.180.227.241.bambit.de [157.180.227.241])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id ABC2C10073B;
        Thu, 29 Jun 2023 18:43:31 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] Fix emmc hs400 mode on mt7986
Date:   Thu, 29 Jun 2023 20:43:16 +0200
Message-Id: <20230629184318.551317-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: bc943361-3c32-42ac-afa6-c1bf0ccbb437
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Eric boots linux directly from ATF without using uboot. In this corner
case clocks for emmc hs400 mode are not correctly setup.

Fix this by adding assigned-clocks and assigned.clock-parents to mmc node.

Eric Woudstra (1):
  arm64: dts: mt7986: fix emmc hs400 mode without uboot initialization

Frank Wunderlich (1):
  dt-bindings: mmc: mtk-sd: drop assigned-clocks/clock-parents

 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 10 ----------
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi         |  4 ++++
 2 files changed, 4 insertions(+), 10 deletions(-)

-- 
2.34.1

