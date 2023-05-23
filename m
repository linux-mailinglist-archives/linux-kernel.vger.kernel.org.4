Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7A070E6B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238573AbjEWUlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbjEWUlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:41:47 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24798CA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 13:41:46 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ae454844edso935505ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 13:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684874505; x=1687466505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LeRhhfywQXFcxoHyxbGEP7jcR1uIGCUmOm50bwNMlmE=;
        b=MaRnzfgjDM2Xg/JVKVha7BPXe84PcTUfhTkY7ZK3HxxghAeMKLqp8zIXIm479DVoDc
         9bZnsX6S2Nnxn1AwOZnJIV+eBw7PpgxC08wA4vKtj4HvAfFwHj8MRAqYEWgFaTAs5KFB
         YdLE7tQz4efslV4fJKJJR2T7O+iGqxkcOfzZ98IQN+pmIGsiy1nP63hnRVNpT6CDngux
         4vCfp0fpxHUYm3ZGYFe1RmE/wPiH276BoY544hHbgGTIggNhX4Y9cOgHUBE+3RhnApgG
         sQkh0nLbcIL4OxHCrlN6IYWb7MlMWJzKeu75wtqk0MVwpgE3Ej1DwSZvyFVbQwa7k/st
         gjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684874505; x=1687466505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LeRhhfywQXFcxoHyxbGEP7jcR1uIGCUmOm50bwNMlmE=;
        b=X/zuII8Oy6j9ddgEcq4JhA32mpjTrA/2NPc6tToYPVX4Htif6EAi6NEd2mTIdK/MKE
         50tgMkIHTSbFFWJAiTwGV04mk7gtBi3Z06jXajd6bkIpQn95PdhTzNzBJSkEoiikhLWq
         uq8R0yVWVrUIlEHxIHKn1efUDZ+nuc2CH/X6GtZKOkDyA+NYNmERXS5GHz3qYef9euFh
         5ontK2UrF91x6aAUO0Hm+0CbAkV7D/uDj8tUpdTT6O8T5u6QY+qi2oYq/iIOgX0kq1Pk
         pIx8Kl20LlXrCbD8pyY7WHFQgDxVHydckBd0ckEVi9xryHnB2upb5MCzMArT/XxlmeBA
         x4hw==
X-Gm-Message-State: AC+VfDzNYgsk77RA2mTFVUftpQq1h8XMDTeaQ4OTcq9HvLKZzP89vNNe
        74VPgId2ypQ5dkWfdbjoLia/W0sVoQs=
X-Google-Smtp-Source: ACHHUZ7x1+qIGYh6yGsIYoV5nU09KQMvCkoAC67O24R1Yz6ikUwzCSJeJ5f5VxA9beeuC6msriqpQw==
X-Received: by 2002:a17:902:c20c:b0:1aa:ef83:34be with SMTP id 12-20020a170902c20c00b001aaef8334bemr14855473pll.47.1684874505479;
        Tue, 23 May 2023 13:41:45 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:b24a:2733:7b03:8e67])
        by smtp.gmail.com with ESMTPSA id b23-20020a170902b61700b001a194df5a58sm7205104pls.167.2023.05.23.13.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 13:41:45 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/2] Xtensa fixes for v6.4
Date:   Tue, 23 May 2023 13:41:30 -0700
Message-Id: <20230523204131.1898839-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following fixes for the Xtensa architecture.

The following changes since commit 457391b0380335d5e9a5babdec90ac53928b23b4:

  Linux 6.3 (2023-04-23 12:02:52 -0700)

are available in the Git repository at:

  https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230523

for you to fetch changes up to 034f4a7877c32a8efd6beee4d71ed14e424499a9:

  xtensa: add __bswap{si,di}2 helpers (2023-05-12 09:44:12 -0700)

----------------------------------------------------------------
Xtensa fixes for v6.4:

- fix signal delivery to FDPIC process
- add __bswap{si,di}2 helpers

----------------------------------------------------------------
Max Filippov (2):
      xtensa: fix signal delivery to FDPIC process
      xtensa: add __bswap{si,di}2 helpers

 arch/xtensa/kernel/signal.c       | 35 +++++++++++++++++++++++++++--------
 arch/xtensa/kernel/xtensa_ksyms.c |  4 ++++
 arch/xtensa/lib/Makefile          |  2 +-
 arch/xtensa/lib/bswapdi2.S        | 21 +++++++++++++++++++++
 arch/xtensa/lib/bswapsi2.S        | 16 ++++++++++++++++
 5 files changed, 69 insertions(+), 9 deletions(-)
 create mode 100644 arch/xtensa/lib/bswapdi2.S
 create mode 100644 arch/xtensa/lib/bswapsi2.S

-- 
Thanks.
-- Max
