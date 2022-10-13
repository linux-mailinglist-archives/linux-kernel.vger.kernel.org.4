Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99C25FE477
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJMVtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiJMVt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:49:29 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B7336BE5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:08 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n7so3036266plp.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=vBx3K1ot3v49SwgTPYcBqrot/DJk84gW5RbBZvKcvpc=;
        b=iB3xu49D6L5voc5fMv0fn8xMj/pj7TitTcjjeGhKcICioMEE4VRD56ytDcUdFS1obx
         wf1LMKAAZbjgPYY0LNV1ZvUrG4uxtsBSKBu6+lDCFZxAWnanTVLhZp+jAyM4/Bp4AANR
         WG63Elp33E/6w2lyPBWbCgkdqPd6Wh8qWTGJ4eLZpj5UD9sx0Wwh4YLvUPVVn9N1vGGP
         j2CNd1nLCzLSSLR32teu7CvYkTDK8FZ2dvweovEoLGboHKt++w7zT72AMbQ7HHu/dV2C
         ZQDfyG1Wn8MG/Y2nTAxtJX6aEeTHMu4CVSSZCxERy4/5zAOLVhkteWDLLnQQeHYumiMV
         Vucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBx3K1ot3v49SwgTPYcBqrot/DJk84gW5RbBZvKcvpc=;
        b=32iIKguStoj8tKld5LGc/gIXlt+5DIz9wErx2ZlI2sB+sAStlbGl+51AQYNeN41e3K
         Zn3SVK3OGpg4rU7K2mT9ubfoz/4kBX1cCftfTJQ0hK65C1/N84LMIKYbWj0lOarG/0W6
         hWbEnl64n1J5SrDSAZoDdqG9nYmr8vLrqGHZxQRN0nMx9xmoMRkfReWSzWEEQ/9ujiAn
         VQmKmtfT/me9hklP4MeTfoAFpQm6lbO+B9eFln0BxSX7f9bgtqLO0Rdfye2Crr6V/1KF
         QintMJkZZcrlkKquWtrw+qcNSURqx+tMOR4FTC3xkGVp1MmRr7CaGry7bFCYXcQya3XV
         9LlQ==
X-Gm-Message-State: ACrzQf2r6DeKg7loQfeaRamMC12p4uL2x4vSRJcm2eLmwgF9l9UKfnPo
        E4tF9NrPVwnks8iqpRA3VgoCaGV8wZXPkuky
X-Google-Smtp-Source: AMsMyM5iNFHilxSB65fezOEPSLaI9f6dIP7s/eJti/GmPxhsKihbdce6/fTzfgA+XRF4zucaYGC+hw==
X-Received: by 2002:a17:90a:3841:b0:20b:650:60d1 with SMTP id l1-20020a17090a384100b0020b065060d1mr1998734pjf.102.1665697746612;
        Thu, 13 Oct 2022 14:49:06 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b0016dbdf7b97bsm284299plg.266.2022.10.13.14.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:06 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for openrisc
Date:   Thu, 13 Oct 2022 14:46:37 -0700
Message-Id: <20221013214637.30893-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, openrisc@lists.librecores.org
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
index 796ba37dd4ff..9a9ca93b63fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15234,7 +15234,7 @@ M:	Stafford Horne <shorne@gmail.com>
 L:	openrisc@lists.librecores.org
 S:	Maintained
 W:	http://openrisc.io
-T:	git git://github.com/openrisc/linux.git
+T:	git https://github.com/openrisc/linux.git
 F:	Documentation/devicetree/bindings/openrisc/
 F:	Documentation/openrisc/
 F:	arch/openrisc/
-- 
2.38.0

