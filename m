Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514D8708A70
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjERV2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjERV1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:27:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935B2E6E;
        Thu, 18 May 2023 14:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XTcLkm+3UhFcHNAvdgJBL/VS22G9EHTBr4inNBOb/ik=; b=YuHH92sFsErpPMnJW9JJgzJbUK
        fsbMF5tXXWuQjyx15T7/aseRSy/qKYokTuvaug8bPfLKMsoPeHSJzZUdUYagoKU6G3i6woN0s4WXj
        wSw6X+5QLDjZdOLwPfw6pDqxSyBajDDj2ZEs/TSvk82F5RSWCMQ+ylsXkPgvoFa8lzIW5uZaYRcOz
        sOfHtScBN4kn0lwNIkFLSNMqZ4Hw483o3Vtvfghl7QrXRNRrqtzFoVjleO3AcAK5XK/m8xkNzWmFh
        6txQjQM8XCgrVTcfj+cKk2cXX4lmtFYGXhjUcQQOrAgBkDSnQwb2kSdd4n8BuZALqzohSVhV4brdM
        bmxoFJRw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzlAA-00EFRV-1L;
        Thu, 18 May 2023 21:27:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 03/11] Docs/scsi: arcmsr: use a chapter heading for clarity
Date:   Thu, 18 May 2023 14:27:41 -0700
Message-Id: <20230518212749.18266-4-rdunlap@infradead.org>
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

Add a chapter heading so that the document sections are not all
at the same level, mucking up the SCSI subsystem contents.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/scsi/arcmsr_spec.rst |    1 +
 1 file changed, 1 insertion(+)

diff -- a/Documentation/scsi/arcmsr_spec.rst b/Documentation/scsi/arcmsr_spec.rst
--- a/Documentation/scsi/arcmsr_spec.rst
+++ b/Documentation/scsi/arcmsr_spec.rst
@@ -1,3 +1,4 @@
+===================
 ARECA FIRMWARE SPEC
 ===================
 
