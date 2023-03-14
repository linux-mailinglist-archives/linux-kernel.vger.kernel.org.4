Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123D76B9229
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjCNLzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjCNLzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:55:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA04328214
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:55:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 869DFB81901
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EEBC433EF;
        Tue, 14 Mar 2023 11:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678794905;
        bh=q4z+1z+IJi1sUIwZcL8DJINnXVOS7+uZJIuwjt/MvOI=;
        h=From:To:Cc:Subject:Date:From;
        b=J/dt6uadN8wGRHQ4rI8RrqBe77N1oeCxuXmCH6yMioxj264RwSMPIss32NC0S9Kvc
         L/0DX8bOnxLvm27oNqowq4SSpSD2FRR1vjIOvbCdJMqEIwzkutuL7eR8XkcM6BIpdt
         GhgSPohDFFWBVZAsGgzP82I1iJdar7N6XBTVmKijhq0pLoTysoj5oObqnD+C1GnSMe
         ZIQp4QOd1hW9ce7+L2yxLJIlNmP+esN+acf8Xwv+iZcBYMe64HZSj47vLPm0nhB9MM
         JUtONquqWIIei/6cs1wDLNKsjEPxvyFaqvGat926a1R4ak/R5bOF9x6WiPSF4/eCA7
         uJwJiwDyWW0+A==
From:   eballetbo@kernel.org
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Enric Balletbo i Serra <eballetbo@kernel.org>
Subject: [PATCH] mailmap: add entry for Enric Balletbo i Serra
Date:   Tue, 14 Mar 2023 12:54:55 +0100
Message-Id: <20230314115455.188818-1-eballetbo@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enric Balletbo i Serra <eballetbo@kernel.org>

Map Enric's old corporate addresses to his kernel.org address.

Signed-off-by: Enric Balletbo i Serra <eballetbo@kernel.org>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 424564f40733..671ad2ad7f6c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -132,6 +132,8 @@ Dmitry Safonov <0x7f454c46@gmail.com> <dsafonov@virtuozzo.com>
 Domen Puncer <domen@coderock.org>
 Douglas Gilbert <dougg@torque.net>
 Ed L. Cashin <ecashin@coraid.com>
+Enric Balletbo i Serra <eballetbo@kernel.org> <enric.balletbo@collabora.com>
+Enric Balletbo i Serra <eballetbo@kernel.org> <eballetbo@iseebcn.com>
 Erik Kaneda <erik.kaneda@intel.com> <erik.schmauss@intel.com>
 Eugen Hristev <eugen.hristev@collabora.com> <eugen.hristev@microchip.com>
 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
-- 
2.39.2

