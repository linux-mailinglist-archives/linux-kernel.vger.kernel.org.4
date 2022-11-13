Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6ED6627288
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 21:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbiKMUeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 15:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbiKMUeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 15:34:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89B812D34
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 12:34:02 -0800 (PST)
Message-ID: <20221113202428.511591041@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668371641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7GsSSHXSEftdKzalYAlU629YtiUc1uiYtJyFKoqYJQk=;
        b=eSvqQ8oy2NQ+1A9AJ4fKDTznVmWjfx+FdooSNiPQz6dMPVTs093A4LkXVJaHJPYzcwUL3r
        1dlsq+aorkFRDSNwlKtND0te4WNGiNrDReTiOypnhMxKWUWmHMM1NoOePk3yrSQExOptaS
        jTDD4iW2+d/K9OJqVZvgauWF2LsslExGgCQlkl3TWo72kpNtEtF8l5lHyxfeK4rUddz66l
        4MT5EHGjx7Il27CbeLZJef2ob2vzbzVCvhX/Me0CINdEShr5zItbHpTY58ieCMBDFeWTKx
        hg+EJpWxW7/xZ73DY5SKQyB2mr1Ltze1U6H6+L0rYDjTZauYGrwGOpw5huHKBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668371641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7GsSSHXSEftdKzalYAlU629YtiUc1uiYtJyFKoqYJQk=;
        b=N1MFDc+/1Vr3iiuIW88I5UqYF8/ubSFoK0KTLrVZBsyLQAboqmkhenvnojYtmHML0y1vjj
        gng74O4Dd56eEkBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [patch 04/10] bus: fsl-mc: Remove linux/msi.h includes
References: <20221113201935.776707081@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 13 Nov 2022 21:34:00 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither dprc-driver.c nor fsl-mc-bus.c need anything from linux/msi.h.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c |    1 -
 drivers/bus/fsl-mc/fsl-mc-bus.c  |    1 -
 2 files changed, 2 deletions(-)

--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/msi.h>
 #include <linux/fsl/mc.h>
 
 #include "fsl-mc-private.h"
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -17,7 +17,6 @@
 #include <linux/slab.h>
 #include <linux/limits.h>
 #include <linux/bitops.h>
-#include <linux/msi.h>
 #include <linux/dma-mapping.h>
 #include <linux/acpi.h>
 #include <linux/iommu.h>

