Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3F2609F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiJXLA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiJXLAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:00:34 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC1D5B12E;
        Mon, 24 Oct 2022 03:59:17 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 110083200931;
        Mon, 24 Oct 2022 06:59:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 24 Oct 2022 06:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1666609152; x=1666695552; bh=kr
        VYjkfLDQwBr9ZbrRSYb5IXhlOH+en9JkOrrwDgplM=; b=Seq+o1mxj8SBX5gryq
        usY2g9H3HKdswRTaOM0c128UWYVRii8xeCwKm357kmJF+dq9pgVVrNT6gQex/IU0
        zAlgxisOxqtlj7VsmtD2KLVt0LFc2HMGir0d6+tS+MRiSvagKmP01uk1+RHA/+6q
        ++ULuPxGsILyxIM0oYsqx/MuyceNdEOi569Qpo9vOecE0gcdnNMNasggZBAumtDs
        1ejBTs7A0yhvOej3fL5h1wLOT2nECK3ueELAfCp6yLeN18bqKH2xfMnIRzSzxSVP
        Kz/ZctzdzGGfrFB8LOr5Vxoa2lEXLwjCUg6ED2e1Np2zjlYgCzIvw2cWBh4ewyG0
        e+wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1666609152; x=1666695552; bh=krVYjkfLDQwBr
        9ZbrRSYb5IXhlOH+en9JkOrrwDgplM=; b=h06dFB9Nko3rb4oLphVZi4tqQoB8S
        nVWCBGFXUXZ4myPx9Gj7qSF7QRAeG9JE28MyeBVJsriRzdYS6Wogfcupx1thWkad
        sMln8bSlBUiJDK4LKy5H4/aGiiVNxNidltyxrIo0DeliASHQDu4VBaW3yHelni6D
        3sdgBCZE2q3o/jPdq/dT3RWgsgVz1CH9PEfRZQnASaTfBvwRaiUc7k8bttJouTKa
        lBQEFXzalPr6FogZgbYkz2VRKvs1V96CRLvxFtBDKF1byUfxIfe7kmSPtDxWnkkw
        i3CYTEqIsYrOAmF5uCO4VWq/Atp9jk37jbg5+xHWaKKvt8sJo3LNcj9QQ==
X-ME-Sender: <xms:_29WY_-DpLdwUHFJSbwTMCqgQKcqZ1rybVW3KqlyfCh-gkSelJISwA>
    <xme:_29WY7tprRiPFJ8B82Xp0D6Qz1GQwStngLsZbT4iAwcqp75gzUv4P3qT8i01sRQbc
    uYgS6nBmPO1zmdDIRI>
X-ME-Received: <xmr:_29WY9BemOgU3K9F3r0e7BTiY1rOgXL53Bu6LSYn9ai0H9pnETu46hArrujr6HNXOJf6ppAnWnNz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtgedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffotggggfesthekre
    dtredtjeenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeffkefhleetge
    fgteeikeetkeehtdffkedvtdevteegfffglefffedtheeugfehfeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:_29WY7eqsvrO0l8rXM1f3Nx9lKR1LchNAsKKrkSMemSflLYUSsPmYw>
    <xmx:_29WY0PeapLQ0UH73EciW-HIlbN2P12aKpCoPELSOYEHBricKObViQ>
    <xmx:_29WY9lw29slNeBFWcwEjb-gDq64TQv2vSWCBg8gCURQ8a-7Imdonw>
    <xmx:AHBWY_GxVy-ksoztcf47ATui4DQv0hyRXJ8b3RCzg4zZj-leY20gsw>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Oct 2022 06:58:58 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, robh+dt@kernel.org, lgirdwood@gmail.com,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        alistair@alistair23.me, geert@linux-m68k.org,
        linux-pm@vger.kernel.org, andreas@kemnade.info, amitk@kernel.org,
        linux-hwmon@vger.kernel.org, shawnguo@kernel.org,
        alistair23@gmail.com, devicetree@vger.kernel.org,
        linux@roeck-us.net, linux-imx@nxp.com
Subject: [PATCH v22 0/2] Add support for the silergy,sy7636a
Date:   Mon, 24 Oct 2022 20:58:51 +1000
Message-Id: <20221024105853.42029-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.37.3
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

v22:
 - Rebase on master
 - Drop `ARM: dts: imx7d-remarkable2: Enable lcdif`
v21:
 - Rebase on master
v20:
 - Remove merged patches
 - Fixup Kconfig selection based on previous discussions
v19:
 - Rebase on linux-next
v18:
 - Rebase
v17:
 - Rebase and fix build issues
v16:
 - Improve vdd regulator comments
v15:
 - Address comments on the patches
v14:
 - Merge the thermal driver and hwmon
v13:
 - Address comments on thermal driver
 - Rebase on master (without other patches)
v12:
 - Rebase
v11:
 - Address comments on hwmon
 - Improve "mfd: simple-mfd-i2c: Add a Kconfig name" commit message
v10:
 - Use dev_get_regmap() instead of dev_get_drvdata()
v9:
 - Convert to use the simple-mfd-i2c instead

Alistair Francis (2):
  ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
  ARM: dts: imx7d-remarkable2: Enable silergy,sy7636a

 arch/arm/boot/dts/imx7d-remarkable2.dts | 62 +++++++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig    |  3 ++
 2 files changed, 65 insertions(+)

-- 
2.37.3

