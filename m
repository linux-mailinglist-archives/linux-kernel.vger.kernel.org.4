Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC1D627292
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 21:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiKMUe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 15:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbiKMUe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 15:34:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B85913FA9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 12:34:12 -0800 (PST)
Message-ID: <20221113202428.889624434@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668371650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=YkMxMrabi+IajYRzCsrYeAzbu1EBQ4csF5+thdpPrds=;
        b=J+Ul5JWG32rrZBX71vu9MQW8iyU1A+9SCAkWtCfTKSPGDf20HxCFoECki/Hm9zpGUPSeAl
        aWzlBFkExgBh0YDjCpeZuar9sv8A5WFHtF3M20ntvQiLAK95EOEnaVVsFSoGWrr/M1/jCf
        YHe2STvK/Zdp7N50j90T6ZP27LeT6pqQf6hLWZZlqdiWKhtzdAWx4HKVzL9Vpa2bjw6AjC
        p3FEYRTnCQfgH5g/qPWRbZQFIr0/1y1HxptJg5haYwY50HncHEzkp/A0/YrJo+RrgCRAQ+
        bnlnQ+ogZFRroPm6cldgVJk6qTNS0k43PhaowzDYCrBJsRrNjCdTpGY/XL5h9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668371650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=YkMxMrabi+IajYRzCsrYeAzbu1EBQ4csF5+thdpPrds=;
        b=gqQvycs9a0Zvj99YpeGgt7McPtJu5+1PmYs4bkA2uiefsEw+F5gfGn1pjCAQfnDlWVkTJ9
        YdoYaXQasjSXncAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: [patch 10/10] iommu/of: Remove linux/msi.h include
References: <20221113201935.776707081@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 13 Nov 2022 21:34:10 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing in this file needs anything from linux/msi.h

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
---
 drivers/iommu/of_iommu.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -9,7 +9,6 @@
 #include <linux/iommu.h>
 #include <linux/limits.h>
 #include <linux/module.h>
-#include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>

