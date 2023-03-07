Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F846AF191
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCGSph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbjCGSpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:45:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371ACB7892;
        Tue,  7 Mar 2023 10:34:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33930B819C8;
        Tue,  7 Mar 2023 18:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B7EC433D2;
        Tue,  7 Mar 2023 18:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678213735;
        bh=OIhHmt2mnVsj3tF12NCkxNkZk2sHr3gGQeR6T7IdeXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKAir1xm950sFtlcYl80bwtjz9HkP1qTD3IAxsc2XVk1pbEzDWfub0f2moNJXbndc
         INf5FRhN+ARZEKaFr9yQw8MV23msDm6/wwu1gdEfzkpHZ/1zY+ETDfrklfKXpNGFiO
         kydB+qWt0GMjfu7JNuIb+TBNnm26+i3idJCIUir8CqQ+wc6ONRFyUFm+oxyItXSj+4
         m06It2oCrrxW4owGhcWvGW5ctvOzgZKDlPOMWoHOdaKiKe2hUJKvjLwGLZv2WrV9Yt
         0qKPHVyVH1RaefFkLQqtCcQxqtL2/HWMadJzJuHggFK6AuBohnnsGyNOMNxKj1ea8a
         8EcmjP/nzoBvg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 02/10] scsi: arcmsr: Remove unnecessary aer.h include
Date:   Tue,  7 Mar 2023 12:28:34 -0600
Message-Id: <20230307182842.870378-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307182842.870378-1-helgaas@kernel.org>
References: <20230307182842.870378-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

<linux/aer.h> is unused, so remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/scsi/arcmsr/arcmsr_hba.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index d3fb8a9c1c39..9d04cb6e62fa 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -57,7 +57,6 @@
 #include <linux/timer.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
-#include <linux/aer.h>
 #include <linux/circ_buf.h>
 #include <asm/dma.h>
 #include <asm/io.h>
-- 
2.25.1

