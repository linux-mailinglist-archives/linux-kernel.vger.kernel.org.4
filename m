Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0125E60079F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiJQHXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiJQHXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:23:35 -0400
X-Greylist: delayed 1259 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Oct 2022 00:23:30 PDT
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2570A59734;
        Mon, 17 Oct 2022 00:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1665990123; bh=v1WmIdGEdjb/NRA9IbpdRDnvrh6PU598P+2FFcf0eoI=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=GXEOablkpD9tab0iyR+Nqti3uRljRoWtutJWpTPoK5n3UP8pzswBj/GHpOns/gmy9
         y7rJFEl2rGNl0q7iOKJbZJyVzy/XuVyX+23ajS0sOzqVDtUFzX4QbFCEqG1bENXcWn
         KrsQvARRQrnFoXikbJl3nlSqaEroCpePbIzaVibY=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via [213.182.55.206]
        Mon, 17 Oct 2022 09:02:03 +0200 (CEST)
X-EA-Auth: PgaBZF2EQagjeQgatbitFuEP2vpDjYeqY00rZfLXzUDuULgmxrv3GX32xIOsdaW/FUVjM2UB0rTenzLna3v6qSx8wD8sNT2m
Date:   Mon, 17 Oct 2022 12:02:30 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: [PATCH] staging: iio: frequency: ad9834: merge unnecessary split
 lines
Message-ID: <Y0z2/qFe3kW96MTs@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve code readability by merging unnecessary split lines that are
well within the code-style guidelines post merge.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/iio/frequency/ad9834.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 2b4267a87e65..285df0e489a6 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -331,11 +331,9 @@ static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9834_write, AD9834_REG_PHASE1);
 static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL, ad9834_write, AD9834_PSEL);
 static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/

-static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
-	ad9834_write, AD9834_PIN_SW);
+static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL, ad9834_write, AD9834_PIN_SW);
 static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL, ad9834_write, AD9834_RESET);
-static IIO_DEV_ATTR_OUTY_ENABLE(0, 1, 0200, NULL,
-	ad9834_write, AD9834_OPBITEN);
+static IIO_DEV_ATTR_OUTY_ENABLE(0, 1, 0200, NULL, ad9834_write, AD9834_OPBITEN);
 static IIO_DEV_ATTR_OUT_WAVETYPE(0, 0, ad9834_store_wavetype, 0);
 static IIO_DEV_ATTR_OUT_WAVETYPE(0, 1, ad9834_store_wavetype, 1);

--
2.30.2



