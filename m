Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4337C6BE090
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 06:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCQFZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 01:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCQFZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 01:25:02 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF1520A0D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 22:25:01 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so7877919pjt.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 22:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679030700;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5OsTv5mWSZFVE+t+Dyd8RSnvy3cQsZjJUc/om6AkPA0=;
        b=NUWyGYTVEEzFBCnAk9Y1gR61+or/NIRmsqXPVcsOJWE5dlw5IdeK8me71AnxHF5VWf
         wqNbQaDkQXl0H4/UYLLgPcHWQjTmgrLDCGh1uixA2Yi6BkJBQmva4yHHDNiw7f9q8xT4
         zWfaBe1jXf6ZK1xNd6Vy4int361bUlC6aUN0oyuVtTX6YfF2x/428WeeHUDbPAB9BJ/m
         2W1X6WUWXNf8bYn7C1sCXX5C8EUZiaYaSBMGENfyb80EtIpecITTbMkNwarazOtUfv7M
         ApDA43Iw5+0eSf16PSnfBzUsqv1LT/7Y3QeYy3y5GJr7PMOM6zLr/Y3rY4LtMmt/EQW8
         OmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679030700;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5OsTv5mWSZFVE+t+Dyd8RSnvy3cQsZjJUc/om6AkPA0=;
        b=A9ddrb5K31gb5xnvrpENvS/ahC3hQubHmMfP5HYmLbJpPXErCgl1Z0MiwuRFlp87Z+
         mDh3HFJsxHv6NNs9unywGX23z5G9fPw04Nyim03rdLeYN5Tz05t3LjSUPmSkDcQnur48
         rlE/Z90/WlRza8ac/UWzci+ebVQK6h+HFiEkt2rOu2SyWUzSnYg2jmBcBQ78v185w6+F
         nfNSVayHSGrr99o2KI7R9Zv1KsaudQx9SvabPPLzpJZYpyOmXHrUWiHIG/V5JiQej+sh
         15vH2qZWQd1xf6T2oysQPLr5z9INdcVx4knI2nKeQWz+T4b8ggbx4NfeeRMti76FaTHB
         QSyg==
X-Gm-Message-State: AO0yUKW/Xvqn5NusXM49JADNkoNYBg68NLT648d+e8RabIgsJmlx48s9
        h/0A7g6rTKvyRp0fJeb0iek=
X-Google-Smtp-Source: AK7set9Im1IFpX88ON4gzwTNyE+UVHwYPAYwvbo5KfrpPnrVF0jOFpzHNbtctISclL//JRZN4ysV3A==
X-Received: by 2002:a17:902:c451:b0:19a:a9d8:e48a with SMTP id m17-20020a170902c45100b0019aa9d8e48amr4983489plm.22.1679030700573;
        Thu, 16 Mar 2023 22:25:00 -0700 (PDT)
Received: from sumitra.com ([14.139.226.12])
        by smtp.gmail.com with ESMTPSA id p6-20020a1709026b8600b0019a97f180fcsm610512plk.37.2023.03.16.22.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 22:24:59 -0700 (PDT)
Date:   Thu, 16 Mar 2023 22:24:55 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     drv@mailo.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev
Subject: [PATCH v4] Staging: octeon: Fix line ending with '('
Message-ID: <20230317052455.GA83442@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Since the coding style limited the code to 80 columns per line which caused
splitting the function header into two lines resulted in the first line
ending with a '('. This caused the checkpatch error.

Place the function parameters immediately after '(' in a single
line to align the function header.

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
v2: Change patch subject and description

v3: Change patch description, noted by Deepak R Varma 
<drv@mailo.com>

v4: Correct grammartical mistakes, noted by Julia Lawall
<julia.lawall@inria.fr>



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

