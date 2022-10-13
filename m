Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BEE5FE47D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiJMVvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJMVuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:50:05 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2469036BE7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:25 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y191so3161485pfb.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=4rYh4tqzLqjfiQMLUfTOKLlbHKAPQJTUpMUJOxSXfbI=;
        b=SwyMx07dMbnb7q92xNJTCTW1qsMdqodOoR+LxmA0VONDdPpXb/0x8CADb/8b8UXbnm
         C9XpSJOjL+q+Eu9S7WKz/hrRHcq98xIp79L0IT567o9Li4OC9YoOw2dieRWHfj6EZIlf
         sOoKYv/WwE0NSiBC2J6IkZHel86sMSD/yYcQLDMKeGJuh4xJnxSBGvnA/KDcH2zEH7q4
         sCyxv5h4h2gBUmDIH9ZZo0uDC4YwYv+J7NUbiMzBc2uSsuCSSe0FKM0Ih5MkL+jcsJrF
         tKHHOdR4g5xSntXCcCpft6tl+qrDbrPb2/ws+TErNE8PQEMx22YlE1geM+ScozAqTDjS
         97Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rYh4tqzLqjfiQMLUfTOKLlbHKAPQJTUpMUJOxSXfbI=;
        b=qFWuOM0/GRD6Vi4sNuICF82iOsHBAhFogrhr1lpoo/6cSJH3c5Vnk6sKazBJktDyNs
         K9YsRnHo/3kOXjV7xSw/iXaBKgF5s9NRAlN23YCtjU4Aq/44cyL0GSwN4i6MOqlLxOuR
         nONxZ1dcRta5j9Q5c0D+I7NDcnnGfxUBW5+OQ4SKCdsM4eL4LK2NY79w6bhYwrMq0p2i
         fE05ofUNEmBW/aUxxq6qB1Buea1ZRMFB7Z2cPPu9PrHmNC3e9PVly0RgUTGbP1ZHXtpX
         LDKk7TrTSL71B2THPfW1Gs2ieSw29sTs9KfS9XGRY+RrorMnbwdeSglKBWApEKWtVyWP
         cV0g==
X-Gm-Message-State: ACrzQf2t+58xCkz1eVRzbaCSKwGchEEbW5E8zhrAu4xOGMq8+QZX7x8/
        24qnaJzwErka+kYgpwwO0t4mZ7OqBxj6/d3K
X-Google-Smtp-Source: AMsMyM76DJUblEq4EfnVnK4aDqRBTLE5ae8HxC9rBJrwXTLjTV+nMNLdF9iGhj+n5vrXjlgUkUny0A==
X-Received: by 2002:a63:24d:0:b0:452:87c1:9781 with SMTP id 74-20020a63024d000000b0045287c19781mr1703876pgc.512.1665697765167;
        Thu, 13 Oct 2022 14:49:25 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id b7-20020a170903228700b0017a0668befasm307663plh.124.2022.10.13.14.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:24 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for vzapolskiy
Date:   Thu, 13 Oct 2022 14:46:40 -0700
Message-Id: <20221013214640.31174-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     vz@mleia.com, linux-arm-kernel@lists.infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Github deprecated the git:// links about a year ago, so let's move to
the https:// URLs instead.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I've split these up by github username so folks can take them
independently, as some of these repos have been renamed at github and
thus need more than just a sed to fix them.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6f79bdb4ee70..6d4e578f6cc1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2281,7 +2281,7 @@ ARM/LPC32XX SOC SUPPORT
 M:	Vladimir Zapolskiy <vz@mleia.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://github.com/vzapolskiy/linux-lpc32xx.git
+T:	git https://github.com/vzapolskiy/linux-lpc32xx.git
 F:	Documentation/devicetree/bindings/i2c/i2c-pnx.txt
 F:	arch/arm/boot/dts/lpc32*
 F:	arch/arm/mach-lpc32xx/
-- 
2.38.0

