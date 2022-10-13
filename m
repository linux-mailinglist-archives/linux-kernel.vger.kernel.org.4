Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672105FE479
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiJMVtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiJMVtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:49:35 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E1E196B66
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:11 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y191so3160969pfb.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=J5mjwMGu2qk5bP3hjRC2Gj2D7aOEOgPLH90aVWzBSuE=;
        b=XPvm2Eg+Chky+3e450NOaAV2UIYc7ESS3vD/9UeYZ5M4LrmS1Hf8OwPSl3u75HfXLC
         x3FJ1Ky317rOZYN+DPoEKoGUuS6zwKZi4xJhmzYXsWQ975GXGeRcNvzloZh0jOHOEryh
         sPySJJA/wq6Gytkx0xezdVJ4LgFdGZ1UW3Tq8GcATRic5/Lo9D8Nhn4Y8wadwIkOxcpC
         rvU0Wy075n7cfKESfZkVe/fo4Um5uiSfHHeyog5ZMxSE5LZ6td+GYJYhiwOwHmrBr6od
         7okf40/bn71z1astTaD4KyEi/Og6spyIWQkIOx0mMSsgvG4qNBz6+ZUuIY1Bem2bkH/M
         Kf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5mjwMGu2qk5bP3hjRC2Gj2D7aOEOgPLH90aVWzBSuE=;
        b=EmUqdRev2o276lXOFJHK/MEh8L2QNVcXEqrEHetYwa2yinuP4rBMJ3uESa7et1OPEH
         Cv3kk3LCLccTBHKulbOHOs9FQoFXyJE312+KTpJodPp3fmAdIuXCPjBXzdOro0M6KA3c
         gbqWMAUSuoHPWhgnRqyEXxeAqrYRUs1i5btVxNLg+Gp/NmNChXxcU2BV2eac3rbXcpWA
         d7rKjxRcWLYe5l7kjbVz093Ajxrw5uZnt8jTrNbt9krX2zZpk/Py2O3YhY/KMvBJUH/p
         r4DJS8v7ad9gTzQl/bycAtkmz+rQJNI9/QsDSULBiKyQUKagWOFjnF8b8Lx3Z8XR/INW
         iUfw==
X-Gm-Message-State: ACrzQf2si5LLlSVOP5ICqmPc/JR+9r6v/kfyC2ZUclVGAl5ihloM+JHF
        kPJ3HJHD+bR/6UPgAWLv0m2/0d4ZtfOthalO
X-Google-Smtp-Source: AMsMyM6mvmMMRIFn+fboyuZWimGbL12CxiIDTmDavT+W16uZk9STafGUskTVP2CF6z1gw3ZQUCiRtg==
X-Received: by 2002:a05:6a00:804:b0:563:264a:f5e5 with SMTP id m4-20020a056a00080400b00563264af5e5mr1795424pfk.62.1665697750534;
        Thu, 13 Oct 2022 14:49:10 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id o63-20020a62cd42000000b0056258a3606csm149495pfg.215.2022.10.13.14.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:10 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for linux-test-project
Date:   Thu, 13 Oct 2022 14:46:38 -0700
Message-Id: <20221013214638.30953-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     vapier@gentoo.org, chrubis@suse.cz, wanlong.gao@gmail.com,
        jstancek@redhat.com, stanislav.kholmanskikh@oracle.com,
        alexey.kodanev@oracle.com, ltp@lists.linux.it
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
index d103b44fb40c..d118acdce8b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11972,7 +11972,7 @@ M:	Alexey Kodanev <alexey.kodanev@oracle.com>
 L:	ltp@lists.linux.it (subscribers-only)
 S:	Maintained
 W:	http://linux-test-project.github.io/
-T:	git git://github.com/linux-test-project/ltp.git
+T:	git https://github.com/linux-test-project/ltp.git
 
 LYNX 28G SERDES PHY DRIVER
 M:	Ioana Ciornei <ioana.ciornei@nxp.com>
-- 
2.38.0

