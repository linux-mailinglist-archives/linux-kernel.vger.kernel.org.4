Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34838708A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjERV14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjERV1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:27:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39026C0;
        Thu, 18 May 2023 14:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jld4blv7JTyD5AZmscX7auzPqXTZgQjlC8t12N4eprQ=; b=UtpvzxQmbT2/Botb7PJFc2DUyj
        xR2RpLQ5OUBfT6TBGT/x4y/NUNLe/kQZoCp2/MIsKqYWGpFMtGqOjBpHAJpmgut02egE8v5mmwOlL
        FLqi5fAHaJEqbD8D+soCNTvpXwY8yXGfglgXJCK/tkhF7/PhrJ6EZit/xIgDxQ5YEetYoLoqhfSjm
        h/AYRF2Z2ucA8c13tsNTqyjaQwxGS4eqmgKEm72pSOCvJlkSdqHAODjLF8FtSDvVLsVbMG7i3Mo+z
        FfXy9LtYWR+C2YBZZyx7+S2cboIwrpOu1bUJWfeUJlSPZqVLFVH7qAWlalJlzqGsfyS/9VBs5JbgO
        s5DjIKew==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzlA9-00EFRV-2E;
        Thu, 18 May 2023 21:27:53 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 01/11] Docs/scsi: organize the SCSI documentation
Date:   Thu, 18 May 2023 14:27:39 -0700
Message-Id: <20230518212749.18266-2-rdunlap@infradead.org>
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

Break the SCSI documentation up into categories:
  Introduction, APIs, driver parameters, and host adapter drivers
instead of alphabetical by document file name (i.e., no organization).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/scsi/index.rst |   37 ++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff -- a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
--- a/Documentation/scsi/index.rst
+++ b/Documentation/scsi/index.rst
@@ -7,6 +7,38 @@ SCSI Subsystem
 .. toctree::
    :maxdepth: 1
 
+Introduction
+============
+
+.. toctree::
+   :maxdepth: 1
+
+   scsi
+
+SCSI driver APIs
+================
+
+.. toctree::
+   :maxdepth: 1
+
+   scsi_mid_low_api
+   scsi_eh
+
+SCSI driver parameters
+======================
+
+.. toctree::
+   :maxdepth: 1
+
+   scsi-parameters
+   link_power_management_policy
+
+SCSI host adapter drivers
+=========================
+
+.. toctree::
+   :maxdepth: 1
+
    53c700
    aacraid
    advansys
@@ -25,7 +57,6 @@ SCSI Subsystem
    hpsa
    hptiop
    libsas
-   link_power_management_policy
    lpfc
    megaraid
    ncr53c8xx
@@ -33,12 +64,8 @@ SCSI Subsystem
    ppa
    qlogicfas
    scsi-changer
-   scsi_eh
    scsi_fc_transport
    scsi-generic
-   scsi_mid_low_api
-   scsi-parameters
-   scsi
    sd-parameters
    smartpqi
    st
