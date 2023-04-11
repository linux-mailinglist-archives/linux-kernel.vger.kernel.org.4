Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4176DE324
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjDKRv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjDKRv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:51:26 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4853B173C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:51:25 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gb34so22652562ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681235484;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kaCf7WeXfgPCNxtzPrrsVGzdV7NlqSNHXFoaeqRcjvE=;
        b=DCsidmOrS1rX14icJcRTFa+oCTMr3rSk2Bh7wPM6AZZxmZSMQFTzOkOipblMiyM/AZ
         tOfXR/Efyncxj9jH37UettBr8kNhC+bGrk0OpJ70g/ouPxVpzt9K4kokF166WwJQJg6P
         lLhMIzRpyyngviUM0J3kKAgnp7fH+LrgZe+79CeaTvfI5Zo9O68DnVvYM0qSO4sZnuFD
         9mwNa4fg6WUapwTU7C3MgFx3/+bJLKgWJAGSpg2jPi/JTiKzVNGsMuVOsfsFjPIk7iGm
         noHvSZRu6B6cQk25WQUpEeakDMRYdk1ZvKN0LMnvti83xZ+a7qu8DVDvkENYb3Kx+XSw
         hTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235484;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kaCf7WeXfgPCNxtzPrrsVGzdV7NlqSNHXFoaeqRcjvE=;
        b=up53xi5CP7QvbUnFWjru2v7WZT7n0a+pZiELTeS1rUTP5HLwX1K7vawEdjBNJiudOx
         ZtCvi973YQJMUwuiLI/xeXW0fLIXDC1hSdshiq1ZavTjJ0tPipFcF+pymIiE9Mh765wI
         gEqYqR67+l5MTCHQlcV3i7qVjLGLmWWbJo/ICdF74HDUg+YWmsQ+rHMkn/HGSsxqX4PB
         dMgSykiHl5DBkrQs7UaDtb0kv+oZpE3ujrSB3WCf+/203IpyYERAbq1UsN1Jz8C7oQuZ
         3dna30Zk4DpjZuuTUBSUjj6VVx9qTjluPcNuYwqVbCWsqgG7ShZ+/Ku1lORxO8ikO8BD
         p3Ig==
X-Gm-Message-State: AAQBX9d57NDPHxTrbJQChtQOlJrCSPRvp3SItfn8XmMk4uDdRtVhKgCp
        /Shxb70k8C88VwYpSDiV8g==
X-Google-Smtp-Source: AKy350alHDQp0B3yx4fKt0ng9yNT0nLwrB3ldsPa5HTljljoY2tsBUhkuxoud3+LQGScqaZTwNZagQ==
X-Received: by 2002:a17:907:7e95:b0:94a:88aa:93b3 with SMTP id qb21-20020a1709077e9500b0094a88aa93b3mr8304179ejc.44.1681235483382;
        Tue, 11 Apr 2023 10:51:23 -0700 (PDT)
Received: from koolguy (dslb-002-205-192-117.002.205.pools.vodafone-ip.de. [2.205.192.117])
        by smtp.gmail.com with ESMTPSA id s21-20020a1709060c1500b0094a85f6074bsm2422256ejf.33.2023.04.11.10.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:51:22 -0700 (PDT)
Date:   Tue, 11 Apr 2023 19:51:21 +0200
From:   Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: octeon: remove typedef declaration for enums
Message-ID: <20230411175121.GA71709@koolguy>
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

Fix checkpatch.pl warning for enums in drivers/staging/octeon/octeon-stubs.h:
cvmx_helper_interface_mode_t,
cvmx_spi_mode_t,
cvmx_pow_wait_t,
cvmx_pko_lock_t,
cvmx_pko_status_t

Change typedef cvmx_helper_interface_mode_t to
enum cvmx_helper_interface_mode in ethernet.c

