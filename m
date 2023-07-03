Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49590746119
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjGCRDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGCRDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:03:51 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B38E58
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 10:03:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b7ef3e74edso23381935ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688403830; x=1690995830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7yqLb1wcD9c/2HMWGlnTf+VSyVMLPWMGu7pIDpxWqdE=;
        b=j65i8vVZDWv8CeF+cC2+gRsAq/NRPz21gnPoOIpQIkeRyD60knYLxLf9NDYjTpXWmw
         OVMZ62HhVC+eXo/bO7bKOq10hmHRlWQ0qZvCY6Pdg/bVNaMRzSjX6i+o3d7U+FefTjxV
         HBSFt22ND+sVAfVXGxd75qRpf3CcLovXPfB2HUR9kAprEvolG2UiP+Cew+q9e9bwdt0b
         pj5g456tHOqCHmq9ECVSJZVYroSb8XFOz5VS2o3EdXv1hkkHmARTIrzmwK/NiiRrHnCe
         1kFFxoEuQqtoDK592QAogWGad/ZPWxn7xC5OP7N69gsR5bXyU2WuRwjTuzW/b010Uikw
         WG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688403830; x=1690995830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yqLb1wcD9c/2HMWGlnTf+VSyVMLPWMGu7pIDpxWqdE=;
        b=Yb8pqLjKu+wA20H19KPCfDppCSOQtzS2GoQi/qk/nYck1/xrnZCWiXOMRlfCyo11DR
         6iMwnBa5/RG84sOuonAuOkI8cPI63IyCS6A7As95bL6tH3EM5QsznHEh1q4aa/W7fj3B
         zl4fCF6fD15In6i2V2MJ+AQJrtYmGvh7xPwUVewBFlbsJnLhjppUK1NjAIab6e1EK7M7
         UhOAsnfZM4QHEMzr8SIzDKBRpoyViWeqCJ/6RtmoSsRBcGbpYadrtOE6F/i/NFDn6dXY
         uLZcGM4IkFLw4J8V0ki5kPwQR7w+t+F+UU8vUZu4jiE9uO5nrJS5r/3YekZmT6hTzViB
         zKew==
X-Gm-Message-State: ABy/qLbaD1731zXTJdpH8xMXYRr08AgvnJo/UocnvG2RR83Uo0ntWwoL
        YiqgMKdWGjio+ug55DObVfQj80vdzpk=
X-Google-Smtp-Source: APBJJlFKMlSFis058h9AZEtOPnuYNkUzUtoM6AWglLlBFOKCoIkQYQE+FgCz/pwqjrbkwiaeW5Ba5g==
X-Received: by 2002:a17:902:c40f:b0:1b8:95a2:d87e with SMTP id k15-20020a170902c40f00b001b895a2d87emr4051495plk.2.1688403829714;
        Mon, 03 Jul 2023 10:03:49 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:feb2:139d:d966:84b8])
        by smtp.gmail.com with ESMTPSA id i10-20020a170902c94a00b001b8a2edab6asm340083pla.244.2023.07.03.10.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 10:03:48 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Minjie Du <duminjie@vivo.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: ISS: add comment about etherdev freeing
Date:   Mon,  3 Jul 2023 10:03:35 -0700
Message-Id: <20230703170335.1340104-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iss_net_configure explicitly frees etherdev in all error return paths
except one where register_netdevice fails. In that remaining error
return path the etherdev is freed by the iss_net_pdev_release callback
triggered by the platform_device_unregister call. Add a comment stating
that.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/platforms/iss/network.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index 9ac46ab3a296..7b97e6ab85a4 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -540,6 +540,7 @@ static void iss_net_configure(int index, char *init)
 		rtnl_unlock();
 		pr_err("%s: error registering net device!\n", dev->name);
 		platform_device_unregister(&lp->pdev);
+		/* dev is freed by the iss_net_pdev_release callback */
 		return;
 	}
 	rtnl_unlock();
-- 
2.30.2

