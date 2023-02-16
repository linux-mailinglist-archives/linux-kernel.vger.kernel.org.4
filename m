Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BFF69897F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 01:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjBPAwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 19:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBPAwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 19:52:03 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A262442FC;
        Wed, 15 Feb 2023 16:51:56 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id my5so1358102ejc.7;
        Wed, 15 Feb 2023 16:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4v+iNw6q2DG3+59CLINEXsz+S06u+U0lm+HG2C4jGxE=;
        b=mFHCMd0aJvzYV8ebvfzCy0rUFUCQIaQS6LLaPW4b6Zri6SxgIZNH7ly80nmMga8Z/X
         WRcTTtOBx6dtEVv4TJ3LrdIuJCYBNMl9UykYImHKSHbyUGRZaNf9vCesZTjB/NhyYKxZ
         PMeWHYRJyfULSP+HPPDszuxfxTkvWWCV2Swuw+aZGgB+u31be3zwdnbc50kiAwo3utW9
         JL0bRIa1GoET5jupRoMI8euVuSTai5Jn3nny6gd0qPMreFej/K10cXSumwtVlnfVROhc
         I+xPdbsRgmQR8qkLXvbSGsjpDPOAd1++88sBzEg6q5A5uPX1cfrrqrtKxEJ8fFCbOonU
         HgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4v+iNw6q2DG3+59CLINEXsz+S06u+U0lm+HG2C4jGxE=;
        b=RGeq42sbRbL/voNK5gL2Eo7DeK9NOKXoXQC06r0TM/3hElEG7GGeFrh9HuO2RAw9Pr
         jMGFh6Zfy61ar88MsChSwhQoGKjk/EoOECWJO+9nL9+YuwQVgeOWAOiCxkFPJU8U4QRr
         0V7NySk4b6mXHWnhE70hyzb0qSN8uk83K5O9MxgRClsA/31voKZxGxOA3+kjozJMnspg
         706HWb9wfmlNvRAiBYSfHqri3nah7pT5FMUhXUc0DmNY9LSB8Ki405W9YX7EIGRmgkNu
         3GPxIRg+zusgOT9U2xuCJnnTdPzn6NY4bpWiykMOydVeO2Rw5Vx+6tIItocfKa0VqnIS
         J3Kw==
X-Gm-Message-State: AO0yUKWaeIxlfAAiH7dLE2DrKNkd5ptI2xGi7cH4beniDBMN8qXGR5ax
        Yrdt3NULjvvgRp/xT15E0pWNQbMaAvGsOOrY
X-Google-Smtp-Source: AK7set9cRrJyPdpGki4EUEEuFujUpmeIPVGGaFioBkj3PCdktnAuX4kXBJtE4q6z7559GXPYdOZ2cA==
X-Received: by 2002:a17:906:aec9:b0:883:fe6b:814 with SMTP id me9-20020a170906aec900b00883fe6b0814mr4132010ejb.37.1676508714773;
        Wed, 15 Feb 2023 16:51:54 -0800 (PST)
Received: from smurf (80.71.142.58.ipv4.parknet.dk. [80.71.142.58])
        by smtp.gmail.com with ESMTPSA id v18-20020a1709060b5200b008a9e585786dsm74600ejg.64.2023.02.15.16.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 16:51:54 -0800 (PST)
Date:   Thu, 16 Feb 2023 01:51:30 +0100 (CET)
From:   Jesper Juhl <jesperjuhl76@gmail.com>
To:     linux-kernel@vger.kernel.org
cc:     linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        GR-QLogic-Storage-Upstream@marvell.com
Subject: [Patch] [drivers/scsi] Remove unneeded version.h includes
Message-ID: <820137c2-decc-3d78-f170-7f1c0571fbb7@gmail.com>
User-Agent: Alpine 2.26 (LNX 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 141c4edb27491e75d63d3e38ec904f36439c03e0 Mon Sep 17 00:00:00 2001
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Mon, 13 Feb 2023 02:48:17 +0100
Subject: [PATCH 03/12] [drivers/scsi] Remove unneeded version.h includes
  pointed out by 'make versioncheck'

Signed-off-by: Jesper Juhl <jesperjuhl76@gmail.com>
---
  drivers/scsi/cxgbi/libcxgbi.h | 1 -
  drivers/scsi/mpi3mr/mpi3mr.h  | 1 -
  drivers/scsi/qedi/qedi_dbg.h  | 1 -
  3 files changed, 3 deletions(-)

diff --git a/drivers/scsi/cxgbi/libcxgbi.h b/drivers/scsi/cxgbi/libcxgbi.h
index 3687b5c0cf90..d8fc7beafa20 100644
--- a/drivers/scsi/cxgbi/libcxgbi.h
+++ b/drivers/scsi/cxgbi/libcxgbi.h
@@ -24,7 +24,6 @@
  #include <linux/scatterlist.h>
  #include <linux/skbuff.h>
  #include <linux/vmalloc.h>
-#include <linux/version.h>
  #include <scsi/scsi_device.h>
  #include <scsi/libiscsi_tcp.h>

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index def4c5e15cd8..427051320564 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -29,7 +29,6 @@
  #include <linux/types.h>
  #include <linux/uaccess.h>
  #include <linux/utsname.h>
-#include <linux/version.h>
  #include <linux/workqueue.h>
  #include <asm/unaligned.h>
  #include <scsi/scsi.h>
diff --git a/drivers/scsi/qedi/qedi_dbg.h b/drivers/scsi/qedi/qedi_dbg.h
index 37d084086fd4..fdda12ef13b0 100644
--- a/drivers/scsi/qedi/qedi_dbg.h
+++ b/drivers/scsi/qedi/qedi_dbg.h
@@ -11,7 +11,6 @@
  #include <linux/kernel.h>
  #include <linux/compiler.h>
  #include <linux/string.h>
-#include <linux/version.h>
  #include <linux/pci.h>
  #include <linux/delay.h>
  #include <scsi/scsi_transport.h>
-- 
2.39.2

