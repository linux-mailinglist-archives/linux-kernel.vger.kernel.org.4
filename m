Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86175BB6EB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 09:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiIQHYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 03:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiIQHYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 03:24:10 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C831746D9B
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 00:24:05 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220917072401epoutp038f3de2f5b47ac7bbf07cdc9b00b7eebf~VlPqPRuK51395913959epoutp03d
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:24:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220917072401epoutp038f3de2f5b47ac7bbf07cdc9b00b7eebf~VlPqPRuK51395913959epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663399441;
        bh=7oqjZ1Z/LaVMkbr+/m9xMFwzVniafNx0UvQT1oyf8Nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sq05CxXS4TcQk5gBLfMoSRApPAtMbvyPKccX8ztBWL19Qc2D21Z8I1JuKK/M5VtJT
         uZZoPzJXaKG+M++43fs3t7WHRZ7mRePs0Q/olcWDSS/DK8j5ShPKkOp2qWt0Nk5H1q
         YFVLT1sAYehoTFM6swWRJwilqBeneKWlJ2PJgxnA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220917072400epcas1p23895082738cb62ee8fb72b15105595a9~VlPpZdeBs1789517895epcas1p2v;
        Sat, 17 Sep 2022 07:24:00 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.136]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MV2Vl3DJFz4x9Px; Sat, 17 Sep
        2022 07:23:59 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.1D.57013.F0675236; Sat, 17 Sep 2022 16:23:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220917072358epcas1p14997459c7add27bf7b4e9333cbf21b72~VlPnkYgG30249502495epcas1p1T;
        Sat, 17 Sep 2022 07:23:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220917072358epsmtrp1635e9fd7499fd8a9aedab5439ad31c11~VlPnjnzo10556805568epsmtrp1e;
        Sat, 17 Sep 2022 07:23:58 +0000 (GMT)
X-AuditID: b6c32a37-ff5fb7000001deb5-1c-6325760fe916
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.45.14392.E0675236; Sat, 17 Sep 2022 16:23:58 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220917072358epsmtip2428353bfdbf88f60ee1d98f49f887f56~VlPnTWC5t3200232002epsmtip2V;
        Sat, 17 Sep 2022 07:23:58 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de, ogabbay@kernel.org,
        krzysztof.kozlowski@linaro.org, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, yelini.jeong@samsung.com,
        myungjoo.ham@samsung.com, jiho.chu@samsung.com
