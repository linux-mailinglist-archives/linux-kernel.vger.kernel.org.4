Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01322736980
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjFTKjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjFTKje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:39:34 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F78133
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 03:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=mAfzavoLlRDJtVxvuvE/n2vaTyG
        mJiWh/lFw5WfFq+U=; b=R8WBk23zhXkIOhtV8vR71kJeaL7nvGagsspmUWdwExe
        r8ef7HWK9ZRfo232fGKlk+niEUKOsObfL6/YU5OEFY4zVsEHk/7j7pcO9rKhI0ly
        3B4bIYkaptJ3BmYLn8DOS4LLKidk18ghiq3tlT5PtmuMFjhB7U6G4etARzls8wZE
        =
Received: (qmail 601016 invoked from network); 20 Jun 2023 12:39:25 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Jun 2023 12:39:25 +0200
X-UD-Smtp-Session: l3s3148p1@FMHLQ43+noxehhtC
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/3] gnss: updates to support the Renesas KingFisher board
Date:   Tue, 20 Jun 2023 12:39:05 +0200
Message-Id: <20230620103909.37582-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, here are some patches with which I can use the GPS receiver on the
Renesas KingFisher board. Still RFC because I have a specific question
regarding the last patch. Looking forward to comments!

   Wolfram

Wolfram Sang (3):
  gnss: ubx: use new helper to remove open coded regulator handling
  gnss: ubx: add support for the reset gpio
  arm64: dts: renesas: ulcb-kf: add node for GPS

 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi | 14 ++++++++++
 drivers/gnss/ubx.c                       | 35 ++++++++++--------------
 2 files changed, 29 insertions(+), 20 deletions(-)

-- 
2.30.2

