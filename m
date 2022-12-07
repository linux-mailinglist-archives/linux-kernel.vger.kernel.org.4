Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69186456DC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiLGJwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLGJwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:52:06 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8CD2E691;
        Wed,  7 Dec 2022 01:52:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h7so21267196wrs.6;
        Wed, 07 Dec 2022 01:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dkCv+0Lxdb8Uhc/wcFvh4AwlpWfEWCJ/tFl+smmHeWg=;
        b=O8CisVTSl8Be01rBLgb6kGohraYbiTYI102ydoHrosu6x3ZQRQxK7Ew2mveUEjiNGF
         NeGl2VNaA1YirFFGIc6+RlVlHo/4+rPjUOn2eUwGLKgK37ao9ECuuFnK8aZM4PqEZ3dt
         Itwb2hQYdizvOF7Tu/lh4gS70Vob1GZ1QAFEAuIJp/XsPgr+wQuJP2ysLWd6GFhg7H4+
         5w/uHkhmvwmNSUaFQ9djYxLNFWuDbifg9KZ5i2HylTJ3si0dQFPhPCItIYbHuXMX6a3C
         1O/tPv5Uel/28y8fos7E5k07FUSechYXfuUFpZxHXtGPPkH7iFy08YYP1DrCtdp6vGIv
         MaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkCv+0Lxdb8Uhc/wcFvh4AwlpWfEWCJ/tFl+smmHeWg=;
        b=jKe478loR7iw1a82CewY3JUbl8rLip3PLLdNEhJlOu2JWp1glRJtxY2FDyZ/8ebZp2
         js0imrFY0n+v+jaafXngkHelK16xHQa1EzIheg15vg0JYvcxNjTpNEOfBXqli/Co3mhY
         DkSyc/UrommBs6F0vRTyGz82pmmME6151ikAzybZzwOhBRvmI36Zbl1zO/y6Ys9KyYx1
         1U7ktuonk73GGBSuzcqx46KLVIWA0yaQaDNLAyzdXnqbh0wIGy6TYqSHHr4GcWFFTH9P
         8XtpK/rkcOZ3l4g9KDjs3xpnz3nYTBvwqfuFYY8G1zXyCY0PZg7r2WO7Z0cP6AL9xXPq
         e/DA==
X-Gm-Message-State: ANoB5pnmMD0KFgnP8u0rP/MBncya6S22vXBVct9IE4o7G6LxpgkJq8sT
        QVaBbR99wJrFBr4zOho9pt4=
X-Google-Smtp-Source: AA0mqf7UA4lPZCgcEajZZw4gOk96rpxb9AiJkDfWVMAFyvd7J7+ApO1QEz6J/ElX43S+6cIdpuovcg==
X-Received: by 2002:adf:decf:0:b0:242:82ba:cda1 with SMTP id i15-20020adfdecf000000b0024282bacda1mr949559wrn.532.1670406723753;
        Wed, 07 Dec 2022 01:52:03 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y7-20020adfe6c7000000b002423edd7e50sm15185710wrm.32.2022.12.07.01.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 01:52:03 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mushahid Hussain <mushi.shar@gmail.com>,
        speakup@linux-speakup.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] accessibility: speakup: Fix spelling mistake "thw" -> "the"
Date:   Wed,  7 Dec 2022 09:52:02 +0000
Message-Id: <20221207095202.2282567-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in the module parameter description
for say_word_ctl and an extra space. Fix the spelling mistake and
remove the extraneous space.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/accessibility/speakup/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
index 4733fd6334ab..56c073103cbb 100644
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -2490,7 +2490,7 @@ MODULE_PARM_DESC(punc_level, "Controls the level of punctuation spoken as the sc
 MODULE_PARM_DESC(reading_punc, "It controls the level of punctuation when reviewing the screen with speakup's screen review commands.");
 MODULE_PARM_DESC(cursor_time, "This controls cursor delay when using arrow keys.");
 MODULE_PARM_DESC(say_control, "This controls if speakup speaks shift, alt and control when those keys are pressed or not.");
-MODULE_PARM_DESC(say_word_ctl, "Sets thw say_word_ctl  on load.");
+MODULE_PARM_DESC(say_word_ctl, "Sets the say_word_ctl on load.");
 MODULE_PARM_DESC(no_interrupt, "Controls if typing interrupts output from speakup.");
 MODULE_PARM_DESC(key_echo, "Controls if speakup speaks keys when they are typed. One = on zero = off or don't echo keys.");
 MODULE_PARM_DESC(cur_phonetic, "Controls if speakup speaks letters phonetically during navigation. One = on zero = off or don't speak phonetically.");
-- 
2.38.1

