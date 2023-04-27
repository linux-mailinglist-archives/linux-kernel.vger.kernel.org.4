Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E26C6F0DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 23:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344076AbjD0VQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 17:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjD0VQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 17:16:20 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0099C2D4A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 14:16:18 -0700 (PDT)
Received: from darkstar.musicnaut.iki.fi (85-76-14-243-nat.elisa-mobile.fi [85.76.14.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4Q6pSS28BLzyXq;
        Fri, 28 Apr 2023 00:16:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1682630174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=I/n3uS94co8BNPTwp6zmfk8PIZTBgMaZTOtf11T/5us=;
        b=PpR61pCBkbTem5N/A1chGIBVAuoMOs0QZSwh2QzF6L6wXtKhWrrpwqv9UHIA2rXPLRxuT2
        aPkCptI6M0btcVOf2lnQRvmTvYbVtY8ALCA4Dt17N2VH2CMkSnPdp6cxlrj2uckmlECDGB
        6tvxr3fgCbjwVElWvDp7RFAQaP78Uuc=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1682630174; a=rsa-sha256; cv=none;
        b=yUHcnHt/o5aWrRRxoMkHkqBgSNPW8PAIaKUZzGy0l3itqunIElD5JNqsn3ie/XjLNDrqgQ
        pW0ygg9qQODhH6sokXHtBFgoFLKhy3cX0tnuP+AeGHQy+DvQ0rlVmNhBssYawUCQHEd3Pc
        tgSftJ6/WvgKTF3djXj6keK7DMFZ29M=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1682630174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=I/n3uS94co8BNPTwp6zmfk8PIZTBgMaZTOtf11T/5us=;
        b=M0blky4OjUv13t8VaotolpeotVWDa+pNTY+mTI21wiWuSGdQ162DbwWEdTMu3hASuOZzJr
        aHJ/eL8Vyb8G9GrZpdtLx/kcZRJGxxNJIRuZfY/yFCz0ljqzDIYgAsAaoCEMuDFvkWZyeV
        2j4c+S1hfYKc5ctLC+t3ZTI3c51aUv0=
Date:   Fri, 28 Apr 2023 00:16:06 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: octeon: delete my name from TODO contact
Message-ID: <20230427211606.GD881984@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I gave up using MIPS OCTEON hardware after the drivers were deleted from
staging in 2019. Afterwards, the driver seems to be added back but the TODO
contact name was not updated accordingly. Delete my name, as I still get
mails from people asking help with the driver and their systems.

Fixes: 422d97b8b05e ("Revert "staging: octeon: delete driver"")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/staging/octeon/TODO | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/octeon/TODO b/drivers/staging/octeon/TODO
index 67a0a1f6b922..044e48e3d65f 100644
--- a/drivers/staging/octeon/TODO
+++ b/drivers/staging/octeon/TODO
@@ -6,4 +6,3 @@ TODO:
 	- make driver self-contained instead of being split between staging and
 	  arch/mips/cavium-octeon.
 
-Contact: Aaro Koskinen <aaro.koskinen@iki.fi>
-- 
2.39.2

