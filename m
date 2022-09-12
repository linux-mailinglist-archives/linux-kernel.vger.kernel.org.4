Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2725B5817
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiILKVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiILKVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:21:13 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7CB11C30
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:21:12 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v4so7811072pgi.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=jpV6C4wRSZEyPPy81dpZ/uy16X005oN7Ulv172cLhkY=;
        b=N1vJZnaN5PEsBGWFgs9XemlePWYvscPgv9UetBVcCWA5TVSTg2wbiXq+sOocM8yUt9
         zY/jRbPd7VcKi49gu6J/F0r0Bo/VEaVaHGGgnMvdADpLEb2IKdMTPFBm208MYI0Rs4+U
         lpqrLIQV7rKx1AEM7rORl8UTPhMH3tOE0fTfn3teKZvieubXnQitw9GfTnzDy3GjnlDY
         i4hxWkq+E+FnmjC55alZOXN8F/eR5i9rgZmrwgyeutzcQZxhE2DjjmMHVswuwfnGqjLh
         PT/GkCPmJ/czlspizgpPLBzvgZ266nCMN1w9xFqNJ4J6Hcus6AueLV99sNLvBdrKmwJV
         0OSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=jpV6C4wRSZEyPPy81dpZ/uy16X005oN7Ulv172cLhkY=;
        b=jr/USIemI0F1XiRQFujmTJ+LRSMep/NcljioqSEMbruIPV037VEne2gEOuDk8q+4T6
         pnUNpPRhgBqUDN0TfrIH4xkQD596jFsZNVL4kpEfsioEb3exyR7edBUyXHDrkJtoPP9H
         aTtOS8tu+vO4FXMaILAOwocfgkuUXNWd+DmDodAVfqbFx6UOhF2PAhhtx1ZtUdYjBWVh
         T5L2YW999FMrlGH2dECpMjbw+JPOKBOCdAHZ/esZHAYJEvOHOHFH/HLMSDWK0ypTpaVR
         IiknQhr/MV/0lMtZfhaqLtSGQ1a9ajNHrpkuysqMHHciF//3FliUgSkblEQ52t1k4nT3
         quag==
X-Gm-Message-State: ACgBeo2ugGp1B2sRXE2Ddivi62uIaxgVuFHKYLYTswsJEaO6DOhrmoUH
        8nS6q2f6sVkdOqOFI7wjF8s=
X-Google-Smtp-Source: AA6agR4uw8PsAhlKtsBxJD+CrMvCrr4yLZZsY3gTRx961f7+M8z3xHZasW9ZnURd1QOz1HQuBWMnmw==
X-Received: by 2002:a05:6a00:10c4:b0:542:a69c:fe9a with SMTP id d4-20020a056a0010c400b00542a69cfe9amr6877390pfu.6.1662978072257;
        Mon, 12 Sep 2022 03:21:12 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b00174f7d10a03sm5648090plh.86.2022.09.12.03.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 03:21:11 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     w.d.hubbs@gmail.com
Cc:     chris@the-brannons.com, kirk@reisers.ca,
        samuel.thibault@ens-lyon.org, Cspeakup@linux-speakup.org,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] speakup/utils: use "!P" instead of "P == 0"
Date:   Mon, 12 Sep 2022 10:21:00 +0000
Message-Id: <20220912102059.18215-1-xu.panda@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Xu Panda <xu.panda@zte.com.cn>

comparing pointer to 0, use !P instead of it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 drivers/accessibility/speakup/utils.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accessibility/speakup/utils.h b/drivers/accessibility/speakup/utils.h
index 4bf2ee8ac246..58ca9847637f 100644
--- a/drivers/accessibility/speakup/utils.h
+++ b/drivers/accessibility/speakup/utils.h
@@ -36,7 +36,7 @@ static inline void open_input(const char *dir_name, const char *name)
        else
                snprintf(filename, sizeof(filename), "%s", name);
        infile = fopen(filename, "r");
-       if (infile == 0) {
+       if (!infile) {
                fprintf(stderr, "can't open %s\n", filename);
                exit(1);
        }
-- 
2.15.2

