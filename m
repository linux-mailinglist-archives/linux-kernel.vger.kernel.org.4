Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D226BD6D1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjCPRQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjCPRQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:16:20 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AC330B00
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:16:19 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id s8so1457517pfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678986979;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DYPQx63WJi0KpetmQ8FlsJ8XrcldXEPSpXZsd4T9ZoE=;
        b=TrfEuZbiz0Mx/8TvVIKDtsms7CUjPnceK8gmFafRKXUtlPSTF7kfOPXh5tU7esXj9T
         QDAnK+slrI3dM8wSyqGZNStOBP3uO3NWg4fV8Or3wN6cVRhaQ9d08deRBG3gOHclObz9
         tw5hjbqOqnG5b32Khk4mZipASBKRDBAyriAz/Cojw81tiLR3zWeulniCFIQAVB1qPLhM
         i/IDHN8TdFk0e0BDQPPkU4hCVrh7U+YXn2V4ktUzIeyWxCtkLkT7O2V0aPD/3xjFZb4b
         0U7j7m1sa6+rPKL2s/0C1gZ/D8hied0I+hipo7oSZR8L1RjC4xj7aQ3YBaO4JS5ylKMw
         8nBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678986979;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DYPQx63WJi0KpetmQ8FlsJ8XrcldXEPSpXZsd4T9ZoE=;
        b=kjBxqJLJcG8S4LSPAvScmCSJlzZV7e7mHywGisEw4VpEhy3iDfsfSgdf3B3GAFsL9p
         Ela21l+fMC7UKaI57OLkIRiGNlJ/BZLyjVvtfFuFg24THgrR3oqL39HlKtLACEanmT9T
         HCnZR5XxiK8L6JFky7wl7+5OyDZ3hKwMg5tjC2tCt5UoWIONLryIwLm2DTne1CRBR6Gu
         yQ0A5XGalUOjFfZBayq8fLyVZiDzamlgGxvukzucnQlJZWsNp+FHdvc/yl6CENNkMS/Z
         XGh7yTRIxv8/ENeuhcm74ObgL247nyYIecfc6YKu6HZNCE4Zo5U1YUH1fjdRhl8mEdl8
         w5uQ==
X-Gm-Message-State: AO0yUKV+6ly19Q1zkMRwtBeixau/6f0Kbr375Qk35wZ9723dSwdNefK/
        QAX8n3InoHnb19re7rIermw=
X-Google-Smtp-Source: AK7set+jVJLXx5I+/yDk5/+NL00FhN05AtgOVbNz29+5ohXHfy2vxLtPj0+O0nusRGww+u3pdgFWWg==
X-Received: by 2002:a05:6a00:1989:b0:625:8d3e:34ff with SMTP id d9-20020a056a00198900b006258d3e34ffmr108856pfl.12.1678986978854;
        Thu, 16 Mar 2023 10:16:18 -0700 (PDT)
Received: from sumitra.com ([117.245.254.247])
        by smtp.gmail.com with ESMTPSA id j2-20020aa78002000000b005d61829db4fsm5697987pfi.168.2023.03.16.10.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 10:16:18 -0700 (PDT)
Date:   Thu, 16 Mar 2023 10:16:14 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     drv@mailo.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev
Subject: [PATCH v3] Staging: octeon: Fix line ending with '('
Message-ID: <20230316171614.GA82631@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since, the coding-style limit the code within 80 columns per line. This
causes splitting the function header into two lines and results the
first line ending with a '('. This causes the checkpatch error.

Place the function parameters immediately after '(' in a single
line to align the function header.

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
v2: Change patch subject and description

v3: Change patch description, noted by Deepak R Varma <drv@mailo.com>


drivers/staging/octeon/octeon-stubs.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 7a02e59e283f..3e7b92cd2e35 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -1372,9 +1372,7 @@ static inline void cvmx_fau_async_fetch_and_add32(uint64_t scraddr,
 						  int32_t value)
 { }
 
-static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(
-	int interface,
-	int port)
+static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interface, int port)
 {
 	union cvmx_gmxx_rxx_rx_inbnd r;
 
-- 
2.25.1

