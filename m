Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9C5655055
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbiLWMZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbiLWMZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:25:14 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69004FCCF;
        Fri, 23 Dec 2022 04:25:13 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [IPv6:2401:4900:1f3f:cd5d:4e48:3b91:9262:9565])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 682D0492;
        Fri, 23 Dec 2022 13:25:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671798312;
        bh=Xo4PgGMqXkAeAbAXamG4Agqq6zDHS6a3JUw2oXCCxcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aNHAgoxhvTZb5g/t3sRmdo1fISxhqSourtvk2a6eUsvsZPlWCVyxocjj+Da9i7fUm
         RJOWfsT+76+cpSo1/4CPtZ/DgZDsJq/scSBkKsTnPPY9a2uPK4GJwDSbDcYsUpx9wC
         1+hH65ZUd5Ec74/lm9JrevRiirNA5uuSBAgSLwiE=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Kees Cook <keescook@chromium.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v3 7/7] staging: vc04_services: vchiq: Drop custom return values from TODO
Date:   Fri, 23 Dec 2022 17:54:04 +0530
Message-Id: <20221223122404.170585-8-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221223122404.170585-1-umang.jain@ideasonboard.com>
References: <20221223122404.170585-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The custom return values (enum vchiq_status) has been dropped.
Remove the TODO entry for the same.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/staging/vc04_services/interface/TODO | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/TODO b/drivers/staging/vc04_services/interface/TODO
index 97085a0b3223..6d9d4a800aa7 100644
--- a/drivers/staging/vc04_services/interface/TODO
+++ b/drivers/staging/vc04_services/interface/TODO
@@ -40,11 +40,6 @@ beneficial to go over all of them and, if correct, comment on their merits.
 Extra points to whomever confidently reviews the remote_event_*() family of
 functions.
 
-* Get rid of custom function return values
-
-Most functions use a custom set of return values, we should force proper Linux
-error numbers. Special care is needed for VCHIQ_RETRY.
-
 * Reformat core code with more sane indentations
 
 The code follows the 80 characters limitation yet tends to go 3 or 4 levels of
-- 
2.38.1

