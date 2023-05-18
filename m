Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841B1708A72
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjERV2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjERV16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:27:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851E510C3;
        Thu, 18 May 2023 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=oAU9Tw71N7HCDXsmkoPztWM1SDzn0JotQA0S92OAoI8=; b=HiXffUcw4VsdOYtjfHKc5BjNbG
        j/sEoj3OXmot33LuPLs53YNxbRTmH8dvPHrwVeuYOk1J4JtUC+jSQw/gAuve7ci4x+dE3VpjsT1+l
        l1M9c6aX7iUcDpcpPR91ytY9EheZpwxm4CV6jcY7K2b9DIZX+oQPD1P3e119XUeGPYv4kuDA9dz5I
        C5PA07Y1AYwYi+N3rnZZOE9yAO1nOFbYwaaaUvu+wM+NyW4DlMkYuDaz+DBY4WNE7DxAiSAOzMqR4
        yREq/hjwYSNgaas8zVK0qdBYa+svAVrRXUo6lMRml7vnOo3HNcHQxUhe/p4KGxGjmIz2f07ggd4Yx
        rWqfiy6g==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzlAD-00EFRV-17;
        Thu, 18 May 2023 21:27:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 10/11] Docs/scsi: ncr53c8xx: shorten chapter heading
Date:   Thu, 18 May 2023 14:27:48 -0700
Message-Id: <20230518212749.18266-11-rdunlap@infradead.org>
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

Make the chapter heading concise yet still descriptive.
This makes the subsystem table of contents more readable (IMO).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/scsi/ncr53c8xx.rst |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/Documentation/scsi/ncr53c8xx.rst b/Documentation/scsi/ncr53c8xx.rst
--- a/Documentation/scsi/ncr53c8xx.rst
+++ b/Documentation/scsi/ncr53c8xx.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=================================================
-The Linux NCR53C8XX/SYM53C8XX drivers README file
-=================================================
+===========================
+NCR53C8XX/SYM53C8XX drivers
+===========================
 
 Written by Gerard Roudier <groudier@free.fr>
 
