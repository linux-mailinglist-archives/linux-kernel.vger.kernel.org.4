Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BEE6D29F5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjCaV2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCaV2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:28:01 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3EA1E724
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:28:00 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y4so94930549edo.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680298078; x=1682890078;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+z6UjGGFvmkTQgSojG8SkLIMfAa6UVmOIxZHbH2bXuY=;
        b=XBSb7b4HcDw05s830VnK6YTJzhgYe95e5BolIV5NYpWVbqSej5FdFJL5kzxgTrlgAI
         OE6qz1Xm/6oP2koRvSyIai7baOdFj/Ci+RXvv5m4odWTMIPWKKWASHLHqXq5dQBZfOlU
         8LYZvlptxt0XyuRsBDpVOL/Py58wBDmvX5gpHChVk2RgajIl5OM6ZznKKznISIrmfx0Y
         2k+xsS0i+QDT69/8x13RmJzBBG4M3sA4SaNwFAbgORfUOEoBl6J//BtVAqwRQ1Kts/68
         c6JjHVIP+yfIB6y6TPj4eW3D1XMghQW6n0g/IJ8TcDnwQ2zEwEqE9dw3kWjENYvyLaWj
         9JDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680298078; x=1682890078;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+z6UjGGFvmkTQgSojG8SkLIMfAa6UVmOIxZHbH2bXuY=;
        b=nY8rK0VtAvrGHDYSPckqsHUCkXgQIXuxlvf8e58ntE2T/AqYhqGkat9Ds9p51WiD0b
         qPS0v3yraHZuFpRO1gWi/bPtJ+fkrOMFTYH4bH6VCKQucCU6/FjYs6OgSKidQAQLBU0W
         XwuxR5XVI35tBNXKUJEn/BqlqhLZ4ALFvOH24R0DJzlc832+oj8p7jcBFUQpJaE23hij
         IQ5bVcWRZKgZW0r4irL9mirMcRQDulLIwNC/xUPqcA3NVlRbDxX36t+r1TjbN4baYPX7
         2OC/E0r+y1Oq5w4TEy7ZEI+/zOCYsqOn/yln0qrAoGSD/ZpaZbrdy3XDSTv4tamRuzXL
         7CKQ==
X-Gm-Message-State: AAQBX9cWS0GxmtCFSFO41KOqvtUc+OxBqJM895HfhjavTSyCl8vgFQTz
        gEsOq1KVKahjCcBVewE5LgLRixIqKnk=
X-Google-Smtp-Source: AKy350bHsPPBiOP1I2P7F+AENVhC4y/Eg3R+A1rtxj8z+tm1AgxpwwZnrJlZXqCNJjJ8beCSN0d9lw==
X-Received: by 2002:a17:906:2098:b0:8d2:78c5:1d4e with SMTP id 24-20020a170906209800b008d278c51d4emr6084743ejq.5.1680298078547;
        Fri, 31 Mar 2023 14:27:58 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id jg9-20020a170907970900b00947ae870e78sm1053689ejc.203.2023.03.31.14.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 14:27:57 -0700 (PDT)
Date:   Fri, 31 Mar 2023 23:27:55 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] staging: rtl8192e: Remove enum RF_1T2R and useless cases
 for customer_id
Message-ID: <cover.1680297150.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove enum RF_1T2R as the code using it has always the same result.
Remove useless cases for customer_id.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (5):
  staging: rtl8192e: Remove enum RF_1T2R
  staging: rtl8192e: Remove local variable Value and powerlevelOFDM24G
  staging: rtl8192e: Remove case customer_id = RT_CID_DLINK
  staging: rtl8192e: Remove case customer_id = RT_CID_819x_CAMEO, ..
  staging: rtl8192e: Remove case customer_id = RT_CID_DEFAULT, ..

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 26 -------------------
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h |  7 -----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  5 ----
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  8 +-----
 drivers/staging/rtl8192e/rtllib.h             |  4 ---
 5 files changed, 1 insertion(+), 49 deletions(-)

-- 
2.40.0

