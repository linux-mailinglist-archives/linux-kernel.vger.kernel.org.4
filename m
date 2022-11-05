Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECD861D949
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 11:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiKEKBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 06:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiKEKAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 06:00:55 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125791BE9E
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 03:00:34 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id k22so6536821pfd.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 03:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=faUzu67FJ/vE0Y/rYOSRDt5IUPW4ac/77L2ocXglKpU=;
        b=KZq8Sm8m8yK1ql+Y5hJ2BKfRpsRlHaoBUEC+SgKNawxruW6mb/pl9IbWz/7g7hu9Up
         loIo37A0r89o/nhoBQiokpms/RqmKrJwkyfbQtYSwiQzCdgXv/xleENRvOQ6Pk8nYPZ3
         v2LvA7gDmssdtJDq+HrJL4PEHPI3tBZZbnh85zBPDKXNF3OukGjZrVBg9aHdIIqH0QTK
         pu3gLc3j3fjBaVV0ox5uO7ef9rnDQzCJtSpx5f5PEvk6ZFrdbi3L/4o0nAuGhwgNi/ho
         TZfKu1ydhyiHxtVSMS7SHKk9IsqVGWvzWPfc2NJlcUzAma7b5ZsbixC+YsJVoaJKqYCI
         00AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=faUzu67FJ/vE0Y/rYOSRDt5IUPW4ac/77L2ocXglKpU=;
        b=ODVdkHeol/sdXpc+bAlnReBzdpkIX0qSmKxAGJwjs4uVOQxJJO3fvLbSvwjDHRYKi1
         Kj4pG+YSQzgxaZJGohzKLD3eUFa6xhzlHuaOcn13AeelqUJPJV/skU8tjoSwqElc7jcd
         IN/dw1hANdaf2uslX4sgmlRtZHH+rSZQGep6Zu73g83oqW4i7uV05xlfEKHM6uQqGq15
         Y11oUM9SXX908aLO3/f/O7AA9RoN8mtT9kUTWSaAForiVXnqDinPYanka1PL6ybj/7OH
         tgwPpMwNlgkBiQYENT+CFnGKWfgNi8AHrM9HClA1Hct1Vf3d41N+Kiz8pL2kxRt5n5jy
         rphQ==
X-Gm-Message-State: ACrzQf3rTWvtrdCrwENbf2U59H+MM+UBAELUb+W0e5KzzyhYXoj69Ujg
        Cxx4s+Rmk8DU5N8OcByWFX8=
X-Google-Smtp-Source: AMsMyM6bVVN6ImWSLUkEsM2JZtUpJhPkVDzB7Byeon1ihmYzM92MCbVCnINN79j+3MURqKzDppjgcg==
X-Received: by 2002:a63:f903:0:b0:46f:1b5:b4fd with SMTP id h3-20020a63f903000000b0046f01b5b4fdmr33338089pgi.544.1667642433589;
        Sat, 05 Nov 2022 03:00:33 -0700 (PDT)
Received: from jacob-Ubuntu (126.224.215.218.sta.wbroadband.net.au. [218.215.224.126])
        by smtp.gmail.com with ESMTPSA id m28-20020a634c5c000000b00451f4071151sm958515pgl.65.2022.11.05.03.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 03:00:33 -0700 (PDT)
From:   Jacob Bai <jacob.bai.au@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Jacob Bai <jacob.bai.au@gmail.com>
Subject: [PATCH 0/3] staging: rtl8192e: trivial code cleanup patches
Date:   Sat,  5 Nov 2022 21:00:27 +1100
Message-Id: <cover.1667641211.git.jacob.bai.au@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename few variables and source files to make it align with other
rtlwifi drivers.
The patches are required to be applied in sequence

Jacob Bai (3):
  staging: rtl8192e: rename tables in r8192e_hwimg.c
  staging: rtl8192e: rename r8192E_hwimg.c/h to table.c/h
  staging: rtl8192e: remove unnecesscary macro define

 drivers/staging/rtl8192e/rtl8192e/Makefile    |  2 +-
 .../staging/rtl8192e/rtl8192e/r8192E_hwimg.h  | 33 ------------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 54 +++++++++----------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.h    | 20 -------
 .../rtl8192e/{r8192E_hwimg.c => table.c}      | 20 +++----
 drivers/staging/rtl8192e/rtl8192e/table.h     | 33 ++++++++++++
 6 files changed, 71 insertions(+), 91 deletions(-)
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.h
 rename drivers/staging/rtl8192e/rtl8192e/{r8192E_hwimg.c => table.c} (95%)
 create mode 100644 drivers/staging/rtl8192e/rtl8192e/table.h

-- 
2.34.1

