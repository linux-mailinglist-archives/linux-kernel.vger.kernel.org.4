Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EE560EFC4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiJ0GCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiJ0GCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:02:07 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5059792D2;
        Wed, 26 Oct 2022 23:01:54 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout4.routing.net (Postfix) with ESMTP id A8B4910094F;
        Thu, 27 Oct 2022 06:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666850512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lb7cH6d0uhpgKwi/q8Rz+TeYgmt5q7s0QqhDeERUfDw=;
        b=xcylABz939+HpHeG+PiIHNOaUsT52G3yaalInhmAEMN4Dt7JRtMRVLU9VcqsafXXYhXeyY
        1JbFZLtpHLAsWtb0j75/vlH4VeQkr5q5NsVoUfF/bY/eFlDxv4xfOCAPHPeqbfxZ4S0Be4
        1BVVrYGsWNVZ2ecMCSTuG5a7gjPJblg=
Received: from frank-G5.. (fttx-pool-80.245.77.6.bambit.de [80.245.77.6])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id C9DAA405D6;
        Thu, 27 Oct 2022 06:01:51 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] support PCIe on mt7986/BPI-R3 (DTS)
Date:   Thu, 27 Oct 2022 08:01:40 +0200
Message-Id: <20221027060142.6354-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: fcc91801-ff5f-40bc-b091-068cab1f2dc3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

After PCIe binding got reviewed here the last 2 PCIe Patches for adding
DTS nodes to mt7986 and bpi-r3.

based on:

rework mtk pcie-gen3 bindings and support mt7986
https://patchwork.kernel.org/project/linux-mediatek/list/?series=688557

Add BananaPi R3
https://patchwork.kernel.org/project/linux-mediatek/list/?series=688984

Frank Wunderlich (1):
  arm64: dts: mt7986: add pcie node to BananaPi-R3

Sam Shih (1):
  arm64: dts: mt7986: add pcie related device nodes

 .../dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi | 17 ++++++
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts  | 16 ++++++
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi     | 52 +++++++++++++++++++
 3 files changed, 85 insertions(+)

-- 
2.34.1

