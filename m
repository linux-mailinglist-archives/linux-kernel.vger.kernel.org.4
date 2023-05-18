Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E05F708A71
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjERV2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjERV14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:27:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D785CC0;
        Thu, 18 May 2023 14:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yDH+ArLaMd1MpNSWYh/A1MRf2Rgus6BaFTXxBSJze68=; b=Jh/frAeYv5ETQfMQFtPJebX1Kx
        kNzQ7diUtmMNOL9WJg9cJM72ZF1vNC9llzk0HbgHGbauguhuPHThfbpOYAxVXO1g8NWNFPfguRWd2
        FNep8Fr0OaLrSpco61L1jMSRBFyIEiQY2djdQZB6OacK/auuTbGQ2UBU9rWvYUnlORy5nKfs5q4wD
        aSm92iQyvURHUAKhxHxkhYSUafnGki7b3gJujL0tf2QVSNyZ8jAuCiwdlT4cbI/uerp4pJLb9XRu6
        XqMeU05r/hu/Onos6tq6hXkrJdn5Z7dx4G/H2TzaurtGjTtiU+sgFHgBT3fSF6Lx6h/9QEBSFQqKK
        wUfLwuYA==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzlAB-00EFRV-2E;
        Thu, 18 May 2023 21:27:55 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, James Smart <james.smart@broadcom.com>
Subject: [PATCH 06/11] Docs/scsi: scsi_fc_transport: fix typo in heading
Date:   Thu, 18 May 2023 14:27:44 -0700
Message-Id: <20230518212749.18266-7-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518212749.18266-1-rdunlap@infradead.org>
References: <20230518212749.18266-1-rdunlap@infradead.org>
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

Fix the typo "Tansport" to be "Transport".
Update email address for James Smart.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: James Smart <james.smart@broadcom.com>
---
 Documentation/scsi/scsi_fc_transport.rst |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -- a/Documentation/scsi/scsi_fc_transport.rst b/Documentation/scsi/scsi_fc_transport.rst
--- a/Documentation/scsi/scsi_fc_transport.rst
+++ b/Documentation/scsi/scsi_fc_transport.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-================
-SCSI FC Tansport
-================
+=================
+SCSI FC Transport
+=================
 
 Date:  11/18/2008
 
@@ -556,5 +556,5 @@ The following people have contributed to
 
 
 James Smart
-james.smart@emulex.com
+james.smart@broadcom.com
 
