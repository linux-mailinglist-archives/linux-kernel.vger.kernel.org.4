Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05634612460
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 18:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJ2QMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 12:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2QMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 12:12:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B9329344;
        Sat, 29 Oct 2022 09:12:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w14so10230267wru.8;
        Sat, 29 Oct 2022 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bwD7b9JWobmpzFsZn0Ibghwm2CFiQyb3FFiHmK/f7fA=;
        b=f+M3Y4/AGW+xVs7PHakGJ4MzDv+LeBQC00/2NNKw8cmdsjUmjQKyoVi6+PwC7FRWXV
         AODMO0bKfhKsp/8l/p1+WBqj9vZqnIb9jtkwiA8JpJT5CxBBRpxur9+0cYts3fYuDwOv
         cSMWvkRIBXf7SWSB+BwGbP1uWpVjI4mZV01dnx+4YyDZjUuekg11lrK457RpzPFb78JG
         M34n9ImNhGCakboxn2rtLRwVGnHHFTrZk5NYZnA9E+1MFHVakhALPTRBROGcbAvlV20S
         tYiBI7t8Eaq7qZmNJE4aM0L5EGtRzep5OS1LrYxlRhXaDdCeBV+qbJQ/PaBAGhMQyZdg
         BKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bwD7b9JWobmpzFsZn0Ibghwm2CFiQyb3FFiHmK/f7fA=;
        b=PqtgkNulGM4v3b7u0UMjcgjakLd7qYfG3O9j31pkGvq3stjMR6m72g4UlF0F2bFEj4
         hNNsVdJO08xccp4u4IdWC2cGW3UD4AVHmy++Gy4ulaEiXT/193U3We1tY7Rsq50v89r3
         AGno9NqNtgxXhJ/F2Zp4qtwg4CY7TmZDt77bpdt84wQ2vG8YQCpFIslez0c3g0/w5Dxm
         tp+dRaAX4ZkgOwQ+n54bSnVvDZ2g8yLWW/0uZ+hz0V9mGXnD0yXBk4CkqNyBUKlm6z0Q
         +0Knr2za05PdV6CHyzIyt1blwk9nr1S8vxvIDsZyCmHg1/Bc2FYo9OQ5DGLorsyGWLJT
         as8A==
X-Gm-Message-State: ACrzQf06pJzP0vIbB4LzlMSSpGhj7hkidU9UGoNWbaUGslSf6VXo3cvw
        FU10IRieMdmSrlYX3lxy+Vo=
X-Google-Smtp-Source: AMsMyM68/f5DRz1ePsSZSK8NTkDykqQwJFE7BFvX6pDc63vGK8ihEcWVkVywIBN64cLh4bnQJBTGnA==
X-Received: by 2002:a05:6000:11cb:b0:236:b1ad:7ae7 with SMTP id i11-20020a05600011cb00b00236b1ad7ae7mr1847289wrx.608.1667059963797;
        Sat, 29 Oct 2022 09:12:43 -0700 (PDT)
Received: from localhost.localdomain ([94.73.35.109])
        by smtp.gmail.com with ESMTPSA id f28-20020a5d58fc000000b0022efc4322a9sm1858471wrd.10.2022.10.29.09.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 09:12:43 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        pobrn@protonmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 0/2] Add support for XP-PEN Deco LW
Date:   Sat, 29 Oct 2022 18:12:38 +0200
Message-Id: <20221029161240.15548-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2: https://lore.kernel.org/linux-input/20221028081656.GA19766@elementary/T/

 - Barnabás Pőcze: Use strstarts() instead of a custom implementation

v2 -> v3: https://lore.kernel.org/linux-input/20221029145511.GA7941@elementary/T/

 - Mia Kanashi: When using the USB dongle, do not fetch battery until
   the tablet is paired

José Expósito (2):
  HID: input: do not query XP-PEN Deco LW battery
  HID: uclogic: Add support for XP-PEN Deco LW

 drivers/hid/hid-input.c          |  6 +++
 drivers/hid/hid-uclogic-params.c | 73 ++++++++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.c  | 34 +++++++++++++++
 drivers/hid/hid-uclogic-rdesc.h  |  7 +++
 4 files changed, 120 insertions(+)

-- 
2.25.1

