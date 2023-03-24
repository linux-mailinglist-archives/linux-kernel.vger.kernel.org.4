Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892EA6C881A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjCXWKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjCXWJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:09:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C03BC2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:09:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y14so3153433wrq.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679695796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=USbTBCYF1HNNMAtJA9NJ2/IOkLBi/b3sc9VKyACjb4c=;
        b=fwge5bR6v99Y0QrwnYlMDGT4ggqNaRSow5YTBUA87SFirsX8WsC27jw1z+grW1ZUUp
         8XgoK0yIxNwisvl0T3XNo7EAlXinSXlDf5dglMGKCUxWyjjodhp6KgZUaWRFi/JalP2z
         kjnXuDXYiLhPlCS41duSULPiR80P5Hs0RIiMzeXvHHSK8SwpdAhcFvRbviZJ/W80cz6A
         EuTOi8LRvWnHKyCoSEignwN6q/IVwjCvMLw116d8EuopfqIUYU1G0rHd2P1AZAwETzDQ
         b5f1kHHX07zDJp2qsYdTye/FFGGKN9IqYjpHlBY9cPqc4sqCYzCHASBjXOT4+XaR06nB
         zXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679695796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USbTBCYF1HNNMAtJA9NJ2/IOkLBi/b3sc9VKyACjb4c=;
        b=zQOFeWU/QlXxsBj18iqcWS+T2b/GNOXZhFP6qwQeUbfBgTdvPV6bEbo5IPg9RGcjb6
         tr959AO+WNN7PuMKqkzOBryscHLZPiqzNhw4OUY+qdYoZzCWk0LINEwyT8Di5p0+Rkul
         AR1STm/UCXeKbQ5nS9ALMBD+GTf1Ip6JRgA4Mpkx725Sp3lbcn8a/MvcUEG7tPi4ZcTo
         vWA4XbvYxhluJKHpOtMcDxSlXt3jrK/Tn6Vzj8Na9oVkD7Tpc2Q18ru+b4WtKLl/bYUg
         VOdlhxxd/kR6H5ERkmwUpS6YLTRBD1YRI6S+bArw5lu+Gg8OalfDCVJMiWn+fQm3lSNl
         vrRw==
X-Gm-Message-State: AAQBX9egGqrbpk0Ip9P5E/2O1t0eptiqjZGxxC7ADPaCmUZ9b/Xji3K1
        8Z3ShZOmiBsbJFhuSQnwL7mUqkp7Oji84Go4
X-Google-Smtp-Source: AKy350b8zE0a7H4cpIO1knYUDPqHWz0Bzsssq9krcM/qr+iVi98Yqf+coYq6web5QM6fEaKc05PaNw==
X-Received: by 2002:adf:e44f:0:b0:2cf:eb86:bd90 with SMTP id t15-20020adfe44f000000b002cfeb86bd90mr3626034wrm.63.1679695795784;
        Fri, 24 Mar 2023 15:09:55 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id x12-20020a5d650c000000b002c5544b3a69sm19201736wru.89.2023.03.24.15.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 15:09:55 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] staging: rtl8192e: remove extra blank lines
Date:   Sat, 25 Mar 2023 03:09:47 +0500
Message-Id: <cover.1679695111.git.kamrankhadijadj@gmail.com>
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

