Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A255F6C8DE7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjCYMNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjCYMNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:13:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB82199
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:13:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d17so4174373wrb.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679746402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ioX1KgKROFiDWyqlsJs6XqlB2RrAlll5N2zukuaEs8k=;
        b=XJPwToHJkrPaj0nwPt2SyRVtFB7FXDH/Z3auEPO+Khwe0rEKQcCueB+nayuCztsgCA
         +KQuHvXruHkxtxhVBDozej0ZHpELqK81gVgsSCTFmkU4jHPDtz43nsx3LDeVy945pG3/
         q5zt0E+RDieYgCgvsXMKcB3QdKrDgGlH33J54m7L/g2SfPAi572ZdhDue23MgGeWlH4P
         rImFNc0OHQ3mr28VGhm0TCkcH1jOdof2rP9kQzP8MrIQVS9Gv99JMhEYDTS84OoNrdUl
         yG487ffsbhBWK8HBiYQO+kJnieLpcl3owxnLSSm7n0IDDsyg9GKibN4habR4uhEjAYDw
         IgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679746402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioX1KgKROFiDWyqlsJs6XqlB2RrAlll5N2zukuaEs8k=;
        b=wWnE7CtqFuPCm3H5/IIr/y0hWHEGGnxqSmGbSAtmn61tDc8pS2Zs+MD1Q6WrhbC0yS
         yH4W6z5CSYVOhRcMnon1g/G8zBh2TDg9rv9C/aCfs1EAWQ8CLK1Rqymvxt74zHeKn4vO
         SVAu54FZyQQ8+9y5Q6CD2wM7DWKo/miFF9flqzcXYx3R2e534hCwbT8zigj0k0As4kkc
         QuDf3qcyzO9+yRGQIYzEQpAVijM/eM2JSAqatnU/BlksmFSU/6V4WXKblYTirjk8NmUj
         oKGwTIZZRSebrLwXGTJV7ThPG/BQMiyuFLUfolUbGl4so47MDG6gWOrf3+Wk3NRB536i
         igHA==
X-Gm-Message-State: AAQBX9fUs6GvfjYbVeZ/om5GNL6an6mfJC23gJAq9taOURXaGS9LirkI
        yegGM8Dtt7jVgArMAYof2wKUWbrbR1z9qw==
X-Google-Smtp-Source: AKy350a2jpGdQ3Z51auHp3Gn/TpH4pAwCSuQc9o1Km/85xtDChsyfUsE2XLnWZKHa4h7BAMCM/Od1A==
X-Received: by 2002:a05:6000:1206:b0:2ce:a8e9:bb3d with SMTP id e6-20020a056000120600b002cea8e9bb3dmr5177954wrx.4.1679746401969;
        Sat, 25 Mar 2023 05:13:21 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb0a000000b002c70c99db74sm20504791wrr.86.2023.03.25.05.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 05:13:21 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: rtl8192u: clean up comments in r8192U_dm.c
Date:   Sat, 25 Mar 2023 17:13:15 +0500
Message-Id: <cover.1679744684.git.kamrankhadijadj@gmail.com>
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

Clean up several comments in file r8192U_dm.c

Reviewer feedback on a previous patch suggested additional cleanup
comments. Link to the previous patch:
https://lore.kernel.org/outreachy/ZB2a5zwYpBZ%2F6qwU@khadija-virtual-machine/


Khadija Kamran (3):
  staging: rtl8192u: reformat block comments
  staging: rtl8192u: remove change history from comments
  staging: rtl8192u: remove code from comments

 drivers/staging/rtl8192u/r8192U_dm.c | 199 ++++-----------------------
 1 file changed, 25 insertions(+), 174 deletions(-)

-- 
2.34.1

