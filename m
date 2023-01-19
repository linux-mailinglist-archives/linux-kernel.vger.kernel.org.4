Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95196731E4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 07:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjASGmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 01:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjASGl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 01:41:58 -0500
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 22:41:54 PST
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4161E65F17
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 22:41:51 -0800 (PST)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230119064043d647a6cda002cb9c0d
        for <linux-kernel@vger.kernel.org>;
        Thu, 19 Jan 2023 07:40:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=XR5dnXnAVuyJ1YzhFuZwj9lsBP3CE7JnAirBt+HixVU=;
 b=IywdLM0ZrTM5xhneF5HG9vkgGN0gdXIiVppU2IScARDiS73PyrcOylXuQ8kbnGWuFjeG6A
 95R9upyyJii1NA6b0054TnL4/Fe5hYPzpS883YhXYkd1Nx++T3yZFb2a1AdG/mdezaH8FD9T
 LZYwSG+bPQQ1JARwrrn0KYvSWOmBc=;
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: [PATCH v2 0/3] arm64: dts: Add IOT2050 M.2 board, describe QSPI layout
Date:   Thu, 19 Jan 2023 07:40:39 +0100
Message-Id: <cover.1674110442.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the devices tree for a new variant of the IOT2050 which comes
with two M.2 slots and is otherwise almost equivalent to the existing
Advanced PG2 variant (USB3 is available via M.2 now).

Furthermore, the device tree of the whole device series is extended to
also hold the QSPI layout.

Changes in v2:
 - alphabetic ordering in binding schema and makefile
 - dropped an unneeded blank line in patch 3

Jan

Jan Kiszka (2):
  arm64: dts: ti: iot2050: Add layout of OSPI flash
  dt-bindings: arm: ti: Add binding for Siemens IOT2050 M.2 variant

chao zeng (1):
  arm64: dts: ti: iot2050: Add support for M.2 variant

 .../devicetree/bindings/arm/ti/k3.yaml        |   1 +
 arch/arm64/boot/dts/ti/Makefile               |   3 +
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   |  46 +++++++
 .../dts/ti/k3-am6548-iot2050-advanced-m2.dts  | 121 ++++++++++++++++++
 4 files changed, 171 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts

-- 
2.35.3

