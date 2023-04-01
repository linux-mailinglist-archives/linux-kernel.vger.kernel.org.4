Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49716D340E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 23:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDAVUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 17:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjDAVUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 17:20:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B515D93C2
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 14:20:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eh3so103051644edb.11
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 14:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680384005;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YqTJVLt/yAp6Cnjom0YyqO4Vpoe/b6jyn4e1raDijuc=;
        b=QjD/vMntbbVB+Cp9Ab4ZsXns7n+I5TLoXV92+tTySay4Fiu0HXLtpXwSHEqW4A8npD
         TgL+4ws61YkM9Wiv6fFcDDJ9aP/GF9FfVhXQTy2Osy/+b6Mh9i4HeVToMEHxPbXI64D1
         vMJSM7UlsKFbTnFBdz/Dr8GTNzgRelyzz35noHXW4D1uGSmVlfOONRzeq86t6oXori2d
         P09y39d8JG18gBUD0CZCsW7gbiHg5yK8gqiPjNYuvEJtaa64Sa0YhuaQxfI11SwE63Ns
         tfM6CitZxKU1yFQWMNvE9My5xmXrG4/NJ4F1umCTcX5g1dcussUtyGkQGaWJKK4MtXGS
         DDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680384005;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqTJVLt/yAp6Cnjom0YyqO4Vpoe/b6jyn4e1raDijuc=;
        b=vIPHRvDUC8GZGJ12cGVKNloOGA0dn7Z0XCBseEZotU0QbAY8o4E27vtrJgUj+pGEzf
         uSO5zVPMV+x9LbjMN9cax7cuH81zeReGm3uHoqZfVqLDcNa0PwEtBuXolwKCEiD5DDS3
         kazq0BlKD6s0C11S8iEbU1TtcbgAx/z9zRNl+NEXdCmByqNFotKZPcLFDBo9jB3+YGIc
         CfoyyO3vyYNWnNWE8WlkeNUjIQ2Boe+1NInXEmOifcS0b2S8WOTzTARhrjqgByZQwrmu
         ywtk44xKUhIcs4Aaz4HxHJhe/eUIxkYuarzNDbqC6TmVewNltocxvbTcDVRWUyZVtbo5
         9Vow==
X-Gm-Message-State: AAQBX9cNrk+WDNouSryQOmAPz+sOwDnEaGYjeYZh3ywoDExdiYnHsngz
        aHgbfXPTATeACj0Ks6vH5M30Yxw9vg==
X-Google-Smtp-Source: AKy350ZxuGHqDoJ7Fb8LTc7+7RwKXdXT4iQ0/D6VXnSjMYHr/2+xQVzErQS1KduaWa0M2ZBlqb7//Q==
X-Received: by 2002:a50:fe94:0:b0:4f9:9e56:84bf with SMTP id d20-20020a50fe94000000b004f99e5684bfmr27706542edt.10.1680384005026;
        Sat, 01 Apr 2023 14:20:05 -0700 (PDT)
Received: from koolguy (dslb-002-205-192-117.002.205.pools.vodafone-ip.de. [2.205.192.117])
        by smtp.gmail.com with ESMTPSA id b59-20020a509f41000000b004fa380a14e7sm2528932edf.77.2023.04.01.14.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 14:20:04 -0700 (PDT)
Date:   Sat, 1 Apr 2023 23:20:02 +0200
From:   Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: octeon: remove typedef declaration for
 cvmx_fau_op_size
Message-ID: <20230401212002.GA30519@koolguy>
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
index 3e7b92cd2e35..cf560c321c92 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -213,12 +213,12 @@ enum cvmx_fau_op_size {
 	CVMX_FAU_OP_SIZE_64 = 3
 };
 
-typedef enum {
+enum cvmx_spi_mode_t {
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
+					enum cvmx_spi_mode_t mode, int timeout)
 {
 	return 0;
 }
-- 
2.25.1

