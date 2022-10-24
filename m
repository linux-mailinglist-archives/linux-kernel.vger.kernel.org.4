Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B563760BE8F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiJXXaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiJXXaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:30:10 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07339A2851;
        Mon, 24 Oct 2022 14:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666644739; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=+ftnH8PiQM7vRwC+vvn0YErE9wzRcvPE7+Jxycee6FQ=;
        b=wVkh2ifrrqdicQgTmpFgvZOs3NWX3iw+5/2+Shc97X68/Ox2Rj10J7SKhU7vHGKOW09XMB
        M3loSKulHb98Jomn0jFr/vLlIBpdb3uKknbojkUr7gChwE5dnfyYRv9J/2luFYwQ2982fx
        3O1A90BpcOtDWDnDXyTgug7MTr5XEl4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     od@opendingux.net, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/5] pwm: jz4740: Fixes and some light changes
Date:   Mon, 24 Oct 2022 21:52:08 +0100
Message-Id: <20221024205213.327001-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry, Uwe,

Here are two important fixes for the pwm-jz4740 driver. They address
problems with the PWM pin levels not being driven inactive when they
should be.

The patches 3-5 are simple changes and are not bugfixes.

Cheers,
-Paul


Paul Cercueil (5):
  pwm: jz4740: Fix pin level of disabled TCU2 channels, part 1
  pwm: jz4740: Fix pin level of disabled TCU2 channels, part 2
  pwm: jz4740: Force dependency on Device Tree
  pwm: jz4740: Depend on MACH_INGENIC instead of MIPS
  pwm: jz4740: Use regmap_{set,clear}_bits

 drivers/pwm/Kconfig      |  4 +-
 drivers/pwm/pwm-jz4740.c | 89 ++++++++++++++++++++++++----------------
 2 files changed, 55 insertions(+), 38 deletions(-)

-- 
2.35.1

