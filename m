Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3E4603A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 08:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJSGwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 02:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiJSGwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 02:52:19 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D306B6D9D8;
        Tue, 18 Oct 2022 23:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pkfzO9opJFwKf3pFoM2WB/XxyOSjC9l3pZUSBKXJ3d4=; b=2wKcTT0sEItyJC2LwbuVFm53Dj
        2D9JRdoEkzcrRQTEvzrj7iVtjNZwDHsDYT4vshJs4UYKJweApi6yrixhghjNAUMxj+GRxHEX/dLNV
        rKQozQFEt93UpqHwI6r5iHcaNZe7kVmthVmNN3htoBYVe2ht+fvvJlnX0Fr72p/gw5YFISggwJrjW
        fS0KNLhgbDoXeDpqSg1+SyvCC1NFpxvPkosdOrASRJ0NbOJbx81IUwdZBpwz3iW0p2UEQCrX+r2hn
        LKtQJBwEvtjWKcICg0jOhCN1NIBOJ9DYzvBf6m5q2fiK3Lq5IST4edKzkcQXKS7pwN5q0H6bqDjT7
        6vqwd/dQ==;
Received: from p200300ccff064b001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff06:4b00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1ol2vq-00045V-2y; Wed, 19 Oct 2022 08:52:02 +0200
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1ol2vp-0044Jd-EF; Wed, 19 Oct 2022 08:52:01 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        j.neuschaefer@gmx.net
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/2] ARM: dts: imx6sl-tolino-shine2hd: Add backlight
Date:   Wed, 19 Oct 2022 08:51:57 +0200
Message-Id: <20221019065159.969852-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a backlight here, it is a bit special situation. The vendor system
has an option to add some extra brightness together with a big warning
that power consumption is increased. Not sure, where it should fit,
but since the backlight is probably made of leds, this might be the most
convenient place.

Andreas Kemnade (2):
  ARM: dts: imx6sl-tolino-shine2hd: Add backlight
  ARM: dts: imx6sl-tolino-shine2hd: Add backlight boost

 arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts | 30 +++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

-- 
2.30.2

