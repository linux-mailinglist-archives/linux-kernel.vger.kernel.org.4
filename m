Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6B9696818
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjBNPaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjBNPaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:30:14 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F03046A1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:30:12 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r2so16053343wrv.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7LiBc+IEi5GSzALdS1gVE7cwYWbpTvaEbHdfomWycl4=;
        b=qqLL5EvXU1B2z6vPs3vAEdKZzORW1NJ+JGa/ij7SuI9OK6PZA+Kwd/EIY2yJzRtfuz
         oP5+rsKq1l8DtMswP/4cTEb9w9U8JucUTAlx2CxOEOssaTlHFmbzDV96CuqVq/9W4miU
         FClwoY5mcIByWI/xGjscyg9fFsQZjBMqBX9ovhcJweue9IoaHT/xP+qgxIq2hOPQnKG5
         fuDFk/kx3GvtepxKuye5bjjyZGUTojaUAyIHglqZFeYZtDau1ddZL5WGxv6pgoCQamp3
         mJ3v0D3jAQA6M4BiC2mzIBt8pvkhgIfsfOfec6styMEG5kBvMadXZVsqzBoNFmdivGAV
         tM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LiBc+IEi5GSzALdS1gVE7cwYWbpTvaEbHdfomWycl4=;
        b=aJa4pyviDDVJLHu0wUpGFpUlhb764oRJ0y0e6QV/ujn9eXmcEBPcxS+yLvFIDBv7Ck
         ypannsO+kO2e7vHAsoUAY4RZKyxVxBga6P2mO8cG8IxzKiRICtENx7uBHLi4bkzhftn6
         zoGfwqZ9a19VRK7Tun+FF2xw8A8q+0yKNBv0XNKXHi7m41kA6cdQucDM5a2bzQZrnVZM
         ZBQAzwKUnxH8iVXxgvdRDsmF2pOoUEnQxplMbCzW9u4X+KjygFyJSe6F1dB7imhlX6ty
         tMnW96v0fcTTlcFHj+OkU/hXqi87wjOVqG5iFHXxGEYf3uIyb8dukCsfFTVvl2l3mQgI
         RXIg==
X-Gm-Message-State: AO0yUKWdzMF8Ev9ZRisUcyV5ZN7TDrgc4rgvpI/5gtSX0mQq/JJtuMJO
        EBZpPU2HuyLJQZx6I70GLyzg23iMxCkkxHUe
X-Google-Smtp-Source: AK7set8NW4LzDC0f2hrJuKWKMbBkqlXzlPBaikxKRKgTwWY8rzIcatl/dKYjWL7U72THc4JCa1+y4w==
X-Received: by 2002:a5d:458d:0:b0:2c3:d657:e951 with SMTP id p13-20020a5d458d000000b002c3d657e951mr2621913wrq.29.1676388610543;
        Tue, 14 Feb 2023 07:30:10 -0800 (PST)
Received: from lmecxl1178.lme.st.com ([80.214.29.100])
        by smtp.gmail.com with ESMTPSA id a4-20020adfeec4000000b002bfc0558ecdsm13224166wrp.113.2023.02.14.07.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:30:09 -0800 (PST)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        op-tee@lists.trustedfirmware.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v2 1/2] tee: system invocation
Date:   Tue, 14 Feb 2023 16:20:46 +0100
Message-Id: <20230214152047.1143106-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds TEE system invocation context provisioning for a Linux driver
to provision execution contexts for invocation of system service
hosted in TEE. OP-TEE SMC ABI implements such invocation context
provisioning.

This feature is needed when a TEE invocation cannot afford to wait for
a free TEE thread when all TEE threads context are used and suspended
as these may be suspended waiting for a system service, as an SCMI clock
or voltage regulator, to be enabled. An example is when OP-TEE invokes
a Linux OS remote service (RPC) to access an eMMC RPMB partition and
the eMMC device is supplied by an OP-TEE SCMI regulator.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Change since v1
- Addressed comment on Linux client to claim reservation on TEE context.
  This brings 2 new operations from client to TEE to request and release
  system thread contexts: 2 new tee_drv.h API functions, 2 new ops
  functions in struct tee_driver_ops. The OP-TEE implement shall implement
  2 new fastcall SMC funcIDs.
