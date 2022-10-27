Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072B660F329
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbiJ0JGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbiJ0JGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:06:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C047E5B07D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:06:01 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id g7so1456572lfv.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pb7xGr5fuIL0NtgblTv6xk3hHUrL7glkJIQ1IQxfKe0=;
        b=jLSWcMzrSk/mqEfzXQZjeid0ZwoWYAz1FTuDTp+7XVyQaSLobdU/+LjtKZMk+LSI++
         U95kA/OZrU6OBs9TKnAUQwXCQ27GFtbkfB3+m8WW9PLT5CC7+lh5cNwZvkIztGwgIoSO
         AQ9QVAQEwNvyiE4ez3Q85GI7CyJF/4w4SldN4by45idAz1Y6Ll94tb1QLZn7W0AAdGmq
         S1zfIfidXOsQHq4pNbmweXVSeaSt3VdFos7Oo+Z0ljVzawpeq6Jg0YNrEabxmFqomM+V
         3N1WMSOQ096/F0Pm5Pcob8lclKu1Kqae9MqbZNRhm6i8KdNn/m4YMwD/E5vWytYqqvQs
         dzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pb7xGr5fuIL0NtgblTv6xk3hHUrL7glkJIQ1IQxfKe0=;
        b=A66RUtc/FvklfR6zA1m7gtuXLhb8BbTqCewbmwg3vynnJO2oN+YUShQPx7nFGWAdr/
         ARHyptulInEP3W49e9sQtwRoUyZ0olEApnpQqcdLnh9xD/vo/pclMp2WMTU6Qs8iUMsN
         ONv5DXq6v6mOcthWHb2Zp52lRVWIewu8h0F3parN3DDzaKMrAgbRt/5zXFAttffHUJ4g
         1NtiA2Krw/M7vOuHFVvZjjc33sArPRoyh5s0Tin0k2w/4UYlC5x8SjS9O8YWTUo03t4k
         g76yHE87WenSnJ2ZIK+cUrH1TuyOXfHsSCH3H7BfKH6I5tXc14Q2F2QwaxGJkqo22Jki
         2S0w==
X-Gm-Message-State: ACrzQf3sF/b2lKT+wp+/ukj9i/OQof0nu8FvmWNZcuI6RKlz5Pga80OQ
        1TzaBv1F8VlYdrr8NSwsFjhqwEjtujPNUQ==
X-Google-Smtp-Source: AMsMyM7N6TxNy+/Mr3NYgX7nR3Jit1vP2BXCodMzldTEl/RHwqQFdCcWjnzzPthI6c6QO14DHKMwIg==
X-Received: by 2002:a05:6512:2a98:b0:4a2:d66f:c57c with SMTP id dt24-20020a0565122a9800b004a2d66fc57cmr17088367lfb.506.1666861559033;
        Thu, 27 Oct 2022 02:05:59 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id d9-20020a2e96c9000000b0026f9cb6d10fsm153273ljj.45.2022.10.27.02.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 02:05:58 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v5 0/6] staging: vt6655: a series of checkpatch fixes on the file: rxtx.c
Date:   Thu, 27 Oct 2022 09:05:49 +0000
Message-Id: <cover.1666849707.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fixes are similar, mostly long lines splitting. I had to make
serveral patches to ease the work of inspectors

v2: fixed a compilation error found by the kernel test robot and
recompiled the code

v3: tends out the error persisted in the second version. this version is
a correction of that

v4: did some corrections as recommended by Greg KH

v5: shortend changelog comments as recommended by Greg KH

Tanjuate Brunostar (6):
  staging: vt6655: fix lines ending in a '('
  staging: vt6655: refactor code in s_uGetRTSCTSDuration
  staging: vt6655: refactor code in s_uFillDataHead
  staging: vt6655: refactor code in s_vGenerateTxParamete
  staging: vt6655: refactor code in the rest of the file
  staging: vt6655: refactor code to avoid a line ending in '('

 drivers/staging/vt6655/rxtx.c | 542 ++++++++++++++++++++--------------
 1 file changed, 324 insertions(+), 218 deletions(-)

-- 
2.34.1

