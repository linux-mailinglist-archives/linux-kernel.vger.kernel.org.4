Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42986AF718
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjCGVA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCGVAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:00:55 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC97A2C09
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 13:00:46 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o12so57646033edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 13:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678222845;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a29C3RqRFTjCabKMwALBA2dvqdxdfVXnv8KYiR92qGw=;
        b=CE8MsnmDuJZhDfn00ZI2O1Y5pI6jrd07thC0NYiDNwd09YYLw6WUy9x/rq++ql2bYJ
         +Osvfx7kmCkk6LBjClBfy1cqv6MfnK6epR3nF82CaceVwkvl72ECwdS+5XPjLRh1RqpR
         Aac6MSkDI/figjyG86fruA/ttZcuvuPxPq/+0GBlRy9yljY6XOtcArUkP6igomY2dRUD
         djGO3LOwdY5akn/SIdpvPq18Nf2niMLtFOwmOt5lJUWuOApoCqr2eh/WkCfyIKFpPAPV
         blp9c8qbFsMcp8OZGl+YAS5Y8CDr/pBOt4v7xAbljBgemOMsldqWGgAPiuT6RJ7DSsqL
         GW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678222845;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a29C3RqRFTjCabKMwALBA2dvqdxdfVXnv8KYiR92qGw=;
        b=YqCOTFNJ75It8B/Bc6fHd0E1Xyp4Mk+XErE1RK11nakeA6+/Zuzj+f1HyK7fR3lfWj
         eAl2R7z6t/DQ6W9TNWL+6AWAX7YLd5euBzHyH1er67hbACgM6NqIneWxaZO4bZl5649y
         wT809TlDP3sqBjEYiMT97eJAqyVpSHVEDAhQC0TXkXHdXgVfjksbeu8w7wn6EC8BO8M9
         nfggxGPyusAx98cuOQfrzHmCOxAfVnsbiwLBx7z0KP3AJeW80/NVD3AJpdW53ItrbcD4
         jEC3tbsUS3pf6V4WVbxNqdQqh7BcEz7wVeFR4HSD9npznhILtDRh7PDzDm9eMfE2DEw8
         NQaA==
X-Gm-Message-State: AO0yUKUwuEQ/NrbuaDvekuhr2rJpiVkhX3Qepg1pk7tTlU0RQgTd2D+e
        T5M/JS9eh+z4GGgtR+NAmv59Pp294Iw=
X-Google-Smtp-Source: AK7set/ABNHMeuJ4zdcbao1bn4CWcWZWK02gYdzoTSOsmVfK6JFc3Q2JR/ygF76r6BYwwpkgh/tSqQ==
X-Received: by 2002:a17:906:5199:b0:8ae:ea08:3842 with SMTP id y25-20020a170906519900b008aeea083842mr14272853ejk.7.1678222845063;
        Tue, 07 Mar 2023 13:00:45 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id mb3-20020a170906eb0300b008e772c97db6sm6532417ejb.128.2023.03.07.13.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 13:00:44 -0800 (PST)
Date:   Tue, 7 Mar 2023 22:00:42 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] staging: rtl8192e: Removing unused arrays
 ..RadioC_A.. and ..ERadioD_A..
Message-ID: <cover.1678222487.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The array Rtl8192PciERadioC_Array and ..RadioD.. is only used in function
rtl92e_config_rf_path which is only called in function rtl92e_config_rf.
In function rtl92e_config_rf a termination condition for the loop is set
to priv->num_total_rf_path = RTL819X_TOTAL_RF_PATH = 2. The loop is only
executed with numbers 0 and 1 for eRFPath. So the function 
rtl92e_config_rf_path is only called with eRFPath for 0 and 1 and never
with 2 or 3 that would make the "case RF90_PATH_C:" and 
"case RF90_PATH_D:" be called. Remove resulting dead code.
---
V1->V2: Changed argumentation in the description and subject

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

This patch series requires the patches:
"[PATCH 0/2] staging: rtl8192e: Removing rf_type RF_2T4R from driver"
"[PATCH] staging: rtl8192e: Change filename r8192E_hwimg.x to table.x"
"[PATCH] staging: rtl8192e: Remove call_usermodehelper starting RadioPower.sh"
"[PATCH] staging: rtl8192e: Remove function ..dm_check_ac_dc_power calling a script"

Philipp Hortmann (2):
  staging: rtl8192e: Remove unused Array Rtl8192PciERadioC_Array
  staging: rtl8192e: Remove unused Array Rtl8192PciERadioD_Array

 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 24 -------------------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.h    |  4 ----
 drivers/staging/rtl8192e/rtl8192e/table.c     |  6 -----
 drivers/staging/rtl8192e/rtl8192e/table.h     |  4 ----
 4 files changed, 38 deletions(-)

-- 
2.39.2

