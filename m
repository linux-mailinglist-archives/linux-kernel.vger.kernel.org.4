Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75AC605559
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 04:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiJTCOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 22:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiJTCOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 22:14:12 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2A5165CA5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 19:14:09 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q1so17916621pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 19:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5N94fzUAOl+Ja3f+p9Lirc4wrF3q7tN7b66toKsjsw0=;
        b=da60Gj9c/cgvFyKZEFh8aFGLUH2ur1pvmBK8/jrnB1odgzr8WUEHNhHU0PKP8p3WzG
         VjNjDz74Ufo8+pC6c42iu8GlNTLx7n+oGy90QoQL8uyUPb9LIVv8dHv8HCfkQ5bdZyGi
         sx61pfAY5xib0OyrO6RW9IYRhp0ZJCX/UwR8nDmuw+j6KGCin7PrU7jm4ETKGMBTeVtN
         tuuXjVtWye2N4FTAENKv5IPJITiMTEGRHvkbqHqHgSQXQv4rynpzI5RqNSe0tP1nroFB
         9z7Hay5YhhYZaMhNQR2b5+FUO8QOAU1+4O3rnrDhJA0iwnX9CrZtlTIPEjsghV0IHwGD
         JGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5N94fzUAOl+Ja3f+p9Lirc4wrF3q7tN7b66toKsjsw0=;
        b=RdfaPppqhmSQleA6kSdWC7lLasDTgOygjpY0miMC1iLtp4AmhR/UqwbAy/Xvxqx63a
         zE7RU2kXpTRbqHLC1YoYDaHSu+Csi5MWOq4jYCoJedDyM0z74kXVsl7PtIblN+nV5Cke
         PntJjV7MzSjywuxf8pbZvGw4kJNzzsI7He3tSPD5tm/l6jF5Px43md3kTBhKYAENAJq3
         Zr6fMRvTG5a0ePtOLGPnbQYiCwX3/5P2+QBX/ukOx5cMQbdW85HIW0yqrf5Tk/sdQEq6
         eyphmtVRuAOCR8g3LMzfBRHkRXyNNDtsNu9Kud0WIODhrxedgvhYvk9GvRbDqqoLP9YI
         +ZUQ==
X-Gm-Message-State: ACrzQf06D1Vz0X8LjR3qSLOjeVikQ5Xlp8p8thftL47ngLdkg3q2YBiQ
        M9y4RMrLH5Ff2PApG6xuv1Q=
X-Google-Smtp-Source: AMsMyM5hTKqxlD78BqZ9YYfWEajIHz1TwhkjSjLku0P1swsgSGS4WiVB+AYxvNFiB7kcBEIxXPH0SQ==
X-Received: by 2002:a05:6a00:1412:b0:557:d887:2025 with SMTP id l18-20020a056a00141200b00557d8872025mr11545210pfu.39.1666232049122;
        Wed, 19 Oct 2022 19:14:09 -0700 (PDT)
Received: from localhost.localdomain (192-184-163-51.fiber.dynamic.sonic.net. [192.184.163.51])
        by smtp.gmail.com with ESMTPSA id n18-20020aa79852000000b005631af4ece2sm11942936pfq.182.2022.10.19.19.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 19:14:08 -0700 (PDT)
From:   Emily Peri <eperi1024@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Emily Peri <eperi1024@gmail.com>
Subject: [PATCH 0/3] staging: rtl8723bs: clean up driver code in rtw_ioctl_set
Date:   Wed, 19 Oct 2022 19:10:50 -0700
Message-Id: <cover.1666230736.git.eperi1024@gmail.com>
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

Created patchset to fix all checkpatch warnings in rtw_ioctl_set

Emily Peri (3):
  staging: rtl8723bs: fix white space warnings
  staging: rtl8723bs: align block comment stars
  staging: rtl8723bs: remove unnecessary parenthesis

 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
2.34.1

