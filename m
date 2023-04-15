Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA0A6E32F8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 19:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjDORpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 13:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjDORpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 13:45:53 -0400
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE99F35BC;
        Sat, 15 Apr 2023 10:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
        Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=q317E9ttFjaV3lxeQeleXspRU/V37RKs/NzArvF5HRc=; b=D
        FSEorSXV24+JVHYefT6cud47W7VPA5g+KN3HD2EASILCZAzxSAXW+ATFtj66Iv43Q4IDapyquDcli
        AnmHS1EW3ip34beRVBdzxBVez1bkTt/u9huOOpkFL7cofLC7o2e+ziSWE9zIoanfBgFmUmdNwQSzO
        AK45puN/mmihLMQCA6YM+SwO4WUipiW9N9zJ3DJwu6Fj5UsY+pgjT/YO3d0f+VKJ6XKn5y3PTgy+T
        wyvNTsfXVPLZDExn3Qu4adnQyQtmwhMUGSUxo+JvCOU63oLILNt4WeinDztqnXbrWJlIua57pSrE1
        NiIEGjDujmuiXAaO9Rd+DeQqS9Y/0m4nw==;
Received: from [2001:4d48:ad59:1403::16a3] (helo=earth.li)
        by the.earth.li with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1pnjxm-00FJmO-Kw; Sat, 15 Apr 2023 18:45:26 +0100
Date:   Sat, 15 Apr 2023 18:45:16 +0100
From:   Jonathan McDowell <noodles@earth.li>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Minor device-tree additions for C.H.I.P
Message-ID: <cover.1681580558.git.noodles@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch series adds some improvements for the C.H.I.P DTS,
enabling bluetooth, exporting the PMIC temperature details via iio-hwmon
and finally adding the appropriate base pinmux info for an external MMC
card.

Jonathan McDowell (3):
  ARM: dts: sun5i: chip: Enable bluetooth
  ARM: dts: sun5i: Add port E pinmux settings for mmc2
  ARM: dts: axp209: Add iio-hwmon node for internal temperature

 arch/arm/boot/dts/axp209.dtsi       | 7 +++++++
 arch/arm/boot/dts/sun5i-r8-chip.dts | 4 ++++
 arch/arm/boot/dts/sun5i.dtsi        | 8 ++++++++
 3 files changed, 19 insertions(+)

-- 
2.39.2

