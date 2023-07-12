Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE5C75043D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjGLKQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjGLKQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:16:33 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23371991
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:16:31 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1DDD5lYRzBR7bG
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 18:16:28 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689156988; x=1691748989; bh=NjUUY+3+UT6hCyVfFCcB4tKetyX
        PuWZgUfS/KNX/ki8=; b=PJ7YOnWtfWVqFe/KWBWia5RMFiLBWLLv/xgct7EB7Q/
        akhYL22hf93gFIbahTCGaQt5d56sqp4GZl0bIavzsdE6VzLfk4M2DpM/ddFjp/Xp
        QHk0pGd/eH8K/hg0/zgaTeiqm+N9h40+uhHX5jcm5YtjWf/RFaVpxqZPnC6cZEJH
        iKnNKGpgZ9ENWCwKrLrhot7bBFWDFjIA7/QazKELhUMxmfVOG2/GNS7foxJtFB3L
        VJF6LEZjEfSw6nySmh09fQMhy/nccL4EHCuy0dA9qLeTs3WHG7nbixM8xi6J+HMa
        DJRW8po+pa8KcaPItVrMTAQQLaRMuz+QN+3nEGf67vA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id D5gKpVIJH9jy for <linux-kernel@vger.kernel.org>;
        Wed, 12 Jul 2023 18:16:28 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1DDD3P90zBHXgf;
        Wed, 12 Jul 2023 18:16:28 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 12 Jul 2023 18:16:28 +0800
From:   hanyu001@208suo.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Fwd: [PATCH] scsi: snic: Convert snprintf to scnprintf
In-Reply-To: <tencent_D20A645667548A8D5B1261D32ED4369FD70A@qq.com>
References: <tencent_D20A645667548A8D5B1261D32ED4369FD70A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <fe09ebd8774d05dc4038e640d7ddb2e4@208suo.com>
X-Sender: hanyu001@208suo.com
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

Coccinelle reports a warning:

drivers/scsi/snic/snic_attrs.c:35: WARNING: use scnprintf or sprintf
drivers/scsi/snic/snic_attrs.c:48: WARNING: use scnprintf or sprintf
drivers/scsi/snic/snic_attrs.c:26: WARNING: use scnprintf or sprintf:

Signed-off-by: ztt <1549089851@qq.com>
---
  drivers/scsi/snic/snic_attrs.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/snic/snic_attrs.c 
b/drivers/scsi/snic/snic_attrs.c
index 3ddbdbc3ded1..255cff16c2bd 100644
--- a/drivers/scsi/snic/snic_attrs.c
+++ b/drivers/scsi/snic/snic_attrs.c
@@ -13,7 +13,7 @@ snic_show_sym_name(struct device *dev,
  {
      struct snic *snic = shost_priv(class_to_shost(dev));

-    return snprintf(buf, PAGE_SIZE, "%s\n", snic->name);
+    return scnprintf(buf, PAGE_SIZE, "%s\n", snic->name);
  }

  static ssize_t
@@ -23,7 +23,7 @@ snic_show_state(struct device *dev,
  {
      struct snic *snic = shost_priv(class_to_shost(dev));

-    return snprintf(buf, PAGE_SIZE, "%s\n",
+    return scnprintf(buf, PAGE_SIZE, "%s\n",
              snic_state_str[snic_get_state(snic)]);
  }

@@ -32,7 +32,7 @@ snic_show_drv_version(struct device *dev,
                struct device_attribute *attr,
                char *buf)
  {
-    return snprintf(buf, PAGE_SIZE, "%s\n", SNIC_DRV_VERSION);
+    return scnprintf(buf, PAGE_SIZE, "%s\n", SNIC_DRV_VERSION);
  }

  static ssize_t
@@ -45,7 +45,7 @@ snic_show_link_state(struct device *dev,
      if (snic->config.xpt_type == SNIC_DAS)
          snic->link_status = svnic_dev_link_status(snic->vdev);

-    return snprintf(buf, PAGE_SIZE, "%s\n",
+    return scnprintf(buf, PAGE_SIZE, "%s\n",
              (snic->link_status) ? "Link Up" : "Link Down");
  }
