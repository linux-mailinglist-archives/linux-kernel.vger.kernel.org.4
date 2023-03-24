Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3715F6C7EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjCXNhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjCXNhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:37:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F20123842;
        Fri, 24 Mar 2023 06:37:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 098E0B82013;
        Fri, 24 Mar 2023 13:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B75EC433D2;
        Fri, 24 Mar 2023 13:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679665067;
        bh=1oxvOLMBWiBJ0zt2qe5luItYy27mJyAvOqY2QnENhCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gX1CyrlDRfDAYIZChO0QGShPIjGhsC+AtJ4P8MXmf1f6Hzojx6kcW25fqHsfBZRVJ
         vs7Whx/crg/VXE3gZy+fOojvOmnTuO4c0bTAbTPczVV52kfVPENbUeOWctnwHtiJCD
         vFuQMyz43DkKq9+qy8TCDECV8cYxX0k1J77V809T8bY3q4+qicon297jAgr/jdn6gk
         fKhYVCsG6yVGh4DJHB4tjMFdRWJyqSvxcAsmxxIpByYfLB7+X6tOxUTPsekNqhcqzA
         xBShUvi688F9iIvbjP63fpxf0VBptKlm2qNGUUZUh02R7zekx7C5yDQz4neM3EnL0P
         pbtmKup+mzRww==
From:   Roger Quadros <rogerq@kernel.org>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org
Cc:     vigneshr@ti.com, srk@ti.com, r-gunasekaran@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] dt-bindings: usb: tps6598x: make interrupts optional
Date:   Fri, 24 Mar 2023 15:37:41 +0200
Message-Id: <20230324133741.43408-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324131853.41102-1-rogerq@kernel.org>
References: <20230324131853.41102-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can poll for interrupt status so interrupts
can be optional. It is still recommended to use the
interrupt line. Polling should only be used for debug
and prototyping.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 Documentation/devicetree/bindings/usb/ti,tps6598x.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
index 348a715d61f4..8c2db282735a 100644
--- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
@@ -35,8 +35,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
-  - interrupt-names
 
 additionalProperties: true
 
-- 
2.34.1

