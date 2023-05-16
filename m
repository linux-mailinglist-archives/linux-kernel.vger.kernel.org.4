Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DD2704598
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 08:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjEPGxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 02:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjEPGxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 02:53:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E992526A
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 23:52:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso2540183566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 23:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1684219968; x=1686811968;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XysAE3wBPBRnm+kDZyhpJGmXjkkmPukHucI6hmadXi8=;
        b=Ak4POiE5wpWvOE4HBZZ/QK+uzljVcOSZ0PZFLxSJSX6U9zO0wEn9O1JfK5eScqffy/
         iJddJE6wnJM4s5qWoYWMmvGd0iy9lGRhHRibg88pAR1pYvxanmIVf9LyOhMQkbr/+R/2
         HAx7KY2Oxe9kNv2dT8r7euRP0SIKWypXbWXGQaTWnLNvEatbS+CK56HYMyudLLt1bD2o
         XKilbGHsSLEypsk4ozmWNJh570FRBH8pY+2ZNeRJ7CIzeWe8wvU2bau4pvJomNQzvZ26
         aN996RyxSYkI0gwTqRKKyW7TmIwuBAxnE54t37rqK7uQ4GiHdqrzZDiUOLah2tVAyhvY
         J7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684219968; x=1686811968;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XysAE3wBPBRnm+kDZyhpJGmXjkkmPukHucI6hmadXi8=;
        b=EsXOClTJI7d709B0PswU7ywxumDdmzNUfQo4bgI9pRzY0P6HvmccKt3rKkKsBQVcMN
         6Aai3G+iKY4LyE2J7Ea+S9t8FWfOhjnAaw8fIr0A51+02tLhYlGUiVDNitn41Gw/hClR
         7KC3gOdOW0CJXcHtvJS0hzxfHR5qDSsjlKAuRIwpJRQPXn9h+tBszjur/6GNcfBDyhHy
         nYZTnM9iz3Ad9GfY0RKMeKkvNHSpPSZuimAfsTkh16dK90SKz76QHMpKuXVIC6wIyXl6
         WF1Al5kAqJTSRmzkBf1CaS19Ja/v6iQdLtdG7NbO3qQcj7dgUJR2PpItbbmrMIjwz6SS
         Qm7g==
X-Gm-Message-State: AC+VfDzpflNg61pi8WYdU9CyV/9Guesq4G0OIglGH5VtohUabyhjPnBe
        CZawO9FKsCe6mgBUgxPeS8q8Qw==
X-Google-Smtp-Source: ACHHUZ6RU/odBg3xoOW5scszLU3AOGmHa9Dax0R2pmUq/aaCvjZkpY+xHcGVojB1+0eRJbIeGiTv0g==
X-Received: by 2002:a17:907:da4:b0:966:4d99:b0aa with SMTP id go36-20020a1709070da400b009664d99b0aamr28303285ejc.59.1684219968320;
        Mon, 15 May 2023 23:52:48 -0700 (PDT)
Received: from [192.168.183.139] ([41.66.96.127])
        by smtp.gmail.com with ESMTPSA id k21-20020a170906971500b00965ffb8407asm10407706ejx.87.2023.05.15.23.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:52:47 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Tue, 16 May 2023 08:52:43 +0200
Subject: [PATCH] docs: printk-formats: Clarify %*pb format parameters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230516-printk-bitmap-v1-1-d5f810192a10@fairphone.com>
X-B4-Tracking: v=1; b=H4sIADsoY2QC/x2NQQqDMBAAvyJ77oqaarBfKT1s4kaX0hg2UlrEv
 zf2OAzD7JBZhTPcqh2U35JljQXaSwV+oTgzylQYuqYzTd8OmFTi9kQn24sSOh/CZK2xI3kojaP
 M6JSiX84qpCsOtam/p0vKQT7/1/1xHD8JiERAewAAAA==
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since it's rather unusual for printk formats to require two parameters,
expand the documentation to clearly mention that in the printk format
for bitmaps.

As an extra example, for example from include/net/bluetooth/hci_core.h
we have a bitmap DECLARE_BITMAP(dev_flags, __HCI_NUM_FLAGS);
This can be printed with ("%*pb", __HCI_NUM_FLAGS, hdev->dev_flags)

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
This probably also applies to other printk formats but since this is the
only one so far I've used that requires two parameters I cannot really
help with the others.

Someone with more knowledge on the other more unusual format strings
could apply this to others also.
---
 Documentation/core-api/printk-formats.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index dfe7e75a71de..3cafb988d757 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -571,7 +571,9 @@ For printing bitmap and its derivatives such as cpumask and nodemask,
 %*pb outputs the bitmap with field width as the number of bits and %*pbl
 output the bitmap as range list with field width as the number of bits.
 
-The field width is passed by value, the bitmap is passed by reference.
+This requires two parameters, the field width (number of bits in the bitmap)
+passed by value and the bitmap passed by reference.
+
 Helper macros cpumask_pr_args() and nodemask_pr_args() are available to ease
 printing cpumask and nodemask.
 

---
base-commit: 16a8829130ca22666ac6236178a6233208d425c3
change-id: 20230516-printk-bitmap-bcffd77379ac

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

