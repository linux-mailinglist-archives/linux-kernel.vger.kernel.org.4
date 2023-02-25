Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037E96A2955
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 12:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBYLh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 06:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBYLh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 06:37:27 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24319199FC;
        Sat, 25 Feb 2023 03:37:24 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B741E5C00FF;
        Sat, 25 Feb 2023 06:37:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 25 Feb 2023 06:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1677325041; x=1677411441; bh=nd
        qB0c0GPSg/FJ6GCSucDXTVMb0erKjJt1WGDMd2mk4=; b=bUJQiycmz16xv895ox
        1QNC91b4GLZbQBaW1GPhQ52x8mSh3BnWmM+Ozf/yGQ5LMtexbE1tz3Eej0YNwLru
        lKp1EQqx1NSOHFgjNs0aizWA/CmoeAipprB+ewNP5OT2I1pBbNB9JhwGZaV3i61E
        eG0gOt9hN3pSk21Ynzl0RyZMnUW6+nSTlot+xKq+xzBPvbucKl9Lguz8lrnz80Ce
        rhZhU8TUvNrk0mbiF4EwC9Up3QnLN8TG4dqxILADHm9kBvIqn4MrRJc/2LIt6hZY
        BjggjGT0U3pYguSxmgOIjvujIuNZrxlesVJSEBjaqQ4dhmvTava+y23DGD/XtmmE
        Vg7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677325041; x=1677411441; bh=ndqB0c0GPSg/F
        J6GCSucDXTVMb0erKjJt1WGDMd2mk4=; b=bwPUT2s8uPiXj9GS8c4WVrq+SRqE9
        4lC/KKaAAFzYBjCloGKdKgf//Z08db0tqSKMOOc6loJ+tROe2FLhaSzBpu8g0RIs
        LArx1mcoiWlc8oWFoA0s+8WaQzm7mHFtbDcdlXRq4PcocICzjPokYiIWAtOLxn3h
        d4hzKqmrppeRBSsHp45dAtV4yKfSM4mdMldJ05WD1H1iPb9yYO2YOTHqKFgEtVCc
        Qvb/+tVgIkOBuXoDIu65/821rFN1f/+D96V+fRY/ZAkXvZrhKqLEQgyrI2D6/SQK
        /8sHIAfF6X/vUWheIH5a+NqbE0xOe1aC8EDvHexh2EgkfUXSizlM17EeQ==
X-ME-Sender: <xms:8fL5Y3Oi7Pk2-RLnFAMYRFHHOGkyphYDpiUi4jURQ7nbNqxnzux1VQ>
    <xme:8fL5Yx-ZrscVQ9sZwhJ3n0UiynFby3eeOJBONcRju18D8NDY_dMLbwnL-2AsEJpIV
    umHT_K8fa0O45ho0Gw>
X-ME-Received: <xmr:8fL5Y2Rk3eT-JpbXoGS2IjncwhwfTUHqx2Y1bEYupxrKcobOflMnI8FBpLF822526MDyuZYdk6ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekhedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffotggggfesthekre
    dtredtjeenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeffkefhleetge
    fgteeikeetkeehtdffkedvtdevteegfffglefffedtheeugfehfeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:8fL5Y7sCieOKRxbUvH3P31ynbK0IyUNpkCU-f9VTQ34yhECTZszImg>
    <xmx:8fL5Y_fvceSqukS39-N032j1kuIWD14TRkULZ2yqVYacylxUcZwt5w>
    <xmx:8fL5Y32ytYxWrX4T-MkoPG5CYQJpWYw-Gck7sW1AN_nPnyzhilWbeg>
    <xmx:8fL5Y6-D8QHFssW61EVFpopfcpyimyJx5F2YcItnKv-jdh1CtuohVw>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Feb 2023 06:37:15 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     s.hauer@pengutronix.de, devicetree@vger.kernel.org,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     arnd@arndb.de, alistair23@gmail.com, kernel@pengutronix.de,
        jernej.skrabec@gmail.com, linux@armlinux.org.uk,
        festevam@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 0/3] imx7d-remarkable2: Enable cyttsp5 and rohm,bd71815
Date:   Sat, 25 Feb 2023 21:37:09 +1000
Message-Id: <20230225113712.340612-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.39.1
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

v3:
 - Remove unused sleep states
v2:
 - Fixup DT formatting issues in path 3

Alistair Francis (3):
  ARM: dts: imx7d-remarkable2: Enable the cyttsp5
  ARM: imx_v6_v7_defconfig: Enable rohm,bd71815
  ARM: dts: imx7d-remarkable2: Enable the rohm,bd71815

 arch/arm/boot/dts/imx7d-remarkable2.dts | 255 ++++++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig    |   5 +
 2 files changed, 260 insertions(+)

-- 
2.39.1

