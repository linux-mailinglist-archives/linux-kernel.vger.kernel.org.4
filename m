Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E79F60EFBC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiJ0GBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiJ0GBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:01:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654D3786F5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:01:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f37so702819lfv.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pb7xGr5fuIL0NtgblTv6xk3hHUrL7glkJIQ1IQxfKe0=;
        b=B2FHC86YAHuUPEPnk72ooTJ6542hsi9NToF8YQGLWNSWfWJTu0H+QxT50J5t0vfG+C
         aKwjSJYOa0+GIEXLvwbeEKTDJnltdlF5AYfc/E6GCoFZx/IvllRqJZ9Sgpk+sRWjBGl+
         9xrDeRuu3ZdRgthgB7eOYwfU1kZYVjzaReKx0faJaTMGd1OPwsumlnk/sbFZjUhDKjcI
         EWZ+KgUfJQQXMAAeJZy//IDeV8NlcOpFnHc/OuzETfFd7otDCCOlLWYBGfK09qR9BaFE
         gah06LcZJmFayxkfGWN+0WSjS7nEq8t8T032EaruhwZanl0aQ+EYHvl6EG7npFpoW0Ir
         lceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pb7xGr5fuIL0NtgblTv6xk3hHUrL7glkJIQ1IQxfKe0=;
        b=m3u5YI2QnOZMn15s6vjOk+kKwWW9c/l0RUI+M/hdOBdPxHWs1EWKaGBIQ74bVWREcx
         nzwGsb7uq9SxOTje9qptCoVX2F75fI0Nb8SpqfVEhKisu69tzP0QPa/51nG6hlIS4oef
         Nsa/39wg0lAVZJdnAFWzTjQWvF7jirQnpugZdTnXzfGDPfomIV9D1wnAikTM+O1WgW5c
         Qq0RkTaLuOxt1tGI86POdGk849mZUjCru7Ou/rKIa1dOQe3SbIoIaBx0eOxQoWEGxvLA
         u2zIJocbWc4vNfj7cVuH3S/PDXBzXD0cMshDV2TxfYDHenK9VRJchHqK6zYghvmcRMo8
         2Inw==
X-Gm-Message-State: ACrzQf3BN/WfO1IAsMsFRo6/prqOZ9oLLWkPogmsS2Iyse5d+4d4F9x0
        +ETcrfnNZxFG/HFF0i5DV38=
X-Google-Smtp-Source: AMsMyM6jL5UsUwxEgYclp9Exq7z/A9Gr+3ib1fHe0h2dM+tzH8NG0E1r0eMO6rm5UPzWF6oNE77wvw==
X-Received: by 2002:ac2:50da:0:b0:4a2:44dc:b820 with SMTP id h26-20020ac250da000000b004a244dcb820mr18045843lfm.316.1666850498631;
        Wed, 26 Oct 2022 23:01:38 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id j3-20020a056512344300b0049fff3f645esm61537lfr.70.2022.10.26.23.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 23:01:38 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v5 0/6] staging: vt6655: a series of checkpatch fixes on the file: rxtx.c
Date:   Thu, 27 Oct 2022 06:01:24 +0000
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

