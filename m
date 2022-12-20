Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25261651FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLTL3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLTL3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:29:43 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F041659E;
        Tue, 20 Dec 2022 03:29:39 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 162933200033;
        Tue, 20 Dec 2022 06:29:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 20 Dec 2022 06:29:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1671535775; x=1671622175; bh=dP
        vWHtRpiToYLYps59erVZEsBmGTOXtq9s1AIPA2oCg=; b=gJHOH5uirsRWgqSr65
        0cA1hIVM+KcAlYVIXIhgjXMgivg3WQYEgqXa4h8Todw1ZIBRF/ba6e/xxCIwPTZS
        Gq3VkYbYXiuwif1hy0ifMQq2YWdrlAZIYAdtNb4Br8u4v7j7PK/FS+dbrpJjWIjh
        O0Jn+6Qvdk3x6hW3obbyc/5T2dOLxHAG1ec6bOSI1b/CAF+JeVvKjB928VnpTsDT
        84kPH14mOZC6+NcFDEZtkzdo99mSBtGFpegWRGPDEPO2aGQExWISDYyLD+Bf4M0i
        8dfj9LGv8UZxnwptUdKnu8eXE53aNqeNl+m9ppoHrotMhPdCb4qtVk9c79mF2+g7
        NTjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1671535775; x=1671622175; bh=dPvWHtRpiToYL
        Yps59erVZEsBmGTOXtq9s1AIPA2oCg=; b=vvNZcyFGV9q/YRGbrxsZJsu5ajAtE
        3lCT7mYGqZRuV3Q9xXd5aYMZy4RXMFjpgFjqcyEhsAIQoeHhwGvLp7J+pcGyhYYN
        4moM+7tQoLnQnc6hFUTMF04p+2rUyLOkMM4RnJHcRbY4WvzrtYIV3Dsa5eYntjGz
        M54ptwd0YkKza+PWjS6pS19CyQ8n9K2Dv37dkyIjZ1GEFdiNB2SjiZr2BMhtgdeB
        0JT5AyCQxT5/dFDrELAUkwa3Us3+zsCOyJYa55epSt87vxV9gIjKa1JRs2wFjYIF
        fP30WxCEk979ZJc1kGjTshC9CV15UwQW0+9FEFbOb8j06rA9K4Tb+7kDw==
X-ME-Sender: <xms:n5yhY5lIq2SZuLi_tkUrd3bJkaxDJLFyxYG9kUD1mxW_dBgxMeNnKA>
    <xme:n5yhY017KaNv-CRJQVus_vXS1N5QWMDsQLGCbCd627wlqjYnibw9ggD3OzDKeJo2O
    HDYGlCG7Ef2gWA1Vss>
X-ME-Received: <xmr:n5yhY_oFzSW_ZXkY29O2OyOxhhmMPhunQtjOfAMpN5PCBz8IK6qQBfLAjbSkGuKuQ3KXlWDmKMkR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgtggfgsehtkeertd
    ertdejnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepffekhfelteeggf
    etieekteekhedtffekvddtveetgeffgfelffeftdehuefgheefnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:n5yhY5mTBd8J3hGNvJTN6WhXh7BzO-CPr0uZDqzmSuSxmBuMczGMrQ>
    <xmx:n5yhY30SS_OMDbuc4pcCAdBa8KGf0bXDyz63Vp_OIyDm9ChcDod_Qg>
    <xmx:n5yhY4vJtfsOx4GTlXqpAiuaGKUUgqL3o_KzTTmit8zgG11hdZVjew>
    <xmx:n5yhY-0vO0nYRzB3SBUN5jrTk5w302acMFTDClWEJcZJYhncsAm-KA>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Dec 2022 06:29:29 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        s.hauer@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux@armlinux.org.uk, festevam@gmail.com, kernel@pengutronix.de,
        arnd@arndb.de, alistair23@gmail.com, jernej.skrabec@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v2 0/3] imx7d-remarkable2: Enable cyttsp5 and rohm,bd71815
Date:   Tue, 20 Dec 2022 21:29:24 +1000
Message-Id: <20221220112927.440506-1-alistair@alistair23.me>
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

v2:
 - Fixup DT formatting issues in path 3

Alistair Francis (3):
  ARM: dts: imx7d-remarkable2: Enable the cyttsp5
  ARM: imx_v6_v7_defconfig: Enable rohm,bd71815
  ARM: dts: imx7d-remarkable2: Enable the rohm,bd71815

 arch/arm/boot/dts/imx7d-remarkable2.dts | 257 ++++++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig    |   5 +
 2 files changed, 262 insertions(+)

-- 
2.38.1