Subject: [PATCH v2 10/13] trinity: Add profile module
Date:   Sat, 17 Sep 2022 16:23:53 +0900
Message-Id: <20220917072356.2255620-11-jiho.chu@samsung.com>
In-Reply-To: <20220917072356.2255620-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmni5/mWqywebFohZ/Jx1jt5j68Amb
        RfPi9WwW77t3M1vsfb2V3eLyrjlsFrcbV7BZ7Ov5yGjxfNp1FgdOj9+/JjF6bFrVyeZx59oe
        No/9c9ewe/RtWcXo8XmTXABbVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJC
        XmJuqq2Si0+ArltmDtBVSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC0wK94sTc
        4tK8dL281BIrQwMDI1OgwoTsjMk93UwF/xcyVrTM6mNqYDzUytjFyMkhIWAi0fP+NnMXIxeH
        kMAORom1XR1sEM4nRolJnw6wQzjfGCUuHPwF13L98nYWiMReRollF/qYIJzPjBIzp75nA6li
        E1CVmDljDTuILSJQLtG88QSYzSyQI/HkThMziC0sYCrR9XMymM0CVL9jwQ+wGl4BG4lrJ0+D
        xTmB7Jubmlgg4oISJ2c+YYGYIy/RvHU22OESAl/ZJRY0LmSCOM9F4v/no1CnCku8Or6FHcKW
        knjZ3wZlZ0tM6VjEAmEXSJx7vhVoEAeQbSxxcUUKiMksoCmxfpc+RIWixM7fcxkh1vJJvPva
        wwpRzSvR0SYEUaIkseTPYajhEhJTZ3xjgijxkGhZ4w0JnX5Gicv7fzFNYJSfheSZWUiemYWw
        eAEj8ypGsdSC4tz01GLDAmN4tCbn525iBCdNLfMdjNPeftA7xMjEwXiIUYKDWUmEV9VTJVmI
        NyWxsiq1KD++qDQntfgQoykweCcyS4km5wPTdl5JvKGJpYGJmZGxiYWhmaGSOK+eNmOykEB6
        YklqdmpqQWoRTB8TB6dUA5P4BJOf88578v/8bPGd8YTlEa/LH0UmC9rzbU8SPbNx6ZxLL/W2
        fpA58zl67qa+X/WMT/gz5vkfzJl0b9v294fmR07+MzF4N6Ph3hbVjpZX4VUfFn993MZbeLqh
        eVJGAVNbbOfuFUv/Kzkdfuu0xU7KTlTt+J2ySdJfunjYz2mxOuu0/5rgomu3Ucj8469Qj2MC
        y4+0if+9s7A7qeR6slPXMl5dlZl195T0OfiUdVzLxLz76zqV3z0I3aY0x+vP5S8MjF3MXX9z
        Zp7tmsbR8m5FvWPQCe0Xx/beXvVcZMdnYYF5n3aFTLWb37s68ur39GNpxec9TTr/qe5f6nX+
        xfYiLrdtP98czf469brkCu14JZbijERDLeai4kQAtvoLgCMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSvC5fmWqywbSlAhZ/Jx1jt5j68Amb
        RfPi9WwW77t3M1vsfb2V3eLyrjlsFrcbV7BZ7Ov5yGjxfNp1FgdOj9+/JjF6bFrVyeZx59oe
        No/9c9ewe/RtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfG5J5upoL/CxkrWmb1MTUwHmpl7GLk
        5JAQMJG4fnk7SxcjF4eQwG5GiXVXLrJBJCQkNt1bztzFyAFkC0scPlwMUfORUeLP9mNgzWwC
        qhIzZ6xhB7FFBGolDh6dzwxiMwsUSMx+OpMFxBYWMJXo+jkZLM4CVL9jwQ+wel4BG4lrJ0+D
        xTmB7JubmsDqhQSsJWZPn8sEUSMocXLmExaImfISzVtnM09g5J+FJDULSWoBI9MqRsnUguLc
        9NxiwwLDvNRyveLE3OLSvHS95PzcTYzg8NbS3MG4fdUHvUOMTByMhxglOJiVRHhVPVWShXhT
        EiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamDqv3DQ9dNr+RgO
        4+PbPnWss7p2+6rj12v29UExMhe0DXbMUUlabK+9VuXPMe4W40e6nKvPemjv1Ba19KqqFD4e
        OzeVf1GlIavrFdntT2KSlxb5np807VJAvmRexpOvHW09Fq9vsOyP+SF1zE+de+6Fp8WRS7/f
        /bchK31uYsiO8youPuqLP//+zyUoq8Utmmhes6zkUGDXl2t7ej44PYhZbnPiaO6sOJs6T7+b
        N941+p1bvvDmbTHz3dOWe0SwZVZEPjATenbo/qcJ4sV80kIMOk4LnTWk30QX8jydZ/WS7++F
        FLOdLcdvF/Lo+D39d+3h+5DcPWvK5fjDMz9axtrH3OS6IGM0Kd7WTOdZ8SElluKMREMt5qLi
        RABhXMhe3gIAAA==
X-CMS-MailID: 20220917072358epcas1p14997459c7add27bf7b4e9333cbf21b72
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220917072358epcas1p14997459c7add27bf7b4e9333cbf21b72
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
        <CGME20220917072358epcas1p14997459c7add27bf7b4e9333cbf21b72@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for profile module.

The samsung NPU provides internal statistics data,
and it includes memory read/write counts, consumed clock
cycle for each operation. This statistics can be read by
ioctl control command.

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/misc/trinity/trinity_vision2_drv.c    | 326 ++++++++++++++++++
 .../misc/trinity/trinity_vision2_profile.h    | 324 +++++++++++++++++
 2 files changed, 650 insertions(+)
 create mode 100644 drivers/misc/trinity/trinity_vision2_profile.h

diff --git a/drivers/misc/trinity/trinity_vision2_drv.c b/drivers/misc/trinity/trinity_vision2_drv.c
index 3dd89920cdf5..111623322895 100644
--- a/drivers/misc/trinity/trinity_vision2_drv.c
+++ b/drivers/misc/trinity/trinity_vision2_drv.c
@@ -18,6 +18,7 @@
 
 #include "trinity_common.h"
 #include "trinity_sched.h"
+#include "trinity_vision2_profile.h"
 #include "trinity_vision2_regs.h"
 
 #define TRIV2_DRV_GET_PDATA(drv) ((struct triv2_pdata *)(drv->pdata))
@@ -146,6 +147,11 @@ struct triv2_pdata {
 
 	/* back buffer for context switching */
 	struct trinity_dma back_buf;
+
+	/* profiling */
+	struct trinity_dma prof_buf;
+	struct mutex prof_lock;
+	DECLARE_HASHTABLE(prof_htable, TRIV2_PROFILE_HASH_BITS);
 };
 
 static void triv2_idu_setup(struct trinity_driver *drv);
@@ -156,6 +162,150 @@ static void triv2_handle_cmd_done(struct trinity_driver *drv,
 				  struct triv2_cmd *cmd, bool timeout);
 static void triv2_setup_buffers(struct trinity_driver *drv);
 
