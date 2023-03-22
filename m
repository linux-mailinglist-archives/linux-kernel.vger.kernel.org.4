Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5956C51F9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCVRO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCVROq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:14:46 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4979233CD1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:14:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r11so75881800edd.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505284;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XcRrrM1o1UQq8TWISprUis5pEAHC0Y4qKGJ5WHoQsZ0=;
        b=KonY2/JIExqCSld+8K4woePb7VQDfSCVnpqTkC0VhwXw/6YqAlfOqAr5ZbvU3W7Nu0
         pjaxmNhJ38o+cAFURXJkkYlP8gz4vRIPMSLDzztnQ+9xqAjdxSG4itNLGYUSRNwTwSex
         //1cf8iP8PzovIC2JSIEDYYed1nkRCx3Cv8XTUAAHusNGPXIACxR0hQMQ3a2fr+PyV7x
         zWtbP0Ug6KdZ7eRJaSwI1wY0ic8mnZpETFp8p0A5s3C7uFj02eb5cT4fAk94BjX6+/DH
         GwnUqoZb5t32+ZJlTuenTo3qWyn2NeN5dYg89+xtGFHbPpQP7H7AQbIVDtXN7k4TNHNV
         uQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505284;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcRrrM1o1UQq8TWISprUis5pEAHC0Y4qKGJ5WHoQsZ0=;
        b=pQqABWRX+AeECkZd/kupWw9fyA146XzaTT7IhGcFHCXDESn3FDRB9P9B4+OZoL+8Zx
         1zBTLr+PWCy0D3VBb/C7hDywM60anNnq6dfP35vXp07HbGWXDy8loYlARkQ5ST0HE11H
         IDMT9Psrs5KFCkJyJIAjrBcVoxt/xeFMqHaU0wGlmwmmLTBiKk6lZa0GfcJASMeG9Zmo
         3yC1rItj6hnw1s1VY2ZnDer7rifRE1Ho53Px3/xWanpcsngU6JWqRtm3Lo441zULK0mt
         EbWhNqJj9UVhqg7a66GZvQs9PTK5A8IPaOTbdTsRRPQEz22cUYZSb6gVJplk+L26fEln
         5eTg==
X-Gm-Message-State: AO0yUKWUFQQo7mybToY626e+xAjszzxhy6sGtCajyM6BigSHI8RNsXn+
        /aYgYa5CrwLqu11Yffcz4fk=
X-Google-Smtp-Source: AK7set+cTsLf78XXHmmC57WantiM4qBchFDo5bjaTIxO2aVFOHTGZ4MG/+rROpcg2y01ea93YTCJEA==
X-Received: by 2002:a05:6402:524e:b0:4fd:298d:4f26 with SMTP id t14-20020a056402524e00b004fd298d4f26mr8402079edd.3.1679505283730;
        Wed, 22 Mar 2023 10:14:43 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id l6-20020a50d6c6000000b004af62273b66sm7990922edj.18.2023.03.22.10.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:14:43 -0700 (PDT)
Date:   Wed, 22 Mar 2023 18:14:41 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] staging: rtl8192e: Replace macros in r8192E_phy.h
Message-ID: <cover.1679504314.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

Remove unused variable or macro or replace custom macro with standard
kernel macro or function.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

V2 has one patch less as it was already accepted.
---
V1->V2: Changed subject lines to be without “f.”, "m." or ".."
        Changed one description from standard function to standard macro

Philipp Hortmann (8):
  staging: rtl8192e: Remove double defined constants bMaskBytex and more
  staging: rtl8192e: Replace macro skb_tail_pointer_rsl with standard
    function
  staging: rtl8192e: Remove unused macro queue_delayed_work_rsl and more
  staging: rtl8192e: Replace macro INIT_DELAYED_WORK_RSL with standard
    macro
  staging: rtl8192e: Replace macro INIT_WORK_RSL with standard macro
  staging: rtl8192e: Replace macro container_of_work_rsl with standard
    macro
  staging: rtl8192e: Replace macro iwe_stream_add_event_rsl with
    standard function
  staging: rtl8192e: Replace macro iwe_stream_add_point_rsl with
    standard function

 .../staging/rtl8192e/rtl8192e/r8192E_phy.h    |  8 ----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 38 +++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  3 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    |  3 +-
 drivers/staging/rtl8192e/rtllib.h             | 15 -------
 drivers/staging/rtl8192e/rtllib_softmac.c     | 23 ++++------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |  3 +-
 drivers/staging/rtl8192e/rtllib_wx.c          | 42 +++++++------------
 8 files changed, 41 insertions(+), 94 deletions(-)

-- 
2.39.2