- Fixed typos in commit message.
---
 drivers/tee/optee/optee_smc.h | 60 +++++++++++++++++++++++++++++++++--
 drivers/tee/optee/smc_abi.c   | 34 +++++++++++++++++++-
 drivers/tee/tee_core.c        | 30 ++++++++++++++++++
 include/linux/tee_drv.h       | 21 ++++++++++++
 4 files changed, 141 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index 73b5e7760d10..75b19e1bd185 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -108,7 +108,8 @@ struct optee_smc_call_get_os_revision_result {
  * Call with struct optee_msg_arg as argument
  *
  * When called with OPTEE_SMC_CALL_WITH_RPC_ARG or
- * OPTEE_SMC_CALL_WITH_REGD_ARG in a0 there is one RPC struct optee_msg_arg
+ * OPTEE_SMC_CALL_WITH_REGD_ARG or OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG
+ * in a0 there is one RPC struct optee_msg_arg
  * following after the first struct optee_msg_arg. The RPC struct
  * optee_msg_arg has reserved space for the number of RPC parameters as
  * returned by OPTEE_SMC_EXCHANGE_CAPABILITIES.
@@ -130,8 +131,8 @@ struct optee_smc_call_get_os_revision_result {
  * a4-6	Not used
  * a7	Hypervisor Client ID register
  *
- * Call register usage, OPTEE_SMC_CALL_WITH_REGD_ARG:
- * a0	SMC Function ID, OPTEE_SMC_CALL_WITH_REGD_ARG
+ * Call register usage, OPTEE_SMC_CALL_WITH_REGD_ARG and OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG:
+ * a0	SMC Function ID, OPTEE_SMC_CALL_WITH_REGD_ARG or OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG
  * a1	Upper 32 bits of a 64-bit shared memory cookie
  * a2	Lower 32 bits of a 64-bit shared memory cookie
  * a3	Offset of the struct optee_msg_arg in the shared memory with the
@@ -175,6 +176,8 @@ struct optee_smc_call_get_os_revision_result {
 	OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG)
 #define OPTEE_SMC_CALL_WITH_REGD_ARG \
 	OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG)
+#define OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG \
+	OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG)
 
 /*
  * Get Shared Memory Config
@@ -254,6 +257,8 @@ struct optee_smc_get_shm_config_result {
 #define OPTEE_SMC_SEC_CAP_ASYNC_NOTIF		BIT(5)
 /* Secure world supports pre-allocating RPC arg struct */
 #define OPTEE_SMC_SEC_CAP_RPC_ARG		BIT(6)
+/* Secure world provisions thread for system service invocation */
+#define OPTEE_SMC_SEC_CAP_SYSTEM_THREAD		BIT(7)
 
 #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES	9
 #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
