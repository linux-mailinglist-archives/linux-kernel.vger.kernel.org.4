Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C2D6D85D1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjDESSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDESSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:18:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B3065BB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:18:45 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id fi11so19779825edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680718724;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LbPoISbRHHbgx/EIizLjiaK4a2+6FCKivzxh5KJKvX4=;
        b=Lj/8r+Ls2RV3REtyjYQ+5sXQz9P56r8nQJkhObC/47JPCQx0EWgDyYzOeRCjWWRTNi
         rrqhKJ9TBOzhCub4MpOmg82OmGMtxMlnS0XQVt9AL74yYaiE0APwebn6yLDP4F6w2RNe
         sXZDJzQTcGYyPBBb4JOtGiWRpIA7uRLJkEMcAv16YSCpz9IBLexYdy0TLZuG0E2JzA6T
         1Os0NyBJzDGwF7XkdiNYEw7fXWkZz8qpVNZlseeLA3a49xYpHiRPA5KtDyTFMM4Dzran
         XPtHEjtooP/RAyzrPQCs7mwts6pgAAV5TExop2m0g3jNW8XraeI8y79OaU2s53/rT/6F
         yx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680718724;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbPoISbRHHbgx/EIizLjiaK4a2+6FCKivzxh5KJKvX4=;
        b=hbK4KK7npHNcRUPQAMTIH6P/eCHV5ZhQyZBh+f6Ul9muGMhLAXIiAuI7aAZO1CccxV
         y65KHSjeoHtg7jjSoSrLeG6DPx0fP/JQOovyeVYbK1DVvAECKmglrghv25e3RXWytmIk
         4xDjRAIOh1M3VxKp1MXqjlHd+Z62jhPUzRtu1mWaiySNwY3ALhX3x8VXSlSiZBqrX9k0
         vfX2q/Ju1/SMbfW8K0UXTl/W7TEC7vk9k50FMiUZrI1iCotdYcJIoaKlhioxS2K2/Ijr
         p9gbxGzxkcUU2eHWDAD276xbNRK0vq5v5h+XpG69p9iM/IllMNjv6fxv+vpiEWMPWhjP
         F9mg==
X-Gm-Message-State: AAQBX9d3wX/8wPE9fzYtrwI4tBJx8jYQHzWndAbmlkKjnf4TidQ8EliV
        tbqoODVlZZJhYlowzg8nbHnqbMM3yA==
X-Google-Smtp-Source: AKy350YCNMvymqNqKy5WInMMa5oFPLUY5LNygeL9fColk5yKXlmxQMUOFvy+jvvLnBmzhOQoqImERQ==
X-Received: by 2002:a17:906:3d71:b0:8b1:820a:7b60 with SMTP id r17-20020a1709063d7100b008b1820a7b60mr3383770ejf.6.1680718724381;
        Wed, 05 Apr 2023 11:18:44 -0700 (PDT)
Received: from koolguy (dslb-002-205-192-117.002.205.pools.vodafone-ip.de. [2.205.192.117])
        by smtp.gmail.com with ESMTPSA id v13-20020a170906b00d00b009373f1b5c4esm7641255ejy.161.2023.04.05.11.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 11:18:43 -0700 (PDT)
Date:   Wed, 5 Apr 2023 20:18:41 +0200
From:   Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: octeon: remove typedef declaration for
 cvmx_fau_op_size
Message-ID: <20230405181841.GA6820@koolguy>
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

Fix checkpatch.pl warning: do not add new typedefs in
drivers/staging/octeon/octeon-stubs.h:216

Signed-off-by: Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
---
 drivers/staging/octeon/octeon-stubs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 3e7b92cd2e35..9f269626b862 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -213,12 +213,12 @@ enum cvmx_fau_op_size {
 	CVMX_FAU_OP_SIZE_64 = 3
 };
 
-typedef enum {
+enum cvmx_spi_mode {
 	CVMX_SPI_MODE_UNKNOWN = 0,
 	CVMX_SPI_MODE_TX_HALFPLEX = 1,
 	CVMX_SPI_MODE_RX_HALFPLEX = 2,
 	CVMX_SPI_MODE_DUPLEX = 3
-} cvmx_spi_mode_t;
+};
 
 typedef enum {
 	CVMX_HELPER_INTERFACE_MODE_DISABLED,
@@ -1362,7 +1362,7 @@ static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
 }
 
 static inline int cvmx_spi_restart_interface(int interface,
-					cvmx_spi_mode_t mode, int timeout)
+					enum cvmx_spi_mode mode, int timeout)
 {
 	return 0;
 }
-- 
2.25.1

