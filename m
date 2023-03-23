Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0706C70EF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjCWTUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWTUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:20:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97448A56
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:20:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eg48so91088959edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679599206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JZr1Ijlukfl1tsPFSXdSVz01ek4cKP2HaY1FmMiyzFM=;
        b=Q2Yy1Px4+xgzAEvQtzE6shkKlwSbIo37r5g16hVfBntNEfdX3LA3fJ6Z4h22SQ+WnD
         7pbdreOgEg9xamVXjOKljOM95Azfgltdc8tH0HE51L4Uw2txVhZVa+TeldJhCVxTFubU
         mrlSMfp6ajGOY7fay7aGvnFnrtyYfLT6UW36nlwslr+b+SSQeVd5ADyI6/psa5PbWHeR
         9SHnkEppGWUQ6PiYo2OzQUvOiYpHw0wblkMYmOvcmqGR+jB6e2++RrpRZNpOcwbKLe4v
         Bk+rS21nTWuimy+Ng3KiGYY4Y8Jjpz8/SKbdxTcsZM6ClR50D8uERdXifnpT1eeiNutm
         clwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679599206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZr1Ijlukfl1tsPFSXdSVz01ek4cKP2HaY1FmMiyzFM=;
        b=5lkcRtfwKFh8ertjnMEx6mufftOofpr5q9d9TIoAjA6jFO+HnUYfKVuhMqy7lNtTbw
         HUeISV0e3stxdoyKpyLWdCMiWljfts0JywKG4CvUTVmhOBGQ+J/lpAEKrYRtBLJmc7zZ
         t/ampe5+86ZbPZpB12d5Wb3NxDY+Spt2JjEq/IUrIWia0OxBmYkQdeSkV85Ebl3ep11U
         zklF4+mMQJFj0xaxlexR49vqLpjOgSaQG1uwpVQXb3iFzjzavvfwS5So4/deAzewwyiA
         R0lDI64eN/psNebK+3No3iJ/tY48PxyQx374k37d9K06X1GwBDo0e/3kd3mCyMeCQDmT
         B+bg==
X-Gm-Message-State: AAQBX9dx8B3v7Bp7nQXZzf6WXF46ESQifOQGYfpmYWgRIMIdBHI5D4he
        xdIGksha/D1Do8JUFnVXAKo=
X-Google-Smtp-Source: AKy350bBHTF9pI533SDCueO0sqE8C7PMX/vfJVHZsPciPw1gYWrEYkv2l9xFhUXdCyFby7O4dkDCAA==
X-Received: by 2002:a17:907:8c0c:b0:92f:17d:4438 with SMTP id ta12-20020a1709078c0c00b0092f017d4438mr151802ejc.47.1679599206300;
        Thu, 23 Mar 2023 12:20:06 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id ia9-20020a170907a06900b00932b3e2c015sm8161409ejc.51.2023.03.23.12.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 12:20:05 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] staging: rtl8192e: code cleanup patches
Date:   Fri, 24 Mar 2023 00:19:58 +0500
Message-Id: <cover.1679598576.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Fix several cleanup issues reported by checkpatch.pl in module
staging/rtl8192e in file rtllib_rx.c

Changes in v2:
 - Resent patchset with the correct email address

Khadija Kamran (4):
  staging: rtl8192e: remove extra blank lines
  staging: rtl8192e: add blank lines after declarations
  staging: rtl8192e: add spaces around binary operators
  staging: rtl8192e: remove blank lines after '{'

 drivers/staging/rtl8192e/rtllib_rx.c | 73 +++++++++++-----------------
 1 file changed, 29 insertions(+), 44 deletions(-)

-- 
2.34.1

