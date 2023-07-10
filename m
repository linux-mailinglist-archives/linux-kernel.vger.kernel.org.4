Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC8674CC29
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjGJFXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjGJFXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:23:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6B7194
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 22:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=oEOriZarkfljqprvr62NM/lb/lGiSn39nVXv2jz5arw=; b=YPBBDcJVrT3jsdUPsn8/LtBMDF
        ZbdlX3OMbmu4impkMZ8OE+FDIl/ESBZvdHgHsMR7pANpHO3CeALTdDP/UUU0as+oztlFwD3DKN3XC
        KNd06lf9GwnKBRJxLOlJYHjyopcydrFHgpxVrGO3ZwvzdHtSnQ8SmxObTGInu1JQnnVLIdVNkIZNx
        F5LfrqLTqZxqeKJ8zdpcmdTz7aWWxvuLCeKHPTHDqui+Hyl+pOhhEdXmbKng3UvnpdXCL1ImUswJg
        /JKlol9fBY+AnasH+6ALtcon8xHJM8EX8m/5XG7q12PSm6FjEz0pk2+G6zZ5nCuIzKm6RvxpFaeSG
        KUMjuOsw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIjMi-00AT06-1b;
        Mon, 10 Jul 2023 05:23:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] coresight: fix spelling in etm3x ABI documentation
Date:   Sun,  9 Jul 2023 22:23:15 -0700
Message-ID: <20230710052315.32699-1-rdunlap@infradead.org>
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
Correct one grammar error.

Fixes: 7a25ec8e481e ("coresight: Adding ABI documentation")
Fixes: 7253e4c95616 ("coresight: etm3x: breaking down sysFS status interface")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x |   12 +++++-----
 1 file changed, 6 insertions(+), 6 deletions(-)

diff -- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
@@ -20,9 +20,9 @@ Date:		November 2014
 KernelVersion:	3.19
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
 Description:	(RW) Used in conjunction with @addr_idx.  Specifies
-		characteristics about the address comparator being configure,
+		characteristics about the address comparator being configured,
 		for example the access type, the kind of instruction to trace,
-		processor contect ID to trigger on, etc.  Individual fields in
+		processor context ID to trigger on, etc.  Individual fields in
 		the access type register may vary on the version of the trace
 		entity.
 
@@ -31,7 +31,7 @@ Date:		November 2014
 KernelVersion:	3.19
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
 Description:	(RW) Used in conjunction with @addr_idx.  Specifies the range of
-		addresses to trigger on.  Inclusion or exclusion is specificed
+		addresses to trigger on.  Inclusion or exclusion is specified
 		in the corresponding access type register.
 
 What:		/sys/bus/coresight/devices/<memory_map>.[etm|ptm]/addr_single
@@ -304,19 +304,19 @@ What:		/sys/bus/coresight/devices/<memor
 Date:		September 2015
 KernelVersion:	4.4
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description: 	(RO) Print the content of the ETM Trace Start/Stop Conrol
+Description: 	(RO) Print the content of the ETM Trace Start/Stop Control
 		register (0x018). The value is read directly from the HW.
 
 What:		/sys/bus/coresight/devices/<memory_map>.[etm|ptm]/mgmt/etmtecr1
 Date:		September 2015
 KernelVersion:	4.4
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description: 	(RO) Print the content of the ETM Enable Conrol #1
+Description: 	(RO) Print the content of the ETM Enable Control #1
 		register (0x024). The value is read directly from the HW.
 
 What:		/sys/bus/coresight/devices/<memory_map>.[etm|ptm]/mgmt/etmtecr2
 Date:		September 2015
 KernelVersion:	4.4
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description: 	(RO) Print the content of the ETM Enable Conrol #2
+Description: 	(RO) Print the content of the ETM Enable Control #2
 		register (0x01c). The value is read directly from the HW.
