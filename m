Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBA366E6E9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjAQTYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbjAQTOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:14:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6F645BC6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ZtExKv0kW+ly456QxzMIxMFsB7eXWSzitTEpn5KuG0Y=; b=IjwUaOMrsAJ2T/TOjvhsDYh0av
        p8/eS52ca2zKVX/iK/2VT8COUVeqPNkEpIQ3Y4EpH1GaeoZJ2uiGcoNU15i770HfS5G1wptN3OLx1
        DxgHaffXvHPtupVJeNEnDk+HHUH39Jrjr2M3XF0/QMZhqkbl3vFxKKui3cJYcb2rLiDngirAT05bY
        ChXDX5ZtoYNIKwDIPvyFIqQX1YzeEK52ibtwyEZ/rsOchMYgwRmav9MzgdlMXyIivQLE29vpaf9kD
        YGiZk/sNyDuIQf923X2xFfOrRWc3tXj8KK95qSdb04TTzEkbNE929RKE7bvMPZGIekvdbLGdVI6D3
        KBB1Qj9w==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHqhM-00FRU3-V5; Tue, 17 Jan 2023 18:28:41 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] most: tell what the MOST acronym means
Date:   Tue, 17 Jan 2023 10:28:40 -0800
Message-Id: <20230117182840.26890-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tell kconfig users what "MOST" means so that they can have a bit
of information about what it is. I.e., more than zero information.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Christian Gromm <christian.gromm@microchip.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/most/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/most/Kconfig b/drivers/most/Kconfig
--- a/drivers/most/Kconfig
+++ b/drivers/most/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 menuconfig MOST
-	tristate "MOST support"
+	tristate "MOST (Media Oriented Systems Transport) support"
 	depends on HAS_DMA && CONFIGFS_FS
 	default n
 	help
