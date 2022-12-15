Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABF564DAB3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiLOL5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLOL5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:57:06 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DA527FD3;
        Thu, 15 Dec 2022 03:57:02 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 5C9823200926;
        Thu, 15 Dec 2022 06:56:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Dec 2022 06:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1671105417; x=1671191817; bh=hB
        NZFN4BszB7btXMuBMEpw3gPjRnE8wukihYoieF5BI=; b=KeCXTsd+5JIUADZU+x
        CaoMYFcAiHg+ILXcX06ALg7OmIWUxwK3Ib3iLWbCBGQzqxPK2YeJpt1A/r0QUwNC
        1RJO8Fk4xXOkGgFwvaodCkR+KXlyRGvFclYbyYxE4Nm2rj9sd0MIR5+vxM4dqAMm
        lbSGU1iHY4fO8lJd9xocbO4XEMyr/yDgpBWAB4PWYMLsJNcy2PFai0G6VvJ+uelx
        tFyIe1BI7+gTcpvf1lyAkk0Znr+a6wTQPl1Z0DoD5TUjsasNbfXEMEBD3iaAvKPl
        Fl+DtAQzoQm/JW7ID6hNP7R+4Q9++gDza+jAAINrrm656ZNBTz6jnE6pnEe6ehuO
        D8ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1671105417; x=1671191817; bh=hBNZFN4BszB7b
        tXMuBMEpw3gPjRnE8wukihYoieF5BI=; b=SH4oogk+thUztQNGjjX1Nud69D+0u
        wFQbM2kXjxKNSZyabE/lSVkaHGpDAXqDK5csavBWJYTZVvvBWMNACX7lBm9BTx+H
        /myH4N6BF4vUJGMbnNsZjw5W7BN69sF9+/tNYcRp3b6BN3Q5sF7S06LDWeSWF9Jr
        dSgbSlSaURCGKbiufTuEgOVSs/KItCp1qxpuWgXTwTVUMZDIpkI/QlKWW2/kj0Vf
        PDmMMMq/v5ZkSUZHXqeWl+M9OIP9jOkw91qml4EGPOwUZ6pY0VtFXDbDKJ0TZ5pv
        Or9Igxn2iLWgE7Y8GIjDBmmpUOPlmYNssndymxq/ZFXARQACP0oGMYw/Q==
X-ME-Sender: <xms:iQubY99FUtEjLuwE9SLKjZFRl-9pA4VJJf-FfFMBDTeCyO-m63n4Uw>
    <xme:iQubYxs2WB780vyk_9AeVClQ6Ka0CKNqEImlrF-1zaM9qSeSTQijKpaZIiBNomHcz
    MnxJr5ER14fGD5Nj38>
X-ME-Received: <xmr:iQubY7Cjb24k2_NEQP4MBGgzT4QUd0ndx48QDJtuz1ygs-eDCZPd4oX4S-9T2B2UOwWVISFapvZ->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgtggfgsehtkeertd
    ertdejnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepffekhfelteeggf
    etieekteekhedtffekvddtveetgeffgfelffeftdehuefgheefnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:iQubYxc-vB3-517A3Xu7MYVtjwuLDjwkPWLouys8u1-8DP1l30rOrg>
    <xmx:iQubYyPeZjRDqmQBnbpvWZDnloRSdprTAzmfQG8rOMAV3rPDGVymHQ>
    <xmx:iQubYzmjil49ItQgcaTn_zTcU3oejWsq9lVkEZ7CvOdh16QLxIeMHA>
    <xmx:iQubY8sXj3Z56no3qxxs7XXUkLeenoT1dBkd6Y9CpNFpRR4QXQxuVQ>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Dec 2022 06:56:49 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     jernej.skrabec@gmail.com, alistair23@gmail.com, festevam@gmail.com,
        kernel@pengutronix.de, linux@armlinux.org.uk, arnd@arndb.de,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 0/3] imx7d-remarkable2: Enable cyttsp5 and rohm,bd71815
Date:   Thu, 15 Dec 2022 21:56:41 +1000
Message-Id: <20221215115644.208486-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.38.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the cyttsp5 and rohm,bd71815 in the device trees and
defconfig for the reMarkable 2.

Alistair Francis (3):
  ARM: dts: imx7d-remarkable2: Enable the cyttsp5
  ARM: imx_v6_v7_defconfig: Enable rohm,bd71815
  ARM: dts: imx7d-remarkable2: Enable the rohm,bd71815

 arch/arm/boot/dts/imx7d-remarkable2.dts | 256 ++++++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig    |   5 +
 2 files changed, 261 insertions(+)

-- 
2.38.1

