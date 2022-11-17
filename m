Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8435362D126
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 03:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238868AbiKQCfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 21:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbiKQCfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 21:35:32 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33702E9DB;
        Wed, 16 Nov 2022 18:35:30 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id k2so350909qkk.7;
        Wed, 16 Nov 2022 18:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqARHLyM93858hT/zUtYfVfE9lsDDkBej8c72F7kBKA=;
        b=bLxEWBRozQYASr45/ecjEYgRpvqNtmBKo9VXhMeNTTTuygjewjl8vqI/xwTmxNfMve
         uoFd9sqirHtC5RJT9EYfaCqm3vveeyb7jY4GqbpGwN11IDTF/7wsYo1NbOXrgvIflUSi
         92chBTGabPnUeEWaHd7y4EqBeMxQ7MrhqjMMyefsUSVDK6dZaUyNeopgKyrUgqGYQKsD
         zXldSaRxQi+ZXkWJ53LuhX9JhU2CXP/W5S6swYWKm4olf3f9YJgq7K8cxiNTWyfV0i/R
         h4wAdFmYaCgVJRWRwxGJj/Vk9XWXHZMvZts1pQiMNOt71hxLz0a+k04siHaSlahReVzX
         yg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqARHLyM93858hT/zUtYfVfE9lsDDkBej8c72F7kBKA=;
        b=l76DVN+ZrWFXVIM0hzbgkd53m9tG0KKORyKq4yFO7/BvZsM1binqLv1E9BmMqqi2P6
         fd3S/Kb4ofcAxBkM7XC9KWj9tURrGCJRJYb6g6IAfCb2CRr5Hbo6GsE9P7USfq99IcnF
         dRl9pZbjgbV+tWu649mnELQLotEs0wgOpPTKame3fEkdxDJQWLT6hBkdOSUeFKWcwK7t
         P5WkmuA/AGrjmNYduHUkfB0kCWySwgmWX540nSnAfza4Dqrbqu7e2G/u5DGYy+n4F6Yy
         9JE2BADpgTpNrqNdoqCVYDwMwi6jf0dyJ/ymcj2k7MVY/oUW3J1i0uH9Cj6SQHYewU35
         PDIQ==
X-Gm-Message-State: ANoB5pmjlwyHR4tnDaP5gz2e3kOZu0nVD8l+q0EB9b5DTM4mywU358On
        JaUXOGwgBD/z7OVN0gzBUwVxxVYG/hU=
X-Google-Smtp-Source: AA0mqf6b65zX+EhdO4LjSWm3IrlityaxVB6zjazx8QB8GhbWpL3iUMA7oPjic/nSnSewWpDQmdkhpQ==
X-Received: by 2002:ae9:ee01:0:b0:6ee:ca70:6451 with SMTP id i1-20020ae9ee01000000b006eeca706451mr146447qkg.545.1668652529530;
        Wed, 16 Nov 2022 18:35:29 -0800 (PST)
Received: from shaak.xiphos.ca (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id v5-20020a05620a0f0500b006eec09eed39sm11311888qkl.40.2022.11.16.18.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 18:35:28 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] math64: add kernel-doc for DIV64_U64_ROUND_UP
Date:   Wed, 16 Nov 2022 21:35:10 -0500
Message-Id: <20221117023510.2338176-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.37.1.223.g6a475b71f8c4
In-Reply-To: <20221117023510.2338176-1-liambeguin@gmail.com>
References: <20221117023510.2338176-1-liambeguin@gmail.com>
MIME-Version: 1.0
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

Add kernel-doc for DIV64_U64_ROUND_UP so that it appears in the
documentation.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 include/linux/math64.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index 1538844fcb51..cf3b0099674a 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -284,6 +284,16 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
 
 u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
 
+/**
+ * DIV64_U64_ROUND_UP - unsigned 64bit divide with 64bit divisor rounded up
+ * @ll: unsigned 64bit dividend
+ * @d: unsigned 64bit divisor
+ *
+ * Divide unsigned 64bit dividend by unsigned 64bit divisor
+ * and round up.
+ *
+ * Return: dividend / divisor rounded up
+ */
 #define DIV64_U64_ROUND_UP(ll, d)	\
 	({ u64 _tmp = (d); div64_u64((ll) + _tmp - 1, _tmp); })
 
-- 
2.37.1.223.g6a475b71f8c4

