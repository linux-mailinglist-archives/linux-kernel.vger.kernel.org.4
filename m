Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A7873095B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbjFNUm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbjFNUmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:42:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802B9268B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:42:18 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EJtEOa018110;
        Wed, 14 Jun 2023 20:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=PHe5HfxjOkcRnacOoCZlGZI8u+HsglkIVmO3NBIpEb8=;
 b=Oc/Lq8ZjDXzr+arONZeMk3tXQjhxFPq2/fgtAOPLOJsmKtdo4SFaz/9zfUHcAZVPiXEj
 nvQaLcwlWg55ZLe/gJLUCncJHmETlq56NkoTo0zInfBabGO3wdVzlqQkqnat4fkfeob9
 NCtg1oObbGUe6PgDtVP2+ToXZR7Ib9xsROHwK1uBuEywCgglVhjUR1LhL233H1WAOxCX
 0FOHhFOC7jRSuR3CQ2nyVRXCXjsRgjLJs5eiNO6mrt2+FxNsJ1LySNFMIwws/5/8uC9V
 fjAeiq0v5BcR8HwLBK+2Ee4B9vvTidC0SxeVVRFNXipvJZAA4je+xmQ4Vz27WlRM0qaX Xg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7d8jeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 20:41:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35EKYLXc008966;
        Wed, 14 Jun 2023 20:41:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm6bquq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 20:41:15 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35EKfEmi021978;
        Wed, 14 Jun 2023 20:41:14 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3r4fm6bqtm-1;
        Wed, 14 Jun 2023 20:41:14 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     error27@gmail.com, dan.carpenter@linaro.org
Subject: [PATCH next] drm/i915/huc: Fix missing error code in intel_huc_init()
Date:   Wed, 14 Jun 2023 13:41:06 -0700
Message-ID: <20230614204109.3071989-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306140181
X-Proofpoint-ORIG-GUID: aW4V0k6qElqU-6NSCbtVSQLe_FsutlCL
X-Proofpoint-GUID: aW4V0k6qElqU-6NSCbtVSQLe_FsutlCL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch warns:
	drivers/gpu/drm/i915/gt/uc/intel_huc.c:388
	    intel_huc_init() warn: missing error code 'err'

When the allocation of VMAs fail: The value of err is zero at this
point and it is passed to PTR_ERR and also finally returning zero which
is success instead of failure.

Fix this by adding the missing error code when VMA allocation fails.

Fixes: 08872cb13a71 ("drm/i915/mtl/huc: auth HuC via GSC")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Found using Static analysis with Smatch, only compile tested.
---
 drivers/gpu/drm/i915/gt/uc/intel_huc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_huc.c b/drivers/gpu/drm/i915/gt/uc/intel_huc.c
index e0afd8f89502..ddd146265beb 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_huc.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_huc.c
@@ -384,6 +384,7 @@ int intel_huc_init(struct intel_huc *huc)
 
 		vma = intel_guc_allocate_vma(&gt->uc.guc, PXP43_HUC_AUTH_INOUT_SIZE * 2);
 		if (IS_ERR(vma)) {
+			err = PTR_ERR(vma);
 			huc_info(huc, "Failed to allocate heci pkt\n");
 			goto out;
 		}
-- 
2.41.0

