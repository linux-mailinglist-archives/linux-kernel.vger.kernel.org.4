Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A5B726394
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbjFGPBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240878AbjFGPBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:01:37 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236471FD8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:01:25 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-52cb8e5e9f5so523867a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686150084; x=1688742084;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8JScWWC74+BsV0fJcjz9vzitBceUwIm3AIsd9TVMHHw=;
        b=U6E3/1M8l5g0rXH+m2pQJSyRDyBkwriKf2tZoQqW15ghveXyC/SJYouKOWYJnro7Jy
         YH9TXxyKnPA5QDvxF19Xg+nEWiOo5reX5dzSF1jT3A49/0Tm2gKpfc8jh/mDqc8zvzhT
         kErXjXmX/NdqHXdOk5EWKL/Sm/Ki5KU6WSkdkzHrtNDu6BUxZz6+wqDj/J5B3O2TD1BH
         EVaPnqM/jK03Hxrlomw7aJnP4RYed1r9JcjcTBgDg6N/dAJvlDDoNnUKOmbDBDhQUq4g
         9qaljs0lhDQitF/jGmH4wJTN9YXO3w+Gnv6OoadQ+GPP5yyzI5S/nb9L6EvNbDuch25a
         Kymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686150084; x=1688742084;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JScWWC74+BsV0fJcjz9vzitBceUwIm3AIsd9TVMHHw=;
        b=EtWvQiFpq6mKR4WcAj2KxNUAWJ9lB4iD35Pk/Avz8MmpCQugQJx4NK/eBYjdcrsooJ
         gMDJQMQlJ8z0+gANJG06lNHRTz3UKLUZ5iJToMYpxy/xPSvayinauPIKCV71SaHlHIvJ
         1B3O5BuCU9CPFPvl20FPVQuAZK4BzTLoNqxQWMMpPz9k57UPZkkwZXIYVcKpwn+syOf2
         mQihEbHLIrKulGjxpS9BtK+XI2DD31AQ7FVALFyF7iVNc82NbEqYMMaS1QTfJ2rJUgEM
         +z36+jPy3x2lvKDCS+zeE3kjdEMpJnDmoRjL2ThIQtU+k+hoBnyx77+I5t19rT0u+fWz
         wiDg==
X-Gm-Message-State: AC+VfDx7ASiGhZJnUmOtjZmxtL/93GMekXkfpEjo908u6OMRiYIjgTHa
        Pdf5rXUMzYK4Tg07t7YsFmUhvLE3DN8=
X-Google-Smtp-Source: ACHHUZ4f62IWDGnTIlEDm2TbAF3TDmsh0zSXUt/EIJwKm6wuPNLpb07mrX0Jm91x/4R2/0T9SNTdWw==
X-Received: by 2002:a17:90a:199:b0:253:2816:2a12 with SMTP id 25-20020a17090a019900b0025328162a12mr6682116pjc.14.1686150084136;
        Wed, 07 Jun 2023 08:01:24 -0700 (PDT)
Received: from yogi-Zephyrus ([103.251.210.211])
        by smtp.gmail.com with ESMTPSA id 27-20020a17090a19db00b002568f2f8102sm1574901pjj.30.2023.06.07.08.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:01:23 -0700 (PDT)
Date:   Wed, 7 Jun 2023 20:31:19 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Trivial code cleanup patches
Message-ID: <cover.1686149467.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches remove variables in the struct rtllib_device that were 
set only once throughout the driver. Instead of using these variables, 
the patches modify the relevant code to directly call the corresponding 
functions, eliminating unnecessary indirection and removing CamelCase.
The patches are required to be applied in sequence.

Yogesh Hegde (5):
  staging: rtl8192e: Remove variable SetWirelessMode
  staging: rtl8192e: Remove variable SetBWModeHandler
  staging: rtl8192e: Remove variable LeisurePSLeave
  staging: rtl8192e: Remove variable InitialGainHandler
  staging: rtl8192e: Remove DRV_NAME definition in rtllib_debug.h

 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c |  4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   |  4 ----
 drivers/staging/rtl8192e/rtl819x_HTProc.c      |  8 ++++----
 drivers/staging/rtl8192e/rtllib.h              |  6 ------
 drivers/staging/rtl8192e/rtllib_debug.h        |  5 -----
 drivers/staging/rtl8192e/rtllib_rx.c           |  3 ++-
 drivers/staging/rtl8192e/rtllib_softmac.c      | 16 +++++++---------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c   |  9 +++++----
 8 files changed, 20 insertions(+), 35 deletions(-)

-- 
2.25.1

