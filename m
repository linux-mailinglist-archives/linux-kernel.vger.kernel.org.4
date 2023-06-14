Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E773872F872
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243822AbjFNIyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243784AbjFNIyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:54:46 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706AB10E9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:54:44 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qgzkl6hRtzBQJZQ
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:54:39 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686732879; x=1689324880; bh=NXspP6LKCH9WQXgrfGSWn0gRJXx
        XFr3UTCp4ndLYBcE=; b=ntix1U9dhofP07tpOOOxtJetvOTL9/WbBf8pgFJUB/S
        S1p9JEI8TN97kIQ35/a42gK4bVQ4QUO2fQqraNxvPKynxHxFMlGPpMSzmm41y9c+
        +rU3Disa6+Td22m93DE5wBTxumqoWIBCENGRJdC4+AbixTJ8712X+v3Ryn4Pw07+
        TSi57S4bY/iNVQ2b2hB78Xv+wWev3dnP2kDCapmmCqk+uR6dmI68VPmKkxd/i67c
        beO/35kZNTZhv+/+FMnYANRhveb2woMLaenPRaSckDHXNfjcBg5EBzkxJNdPi3e+
        P2KZeM0h7AwMoPtU9tat+LlC8GQawpAtkhJswsSobog==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lySVEt3fZPUR for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 16:54:39 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qgzkl45Y3zBJJDJ;
        Wed, 14 Jun 2023 16:54:39 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 16:54:39 +0800
From:   baomingtong001@208suo.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qlogicpti: Remove unneeded semicolon
In-Reply-To: <20230614085236.43022-1-luojianhong@cdjrlc.com>
References: <20230614085236.43022-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <5b703018fcab06a574c713c318df1112@208suo.com>
X-Sender: baomingtong001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./drivers/scsi/qlogicpti.c:1153:3-4: Unneeded semicolon

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  drivers/scsi/qlogicpti.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 1e8fbd457248..52253b7da157 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1150,7 +1150,7 @@ static struct scsi_cmnd 
*qlogicpti_intr_handler(struct qlogicpti *qpti)
          case COMMAND_ERROR:
          case COMMAND_PARAM_ERROR:
              break;
-        };
+        }
          sbus_writew(0, qpti->qregs + SBUS_SEMAPHORE);
      }