+static const char *const triv2_op_names[] =
+	TRIV2_FOREACH_OPNAME(TRIV2_GENERATE_OPNAME);
+
+static struct triv2_profile *
+triv2_find_profile(const struct trinity_driver *drv, int req_id)
+{
+	struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+	unsigned long key = TRIV2_PROFILE_HASH_KEY(req_id);
+	struct triv2_profile *profile = NULL;
+
+	hash_for_each_possible(pdata->prof_htable, profile, hlist, key) {
+		if (profile->req_id == req_id)
+			break;
+	}
+
+	return profile;
+}
+
+static void triv2_fini_profile(struct device *dev, struct trinity_dma *prof_buf)
+{
+	if (!prof_buf->addr)
+		return;
+
+	trinity_dma_free(dev, prof_buf);
+	memset(prof_buf, '\x00', sizeof(*prof_buf));
+}
+
+static void triv2_init_profile(struct trinity_driver *drv,
+			       unsigned long profile_size)
+{
+	struct device *dev = drv_to_dev_ptr(drv);
+	struct trinity_dma *prof_buf = TRIV2_DRV_GET_PROF_BUF(drv);
+
+	if (profile_size > 0) {
+		/* allocate profile buffer and enable it */
+		struct iommu_domain *domain;
+		phys_addr_t paddr;
+		int status;
+
+		triv2_fini_profile(dev, prof_buf);
+
+		status = trinity_dma_alloc(dev, profile_size, prof_buf);
+		if (status < 0) {
+			dev_err(dev,
+				"Couldn't allocate memory for profiling buffer: %d",
+				status);
+			return;
+		}
+
+		domain = iommu_get_domain_for_dev(drv_to_dev_ptr(drv));
+		paddr = trinity_get_paddr(domain, prof_buf->dma_handle);
+		iowrite32(TRIV2_IDU_ADDR(paddr),
+			  trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+						 OFFSET_NPU_PROF_ADDR));
+		iowrite32(prof_buf->size,
+			  trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+						 OFFSET_NPU_PROF_SIZE));
+	} else {
+		/* disable profiling */
+		triv2_fini_profile(dev, prof_buf);
+
+		iowrite32(0, trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+						    OFFSET_NPU_PROF_ADDR));
+		iowrite32(0, trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+						    OFFSET_NPU_PROF_SIZE));
+	}
+}
+
+static void triv2_assign_opnames(struct triv2_cmd_profile *cmd)
+{
+	struct triv2_op_profile *ops = cmd->profile_ops;
+	uint32_t i;
+
+	for (i = 0; i < cmd->total_ops; i++)
+		snprintf(ops[i].op_name, TRIV2_MAX_OPNAME, "%s",
+			 triv2_op_names[ops[i].opcode]);
+}
+
+static int32_t triv2_check_profile(struct trinity_driver *drv,
+				   struct trinity_req *req)
+{
+	struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+	struct triv2_req *t_req = TRIV2_GET_REQ(req);
+	struct trinity_dma *profile_buf;
+	struct triv2_cmd_profile *profile_cmd;
+	struct triv2_cmd_profile *profile_cmd_new;
+	struct triv2_profile *profile;
+
+	uint32_t offset = t_req->profile_offset;
+	uint32_t total_ops, total_size;
+
+	profile_buf = TRIV2_DRV_GET_PROF_BUF(drv);
+	if (!profile_buf->addr)
+		return 0;
+
+	if (profile_buf->size <= offset) {
+		dev_err(drv_to_dev_ptr(drv),
+			"Invalid profile offset detected: 0x%x", offset);
+		return -EINVAL;
+	}
+
+	profile_cmd = (struct triv2_cmd_profile *)((char *)profile_buf->addr +
+						   offset);
+	profile_cmd->total_cycles = t_req->total_cycles;
+
+	total_ops = profile_cmd->total_ops;
+	total_size = sizeof(struct triv2_cmd_profile) +
+		     total_ops * sizeof(struct triv2_op_profile);
+
+	profile_cmd_new = vzalloc(total_size);
+	if (!profile_cmd_new)
+		return -ENOMEM;
+
+	mutex_lock(&pdata->prof_lock);
+
+	profile = req->stat->profile;
+	if (profile) {
+		WARN_ON(!profile->data);
+		vfree(profile->data);
+		profile->data = profile_cmd_new;
+	} else {
+		int req_id = req->input.config.req_id;
+		unsigned long key = TRIV2_PROFILE_HASH_KEY(req_id);
+
+		profile = vzalloc(sizeof(struct triv2_profile));
+		if (!profile) {
+			vfree(profile_cmd_new);
+			mutex_unlock(&pdata->prof_lock);
+			return -ENOMEM;
+		}
+		profile->req_id = req_id;
+		profile->data = profile_cmd_new;
+
+		hash_add(pdata->prof_htable, &profile->hlist, key);
+
+		req->stat->profile = profile;
+	}
+	memcpy(profile_cmd_new, profile_cmd, total_size);
+	triv2_assign_opnames(profile_cmd_new);
+
+	mutex_unlock(&pdata->prof_lock);
+	return 0;
+}
+
 /**
  * triv2_get_state() - Get state (TRINITY_STATE_READY/TRINITY_STATE_PAUSE) of the device.
  * @returns (enum triv2_state) TRINITY_STATE_READY (i.e., 1) or TRINITY_STATE_PAUSE (i.e., 0 )
@@ -447,6 +597,157 @@ static void triv2_stop_reqs(struct work_struct *work)
 	triv2_cancel_reqs(drv);
 }
 
+/**
+ * triv2_get_profile_meta() - get profile metadata for the target req
+ */
+static int32_t triv2_get_profile_meta(const struct trinity_driver *drv,
+				      struct trinity_ioctl_profile_meta *meta)
+{
+	struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+	struct triv2_profile *profile;
+	struct triv2_cmd_profile *profile_data;
+	int ret = 0;
+
+	mutex_lock(&pdata->prof_lock);
+
+	profile = triv2_find_profile(drv, meta->req_id);
+	if (!profile) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	profile_data = profile->data;
+	WARN_ON(!profile_data);
+
+	meta->total_cycles = profile_data->total_cycles;
+	meta->total_ops = profile_data->total_ops;
+	meta->profile_size =
+		profile_data->total_ops * sizeof(struct triv2_op_profile);
+	/* unsupported for now */
+	meta->input_footprint = -1;
+	meta->output_footprint = -1;
+
+out:
+	mutex_unlock(&pdata->prof_lock);
+
+	return ret;
+}
+
+/**
+ * triv2_get_profile_buff() - get profile buffer for the target req
+ */
+static int32_t triv2_get_profile_buff(const struct trinity_driver *drv,
+				      struct trinity_ioctl_profile_buff *buff)
+{
+	struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+	struct triv2_profile *profile;
+	struct triv2_cmd_profile *profile_data;
+	uint32_t total_size;
+	int ret = 0;
+
+	mutex_lock(&pdata->prof_lock);
+
+	profile = triv2_find_profile(drv, buff->req_id);
+	if (!profile) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	profile_data = profile->data;
+	WARN_ON(!profile_data);
+
+	profile_data = profile->data;
+	total_size = profile_data->total_ops * sizeof(struct triv2_op_profile);
+
+	if (buff->profile_pos + buff->profile_size > total_size) {
+		dev_err(drv_to_dev_ptr(drv),
+			"Profile data out-of-range! pos(%u) size(%u) > total_size(%u)",
+			buff->profile_pos, buff->profile_size, total_size);
+		ret = -ERANGE;
+		goto out;
+	}
+
+	/* consider partial memory copies */
+	if (copy_to_user((char __user *)buff->profile_buf,
+			 (char *)profile_data->profile_ops + buff->profile_pos,
+			 buff->profile_size))
+		ret = -EACCES;
+
+out:
+	mutex_unlock(&pdata->prof_lock);
+
+	return ret;
+}
+
+static ssize_t triv2_get_profile(const struct trinity_driver *drv, char *buf, int req_id)
+{
+	struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+	struct triv2_profile *profile;
+	struct triv2_cmd_profile *profile_data;
+	uint32_t i;
+	ssize_t len = 0;
+
+	mutex_lock(&pdata->prof_lock);
+
+	profile = triv2_find_profile(drv, req_id);
+	if (!profile) {
+		len += snprintf(buf, PAGE_SIZE, "Unable to find the profile data (req_id %d)",
+			 req_id);
+		goto out;
+	}
+
+	profile_data = profile->data;
+	WARN_ON(!profile_data);
+
+	len += snprintf(buf, PAGE_SIZE, "Total cycles: %lld", profile_data->total_cycles);
+	len += snprintf(buf, PAGE_SIZE, "Total ops: %u", profile_data->total_ops);
+
+	for (i = 0; i < profile_data->total_ops; i++) {
+		struct triv2_op_profile *op = &profile_data->profile_ops[i];
+
+		len += snprintf(buf, PAGE_SIZE, "[%u] opcode: %u name:%s", i, op->opcode,
+				op->op_name);
+		len += snprintf(buf, PAGE_SIZE, "\tcycles: %lld", op->cycles);
+		len += snprintf(buf, PAGE_SIZE, "\tprog_seq: %lld", op->prog_seq);
+		len += snprintf(buf, PAGE_SIZE, "\texec_seq: %lld", op->exec_seq);
+		if (op->dram_read > 0)
+			len += snprintf(buf, PAGE_SIZE, "\tdram_read: %lld", op->dram_read);
+		if (op->dram_write > 0)
+			len += snprintf(buf, PAGE_SIZE, "\tdram_write: %lld", op->dram_write);
+		if (op->sram_read > 0)
+			len += snprintf(buf, PAGE_SIZE, "\tsram_read: %lld", op->sram_read);
+		if (op->sram_write > 0)
+			len += snprintf(buf, PAGE_SIZE, "\tsram_write: %lld", op->sram_write);
+	}
+out:
+	mutex_unlock(&pdata->prof_lock);
+	return len;
+}
+
+/**
+ * triv2_destroy_profile() - destroy profile data
+ */
+static void triv2_destroy_profile(const struct trinity_driver *drv, void *data)
+{
+	struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+	struct triv2_profile *profile = data;
+	struct triv2_cmd_profile *profile_data;
+
+	if (!profile)
+		return;
+
+	mutex_lock(&pdata->prof_lock);
+
+	profile_data = profile->data;
+	WARN_ON(!profile_data);
+	vfree(profile_data);
+
+	hash_del(&profile->hlist);
+	vfree(profile);
+
+	mutex_unlock(&pdata->prof_lock);
+}
+
 static void triv2_handle_irq_cmds(struct trinity_driver *drv)
 {
 	struct triv2_cmd_info *info;
@@ -1021,11 +1322,13 @@ static void triv2_setup_buffers(struct trinity_driver *drv)
 	struct iommu_domain *domain;
 	struct trinity_dma *cmd_buf;
 	struct trinity_dma *back_buf;
+	struct trinity_dma *prof_buf;
 	phys_addr_t paddr;
 
 	domain = iommu_get_domain_for_dev(dev);
 	cmd_buf = TRIV2_DRV_GET_CMD_BUF(drv);
 	back_buf = TRIV2_DRV_GET_BACK_BUF(drv);
+	prof_buf = TRIV2_DRV_GET_PROF_BUF(drv);
 
 	/* command */
 	paddr = trinity_get_paddr(domain, cmd_buf->dma_handle);
@@ -1038,6 +1341,22 @@ static void triv2_setup_buffers(struct trinity_driver *drv)
 					 OFFSET_NPU_BACK_ADDR));
 	iowrite32(back_buf->size, trinity_get_iomem_addr(drv->mmreg_vaddr[0],
 							 OFFSET_NPU_BACK_SIZE));
