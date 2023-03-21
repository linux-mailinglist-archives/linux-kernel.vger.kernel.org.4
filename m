Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A604E6C3A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCUTcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCUTcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:32:46 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913F2574C7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:32:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k2so17150721pll.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679427108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=34bJ9/3U+OWHFLOhl+l9+SPl3oUSFTJCPM6fMF2qXcY=;
        b=PkOTWLy/9dXyYKbkxN0l3xyf6i9YW9WXQeAa+RfGdyoHBz4+f3k6LH8EM+3vy4y6GZ
         e1sxQl4z59RwiP1pGWZtsy3OsAZFy0gnUcUTPDLB06WSOmbzlSVgGnEU9PdcevUKHZaw
         5Mbexo2BlXkeNJcN3W+xP1k7tNNebqTT9G0k1mvvq/AKr7BzV35BF945u3K9hPai//C0
         IXln8h58HWjUbc83xp4bB/xmfsKXgdKmR59S2JwgXj3R7Q6mS4pTdpY3CF+w0aJESw2B
         BEY4eNmYuFlXfA8LPsMnca3wPg7Gyz03NG0fQicYBz5Sczp0U1u8HgpI/2VNI0fgTB/Z
         PqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679427108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34bJ9/3U+OWHFLOhl+l9+SPl3oUSFTJCPM6fMF2qXcY=;
        b=PsM7P9FSIr76bSCBlCPK0xmKP9GXSJ8/aDDL7V1SjC2wfUU81Z3FoyabZtXfOaBEqE
         C5rHw6lufKZtNVclP7Pmi4ornxzyxhR+JRlev3uxuvasMzBdVLhcLRzm7VnsRenhYfYN
         8Vc69jB+YZMgL9KZ7WM7Y29r6MNeUwXPtzLRl7vaS6RKTcXaMplKE5V9Q6sBV7jCVle0
         IpTcg1AqCvDaUcC2Q2pblK5kXt0Q43L6vOqv8ee1rdSdeRzp+vAzYEA/nkLaLuZOY/Da
         RISkhwPFbmIEs6pqM3DwKQoBwAybllLzx0IFvARFOlJtV4uPD5KzLEAYIxmR4xPYecnO
         Mueg==
X-Gm-Message-State: AO0yUKWDgfuuU92t11MYuJ/1D8ri/lxrbYiV4z9Zvxta/PnXBfCw/LGW
        82eWnxG8wNj8PAU2Knarriw=
X-Google-Smtp-Source: AK7set8avUxSMJmFyfO2g4/bFXHpxxgis416xAsTca8qR49CcB4Kb8ZwGEqsakxK3tGHu2WqutPlLg==
X-Received: by 2002:a05:6a20:7b11:b0:da:c40:8d6 with SMTP id s17-20020a056a207b1100b000da0c4008d6mr3225642pzh.0.1679427108446;
        Tue, 21 Mar 2023 12:31:48 -0700 (PDT)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id d9-20020aa78e49000000b005cd81a74821sm4848448pfr.152.2023.03.21.12.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:31:48 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v6 0/7] refactor file signing program
Date:   Wed, 22 Mar 2023 01:01:36 +0530
Message-Id: <20230321193143.87866-1-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.2
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

This patch series refactors the sign-file program.

Brief of changes in this patch series:

- Improve argument parsing logic.
- Add few more easy to remember arguments.
- Add support to sign bunch of modules at once.
- Improve the help message with examples.
- Few trivial checkpatch reported issue fixes.

Version 6 changes:
- Fixed commit messages as suggested by Greg and David.

Version 5 changes:
- Addressed review comments from David Howells.
- Fragmented the patches into further small units.
Link:
v4: https://lore.kernel.org/all/20230221170804.3267242-1-sshedi@vmware.com/

Version 1 - Version 4 changes:
Did some back and forth changes. Getting familiar with patch submission
process, nothing significant happened.

Links:
v1: https://lore.kernel.org/all/dc852d8e-816a-0fb2-f50e-ff6c2aa11dd8@gmail.com/
v2: https://lore.kernel.org/all/20230213185019.56902-1-sshedi@vmware.com/
v3: https://lore.kernel.org/all/20230213190034.57097-1-sshedi@vmware.com/

Shreenidhi Shedi (7):
  sign-file: use getopt_long_only for parsing input args
  sign-file: inntroduce few new flags to make argument processing easy.
  sign-file: move file signing logic to its own function
  sign-file: add support to sign modules in bulk
  sign-file: improve help message
  sign-file: use const with a global string constant
  sign-file: fix do while styling issue

 scripts/sign-file.c | 292 +++++++++++++++++++++++++++++++-------------
 1 file changed, 209 insertions(+), 83 deletions(-)

--
2.39.2
