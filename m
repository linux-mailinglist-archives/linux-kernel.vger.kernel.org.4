Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A775F6239
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiJFIC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiJFICX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:02:23 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843A9895E4;
        Thu,  6 Oct 2022 01:02:22 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bq9so1418885wrb.4;
        Thu, 06 Oct 2022 01:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=h/CPbvBhIhAmB8BgDAWtC+ijrXo2y4m+iumWEM4mQ8I=;
        b=IXs0zW0GLS/p3OdwRpeM+Pm/hT9vgMdrXlY96Tu7Lm05QLmaiyq2aym49owlCKLjIs
         faCORzG4kJ9AVuhPCLqSioSt/rt1FD3kRLk/2Vuz/YklThaaojDcXqO+i1rxD8Q36ewj
         XelJ1DkUAAUhtgoO220Up9/uMKvHAmyuKqxAWUHDG7FAehTApar9HQ+k90wlwKI0z3Un
         VQ0Ya8fUkmRANWV2gpY9zSoED2NklTDZB57ua1WuPWB/x32QWPfuHjexwABW1vg87hjz
         fDvI3eBE04i91OY0NhB5M4lL0HAYLrdMVv+n5WpuGCQjJbBRdJrrG9mYsIID2Fw1WFUJ
         8uJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=h/CPbvBhIhAmB8BgDAWtC+ijrXo2y4m+iumWEM4mQ8I=;
        b=qrmf4nDXCaPn4+JEYjnXm3iyPyAKXD6Fa+XGKWorsRvxa40/b+qZAr6+ahB67XbN+x
         wm37D2TfC1IM6coUFPIEimprK0TqrIns/9+R2tqBDWqOf4WmlbayIALUHNBUhOWuYNvC
         VJmLXgnqdmJ0wheKrivKbMs23lTotbfN9VH4sjb9v2zmYqzfZsAMgTQnTE4lH4EmfIdh
         PwJnrx1jLUiRUqANdGlJZbGgj7tusKGF6JEjR6JGWxs4Aa24dWo5Zy+A5N4kwIxiKTcG
         koioXHBXQ5uf0JyE0rok0SnG2YwF9I4bKCgOpogbrmDJRJMX8np0RAOaCCyaSgwsO3lN
         lzFg==
X-Gm-Message-State: ACrzQf1cMw7pCz0yuN+Zy0SUwD53RpmESdtxr9texc+ksMJcaoqCXQ+B
        k8l/8QGoKpQ8jM1c7KxdJ814s/4sh14=
X-Google-Smtp-Source: AMsMyM7HB9/f4IWVA2KEgdPROaQRV06J4NJ+ZjB0UMnhjpgnwDnI0RjKGCxsA+RVIarbEdz9cotQJQ==
X-Received: by 2002:a5d:44c4:0:b0:22e:31cd:afe7 with SMTP id z4-20020a5d44c4000000b0022e31cdafe7mr2243348wrr.246.1665043340741;
        Thu, 06 Oct 2022 01:02:20 -0700 (PDT)
Received: from felia.fritz.box (200116b826c5b200182d609e7f0e6e89.dip.versatel-1u1.de. [2001:16b8:26c5:b200:182d:609e:7f0e:6e89])
        by smtp.gmail.com with ESMTPSA id k2-20020a7bc402000000b003b31c560a0csm4242918wmi.12.2022.10.06.01.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 01:02:20 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust STARFIVE JH7100 PINCTRL DRIVER after file movement
Date:   Thu,  6 Oct 2022 10:01:54 +0200
Message-Id: <20221006080154.5396-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ba7fdf88e98a ("pinctrl: Create subdirectory for StarFive drivers")
moves pinctrl-starfive.c into its own subdirectory starfive; further,
commit ba99b756da17 ("pinctrl: starfive: Rename "pinctrl-starfive" to
"pinctrl-starfive-jh7100"") adds the suffix jh7100 to the driver and
dt-bindings header file name.

These commits however do not adjust the entry in MAINTAINERS. Hence,
./scripts/get_maintainer.pl --self-test=patterns complains about a broken
reference.

Adjust the entries for STARFIVE JH7100 PINCTRL DRIVER after file movement.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a1347b5fd07..37a9f9e7f6c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19603,8 +19603,8 @@ M:	Emil Renner Berthing <kernel@esmil.dk>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
-F:	drivers/pinctrl/pinctrl-starfive.c
-F:	include/dt-bindings/pinctrl/pinctrl-starfive.h
+F:	drivers/pinctrl/starfive/
+F:	include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
 
 STARFIVE JH7100 RESET CONTROLLER DRIVER
 M:	Emil Renner Berthing <kernel@esmil.dk>
-- 
2.17.1

