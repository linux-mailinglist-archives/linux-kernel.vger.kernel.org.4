Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCB66FF3B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbjEKOKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238382AbjEKOKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:10:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8C7E739;
        Thu, 11 May 2023 07:10:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4AC561FF00;
        Thu, 11 May 2023 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683814212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B8F01zoG6qFkp/pYPpjhsWI00zUgECS/Cfwhlo7ouPA=;
        b=x2Nxq1+L+Wp/OsUzrzpq9C7C+amTDIHErO+8C2KYch3yTpnPSf+CGTV7OyUNM/47b8XCYv
        9QetYQyZHxVMLtJo3D8DbhdvFvA/URIAe9Nn0CKJaoxNjFC7z2kauYH47365lLNaE37m5a
        aO8ldkedBCNEkiA9avrIoCd9GW2Wtok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683814212;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B8F01zoG6qFkp/pYPpjhsWI00zUgECS/Cfwhlo7ouPA=;
        b=NnAIm9hvdcwAp/TEkNo9P8DtTAXyrQuI9jXoCn59Iq3N4i6T9m6aMusxEzER+UJ1UHCZEh
        RMAv7T/m/7esagAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE528134B2;
        Thu, 11 May 2023 14:10:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gCx2MUP3XGR0PwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 11 May 2023 14:10:11 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v4 06/11] Documentation: Add info on nvme_trtype
Date:   Thu, 11 May 2023 16:09:48 +0200
Message-Id: <20230511140953.17609-7-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230511140953.17609-1-dwagner@suse.de>
References: <20230511140953.17609-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mention that the nvme tests can be parametrized.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 3550f377f487..33c2a512eb6b 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -98,6 +98,13 @@ requires that the kernel be compiled with `CONFIG_BLK_DEV_ZONED` enabled.
 RUN_ZONED_TESTS=1
 ```
 
+### NVMe test parameterizing
+
+The NVMe tests can be additionally parameterized via environment variables.
+
+- nvme_trtype: 'loop' (default), 'tcp', 'rdma' and 'fc'
+  Run the tests with the given transport.
+
 ### Running nvme-rdma nvmeof-mp srp tests
 
 Most of these tests will use the rdma_rxe (soft-RoCE) driver by default. The siw (soft-iWARP) driver is also supported.
-- 
2.40.0

