Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3130E617687
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiKCGBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiKCGB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:01:26 -0400
Received: from mx0a-00622301.pphosted.com (mx0a-00622301.pphosted.com [205.220.163.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C194713F5F;
        Wed,  2 Nov 2022 23:01:24 -0700 (PDT)
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A35AKWE016457;
        Wed, 2 Nov 2022 23:01:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=com20210415pp;
 bh=M5wisoswgV0ID+S8hei0Ko4zoPsxEynOldgnS6b0Flg=;
 b=PxoqtctsYOaKHj44IPP4AS1FhGwjY0EtQMpqTnztkTjRntyM+D5URgQyuunxvjXlQ70T
 TOTN+bf5oyIdrOqUI15sWu02oQ8+523VzJhJEidE5EpO7sJ0M2rHwpErpsOjmWtUyjZX
 czMyitx/EY2vL/Ng6lbdp1Nd1o1GckJTP/Yb5VZLIXjVaLmghGpoGTDnYlY/mPC9bu/y
 lcK2/QVUkwI0A3NGfzF/Vn3JzwWjbM0D9X9DCHAc452Kx1iOcXbzl1d+XOV1MqIpcCkI
 zIuaGQb5J/v3J22DNltqRtEuqtuau8oC0ToESvZfjkCvPi3Mn83ibnEpj1bUZHhcfrRx lQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3km44p82wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 23:01:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HM6t4Tn1DQBzpfdmf2ehR+vzbeodcxwD/wTiK4KiD7LV3HDIvX9knkvRfpx+kgOeSrzAvtsXieNJtvQMBFFhDU0rxfosRWf23iQEjaAdwLYfyfOWCAOuqseFuUGFj+lal3SpDYMX6KttoPuvgUxoRPPlg8URbF2HDrmI5pHmr1guBqD5Th6PvcCmgiDGly7y53x0iepAgw5hBphh3Nv4NfaWdtqyq+31iFWjAMTedPecqjbxfkcnLSsQyA15VM4TEVZJ1LwzUFdQCWdRDOUDjOHpCMl4d8Rb958wppXHtnsHdlrl0RSg4bFCYpyCJ+5FqvJL3mVorRC4tJYslV1d2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RrTJDJrEfsR/998iz6BAY7yoOwBBWgvjKUo1pOId8c=;
 b=StngIhl6FK54u2T0vaF15pXDK0kc2OlBwltkliGfdqreQd4R7PtNpwl3UyD3EjQ6ZxRoh+cjMtvWfpwanPFdSkpfVzHO71hZ11NwtOpy4nlwGjBU0b8fruk7rrMOhG1a9QXXMIZz040ZeTp1DS8bBAjn8xoEAc90vuBbw0yMk1zWciy9+o9qKRzxvejYOsLkMDpQirYjlC8pKNzthknEKGr5GzwrV/k9IYise/8rw4GDY7yHdZCvCWwPl9tY5NhoLVfxlKxW768Rx2qgqK9ILOeTI3EHFyq+UOU8Eu0aeUYZf1uDvN5uCr7rYMTJv+xqDeR2Upqb4A8F7stFROttsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RrTJDJrEfsR/998iz6BAY7yoOwBBWgvjKUo1pOId8c=;
 b=ZKiTRB3stB1MLh3VtbPFYyR078dEujtbM+Ri2L0jj40jnoZ7I14NZPcZEH/u2UKdOdfizV6T0ecSdQg8Ae8cN5IXwTEoRXE1VRGfYPCJE7HLsWTY4tWsCBSUl5G0qzipnkI1PLgbna7UXZE+pCndAZWkOdiD3yAxcpi3MVpiKUNHDKHVoRCxIFohHRLO/9t17ZPuyr0ACpFbmfmGlH5hFZAEzafBAZep7cFsR07q7WXsP4iWHU9TY8IGWWaGDEWoPULDZY3Jrxdvl1jZTNlT2OcFrRiLYnOIPjIXy7i5OtL/sAzB+URH6g8a7av/Oo3Xb/5S2a2PjGDXlOYn/G64uw==
Received: from DS7PR19MB6254.namprd19.prod.outlook.com (2603:10b6:8:9a::19) by
 PH7PR19MB6014.namprd19.prod.outlook.com (2603:10b6:510:1dd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.21; Thu, 3 Nov 2022 06:01:08 +0000
Received: from DS7PR19MB6254.namprd19.prod.outlook.com
 ([fe80::f9bc:3b31:8390:e804]) by DS7PR19MB6254.namprd19.prod.outlook.com
 ([fe80::f9bc:3b31:8390:e804%5]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 06:01:08 +0000
From:   Jing Leng <jleng@ambarella.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        laurent.pinchart@ideasonboard.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Jing Leng <jleng@ambarella.com>
Subject: [PATCH v4] usb: gadget: f_uvc: add super speed plus transfer support
Date:   Thu,  3 Nov 2022 14:00:41 +0800
Message-Id: <20221103060041.25866-1-jleng@ambarella.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220217031035.6150-1-3090101217@zju.edu.cn>
References: <20220217031035.6150-1-3090101217@zju.edu.cn>
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::15)
 To DS7PR19MB6254.namprd19.prod.outlook.com (2603:10b6:8:9a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB6254:EE_|PH7PR19MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8f30bf-326e-4808-44a1-08dabd60ccfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5aDJuQG+1NvnH2eb4QsCufPBAtReMOvh0cPLQWP/4vKIcwZ/5rFOGjr/jWCT+QYHTlX3R7klReVQ+m2D2Ffn23yZhCEleOQ0YgJouUhwYgGZG/5wcImPOF4RquFEX1+qA4B8FB4Cx3Evx1yl/PVpL2Xp97IcbulLllXdcgI/syIIN6AeFikC3VzW234O64jUq2IWQ0d8qAfQSRHid91k2UKnYXp58I82D3KXbLu6Df/F/xAnC/p9wz7+B745OIUFzjths5ghphykOeR95Q9ClVKuyBDl9BwfYQ/iY7W7LzQyXdW4pNkJ0lK7U/35M7gocxjMutOCp5aX186ziH4XSRruFo5TnJGGWh0v2kGFCIXdDpjfBu4A/6j39bh7C7hcf752QglZSQ0X2ru7F0LMqp9iRZRins0DFqIzXpz6vpR5RhXpg8YpdZqnpjJGQ8pVL3OgSJrT15jqEGivsi+97XWuBPS5zOE00fM0ocuPjDU/vILdfr0R8JIhjJOf27BYZuA7iG3D7aVmAL8xJIz1wT+T668XLCYN5dBwQ6omxJmK2+WbiAmfzDANuiMnM9SEVo9t3PyFajgTXi40NzeSj1ds7m6Zf47n7zhHLeyVNHt5Djeb06WkGl2pTzrTxgZgUw9P2sXVCU5sST4TNrQXxCFmrdd/ev1gxIkPt+o/tC+aYQ5Nnl3j0lXnR0WXqX10ZHHAYHMizP49INHmqLy952KRoFyt6DDM604NXd+g13xozjkCjm1EfGO6cSc1vABZPdsntD3CnTdEJ9zGsDdRzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB6254.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39850400004)(376002)(366004)(136003)(346002)(451199015)(6666004)(8936002)(6506007)(41300700001)(6486002)(5660300002)(478600001)(2906002)(52116002)(107886003)(38100700002)(83380400001)(1076003)(86362001)(316002)(186003)(36756003)(38350700002)(26005)(6512007)(66946007)(4326008)(2616005)(8676002)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C4FqJ7d1ApXbSd07ejxJxTjvO7O+lkJQyIrvDIc6qQQGiJT3mYPjctrzDKLP?=
 =?us-ascii?Q?q/XQNJYOqzPiszoW/sDF97OASF6rsl5vX/6ZkXOMRIovGY233LdwcEri8krV?=
 =?us-ascii?Q?d+/7g2DwGqLn0CApiOKLK7DOXYT9NVPXCAVW7cXQFR2S4iyD8S9ftLIqitWn?=
 =?us-ascii?Q?VwDNwIDVvYIa1lof7gLcW0tiad/Buurx0HK8paX233rCsjPKbAAf6TjNaqMP?=
 =?us-ascii?Q?G374LH4Q4SaICS0BA9MTESEYrjK4MfjQZSOKeHvDIvMXu9fP7daZkT+3m4l5?=
 =?us-ascii?Q?HCoQOrd+dsO+2HirYakoG4PLUYEWnnAid/0VfrORNiGvdEGfQdqdlekI6oTc?=
 =?us-ascii?Q?vumUaHl+VDXO6m+IkuAjl81cOpTY05wDT1hhoE4TQME2nPTjGvvKDABp2kBG?=
 =?us-ascii?Q?iPRwx7TKQ3WPuD5LakUEFAmCAr+BglJgj8+iB/NNrFF10iDAU2PS5DtVn5iw?=
 =?us-ascii?Q?1B4LGwOv1HA3QuPA0LeCc2XVC7M3qZj62tH0V3cHtO0mVdITAW8PpOOfawb0?=
 =?us-ascii?Q?nZVLutWFdof4hIDudFi9ipbSV3/lUcbzFLUD/dltK+f3+reCE7Cn1FBHlBJr?=
 =?us-ascii?Q?JDscuVmWAv6+AiP841lT2lh5hdbsgi1j0sgpEVSCrjcNBZyX53pmLMws0kIr?=
 =?us-ascii?Q?X4C/Q32dPh0SnxRU8iwfeo+jqCJlVFbx1CSseAuAWvxbfvGr6jM2QO3ZoeMT?=
 =?us-ascii?Q?Raaw4iq017yDQYwUgZNgRfgT0g04Q8RJWh4MZ9O3+QktYtvz8bOCQVuCQ3EC?=
 =?us-ascii?Q?UHQTnftih3Yp19OnjMc5GJlH0Mi3IzQYPVrPL7J28P6i5jtPaL2UA52hq+IF?=
 =?us-ascii?Q?NrIx3Mk55fMGyeJ3qvvwf3pV/o8jQ3+DC9RUV+oQKdxAX/tEExkWkk2wbvBH?=
 =?us-ascii?Q?BD4XciTqw7gZN9SQi+o7kdA1pGAbKn+qwmRe01qpCsW7718OJWaxJZ2wMLTK?=
 =?us-ascii?Q?6t0+oMuYeVrimAG5ThgI5iUTUwxCchZUl7CzZmsM49xWfh2uGVuMyrGdVn/A?=
 =?us-ascii?Q?uo9DRDk39LA0VFjoY7G9dMkiJIO6JLeMwk7OPldhOTNA9XDYB87p/SAkxXy4?=
 =?us-ascii?Q?HhsOBnyhU32CGsFhoaCy9qanIBgmj1toiPcebOsSvY/Rxft4Q2pSAbb4NZp0?=
 =?us-ascii?Q?z6Ry18y2u2wyxgdLsPkBAJdHr4B1EqoaW8JtdHtRE37kECw/eEwn4ueD1gTP?=
 =?us-ascii?Q?OzKl9vZyaK1P6vaEf3EGm2WVNALoJI2kmob/A83cDbIUYpa4fpMUAPzNl6bf?=
 =?us-ascii?Q?0BEINMkjx9Jdd8OEidMHh4FUX6vKNHRMo04JtD+Lfa7ifPgtwqB+9vdsdO2r?=
 =?us-ascii?Q?spk27pNNEirb5ODKR9wLRp5t2egAKViiDBXMdB1ykdP1Hy7/cXLZ25AIbXIA?=
 =?us-ascii?Q?i3fBeMNJ3D2cwS/IruC8QYGHNNK/TTBKHDVuujTW3VJlvoiaOtqMAbt+J9Hv?=
 =?us-ascii?Q?YJra3TlYnZAnMZp1gHU7jIuycxnQ5XY+tS/gm51fmu1nu1qwSdYmqSIiV3I7?=
 =?us-ascii?Q?3qnR5glhhqOl33mToj00PvuLDTSGdMwEXH9PLIj6iYEY5P8OZg05npbeXdBu?=
 =?us-ascii?Q?Jl6p8ncN4EJdGLabfuMbhKUh+0h3tL0pgEOGzXX7?=
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8f30bf-326e-4808-44a1-08dabd60ccfb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB6254.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 06:01:08.3156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkSUkGBL5Q25WwPZk8EA7eYdSLY4uxl+Qm96PNAciQ5+oPIjU6KvWXWX3VES/elP5/YxllwysZVbMhleklRv1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6014
X-Proofpoint-GUID: 1QivHNUszSPq02C6SaGZrKgj0bWEmILa
X-Proofpoint-ORIG-GUID: 1QivHNUszSPq02C6SaGZrKgj0bWEmILa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=700 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UVC driver doesn't set ssp_descriptors in struct usb_function,
it doesn't support USB_SPEED_SUPER_PLUS transfer. So we can
refer to USB_SPEED_SUPER to realize the support of
USB_SPEED_SUPER_PLUS.

If users use a USB device controller that speed can be up to
USB_SPEED_SUPER_PLUS (10 Gbps), downgrading to USB_SPEED_SUPER
(5 Gbps) is not a good performance. In addition, it triggers a
warning "configfs-gadget gadget: uvc doesn't hold the descriptors
for current speed".

Signed-off-by: Jing Leng <jleng@ambarella.com>
---
ChangeLog v3->v4:
- Rebase the patch.
- Make email addresses ('From' and 'Signed-off-by') consistent.
ChangeLog v2->v3:
- Modify the title and description of the PATCH
- It is a feature but not a bug
ChangeLog v1->v2:
- Update more detailed description of the PATCH
---
 drivers/usb/gadget/function/f_uvc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 6e196e06181e..6ffaf594be9d 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -482,6 +482,7 @@ uvc_copy_descriptors(struct uvc_device *uvc, enum usb_device_speed speed)
 	void *mem;
 
 	switch (speed) {
+	case USB_SPEED_SUPER_PLUS:
 	case USB_SPEED_SUPER:
 		uvc_control_desc = uvc->desc.ss_control;
 		uvc_streaming_cls = uvc->desc.ss_streaming;
@@ -526,7 +527,7 @@ uvc_copy_descriptors(struct uvc_device *uvc, enum usb_device_speed speed)
 	      + uvc_control_ep.bLength + uvc_control_cs_ep.bLength
 	      + uvc_streaming_intf_alt0.bLength;
 
-	if (speed == USB_SPEED_SUPER) {
+	if (speed == USB_SPEED_SUPER || speed == USB_SPEED_SUPER_PLUS) {
 		bytes += uvc_ss_control_comp.bLength;
 		n_desc = 6;
 	} else {
@@ -570,7 +571,7 @@ uvc_copy_descriptors(struct uvc_device *uvc, enum usb_device_speed speed)
 	uvc_control_header->baInterfaceNr[0] = uvc->streaming_intf;
 
 	UVC_COPY_DESCRIPTOR(mem, dst, &uvc_control_ep);
-	if (speed == USB_SPEED_SUPER)
+	if (speed == USB_SPEED_SUPER || speed == USB_SPEED_SUPER_PLUS)
 		UVC_COPY_DESCRIPTOR(mem, dst, &uvc_ss_control_comp);
 
 	UVC_COPY_DESCRIPTOR(mem, dst, &uvc_control_cs_ep);
@@ -733,6 +734,15 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 		}
 	}
 
+	if (gadget_is_superspeed_plus(c->cdev->gadget)) {
+		f->ssp_descriptors = uvc_copy_descriptors(uvc, USB_SPEED_SUPER_PLUS);
+		if (IS_ERR(f->ssp_descriptors)) {
+			ret = PTR_ERR(f->ssp_descriptors);
+			f->ssp_descriptors = NULL;
+			goto error;
+		}
+	}
+
 	/* Preallocate control endpoint request. */
 	uvc->control_req = usb_ep_alloc_request(cdev->gadget->ep0, GFP_KERNEL);
 	uvc->control_buf = kmalloc(UVC_MAX_REQUEST_SIZE, GFP_KERNEL);
-- 
2.17.1


**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidential Information and is intended solely for the use of the individual(s) to whom it is addressed. Any unauthorized review, use, disclosure, distribute, copy, or print is prohibited. If you are not an intended recipient, please contact the sender by reply email and destroy all copies of the original message. Thank you.
