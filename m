Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0A46C67ED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjCWMQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjCWMPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:15:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB00279A4;
        Thu, 23 Mar 2023 05:14:44 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ew6so22560609edb.7;
        Thu, 23 Mar 2023 05:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679573683;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtfyA5+0e27PBCjZwhJRtSv2XkdtikGY1iiyI1Ysvsc=;
        b=CsTdLDaM4ckiOneovfOqYSr+RapnYsg0Em1LH78jxOaP8J8VJR/OlcupAihouHCkNk
         uzr7h7GEN5zUAuqehdtnNOkxyi4A86b1qa+3Dagw1r4saZkPbGehuQOr+7k4MMZ3++SE
         5oubKdfoYCPeM//ZXBsQ7l/4HBLgey5isd6A8mug/WyP+kM250QMYUKIZ5qVuKxMjvsE
         aF84KmkCvBupLdx2IWP9uvUxYdOZfbQYV0vFj6zGbsXX6gHNxfegFmB24vvtjKbgeHx5
         OOvqlUtB6t98UJzkuGD3gC9+FuhvYYw4zYdAjDvbc6xfBmGVWrMljb7LCrVhWWUTMj17
         ulng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573683;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtfyA5+0e27PBCjZwhJRtSv2XkdtikGY1iiyI1Ysvsc=;
        b=gAzaS4Ay/Iy9K3SFkbOtuVzcqA5gFHW2i2yFetTOrzkiI5QP65741E9rKiXv3VPxH7
         QpjKGWgrN8GnMf2gCPNl7g0WEREvLRMrGoAbijrlWEO5XwbYNE0iGSt+h02DyEoNzuPU
         qp0VXRk7Kinp6HTCBXZPrmLpkSGfmew83zbPMz5ypulOiXk9ClA2Yfc7Dwvz5VuJxHge
         tsmHIGqYNxz+bKkAuwrDRMcqmR28o/JAP9ejXR9O4qs993hFZXZrcPGKoOrN9Kg5/kIK
         8WZjSkQlz4ZYih7qedW5CxhvjSIwbFaxMw3Mr+xS+ciPmic3GTENr0DICWAiMWuxDSBQ
         RoSQ==
X-Gm-Message-State: AO0yUKW0mhJqO4vhnH2yyIXD/1n5qoLSmG0X3FCy6UGkhkBGrpBEd8hc
        kYoqVCSS7qEkpQWtbnKx/WHmTPq2t+f2zA==
X-Google-Smtp-Source: AK7set+HmNtTcwTYVRADBqYt9gkrEw4spWc+kfydjtrvRIb2Z0PVz5ZIdmiiy6REIw4t61dQidpwHQ==
X-Received: by 2002:a17:907:1def:b0:8b2:d30:e722 with SMTP id og47-20020a1709071def00b008b20d30e722mr10074299ejc.3.1679573682628;
        Thu, 23 Mar 2023 05:14:42 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:d509:cbf0:f579:76f0])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709064e1500b00930de1da701sm8772930eju.10.2023.03.23.05.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:14:42 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: remove obsolete file entry in MIPS/LOONGSON1 ARCHITECTURE
Date:   Thu, 23 Mar 2023 13:14:37 +0100
Message-Id: <20230323121437.28239-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c46496119ed0 ("clk: loongson1: Remove the outdated driver") removes
all files matching the pattern drivers/*/*/*loongson1*, but misses to
adjust the file entry for MIPS/LOONGSON1 ARCHITECTURE in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Remove this file entry in MIPS/LOONGSON1 ARCHITECTURE.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Keguang, please ack.
Stephen, please pick this minor fix-up on the top of the commit above.

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f8e846fc453..4aac18b5d5c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14047,7 +14047,6 @@ L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	arch/mips/include/asm/mach-loongson32/
 F:	arch/mips/loongson32/
-F:	drivers/*/*/*loongson1*
 F:	drivers/*/*loongson1*
 
 MIPS/LOONGSON2EF ARCHITECTURE
-- 
2.17.1

