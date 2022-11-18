Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369F462FC9C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242795AbiKRSYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242737AbiKRSXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:23:23 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D8A920B3;
        Fri, 18 Nov 2022 10:23:21 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id h21so3673991qtu.2;
        Fri, 18 Nov 2022 10:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njRDyo+4UkliIu7d/BjrERx6O7icrAQYdHMHglQ4OMk=;
        b=AKL0gy8tEfqOd0XHiB1jqjwiKwInZr58vFYrct0KPfTk55XqIMmhE0192ML2eq/1qx
         BEEmWi4LgNtnePSjs0njyh7au6SLzxetcup7f5Q9DYg+Uzzig3gqSIpBx316ga5CD7v4
         UiqdcOiNz7kL1oDJeKxCElS6NOQLc6a8RIrN/WVT4UrAp/KPc4v3I4v0Qz76H6QLjcxi
         xgHkmPXD4e12CcWKrkOFlstrovYB9kAmKDf82KrrGW3+MuGzyivrM8eVZvAKciqAeoLv
         woy/3GTvfwayKZaRDIBTQ4OVSOQxukhwvYYLaLNR23mg3IKUbZ+DzPr186NCYqKXIArH
         I3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njRDyo+4UkliIu7d/BjrERx6O7icrAQYdHMHglQ4OMk=;
        b=jsKbHNAbjM8T9T9RSWesVrC1aPTbyTDoSwARRmFt0A6gI6YxOtQuYCXt698vhH44c4
         KLXVfD4diOBpFmlO1rZMTTGrDr00YP/5K+XGFWh439i9YOWdeWR/J1F5x4jYSNXFLa3d
         IdUW7+PW88P9Qdw1WaLrWbCJxtu258WEWFIZQOp6gLgMzpSiBB55Yla6D6gbRGIlLbxo
         yOl2xKjQvoVCKpLarEpHhxQUU398dfWhlkfFId5OuM6YLwWKQldhCfzMUhm6hhVjBCgl
         1PRWlFhGLgzwTRCMBSNPRHUjwNH/4XdR2NEOR5ABVCDIkQf/JFCGoTlyr8Q2PXSGFwUF
         Ec9g==
X-Gm-Message-State: ANoB5pkp+nBVuEAqFGrQYBFaeOB45f/XWVeFVGdV1naKbBwx/Udd/4Ks
        poFZXgT6P0LEeTQI2bOPats=
X-Google-Smtp-Source: AA0mqf4QyYNh4w0jrkSVrHdtsz95nx3YSxTrSyHlRxhuUonOzBQq5wyXBdrwC6xpWpjrYnPrG/b5VA==
X-Received: by 2002:ac8:4501:0:b0:3a5:cb81:aff5 with SMTP id q1-20020ac84501000000b003a5cb81aff5mr7712731qtn.662.1668795800894;
        Fri, 18 Nov 2022 10:23:20 -0800 (PST)
Received: from shaak.xiphos.ca (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id q46-20020a05620a2a6e00b006fbcab95d70sm2349025qkp.101.2022.11.18.10.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 10:23:20 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     Liam Beguin <liambeguin@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] math64: add kernel-doc for DIV64_U64_ROUND_UP
Date:   Fri, 18 Nov 2022 13:23:08 -0500
Message-Id: <20221118182309.3824530-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.37.1.223.g6a475b71f8c4
In-Reply-To: <20221118182309.3824530-1-liambeguin@gmail.com>
References: <20221118182309.3824530-1-liambeguin@gmail.com>
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
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
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

