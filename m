Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62056B63B1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 08:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCLHc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 03:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCLHcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 03:32:54 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FF558C3B
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 23:32:53 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cy23so36770249edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 23:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678606372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=590kegQ5S46TgiOWfJqQ1hyO5zf2wczEPaNlcKYRY+M=;
        b=diRTSoV06P/iuYFocwhOo2CpLewnjZE4tFQGzu19etY8CaWDKJK4UlFJgHC3KX0YqX
         sYQ4E8KElNWpej2Yr0Igi6038KKMNNUoB7fLmDd+hoIrv1e79TDQbdlGmpJFFUPfoRqa
         CRMfJJ2Ga064jGiU/ZFFlNcyuLdX6Z9KCKcY5n3x9EUVdPj+IMXbJztu4jh/gbA65GNz
         Kq7IAz4inCb1CrsolD0hRjpdipVYV8uJ6CtyoTaIrZ5wT6XdF1Sz1meoqenlpSL9/dJU
         lZCOGK8oxMORVOw+hw/ZEQ+JOxd9W4fTw7ydJRtIEGcRWRGR18MxOjzPTC9K1ZmMEs8y
         KFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678606372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=590kegQ5S46TgiOWfJqQ1hyO5zf2wczEPaNlcKYRY+M=;
        b=tNmfzSQMpykuYRwmwM+AzZD7aehIVClb8hdbI2h6jDxiuggkOeVNhkIfZZTq8wpwEx
         A8HGxdFOr4N+tK0rSoKvfYOEcyq+F9B4/l0Hxb5xwUE54WVw34zHsD0mhDDc/0B74yKy
         8K3jFiY8xalAQWNOM0uE23UPpTzd8CiMK/KdBU79mgbvtvflGeRkjcvJx9a8SELS1FNm
         k+WRV0TBK1pnsqTxpuQxRakPhBJKSFGh+btwAt+MGXDpCfXYXJh8oAZ6P2ULQXHHyt0k
         w9Pp8p+Mg6SGZAfkgJqlTfevLrFpJoFeJ5ld3fYiKDBG48qn8ewFnIC4cmreyGRHrGdB
         B/eQ==
X-Gm-Message-State: AO0yUKX8NhE6h25E/jkABJZwepC7haA4r4fAzwKusHxpwWy9KJiN32Mu
        m7Myc2JD8ZB+EFS8k3or490=
X-Google-Smtp-Source: AK7set+Dh4KntyezYUBhsZrgmfuYZ6vRjVVgyfgZkmujh7cL/UthuhlkGK9nKP1z2JSujYklQSd/5Q==
X-Received: by 2002:a17:906:2989:b0:88f:13f0:4565 with SMTP id x9-20020a170906298900b0088f13f04565mr27871455eje.69.1678606372103;
        Sat, 11 Mar 2023 23:32:52 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbfa.dynamic.kabel-deutschland.de. [95.90.187.250])
        by smtp.gmail.com with ESMTPSA id dc8-20020a170906c7c800b008d1dc5f5692sm1928841ejb.76.2023.03.11.23.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 23:32:51 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/2] staging: rtl8192u: remove two unused functions
Date:   Sun, 12 Mar 2023 08:32:45 +0100
Message-Id: <20230312073247.9822-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes two unused functions.

Michael Straube (2):
  staging: rtl8192u: rtl8192_SetRFPowerState() is not used
  staging: rtl8192u: dm_shadow_init() is not used

 drivers/staging/rtl8192u/r8192U_dm.c  | 38 ------------
 drivers/staging/rtl8192u/r8192U_dm.h  |  1 -
 drivers/staging/rtl8192u/r819xU_phy.c | 87 ---------------------------
 drivers/staging/rtl8192u/r819xU_phy.h |  2 -
 4 files changed, 128 deletions(-)

-- 
2.39.2

