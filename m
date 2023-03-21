Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF546C39B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCUTCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjCUTCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:02:01 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA5C56538;
        Tue, 21 Mar 2023 12:01:49 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B2EE55C0105;
        Tue, 21 Mar 2023 15:01:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 21 Mar 2023 15:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1679425305; x=
        1679511705; bh=XDrvGUk9PJdg/6+5k40AIJKhr8ZrxDCGiHZcWcPJnLY=; b=E
        fgI+vkMEB/ivbm0D4fudXuJf7CN0WGeZlbpfPICNNQQv6ugakPD8AAbfHZS3z36z
        +YhRjYwCfaZaiTKLkjaqEK4sukYKnhNqcjalyWPkpcDTH3pvwrBrcRF3CoQvIrA+
        uXmTkPVF4g2S0U6uZ+7S81rY3B89/utMjIYc+qQOoYLtbPpYPwE8ZyVh5jj7wPjk
        t/28pgazhF8O/0ZUj4L+ZdgPUM9r9Tu5uOSYiXtkblvdFQmzRNaZ+SYP88Q4zbDW
        dMt5ozbZDZdTeiZ9Yd0rVV/WwxBssRMvZrlmoPJqAnaiEB5UsTtpAZnYEsQvo3Mk
        dRvdX3MkA9SjrocwYNYjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1679425305; x=
        1679511705; bh=XDrvGUk9PJdg/6+5k40AIJKhr8ZrxDCGiHZcWcPJnLY=; b=k
        PhGCpTXf0GQHmqRGaVccYzLnqWhqTPQ5Qe9eK5U+k4qPJnDq/S/SHl9siupuyyCL
        ydGkIGQA8r1nFhAemWGLjNlT5+YeqqrsevjM4RDGhJUANilzsqCRDFh86hSO8iHH
        ipW25a1cG9aNXHeJoCBtmm763owsxMDUHatW8/hpJmAwc0gl0+rbrwe0KNhBMoxB
        4IGlRrGANV21qjm1a4kKA3X2qthvUrUOtxJKK0N7wkDBq2dPzLvU4VYinqrf+oy8
        2GybUcMOedyzMRUl3nWVkaoDiR1Y+kNizrMn29hQ0kSY9iK42HKsHkXrYsvLeMPR
        BW+Mh8Gg12wOkHfDsxTMw==
X-ME-Sender: <xms:GP8ZZLkutVFfr52RRMAxlvcxdwE2VUxUt-DjOVsOFfRFyw5nKFzhLA>
    <xme:GP8ZZO02oVp0iUkTk-M4mxxvRjXmGBEBEeQEYWZXumd3wvh0vFHsnXxSJxOCIK5gm
    _Cdtc0iFgRPA9J7TJ0>
X-ME-Received: <xmr:GP8ZZBqp2Y0Ww8JsoHKGDiXWyOQ00qsTyOSrk2SmhGWXc-_Tn456YF9rRtshuLazVFBAM5btrNagTRoIcxNTrYkCjjVksGNsOxH4x_DAXMmA02lkOB65kHfkQ7j13i6BoDTd0ZkamA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:Gf8ZZDnIdagMQdq3gtGD179ESghqSCMzbOdZ3tAJpJ2vxMittC0FLg>
    <xmx:Gf8ZZJ062cqjGlqfs-D-_BJFn6magWMT8077ESIM8VbqjHQGjDivQA>
    <xmx:Gf8ZZCufyTjKRUKhg0gXF0iJbiiLwd-_TDYL9y6i0x7p7ZjKvxiUAA>
    <xmx:Gf8ZZCyfuCcD5oqwn3tbvHMrzVJTYY0dP1xcyhUs5-LBtDAxiVFzCA>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 15:01:44 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: acpi: Remove notifier before destroying handler
Date:   Tue, 21 Mar 2023 15:01:36 -0400
Message-Id: <20230321190136.449485-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Was debugging another issue (since fixed) and noticed that the acpi
notify_handler should be removed before the ucsi object is destroyed.

This isn't fixing any issues that I'm aware of - but I assume could
potentially lead to a race condition if you were really unlucky?

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index ce0c8ef80c04..be3bf4f996d3 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -176,12 +176,12 @@ static int ucsi_acpi_remove(struct platform_device *pdev)
 {
 	struct ucsi_acpi *ua = platform_get_drvdata(pdev);
 
-	ucsi_unregister(ua->ucsi);
-	ucsi_destroy(ua->ucsi);
-
 	acpi_remove_notify_handler(ACPI_HANDLE(&pdev->dev), ACPI_DEVICE_NOTIFY,
 				   ucsi_acpi_notify);
 
+	ucsi_unregister(ua->ucsi);
+	ucsi_destroy(ua->ucsi);
+
 	return 0;
 }
 
-- 
2.39.2

