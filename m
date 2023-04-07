Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302566DAD1B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjDGNFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjDGNFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:05:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C921CF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:05:48 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l10-20020a05600c1d0a00b003f04bd3691eso10274217wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680872746;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q65I8oJNkk5OeaspjtyS5YaULgJm8HOY8RaqcBgw9yM=;
        b=W7/GLKKOXuw/+Aud8XTnR6E0qxxLEsg8YDxPsknmJttZZnNJ1oudkNTmggjMzPFTpo
         71H6PZO0ZuYLkTqR9HTAvNGsU0DQeOqHliUUenbeRehy/ZMoiypicqMD2PFKBEkLy1Sa
         ru6S/EbyP+XdSXV+J7zriQTj2SVP4TfabGz7BWZkevm5fs5i2akII8sRkZD4E9UGKHMD
         ulEO/tbQa2S19OFXvZsgJKMMUHvwA1pz51GCHQVBSFGudsCNG6KfVCny8imT2U9k9e/E
         fOn7VIAu/SKuKGwa3XNJSAfLClamkHscxib/JzIHI0mm2ruJig7R2/hkI3gFFq48dvXs
         hDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680872746;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q65I8oJNkk5OeaspjtyS5YaULgJm8HOY8RaqcBgw9yM=;
        b=v8PmW5sfofSTec6SpUzRcf027gD+70VqRSxI936VwFzVpwicjM6DLgk3Kl15LJhn9G
         vqBXi6T4eZxK/P1pfYOfo2fvCcYaACeJsdJdVwPVybiYoMyJ/BiPDV4Ytn5CiqPQvuqU
         0/Nmu+AZvY86Q7vGWzGOTUuBpLbNkqr2deaFrMmf7RqDrqGA8acXLdra5rwRGBIAaiJu
         tL5Zh0iWdXd8XMU/5saNTMNY3peClrj/aeN8+xueqz0HorkmERFxaQ62sRFR9rlSOhBl
         PG+t8mezCoerGS285iSXlStwVD5RmW6Jd23ykopYmaZsNpo0Y0MCSyySo6LjpoDN5iVF
         HEKw==
X-Gm-Message-State: AAQBX9d8RfWpZC1IndcFHoKv/aSGtYhclhEdHT/alcE4ZGr9PdHSiCQr
        4COJ25AK6aWccts9bwjmywg3CbGsBA==
X-Google-Smtp-Source: AKy350ZHfRTS94vuajAxTUng211GRem8ZbX9yAqH+g9GfuHv6BJ7Clo6VEHHux/SkPMc12lfcsvJeA==
X-Received: by 2002:a1c:7409:0:b0:3dc:5b88:e6dd with SMTP id p9-20020a1c7409000000b003dc5b88e6ddmr1243588wmc.10.1680872746341;
        Fri, 07 Apr 2023 06:05:46 -0700 (PDT)
Received: from koolguy (dslb-002-205-192-117.002.205.pools.vodafone-ip.de. [2.205.192.117])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b003f046ad52efsm8434226wmb.31.2023.04.07.06.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 06:05:45 -0700 (PDT)
Date:   Fri, 7 Apr 2023 15:05:43 +0200
From:   Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: octeon: remove typedef declaration for enums
Message-ID: <20230407130543.GA32964@koolguy>
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
 drivers/staging/octeon/ethernet.c     |  2 +-
 drivers/staging/octeon/octeon-stubs.h | 50 +++++++++++++++------------
 2 files changed, 29 insertions(+), 23 deletions(-)

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
index 3e7b92cd2e35..3d613dc725e8 100644
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
@@ -1257,15 +1257,17 @@ static inline int octeon_is_simulation(void)
 	return 1;
 }
 
-static inline void cvmx_pip_get_port_status(uint64_t port_num, uint64_t clear,
+static inline void cvmx_pip_get_port_status(uint64_t port_num,
+					    uint64_t clear,
 					    cvmx_pip_port_status_t *status)
 { }
 
-static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
+static inline void cvmx_pko_get_port_status(uint64_t port_num,
+					    uint64_t clear,
 					    cvmx_pko_port_status_t *status)
 { }
 
-static inline cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int
+static inline enum cvmx_helper_interface_mode cvmx_helper_interface_get_mode(int
 								   interface)
 {
 	return 0;
@@ -1342,11 +1344,11 @@ static inline unsigned int cvmx_get_core_num(void)
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
@@ -1356,13 +1358,14 @@ static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
 	return wqe;
 }
 
-static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
+static inline struct cvmx_wqe *cvmx_pow_work_request_sync(enum cvmx_pow_wait wait)
 {
 	return (void *)(unsigned long)wait;
 }
 
 static inline int cvmx_spi_restart_interface(int interface,
-					cvmx_spi_mode_t mode, int timeout)
+					     enum cvmx_spi_mode mode,
+					     int timeout)
 {
 	return 0;
 }
@@ -1380,13 +1383,16 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interfac
 	return r;
 }
 
-static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
-						cvmx_pko_lock_t use_locking)
+static inline void cvmx_pko_send_packet_prepare(uint64_t port,
+						uint64_t queue,
+						enum cvmx_pko_lock use_locking)
 { }
 
-static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
-		uint64_t queue, union cvmx_pko_command_word0 pko_command,
-		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
+static inline enum cvmx_pko_status cvmx_pko_send_packet_finish(uint64_t port,
+							    uint64_t queue,
+							    union cvmx_pko_command_word0 pko_command,
+							    union cvmx_buf_ptr packet,
+							    enum cvmx_pko_lock use_locking)
 {
 	return 0;
 }
-- 
2.25.1

