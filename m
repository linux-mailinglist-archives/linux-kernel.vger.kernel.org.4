Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9016BB55B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjCON5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjCON5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:57:33 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737046A2DC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:57:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o12so75888552edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678888643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5gwGEr7hORPK5Xm0RmOlgJgjBRyOt+rt8ougO/W0Ws=;
        b=Rn/dHkSH+oiXFCCItYOodm56LLRtpRrNP4yAZLAHBQa1vrzBO4Fj6ITwujzSPWYMTw
         vPhgEqLqOO5XK52hRBalT14EH4wtt1W5auCQZ9hPuSc+l5Os5ERIIvSt7yERmApi8DjL
         5XfWY2NWe5JouBQYztQ4jcFCbkvKM7B+DGYWzZxFmj4cW2NjwMv+fnEYtHg7xiRiTxCD
         Tf3eSyZevSBstKNeBJ8dghyefJvCzH5t7PwwItnGY7xL7NvbpmOYYZ1R5hLLL/F3skSO
         gKhe56DLuESvGuGhaMdaVFdY0VsO1YQFpu5WPh9fZYx1Y0L/o2dDc17CnQTUe7OEliT/
         gaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678888643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5gwGEr7hORPK5Xm0RmOlgJgjBRyOt+rt8ougO/W0Ws=;
        b=371Rap7EhjJT3YM8yKTrtVFoFlDfbUdt3vQOs0FGb/pWn6V0nldB5hvS51JSdI432d
         Btcw7RaM6zVRDrNDqsqKfiN1YGMjtJXpFMzIUxUjSX2ZkXWYW04UO8jnSV5pcrR5V8Nt
         JzMw3HqHwcdr04k2xa3G95NrF2NGZ1b+7XsUpFNR5hG6agNct017tSPVIoMDMu6LR4Jb
         GaizwNqyhEeutLXUYDLFnw53VTRRhnlSTgLGgoYkxtWIkjOfwucURU00EMlfI/IAKSKo
         vEMk2TaZ+tJQF4uxH2GayoNqEwxJx4X4Zk/gmJDYeum33EOnP014TX5Ns2mYr6SyN72v
         dmmw==
X-Gm-Message-State: AO0yUKUXCbxUD4mFuKIZvyNaZsExtku5btZLjQ5ReHrMvCA4V6VGCKp8
        IQhmY5X0VJmRIC2IB+CdHWY=
X-Google-Smtp-Source: AK7set9zdnwlaThvC4G0BCVmrR0uAUqL1u0JsTiU29fX1meXkY1gPwC6Lqb3ZLIh679ogpDlInXoJw==
X-Received: by 2002:a17:906:76d9:b0:92f:44f8:7250 with SMTP id q25-20020a17090676d900b0092f44f87250mr1456665ejn.27.1678888642912;
        Wed, 15 Mar 2023 06:57:22 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id jz14-20020a17090775ee00b00926f89e2213sm2529441ejc.190.2023.03.15.06.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:57:22 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, zoo868e@gmail.com, jerrykang026@gmail.com,
        cuigaosheng1@huawei.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        eng.mennamahmoud.mm@gmail.com
Subject: [PATCH v3 2/2] staging: vme_user: remove unnecessary blank lines
Date:   Wed, 15 Mar 2023 15:57:09 +0200
Message-Id: <3c194568de78d1c551afe2b8b079a27867f906d2.1678888612.git.eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <078be1ba242950f31d0aa13fe9815d92fe96468b.1678888612.git.eng.mennamahmoud.mm@gmail.com>
References: <078be1ba242950f31d0aa13fe9815d92fe96468b.1678888612.git.eng.mennamahmoud.mm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary blank lines before a close brace
as reported by checkpatch script

"CHECK: Blank lines aren't necessary before a close brace '}'"

Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
change in v2:
	edit commit message
---
change in v3:
        edit commit message
---
 drivers/staging/vme_user/vme_tsi148.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index bfa604043355..2f5eafd50934 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -1023,7 +1023,6 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
 err_res:
 err_window:
 	return retval;
-
 }
 
 /*
@@ -1741,7 +1740,6 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
 				  list);
 		prev->descriptor.dnlau = cpu_to_be32(address_high);
 		prev->descriptor.dnlal = cpu_to_be32(address_low);
-
 	}
 
 	return 0;
@@ -1773,7 +1771,6 @@ static int tsi148_dma_busy(struct vme_bridge *tsi148_bridge, int channel)
 		return 0;
 	else
 		return 1;
-
 }
 
 /*
@@ -2220,7 +2217,6 @@ static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
 	}
 
 	return 0;
-
 }
 
 static void tsi148_crcsr_exit(struct vme_bridge *tsi148_bridge,
@@ -2530,7 +2526,6 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	kfree(tsi148_bridge);
 err_struct:
 	return retval;
-
 }
 
 static void tsi148_remove(struct pci_dev *pdev)
-- 
2.34.1

