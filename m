Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C91D74CC2C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjGJFYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjGJFXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:23:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA25E77
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 22:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=gVuMooPBzlpjTMdRJssYxzr7EJS3WFVRMt5p+C87f2M=; b=AU6+zZKljUON2mo6/a+GdGfjFc
        9fOynrrlpLqL7RUXmlOMBbau5qiMEvSpinX6SaEwdmB6mXiTLKG4m7t19Dg+/npai6Z68mMopoymx
        W3YarRisLqB8USi6rqNwpCYOw/92b3Tasys/y484TOmeLQcoJ7+dkEG4/vqNIqOTsMAv1ixicQ8pO
        5IuUNL5lQn3pS93kpth0nq8xzsvGC5sRnsqArHhupNj8KxwZlwLkUj67e1GZA76IeNrpmlZ5B/Y8D
        OCn5iQJ7ZHsPR8ek8Lch8XpbWAMKXuurnUy2j50ULhwMff1pfn/YW/bog7DxV3ef0jjWzg4mNv4mG
        cYrtyVBw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIjN0-00AT2x-04;
        Mon, 10 Jul 2023 05:23:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Justin Ernst <justin.ernst@hpe.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH] x86/platform/uv: fix spelling in sgi_uv ABI documentation
Date:   Sun,  9 Jul 2023 22:23:33 -0700
Message-ID: <20230710052333.7692-1-rdunlap@infradead.org>
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
Cc: Borislav Petkov <bp@suse.de>
---
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
 
