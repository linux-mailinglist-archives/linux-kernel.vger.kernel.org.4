Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703296B6EC0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 06:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCMFJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 01:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCMFJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 01:09:11 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEAB25E2F;
        Sun, 12 Mar 2023 22:09:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x3so43696956edb.10;
        Sun, 12 Mar 2023 22:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678684148;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPeUZ8/TRz97/5xautsmimgF2BR3ajyQnCAIeqXt5JE=;
        b=nyqxQIrCF6KDiAZw1b8m4PZR/GNtSA1g9idSQFjcGHXMdu7brOu+KUW4P6dYaqGkIM
         I+LMbpMydMTo8t5fPrmgLc0ZjqxZGVLOvUHgV6ptyWkTGm8cRGU1SYej5r4C945WSL1Y
         VDZEKQZfTad4yYQ8l8NYYQ4xULG5GlaIacuhWhlRpC0EX8qUR6QDcAaxnNaNdsXIN8xU
         7KqS7bzdhWdLueBbE0Oxo8MRZ51ETH9Dsnn6KdUHKmJjkiW98dAdV4R5+P+E0pGJ/XQr
         tr/BiSAVO+/RNN6Voya0s7ZF5IHtW3ilUGcMSmknjAseZCdAbT40Qe8TZxk9Z5IEmQlG
         EI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678684148;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPeUZ8/TRz97/5xautsmimgF2BR3ajyQnCAIeqXt5JE=;
        b=nxka9wvdSNMYJL4O5eCHnpOrW72Du4pHcJoMq3bUKw6v0zh6F944VRCUMJivVGaY+/
         hoh7ItgXQ1W8c3eWzppSU4cAmye/37pZCqGK6gfzBT+2VV5WaR3Qry5xE3r1jziEeexG
         xgFA2mUhIBbkEzd2LPP5vPi97cHa3hRzh3d7pWOMZn68Tzz5RVL8Mu6apBqPOozUNQEP
         s8mSU1LcTc8iBj7t3Dlv0B09204rOtsgMeiDlz/yXGuYIcASij84O49sgfZQXkBp65bg
         ME4nQZwtdr99IzCK2xdaTHAJRubSYW9bIZJt9MlEsbwYhGV2MT+1Ws85XMFFMQFFvtad
         EiiA==
X-Gm-Message-State: AO0yUKWAox/fnPo/1fxEwcY44bJ7sDMnD+nO74Yb4itsp3lqP2xDKisy
        4BvaEb528C/D4GONY+razOM=
X-Google-Smtp-Source: AK7set8QPCJTIDTMIV6Kh2J2CdN72IibjdSoZKFWFmU76t8xV4MSkU+mwscyB62sGiOslWhlhF9Wgg==
X-Received: by 2002:a05:6402:1645:b0:4aa:a4f0:2c17 with SMTP id s5-20020a056402164500b004aaa4f02c17mr30937503edx.4.1678684147911;
        Sun, 12 Mar 2023 22:09:07 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:75e7:ea6b:c385:692e])
        by smtp.gmail.com with ESMTPSA id 1-20020a508e01000000b004f9e6495f94sm2604363edw.50.2023.03.12.22.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 22:09:07 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Support Opensource <support.opensource@diasemi.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH SECOND RESEND] MAINTAINERS: repair pattern in DIALOG SEMICONDUCTOR DRIVERS
Date:   Mon, 13 Mar 2023 06:09:03 +0100
Message-Id: <20230313050903.29416-1-lukas.bulwahn@gmail.com>
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

Commit 441613662db7 ("dt-bindings: mfd: Convert da9063 to yaml") converts
da9063.txt to dlg,da9063.yaml and adds a new file pattern in MAINTAINERS.
Unfortunately, the file pattern matches da90*.yaml, but the yaml file is
prefixed with dlg,da90.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken file pattern.

Repair this file pattern in DIALOG SEMICONDUCTOR DRIVERS.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
v1: https://lore.kernel.org/all/20220623104456.27144-1-lukas.bulwahn@gmail.com/
v1-resend: https://lore.kernel.org/all/20230110154901.20223-1-lukas.bulwahn@gmail.com/

v1 to resend:
 - added the Acked-by from Conor Dooley.

Lee, please pick this minor non-urgent clean-up patch.

If not picked up, this patch will go to Andrew Morton for another try to submit.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2892858cb040..19792a020016 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6000,7 +6000,7 @@ W:	http://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
 F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
-F:	Documentation/devicetree/bindings/mfd/da90*.yaml
+F:	Documentation/devicetree/bindings/mfd/dlg,da90*.yaml
 F:	Documentation/devicetree/bindings/regulator/dlg,da9*.yaml
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
-- 
2.17.1

