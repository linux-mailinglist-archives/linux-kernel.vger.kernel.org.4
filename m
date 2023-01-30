Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354D66811DE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbjA3ORA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbjA3OQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:16:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567893CE32
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:16:42 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1pMUxF-0004Dq-Nf; Mon, 30 Jan 2023 15:16:17 +0100
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jlu@pengutronix.de>)
        id 1pMUxF-001UGs-SI; Mon, 30 Jan 2023 15:16:16 +0100
Received: from jlu by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jlu@pengutronix.de>)
        id 1pMUxD-00GEro-D4; Mon, 30 Jan 2023 15:16:15 +0100
From:   Jan Luebbe <jlu@pengutronix.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jan Luebbe <jlu@pengutronix.de>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 0/2] Fix module signing with PKCS#11 URIs
Date:   Mon, 30 Jan 2023 15:15:51 +0100
Message-Id: <20230130141553.3825449-1-jlu@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here are two patches to fix kernel module signing when using a key via
PKCS#11, including the case where the URI contains semicolons to
separate components.

Best regards,
Jan


Jan Luebbe (2):
  certs: Fix build error when PKCS#11 URI contains semicolon
  kbuild: modinst: Fix build error when CONFIG_MODULE_SIG_KEY is a
    PKCS#11 URI

 certs/Makefile           | 2 +-
 scripts/Makefile.modinst | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.30.2

