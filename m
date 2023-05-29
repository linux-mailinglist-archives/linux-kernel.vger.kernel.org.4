Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EDA714F31
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 20:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjE2SQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 14:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjE2SQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 14:16:40 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D092FB2;
        Mon, 29 May 2023 11:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685384180; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fGCz6MR52Py5EN3ZqM7TG5K1oVxWYP8oijlEJn/Cc3r2Gp2ZM/EjJMR1f9+RTMbsbg
    OkgkVJiun/3ZIJ84yPa+iPuBP4TYNqGvRs/8q8Dl3s3Nr1z8XhL0aNGIxSxLgDzwkAXB
    hzfY/Ccd5GToYPUHKwkRPj8ad1uT+336t+cTuguHwRWsRhy5RI5cTNZwYfTcpwHLDf3B
    JykdHBvNSOLp7hO1pQ+nJ1qbBnUcy80qJKIVFHTdZhmFBr7oTRc+ipvSL4f3969dD2B6
    Ju9VA/pBGYIJ+WtErJMWMK3PQwjC51oAiRDIKHpBH9nrTt/1A1NzENYpoQh2qx/rKcqh
    zKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685384180;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=iGWBPD3uogSn/L1mafusnNllSHOos35ANb0AXOoTCxo=;
    b=Bk8ZFBFH05Al1Hs9bKUt11c6UmFcWTIWkWLIGb9gwtSxJXg4ZnouNKvdaLTwAWjlWG
    ick32I0rBTom7qP2v19NYf5tabr7o4dFfISTkRuO5KV8/i1uFbEV44aODV4VA6vGO8Dn
    LcJQIWojHu+aJiXi7aNYOTBMNKh9Hz5rAJjea9gFbYG4V/H/KGc1FrOXL+EGnQeXgW7T
    IpOlXbOeADs4CChy8jSNrVDEehXMK86BbBdTSxqpHjMHn4GEJ/PQb/BH1SwHmyW8AMah
    Q5U4cFfyggYu1uO/WVqElhdx2yu5GxhDHRl7bVRASnSGQb0H2bhnvgzfy8dhZ/G/8E4C
    3MFg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685384180;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=iGWBPD3uogSn/L1mafusnNllSHOos35ANb0AXOoTCxo=;
    b=fFLJfxDzXU6Gk2w3otHywVuh6SZHy0e1tF/bqI9+NYMtuhszXUSofD0BMkz51Ocgwf
    mA85ueMFVik8NTbU5Qdr+QcLfRwGMMHObYZ7Ccd5I5K+Zt3aa/rCWmbmqKNVOTt6SGpb
    luqGOI9zOBPBT6JTUYfgIt+xlOgQgD4mxDx41cyDh3qGkmYKW39RUh0CqveER4Ydq6zQ
    W/YQ+S+U5z8Bij4Tt33+Jz6smF4wnQ5qi7ONbHQsRCCrTzNK0Y+mJbzuwjMUkINQrFAt
    a6aXu9HXHaWuLQ77qcjeJkTR0+jKGwzC2xHPynAWY5IW83MBn9kaHKUVdx724+fPBLvQ
    do5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685384180;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=iGWBPD3uogSn/L1mafusnNllSHOos35ANb0AXOoTCxo=;
    b=usKV9G8KbWMtIMDhJ6H5IL+cXEv/7oBteQGXTP72fqX5uUiOvdguRsknhkeyV81+Hn
    r4aVBaSAJH3tjoKnIUAg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOH8mT0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4TIGJfUJ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 29 May 2023 20:16:19 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 29 May 2023 20:16:14 +0200
Subject: [PATCH] media: venus: firmware: Use of_reserved_mem_lookup()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230529-venus-of-rmem-v1-1-dfcdc5047ffb@gerhold.net>
X-B4-Tracking: v=1; b=H4sIAO3rdGQC/x2NQQqDQAwAvyI5N+ButWi/Ujysmq0BjSVBKYh/N
 3icgWEOMFImg3dxgNLOxqs4hEcBw5TkS8ijM8QyPss6triTbIZrRl1owfyq2qapQ6jyCN70yQh
 7TTJMXsk2zy5/Spn/9+TTnecFsGiK2HQAAAA=
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Cc:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reserved memory can be either looked up using the generic function
of_address_to_resource() or using the special of_reserved_mem_lookup().
The latter has the advantage that it ensures that the referenced memory
region was really reserved and is not e.g. status = "disabled".

of_reserved_mem also supports allocating reserved memory dynamically at
boot time. This works only when using of_reserved_mem_lookup() since
there won't be a fixed address in the device tree.

Switch the code to use of_reserved_mem_lookup(). There is no functional
difference for static reserved memory allocations.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
See e.g. [1] for an example of dynamically allocated reserved memory.
(This patch does *not* depend on [1] and is useful without as well...)

[1]: https://lore.kernel.org/linux-arm-msm/20230510-dt-resv-bottom-up-v1-5-3bf68873dbed@gerhold.net/
---
 drivers/media/platform/qcom/venus/firmware.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index cfb11c551167..2e7ffdaff7b2 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -10,6 +10,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
 #include <linux/firmware/qcom/qcom_scm.h>
@@ -82,9 +83,9 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
 			 phys_addr_t *mem_phys, size_t *mem_size)
 {
 	const struct firmware *mdt;
+	struct reserved_mem *rmem;
 	struct device_node *node;
 	struct device *dev;
-	struct resource r;
 	ssize_t fw_size;
 	void *mem_va;
 	int ret;
@@ -99,13 +100,16 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
 		return -EINVAL;
 	}
 
-	ret = of_address_to_resource(node, 0, &r);
-	if (ret)
-		goto err_put_node;
+	rmem = of_reserved_mem_lookup(node);
+	of_node_put(node);
+	if (!rmem) {
+		dev_err(dev, "failed to lookup reserved memory-region\n");
+		return -EINVAL;
+	}
 
 	ret = request_firmware(&mdt, fwname, dev);
 	if (ret < 0)
-		goto err_put_node;
+		return ret;
 
 	fw_size = qcom_mdt_get_size(mdt);
 	if (fw_size < 0) {
@@ -113,17 +117,17 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
 		goto err_release_fw;
 	}
 
-	*mem_phys = r.start;
-	*mem_size = resource_size(&r);
+	*mem_phys = rmem->base;
+	*mem_size = rmem->size;
 
 	if (*mem_size < fw_size || fw_size > VENUS_FW_MEM_SIZE) {
 		ret = -EINVAL;
 		goto err_release_fw;
 	}
 
-	mem_va = memremap(r.start, *mem_size, MEMREMAP_WC);
+	mem_va = memremap(*mem_phys, *mem_size, MEMREMAP_WC);
 	if (!mem_va) {
-		dev_err(dev, "unable to map memory region: %pR\n", &r);
+		dev_err(dev, "unable to map memory region %pa size %#zx\n", mem_phys, *mem_size);
 		ret = -ENOMEM;
 		goto err_release_fw;
 	}
@@ -138,8 +142,6 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
 	memunmap(mem_va);
 err_release_fw:
 	release_firmware(mdt);
-err_put_node:
-	of_node_put(node);
 	return ret;
 }
 

---
base-commit: 9f9f8ca6f012d25428f8605cb36369a449db8508
change-id: 20230529-venus-of-rmem-f649885114fd

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

