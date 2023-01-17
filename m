Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7015E66D692
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbjAQHCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbjAQHBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:01:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AF1233CE;
        Mon, 16 Jan 2023 23:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=CaJT0rYGPp0RRyxLHU+xKNZaW/U2SGXUMxBRbgTGFgg=; b=lT/6appo+nT3R1/TuuFGqOBVSZ
        82hiNuahQw8K9k2uTr3Wz42KWtHlFzIHjt2Y7VARbSdmvXvR4ZVCVE6DRwgaQHc9M1ctC1ICPfHah
        RHbzZsZibBa5YsotGU5xSO9Q+1ph2P1fSELEmOAA90HqXhC46sA5mS7wh4PyTnVzikaX6qbEpIbDh
        zZrAEaLnM8fbpEHKNMCH7gDeMkxvh8ds3VBHtArJOLTUpY4WJBm/yB0AGU3gBnOzuO4aNWcCiK8xF
        dx3hfRIJiafHyUIkU0gSW3o+wmqap9yNfFBjkSqnlwJw3pB0qx99nFaJ+XQtHV2OYHbg/e//J34ot
        cg1R0fSg==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHfyi-00D77n-58; Tue, 17 Jan 2023 07:01:52 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        target-devel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] scsi: elx: libefc_sli: use "/*" for non-kernel-doc comment
Date:   Mon, 16 Jan 2023 23:01:51 -0800
Message-Id: <20230117070151.29339-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use "/**" to begin non-kernel-doc comments.
Prevent a kernel-doc warning:

drivers/scsi/elx/libefc_sli/sli4.c:13: warning: cannot understand function prototype: 'struct sli4_asic_entry_t sli4_asic_table[] = '

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: James Smart <james.smart@broadcom.com>
Cc: Ram Vegesna <ram.vegesna@broadcom.com>
Cc: target-devel@vger.kernel.org
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
---
 drivers/scsi/elx/libefc_sli/sli4.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/scsi/elx/libefc_sli/sli4.c b/drivers/scsi/elx/libefc_sli/sli4.c
--- a/drivers/scsi/elx/libefc_sli/sli4.c
+++ b/drivers/scsi/elx/libefc_sli/sli4.c
@@ -4,7 +4,7 @@
  * “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.
  */
 
-/**
+/*
  * All common (i.e. transport-independent) SLI-4 functions are implemented
  * in this file.
  */
