Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935BA5FE46F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiJMVt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiJMVtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:49:35 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447FD8E7A9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:20 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id l6so2677861pgu.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=JvqzMQuG2ysbuflR34UFHsMOAGwcuRu//rcYf9o8Plw=;
        b=VOhZUJ8HWpyodxNy9hEF+jJ52uPI2e0oBaO1RhSBkI3oLLYc/74IND3TkIv+sEZbQF
         2rlyEzS99kFSA2jTUJKDhv/9Aq1YAJlD5p0L559tMtVCasDFvI9bWDY29+ErRJoyma8W
         UwgquJ5ahHhJdsTJHOfsT7ApoEhkW/XHRrgeS2gP+xMBUhwMc7RvJBnVVesqpEulHa10
         55w9Pw3A/X//om0F8CHibb1ghqPEgsfDrnpqs4d3d+A+V/fxJd8WJZt8alcjULagrd/N
         9y5BKPOXPiH0A9K2q5m0zp0Xkih3UmMht9ZdsJLhZpS5U7xCLFwWqVN0oguA9YVybRTK
         /nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvqzMQuG2ysbuflR34UFHsMOAGwcuRu//rcYf9o8Plw=;
        b=QPLnZt+LKHVdT/3/xyIMKEW74lEUaMwka9Y0bb2Lcutis4TX5FBzv5xzOsJDgtXJ3I
         gcsPtDclk7m8qyLKLWuh+0XEtnAbU09d3Wd5Iqdh+XuRtsvLGrc8+D15fsmmBwh4HiKR
         wwie0Ufylp0lIf7h9TXOUKThOwRbrZunizBMx39hwS+9LEvibqSIaUyBDkVBXWNsEFV9
         uRc35TSRZ8qPcTXD9ZDqco8WxXX0iQfiCkmN3Ip+gAGzhkqhQmkkTTvAKFEarC8IZLjo
         nlwB12U+KRyabutRQ55lzIqv8VX/UEGgR4zowy6QwDeVaBlePXHc6aseB82SomnNGWKE
         lXaQ==
X-Gm-Message-State: ACrzQf0iMhkLXKAGu38e66ab5lJTKoNiQWE4DZ0/QnKfQnRTVBQBE0LB
        nohjPXmzt2mBp2ySdfzD0o87SXGDn4cOLZNd
X-Google-Smtp-Source: AMsMyM77MaqGBAHFmJlDQnHnsmOLwoA7y7mMTrwXCkONizLkseACp88n9Lkm5RIcw3kGmIhemDfo6w==
X-Received: by 2002:a63:1b5d:0:b0:461:7362:e8b5 with SMTP id b29-20020a631b5d000000b004617362e8b5mr1678019pgm.83.1665697753893;
        Thu, 13 Oct 2022 14:49:13 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id t14-20020a17090a3e4e00b0020ad86f4c54sm232814pjm.16.2022.10.13.14.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:12 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for kleikamp
Date:   Thu, 13 Oct 2022 14:46:38 -0700
Message-Id: <20221013214638.30994-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     shaggy@kernel.org, jfs-discussion@lists.sourceforge.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 6a4e8144198b..9a47bd58a330 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10867,7 +10867,7 @@ M:	Dave Kleikamp <shaggy@kernel.org>
 L:	jfs-discussion@lists.sourceforge.net
 S:	Maintained
 W:	http://jfs.sourceforge.net/
-T:	git git://github.com/kleikamp/linux-shaggy.git
+T:	git https://github.com/kleikamp/linux-shaggy.git
 F:	Documentation/admin-guide/jfs.rst
 F:	fs/jfs/
 
-- 
2.38.0

