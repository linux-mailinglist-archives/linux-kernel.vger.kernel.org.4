Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30F174E18A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 00:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjGJWqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 18:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGJWqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 18:46:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BFF9C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 15:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=X/qJ/SWxS8RBLyV/16gE1XO+8L0Bw94e1FdQYm5w4Gw=; b=lrX+PwQSX5iTRYogCCPHCWVEzA
        M6Dpi4H/Tw6cjOvSNTre5KY12t8k09yFd3obRHjt+td+Fevtbcf7ix12dA9QQhC3GYRWg8ALZJ2Ha
        SqdchMSIm917lUdk7zZIOiVyIiV1zRsLBTk19fQo8Fv0EW/qDGUe7BQGspv3F5OFzwu9yx+XIrNFc
        q5m6+7Ilscyau9T1YrPgyuY+QZTIgivXxUHAWSIiBBCSjJMxojDjcff/1oGqi47txhWJJySfPWMzS
        CG6Rb/bMZ4nl6/DWYwzTchZyXuCiqj0NR6E0uJ+RPpop0YT+zWkvxqJBsm6OtK43cI6PtRG8GMGkD
        vWUX21fg==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIze2-00Ct3T-23;
        Mon, 10 Jul 2023 22:46:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Justin Ernst <justin.ernst@hpe.com>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH v2] x86/platform/uv: fix spelling in sgi_uv ABI documentation
Date:   Mon, 10 Jul 2023 15:46:13 -0700
Message-ID: <20230710224613.22950-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems as identified by codespell.

Fixes: c159376490ee ("x86/platform/uv: Update ABI documentation of /sys/firmware/sgi_uv/")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Justin Ernst <justin.ernst@hpe.com>
Cc: Borislav Petkov <bp@alien8.de>
---
v2: use Borislav's correct email address

 Documentation/ABI/testing/sysfs-firmware-sgi_uv |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/Documentation/ABI/testing/sysfs-firmware-sgi_uv b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
--- a/Documentation/ABI/testing/sysfs-firmware-sgi_uv
+++ b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
@@ -102,12 +102,12 @@ Description:
 			conn_port
 
 		The conn_hub entry contains a value representing the unique
-		oridinal value of the hub on the other end of the fabric
+		ordinal value of the hub on the other end of the fabric
 		cable plugged into the port. If the port is disconnected,
 		the value returned will be -1.
 
 		The conn_port entry contains a value representing the unique
-		oridinal value of the port on the other end of the fabric cable
+		ordinal value of the port on the other end of the fabric cable
 		plugged into the port. If the port is disconnected, the value
 		returned will be -1.
 
