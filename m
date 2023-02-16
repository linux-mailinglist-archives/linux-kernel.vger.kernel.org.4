Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3FB699D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 21:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBPUN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 15:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBPUN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 15:13:26 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4A24D60C;
        Thu, 16 Feb 2023 12:13:24 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|hussein@unixcat.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1FD5E881AD4;
        Thu, 16 Feb 2023 20:13:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a274.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9ED1E881011;
        Thu, 16 Feb 2023 20:13:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1676578403; a=rsa-sha256;
        cv=none;
        b=p1dtj3p+OQYk0auonZJG6uG8OX5O2foRl56L27Z+SPTwpyCr5iYeeEslJOP07X+P/ERvfF
        qyTI0CKp9taXJF2wlnCRia4i3EFV4mjFiqME5rbwKkBkyBtHHhT4F+WbYIgYaSpD3jd8n+
        jVTST8fRUUmIU8Bgg+QGRMlL4eOMLe3jY7w4ARksL7UOAgGsghKsMelDg7sjbSVt9ixHAs
        o7R1Or8NCLG7McKwP8qwu+hj0zgqK2c/Z3NpnN/2k05MdR4OpoqYZx3lU9rBJqck208vb4
        s08q4VF+7gy1yiCgm2HhFZv5hXtfdTPlf9p53Sjyie+sbebZAm57eyyW6fbYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1676578403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=KbIa0sIStAMO0mMB6RiYRVtu/9/bZPgLeoihDTD5mi4=;
        b=gOwVOuSBcwMp5iwSfUGXPZhtQ09fqB0UveQ0dPUoFZ5UJanSLxuCLxRROQyZ8dtkQ1Ks33
        Ypz6Z4bV5qY69bCzkTYpK/OyurKI6h7mqgOXq//B8K2Zs2RDOkRPjddD+r0zCm15H+BeOr
        XIcZz5xSADcS+fMfbafrIJ7VSjV8C0j6Z8kCz34DYQmKPrES6FPLup659+b+QIvVhz1/cF
        hCwBHe40DsdIuzHzBeppTJaCQ4OYgXJZ5LLz0sbc5+dnkf0Qp74y1NV8viun14WYoZGDxK
        UEq6XW9L6CEHPDrCrGU6NunSHbEaR+cueXHjkGwd1hmLIG7lBC2p4HltKGZp2g==
ARC-Authentication-Results: i=1;
        rspamd-b9c55767f-4hcbr;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=hussein@unixcat.org
X-Sender-Id: dreamhost|x-authsender|hussein@unixcat.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|hussein@unixcat.org
X-MailChannels-Auth-Id: dreamhost
X-Tank-Lettuce: 4b0928a05bcc2948_1676578403899_2556423479
X-MC-Loop-Signature: 1676578403899:1245416223
X-MC-Ingress-Time: 1676578403898
Received: from pdx1-sub0-mail-a274.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.138.42 (trex/6.7.1);
        Thu, 16 Feb 2023 20:13:23 +0000
Received: from localhost (unknown [175.144.191.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hussein@unixcat.org)
        by pdx1-sub0-mail-a274.dreamhost.com (Postfix) with ESMTPSA id 4PHmNL6rRTzC5;
        Thu, 16 Feb 2023 12:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unixcat.org;
        s=dreamhost; t=1676578403;
        bh=KbIa0sIStAMO0mMB6RiYRVtu/9/bZPgLeoihDTD5mi4=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=Xk4w1vUy9AUhEl4QSdG7Dn3z6mhKBLEjxyGqcWcfAs8p4igOJCvbOt5DtPj6ENPoy
         JjGRBrZLgObuIB2wQ1XYgSsoigwZhuhYM98TBpvDjXjYEXivBhs9/DwI3mD53mWZjh
         KpD94jpZLkQaCtOaJChpbI5FZOwlxSS/RmwtaxzY=
From:   Nur Hussein <hussein@unixcat.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nur Hussein <hussein@unixcat.org>
Subject: [PATCH] Add error checking to sysfs_update_group in drivers/scsi/scsi_transport_spi.c
Date:   Fri, 17 Feb 2023 04:12:59 +0800
Message-Id: <20230216201259.405939-1-hussein@unixcat.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An instance of sysfs_update_group now checks the result and on error,
logs it via pr_err().

Signed-off-by: Nur Hussein <hussein@unixcat.org>
---
 drivers/scsi/scsi_transport_spi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transport_spi.c
index 2442d4d2e3f3..f905b4787a42 100644
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -1559,8 +1559,9 @@ static int spi_target_configure(struct transport_container *tc,
 {
 	struct kobject *kobj = &cdev->kobj;
 
-	/* force an update based on parameters read from the device */
-	sysfs_update_group(kobj, &target_attribute_group);
+	/* force an update based on parameters read from the device, log an error on failure */
+	if (sysfs_update_group(kobj, &target_attribute_group))
+		pr_err("Unable to update sysfs entries\n");
 
 	return 0;
 }
-- 
2.34.1

