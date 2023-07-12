Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AAA750405
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjGLKAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjGLKAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:00:30 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407BF1720
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:00:28 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1Csk1P3pzBR7bF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 18:00:26 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689156026; x=1691748027; bh=2fGWJboIBRcv+wNPB12+yip1okA
        5PpFcw45UJ5WXOdY=; b=NIpc3MjekY+wPNbPpk81KdEjbPuPtQ+3R84E586L5Hk
        Z0qUYF6Avfx6CzNJwQYD9yNaL6V9iiDsYG8WG3obmsWAbFJh/NG7FqT+PgioLFWO
        KqvkkjXTwJF2ckRfW0MXVHj8c3ASIxjxsS0438g2q5uf/bJIWjZk4rSje5Do8L7t
        w9uYC6Y6Ek5ExmqJY6MsZQRXwdLpop4nOVhcX43lyLd98gWsuMk5SXYCemLmOEBi
        uuHNCJoiUuqvfAZQgorhv+4GqlaYY3mIErFYW/ui3FiBlpvt5YsVagHn2fBUMijW
        x/masUeZFzoaPdnvp4e9U/6F/p5VWMJ0GQRqmL8KJLA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id imNaZRUxQw3b for <linux-kernel@vger.kernel.org>;
        Wed, 12 Jul 2023 18:00:26 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1Csj68YqzBR5lR;
        Wed, 12 Jul 2023 18:00:25 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 12 Jul 2023 18:00:25 +0800
From:   pangzizhen001@208suo.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] iio/adc: Fix comment typo
In-Reply-To: <20230712095719.32259-1-wangjianli@cdjrlc.com>
References: <20230712095719.32259-1-wangjianli@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <943cc02207bbcc042fed163915a88ef4@208suo.com>
X-Sender: pangzizhen001@208suo.com
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

Delete duplicate word "the"

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
  drivers/iio/adc/palmas_gpadc.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c 
b/drivers/iio/adc/palmas_gpadc.c
index 27b2632c1037..76e0a4d8af3b 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -458,7 +458,7 @@ static int palmas_gpadc_get_calibrated_code(struct 
palmas_gpadc *adc,
   *
   * The gain error include both gain error, as specified in the 
datasheet, and
   * the gain error drift. These paramenters vary depending on device and 
whether
- * the the channel is calibrated (trimmed) or not.
+ * the channel is calibrated (trimmed) or not.
   */
  static int palmas_gpadc_threshold_with_tolerance(int val, const int 
INL,
                           const int gain_error,
