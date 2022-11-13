Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C339462728F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 21:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbiKMUew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 15:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbiKMUe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 15:34:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8B513F3B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 12:34:08 -0800 (PST)
Message-ID: <20221113202428.760225831@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668371647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vyAOtKiLGPQMWrI5pYLj7HpC4nHb4okxWSCEhrh3OOM=;
        b=Xz/Y1+VIzP9pbSypMlXf+X/sNaUEPUWPUH9bQWxGwqeZODSdxQKWNeogVr3kCWqK7UEj87
        ZeJ+38WeuHAWrCqV+Yhak7aZXgncZoRBqUtiOOjlp+SGxO63SEc7ICQj9USO5LMFI/NRzS
        MshbFmHYUImYi1s9N7MLI0840xCgrcmnf/GereoRsVBO2mm3ZBEZW/RoFv7EZ0XEotJxfm
        gxCEEFhpYE24V7bXt0WnwOQtYhekgURXB7HWkMhlXBfpqvn61fBvU9p24ieDfMvuFFxCPh
        2lswRiScac9f/60BJbwl0QxwRtzLEaYw8pW/r8tP2Yvw+fMmfYkwNqbjFV1N2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668371647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vyAOtKiLGPQMWrI5pYLj7HpC4nHb4okxWSCEhrh3OOM=;
        b=FVL1KDMHMo8lgvFwMJInGIgweoymkp4w854y1gSCbVlVZ3ku0/B9MLscUdJMKiQ8MJnuV3
        L7a9lEw9sZJv+sCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Roy Pledge <Roy.Pledge@nxp.com>
Subject: [patch 08/10] soc: fsl: dpio: Remove linux/msi.h include
References: <20221113201935.776707081@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 13 Nov 2022 21:34:07 +0100 (CET)
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
Cc: Roy Pledge <Roy.Pledge@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-driver.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -10,7 +10,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
-#include <linux/msi.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
 #include <linux/io.h>

