Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A14A6973C5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjBOBkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjBOBkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:40:16 -0500
X-Greylist: delayed 1290 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Feb 2023 17:40:12 PST
Received: from mx0a-0068d901.pphosted.com (mx0a-0068d901.pphosted.com [205.220.168.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302B72ED57;
        Tue, 14 Feb 2023 17:40:12 -0800 (PST)
Received: from pps.filterd (m0278264.ppops.net [127.0.0.1])
        by mx0b-0068d901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31ECLqJk003890;
        Tue, 14 Feb 2023 17:06:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=proofpoint;
 bh=+E3D7NjFr9DwulWLyfadMnM9dX+k4g63pBPpJwW66TU=;
 b=Ms+N5zPdZNyEhvlo9VjfmRZgPmdaavlTv67enTMKvkhRcGLxncRjHRdbgcgQ4EdKCpPc
 uZgBrM33/peNU3wdgGhWbLFYJhVlHUa3jGr7qoRmlNw4C9qKHO5JgHfZBUiL7I6a0mu+
 DWM/lHU3ftnwcHresWWN3mfRM/XEWjnF/uz4E3X69A5y3dJcwzyaoT1YczrvtO0k5n5j
 anS4ipl1GkaHav+fv+i69GAoubiu9+QLJEsIfxyjPDN49AJaDOrl1aju8mIvQZSO3hn2
 G5fQYy003R6B1ugPSjCMiPyqCLQGvsVKlTrvJsy0sUv8azlQk58U6e6TDu5Mlcx9Pf0U Yg== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by mx0b-0068d901.pphosted.com (PPS) with ESMTPS id 3npaxs28yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 17:06:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaDOU1sMtGvpnaCi/H6iLoNtLTI96jsoHt50V6XEXiEeJS1Rg8z+0LMcswu1bVr7bhsjc5QkKQu4ZMyFKrcf6mcmEpvhHo2jB14jNEWs5WTUEeKC44N5TXjqUfxHY8Mp6FE+4LhPcjeaPTEi6tAfZ+KYlfKW8QCJypf3jBIvsHtjekjSBqXuHTpXKYVy71daoGaveHgmooLs9C5aGcEa/zxep+GNdzIXTVXTSt44S3FmPvWChNTTvsPGzh3QiiFcK2Z21s0DwGmpfkKClzTDhBmO9zr68Hv/LfrIe2IAfcQyWSlAnE1fxey8bMqtzw52/QWPavug12wlYGqHfMQ7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+E3D7NjFr9DwulWLyfadMnM9dX+k4g63pBPpJwW66TU=;
 b=CYs+Y4QiCPj2t9aadulBBBWuy80CRvxar22J+/1LfF4T1Gmxg3Hy5CVqiu8rgAHnOssKRJEpOIoX5TDuBygK/XMOCYewZ9iqL1ijTC0tRHbyGP+m8DgIWiNHGUSnAVRN4+x3i1tMzO/iKDQrz8uPHkaYFnkkpsAu0DaRa7N2mHPzhFbLfnU27y63alGq0IDSCPiVJm5UpHgWQAh3F7jR7vJAqq4dB+dhYsjGckYwHv6Ohp5h+HWVpnsM5Dqt2pbp8JNzTzAjLIfBz49lHptlDjmzEW1sIJLFizn6mFmN3DLB4JBcioXSABUGn8qimU3gIo6nKf3kqyk637Pd1MFzQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.203.150.150) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=biamp.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=biamp.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E3D7NjFr9DwulWLyfadMnM9dX+k4g63pBPpJwW66TU=;
 b=TCE1pNEsfhpJPkLJNmlFV0VNBKotIh8UZ0CNOzgWqylkezQ+4nBF861ahVH2KbDoVrRsjxlF1X4J6HqrMfs/R1N5cZi8Jnsd3cRIhnIvBlM+xV1KfjBWD8aZAU7EIYlQLh/gDu7Y7GUCKpR/kJ5AekUq1eOth8H25zbnkULd/5Ma+GVilLvgNzdCTHD2ubfikjh2rHTlSVOYXrNgrICRlsqkcMKcI6gnbQp8TsaIMu9DWabzeEF12kIekNDK952bI1r3vpE6ODE2XPkS5E+gOLbCcTBGATE+asbfIBrBBeomWxSIpjhK+RyXpwQIuXUtggCYYa+cxDx6PvsQr7aMhA==
Received: from SN4PR0501CA0044.namprd05.prod.outlook.com
 (2603:10b6:803:41::21) by IA1PR17MB6214.namprd17.prod.outlook.com
 (2603:10b6:208:41a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Wed, 15 Feb
 2023 01:06:17 +0000
Received: from SN1NAM02FT0025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:41:cafe::ca) by SN4PR0501CA0044.outlook.office365.com
 (2603:10b6:803:41::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12 via Frontend
 Transport; Wed, 15 Feb 2023 01:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.203.150.150)
 smtp.mailfrom=biamp.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=biamp.com;
Received-SPF: Pass (protection.outlook.com: domain of biamp.com designates
 50.203.150.150 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.203.150.150; helo=biampwebapp1.biamp.com; pr=C
Received: from biampwebapp1.biamp.com (50.203.150.150) by
 SN1NAM02FT0025.mail.protection.outlook.com (10.97.5.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 01:06:16 +0000
Received: from djs-build.biamp.com ([10.21.12.68]) by biampwebapp1.biamp.com over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
         Tue, 14 Feb 2023 17:06:01 -0800
From:   David Sands <david.sands@biamp.com>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, david.sands3@gmail.com,
        David Sands <david.sands@biamp.com>
Subject: [RFC] usb: gadget: f_fs: add capability for dfu run-time descriptor
Date:   Wed, 15 Feb 2023 11:05:58 +1000
Message-Id: <20230215010558.1114445-1-david.sands@biamp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Feb 2023 01:06:02.0046 (UTC) FILETIME=[ABE9FDE0:01D940D9]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1NAM02FT0025:EE_|IA1PR17MB6214:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5e1d1cae-c356-4131-77c6-08db0ef0d6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Rpj6/e1kDXGWIu/IvZGXdDfRirmYnIUdR1rwMZYkcmhJMf70DYzpD5GzZn7TAhthQaXCM0I/kHI4WnzOFY6w2pWB2+p59fOzcEnhppjEr5AQr3aUfaPYNR/cvr2yG1kFQDyVvX5zSBobjpXvcQBi7u+NY63Yw0vjh0ZWazNPB2SfLIWCgJrDX/MBYzzrSXPLFsf+azXI47dF62rk4eHDMFN3fmqa34+r1aaL5QGKzzO5XLDqHm07A4t9bN7+t4Ok1HO//KoPNf04pbsSCiEfqCM+EWZCacCHGdJqzXjgq9Zn/GLCAPMV9u9eQv6s91Gh/IS11AXZVGJ1dhqLZDYFk3a1xokOnsXBlq4BMJJNa+Hhli9Sua9+2U9T1zI7ZhL0NnUq7aIRzoBwXtZrW6nriE5g7j/IyGLONyDM2sWWT3HemuSSP40OnkF5A54r50/8sVxSlJ6ZzZBm2veeWyTLRo3d9ZasFUda/MfzYkw485B4vF676K8Pcs7RppIPNbmvnhsGq3CH9jAu2++MWUdpu5dedHpscD6Dm/JjXCNhSyIUPAjMQ2qxsHnpeDg2dtGCEEwv53WOa0MOiQfzdeFLDSAJF2cvNF3BLXhQmjky5ar6uWpoow8SSLbbmBRqmEHwdzQklFjbx0HZ2DehFW7iJX49MtrUlrue/7fwUzKKr9duAlotWOX1p1C+y/Kd1kdjZmanBK8oXIN/ze40acdFQ==
X-Forefront-Antispam-Report: CIP:50.203.150.150;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:biampwebapp1.biamp.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(136003)(396003)(376002)(346002)(451199018)(46966006)(36840700001)(6666004)(316002)(41300700001)(107886003)(2616005)(83380400001)(336012)(82310400005)(426003)(47076005)(7696005)(478600001)(36756003)(86362001)(40480700001)(4326008)(8676002)(70586007)(450100002)(8936002)(36860700001)(5660300002)(26005)(70206006)(82740400003)(186003)(81166007)(2906002)(44832011)(1076003)(356005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 01:06:16.3904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1d1cae-c356-4131-77c6-08db0ef0d6fe
X-MS-Exchange-CrossTenant-Id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=341ac572-066c-46f6-bf06-b2d0c7ddf1be;Ip=[50.203.150.150];Helo=[biampwebapp1.biamp.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6214
X-Proofpoint-GUID: BRMrim-u5tH7ZWbNTqDcstO6p6nDk9Kv
X-Proofpoint-ORIG-GUID: BRMrim-u5tH7ZWbNTqDcstO6p6nDk9Kv
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability for FunctionFS driver to be able to create DFU Run-Time
descriptors.

Signed-off-by: David Sands <david.sands@biamp.com>
---
 drivers/usb/gadget/function/f_fs.c  | 12 ++++++++++--
 include/uapi/linux/usb/ch9.h        |  4 ++++
 include/uapi/linux/usb/functionfs.h | 10 ++++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 73dc10a77cde..ac77ded9e6ad 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2049,7 +2049,7 @@ typedef int (*ffs_os_desc_callback)(enum ffs_os_desc_type entity,
 
 static int __must_check ffs_do_single_desc(char *data, unsigned len,
 					   ffs_entity_callback entity,
-					   void *priv, int *current_class)
+					   void *priv, int *current_class, int *current_subclass)
 {
 	struct usb_descriptor_header *_ds = (void *)data;
 	u8 length;
@@ -2108,6 +2108,7 @@ static int __must_check ffs_do_single_desc(char *data, unsigned len,
 		if (ds->iInterface)
 			__entity(STRING, ds->iInterface);
 		*current_class = ds->bInterfaceClass;
+		*current_subclass = ds->bInterfaceSubClass;
 	}
 		break;
 
@@ -2132,6 +2133,12 @@ static int __must_check ffs_do_single_desc(char *data, unsigned len,
 			if (length != sizeof(struct ccid_descriptor))
 				goto inv_length;
 			break;
+		} else if (*current_class == USB_CLASS_APP_SPEC &&
+				*current_subclass == USB_SUBCLASS_DFU) {
+			pr_vdebug("dfu functional descriptor\n");
+			if (length != sizeof(struct usb_dfu_functional_descriptor))
+				goto inv_length;
+			break;
 		} else {
 			pr_vdebug("unknown descriptor: %d for class %d\n",
 			      _ds->bDescriptorType, *current_class);
@@ -2194,6 +2201,7 @@ static int __must_check ffs_do_descs(unsigned count, char *data, unsigned len,
 	const unsigned _len = len;
 	unsigned long num = 0;
 	int current_class = -1;
+	int current_subclass = -1;
 
 	ENTER();
 
@@ -2215,7 +2223,7 @@ static int __must_check ffs_do_descs(unsigned count, char *data, unsigned len,
 			return _len - len;
 
 		ret = ffs_do_single_desc(data, len, entity, priv,
-			&current_class);
+			&current_class, &current_subclass);
 		if (ret < 0) {
 			pr_debug("%s returns %d\n", __func__, ret);
 			return ret;
diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
index 31fcfa084e63..4683b3b508c7 100644
--- a/include/uapi/linux/usb/ch9.h
+++ b/include/uapi/linux/usb/ch9.h
@@ -266,6 +266,9 @@ struct usb_ctrlrequest {
 /* From the USB 3.1 spec */
 #define	USB_DT_SSP_ISOC_ENDPOINT_COMP	0x31
 
+/* From USB Device Firmware Upgrade Specification, Revision 1.1 */
+#define USB_DT_DFU_FUNCTIONAL		0x21
+
 /* Conventional codes for class-specific descriptors.  The convention is
  * defined in the USB "Common Class" Spec (3.11).  Individual class specs
  * are authoritative for their usage, not the "common class" writeup.
@@ -335,6 +338,7 @@ struct usb_device_descriptor {
 #define USB_CLASS_VENDOR_SPEC		0xff
 
 #define USB_SUBCLASS_VENDOR_SPEC	0xff
+#define USB_SUBCLASS_DFU		0x01
 
 /*-------------------------------------------------------------------------*/
 
diff --git a/include/uapi/linux/usb/functionfs.h b/include/uapi/linux/usb/functionfs.h
index d77ee6b65328..3d15b193b260 100644
--- a/include/uapi/linux/usb/functionfs.h
+++ b/include/uapi/linux/usb/functionfs.h
@@ -37,6 +37,16 @@ struct usb_endpoint_descriptor_no_audio {
 	__u8  bInterval;
 } __attribute__((packed));
 
+/* DFU Functional descriptor */
+struct usb_dfu_functional_descriptor {
+	__u8  bLength;
+	__u8  bDescriptorType;
+	__u8  bmAttributes;
+	__le16 wDetachTimeOut;
+	__le16 wTransferSize;
+	__le16 bcdDFUVersion;
+} __attribute__ ((packed));
+
 struct usb_functionfs_descs_head_v2 {
 	__le32 magic;
 	__le32 length;
-- 
2.34.1

