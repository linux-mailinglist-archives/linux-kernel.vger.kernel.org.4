Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE126A8897
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 19:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjCBSh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 13:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCBSh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:37:56 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E975E272D;
        Thu,  2 Mar 2023 10:37:54 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|hussein@unixcat.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8DAF514168F;
        Thu,  2 Mar 2023 18:37:52 +0000 (UTC)
Received: from pdx1-sub0-mail-a274.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BABA4141DAC;
        Thu,  2 Mar 2023 18:37:50 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677782272; a=rsa-sha256;
        cv=none;
        b=OKy4sgheNwKlxNve2m6H5HROKa+v2fBtaRDEx1x2viH7ZcdTBGmS4Tn0ZxZQW5lBPrDAHf
        55x8WtTNNAT8cHXTKLVYPztaoz+OM+UscjDuFdBMf6pxKdVGo2HAGxSJxUbSAfrJN8KlIr
        NDVgOLfnr/BAP8ByQGjRFMHdEE1G4Gc7pbF/trtKj1wd4GKzGQ3TfyrOcBRCjdu4+NI83v
        FL1T2aKvfuUWWhI4KAwNrhZPUhVonjJFfPLFQSCav0Lrsq0d2aiE4ryl+uL4cUZ/yKWARm
        9lMYphu0YJ8kpgEes1yG0V67gbceMhBsAHNNbqElDPuYNFbOMKffTjAiK553IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677782272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=KbIa0sIStAMO0mMB6RiYRVtu/9/bZPgLeoihDTD5mi4=;
        b=9sjKMRafB9B4eEaYMWycd1R0zVh6xziYy4i+NY4af5A9KzSKKO2cfVLD4U7tGAQbz3xIgB
        cxJGoGTD6nthq/9CDmdOOzGKNj9lDUoyMSQJcNnJ+F6F1AgjpzlAAvdbB/fH5fA9gfHXtr
        lq1svAquWr+3KqlxYIf2wcySDVBYwbANDT2Z2PQ65kojGNuYNs2VmmBUMIQVJyEPDZj7Fz
        BswyMuR3rIcOMqrspQN/H7JT4Bymm9C2+VD8+9CojexCqwESdPPZmLwtOA5zWW4/AELm7K
        sYSfupO8mqJGlNI1dfrUmeGlMBybAqvakjeHkJe4lSHfkDQN1jPzGnpRpBIIsA==
ARC-Authentication-Results: i=1;
        rspamd-69778c65cd-pq5gk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=hussein@unixcat.org
X-Sender-Id: dreamhost|x-authsender|hussein@unixcat.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|hussein@unixcat.org
X-MailChannels-Auth-Id: dreamhost
X-Abortive-Ruddy: 3435e4f700994e25_1677782272310_2097792675
X-MC-Loop-Signature: 1677782272310:2704307466
X-MC-Ingress-Time: 1677782272310
Received: from pdx1-sub0-mail-a274.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.110.64.199 (trex/6.7.2);
        Thu, 02 Mar 2023 18:37:52 +0000
Received: from localhost (unknown [175.144.191.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hussein@unixcat.org)
        by pdx1-sub0-mail-a274.dreamhost.com (Postfix) with ESMTPSA id 4PSKbR6pG8z186;
        Thu,  2 Mar 2023 10:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unixcat.org;
        s=dreamhost; t=1677782260;
        bh=KbIa0sIStAMO0mMB6RiYRVtu/9/bZPgLeoihDTD5mi4=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=jSnnFZrojsRpN1LhK3lJnGHbvrV6IY1p+fuRiPXuDXZX3Z04j0Tbo+B6OAvNmbQol
         YfjYA9WuOipfphFkKhjFqdrJgyH4BskoxRRL3xOxvQQqlaa2m+uRTP+PAgwPCBa18P
         jgEfj9ie64/dZsu8Ho8WUtHnhU5o29B6TwOVXwpo=
From:   Nur Hussein <hussein@unixcat.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nur Hussein <hussein@unixcat.org>
Subject: [PATCH RESEND] scsi: Add error checking to sysfs_update_group in drivers/scsi/scsi_transport_spi.c
Date:   Fri,  3 Mar 2023 02:37:35 +0800
Message-Id: <20230302183735.1281237-1-hussein@unixcat.org>
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

