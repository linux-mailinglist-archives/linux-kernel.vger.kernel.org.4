Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E32572271A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjFENNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjFENNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:13:43 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE6E197
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:13:37 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b1806264e9so24381395ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685970817; x=1688562817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qRPb6J5NRktKRP7+z02Eos3uAz1yeGFclnQmG0HZ++4=;
        b=Dj0QqjOK7DmyQir8kYZnVV2n7Ftt7Oq7pfIhlAq0C5Rxki0R4ORhm02hwQ/TnzJGut
         9gJFU4Ghkwe0wdmIInf0wMqXJ2UrOSM1kRcKwGGtkE9dgTIbfhSrHPIlVFXDZrjFkZJy
         8cZ9KS6Oi3nSnQkCFRfxcw2x3zuUZeyhvvWDUGH2uuVFZNz90AKd/Hg2BNe641Pz2Qxh
         Jj/3jimsAa4fnn5qoxClncvorp1s9UwQi1i0Ny+0NWjAXTqKzWfrf49YKuyTL8zr31up
         T2jFa1vS4U1mi+wEKtOZYuXKwHJUwtMBImUGglUvk5wTtHHmSYH5FwXrws5t8PdJVyk7
         L4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685970817; x=1688562817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRPb6J5NRktKRP7+z02Eos3uAz1yeGFclnQmG0HZ++4=;
        b=fBZfGJhCwiXQruJtH61ZbQZmqRnRaW7UfT4hTkaO+QP9zaedPMc4YgVb0eW7o6iUeT
         RryTeEyb3IMdm5SxBEWQ3R8Ispw/VD/NiYu+aD/zCeLwVjjx08NsvLsXln+rP6wYvmp1
         NgLDJFgc7fdkxYT3lLAIoL/FOeJrk6kuYDL5aH1ZNEj2zIN4K2WEyLiaKqrIAPc0nt0X
         jEimRpZtSDiZFu8zW0IfwNmOSDuEIEVqchEOKFIaB4jR5ourfxX34BNaZoptb9hQA+uc
         rnxsN/6lH3VV9s1n/Ovr7uiztTql4FXuKgdAswTp3soOE/W2wX8VFxFJb8A9gasSQIdW
         Wgxw==
X-Gm-Message-State: AC+VfDzY7JateVxBXs4riiK23zB12Qy6tnB45D/mmam9RXcU1y5NbGRo
        B031OHksHRoQud8eY1rBKYIsm9oRPSaoZASL
X-Google-Smtp-Source: ACHHUZ50vSqgKN7a+742lmqTxtfeZnsppZ7tegySwK4rHmn+i5pthr9Fhq94NvbpLUXcnluAYsiJig==
X-Received: by 2002:a17:902:e5c2:b0:1b1:e863:9e77 with SMTP id u2-20020a170902e5c200b001b1e8639e77mr3265400plf.18.1685970817152;
        Mon, 05 Jun 2023 06:13:37 -0700 (PDT)
Received: from ubuntu.. ([103.165.115.136])
        by smtp.gmail.com with ESMTPSA id jh1-20020a170903328100b001a6cd1e4205sm6537642plb.279.2023.06.05.06.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 06:13:36 -0700 (PDT)
From:   Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
To:     abbotti@mev.co.uk
Cc:     hsweeten@visionengravers.com, linux-kernel@vger.kernel.org,
        Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
Subject: [PATCH] drivers: comedi: drivers: s526: fixed a commented out if else coding style issue
Date:   Mon,  5 Jun 2023 18:43:06 +0530
Message-Id: <20230605131306.427682-1-neelchakrabortykernelwork@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
---
 drivers/comedi/drivers/s526.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/comedi/drivers/s526.c b/drivers/comedi/drivers/s526.c
index 9245c679a3c4..12aa40920575 100644
--- a/drivers/comedi/drivers/s526.c
+++ b/drivers/comedi/drivers/s526.c
@@ -229,7 +229,6 @@ static int s526_gpct_insn_config(struct comedi_device *dev,
 		 */
 		devpriv->gpct_config[chan] = data[0];
 
-#if 1
 		/*  Set Counter Mode Register */
 		val = data[1] & 0xffff;
 		outw(val, dev->iobase + S526_GPCT_MODE_REG(chan));
@@ -246,7 +245,6 @@ static int s526_gpct_insn_config(struct comedi_device *dev,
 			 *      dev->iobase + S526_GPCT_CTRL_REG(chan));
 			 */
 		}
-#else
 		val = S526_GPCT_MODE_CTDIR_CTRL_QUAD;
 
 		/*  data[1] contains GPCT_X1, GPCT_X2 or GPCT_X4 */
-- 
2.40.1

