Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9716B38CD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjCJIfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjCJIfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:35:08 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF2B136E2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:35:06 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s11so17353768edy.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678437305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HTybWXU5IAL8XI2UexysnpWqhELXal8JVfpL47ufHeU=;
        b=ZS5IRumERN7XotCqRgichugZm5NATDs6rD7+6nLJ8lTewXz8bVwp7meppGEYhQlrHu
         za0mWrnIn7xrRtTS0uSHFHcIM/7/wj8L59zQBB/fn8wK92nNYHqmf2CObRW3rPZSuMeV
         VmogdopmyeF8q9LS59zLU2+9QWI8/aKS7rSV0Dd3NH/G9Fv4kssxjXHF5FNyQMcOXiW7
         UiEujl+otrBdVgEXmp7I7n1PmGFy4EAuJ22XivJlShCLWY6kusnzQYCL12gQZU4rPWb6
         bg65G06iM31loNZdIlvTuVz3B1qxFukvtqo+ar7PHx/yp8e4K+O4PQ5hap84Pl06zSwl
         empw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTybWXU5IAL8XI2UexysnpWqhELXal8JVfpL47ufHeU=;
        b=Y7+98B86tEET7C+V5HXwIFehIS/7eXeM+dBIXbgtr0gDMpD+uvDqzJTjXF1aq+I1jF
         OQXjccj2QAThEJgm9dzb2mpATuZ3ifpDhhNP635yuNLXSQofzh96A+MIi6x18r0pw8Jl
         y4fu9cQJaho7bqWHrXe6dP//Iw9zt2v4yfYepq764yzNxNH5XcwI2pUSF3/xwe/blbct
         aaI1N+Lcht3L/3fbIQDdg5GiIYmySHi5rXeE9B38xy6AVqzUrLYOy3ND2ieQz0HJeFyX
         M9c/kcZwIr7wb1GKkm7kZ92II+KTbCyarbEW75bAYvqOSwFjlI8UyfkdSQ84Qnx5NgKl
         pzOw==
X-Gm-Message-State: AO0yUKWnS/2DBjerAXMTfmYEPm8BLRcMMzsWMPOem9aiOQM/yXDaBUoY
        izsIopGrP3z/0cZT1jucbKI=
X-Google-Smtp-Source: AK7set+gayih3x7n+jeDpUGIM5rn3g0D4qfBqFHPLtWulfhKu1RZ/W3r5jXyorBFQ4NOoWuzG3hHug==
X-Received: by 2002:a17:907:9713:b0:8b1:a3c7:a9c9 with SMTP id jg19-20020a170907971300b008b1a3c7a9c9mr29926324ejc.70.1678437304904;
        Fri, 10 Mar 2023 00:35:04 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbd3.dynamic.kabel-deutschland.de. [95.90.187.211])
        by smtp.gmail.com with ESMTPSA id h10-20020a17090619ca00b008ce5b426d77sm697888ejd.13.2023.03.10.00.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 00:35:04 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/5] staging: rtl8723bs: remove some unused functions
Date:   Fri, 10 Mar 2023 09:34:44 +0100
Message-Id: <20230310083449.23775-1-straube.linux@gmail.com>
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

This series removes some unused functions from hal/hal_com.c.

Michael Straube (5):
  staging: rtl8723bs: MapCharToHexDigit() is not used
  staging: rtl8723bs: ParseQualifiedString() is not used
  staging: rtl8723bs: isAllSpaceOrTab() is not used
  staging: rtl8723bs: linked_info_dump() is not used
  staging: rtl8723bs: rtw_get_raw_rssi_info() is not used

 drivers/staging/rtl8723bs/hal/hal_com.c     | 108 --------------------
 drivers/staging/rtl8723bs/include/hal_com.h |   9 --
 2 files changed, 117 deletions(-)

-- 
2.39.2

