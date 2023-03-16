Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2C26BD45E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjCPPwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjCPPwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:52:08 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB17283FF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:52:06 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id fd25so1422524pfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678981926;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tOcVYpEkBU+F2J1BLwbVIMceM+rp1K8jWNJcX1iHdIo=;
        b=qBS8p0D8OOpgalLTxlU4DXIK3F+5cPuTq6SjsDfJ9wpnni3DIIeRQdwsP5PITOFAxs
         bmi/77J0sVy3L6szsHMSntVJajGHtcP1idPWDamRtyL4bcuxkGa6IydOiDT0qfkqhlJO
         HKtEAzMO5b5iPfGbd62Z0JamDBVKAvGYYY4jAkFD4YEszSxZB8SPOJRnOrEBxzJ3gw8V
         p8z3g2vG240yzBukFaTy6M3ELn2RkngrXTvFl/iznQgvN4aMq/LDIIBt4MS7qpgretX3
         2+KLmOnOIrdKpoutO9M2mfUbzOhJlTNUfeeYw88zffRTifYNRoqUxr4vY4stHTNzUeVL
         Qc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678981926;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOcVYpEkBU+F2J1BLwbVIMceM+rp1K8jWNJcX1iHdIo=;
        b=nL0JyhNUa/2kpKDmIdoVfNxQA0nNf1xtojB/1hgdqmzfoPeO5Zwyjqxj0pGE1rEqMS
         Y5/J2gyX9tEVTiByTd0cwHY7/2vQgNursXlAe3Hi9PZCpg0shXM9PIlOjPDZ9lhxZl+j
         78lj1dJDWeVV9fWfA7GNu3OcfgIugUlSjP+wtTUMUWCwxPwIxW9KLQJ7gQO5s/obPV+p
         oysbr5tBP+V7x1VqY3jb8vlCyi6VPHeXjSNcfzHJX+76n2w57Sr+AGl2ZXI4osRwI7DF
         IerLjT37BxCdCtoHIhDpf1ucY5IqWhSFIeCTTuUVtM3T5F+xBQnUvEeNuoa9tSDjZWAI
         ojLQ==
X-Gm-Message-State: AO0yUKVIeiNRb+VNzux89eZ/cr9MeLJTtAW6s6fpOBqKqDuaUoEHBLrw
        2IDsgUG5H8m2+FeP11JlYDOENW374Zyr9w==
X-Google-Smtp-Source: AK7set88clC4PgM3UNPgE6+tMcTDdZ/P2AuucREOUuO2YQ0vkMTXCNnanVH7L5/QolZABvczlD1HLg==
X-Received: by 2002:a62:8457:0:b0:625:eacf:caf9 with SMTP id k84-20020a628457000000b00625eacfcaf9mr2944270pfd.7.1678981926219;
        Thu, 16 Mar 2023 08:52:06 -0700 (PDT)
Received: from sumitra.com ([117.245.254.247])
        by smtp.gmail.com with ESMTPSA id x21-20020aa784d5000000b00592eb6f239fsm5606817pfn.40.2023.03.16.08.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 08:52:05 -0700 (PDT)
Date:   Thu, 16 Mar 2023 08:52:02 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: [PATCH v2] Staging: octeon: Fix line ending with '('
Message-ID: <20230316155202.GA82100@sumitra.com>
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

Adhere to coding-style.

Checkpatch has reported code style warning:
CHECK: Lines should not end with a '('.

Enhance the design of a function header:
Align the function parameters immediately after '(' in a single line.

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---

v2: Change patch subject and description.

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