@@ -426,6 +431,55 @@ struct optee_smc_disable_shm_cache_result {
 /* See OPTEE_SMC_CALL_WITH_REGD_ARG above */
 #define OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG	19
 
+/* See OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG above */
+#define OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG	20
+
+/*
+ * Request reservation of a system invocation thread context in OP-TEE
+ *
+ * Call register usage:
+ * a0	SMC Function ID: OPTEE_SMC_CALL_RESERVE_SYS_THREAD
+ * a1-6	Not used
+ * a7	Hypervisor Client ID register
+ *
+ * Normal return register usage:
+ * a0	Return value, OPTEE_SMC_RETURN_*
+ * a1-3	Not used
+ * a4-7	Preserved
+ *
+ * Possible return values:
+ * OPTEE_SMC_RETURN_UNKNOWN_FUNCTION	Trusted OS does not recognize this
+ *                                      function.
+ * OPTEE_SMC_RETURN_OK			Call successfully completed.
+ * OPTEE_SMC_RETURN_ETHREAD_LIMIT	Number of Trusted OS threads exceeded
+ *                                      for the request.
+ */
+#define OPTEE_SMC_FUNCID_CALL_RESERVE_SYS_THREAD	21
+#define OPTEE_SMC_CALL_RESERVE_SYS_THREAD \
+	OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_RESERVE_SYS_THREAD)
+
+/*
+ * Unregister reservation of a system invocation thread context in OP-TEE
+ *
+ * Call register usage:
+ * a0	SMC Function ID: OPTEE_SMC_CALL_UNRESERVE_SYS_THREAD
+ * a1-6	Not used
+ * a7	Hypervisor Client ID register
+ *
+ * Normal return register usage:
+ * a0	Return value, OPTEE_SMC_RETURN_*
+ * a1-3	Not used
+ * a4-7	Preserved
+ *
+ * Possible return values:
+ * OPTEE_SMC_RETURN_UNKNOWN_FUNCTION	Trusted OS does not recognize this
+ *                                      function.
+ * OPTEE_SMC_RETURN_OK			Call successfully completed.
+ */
+#define OPTEE_SMC_FUNCID_CALL_UNRESERVE_SYS_THREAD	22
+#define OPTEE_SMC_CALL_UNRESERVE_SYS_THREAD \
+	OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_UNRESERVE_SYS_THREAD)
+
 /*
  * Resume from RPC (for example after processing a foreign interrupt)
  *
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a1c1fa1a9c28..013b5ae31c0e 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -889,7 +889,10 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
 	}
 
 	if  (rpc_arg && tee_shm_is_dynamic(shm)) {
-		param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
+		if (ctx->system_ctx_count)
+			param.a0 = OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG;
+		else
+			param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
 		reg_pair_from_64(&param.a1, &param.a2, (u_long)shm);
 		param.a3 = offs;
 	} else {
@@ -1085,6 +1088,33 @@ static int optee_smc_open(struct tee_context *ctx)
 	return optee_open(ctx, sec_caps & OPTEE_SMC_SEC_CAP_MEMREF_NULL);
 }
 
+static int optee_request_sys_ctx(struct tee_context *ctx)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+	struct arm_smccc_res res;
+
+	if (!(optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SYSTEM_THREAD))
+		return -EINVAL;
+
+	optee->smc.invoke_fn(OPTEE_SMC_CALL_RESERVE_SYS_THREAD,
+			     0, 0, 0, 0, 0, 0, 0, &res);
+
+	if (res.a0 != OPTEE_SMC_RETURN_OK)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void optee_release_sys_ctx(struct tee_context *ctx)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+	struct arm_smccc_res res;
+
+	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SYSTEM_THREAD)
+		optee->smc.invoke_fn(OPTEE_SMC_CALL_UNRESERVE_SYS_THREAD,
+				     0, 0, 0, 0, 0, 0, 0, &res);
+}
+
 static const struct tee_driver_ops optee_clnt_ops = {
 	.get_version = optee_get_version,
 	.open = optee_smc_open,
@@ -1095,6 +1125,8 @@ static const struct tee_driver_ops optee_clnt_ops = {
 	.cancel_req = optee_cancel_req,
 	.shm_register = optee_shm_register,
 	.shm_unregister = optee_shm_unregister,
+	.system_ctx_request = optee_request_sys_ctx,
+	.system_ctx_release = optee_release_sys_ctx,
 };
 
 static const struct tee_desc optee_clnt_desc = {
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 98da206cd761..a7dfdea5d85b 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -5,6 +5,7 @@
 
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
+#include <linux/bug.h>
 #include <linux/cdev.h>
 #include <linux/cred.h>
 #include <linux/fs.h>
@@ -1141,10 +1142,39 @@ EXPORT_SYMBOL_GPL(tee_client_open_context);
 
 void tee_client_close_context(struct tee_context *ctx)
 {
+	while (ctx->system_ctx_count)
+		tee_client_release_system_context(ctx);
+
 	teedev_close_context(ctx);
 }
 EXPORT_SYMBOL_GPL(tee_client_close_context);
 
+int tee_client_request_system_context(struct tee_context *ctx)
+{
+	int ret;
+
+	if (!ctx->teedev->desc->ops->system_ctx_request ||
+	    !ctx->teedev->desc->ops->system_ctx_release)
+		return -EINVAL;
+
+	ret = ctx->teedev->desc->ops->system_ctx_request(ctx);
+	if (!ret)
+		ctx->system_ctx_count++;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tee_client_request_system_context);
+
+void tee_client_release_system_context(struct tee_context *ctx)
+{
+	if (ctx->system_ctx_count &&
+	    ctx->teedev->desc->ops->system_ctx_release) {
+		ctx->teedev->desc->ops->system_ctx_release(ctx);
+		ctx->system_ctx_count--;
+	}
+}
+EXPORT_SYMBOL_GPL(tee_client_release_system_context);
+
 void tee_client_get_version(struct tee_context *ctx,
 			    struct tee_ioctl_version_data *vers)
 {
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 17eb1c5205d3..45577256bb71 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -47,6 +47,8 @@ struct tee_shm_pool;
  *              non-blocking in nature.
  * @cap_memref_null: flag indicating if the TEE Client support shared
  *                   memory buffer with a NULL pointer.
+ * @system_ctx_count: Number of system invocation contexts provisioned for
+ *                    this TEE client or 0.
  */
 struct tee_context {
 	struct tee_device *teedev;
@@ -55,6 +57,7 @@ struct tee_context {
 	bool releasing;
 	bool supp_nowait;
 	bool cap_memref_null;
+	unsigned int system_ctx_count;
 };
 
 struct tee_param_memref {
@@ -90,6 +93,8 @@ struct tee_param {
  * @supp_send:		called for supplicant to send a response
  * @shm_register:	register shared memory buffer in TEE
  * @shm_unregister:	unregister shared memory buffer in TEE
+ * @system_ctx_request:	Request provisioning of a new system context in TEE
+ * @system_ctx_release:	Release a provisioned system context in TEE
  */
 struct tee_driver_ops {
 	void (*get_version)(struct tee_device *teedev,
@@ -112,6 +117,8 @@ struct tee_driver_ops {
 			    struct page **pages, size_t num_pages,
 			    unsigned long start);
 	int (*shm_unregister)(struct tee_context *ctx, struct tee_shm *shm);
+	int (*system_ctx_request)(struct tee_context *ctx);
+	void (*system_ctx_release)(struct tee_context *ctx);
 };
 
 /**
@@ -397,6 +404,20 @@ tee_client_open_context(struct tee_context *start,
  */
 void tee_client_close_context(struct tee_context *ctx);
 
+/**
+ * tee_client_request_system_context() - Close a TEE context
+ * @ctx:	TEE context to close
+ *
+ * @return 0 on success else an error code
+ */
+int tee_client_request_system_context(struct tee_context *ctx);
+
+/**
+ * tee_client_release_system_context() - Release a reserved system exec context
+ * @ctx:	TEE context reference
+ */
+void tee_client_release_system_context(struct tee_context *ctx);
+
 /**
  * tee_client_get_version() - Query version of TEE
  * @ctx:	TEE context to TEE to query
-- 
2.25.1

