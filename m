Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2AB6029B7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJRKzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJRKzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:55:11 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD6C48C8D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:55:03 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id r22so17355275ljn.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcrTC51miLJfxjyuOmcj7nFOefmSQq5Qp2IKennwdVc=;
        b=hud7zyP1/Xt6WIxZpgWGLH8B2vzPBYq9IsvYwFETmD5ReM91rGx5nlWmdto+bPN42A
         hcHRIMWI2qAKLBduQvQnRK285PQ2sqJiivs5/Ol/1ybNno/N455/aCG6W5v7T1pFrhdT
         u838tXCy4D2wWxgbcxDQ5XcYO+MhdKYUXsl4wdx8Ha+tqcrYcoJVUNG9+EwbuuHquQvd
         w3uBrX+fdw1pf8g1Cgsqf/hpXiqyQs3STBvIyojLIfVDFFH2hzJ2GC1JCuG9YX+HmWGl
         /4DlqJqjVyBd7LC2pB4OpeUXoOEJi6k+whbT/EAOrq5/LszoDBS6n9uAJiQmAUCqrSw6
         jn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AcrTC51miLJfxjyuOmcj7nFOefmSQq5Qp2IKennwdVc=;
        b=jyTBXUPGxQF3b9q6i8ehuDIqBQatIDWLV07ZRl71vVy+DlJXpGeNVRZ1i7/Xnf2amV
         ztooGz5QEw3ut0yRSIixi9oLWTu5ZUBb2r5kO6FEcJUX0JOjn6zRjbu5MnCXHlE63dmV
         2davVAmn5irwVXEfqVeTXNWMqbMMq8wNGZkMWat3W3JQejlQ+3Q3wkShDNDlZAs8udfi
         b+n500ksVsmmIDTZji1WdrU1QwVtnITjxF2aBsfNyni8u9DuY5PTAhH0XBsqLQMRw2uR
         j3KEiD4M6KWg8qynZcKfREdrfP7zYKHW9CE7EoLGIyHoTkBEgoRQs0dqk93YTKRzIpj5
         4zAA==
X-Gm-Message-State: ACrzQf2V4mvogmlCSJMFdqP1bX8iUbEhw8nAruyT8nzSXNMUjqTotXdP
        pkzTDKzk9uZpTFgVoi08rhTX35a50o8rfC2C
X-Google-Smtp-Source: AMsMyM7SbCSao4X651caaK6HVsg/TPp8v2MEtAULswXBUUBWoobtZE87tsE6m98bWIID4X2BzhrNhQ==
X-Received: by 2002:a05:651c:1107:b0:26f:dfab:92d5 with SMTP id e7-20020a05651c110700b0026fdfab92d5mr799304ljo.461.1666090502086;
        Tue, 18 Oct 2022 03:55:02 -0700 (PDT)
Received: from elroy-temp-vm ([20.240.130.248])
        by smtp.gmail.com with ESMTPSA id d20-20020a194f14000000b00498ee99a749sm1794270lfb.304.2022.10.18.03.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 03:55:01 -0700 (PDT)
Date:   Tue, 18 Oct 2022 10:55:01 +0000
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: [PATCH] staging: rts5208: split long line of code
Message-ID: <Y06GBWZe+zF+ddD3@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning by splitting up a long line of code, improving
code readability

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/rts5208/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
index 4643127a87ca..6503db5bb874 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -4505,7 +4505,8 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 				if (CHK_SD(sd_card)) {
 					retval = reset_sd(chip);
 					if (retval != STATUS_SUCCESS) {
-						sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
+						sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON |
+								SD_SDR_RST);
 						goto sd_execute_write_cmd_failed;
 					}
 				}
-- 
2.34.1

