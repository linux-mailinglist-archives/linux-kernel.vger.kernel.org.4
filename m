Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D029C6A3A35
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 05:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjB0Eui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 23:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0Eug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 23:50:36 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F99E07C;
        Sun, 26 Feb 2023 20:50:36 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 84E443200902;
        Sun, 26 Feb 2023 23:50:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 26 Feb 2023 23:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1677473434; x=1677559834; bh=fI
        4g0ve62uV8mrXHpG6HypxMDaY5Y37mRewKpXjGCJ4=; b=MzWrCfjmJHTWYYfXuf
        sbuVwJ01HsRfvKx3HJACaqMezbF0+0e0zoVuAFFtpuGYAcjxRl5k/LG/4Ct/6WZm
        Er0suMK8fBPXBRUMuwTpPxEYu25YAZdt70hIZbNXOCXCGvqlp/lUQ15thwknRfYC
        okJUMHbEHRSWaDSxzINU+/HrkOrqLThZCb2gNCR1T1DC6bFUjvtEx3YdHWA1oeBX
        VXWkxz0pb9YdDWwh53mJqjZjuLItXdI71rRSn9jKQNtEhKQzmJer6xyxBRPJGKsj
        Mf0bRAZw0rfzDZGqP9/WOmZuHxUr3srzyyi/6SXzJ3voXPa4y2+Bxqlyisq0Svcb
        2FrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677473434; x=1677559834; bh=fI4g0ve62uV8m
        rXHpG6HypxMDaY5Y37mRewKpXjGCJ4=; b=ct73tTMdD1tMi6iO0bvZ/WhlBfc1Z
        3KL6lnCRN1vM4qcdeKQz85nq8uEVQL580QHq2AaOwinbY1Z4qmv6JdUMCTHRLTQR
        rbvWXzRc8x1W0Jaan0VD+zQKlRoXetTH6pCORJKIqLagCvalIA2zRhXr9A/V2m4i
        M4qAbHUTz+sB+vop2cCTL7eZqQBP3Jbkoj8DLG2+4Ek8e8XY3WVPvuRt/afor1qc
        NdKKrH6RbcK0Js+3v22wny4F09I/aXCpUyOoIRKNYL+0hzWjwEwtlFMFy+E1YV1h
        EcNDpCvuCMA5lrB8Y+dm7AXAn1Dn0hEodEHGUniNNvoGo4yfSv9KmqSmQ==
X-ME-Sender: <xms:mTb8Y9R6aLPOYjUh7ZE171y2UvCMet7llO2DcLd6kah5TJsIUXsggg>
    <xme:mTb8Y2zgPJ2wxVkOn0KIvgKRBETxZatv7RIeWJYxOxbXK_061TGkXw2tlj_H55QxG
    OBrfeV-CyDAA98FWgw>
X-ME-Received: <xmr:mTb8Yy3ufCf8WL9fYAaebXMuh1_rnNOg2eoMAmIlq3Ft-ezOUGXeZgpWkEunn2GBy2X_Vn0ITe4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekledgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffotggggfesthekre
    dtredtjeenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeffkefhleetge
    fgteeikeetkeehtdffkedvtdevteegfffglefffedtheeugfehfeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:mTb8Y1BDjerfhwsoHpUiylEfAXcc9O-dJPXscR1K6OIWoEF5J08ZFg>
    <xmx:mTb8Y2hNo3KujXjFat0fdZQizYkLLyido_n79VMsSB41_hwdyU91dg>
    <xmx:mTb8Y5oB2pMebs7B-iD2hSa78jua--jQuP9c_RvJ1OA5jrrGmAi89A>
    <xmx:mjb8Y9QboG_OLoYoOGZLxSvp1HiDWf55I8fW9zxeBpqrXAQ3wUmFJg>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Feb 2023 23:50:28 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     devicetree@vger.kernel.org, s.hauer@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, linux-imx@nxp.com
Cc:     linux@armlinux.org.uk, arnd@arndb.de, alistair23@gmail.com,
        kernel@pengutronix.de, festevam@gmail.com,
        jernej.skrabec@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 0/3] imx7d-remarkable2: Enable cyttsp5 and rohm,bd71815
Date:   Mon, 27 Feb 2023 14:50:20 +1000
Message-Id: <20230227045023.560319-1-alistair@alistair23.me>
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

v4:
 - Fixup the rohm changes to match DT schema
v3:
 - Remove unused sleep states
v2:
 - Fixup DT formatting issues in path 3

Alistair Francis (3):
  ARM: dts: imx7d-remarkable2: Enable the cyttsp5
  ARM: imx_v6_v7_defconfig: Enable rohm,bd71815
  ARM: dts: imx7d-remarkable2: Enable the rohm,bd71815

 arch/arm/boot/dts/imx7d-remarkable2.dts | 239 ++++++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig    |   5 +
 2 files changed, 244 insertions(+)

-- 
2.39.1

