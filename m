Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8146176CF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiKCGjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKCGjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:39:15 -0400
X-Greylist: delayed 1531 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Nov 2022 23:39:13 PDT
Received: from mx0a-00622301.pphosted.com (mx0a-00622301.pphosted.com [205.220.163.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B87225;
        Wed,  2 Nov 2022 23:39:13 -0700 (PDT)
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A35iHtV007985;
        Wed, 2 Nov 2022 23:13:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=com20210415pp;
 bh=SxlVmwbN5zNq8XSrOOSzgaD2zI1a+FbIj99FVKBqzsY=;
 b=lA6oeKOgZIwW6cF80kfZ87gMXg0iIz/kRNmQCdoBezJ3TmD78dhkILnFxOnTc16WgXVw
 p3cCED2JZvrh9YqcmvUKNbyFjQ9/eARLzh0i7cz8XvMpg48T3P739ldy8qbpY7w6S0bu
 HIDhDWAL4yQHfIpUjGvlmQlhyS7BMI65IwbK+4fW4A7qZUrBQNowzLpKcbZagdYI/eVb
 rBwFDvILY4ciKbXjMRxYaeMGrSaeRFxXM/NJNOd0mspBa1ls0beg2K4YEX9KwUWoRr0k
 vylUiTbxuPNj7LluWLKehcRd5eshKSMtkBTsoaVY63ukMgqZa+ir0wVRbshFHq/2J7Rz 7A== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3km44p832h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 23:13:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3i7wo2dltDPGpYpA6defZUL1YtIO4xipVx+jTmgYjLvAIp2w98FeJa+sPSeMni+v3fLXSyzJ/fvmIQUTMGDjuDoH+e63kWpHqeaON/UfdMSf9MSxQSgavb6wT5Hbz5++4/jNZu2aPSTNWJuWBK1zhZUTed7JoKM5yfC/4jBYJCg2kE7nftgir5s1zE0SOmpW/Z7+CRqywZrWUni2dhsy692r+uB7LRPBPZQ8Vdf5hcB8fAvozmL9140Fs5I+zE4wAK6rdhpKhXHEgnL+MFPbtILs1nSinmrjC5sdI2I87mm+UNRuZidDykv6sfKSd0AtWPFh4YRg1qrxfCYGo0BVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVvFHxuYKzT9N5yIvcI3KPluFe4VuviIEcieMHJ3uTs=;
 b=H8gvYn8WnsFrGUvwfstnlA9eSCtHYebqLzm3iW4J6UHeQWwlH5Ll0GkWwtFhUaHqcIp9r5hRaQdA0/6T6iraxrtsdSZ0uAfdAwvQEFQGMFE0cb7JrfWGNyR1yehGHceWvz2SMQoJjX2S64Q2OI+3dyqYeJ0oEtsAvWyah6hlaXZoTynUiVW4LRlP36hY8gLcgacJzQKxAYYpKHOHlWcfoZ5pGvw3BQyduwssgCO36plVHbKa/1ZFQZlv2KnQnjlPlVe7rBf7xCvC/m83YaLND1Ff6o55CGms7uLPVJmTRuwQnGoAdmFJGPcM4XCmjCeusRri859guxENBHViO4FQwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVvFHxuYKzT9N5yIvcI3KPluFe4VuviIEcieMHJ3uTs=;
 b=GkfwjZMXt0XnjDVOXf5H7AEmfGPcjL7HVxnm54r4Rv0vDSeS4NjTPSkWKIqmyRLGNN3WQkWwuNn1GJrbSahm4BI4VJewsMSS3V1f0OgStfMLgXcC2WPVN3Fl7hsAHor7PP69BkfuUKnlvDmKQjZ7obaBayRbRvV0bBFxuSq2E4cf7BEYGDQJgE632tI3UrhWLEwpxKh1EzQbLSHYkP4MWGiSO2SYLUK6fUzkLypI9YcohFZrAbRYoayE7A6FYOyUDaujFIRzh8RvUSBADyKYkznI9LRgZPO4FoKD0cNY4mxI88CiAGro6FrqQzkjGl4+tylsg/MT8qXrQdvUACbJXw==
Received: from DS7PR19MB6254.namprd19.prod.outlook.com (2603:10b6:8:9a::19) by
 IA1PR19MB6273.namprd19.prod.outlook.com (2603:10b6:208:3eb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Thu, 3 Nov
 2022 06:13:25 +0000
Received: from DS7PR19MB6254.namprd19.prod.outlook.com
 ([fe80::f9bc:3b31:8390:e804]) by DS7PR19MB6254.namprd19.prod.outlook.com
 ([fe80::f9bc:3b31:8390:e804%5]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 06:13:25 +0000
From:   Jing Leng <jleng@ambarella.com>
To:     balbi@kernel.org, bilbao@vt.edu, corbet@lwn.net,
        gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com,
        mchehab+huawei@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rdunlap@infradead.org,
        Jing Leng <jleng@ambarella.com>
Subject: [PATCH v5] usb: gadget: uvc: add bulk transfer support
Date:   Thu,  3 Nov 2022 14:13:03 +0800
Message-Id: <20221103061303.26813-1-jleng@ambarella.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220513004201.25563-1-3090101217@zju.edu.cn>
References: <20220513004201.25563-1-3090101217@zju.edu.cn>
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0237.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::33) To DS7PR19MB6254.namprd19.prod.outlook.com
 (2603:10b6:8:9a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB6254:EE_|IA1PR19MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dbefbfa-6aa4-47a3-21b7-08dabd628426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gA22qih5HRYO/qBX9HFDPS9Yhll9sYfAS84R/Iw16pIaeHusAKFwviAMDqRFrW0nrLvBKXX2DGpX8mUH3rVX+QYZz+wEd6xwXYysiCDQBghtquHVoLlRFHt2Gb5iKOpyobLtlnQupcKs/aow5Xbe3vlOiPgO6UbeNDkt0Vq4GQ8ek0j5C+Sf3Hoqh8Erd0T+ooevoqGrPpoAsOXI8o5fAbobRZW5dbwBngZofoRNN2b5bybk2yZyV4ypQA6dnSl4IdFNF84/xNHOoyDmTrtsYwNJZYZ5mH9vQ57hyMkQ+jbBGiH2s+uO/7sR8ZJtzsiswBmD5P/vn4hYNUE4VaumS5tIe6sb2SeKeQYu9+EgFO7HcgmwRJczTGI1pFnPqOxPEilTT3DQOVUCSGUVmBkLVoqkGrbxIxi6J0If3MNjchchVQdVghqUDWmeeWZ4FkNCnJfAbo0XFl0RS/YKscmLbUYCVdihsnkF+PjESo/mlphstw0Y+o1d8a0hmVrdIzBoDe1NMujeBqTMQV4ODPLchbnGOOgI9sKukRWa+yugHNkeYYRD7Qj1mYaOcKymNhvQiAHF9Tm/GlVetfNqRikfgaupeEWVu9+rOLfvHrGBbDtoGfugAJ1zoB84fNFlV4zqm3xlzqZpYP0z1eYbO2kdU99NmXruyWXzDMCljqba9NbKF/l6YaXYroNpwDG5hDVI+LZQENAKIb8kX+cI0r3kCUCWsWGGs4/YslmOTXpVQtcMcMXam5uo6/98PI2dfCszBQepezxbyEZWosBQkLi0JQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB6254.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(39850400004)(346002)(376002)(451199015)(30864003)(8936002)(2906002)(38100700002)(52116002)(38350700002)(4326008)(41300700001)(5660300002)(66946007)(186003)(26005)(6486002)(316002)(1076003)(2616005)(8676002)(86362001)(478600001)(6506007)(6512007)(6666004)(107886003)(7416002)(83380400001)(66476007)(66556008)(36756003)(19627235002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h+8RqyOmXFXTnLf3d4rwUvOuhsHehmqfYfYv/sxRk+BQQVys86lKFNA3+BEY?=
 =?us-ascii?Q?CrKqjErVWLvxsAiOZwfALbiJ5OOy6Kzyjcys2PPHM4ZuZl+vbczgnVMrQQNk?=
 =?us-ascii?Q?dkEsIy5pTRCX1msB4F/luiEZ3SDYR/HDXQnRcq3eV3+07Ya+uzd0BjDYNqfG?=
 =?us-ascii?Q?WusOFeJtK4LhbJqJl8htAM0/Wkivv2gSHrGrSPi8om5xywVHNOqCjsWWhaRk?=
 =?us-ascii?Q?gMq1VQuepPhrbjPylciX2pzCZwhAe8TL0T3GciDSL9OntTdxJjdkEJWCaKny?=
 =?us-ascii?Q?PaEdTefqte9H0rEuRkYsRuAlJGkqhz+QA34WzLu716F9CdDROoI1wct5TZZH?=
 =?us-ascii?Q?Q6TtEmW3v8dwiffIY+t+okmH6V1Fd6BD/NixGNGIDpOWbOmC9K/1p1g4Yt1i?=
 =?us-ascii?Q?0ZZhacG+XUYPdGgl2t4e5KAT9JXKRUf9bXjeoIxMz1mh5EdYFNq83kk8VQoH?=
 =?us-ascii?Q?caWlVJBVWh2Sngi0t1/PoPgwH6bL1drQ53zksLrXXdxKSYWqeDfwDBCwI2Ui?=
 =?us-ascii?Q?XNTaVrtcX5YxBfFfZXlNOC6LWLgjwuD2rCoIFhcd/wRTm6PgOfqZjjxNAj41?=
 =?us-ascii?Q?cgCGuu7cYGGhJdiYDFkBjeC3MMi/iDZatD9V65AjcBSzKopF2p5ckOOwZIKr?=
 =?us-ascii?Q?zgKmEIcGLQbnkdCtd+VK7s1KNrFUMNlGC3sjPj8CC4GOqwegbY+vAwlZoBgX?=
 =?us-ascii?Q?pK1VIcJsMX6Lg692AAqASsxRIwZUaFg4qYHLUta91m6sDFrSOL+pHVj9Whyz?=
 =?us-ascii?Q?TNAXNxfjBKQzhkawgQRGw8Vis/5f3JKmiw1oGsUIdfGmTIMDV1J0YTK0P5Oo?=
 =?us-ascii?Q?NX5tR3x7QssDudZ3/+ZruBmwjU0brkbJQ7hDDpgoZ6gEnnc5bL1XmWd+AVyt?=
 =?us-ascii?Q?TY5AKfDze+5UNdmualp5j55kf5hULtqaJ4OlM2IB8mQJczz42xKbm3uEwPhI?=
 =?us-ascii?Q?UIEsXAZwGmaBfpwSFYbuOiZq2rLOl3IFEvYyYI/7gjco9zOEM9UPujiahQah?=
 =?us-ascii?Q?7RpVmXW/gU1QIaxCk0ZuZGh16/0KBRMxRxx74zp390LT8450A4REMdELtIoL?=
 =?us-ascii?Q?shhZjIzvKzRGo+QDLcR8Uil4tFZlbAHuTQpRAQqK4MNGMhEbjuw0hpxvc0Vm?=
 =?us-ascii?Q?56t65Qit03AwXeIafT9IwudUC5d8lmBaRm9/HlvGk1CmOENaZtBCf7IYceSr?=
 =?us-ascii?Q?m53mBSjFVDLYV6K52cQk0vrsQ9jJ6RPjtE3rKI7tTlGCbi6QBN+qLiY3I/k0?=
 =?us-ascii?Q?7AfLXv07rEv6KSX1YKs+HkzvRyQ1vgqjFW3zoKv/BQ8JuzP33NkdYcvhWPB/?=
 =?us-ascii?Q?TDrZWehYui5kwWObYSwuD6zdFIAgsVzpReEneRvaVau3LREWhlnmm/+Sb6bs?=
 =?us-ascii?Q?mHWyOyzlEM/TskdF98nLySHS5FfMgb0xk4Rb3T28AOeXnZhH808rjI0gvc9h?=
 =?us-ascii?Q?b5bFS2laKILP9Tquif1eCjS/ZsYww0fNUdLfUn9TnuxehT4IhRiM11gxK6/f?=
 =?us-ascii?Q?cFRCvdRe/wH0Euuzi3YEKetyUDHM87z9gmueg0l6BWqsrlIxBgxXm/D2YTjZ?=
 =?us-ascii?Q?3E32fPpJCgyZDwB0SUYe1MYSKzHxLIyvs77gopW+5pagZCXka2TIYQx0r67j?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbefbfa-6aa4-47a3-21b7-08dabd628426
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB6254.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 06:13:25.0694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nlp3dXlS9SfcAp4ziGFP5lo/DjPj6QocyLr+6R6a112LMoh1gFvLubH3ZGimxcvv63+WBeOrwnFHRQibXyuKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6273
X-Proofpoint-GUID: 8wOMGoEI1HH0QBmL6g9zyBkfOX8gdHAq
X-Proofpoint-ORIG-GUID: 8wOMGoEI1HH0QBmL6g9zyBkfOX8gdHAq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The video data endpoint of uvc can be implemented as either an
isochronous or a bulk endpoint.

The transmission speed of bulk mode is faster than isochronous mode.
I tested the speed with cdns3 (USB 3.2 Gen1), it's difficult to reach
2 Gbps in the isochronous mode, and it can exceed 4 Gbps in the bulk
mode.

A VideoStreaming interface with isochronous endpoints must have alternate
settings that can be used to change certain characteristics of the
interface and underlying endpoint(s). A typical use of alternate settings
is to provide a way to change the bandwidth requirements an active
isochronous pipe imposes on the USB.

A VideoStreaming interface containing a bulk endpoint for streaming shall
support only alternate setting zero. Additional alternate settings
containing bulk endpoints are not permitted in a device that is compliant
with the Video Class specification.

Here shows an example of the configfs differences:
  if [ $BULK -eq 1 ]; then
      echo "bulk" > functions/$FUNC/streaming_transfer
      echo $(( 1024 * N )) > functions/$FUNC/streaming_maxpacket
  else
      echo "isoc" > functions/$FUNC/streaming_transfer
      echo 1024 > functions/$FUNC/streaming_maxpacket
  fi

Signed-off-by: Jing Leng <jleng@ambarella.com>
---
ChangeLog v4->v5:
- Rebase the patch.
- Make email addresses ('From' and 'Signed-off-by') consistent.
ChangeLog v3->v4:
- echo "bulk" > functions/$FUNC/streaming_transfer to set bulk mode
ChangeLog v2->v3:
- Mistakenly deleted the definition of i and USBDHDR when porting from my workdir.
- Reported-by: kernel test robot <lkp@intel.com>
ChangeLog v1->v2:
- Handle imagesize in uvc_v4l2_set_format. If it's not handled,
- switching from low resolution to high resolution will fail to play.
---
 .../ABI/testing/configfs-usb-gadget-uvc       |   8 +-
 Documentation/usb/gadget-testing.rst          |   1 +
 drivers/usb/gadget/function/f_uvc.c           | 228 +++++++++++++-----
 drivers/usb/gadget/function/u_uvc.h           |   1 +
 drivers/usb/gadget/function/uvc.h             |   2 +
 drivers/usb/gadget/function/uvc_configfs.c    |  64 ++++-
 drivers/usb/gadget/function/uvc_queue.c       |  14 +-
 drivers/usb/gadget/function/uvc_video.c       |  16 +-
 8 files changed, 261 insertions(+), 73 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc b/Documentation/ABI/testing/configfs-usb-gadget-uvc
index 611b23e6488d..ffa2fd8c7fcd 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
@@ -3,12 +3,14 @@ Date:		Dec 2014
 KernelVersion:	4.0
 Description:	UVC function directory
 
-		===================	=============================
+		===================	===================================
 		streaming_maxburst	0..15 (ss only)
-		streaming_maxpacket	1..1023 (fs), 1..3072 (hs/ss)
+		streaming_maxpacket	isoc: 1..1023 (fs), 1..3072 (hs/ss)
+					bulk: 1024..0x40000000
 		streaming_interval	1..16
+		streaming_transfer	isoc/bulk
 		function_name		string [32]
-		===================	=============================
+		===================	===================================
 
 What:		/config/usb-gadget/gadget/functions/uvc.name/control
 Date:		Dec 2014
diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index 2278c9ffb74a..880af56abe8b 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -793,6 +793,7 @@ The uvc function provides these attributes in its function directory:
 	streaming_maxpacket maximum packet size this endpoint is capable of
 			    sending or receiving when this configuration is
 			    selected
+	streaming_transfer  specify data transmission mode (isoc/bulk)
 	function_name       name of the interface
 	=================== ================================================
 
diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 6e196e06181e..8a4df750e00d 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -29,6 +29,8 @@
 #include "uvc_v4l2.h"
 #include "uvc_video.h"
 
+#define USBDHDR(p) ((struct usb_descriptor_header *)(p))
+
 unsigned int uvc_gadget_trace_param;
 module_param_named(trace, uvc_gadget_trace_param, uint, 0644);
 MODULE_PARM_DESC(trace, "Trace level bitmask");
@@ -181,19 +183,19 @@ static struct usb_ss_ep_comp_descriptor uvc_ss_streaming_comp = {
 	 */
 };
 
-static const struct usb_descriptor_header * const uvc_fs_streaming[] = {
+static const struct usb_descriptor_header *uvc_fs_streaming[] = {
 	(struct usb_descriptor_header *) &uvc_streaming_intf_alt1,
 	(struct usb_descriptor_header *) &uvc_fs_streaming_ep,
 	NULL,
 };
 
-static const struct usb_descriptor_header * const uvc_hs_streaming[] = {
+static const struct usb_descriptor_header *uvc_hs_streaming[] = {
 	(struct usb_descriptor_header *) &uvc_streaming_intf_alt1,
 	(struct usb_descriptor_header *) &uvc_hs_streaming_ep,
 	NULL,
 };
 
-static const struct usb_descriptor_header * const uvc_ss_streaming[] = {
+static const struct usb_descriptor_header *uvc_ss_streaming[] = {
 	(struct usb_descriptor_header *) &uvc_streaming_intf_alt1,
 	(struct usb_descriptor_header *) &uvc_ss_streaming_ep,
 	(struct usb_descriptor_header *) &uvc_ss_streaming_comp,
@@ -204,6 +206,10 @@ static const struct usb_descriptor_header * const uvc_ss_streaming[] = {
  * Control requests
  */
 
+
+static int uvc_function_set_alt(struct usb_function *f,
+		unsigned int interface, unsigned int alt);
+
 static void
 uvc_function_ep0_complete(struct usb_ep *ep, struct usb_request *req)
 {
@@ -219,6 +225,13 @@ uvc_function_ep0_complete(struct usb_ep *ep, struct usb_request *req)
 		uvc_event->data.length = req->actual;
 		memcpy(&uvc_event->data.data, req->buf, req->actual);
 		v4l2_event_queue(&uvc->vdev, &v4l2_event);
+
+		/*
+		 * Bulk mode only has one alt, so we should set STREAM ON after
+		 * responding the SET UVC_VS_COMMIT_CONTROL request.
+		 */
+		if (uvc->state == UVC_STATE_BULK_SETTING)
+			uvc_function_set_alt(&uvc->func, uvc->streaming_intf, 1);
 	}
 }
 
@@ -228,6 +241,9 @@ uvc_function_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 	struct uvc_device *uvc = to_uvc(f);
 	struct v4l2_event v4l2_event;
 	struct uvc_event *uvc_event = (void *)&v4l2_event.u.data;
+	struct f_uvc_opts *opts = fi_to_f_uvc_opts(f->fi);
+	unsigned int interface = le16_to_cpu(ctrl->wIndex) & 0xff;
+	unsigned int cs = le16_to_cpu(ctrl->wValue) >> 8 & 0xff;
 
 	if ((ctrl->bRequestType & USB_TYPE_MASK) != USB_TYPE_CLASS) {
 		uvcg_info(f, "invalid request type\n");
@@ -245,6 +261,21 @@ uvc_function_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 	uvc->event_setup_out = !(ctrl->bRequestType & USB_DIR_IN);
 	uvc->event_length = le16_to_cpu(ctrl->wLength);
 
+	/*
+	 * Bulk mode only has one alt, when the SET UVC_VS_COMMIT_CONTROL request
+	 * is received, if the streaming is in transit, we need to set STREAM OFF,
+	 * if the uvc state is UVC_STATE_BULK_WAITING, we only need to change it.
+	 */
+	if (opts->streaming_transfer == USB_ENDPOINT_XFER_BULK &&
+		uvc->event_setup_out &&
+		uvc->streaming_intf == interface &&
+		cs == UVC_VS_COMMIT_CONTROL) {
+		if (uvc->state == UVC_STATE_STREAMING)
+			uvc_function_set_alt(&uvc->func, uvc->streaming_intf, 0);
+		else if (uvc->state == UVC_STATE_BULK_WAITING)
+			uvc->state = UVC_STATE_BULK_SETTING;
+	}
+
 	memset(&v4l2_event, 0, sizeof(v4l2_event));
 	v4l2_event.type = UVC_EVENT_SETUP;
 	memcpy(&uvc_event->req, ctrl, sizeof(uvc_event->req));
@@ -255,9 +286,12 @@ uvc_function_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 
 void uvc_function_setup_continue(struct uvc_device *uvc)
 {
+	struct f_uvc_opts *opts = fi_to_f_uvc_opts(uvc->func.fi);
 	struct usb_composite_dev *cdev = uvc->func.config->cdev;
 
-	usb_composite_setup_continue(cdev);
+	/* delayed_status in bulk mode is 0, so it doesn't need to continue. */
+	if (opts->streaming_transfer != USB_ENDPOINT_XFER_BULK)
+		usb_composite_setup_continue(cdev);
 }
 
 static int
@@ -282,6 +316,7 @@ uvc_function_set_alt(struct usb_function *f, unsigned interface, unsigned alt)
 	struct usb_composite_dev *cdev = f->config->cdev;
 	struct v4l2_event v4l2_event;
 	struct uvc_event *uvc_event = (void *)&v4l2_event.u.data;
+	struct f_uvc_opts *opts = fi_to_f_uvc_opts(f->fi);
 	int ret;
 
 	uvcg_info(f, "%s(%u, %u)\n", __func__, interface, alt);
@@ -314,15 +349,19 @@ uvc_function_set_alt(struct usb_function *f, unsigned interface, unsigned alt)
 	if (interface != uvc->streaming_intf)
 		return -EINVAL;
 
-	/* TODO
-	if (usb_endpoint_xfer_bulk(&uvc->desc.vs_ep))
-		return alt ? -EINVAL : 0;
-	*/
-
 	switch (alt) {
 	case 0:
-		if (uvc->state != UVC_STATE_STREAMING)
-			return 0;
+		if (opts->streaming_transfer == USB_ENDPOINT_XFER_BULK) {
+			if (uvc->state == UVC_STATE_CONNECTED)
+				uvc->state = UVC_STATE_BULK_WAITING;
+			else if (uvc->state == UVC_STATE_STREAMING)
+				uvc->state = UVC_STATE_BULK_SETTING;
+			else
+				return 0;
+		} else {
+			if (uvc->state != UVC_STATE_STREAMING)
+				return 0;
+		}
 
 		if (uvc->video.ep)
 			usb_ep_disable(uvc->video.ep);
@@ -331,12 +370,19 @@ uvc_function_set_alt(struct usb_function *f, unsigned interface, unsigned alt)
 		v4l2_event.type = UVC_EVENT_STREAMOFF;
 		v4l2_event_queue(&uvc->vdev, &v4l2_event);
 
-		uvc->state = UVC_STATE_CONNECTED;
+		if (opts->streaming_transfer != USB_ENDPOINT_XFER_BULK)
+			uvc->state = UVC_STATE_CONNECTED;
+
 		return 0;
 
 	case 1:
-		if (uvc->state != UVC_STATE_CONNECTED)
-			return 0;
+		if (opts->streaming_transfer == USB_ENDPOINT_XFER_BULK) {
+			if (uvc->state != UVC_STATE_BULK_SETTING)
+				return 0;
+		} else {
+			if (uvc->state != UVC_STATE_CONNECTED)
+				return 0;
+		}
 
 		if (!uvc->video.ep)
 			return -EINVAL;
@@ -598,62 +644,101 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	unsigned int max_packet_size;
 	struct usb_ep *ep;
 	struct f_uvc_opts *opts;
+	int i = 0;
 	int ret = -EINVAL;
 
 	uvcg_info(f, "%s()\n", __func__);
 
 	opts = fi_to_f_uvc_opts(f->fi);
-	/* Sanity check the streaming endpoint module parameters. */
-	opts->streaming_interval = clamp(opts->streaming_interval, 1U, 16U);
-	opts->streaming_maxpacket = clamp(opts->streaming_maxpacket, 1U, 3072U);
-	opts->streaming_maxburst = min(opts->streaming_maxburst, 15U);
-
-	/* For SS, wMaxPacketSize has to be 1024 if bMaxBurst is not 0 */
-	if (opts->streaming_maxburst &&
-	    (opts->streaming_maxpacket % 1024) != 0) {
-		opts->streaming_maxpacket = roundup(opts->streaming_maxpacket, 1024);
-		uvcg_info(f, "overriding streaming_maxpacket to %d\n",
-			  opts->streaming_maxpacket);
-	}
 
-	/*
-	 * Fill in the FS/HS/SS Video Streaming specific descriptors from the
-	 * module parameters.
-	 *
-	 * NOTE: We assume that the user knows what they are doing and won't
-	 * give parameters that their UDC doesn't support.
-	 */
-	if (opts->streaming_maxpacket <= 1024) {
-		max_packet_mult = 1;
-		max_packet_size = opts->streaming_maxpacket;
-	} else if (opts->streaming_maxpacket <= 2048) {
-		max_packet_mult = 2;
-		max_packet_size = opts->streaming_maxpacket / 2;
+	/* Handle different transfer mode for stream endpoints */
+	if (opts->streaming_transfer == USB_ENDPOINT_XFER_BULK) {
+		uvc_fs_streaming_ep.bmAttributes = opts->streaming_transfer;
+		uvc_hs_streaming_ep.bmAttributes = uvc_fs_streaming_ep.bmAttributes;
+		uvc_ss_streaming_ep.bmAttributes = uvc_fs_streaming_ep.bmAttributes;
+
+		opts->streaming_maxburst = min(opts->streaming_maxburst, 15U);
+
+		if (opts->streaming_maxpacket % 1024 != 0) {
+			opts->streaming_maxpacket = roundup(opts->streaming_maxpacket, 1024);
+			uvcg_info(f, "overriding streaming_maxpacket to %d\n",
+				opts->streaming_maxpacket);
+		}
+
+		uvc_fs_streaming_ep.wMaxPacketSize = cpu_to_le16(64);
+		uvc_fs_streaming_ep.bInterval = 0;
+
+		uvc_hs_streaming_ep.wMaxPacketSize = cpu_to_le16(512);
+		uvc_hs_streaming_ep.bInterval = 0;
+
+		uvc_ss_streaming_ep.wMaxPacketSize = cpu_to_le16(1024);
+		uvc_ss_streaming_ep.bInterval = 0;
+
+		uvc_ss_streaming_comp.bmAttributes = 0;
+		uvc_ss_streaming_comp.bMaxBurst = opts->streaming_maxburst;
+		uvc_ss_streaming_comp.wBytesPerInterval = 0;
+
+		uvc->video.max_payload_size = opts->streaming_maxpacket;
 	} else {
-		max_packet_mult = 3;
-		max_packet_size = opts->streaming_maxpacket / 3;
-	}
+		uvc_fs_streaming_ep.bmAttributes = opts->streaming_transfer;
+		uvc_hs_streaming_ep.bmAttributes = uvc_fs_streaming_ep.bmAttributes;
+		uvc_ss_streaming_ep.bmAttributes = uvc_fs_streaming_ep.bmAttributes;
+
+		/* Sanity check the streaming endpoint module parameters. */
+		opts->streaming_interval = clamp(opts->streaming_interval, 1U, 16U);
+		opts->streaming_maxpacket = clamp(opts->streaming_maxpacket, 1U, 3072U);
+		opts->streaming_maxburst = min(opts->streaming_maxburst, 15U);
+
+		/* For SS, wMaxPacketSize has to be 1024 if bMaxBurst is not 0 */
+		if (opts->streaming_maxburst &&
+			(opts->streaming_maxpacket % 1024) != 0) {
+			opts->streaming_maxpacket = roundup(opts->streaming_maxpacket, 1024);
+			uvcg_info(f, "overriding streaming_maxpacket to %d\n",
+				opts->streaming_maxpacket);
+		}
 
-	uvc_fs_streaming_ep.wMaxPacketSize =
-		cpu_to_le16(min(opts->streaming_maxpacket, 1023U));
-	uvc_fs_streaming_ep.bInterval = opts->streaming_interval;
+		/*
+		 * Fill in the FS/HS/SS Video Streaming specific descriptors from the
+		 * module parameters.
+		 *
+		 * NOTE: We assume that the user knows what they are doing and won't
+		 * give parameters that their UDC doesn't support.
+		 */
+		if (opts->streaming_maxpacket <= 1024) {
+			max_packet_mult = 0;
+			max_packet_size = opts->streaming_maxpacket;
+		} else if (opts->streaming_maxpacket <= 2048) {
+			max_packet_mult = 1;
+			max_packet_size = opts->streaming_maxpacket / 2;
+		} else {
+			max_packet_mult = 2;
+			max_packet_size = opts->streaming_maxpacket / 3;
+		}
 
-	uvc_hs_streaming_ep.wMaxPacketSize =
-		cpu_to_le16(max_packet_size | ((max_packet_mult - 1) << 11));
+		uvc_fs_streaming_ep.wMaxPacketSize =
+			cpu_to_le16(min(opts->streaming_maxpacket, 1023U));
+		uvc_fs_streaming_ep.bInterval = opts->streaming_interval;
 
-	/* A high-bandwidth endpoint must specify a bInterval value of 1 */
-	if (max_packet_mult > 1)
-		uvc_hs_streaming_ep.bInterval = 1;
-	else
-		uvc_hs_streaming_ep.bInterval = opts->streaming_interval;
+		uvc_hs_streaming_ep.wMaxPacketSize =
+			cpu_to_le16(max_packet_size | (max_packet_mult << 11));
+
+		/* A high-bandwidth endpoint must specify a bInterval value of 1 */
+		if (max_packet_mult > 0)
+			uvc_hs_streaming_ep.bInterval = 1;
+		else
+			uvc_hs_streaming_ep.bInterval = opts->streaming_interval;
+
+		uvc_ss_streaming_ep.wMaxPacketSize = cpu_to_le16(max_packet_size);
+		uvc_ss_streaming_ep.bInterval = opts->streaming_interval;
+
+		uvc_ss_streaming_comp.bmAttributes = max_packet_mult;
+		uvc_ss_streaming_comp.bMaxBurst = opts->streaming_maxburst;
+		uvc_ss_streaming_comp.wBytesPerInterval =
+			cpu_to_le16(max_packet_size * (max_packet_mult + 1) *
+				(opts->streaming_maxburst + 1));
 
-	uvc_ss_streaming_ep.wMaxPacketSize = cpu_to_le16(max_packet_size);
-	uvc_ss_streaming_ep.bInterval = opts->streaming_interval;
-	uvc_ss_streaming_comp.bmAttributes = max_packet_mult - 1;
-	uvc_ss_streaming_comp.bMaxBurst = opts->streaming_maxburst;
-	uvc_ss_streaming_comp.wBytesPerInterval =
-		cpu_to_le16(max_packet_size * max_packet_mult *
-			    (opts->streaming_maxburst + 1));
+		uvc->video.max_payload_size = 0;
+	}
 
 	/* Allocate endpoints. */
 	ep = usb_ep_autoconfig(cdev->gadget, &uvc_control_ep);
@@ -667,7 +752,7 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 		ep = usb_ep_autoconfig_ss(cdev->gadget, &uvc_ss_streaming_ep,
 					  &uvc_ss_streaming_comp);
 	else if (gadget_is_dualspeed(cdev->gadget))
-		ep = usb_ep_autoconfig(cdev->gadget, &uvc_hs_streaming_ep);
+		ep = usb_ep_autoconfig_ss(cdev->gadget, &uvc_hs_streaming_ep, NULL);
 	else
 		ep = usb_ep_autoconfig(cdev->gadget, &uvc_fs_streaming_ep);
 
@@ -709,6 +794,28 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	uvc->streaming_intf = ret;
 	opts->streaming_interface = ret;
 
+	/* Handle different transfer mode for descriptors */
+	i = 0;
+	if (opts->streaming_transfer == USB_ENDPOINT_XFER_BULK) {
+		uvc_streaming_intf_alt0.bNumEndpoints = 1;
+	} else {
+		uvc_streaming_intf_alt0.bNumEndpoints = 0;
+
+		uvc_fs_streaming[i] = USBDHDR(&uvc_streaming_intf_alt1);
+		uvc_hs_streaming[i] = USBDHDR(&uvc_streaming_intf_alt1);
+		uvc_ss_streaming[i] = USBDHDR(&uvc_streaming_intf_alt1);
+		++i;
+	}
+	uvc_fs_streaming[i] = USBDHDR(&uvc_fs_streaming_ep);
+	uvc_hs_streaming[i] = USBDHDR(&uvc_hs_streaming_ep);
+	uvc_ss_streaming[i] = USBDHDR(&uvc_ss_streaming_ep);
+	++i;
+	uvc_fs_streaming[i] = NULL;
+	uvc_hs_streaming[i] = NULL;
+	uvc_ss_streaming[i] = USBDHDR(&uvc_ss_streaming_comp);
+	++i;
+	uvc_ss_streaming[i] = NULL;
+
 	/* Copy descriptors */
 	f->fs_descriptors = uvc_copy_descriptors(uvc, USB_SPEED_FULL);
 	if (IS_ERR(f->fs_descriptors)) {
@@ -872,6 +979,7 @@ static struct usb_function_instance *uvc_alloc_inst(void)
 
 	opts->streaming_interval = 1;
 	opts->streaming_maxpacket = 1024;
+	opts->streaming_transfer = USB_ENDPOINT_SYNC_ASYNC | USB_ENDPOINT_XFER_ISOC;
 	snprintf(opts->function_name, sizeof(opts->function_name), "UVC Camera");
 
 	ret = uvcg_attach_configfs(opts);
diff --git a/drivers/usb/gadget/function/u_uvc.h b/drivers/usb/gadget/function/u_uvc.h
index 24b8681b0d6f..88cd235e0ea8 100644
--- a/drivers/usb/gadget/function/u_uvc.h
+++ b/drivers/usb/gadget/function/u_uvc.h
@@ -24,6 +24,7 @@ struct f_uvc_opts {
 	unsigned int					streaming_interval;
 	unsigned int					streaming_maxpacket;
 	unsigned int					streaming_maxburst;
+	unsigned int					streaming_transfer;
 
 	unsigned int					control_interface;
 	unsigned int					streaming_interface;
diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 40226b1f7e14..b00cba322643 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -123,6 +123,8 @@ enum uvc_state {
 	UVC_STATE_DISCONNECTED,
 	UVC_STATE_CONNECTED,
 	UVC_STATE_STREAMING,
+	UVC_STATE_BULK_WAITING,
+	UVC_STATE_BULK_SETTING,
 };
 
 struct uvc_device {
diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index 4303a3283ba0..ef7c4f6630d4 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -2348,11 +2348,72 @@ end:									\
 UVC_ATTR(f_uvc_opts_, cname, cname)
 
 UVCG_OPTS_ATTR(streaming_interval, streaming_interval, 16);
-UVCG_OPTS_ATTR(streaming_maxpacket, streaming_maxpacket, 3072);
+UVCG_OPTS_ATTR(streaming_maxpacket, streaming_maxpacket, 0x40000000U);
 UVCG_OPTS_ATTR(streaming_maxburst, streaming_maxburst, 15);
 
 #undef UVCG_OPTS_ATTR
 
+#define UVCG_OPTS_ATTR_TRANSFER(cname, aname)				\
+static ssize_t f_uvc_opts_##cname##_show(				\
+	struct config_item *item, char *page)				\
+{									\
+	struct f_uvc_opts *opts = to_f_uvc_opts(item);			\
+	int result;							\
+	char *str;							\
+									\
+	mutex_lock(&opts->lock);					\
+	switch (opts->cname) {						\
+	case USB_ENDPOINT_XFER_BULK:					\
+		str = "bulk";						\
+		break;							\
+	case USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC:		\
+		str = "isoc";						\
+		break;							\
+	default:							\
+		str = "unknown";					\
+		break;							\
+	}								\
+	result = sprintf(page, "%s\n", str);				\
+	mutex_unlock(&opts->lock);					\
+									\
+	return result;							\
+}									\
+									\
+static ssize_t								\
+f_uvc_opts_##cname##_store(struct config_item *item,			\
+			   const char *page, size_t len)		\
+{									\
+	struct f_uvc_opts *opts = to_f_uvc_opts(item);			\
+	int ret = 0;							\
+									\
+	mutex_lock(&opts->lock);					\
+	if (opts->refcnt) {						\
+		ret = -EBUSY;						\
+		goto end;						\
+	}								\
+									\
+	if (!strncmp(page, "bulk", 4))					\
+		opts->cname = USB_ENDPOINT_XFER_BULK;			\
+	else if (!strncmp(page, "isoc", 4))				\
+		opts->cname = USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC; \
+	else {								\
+		ret = -EINVAL;						\
+		goto end;						\
+	}								\
+									\
+	ret = len;							\
+									\
+end:									\
+	mutex_unlock(&opts->lock);					\
+	return ret;							\
+}									\
+									\
+UVC_ATTR(f_uvc_opts_, cname, cname)
+
+UVCG_OPTS_ATTR_TRANSFER(streaming_transfer, streaming_transfer);
+
+#undef UVCG_OPTS_ATTR_TRANSFER
+
 #define UVCG_OPTS_STRING_ATTR(cname, aname)				\
 static ssize_t f_uvc_opts_string_##cname##_show(struct config_item *item,\
 					 char *page)			\
@@ -2399,6 +2460,7 @@ static struct configfs_attribute *uvc_attrs[] = {
 	&f_uvc_opts_attr_streaming_interval,
 	&f_uvc_opts_attr_streaming_maxpacket,
 	&f_uvc_opts_attr_streaming_maxburst,
+	&f_uvc_opts_attr_streaming_transfer,
 	&f_uvc_opts_string_attr_function_name,
 	NULL,
 };
diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index 0aa3d7e1f3cc..2695b3ed29b5 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -54,9 +54,13 @@ static int uvc_queue_setup(struct vb2_queue *vq,
 
 	sizes[0] = video->imagesize;
 
-	req_size = video->ep->maxpacket
-		 * max_t(unsigned int, video->ep->maxburst, 1)
-		 * (video->ep->mult);
+	/* Bulk mode uses max_payload_size as req_size */
+	if (video->max_payload_size)
+		req_size = video->max_payload_size;
+	else
+		req_size = video->ep->maxpacket
+			 * max_t(unsigned int, video->ep->maxburst, 1)
+			 * (video->ep->mult);
 
 	/* We divide by two, to increase the chance to run
 	 * into fewer requests for smaller framesizes.
@@ -143,7 +147,9 @@ int uvcg_queue_init(struct uvc_video_queue *queue, struct device *dev, enum v4l2
 	queue->queue.buf_struct_size = sizeof(struct uvc_buffer);
 	queue->queue.ops = &uvc_queue_qops;
 	queue->queue.lock = lock;
-	if (cdev->gadget->sg_supported) {
+
+	/* UDC supports scatter gather and transfer mode isn't bulk. */
+	if (cdev->gadget->sg_supported && !video->max_payload_size) {
 		queue->queue.mem_ops = &vb2_dma_sg_memops;
 		queue->use_sg = 1;
 	} else {
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index dd1c6b2ca7c6..70737340acfb 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -271,8 +271,10 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 		break;
 
 	default:
-		uvcg_warn(&video->uvc->func,
-			  "VS request completed with status %d.\n",
+		if (uvc->state == UVC_STATE_BULK_WAITING ||
+			uvc->state == UVC_STATE_BULK_SETTING)
+			break;
+		uvcg_warn(&uvc->func, "VS request completed with status %d.\n",
 			  req->status);
 		uvcg_queue_cancel(queue, 0);
 	}
@@ -328,9 +330,13 @@ uvc_video_alloc_requests(struct uvc_video *video)
 
 	BUG_ON(video->req_size);
 
-	req_size = video->ep->maxpacket
-		 * max_t(unsigned int, video->ep->maxburst, 1)
-		 * (video->ep->mult);
+	/* Bulk mode uses max_payload_size as req_size */
+	if (video->max_payload_size)
+		req_size = video->max_payload_size;
+	else
+		req_size = video->ep->maxpacket
+			 * max_t(unsigned int, video->ep->maxburst, 1)
+			 * (video->ep->mult);
 
 	video->ureq = kcalloc(video->uvc_num_requests, sizeof(struct uvc_request), GFP_KERNEL);
 	if (video->ureq == NULL)
-- 
2.17.1


**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidential Information and is intended solely for the use of the individual(s) to whom it is addressed. Any unauthorized review, use, disclosure, distribute, copy, or print is prohibited. If you are not an intended recipient, please contact the sender by reply email and destroy all copies of the original message. Thank you.
