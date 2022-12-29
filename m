Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EB2659297
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 23:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiL2Wpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 17:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiL2Wpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 17:45:52 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC87C66;
        Thu, 29 Dec 2022 14:45:51 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 2AE7C3200583;
        Thu, 29 Dec 2022 17:45:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 29 Dec 2022 17:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1672353949; x=1672440349; bh=/PKHe3zt/KewFuduOYX4v7Y/1
        VdJEV6pvckvKTHr4GM=; b=VLmOJmaJJIiJP0vuks/1uFzKAYjgTkV1mkNosSZW6
        /5LD4FBO6nQG51Kn/vUSSU4nnWA7LuL8LeZFsaoQQ56P1HLtXCsqNfb8Xi1x0iWY
        gANdB/rto338hbLcWgpcZ9i5U6TuDqqowo3irBacO8Nc0+wKdkwbHsNb7mL7RvF6
        VRmol8Qs8Gu26oBshyYkm8wVrq0mvodO45dLKA0pYxlK4hndatqMJ9okKxqJ2YOg
        s9HCSswhTaW0Km2+WM38ueEbFfA9+8UmPWbxn7bUj6vEfH+++ug13tC+d9l5BtQI
        ufckLyVUgjt8dVkxsZm5dOJQVVXUG7pOnLPHzmanXJ2ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672353949; x=1672440349; bh=/PKHe3zt/KewFuduOYX4v7Y/1VdJEV6pvck
        vKTHr4GM=; b=uC9ST3Dr6I/PU9Y2BLqYCTdiCkq6vh5PdeG0nLoHEzk0lLXaqY2
        dDgXFqhbF/fXmHDOQWfltcCosbg67EcYehzlNxcHy2sn4rkRCqBydL/hCB1tMr27
        W6mWnFYjDv/GZYjyveH8f4qJOyUFVAgC+CUXbY0JO1YjV+AZxt0p7jszG7t5squx
        Jlzu3x/ApuW0lpFlxVYvG9eO3EEsIw4H0EuP1r9jNNZRiJHHK+pt8bhsBurIjyzl
        gcBfDXWRKjvn43hseROI1H31VgtuJ+YtJ8duPHuBPJcQlMQi363FrvaOQ1/wvACI
        /z7aHaXcTzDg9MSnYx6cWbKPT4REdBtrMNA==
X-ME-Sender: <xms:nRiuY4c4cmwqVNmh-LL2LlBDzOEsPHZE1s59pLeB_ZXqPpg8odJEYA>
    <xme:nRiuY6N31UHoFKEmDgi5niFT8GjQlFzEImG0d1WA0VlpagLQ7LPXS1Q3p84ubO4Lx
    OLm5vH55DUtJdCOqA>
X-ME-Received: <xmr:nRiuY5i6BG0Von58tbOAFwggT-5r1vzwePa5K9lkY0PAVGhhpoWRhpXv0M_5F-jvLjbvm66X4c6U-7Lg-AuE4GiYdzerKutDDu8dEMrhX-ss1IFXU8kUQhhO9kQuXsZrpgphgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieehgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpedthfefheegleelfeduhffgvdevhfejkeevhfevuefghfefhffgffeihedt
    lefgieenucffohhmrghinheplhhinhhugidqshhunhigihdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhl
    lhgrnhgurdhorhhg
X-ME-Proxy: <xmx:nRiuY99uq8MWuuLcFxwIdoocdNsGufWywe1T9nuAVIZjyWfcoNMFRQ>
    <xmx:nRiuY0tTcilbxn2ORleGJ2Be8AL7xXDMdfDqXosz7Lja_rxWIv1VnA>
    <xmx:nRiuY0F1jbCLIxo5pcp848ebJJBL2OPd7UA9ltiFp0eRgUZrPurExg>
    <xmx:nRiuY58waKqFImkTNdPVGBSVAdexbacYCqio1aFuv93IxbXbi8PZ9g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 17:45:48 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 0/2] iNet U70B Rev 01 Tablet Support
Date:   Thu, 29 Dec 2022 16:45:45 -0600
Message-Id: <20221229224547.25225-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a binding and devicetree for yet another A33-based
tablet board. The devicetree currently fails validation because I have
no idea what compatible string to use for the DPI panel. Neither the
hardware nor the software provide any clues about a manufacturer or
model -- the driver used by the vendor Android is called "default_lcd".

Link: https://linux-sunxi.org/Inet_U70B


Samuel Holland (2):
  dt-bindings: arm: sunxi: Add iNet U70B Rev 01 Tablet
  ARM: dts: sun8i: A33: Add iNet U70B Rev 01

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/sun8i-a33-inet-u70b-rev01.dts    | 172 ++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-a33-inet-u70b-rev01.dts

-- 
2.37.4

