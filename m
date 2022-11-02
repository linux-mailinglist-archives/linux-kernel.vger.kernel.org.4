Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691F961647D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiKBOJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKBOJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:09:15 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CFAE00F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:09:10 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j4so28476144lfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 07:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xqbSRM0xN3ReIDpRy+VRCD5PHrzF50Z7Q5uelUzp7aU=;
        b=nmw26d55ePaYauwNrDIpXKG/7dnVoq3P2mbnJGCihMWimVV1W3X7U70oo4TnfM9ENT
         eAmeFiQkaoFe5G/K0WaRzSO5wY05MSF5rz0PXcNEJjZMD5yDjZDfOCtUtQN80PQdFCco
         77BnjkxEOgbJczlZtTVPjEM9gfVAm1cB57pyYVLglbldsbSvwRn5ArmTQLstEANbWRZN
         bfLT5Zswhb5q+jfQQcZEFE4wV6s6JkpGDIoyv6IAbsHOCIxHI0j1DYsApl/BF0d7ONog
         sbxs/2C+Wfs7gfAnt3OKxPRKqHPKk85ynuwSqObV9iHpLeqohcA0BYkyDpWrZYoJTFFw
         US+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqbSRM0xN3ReIDpRy+VRCD5PHrzF50Z7Q5uelUzp7aU=;
        b=mxxI8EiydksUnuzB5BWDlfaEc1kUr6HE5jK1sbwts3dywuHyJAnUOsw2puy+eLMXm/
         +7Z4utWED6FqrpIPS5AXUiAuvTk41iZ004D91uXEgbKzou+3yogmf7fVKNAzmJprkTeV
         sn1YASikYE8goNxHzTnl17J8QjxYme6nmZbHjvd4fV3nRAZ0AKrkOlZr3gPT/rZVlLhy
         RO188dUkFoWIJ7S9Zzah2fHYAVN52vEPOuYISW694nzDYAZwqOiEjy6cUGN9fEZcwag7
         sXOJcYtf2fcSukQEyQA1pvRY5xb+qKNvdC4s0fPgx0+Ku2GsbtgOhRfL1xY7WdWpYmui
         phTg==
X-Gm-Message-State: ACrzQf2UO4Wns8S6a6WPo6pcyK/D4lfqFl4K90fhA8dKrAv8VRuZwEcg
        aj05pCCTm6mQMI7G1GB6PX4=
X-Google-Smtp-Source: AMsMyM7Otr+qYHHnuPGjYtUz9lxKs430Sk37Vcw+UPQX0wfI8U4+jGcfxuROkWfRlAGGVrKZRiPWew==
X-Received: by 2002:ac2:5bcd:0:b0:4b0:d503:9afb with SMTP id u13-20020ac25bcd000000b004b0d5039afbmr5046056lfn.13.1667398148363;
        Wed, 02 Nov 2022 07:09:08 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id bj12-20020a2eaa8c000000b0026e0434eb1esm119503ljb.67.2022.11.02.07.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:09:07 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH V4 0/2] staging: vt6655: some checkpatch fixes in the file rxtx.c
Date:   Wed,  2 Nov 2022 14:08:46 +0000
Message-Id: <cover.1667397591.git.tanjubrunostar0@gmail.com>
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

These fixes are focused on the function s_vFillRTSHead

v4: rebased by codebase against the staging-next branch of the
staging.git tree

v3: changed the function name from fill_rts_head to fill_rts_header as
head is conventionally used in lists

v2: changed confusing changelog messages

Tanjuate Brunostar (2):
  staging: vt6655: change the function name s_vFillRTSHead
  staging: vt6655: Join some lines of code to avoid code lines ending in
    (

 drivers/staging/vt6655/rxtx.c | 48 ++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

-- 
2.34.1

