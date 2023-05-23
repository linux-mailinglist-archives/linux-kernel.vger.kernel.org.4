Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A95370D42D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbjEWGnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjEWGnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:43:25 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF98119
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=bsEJMT7PL8ygwWwOZmmg6TMP6cr
        VqspcIVpnTgNVp6A=; b=N7zX9oTD1UeCAPKtFwPDQYZLj9i1c0MAXpz8f9xS70/
        1FSCxKwpNG6mwftOHeD0MFPBAYejIStgsWHlw2eGzAqbrlg6Zfgujd8BowSsbX80
        VRzPeC8ShIdOqCOctYnWOUgnry6/7AdzmFewqYdBlujtHoGS3OA2TZXnBIe91gzI
        =
Received: (qmail 2628164 invoked from network); 23 May 2023 08:43:20 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 May 2023 08:43:20 +0200
X-UD-Smtp-Session: l3s3148p1@rcy7s1b82MgujnsI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 0/5] gnss: updates to support the Renesas KingFisher board
Date:   Tue, 23 May 2023 08:43:05 +0200
Message-Id: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
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
Renesas KingFisher board. They are RFC because of my proposal to merge
UBX and MTK drivers in patch 1. Patches 2-5 should be good to go from my
point of view. Looking forward to comments!

   Wolfram


Wolfram Sang (5):
  WIP: gnss: merge MTK driver into UBX driver
  gnss: ubx: use new helper to remove open coded regulator handling
  gnss: ubx: 'vcc' can be optional
  gnss: ubx: add support for the reset gpio
  arm64: dts: renesas: ulcb-kf: add node for GPS

 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi |  9 ++-
 drivers/gnss/ubx.c                       | 82 +++++++++++++++---------
 2 files changed, 58 insertions(+), 33 deletions(-)

-- 
2.35.1

