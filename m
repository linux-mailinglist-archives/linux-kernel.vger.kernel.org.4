Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3463461DBB0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiKEPdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKEPdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:33:40 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598D4C75D;
        Sat,  5 Nov 2022 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=6rfZ0+MVQCixP+2u55j4i4SsY6z48ejiPHC0AtI1mbw=; b=iemQmT3liHFJc0ZsdB/GUBwrxs
        wMEFdfObOoMgpXpBvDGAOuriqzvc0RmX+nhcH3+fDzQJMtWzUsPkYP354iRCFyf31UVmyO+3oONiT
        2dxA7Kx5LTUihtn7Avw+/Bmh45hyokn5KVnPxHqm4wOSGpz3UrhfBb9jAYN4ZrJk7q7HDJliPLmB9
        qo4yO/HrsCiYuLDv51WkrPEfSBs/miVkcbUIvysNuKgFOLPiMrDCMVHmNxy0d7zTa2HeNGDFN4xyO
        fsRMsTPfY9usXh79QnRllvpnZVs/KCBh3AYcYcbwt7R2rLVF7+Ee9lTZIaYkgDOwi0+k9jxwZ/Eqa
        KhfR5ivQ==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <bage@debian.org>)
        id 1orLAp-004CNe-Ak; Sat, 05 Nov 2022 15:33:30 +0000
From:   Bastian Germann <bage@debian.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Bastian Germann <bage@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] arm64: dts: allwinner: a64: enable Bluetooth on Pinebook
Date:   Sat,  5 Nov 2022 16:33:18 +0100
Message-Id: <20221105153319.19345-1-bage@debian.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Debian-User: bage
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pinebook uses RTL8723CS for WiFi and Bluetooth. Enable BT in the device tree.
This was part of a patch series adding RTL8723CS Bluetooth support to btrtl.

Changelog:
  v2: Fix subject
      Drop misleading I2C sentence
      Add enable-gpios to bluetooth device tree node

Vasily Khoruzhick (1):
  arm64: dts: allwinner: a64: enable Bluetooth on Pinebook

 .../boot/dts/allwinner/sun50i-a64-pinebook.dts     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.38.1

