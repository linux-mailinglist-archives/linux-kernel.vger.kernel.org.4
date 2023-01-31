Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DDE6834F8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjAaSOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjAaSOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:14:43 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8EE1027D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:14:42 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id k4so38698116eje.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oBUJW5g0l7Cow1aZueI6QMIdh34q+4xeYl6ay0vZEdY=;
        b=ooUIqV1qOuf4L+JepERD12vmqc21GEhVvlFh8Kk/YMuX5rl/Emj5/KdJvys6lyRWPw
         KfA1VwfDQ+wdIW+wW7m8Aqd7YRGb4DE3UNTqsLa0sIVKR4/YOHpj9x5s3FrZxHJWvTaZ
         Dz7fuyyxHPYNQC37otjMILneEAZY92edcJhHaNyF/vn4BQgm28GhsVLQY20ZZq1GSUFJ
         R2vMXoQFwffwTr7347LV/UTAX9dr3A1p3Np5bwOIcNaf1U6B4sXd49Si+1P8sl+BeIiI
         c6zjTGW3x0uWfQXNeimNq6IJKSoAwV4RZOAa4dbg6xWbEN/EWmleGKrRcUU+ZnYRF+aO
         BSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBUJW5g0l7Cow1aZueI6QMIdh34q+4xeYl6ay0vZEdY=;
        b=wvbg/RLvOmcS6AJSC0w6bL9bgPGo4R55WkbD+tjmwRvk1uDJxgb2vGRA81YlPrNsMN
         YEla1fBtC7cgow8SuRj1OffeRIhV60Ht7z990HRndRnyedVCcYxD3C3oBP5L72dWoBJC
         /wf17Axlgi/WC6UyhXfJbmwIKxf5VEIn50u4z+QsGXi+/qPD2Y9rZbE6gbCq6ZdJJnBg
         U/2qcicokKsSp/IDvM4r/duAbYXBQBZqWh1LjEkmArNobCvZtWxj2Y0tOid3PJ/+g0iK
         /CkFgGAHntNq1GXNgIj+WGelIRp0DXi8w5lAIvj1ObJCaxe74vQxBvU/r/aFyIMGfBTX
         2mxw==
X-Gm-Message-State: AO0yUKWuRqblqs8mF8dcdHv6E1HIo3M3Ze8dFyC+47EUQ/W82QpfxqXk
        3AmOnK4U+sDUlMrTLPWpLHc=
X-Google-Smtp-Source: AK7set/Fm2STpfkzkeO2bN2CrWnDnnHCG4vOw5APB3JNA3oxaU0Bf8XyZTdFJzyYYgRCvlzNO3jmFA==
X-Received: by 2002:a17:907:c282:b0:878:509f:798d with SMTP id tk2-20020a170907c28200b00878509f798dmr26429055ejc.0.1675188881209;
        Tue, 31 Jan 2023 10:14:41 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (gw.combine.ideon.se. [85.235.7.115])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906318700b00888f92f0708sm3370998ejy.15.2023.01.31.10.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 10:14:40 -0800 (PST)
Date:   Tue, 31 Jan 2023 19:14:39 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: Added information about bit_rate
 configuration
Message-ID: <Y9laj+z0TuasBRx5@combine-ThinkPad-S1-Yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Information in the TODO file for bit_rate configuration is
insufficient.

This patch adds information on how to approach when considering
to modify bit_rate to support upto 300kbps.

Signed-off-by: Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
---
 drivers/staging/pi433/TODO | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/pi433/TODO b/drivers/staging/pi433/TODO
index 5cf3fd99d521..daa0dbcf6d53 100644
--- a/drivers/staging/pi433/TODO
+++ b/drivers/staging/pi433/TODO
@@ -3,3 +3,6 @@
 * Some missing data (marked with ###) needs to be added in the documentation
 * Change (struct pi433_tx_cfg)->bit_rate to be a u32 so that we can support
     bit rates up to 300kbps per the spec.
+  -> This configuration needs to be moved to sysfs instead of being done through
+     IOCTL. Goind forward, we need to port userspace tools to use sysfs instead
+     of IOCTL and then we would delete IOCTL.
-- 
2.34.1


-- 
Thanks & Regards,
Guru
