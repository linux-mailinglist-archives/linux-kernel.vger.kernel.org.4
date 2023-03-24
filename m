Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894B86C7E06
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjCXM1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjCXM1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:27:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C8623653
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 05:27:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C5013CE250E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992CCC433D2;
        Fri, 24 Mar 2023 12:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679660851;
        bh=NFeDtx+FEV8J4Pvriql0F+eplQm7k6WnO7aRNvbz+GI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EpqnKb8TrPPNaP2Nou04CeQ7xC86IR3GzJi4ycK57UTTrIxwLSk2dmrbzQI3rS3th
         FfvqESHC2WhkUtpo7i0mDldULwDtmM1A2cC6WlqO0XhDloJi0Vab1fK3GDH2Fihohc
         MRdv/AmFdl+r3D82XgZc0cD12qS+PH/DINtBA0c0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 5/6] driver core: physical_location.h remove extern from function prototypes
Date:   Fri, 24 Mar 2023 13:27:10 +0100
Message-Id: <20230324122711.2664537-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324122711.2664537-1-gregkh@linuxfoundation.org>
References: <20230324122711.2664537-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=940; i=gregkh@linuxfoundation.org; h=from:subject; bh=NFeDtx+FEV8J4Pvriql0F+eplQm7k6WnO7aRNvbz+GI=; b=owGbwMvMwCRo6H6F97bub03G02pJDCmy0+UF4w6dNWwNFHFNcX7dcpMv5++7lEd3Wdb97AgSS Thw5qdKRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAExkqTLD/HQzu0rH1T4FLJ9v urfFt558Ijb1IsOCLTIzOjK+37W6cO3G1ZnzxVJzViTxAgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel coding style does not require 'extern' in function prototypes
in .h files, so remove them from drivers/base/physical_location.h as
they are not needed.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/physical_location.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/physical_location.h b/drivers/base/physical_location.h
index 82cde9f1b161..3f3f61307998 100644
--- a/drivers/base/physical_location.h
+++ b/drivers/base/physical_location.h
@@ -8,7 +8,7 @@
 #include <linux/device.h>
 
 #ifdef CONFIG_ACPI
-extern bool dev_add_physical_location(struct device *dev);
+bool dev_add_physical_location(struct device *dev);
 extern const struct attribute_group dev_attr_physical_location_group;
 #else
 static inline bool dev_add_physical_location(struct device *dev) { return false; };
-- 
2.40.0

