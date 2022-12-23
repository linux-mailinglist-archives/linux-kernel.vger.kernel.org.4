Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BB3655053
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbiLWMZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiLWMZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:25:06 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D092D3722B;
        Fri, 23 Dec 2022 04:25:05 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [IPv6:2401:4900:1f3f:cd5d:4e48:3b91:9262:9565])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2632A881;
        Fri, 23 Dec 2022 13:24:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671798304;
        bh=Teh9FEdU2+IIKkL8HiQ9YhI22GGJKUCmyjVYueFUfIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AukxRzirNyUq9LMGvC1efBHK5hFNjsMDd2L+BcxWehafa/Dqqgr/cA4dHuWwl5OIS
         gQR5Aj6F3J1Izc1VWO9fs5GcmzUuxZqWv9dvMZ+veLF+ORIGiEqjwKzPPzxLiYEQGT
         8K5UeT7h1Re5J67+u5wTLKc8T73Kir3/q8s1Qjzo=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Kees Cook <keescook@chromium.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v3 6/7] staging: vc04_services: Drop enum vchiq_status remnants
Date:   Fri, 23 Dec 2022 17:54:03 +0530
Message-Id: <20221223122404.170585-7-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221223122404.170585-1-umang.jain@ideasonboard.com>
References: <20221223122404.170585-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop all references to enum vchiq_status as they are no longer in
use.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../include/linux/raspberrypi/vchiq.h              |  4 ----
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 14 +++++++-------
 .../vc04_services/interface/vchiq_arm/vchiq_core.c |  6 +++---
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
index 2ca4461d26ee..66965da11443 100644
--- a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
+++ b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
@@ -17,10 +17,6 @@ enum vchiq_reason {
 	VCHIQ_BULK_RECEIVE_ABORTED    /* service, -, bulk_userdata */
 };
 
-enum vchiq_status {
-	VCHIQ_RETRY   = 1
-};
-
 enum vchiq_bulk_mode {
 	VCHIQ_BULK_MODE_CALLBACK,
 	VCHIQ_BULK_MODE_BLOCKING,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 5cfad840bd18..22de23f3af02 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -751,7 +751,7 @@ static int vchiq_is_connected(struct vchiq_instance *instance)
 
 int vchiq_connect(struct vchiq_instance *instance)
 {
-	enum vchiq_status status;
+	int status;
 	struct vchiq_state *state = instance->state;
 
 	if (mutex_lock_killable(&state->mutex)) {
@@ -778,7 +778,7 @@ vchiq_add_service(struct vchiq_instance *instance,
 		  const struct vchiq_service_params_kernel *params,
 		  unsigned int *phandle)
 {
-	enum vchiq_status status;
+	int status;
 	struct vchiq_state *state = instance->state;
 	struct vchiq_service *service = NULL;
 	int srvstate;
@@ -839,7 +839,7 @@ int
 vchiq_bulk_transmit(struct vchiq_instance *instance, unsigned int handle, const void *data,
 		    unsigned int size, void *userdata, enum vchiq_bulk_mode mode)
 {
-	enum vchiq_status status;
+	int status;
 
 	while (1) {
 		switch (mode) {
@@ -877,7 +877,7 @@ int vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int handle,
 		       void *data, unsigned int size, void *userdata,
 		       enum vchiq_bulk_mode mode)
 {
-	enum vchiq_status status;
+	int status;
 
 	while (1) {
 		switch (mode) {
@@ -915,7 +915,7 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 			     unsigned int size, enum vchiq_bulk_dir dir)
 {
 	struct vchiq_service *service;
-	enum vchiq_status status;
+	int status;
 	struct bulk_waiter_node *waiter = NULL, *iter;
 
 	service = find_service_by_handle(instance, handle);
@@ -1103,7 +1103,7 @@ service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
 			 */
 			if ((user_service->message_available_pos -
 				instance->completion_remove) < 0) {
-				enum vchiq_status status;
+				int status;
 
 				vchiq_log_info(vchiq_arm_log_level,
 					       "Inserting extra MESSAGE_AVAILABLE");
@@ -1330,7 +1330,7 @@ vchiq_keepalive_thread_func(void *v)
 	struct vchiq_state *state = (struct vchiq_state *)v;
 	struct vchiq_arm_state *arm_state = vchiq_platform_get_arm_state(state);
 
-	enum vchiq_status status;
+	int status;
 	struct vchiq_instance *instance;
 	unsigned int ka_handle;
 	int ret;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index ddb6d0f4daed..4e705a447a62 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -2591,7 +2591,7 @@ release_service_messages(struct vchiq_service *service)
 static int
 do_abort_bulks(struct vchiq_service *service)
 {
-	enum vchiq_status status;
+	int status;
 
 	/* Abort any outstanding bulk transfers */
 	if (mutex_lock_killable(&service->bulk_mutex))
@@ -2611,7 +2611,7 @@ do_abort_bulks(struct vchiq_service *service)
 static int
 close_service_complete(struct vchiq_service *service, int failstate)
 {
-	enum vchiq_status status;
+	int status;
 	int is_server = (service->public_fourcc != VCHIQ_FOURCC_INVALID);
 	int newstate;
 
@@ -3212,7 +3212,7 @@ vchiq_queue_message(struct vchiq_instance *instance, unsigned int handle,
 int vchiq_queue_kernel_message(struct vchiq_instance *instance, unsigned int handle, void *data,
 			       unsigned int size)
 {
-	enum vchiq_status status;
+	int status;
 
 	while (1) {
 		status = vchiq_queue_message(instance, handle, memcpy_copy_callback,
-- 
2.38.1

