Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB566D3827
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 15:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjDBNyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 09:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBNyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 09:54:33 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB589ED0;
        Sun,  2 Apr 2023 06:54:32 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l7so24851154pjg.5;
        Sun, 02 Apr 2023 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680443671; x=1683035671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Js0vdR9qo581AbpL/JRCH5c1IDiCJNDf7AV+/DBVZ8=;
        b=iZCF4e54pSQKxlmpeKZ7YX/I3vvW6ll4Q/Ru0VXhjWwe2o/l0LpaDyK4kH+GeSS3BW
         rt5OqJVodAL3pMlF8huCgOz3bK5vi/4T+uJKG79FQ0htpEo+LSbcv8acgwqU3ZPj+W6V
         JkcWpWp3O/A51RoPybOR7CZifv+htikGpE8cdKbgFG4d1ZwFI484icwxknbhLKw3nMrV
         nBN0oqs6j162HupVsW8kTOYaCOt2TMXqEasFl9UcGfcF0eTO8pfZrSIyopT36/lvrO6z
         Uj83khLsrems7lPkpreRAM6FDFnWqQYayUg+h9tPnAizMIPfZprqRGh2tElX+t8Y38cr
         JRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680443671; x=1683035671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Js0vdR9qo581AbpL/JRCH5c1IDiCJNDf7AV+/DBVZ8=;
        b=vijbjg5/A4vK2eHITXqsF3vs6xL9sq8SNFzzjx6Pp3ykRlWf3mucXZNa/4aLeCgTO3
         0ofSogsY9bGjWVenlf93RwbwcOLEaNrer61/ChpytXvZzaUQABgVdK0fN067NUpdqLvn
         YfR3lolb/PuJbMlBgT/Ogd+vAXrv9AVAy6MmpDT4IGoxhCEIHXMgC1Ydkju1DWdOSdhg
         0TEgvwzBsjzlBZvdSkNEHhRQuy0juMH1revm9glEh2RvR1cKrRqbFaPYzCBxqr8CKm95
         I8GuTops/njg9iJyZ5hy9qOf8/EnWMyouQG0T9Q5g6KNybKtjArrUSoWHulYwwVL/wq0
         06YA==
X-Gm-Message-State: AAQBX9djysJMhoIc5gQr2cbd9PkphXd+F4Nk8elR9uDuhohRX/T5h8vI
        vR5rkC9ZgTeqN+61NfixLEm6p4AfkNv/NQ==
X-Google-Smtp-Source: AKy350Zt9eyH4Fk7vZKvgUBlf/okVVMn2EMJV4TdfWiVeEa+Kmw/88qSjvidDFmuBTgYrTHPUO15Gw==
X-Received: by 2002:a17:902:fb46:b0:1a1:a722:104f with SMTP id lf6-20020a170902fb4600b001a1a722104fmr27675880plb.24.1680443671513;
        Sun, 02 Apr 2023 06:54:31 -0700 (PDT)
Received: from 7YHHR73.igp.broadcom.net (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id ji13-20020a170903324d00b001a1aeb3a7a9sm4824861plb.137.2023.04.02.06.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 06:54:30 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH] Documentation: firmware: Clarify firmware path usage
Date:   Sun,  2 Apr 2023 06:54:14 -0700
Message-Id: <20230402135423.3235-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newline characters will be taken into account for the firmware search
path parameter, warn users about that and provide an example using 'echo
-n' such that it clarifies the typical use of that parameter.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/driver-api/firmware/fw_search_path.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/firmware/fw_search_path.rst b/Documentation/driver-api/firmware/fw_search_path.rst
index a360f1009fa3..d7cb1e8f0076 100644
--- a/Documentation/driver-api/firmware/fw_search_path.rst
+++ b/Documentation/driver-api/firmware/fw_search_path.rst
@@ -22,5 +22,10 @@ can use the file:
 
 * /sys/module/firmware_class/parameters/path
 
-You would echo into it your custom path and firmware requested will be
-searched for there first.
+You would echo into it your custom path and firmware requested will be searched
+for there first. Be aware that newline characters will be taken into account
+and may not produce the intended effects. For instance you might want to use:
+
+echo -n /path/to/script > /sys/module/firmware_class/parameters/path
+
+to ensure that your script is being used.
-- 
2.25.1

