Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B066C68DB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjCWMve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCWMvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:51:32 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5741C318
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:51:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b20so53121270edd.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679575890;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S7HvfwciuqSvsnKf4jcKZ3F5a7TDTuPwSv9a3Pc+zGg=;
        b=Blvb+qIxtAHszQDyGJ9wWWfO62C7FWacM/wFm6iIcDCulFG692mp4FsLEdZEPE89Mj
         fNJpuFFQdNBT8M0sfWgQcSnOnTfF41reSxE8Wblx3Ojk1if7jrs/X3hIgltkewYO/kmS
         HWzlij8o9GTc/9ftjzuMl799AFLo65v8K7GrDoSjCFxdTWi32tpKTvLQutO4Vbm1qzBR
         MzZVMVwDTzIbbvXMmN9Zcg5HacPBCjipEHWNTS1Jm8qkzWalzVVUtHq+TBEZ3JsKDieN
         mklRzd3Ln6qNOXcXNwNdhLIZVsVLNWrf/aqpxkuyFrXO2Mm44W3DlZ+2uTLO6YrQx8iB
         uhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679575890;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7HvfwciuqSvsnKf4jcKZ3F5a7TDTuPwSv9a3Pc+zGg=;
        b=EzLoIFaz4sIjryl6z3woPIikChWJoCO5OUPbbTnL2Wr05yxqh8rayHxEPr4cGhoDz3
         LIujNeCrmLY91oJpE6hekggWDCvqWITeYduy74utk67A14o0ElyrCs8fTQzghiF08hWB
         y1m2n3N9y5vteyqeSzQeJljXC2B46cZNcVUZwzy0Bh90AVb39+fu54liiQDgpByAX4Op
         CSWymPX65WHqjtx7skCGjGjpfJvxHSnSGSiUNOfRD1d3p/lKWKPr2+UUYcQ/ECgscYgB
         10jhGgtPIu2cG/l8T5m1NgmUBs5dJ98r/1hagEzUz5xGLvLFYs0eMBtMfT9sIlS/6vDW
         FXFg==
X-Gm-Message-State: AO0yUKWI1/er1z1Uur4qRkVtK4qHdpcn9crQgy2FFf9N57HH+Ia9Syo8
        MutJn5xVGo9OHBPjuN/ru5Hl8Dwg4PiBZ7zA
X-Google-Smtp-Source: AK7set9qXDi2SIgHgRXCuy4IkvI498IWpPdrcCUJ7fAtaWYPEZA0YvZ7hvjBwgihQmASGTvumocF0A==
X-Received: by 2002:a17:906:ce5c:b0:933:4184:f0d7 with SMTP id se28-20020a170906ce5c00b009334184f0d7mr11469572ejb.69.1679575890296;
        Thu, 23 Mar 2023 05:51:30 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id 22-20020a170906309600b0092f289b6fdbsm8587430ejv.181.2023.03.23.05.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:51:29 -0700 (PDT)
Date:   Thu, 23 Mar 2023 17:51:27 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] staging: most: fix line ending with '(' in dim2
Message-ID: <ZBxLT4w0cKZ/aOZo@khadija-virtual-machine>
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

Splitting function header to multiple lines because of 80 characters per
line limit, results in ending the function call line with '('.
This leads to CHECK reported by checkpatch.pl

Move the function parameters right after the '(' in the function call
line. Align the rest of the parameters to the opening parenthesis.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/most/dim2/hal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/most/dim2/hal.c b/drivers/staging/most/dim2/hal.c
index a5d40b5b138a..6abe3ab2b2cf 100644
--- a/drivers/staging/most/dim2/hal.c
+++ b/drivers/staging/most/dim2/hal.c
@@ -346,9 +346,8 @@ static void dim2_clear_ctram(void)
 		dim2_clear_ctr(ctr_addr);
 }
 
-static void dim2_configure_channel(
-	u8 ch_addr, u8 type, u8 is_tx, u16 dbr_address, u16 hw_buffer_size,
-	u16 packet_length)
+static void dim2_configure_channel(u8 ch_addr, u8 type, u8 is_tx, u16 dbr_address,
+				   u16 hw_buffer_size, u16 packet_length)
 {
 	dim2_configure_cdt(ch_addr, dbr_address, hw_buffer_size, packet_length);
 	dim2_configure_cat(MLB_CAT, ch_addr, type, is_tx ? 1 : 0);
-- 
2.34.1

