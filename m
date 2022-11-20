Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A3D6316BF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 23:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiKTWM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 17:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiKTWMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 17:12:24 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6DB26486;
        Sun, 20 Nov 2022 14:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mHensYgwzIJKT532DNKE/RSfHEKyHXNfQyHZcpZq60w=; b=KPaM8bls9zL606ZIVqyXz+QTGU
        8S+NWcrXOYQLWqLUB8B07gLJOc9HQzg0ird4q796confO1q8SpSFqYWdf9Yiy9EZH3Ix8QBGeaY3A
        djZab63MN86cbzq+uutgBGKxsZd/KhdMu46fkfXsH4f21sfqXjei0sa55MlG6+6zabZ12TrV+XNXq
        aFxFFehe7SC06yD6Q5MTLeBVDQpI1useTqVBJbMOEp1CxU61kzqH5bejgRCXzmTypYHQjvug9Sacj
        CN505enOwJpqr/WQ7+OSwgkFgB4BWRnR0gBHhUq06pkQC4XigR6p/nhSIOH6FNlHaReCec3XlW5BM
        7emjknZQ==;
Received: from p200300ccff43b2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff43:b200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1owsXt-00068k-HP; Sun, 20 Nov 2022 23:12:13 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1owsXs-00Cypf-EJ; Sun, 20 Nov 2022 23:12:12 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     tony@atomide.com, lgirdwood@gmail.com, broonie@kernel.org,
        Nicolae_Rosia@mentor.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/2] regulator: twl6030: some TWL6032 fixes
Date:   Sun, 20 Nov 2022 23:12:06 +0100
Message-Id: <20221120221208.3093727-1-andreas@kemnade.info>
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

There are some problems regarding TWL6032 regulators, including
inconsistent states. They come to light during porting support
for the Epson Moverio BT-200 to newer kernels. 
Information sources are the 3.0 vendor kernel 
(http://epsonservice.goepson.com/downloads/VI-APS/BT200_kernel.tgz)
and git blame archeology.

Andreas Kemnade (2):
  regulator: twl6030: re-add TWL6032_SUBCLASS
  regulator: twl6030: fix get status of twl6032 regulators

 drivers/regulator/twl6030-regulator.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

-- 
2.30.2

