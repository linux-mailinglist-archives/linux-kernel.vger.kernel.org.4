Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D029B5B4F55
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 16:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiIKODt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 10:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiIKODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:03:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E0533A19;
        Sun, 11 Sep 2022 07:03:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D6F7B80B50;
        Sun, 11 Sep 2022 14:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F70C43141;
        Sun, 11 Sep 2022 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662904989;
        bh=WWx3AJlX6Slk7wqDxJ03BK7fBMO8+hLbvGw5qltzu88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S2ME8UJtIiwFMdofFqm+rWwVReu7wqvU+NEaE0uj6TTATHVsdwpTF7LaNltA7HXqL
         yP65rwTzpl4J8+mn521HOqNiC+92Qq3yj805zqr24ntUo+vT6B+PKamYzmkNbmU2Ji
         QzpBzF5IBTeR7fU8gSqt8o2A+2Y3hNvh7MMbay/CqaO7uST9kjM5sFkBC13BjutfEf
         vxzZHMVRtXZ0Ok4XxrA9+aieFlouWcl+yjEX+2vUKZXpsUK5oG85lKcyeWRvF5swBD
         /3hc8iremlwoQs4/4oYXFb2PUy0MvQUYz4C4yB0oCw74aItvvCm3Do5IhNlXPMFc/B
         5aGjSTroV8fUA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oXNYL-0007wg-Pg; Sun, 11 Sep 2022 16:03:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>,
        arun.pappan@ftdichip.com, sowjanya.reddy@ftdichip.com,
        malliamireddy009@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] USB: serial: ftdi_sio: include FT2232D in type string
Date:   Sun, 11 Sep 2022 16:02:08 +0200
Message-Id: <20220911140216.30481-5-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220911140216.30481-1-johan@kernel.org>
References: <20220911140216.30481-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the updated D-version in the type string for the FT2232C type.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index b4db6a4ea223..cd3cdecc5f90 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1074,7 +1074,7 @@ static const char *ftdi_chip_name[] = {
 	[SIO]		= "SIO",	/* the serial part of FT8U100AX */
 	[FT232A]	= "FT232A",
 	[FT232B]	= "FT232B",
-	[FT2232C]	= "FT2232C",
+	[FT2232C]	= "FT2232C/D",
 	[FT232R]	= "FT232R",
 	[FT232H]	= "FT232H",
 	[FT2232H]	= "FT2232H",
-- 
2.35.1

