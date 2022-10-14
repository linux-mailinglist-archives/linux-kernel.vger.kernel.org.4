Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305E25FEFE5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiJNOKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiJNOK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:10:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39D6E986F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:10:23 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w18so7741411wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rmIl0OBLB4SP+v2h2sZKy8uyDvrgWioQVuwhBBZ4GbU=;
        b=jChNLbHow128ihS9MyG1GGW97WltMz/Vc5Sp7/dmqQenc0gIqNXQPl9Ka0L5/Ala6q
         WaYEyA5XYFgohPTuAUZCR4O+wBSd9fgaU7S60c9Sfm7kgp1YY56bKI61uBH7E52/gpEy
         2XvqVVo162fPWagX386KDJxQRAsPfL9tqVzWF8gSMSAaj7kISHgttNAvoGgtgtWQciZL
         my+r2KRXE69/ZVAri6jKBNHXRCIvuCn0zykGsdl7wbaI47wTMcG/S2trm5hPNBPXfZKf
         GfwcrzXyIvXRYA0D7Yrip3YDGBytORujFt+QD1M++W1obTkczLZytvS1W39dgz5+Pq0u
         eT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmIl0OBLB4SP+v2h2sZKy8uyDvrgWioQVuwhBBZ4GbU=;
        b=A/3DIVWj6ff/XD2vgBsOtqQUFhXFVbgOfuYrVXrBxqTs1ecLBo50iph8/LJDVNf3Bx
         FPpea4aAl217+0m3YXPJLOaq4InQ4uyjXxVGkGkr9rZfdBat9gdZMnDm2EgrQuhuM/M2
         9+xzJLP+GRgcl0LTMqfjF9G1mWnvgaTgWmVYJ3VXQkDP0y8Fl84i2180tHpYSkUTIt3B
         k7E0w1S/VWV/j7X7kvMVtWK4OAOZLhT5nn9Pr2Ve9pcsELlvuwlvFg1UNvcxqcPZ92Lc
         tCGuXvNRxrvXu8J1nPQECGmWHuqswbt5sXsxPk/qUVTHRkSgRIchOXxJjXkoVXvibiaE
         g+fw==
X-Gm-Message-State: ACrzQf1IVUtjjIiqPqjs/tvF6Ypj5hLjgr5Lo9ZtTGH88l8+72akgD/s
        eviGWHe4fm0DXNWIRofsdUBkQA==
X-Google-Smtp-Source: AMsMyM4T81oq5uEeobLXYxpcLvVCbMaf5kQ3itirRq04ESLdABuNwH7haJlpUAclsDe9hu3KA9R2/A==
X-Received: by 2002:a5d:584d:0:b0:230:c250:603e with SMTP id i13-20020a5d584d000000b00230c250603emr3458637wrf.143.1665756621603;
        Fri, 14 Oct 2022 07:10:21 -0700 (PDT)
Received: from localhost.localdomain (host86-168-251-20.range86-168.btcentralplus.com. [86.168.251.20])
        by smtp.gmail.com with ESMTPSA id t65-20020a1c4644000000b003b505d26776sm7010265wma.5.2022.10.14.07.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 07:10:21 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, qsyousef@gmail.com,
        qais.yousef@arm.com, Qais Yousef <qyousef@layalina.io>
Subject: [PATCH] mailmap: Update email for Qais Yousef
Date:   Fri, 14 Oct 2022 15:10:16 +0100
Message-Id: <20221014141016.539625-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update my email address for old entry and add a new entry for my
contribution while working with arm to continue support that work.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 .mailmap | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 380378e2db36..bd51ecdb4cd1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -353,7 +353,8 @@ Peter Oruba <peter@oruba.de>
 Pratyush Anand <pratyush.anand@gmail.com> <pratyush.anand@st.com>
 Praveen BP <praveenbp@ti.com>
 Punit Agrawal <punitagrawal@gmail.com> <punit.agrawal@arm.com>
-Qais Yousef <qsyousef@gmail.com> <qais.yousef@imgtec.com>
+Qais Yousef <qyousef@layalina.io> <qais.yousef@imgtec.com>
+Qais Yousef <qyousef@layalina.io> <qais.yousef@arm.com>
 Quentin Monnet <quentin@isovalent.com> <quentin.monnet@netronome.com>
 Quentin Perret <qperret@qperret.net> <quentin.perret@arm.com>
 Rafael J. Wysocki <rjw@rjwysocki.net> <rjw@sisk.pl>
-- 
2.25.1

