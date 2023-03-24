Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466BC6C7E02
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjCXM1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjCXM1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:27:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158211A971
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 05:27:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A491C62A8B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937A0C433EF;
        Fri, 24 Mar 2023 12:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679660839;
        bh=jKsoO9AvwyMK4q0iG+6Rsy4+MYC+QeCqpJydyL/ULnY=;
        h=From:To:Cc:Subject:Date:From;
        b=lpa37ZRMWPdgWwrlDsRjPF8nau6tbF383CS2YxZbXD6MXtfauZozJlkdh3VZebPPN
         CKjDNAtjd3zwz29SzTfwvyBW9tWDE6aZsxqD7fpZ0NhsVI7rymAJfEq1m3RE3Q46Y3
         B/POoeHg0pDMXZmz1ZorijDm6A2/Zr7/JhRkYX0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/6] driver core: device.h: remove extern from function prototypes
Date:   Fri, 24 Mar 2023 13:27:06 +0100
Message-Id: <20230324122711.2664537-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; i=gregkh@linuxfoundation.org; h=from:subject; bh=jKsoO9AvwyMK4q0iG+6Rsy4+MYC+QeCqpJydyL/ULnY=; b=owGbwMvMwCRo6H6F97bub03G02pJDCmy0+WmH2lJ2Rr6YmcVR/mNaJYZZ0NrXv22Wna7w+rO8 uSbF7fId8SyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEwjMY5meFs11SP3rm5Xvp IqPpdUwvncTvv2GYw7vjxrdtjAsVuz6cnr4uL2vh68Np8wE=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel coding style does not require 'extern' in function prototypes
in .h files, so remove them from include/linux/device.h as they are not
needed.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/device.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 3b23772d3bbb..472dd24d4823 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1088,8 +1088,7 @@ void device_link_remove(void *consumer, struct device *supplier);
 void device_links_supplier_sync_state_pause(void);
 void device_links_supplier_sync_state_resume(void);
 
-extern __printf(3, 4)
-int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
+__printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
 
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
-- 
2.40.0