+
+	/* profile */
+	if (prof_buf->size > 0) {
+		paddr = trinity_get_paddr(domain, prof_buf->dma_handle);
+		iowrite32(TRIV2_IDU_ADDR(paddr),
+			  trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+						 OFFSET_NPU_PROF_ADDR));
+		iowrite32(prof_buf->size,
+			  trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+						 OFFSET_NPU_PROF_SIZE));
+	} else {
+		iowrite32(0, trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+						    OFFSET_NPU_PROF_ADDR));
+		iowrite32(0, trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+						    OFFSET_NPU_PROF_SIZE));
+	}
 }
 
 static int32_t triv2_init_pdata(struct trinity_driver *drv)
@@ -1203,6 +1522,13 @@ static struct trinity_desc triv2_desc = {
 	.dealloc_req = triv2_dealloc_req,
 	.prepare_req = triv2_prepare_req,
 	.invoke_req = triv2_invoke_req,
+	/* profile */
+	.init_profile = triv2_init_profile,
+	.check_profile = triv2_check_profile,
+	.get_profile_meta = triv2_get_profile_meta,
+	.get_profile_buff = triv2_get_profile_buff,
+	.get_profile = triv2_get_profile,
+	.destroy_profile = triv2_destroy_profile,
 	/* etc. */
 	.handle_timeout = triv2_handle_timeout,
 	.stop_reqs = triv2_stop_reqs,
diff --git a/drivers/misc/trinity/trinity_vision2_profile.h b/drivers/misc/trinity/trinity_vision2_profile.h
new file mode 100644
index 000000000000..7e5b169eca6b
--- /dev/null
+++ b/drivers/misc/trinity/trinity_vision2_profile.h
@@ -0,0 +1,324 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/**
+ * Profile header for TRIV2 devices
+ *
+ * Copyright (C) 2021-2022 Samsung Electronics
+ * Copyright (C) 2021 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#ifndef __DRIVERS_MISC_TRINITY_VISION2_PROFILE_H__
+#define __DRIVERS_MISC_TRINITY_VISION2_PROFILE_H__
+
+#include <linux/types.h>
+
+#define TRIV2_MAX_OPNAME	(128)
+#define TRIV2_MAX_PROFILE_SIZE	(256)
+
+/**
+ * struct triv2_op_profile - A profile data per operation
+ *
+ * @op_name: The physical DMA address of this DMA buffer.
+ * @cycles: total number of cycles
+ * @dram_read: a count for dram read
+ * @dram_write: a count for dram write
+ * @sram_read: a count for sram read
+ * @sram_write: a count for sram write
+ * @start_cycles: a count for starting cycles
+ * @end_cycles: a cont for ending cycles
+ * @opcode: operation code
+ * @prog_seq: program sequence number
+ * @exec_seq: execution sequence number
+ * @reserved: reserved
+ */
+struct triv2_op_profile {
+	union {
+		struct {
+			char op_name[TRIV2_MAX_OPNAME];
+
+			int64_t cycles;
+
+			int64_t dram_read;
+			int64_t dram_write;
+
+			int64_t sram_read;
+			int64_t sram_write;
+
+			int64_t start_cycles;
+			int64_t end_cycles;
+
+			uint32_t opcode;
+			int64_t prog_seq;
+			int64_t exec_seq;
+		} __packed;
+		uint8_t reserved[TRIV2_MAX_PROFILE_SIZE];
+	};
+};
+
+/**
+ * struct triv2_cmd_profile - A profile data per command
+ *
+ * @total_cycles: total number of cycles for a command
+ * @total_ops: total operations of command
+ * @profile_ops: list of profile data for operations
+ */
+struct triv2_cmd_profile {
+	int64_t total_cycles;
+	uint32_t total_ops;
+	/* zero-length array */
+	struct triv2_op_profile profile_ops[];
+} __packed;
+
+/**
+ * struct triv2_profile - A profile data
+ *
+ * @req_id: total number of cycles for a command
+ * @hlist: list of profile data
+ * @data: command profile data
+ */
+struct triv2_profile {
+	int req_id;
+	struct hlist_node hlist;
+	struct triv2_cmd_profile *data;
+};
+
+enum {
+	NOP = 0x00,
+	HALT = 0x01,
+	ADMA_IN = 0x02,
+	ADMA_OUT = 0x03,
+	RESCALE_I8 = 0x04,
+	RESCALE_I16 = 0x05,
+	CONVERT_I16_I8 = 0x06,
+	CONVERT_I8_I16 = 0x07,
+	RELUN_I8 = 0x08,
+	RELUN_I16 = 0x09,
+	PRELU_I8 = 0x0A,
+	PRELU_I16 = 0x0B,
+	ADD_I8 = 0x0C,
+	ADD_I16 = 0x0D,
+	REDUCE_MEAN_I8 = 0x0E,
+	REDUCE_MEAN_I16 = 0x0F,
+	MAX_POOL_I8 = 0x10,
+	MAX_POOL_I16 = 0x11,
+	AVG_POOL_I8 = 0x12,
+	AVG_POOL_I16 = 0x13,
+	CONV_I8 = 0x14,
+	CONV_I16 = 0x15,
+	CONVE_I8 = 0x16,
+	CONVE_I16 = 0x17,
+	TCONV_I8 = 0x18,
+	TCONV_I16 = 0x19,
+	MUL_I8 = 0x1A,
+	MUL_I16 = 0x1B,
+	DCONV_I8 = 0x1C,
+	DCONV_I16 = 0x1D,
+	DCONVE_I8 = 0x1E,
+	DCONVE_I16 = 0x1F,
+	CONV_I8_P = 0x20,
+	CONV_I16_P = 0x21,
+	PDMA_IN = 0x40,
+	PDMA_OUT = 0x41,
+	ARGMAX_I8 = 0x42,
+	ARGMAX_I16 = 0x43,
+	RESHAPE_I8 = 0x44,
+	RESHAPE_I16 = 0x45,
+	TRANSPOSE_I8 = 0x46,
+	TRANSPOSE_I16 = 0x47,
+	CONCAT_I8 = 0x48,
+	CONCAT_I16 = 0x49,
+	PAD_I8 = 0x4A,
+	PAD_I16 = 0x4B,
+	STRIDED_SLICE_I8 = 0x4C,
+	STRIDED_SLICE_I16 = 0x4D,
+	CONVERT_FORMAT_I8 = 0x4E,
+	CONVERT_FORMAT_I16 = 0x4F,
+	SIGMOID_I8 = 0x50,
+	SIGMOID_I16 = 0x51,
+	TANH_I8 = 0x52,
+	TANH_I16 = 0x53,
+	ELU_I8 = 0x54,
+	ELU_I16 = 0x55,
+	FLOOR_I8 = 0x56,
+	FLOOR_I16 = 0x57,
+	RSQRT_I8 = 0x58,
+	RSQRT_I16 = 0x59,
+	SQRT_I8 = 0x5A,
+	SQRT_I16 = 0x5B,
+	SOFTMAX_I8 = 0x5C,
+	SOFTMAX_I16 = 0x5D,
+	DIVIDE_I8 = 0x60,
+	DIVIDE_I16 = 0x61,
+	FLOORDIV_I8 = 0x62,
+	FLOORDIV_I16 = 0x63,
+	LOGICAL_OR_I8 = 0x64,
+	LOGICAL_OR_I16 = 0x65,
+	GREATER_I8 = 0x66,
+	GREATER_I16 = 0x67,
+	GREATER_EQUAL_I8 = 0x68,
+	GREATER_EQUAL_I16 = 0x69,
+	POW_I8 = 0x6A,
+	POW_I16 = 0x6B,
+	EXP_I8 = 0x6C,
+	EXP_I16 = 0x6D,
+	NOT_EQUAL_I8 = 0x6E,
+	NOT_EQUAL_I16 = 0x6F,
+	BATCH_TO_SPACE_I8 = 0x70,
+	BATCH_TO_SPACE_I16 = 0x71,
+	SPACE_TO_BATCH_I8 = 0x72,
+	SPACE_TO_BATCH_I16 = 0x73,
+	DEPTH_TO_SPACE_I8 = 0x74,
+	DEPTH_TO_SPACE_I16 = 0x75,
+	SPACE_TO_DEPTH_I8 = 0x76,
+	SPACE_TO_DEPTH_I16 = 0x77,
+	YUV_TO_RGB_I8 = 0x7A,
+	YUV_TO_RGB_I16 = 0x7B,
+	RESIZE_BILINEAR_I8 = 0x7C,
+	RESIZE_BILINEAR_I16 = 0x7D,
+	RESIZE_NEAREST_NEIGHBOR_I8 = 0x7E,
+	RESIZE_NEAREST_NEIGHBOR_I16 = 0x7F,
+	LOCAL_RESPONSE_NORM_I8 = 0x80,
+	LOCAL_RESPONSE_NORM_I16 = 0x81,
+	INSTANCE_NORM_I8 = 0x82,
+	INSTANCE_NORM_I16 = 0x83,
+	REDUCED_SUM_SSUM_I8 = 0x84,
+	REDUCED_SUM_SSUM_I16 = 0x85,
+	REDUCED_SUM_SSUM_ACC_I8 = 0x86,
+	REDUCED_SUM_SSUM_ACC_I16 = 0x87,
+	REDUCED_SUM_2SUM_I8 = 0x88,
+	REDUCED_SUM_2SUM_I16 = 0x89,
+	REDUCED_MEAN_DEV_WSUM_I8 = 0x8A,
+	REDUCED_MEAN_DEV_WSUM_I16 = 0x8B,
+	REDUCED_MEAN_DEV_I8 = 0x8C,
+	REDUCED_MEAN_DEV_I16 = 0x8D,
+	RESCALE_CW_I8 = 0x8E,
+	RESCALE_CW_I16 = 0x8F,
+	REDUCED_MEAN_SCALE_WSUM_I8 = 0x90,
+	REDUCED_MEAN_SCALE_WSUM_I16 = 0x91,
+	RESCALE_CHANNELWISE_I8 = 0x92,
+	RESCALE_CHANNELWISE_I16 = 0x93,
+};
+
+/** generate opnames */
+#define TRIV2_GENERATE_OPNAME(OPNAME)	\
+	[OPNAME] = #OPNAME,
+
+#define TRIV2_FOREACH_OPNAME(GEN)	{\
+	GEN(NOP) \
+	GEN(HALT) \
+	GEN(ADMA_IN) \
+	GEN(ADMA_OUT) \
+	GEN(RESCALE_I8) \
+	GEN(RESCALE_I16) \
+	GEN(CONVERT_I16_I8) \
+	GEN(CONVERT_I8_I16) \
+	GEN(RELUN_I8) \
+	GEN(RELUN_I16) \
+	GEN(PRELU_I8) \
+	GEN(PRELU_I16) \
+	GEN(ADD_I8) \
+	GEN(ADD_I16) \
+	GEN(REDUCE_MEAN_I8) \
+	GEN(REDUCE_MEAN_I16) \
+	GEN(MAX_POOL_I8) \
+	GEN(MAX_POOL_I16) \
+	GEN(AVG_POOL_I8) \
+	GEN(AVG_POOL_I16) \
+	GEN(CONV_I8) \
+	GEN(CONV_I16) \
+	GEN(CONVE_I8) \
+	GEN(CONVE_I16) \
+	GEN(TCONV_I8) \
+	GEN(TCONV_I16) \
+	GEN(MUL_I8) \
+	GEN(MUL_I16) \
+	GEN(DCONV_I8) \
+	GEN(DCONV_I16) \
+	GEN(DCONVE_I8) \
+	GEN(DCONVE_I16) \
+	GEN(CONV_I8_P) \
+	GEN(CONV_I16_P) \
+	GEN(PDMA_IN) \
+	GEN(PDMA_OUT) \
+	GEN(ARGMAX_I8) \
+	GEN(ARGMAX_I16) \
+	GEN(RESHAPE_I8) \
+	GEN(RESHAPE_I16) \
+	GEN(TRANSPOSE_I8) \
+	GEN(TRANSPOSE_I16) \
+	GEN(CONCAT_I8) \
+	GEN(CONCAT_I16) \
+	GEN(PAD_I8) \
+	GEN(PAD_I16) \
+	GEN(STRIDED_SLICE_I8) \
+	GEN(STRIDED_SLICE_I16) \
+	GEN(CONVERT_FORMAT_I8) \
+	GEN(CONVERT_FORMAT_I16) \
+	GEN(SIGMOID_I8) \
+	GEN(SIGMOID_I16) \
+	GEN(TANH_I8) \
+	GEN(TANH_I16) \
+	GEN(ELU_I8) \
+	GEN(ELU_I16) \
+	GEN(FLOOR_I8) \
+	GEN(FLOOR_I16) \
+	GEN(RSQRT_I8) \
+	GEN(RSQRT_I16) \
+	GEN(SQRT_I8) \
+	GEN(SQRT_I16) \
+	GEN(SOFTMAX_I8) \
+	GEN(SOFTMAX_I16) \
+	GEN(DIVIDE_I8) \
+	GEN(DIVIDE_I16) \
+	GEN(FLOORDIV_I8) \
+	GEN(FLOORDIV_I16) \
+	GEN(LOGICAL_OR_I8) \
+	GEN(LOGICAL_OR_I16) \
+	GEN(GREATER_I8) \
+	GEN(GREATER_I16) \
+	GEN(GREATER_EQUAL_I8) \
+	GEN(GREATER_EQUAL_I16) \
+	GEN(POW_I8) \
+	GEN(POW_I16) \
+	GEN(EXP_I8) \
+	GEN(EXP_I16) \
+	GEN(NOT_EQUAL_I8) \
+	GEN(NOT_EQUAL_I16) \
+	GEN(BATCH_TO_SPACE_I8) \
+	GEN(BATCH_TO_SPACE_I16) \
+	GEN(SPACE_TO_BATCH_I8) \
+	GEN(SPACE_TO_BATCH_I16) \
+	GEN(DEPTH_TO_SPACE_I8) \
+	GEN(DEPTH_TO_SPACE_I16) \
+	GEN(SPACE_TO_DEPTH_I8) \
+	GEN(SPACE_TO_DEPTH_I16) \
+	GEN(YUV_TO_RGB_I8) \
+	GEN(YUV_TO_RGB_I16) \
+	GEN(RESIZE_BILINEAR_I8) \
+	GEN(RESIZE_BILINEAR_I16) \
+	GEN(RESIZE_NEAREST_NEIGHBOR_I8) \
+	GEN(RESIZE_NEAREST_NEIGHBOR_I16) \
+	GEN(LOCAL_RESPONSE_NORM_I8) \
+	GEN(LOCAL_RESPONSE_NORM_I16) \
+	GEN(INSTANCE_NORM_I8) \
+	GEN(INSTANCE_NORM_I16) \
+	GEN(REDUCED_SUM_SSUM_I8) \
+	GEN(REDUCED_SUM_SSUM_I16) \
+	GEN(REDUCED_SUM_SSUM_ACC_I8) \
+	GEN(REDUCED_SUM_SSUM_ACC_I16) \
+	GEN(REDUCED_SUM_2SUM_I8) \
+	GEN(REDUCED_SUM_2SUM_I16) \
+	GEN(REDUCED_MEAN_DEV_WSUM_I8) \
+	GEN(REDUCED_MEAN_DEV_WSUM_I16) \
+	GEN(REDUCED_MEAN_DEV_I8) \
+	GEN(REDUCED_MEAN_DEV_I16) \
+	GEN(RESCALE_CW_I8) \
+	GEN(RESCALE_CW_I16) \
+	GEN(REDUCED_MEAN_SCALE_WSUM_I8) \
+	GEN(REDUCED_MEAN_SCALE_WSUM_I16) \
+	GEN(RESCALE_CHANNELWISE_I8) \
+	GEN(RESCALE_CHANNELWISE_I16) \
+}
+#endif /* __DRIVERS_MISC_TRINITY_VISION2_PROFILE_H__ */
-- 
2.25.1

