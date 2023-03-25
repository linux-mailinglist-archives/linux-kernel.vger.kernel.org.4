Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7314B6C8FCA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 18:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjCYReK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 13:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjCYReC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 13:34:02 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A767ECA37
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:33:55 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x1so4499264qtr.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679765634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2i4ZWFQEEf+sgts9I9IXVKvOCwZuHZ3OWXbYKFFdbY=;
        b=NvEg5wJgvEddeXnTJ9ZD0PZGySimLuse3EAD4IauotUQqajZfmDDzEXep5uPbOxCSs
         pxmCfsVXlFtnaHZbBUJ/hyADQzDMxZjc4irxuLH12DmGuKCPb5BGSwcqHBRnvzAT8uft
         CZkNklkdQOpCvNOIzpL8pxANq+xxXe09HR5A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679765634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2i4ZWFQEEf+sgts9I9IXVKvOCwZuHZ3OWXbYKFFdbY=;
        b=Ypgwkq5FyhmbdjBcTL6e347CxHDgC/ylIHBAlM3yQz3jGXhONQp2f6H1+AUZatdAC5
         dkHvZyuC8CVIVWXoJRoUaG9bsVFDng2l+DGpE7cSF/fd9yPzzZBzv6o/5IfvtV4ajbas
         MJKp1MBC0C8VQcyRmDeMW7NLbzgnmJ38tVWtuXwSp20cTyBodim1pXTT8I/lBfSDRgpj
         MFPfvoDQbTpV6X/8TI0SvWwpRiSyYDK3xh4rBqIvfT4G+tF4i+EErZhRwakvlS7ilMx1
         nW31Vf4mjJvJ9DTG3eWDVOm4AV2JfYu2IHlo/pm9y6vty9ju9I0++Pyojtrwi7J2S5kl
         nqwA==
X-Gm-Message-State: AO0yUKUjNmT7KVf88F4Ay/48hOifchNqgSsUYv5YMBVCfT+nIP41v6ZV
        2ePpCceL6nL68QniNtOh3d/85JF5bkcFk7Ge6pM=
X-Google-Smtp-Source: AK7set97lqOAjDVThbElr8+YxFs2CK0mVkHKmSkCZdCfhhdf5qsvrHG530FnmOqFw4nsx4KTUtAwdg==
X-Received: by 2002:ac8:4e56:0:b0:3bf:b6cf:25c5 with SMTP id e22-20020ac84e56000000b003bfb6cf25c5mr12738707qtw.14.1679765633762;
        Sat, 25 Mar 2023 10:33:53 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id m4-20020ac84444000000b003e37ee54b5dsm6762764qtn.90.2023.03.25.10.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 10:33:53 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v2 02/13] MAINTAINERS: Add Boqun to RCU entry
Date:   Sat, 25 Mar 2023 17:33:05 +0000
Message-Id: <20230325173316.3118674-3-joel@joelfernandes.org>
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

From: Boqun Feng <boqun.feng@gmail.com>

Just to be clear, the "M:" tag before my name is short of "Minions" ;-)

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 698c330d37cf..e9fb1c172ffe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17639,6 +17639,7 @@ M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
 M:	Neeraj Upadhyay <quic_neeraju@quicinc.com> (kernel/rcu/tasks.h)
 M:	Joel Fernandes <joel@joelfernandes.org>
 M:	Josh Triplett <josh@joshtriplett.org>
+M:	Boqun Feng <boqun.feng@gmail.com>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 R:	Lai Jiangshan <jiangshanlai@gmail.com>
-- 
2.40.0.348.gf938b09366-goog

