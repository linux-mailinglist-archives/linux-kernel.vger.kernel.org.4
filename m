Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39936985B0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBOUho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjBOUhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:37:36 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F493B3C4;
        Wed, 15 Feb 2023 12:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=e/h7Jd3Bftz4I/V3GwkrnB37sFuV2tm61VzgB83k3L4=; b=OffNwXDw2cmv09Gyr4ScW2cmR8
        ddg010JHL6upKIJS4YL0BLf8upSmjs0nkBYuycSPCIadhCthTA2OEyUAD7WrEWSrOTD/jBIFtip0O
        y9mYrS1MDbym6lMeKM7aN9N3OkLrRe838X02Oh7HRxUXTSoev4o2Ex0dL4NV9i2V4gk6ROQ88Yr4L
        L6CecifHmbvpBDCN0DDtSaAx3mxcJt15rWoEokXcRu1WwJ70FULOBRfb8qvGyTJ9glwwfOrNbayEK
        8893zclLjf36lU5GfinPl02IIz6VkH4byI7ZmYMdMhokXq2snKBBiBR41fIrI4NAomTbv1EwVaReW
        HijuX0KA==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <bage@debian.org>)
        id 1pSOWi-002j5f-B0; Wed, 15 Feb 2023 20:37:16 +0000
From:   Bastian Germann <bage@debian.org>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     Bastian Germann <bage@debian.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/5] Enable hwlock on Allwinner A64
Date:   Wed, 15 Feb 2023 21:37:05 +0100
Message-Id: <20230215203711.6293-1-bage@debian.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Debian-User: bage
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allwinner,sun6i-a31-hwspinlock compatible driver can be used with
the Allwinner A64 chip. Add the wiring required to enable it.

The device tree binding needs some work to verify everything that is
needed by the sun6i hwlock driver.

The hwlock device was verified to be available with this series applied
on a Pinebook.

1/5 was already applied in linux-next.

Changelog:
v2:
   Fix the dt-binding example for the added properties.
   Add a compatible string for a64.
   Wording 3/5: driver -> Linux driver.

Bastian Germann (5):
  dt-bindings: hwlock: sun6i: Add missing #hwlock-cells
  dt-bindings: hwlock: sun6i: Add #hwlock-cells to example
  dt-bindings: hwlock: sun6i: Add missing names
  dt-bindings: hwlock: sun6i: Add a64 compatible string
  arm64: dts: allwinner: a64: Add hwspinlock node

 .../allwinner,sun6i-a31-hwspinlock.yaml       | 21 ++++++++++++++++++-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 11 ++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.39.1

