Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D966C8844
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjCXWXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjCXWXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:23:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6362F3599
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:23:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r29so3142157wra.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679696588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NY10APJiMF6Bak2tNJJ5hJLrQp4ks52I/JpQMFq6tI4=;
        b=SGaanR3nKGyiKLdoCEL0XAbHWj2MYCnpR0QUuR62Gzcvj8ev+pKbmddccnHWpZcSvX
         SkCnGjS5Zbs8x+mcjXqCzUQ7GnCUUSsDS3OwsPV9lQNp/R47VNxRqFvRO0qGor6MXn8i
         3Ybzmi7XU5/hfBAG1IDsji//fdZXknIw0yaRVCRphHMBN0M4CAnKJ09XfFSRTjkG1H5z
         SykfNVRMkbAL4JzpMNzYEKF5SdinHbfgcRjjlFskUSFZsrpqyBnfsdx+B0Pl2V0EO/f1
         txwcMiuXn/gu3AGZHhoLCVYEHwhTAAEXBCMSZdQLgZyr0KPFlRdBqw/fo5MenNZXTgux
         4y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679696588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NY10APJiMF6Bak2tNJJ5hJLrQp4ks52I/JpQMFq6tI4=;
        b=gnnueH90i4F0W6f/P2SpWDqs5a1r0qoV4YLKoqXyIOBIFC9+ZWlmJFgh/NQ86ZILkt
         g9TxduzevrZpG3wP5VgQnJdUNCvzdj4Wvj1mNwQ23txsULpVvYpXrFzcqyfhdb0A4Lpd
         rfdEHkxonrG+rJl4wvPCdzTEVuhWsVwuDhFm8tPZMpb5Xnj7IhSOfrMm1z2yp52BOsCn
         fSlKC1vwcJQ6CXAhksMy574yZBvOrXzVDKn9HR57lXGh0/5p00gS3rnAh7fw4BGBKqku
         Nloybz6xkTlk59LJDS5NP2xOgox1FJUqhKO5IFd+UfYOYnIyDeq0A5d585Nsc6h1EM1c
         tYCg==
X-Gm-Message-State: AAQBX9ckm9he17DMDhSPEyfTKOzv67Gq0jntCYECm0UQizrJW/W/tDF6
        zAXuG3NoOib9QNJ96qRC2u8=
X-Google-Smtp-Source: AKy350YjCyNrGOXLSNzG6Y4T9xQmpvl2pHNPFoV0P4a2gkUH3zb5w/tOhVhNhk0+WbOxP/40illlEA==
X-Received: by 2002:adf:f546:0:b0:2db:9526:b6ec with SMTP id j6-20020adff546000000b002db9526b6ecmr3468603wrp.58.1679696587890;
        Fri, 24 Mar 2023 15:23:07 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id m8-20020a5d4a08000000b002c3f03d8851sm19161446wrq.16.2023.03.24.15.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 15:23:07 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] code cleanup patches
Date:   Sat, 25 Mar 2023 03:23:00 +0500
Message-Id: <cover.1679696291.git.kamrankhadijadj@gmail.com>
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

Changes in v4:
 - Changed the subject of the cover-letter that was mistakenly edited in
   the previous patchset.

Chnages in v3:
 - Changed the description of all patches in order to explain 'why' the
   patches need to be merged.

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

