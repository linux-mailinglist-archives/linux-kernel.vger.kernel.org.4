Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9D674CC28
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjGJFX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjGJFXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:23:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57307CE
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 22:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=6zTnxeT0qLlfEPSwWehXQgoqAxoItUECelPypoCLsTw=; b=YXasUrY1C443PojEPK6NfyPUU7
        L4PQF2KK+NzR08R1ucePP64Dpn1pnUaf9mSHeUGmHnQWGewSpNfthn4H2ANnj0Ul+TIdlITPOWN4p
        fMHW8oLZUc2Li1u2JKFqJgSU+P+SssUEzTkHzClqPs1ffUh1pQrRZCR+s7oel5LwzYSD4TzEFhznI
        IgRtaTCXA5LNaWGpqne5ZRWrLoLnYGJGltRsKtGLlcNB1+YLacQCNOPiAZx9ujeZx54ys4UKnG2iF
        Vk0QpeVbwQFQV1iNIiAtnTVCBu2613aPHXXbjRfG2FsM5jNqPyhwv8bLNtoNZXnKOrD78g4NBta5F
        mNMspSYg==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIjMY-00ASzJ-1q;
        Mon, 10 Jul 2023 05:23:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Eddie James <eajames@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH] docs: ABI: fix spelling/grammar in SBEFIFO timeout interface
Date:   Sun,  9 Jul 2023 22:23:05 -0700
Message-ID: <20230710052305.29611-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems as identified by codespell.
Correct one grammar error.

Fixes: 9a93de620e0a ("docs: ABI: testing: Document the SBEFIFO timeout interface")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Eddie James <eajames@linux.ibm.com>
Cc: Joel Stanley <joel@jms.id.au>
---
 Documentation/ABI/testing/sysfs-bus-fsi-devices-sbefifo |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/Documentation/ABI/testing/sysfs-bus-fsi-devices-sbefifo b/Documentation/ABI/testing/sysfs-bus-fsi-devices-sbefifo
--- a/Documentation/ABI/testing/sysfs-bus-fsi-devices-sbefifo
+++ b/Documentation/ABI/testing/sysfs-bus-fsi-devices-sbefifo
@@ -5,6 +5,6 @@ Description:
 		Indicates whether or not this SBE device has experienced a
 		timeout; i.e. the SBE did not respond within the time allotted
 		by the driver. A value of 1 indicates that a timeout has
-		ocurred and no transfers have completed since the timeout. A
-		value of 0 indicates that no timeout has ocurred, or if one
-		has, more recent transfers have completed successful.
+		occurred and no transfers have completed since the timeout. A
+		value of 0 indicates that no timeout has occurred, or if one
+		has, more recent transfers have completed successfully.