Signed-off-by: Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
---
Changes in v2:
-Remove Alignment fixes from previous version.

 drivers/staging/octeon/ethernet.c     |  2 +-
 drivers/staging/octeon/octeon-stubs.h | 39 +++++++++++++--------------
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 9eee28f2940c..023b107e077a 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -798,7 +798,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
 
 	num_interfaces = cvmx_helper_get_number_of_interfaces();
 	for (interface = 0; interface < num_interfaces; interface++) {
-		cvmx_helper_interface_mode_t imode =
+		enum cvmx_helper_interface_mode imode =
 		    cvmx_helper_interface_get_mode(interface);
 		int num_ports = cvmx_helper_ports_on_interface(interface);
 		int port;
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 3e7b92cd2e35..58708a7f727a 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -213,14 +213,14 @@ enum cvmx_fau_op_size {
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
 
-typedef enum {
+enum cvmx_helper_interface_mode {
 	CVMX_HELPER_INTERFACE_MODE_DISABLED,
 	CVMX_HELPER_INTERFACE_MODE_RGMII,
 	CVMX_HELPER_INTERFACE_MODE_GMII,
@@ -231,20 +231,20 @@ typedef enum {
 	CVMX_HELPER_INTERFACE_MODE_PICMG,
 	CVMX_HELPER_INTERFACE_MODE_NPI,
 	CVMX_HELPER_INTERFACE_MODE_LOOP,
-} cvmx_helper_interface_mode_t;
+};
 
-typedef enum {
+enum cvmx_pow_wait {
 	CVMX_POW_WAIT = 1,
 	CVMX_POW_NO_WAIT = 0,
-} cvmx_pow_wait_t;
+};
 
-typedef enum {
+enum cvmx_pko_lock {
 	CVMX_PKO_LOCK_NONE = 0,
 	CVMX_PKO_LOCK_ATOMIC_TAG = 1,
 	CVMX_PKO_LOCK_CMD_QUEUE = 2,
-} cvmx_pko_lock_t;
+};
 
-typedef enum {
+enum cvmx_pko_status {
 	CVMX_PKO_SUCCESS,
 	CVMX_PKO_INVALID_PORT,
 	CVMX_PKO_INVALID_QUEUE,
@@ -252,7 +252,7 @@ typedef enum {
 	CVMX_PKO_NO_MEMORY,
 	CVMX_PKO_PORT_ALREADY_SETUP,
 	CVMX_PKO_CMD_QUEUE_INIT_ERROR
-} cvmx_pko_status_t;
+};
 
 enum cvmx_pow_tag_type {
 	CVMX_POW_TAG_TYPE_ORDERED   = 0L,
@@ -1265,8 +1265,7 @@ static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
 					    cvmx_pko_port_status_t *status)
 { }
 
-static inline cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int
-								   interface)
+static inline enum cvmx_helper_interface_mode cvmx_helper_interface_get_mode(int interface)
 {
 	return 0;
 }
@@ -1342,11 +1341,11 @@ static inline unsigned int cvmx_get_core_num(void)
 }
 
 static inline void cvmx_pow_work_request_async_nocheck(int scr_addr,
-						       cvmx_pow_wait_t wait)
+						       enum cvmx_pow_wait wait)
 { }
 
 static inline void cvmx_pow_work_request_async(int scr_addr,
-					       cvmx_pow_wait_t wait)
+					       enum cvmx_pow_wait wait)
 { }
 
 static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
@@ -1356,13 +1355,13 @@ static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
 	return wqe;
 }
 
-static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
+static inline struct cvmx_wqe *cvmx_pow_work_request_sync(enum cvmx_pow_wait wait)
 {
 	return (void *)(unsigned long)wait;
 }
 
 static inline int cvmx_spi_restart_interface(int interface,
-					cvmx_spi_mode_t mode, int timeout)
+				       enum cvmx_spi_mode mode, int timeout)
 {
 	return 0;
 }
@@ -1381,12 +1380,12 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interfac
 }
 
 static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
-						cvmx_pko_lock_t use_locking)
+						enum cvmx_pko_lock use_locking)
 { }
 
-static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
-		uint64_t queue, union cvmx_pko_command_word0 pko_command,
-		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
+static inline enum cvmx_pko_status cvmx_pko_send_packet_finish(uint64_t port,
+		    uint64_t queue, union cvmx_pko_command_word0 pko_command,
+		    union cvmx_buf_ptr packet, enum cvmx_pko_lock use_locking)
 {
 	return 0;
 }
-- 
2.25.1

