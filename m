Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBC16AC3C6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCFOtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjCFOsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:48:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975D82CFC5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:48:35 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326DgsKt005152;
        Mon, 6 Mar 2023 14:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=wVTC4Q0LT3YwvLMJ74q3RRO4VzGWhpReLaEZ6kOGOjU=;
 b=hHoXNYDqZrq+Krf4b8bp2Fl9sQRumlYnP8NazM0eLdgg02/kxoH3CZzmHG7j5l1IWB9l
 xXkvQVJD2LeselaQk1ktUL5XxQ7kiKem3mct69tFA35DJRm/tbjL50/UCNXXiFN3FtDE
 HNNqaCudtDAVFDCFTqWhtE7uOwEk0PaoMLzbAWh71VR1NTBYuaJLVyFDf4rX0SzbuyfG
 jzbPPCbre6l5WQW3OozB1AgEMcWgO/i9pobEy6b+t3dqg5MiYHXPDUMkNRcyEfLHFPSA
 YM0Ll1d+xcdMPAJTXa6lLij58gsxZfK9ge3aizaw48zYsFLJVhCbO1AqAVJW4Nz3tlID DQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p419151dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 14:48:17 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 326EmDPa018021;
        Mon, 6 Mar 2023 14:48:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3p4fft5j5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 06 Mar 2023 14:48:13 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 326EfjQI011965;
        Mon, 6 Mar 2023 14:48:12 GMT
Received: from mdalam-linux.qualcomm.com (mdalam-linux.qualcomm.com [10.201.2.71])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 326EmCk1018016;
        Mon, 06 Mar 2023 14:48:12 +0000
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id A926112010CA; Mon,  6 Mar 2023 20:18:11 +0530 (IST)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     quic_sjaganat@quicinc.com, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, quic_mdalam@quicinc.com
Subject: [PATCH 5/5] mtd: rawnand: Fix spelling mistake waifunc() -> waitfunc()
Date:   Mon,  6 Mar 2023 20:18:10 +0530
Message-Id: <20230306144810.22078-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NFv1m6xKYlTOOm9i4MozZSTPosqoRhLu
X-Proofpoint-GUID: NFv1m6xKYlTOOm9i4MozZSTPosqoRhLu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_08,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=848
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060130
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a chip->legacy.waifunc(). Fix it.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 include/linux/mtd/rawnand.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index f8d4be9c587a..5159d692f9ce 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1075,7 +1075,7 @@ static inline void nand_op_trace(const char *prefix,
  * @exec_op:	 controller specific method to execute NAND operations.
  *		 This method replaces chip->legacy.cmdfunc(),
  *		 chip->legacy.{read,write}_{buf,byte,word}(),
- *		 chip->legacy.dev_ready() and chip->legacy.waifunc().
+ *		 chip->legacy.dev_ready() and chip->legacy.waitfunc().
  * @setup_interface: setup the data interface and timing. If chipnr is set to
  *		     %NAND_DATA_IFACE_CHECK_ONLY this means the configuration
  *		     should not be applied but only checked.
-- 
2.17.1

