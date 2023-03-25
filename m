Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9896C8FCB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 18:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjCYReN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 13:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjCYReC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 13:34:02 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8C5CDD3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:33:56 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a5so4504291qto.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679765634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pJMvzOBsStXaQ6aO+axzLwb5fLtB6xIoptrhTt/3BE=;
        b=IxRuOK/3xmJUvXbXJ+choX2xTmTN4VVfVyCdzi/uNkGLrkiSmsMx1/es3KQnxSLa2b
         FFPro4IjUEp+MSb0y2pUPRuxATx0VW/NHDwRuznZzbc6wKWtoQSWQhWT6UTVsuAk3oGR
         iyCq/R5I9bjmk+Ksz+nizZH4ipHt55i4sSEEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679765634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pJMvzOBsStXaQ6aO+axzLwb5fLtB6xIoptrhTt/3BE=;
        b=aM7C66fmZGiVQDS3GI2bqh05JHv9pkS4kYvzCXeYflmwlI2aDWG8PaRkrN763GmOKW
         2x/Q7MI8GzijFL/t0uXjwFLOho8/+996w2aiAFVeCC9vYQi7UBqaUS51KMVch6iJJxmb
         BhO5sYBZxH6KpL8TsWv/HJw9tXHMPb8tNGBOQ67qoHCW6E9Zkj6PySKZSbAwY7RPr/K3
         DzUJJgpBRlqEeFwr/RIcgRgHLUcb0lW5xw/U1VNEsDmq4RLTw98lOB2F3PpG+7nTpCDq
         nMFcbU4ZPuOKwlMW90UVouQRMciyMIYBROY0L5rI0MMbMkZek4ZoyYM6oluJMBr1Hv3u
         eG1Q==
X-Gm-Message-State: AO0yUKVyf7dGXtCRbxn3fbYxgZS7RIFdSeHFRTUkuLNuYLz/ZtAYelFV
        Sa8IIFMuaHjTkYi/CbRTTQ4M2U+1Khhu9o/k6Q8=
X-Google-Smtp-Source: AK7set/pbBwu3aEkkCDle9qB2GrPx2h6E5zBaeYDa94xLyQTcdw7fyf5C9hAHfxXBRoG9XNC9jRX/g==
X-Received: by 2002:ac8:5896:0:b0:3b8:6d3a:5ec7 with SMTP id t22-20020ac85896000000b003b86d3a5ec7mr12812600qta.22.1679765634735;
        Sat, 25 Mar 2023 10:33:54 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id m4-20020ac84444000000b003e37ee54b5dsm6762764qtn.90.2023.03.25.10.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 10:33:54 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Zqiang <qiang1.zhang@intel.com>
Subject: [PATCH v2 03/13] MAINTAINERS: Add Zqiang as a RCU reviewer
Date:   Sat, 25 Mar 2023 17:33:06 +0000
Message-Id: <20230325173316.3118674-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230325173316.3118674-1-joel@joelfernandes.org>
References: <20230325173316.3118674-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have spent about two years studying and contributing to RCU,
and sharing RCU-related knowledge within my team, if possible,
please consider me as R ;-).

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9fb1c172ffe..e03067b857a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17643,6 +17643,7 @@ M:	Boqun Feng <boqun.feng@gmail.com>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 R:	Lai Jiangshan <jiangshanlai@gmail.com>
+R:	Zqiang <qiang1.zhang@intel.com>
 L:	rcu@vger.kernel.org
 S:	Supported
 W:	http://www.rdrop.com/users/paulmck/RCU/
-- 
2.40.0.348.gf938b09366-goog

