Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC6662ED05
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 06:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiKRFFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 00:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiKRFFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 00:05:39 -0500
X-Greylist: delayed 604 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Nov 2022 21:05:38 PST
Received: from scadrial.mjdsystems.ca (scadrial.mjdsystems.ca [192.99.73.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F0E769C4;
        Thu, 17 Nov 2022 21:05:38 -0800 (PST)
Received: from cwmtaff.localnet (107-190-58-99.cpe.teksavvy.com [107.190.58.99])
        by scadrial.mjdsystems.ca (Postfix) with ESMTPSA id 79F87889AC01;
        Thu, 17 Nov 2022 23:55:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed; d=mjdsystems.ca;
        s=202010; t=1668747332;
        bh=a3BoROREcq9yjP9BAHO6xJ2ZvTcePivtJqbREHTyI8Q=;
        h=From:To:Cc:Subject:Date:From;
        b=TbHqVeLA+nzeaHqafZycaDaINXWu+M82pvWzFWEucXz+5jG3xy9ev/SqCMTV9dURE
         Q8qCCG7jl4Lls7L0i3UHxWgVp5zq5+sfmM2PkB+oE3pgck25xbBakn0WTg1Z9sUIgS
         UtwA1UJ31OMPlY/oeqPNQ4TRZPNhz1+pGrDlNLKFRsQKIa5kgUb2+J9H3P6R8uUgC1
         qSfsB6pyhOVHCrxlqaV/xGnfr54mEjVDTWjL1w8p8d9pAiEZ4vkT0KFfyNlcEfcKcx
         xYahufgpzsFpPBsc+vLHwb438vu3Uhd9hoADNwtdsCf88FBpuxIpdKKlxUeVvCgWXq
         vhXPGeScUcy6QEciMSKA6dCmucVOIJR9DT6uRCfFQwxcuEuN5A5axOJqME+3SuVY6v
         0l8ig3QCKqcyhwSY9ymxEAsa3AL11FtwRG2QBYgxrUynhpwvyrJaINGHUHr4iTB3ix
         NSfeINuSb52l5rrNDc2UPtsvsVWh7FpIZSfCv44rZjBTONKG/9HlX/AbJIj3vgygfL
         RIAgYASafqFyM/B94o2vxvqA17n6B5b8wdwpNNC2ek3p1mDNMK4vSZuESOPSA9cNJj
         1nDej2+j7qXaMiwub8eTdEvdsiQs8gd7zeM8c+xr4YWpJ+nTNf4WQ1lIpkJtqTIYIR
         fBGPADEXmsWAFByux8JlOE/A=
From:   Matthew Dawson <matthew@mjdsystems.ca>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Eugene Shalygin <eugene.shalygin@gmail.com>
Subject: [PATCH] hwmon: (asus-ec-sensors) add definitions for ROG ZENITH II EXTREME ALPHA
Date:   Thu, 17 Nov 2022 23:55:31 -0500
Message-ID: <2829949.vuYhMxLoTh@cwmtaff>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Zenith II Extreme Alpha.  It is basically the same
board as the Zenith II Extreme, and has a similar sensor suite.  The
DSDT is basically the same except for some address, so use the same
board information as the non-Alpha board.

Signed-off-by: Matthew Dawson <matthew@mjdsystems.ca>
---
 drivers/hwmon/asus-ec-sensors.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 81e688975c6a..ac0459be04c7 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -466,6 +466,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_strix_z690_a_gaming_wifi_d4),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME",
 					&board_info_zenith_ii_extreme),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME ALPHA",
+					&board_info_zenith_ii_extreme),
 	{},
 };
 
-- 
2.35.1




