Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685EB6D36BB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 11:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjDBJwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 05:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjDBJwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 05:52:06 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A092BEE0
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 02:51:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h8so106301404ede.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 02:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680429099; x=1683021099;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2IDvEqK40hdfeaC/5vcKlzJ8ldccO8ZyOrtbI8/UQso=;
        b=bYGfDEJghpcBi7i4yza2Phq8tCEBxOpVWp2cGMeFpQgVy9Jw8azJbFwW/GVLDkVeiM
         borWGvtXbfTdFgmyENPaFICjo/Bx76xoh+Xx4nkNm8QvzsI8Bho0S2ARYp8h3XnHdpiV
         67OplqowEnZh2w+UvJPZEVBta2ARLiMU1aS/Z3QeB7Y/N72b55D8qrgLHPrIVHh6WjVp
         pGwWw9m0jxFXus57lfO5QNUm5pBaWFdx3p+7zz/0DbFuuE6Ru5TRxSYQO0ptGTs8cZFG
         bRjwXRPtdFmFrCMje8GYPiuMcrhukdmQdh20OdKovDvIApqD3zuzT20i1pwRVgR7fMxY
         91LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680429099; x=1683021099;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2IDvEqK40hdfeaC/5vcKlzJ8ldccO8ZyOrtbI8/UQso=;
        b=eI27DDP7vgzbudEH347LxJp5ATJO7XJg+mnQ8gnB4yr3yxGX3cpZWnCIbnpxjAzmn3
         YaCxNVBvKp2gggRYP/estTqVIfWCMWYbo4j4wM9WOukeaaSrWJ1q59bfnRjNghEHs7ru
         cPyuKLFjWN/G3Kq53c6ZJ5z9p0yVTJNytvBLT5w+VId0tCdm3ac7SZpjXizyQl94rEmA
         CkWNPmnXsNrYSazBd/kudodgPjaRy0XoOwHzS/NyjjsmjsenQ6fSuDi+S+v5/DnDAY/a
         u9HJHaSnWblc+sAqaixJtfDFbcKvAeBgZbf/BxebXzSQ5j4i5eIMrnZ+Z6lw5EbyL/RN
         YtBw==
X-Gm-Message-State: AAQBX9chflIyoO3843czySaymtCpQ76f4UHPbhDK1WmKO/8VWGuOWUi+
        YFNipjelcBgG/cjuwJmzCE3TKy9hBsc=
X-Google-Smtp-Source: AKy350a9MsvkMpzvVI6Nn+Qh5M6t4iuNAkNmgQeVoknnM++Kmh0S2kpecy3A7VgcwD/0rh5GAM24dQ==
X-Received: by 2002:a05:6402:2803:b0:502:e50:3358 with SMTP id h3-20020a056402280300b005020e503358mr12854788ede.3.1680429099044;
        Sun, 02 Apr 2023 02:51:39 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id e27-20020a50d4db000000b004fadc041e13sm3085852edj.42.2023.04.02.02.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 02:51:38 -0700 (PDT)
Date:   Sun, 2 Apr 2023 11:51:36 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] staging: rtl8192e: Remove enum RF_1T2R and useless
 cases for customer_id
Message-ID: <cover.1680427945.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove enum RF_1T2R as the code using it has always the same result.
Remove useless cases for customer_id.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e
---
V1->V2: Added first patch to avoid a useage of an uninitialized
        variable RF_Type introduced by later patches.

Philipp Hortmann (6):
  staging: rtl8192e: Remove RF_Type from
    .._dm_tx_update_tssi_weak_signal
  staging: rtl8192e: Remove enum RF_1T2R and RF_Type
  staging: rtl8192e: Remove local variable Value and powerlevelOFDM24G
  staging: rtl8192e: Remove case customer_id = RT_CID_DLINK
  staging: rtl8192e: Remove case customer_id = RT_CID_819x_CAMEO, ..
  staging: rtl8192e: Remove case customer_id = RT_CID_DEFAULT, ..

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 26 -------------------
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h |  7 -----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  5 ----
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 21 +++++----------
 drivers/staging/rtl8192e/rtllib.h             |  4 ---
 5 files changed, 6 insertions(+), 57 deletions(-)

-- 
2.40.0

