Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B67674F76A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjGKRnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjGKRnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:43:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D729E4F;
        Tue, 11 Jul 2023 10:43:41 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BEGjM4027139;
        Tue, 11 Jul 2023 17:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=3vjL928j0n+XCcEgXGqLu933Dl3PXe7plpkKxDB5HQQ=;
 b=VqzLNTUv2zFiRkbhb2Mf+BqfyeQpOoZBvl71/DJMnNfc/kM7VD0ga1wVVmQbDbphyELl
 B7uGZ3GsiZV9cs32G/WJiII0jLlg11M3LAf5JFhXBAIzVir14r4tJrX7nfopKMLjoqgY
 uZK2TU2cw802twZddSYOciBn4TOka133LlnGCKyGgw8y7bEKgF9V9a2nvf4bSk+GVmSX
 Aed5e/A6x7H3d16fg8HoApXUB0ZZVFJzmO4DffHY5xeeFvhChfkp5WIF6RlI7FHhfkCy
 E7zH6JOVNOuiNLUM51iDveGvbW8pcMwd8+61cWbvwPcb829lLn9wCpnPiJqNnMURPrg3 Dw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs8nt0mc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 17:43:25 +0000
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36BHhO9J019636;
        Tue, 11 Jul 2023 17:43:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rrq09bt90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Jul 2023 17:43:24 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36BHhN47019628;
        Tue, 11 Jul 2023 17:43:23 GMT
Received: from hu-devc-lv-u18-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.27])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTP id 36BHhNmd019619;
        Tue, 11 Jul 2023 17:43:23 +0000
Received: by hu-devc-lv-u18-c.qualcomm.com (Postfix, from userid 464172)
        id 4F5405005A3; Tue, 11 Jul 2023 10:43:23 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     Thinh.Nguyen@synopsys.com, stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, rogerq@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v3 2/3] dt-bindings: usb: snps,dwc3: Add allow-rtsusp-on-u3 property
Date:   Tue, 11 Jul 2023 10:43:19 -0700
Message-Id: <20230711174320.24058-3-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230711174320.24058-1-quic_eserrao@quicinc.com>
References: <20230711174320.24058-1-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eqqFT-LZmVj-xyv4bJP5KyI2i4dhsBHC
X-Proofpoint-ORIG-GUID: eqqFT-LZmVj-xyv4bJP5KyI2i4dhsBHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_10,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=20 bulkscore=0 spamscore=20
 impostorscore=0 mlxscore=20 lowpriorityscore=0 mlxlogscore=61
 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110159
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property allows dwc3 runtime suspend when bus suspend interrupt
is received even with cable connected. This would allow the dwc3
controller to enter low power mode during bus suspend scenario.

This property would particularly benefit dwc3 IPs where hibernation is
not enabled and the dwc3 low power mode entry/exit is handled by the
glue driver. The assumption here is that the platform using this dt
property is capable of detecting resume events to bring the controller
out of suspend.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index a696f23730d3..18ad99a26dd9 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -403,6 +403,11 @@ properties:
     description:
       Enable USB remote wakeup.
 
+  snps,allow-rtsusp-on-u3:
+    description:
+      If True then dwc3 runtime suspend is allowed during bus suspend
+      case even with the USB cable connected.
+
 unevaluatedProperties: false
 
 required:
-- 
2.17.1

