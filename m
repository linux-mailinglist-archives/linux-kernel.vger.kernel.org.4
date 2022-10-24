Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD36609E71
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiJXKCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiJXKCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:02:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D54355C55
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:02:02 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g12so5329560lfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dbc9+ZJrZvJ0IrLyQ89n+PqwdOcGQExwOrzYsD/fuLY=;
        b=kQrqxJlWe+DlZbyTxFm/764ugetvgYDPWKrAOqJ287D/lQAQg7teJsFfY0om+S2R1j
         +1kx+HBEJxybLZGOHbyDFRd0tfcFwFjmPYbVWxkmgqm0Sz7YGknr+Mn00azS2vgrV604
         8e6ZGWeU2wf4ZFGv2IaP7YiVNUeXiZK7vRYryuO9KYeEqG9sx8IOf8owGM5gEiYA1N0k
         qv0/cgfZJaky95YcTpjJM+V3j7YZS+8hs98IE9IjCdgpLiq9Wc+1wvepA/dNl7gsUbZw
         UYIlrTFthrlKi5epCEghUjezeTl1IFU6FfuMkwGMrrlMinNw5Sbkp2RjGQ38557vCDbS
         q7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbc9+ZJrZvJ0IrLyQ89n+PqwdOcGQExwOrzYsD/fuLY=;
        b=EsGKWD7Si1BeU3F8KffFJu6dT7MpFanJQ4M0hHid9SHwRmUM/mKcrI+NTy2ZYAz95w
         F024UeA/XDj3XmqUHAPBMV0gtiijpJLuG6BcgfBZI4ADaYF8gFP33m7c7bX9jBRwwVbR
         EZXZS32qiOU2K4Vhq8U3IdDPuuVvR8HDg3Yf6IFrmlYgcNpIiAGlyPOLhti7tPqrMy2e
         p/JgpwDp/d46aTZmk2ymxtUkrcm7yrn+EAgXkTlgH6TI4gJg2tYWMU5iwzwhDm96jxHS
         aWUB+R9wiFejUJjEzVxI8A8PZp26fAM7b2kO8Q4SI1JVPpMTB9HJSVDiGICsMl5M1r5A
         2m7g==
X-Gm-Message-State: ACrzQf3Qn1wiUGoDYNhC8xZuNW80HPeggNWAAAC5frMSHu0O/zWsPWQK
        FZq3g9MIkxBRCphFSQ8fLCI=
X-Google-Smtp-Source: AMsMyM7x7awehaAYAW35nFwgrGYz2wy/DYOyRlwiTLVMVcYsL5TPOx0o4Bd7JqMAZHmmE19fH/hgSQ==
X-Received: by 2002:a05:6512:1156:b0:4a2:7e73:1f28 with SMTP id m22-20020a056512115600b004a27e731f28mr12837855lfg.38.1666605720226;
        Mon, 24 Oct 2022 03:02:00 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id s9-20020a2eb629000000b0026dfbdfc1ddsm4896832ljn.11.2022.10.24.03.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 03:01:59 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v4 0/6] staging: vt6655: a series of checkpatch fixes on the file: rxtx.c
Date:   Mon, 24 Oct 2022 10:01:46 +0000
Message-Id: <cover.1666605225.git.tanjubrunostar0@gmail.com>
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

Tanjuate Brunostar (6):
  staging: vt6655: fix lines ending in a '('
  staging: vt6655: refactor long lines of code in s_uGetRTSCTSDuration
  staging: vt6655: refactor long lines of code in s_uFillDataHead
  staging: vt6655: refactor long lines of code in s_vGenerateTxParamete
  staging: vt6655: refactor long lines of code in the rest of the file
  staging: vt6655: refactor code to avoid a line ending in '('

 drivers/staging/vt6655/rxtx.c | 542 ++++++++++++++++++++--------------
 1 file changed, 324 insertions(+), 218 deletions(-)

-- 
2.34.1

