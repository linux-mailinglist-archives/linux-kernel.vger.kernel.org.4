Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180256144EE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 08:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKAHOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 03:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAHOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 03:14:00 -0400
X-Greylist: delayed 1981 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Nov 2022 00:14:00 PDT
Received: from mx0a-00622301.pphosted.com (mx0a-00622301.pphosted.com [205.220.163.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0402E12D20
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 00:13:59 -0700 (PDT)
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A15S6ww026039;
        Mon, 31 Oct 2022 23:18:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=com20210415pp;
 bh=Um+Vqh/z3Sqowqf6H4CXl3c5zAySxPpO8OP6vNahBAM=;
 b=1cSToc6TLVm1F96iseQcxUxHNd6U71aO4Xbqi6adZeNxf9nNlLJcbyMVBkxSERop2djp
 lIur1loqihPKlhcDys1F6zKrIzarg3bHlIw1APWqwiQmSpDZzH9NxnaC/T8iwiq19rfb
 JNvIKYu4fPaK7K5OweQnG2z9UvHS3HUZKKv5xxpw3f5ymjQg2NrEZrivZT6CB08o17NZ
 ac2CUvsoNa5yToDmr8wGOz+IdWdVYBP8k1KQP28RiZUF4o0TNn97leVyuNiSeh8seHCu
 P2tiCGtm/7yix/ceufkTuiGmki5JYHnGbbfEr3g/nBlnQNv8JxzKY++e1MsCovtUcFvV Dg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3kjbchgcq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 23:17:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIuVPhSG/yCKvaBAR+xt1RHag2VaLTNyyJOksWfrUCI9jQHxRTHb/TYS/WazqV+Ftn2DujDVpD4buTcDzynPQErdvvw9dknQEsMmsWW9Yf4salLvF5Ue/s5fcbXAnaAxmDEjE+8FlmLcXWNsva+TliEvuVy78eeAaXmt59Nm2rVB5bXNo1p0SdJFk71VfPcxuJTlMkjkMkfKMtJpJ83krl+mXp4+f+OuuijbG6EMhRpKYGeuK3RmJXBHYr1ZG5hFPFuNrUy+/BQYGonLn+ZT2NGXtD3ARMhjsOryFVo2DLDWXwtnZvqzhzk+nUYXNT+DACkGFlTpGrbRhBg1YUCcrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9j5ESlIg0TGMaDJlTMBnvrVXsvJfvcFzTAsXj9HRLec=;
 b=mRfD1IRX9tZu7thvgyCmVVhnRNbQVmTCbaFX3JuzknkYMmIiKXa672tp95cpjYYLIG6xSQnJpTU7MDimD0W/J4VMZfIsMOg/G0vh6mGiAUdWCe59MM+xU3VpFemNQAy5Z9IGShJxQIs76lEclmp88CFlIQd7fVhcDHJdS6Mz7FGaYp+yC0ZVYGV9fhFYsNS/Ykc8+YADEMZPrFLL1QXMtt0MymOoRXBTME1mD8XMFdDFPPGggmssSrZxB4+FPjstt+OPPuOre1ePc/YYPD37ODhMra5IOGmhysUyOeaEFhj9JBaxATUT/NpO8UzJttMri53K7NBtZFhybhVsMmVhEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9j5ESlIg0TGMaDJlTMBnvrVXsvJfvcFzTAsXj9HRLec=;
 b=MHjmCrLD4mVfV1HysLvC/HRH/JwQiQqbG5NfPJca+W5ZJzjicvupokMfidm/ruUBqlYfVYkBf9PjlCwKMhUNBU7j+FrjrKE3qJDA19+Zfcm8M5pN72YTVZ0TxOaYWlKPC6tAl25PBU+jOs5pT1fGjdIDgNW4++LYIcyhPejE9YDQ73GN12V2liL7mlOgQERxV72ldT+/qHSdYIuyVLlVlL7C5/1SoAc6yFgTcXkzfc7odlHCbQBhCVvOXwbHvL1/S+RIP/Vse6jC2m2GbLDy5IW2lezof9UiUQJD2sI5vDj6YQcKPNBCJR2biAYi/Neg/K8tz/8oxtbVpCE0Xa0knQ==
Received: from DS7PR19MB6254.namprd19.prod.outlook.com (2603:10b6:8:9a::19) by
 DM6PR19MB4025.namprd19.prod.outlook.com (2603:10b6:5:24b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.16; Tue, 1 Nov 2022 06:17:53 +0000
Received: from DS7PR19MB6254.namprd19.prod.outlook.com
 ([fe80::39c:3d8c:e6cd:d3aa]) by DS7PR19MB6254.namprd19.prod.outlook.com
 ([fe80::39c:3d8c:e6cd:d3aa%7]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 06:17:53 +0000
From:   Jing Leng <jleng@ambarella.com>
To:     gregkh@linuxfoundation.org, pawell@cadence.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Jing Leng <jleng@ambarella.com>
Subject: [PATCH v3] usb: cdnsp: Fix wrong transmission direction of EP0
Date:   Tue,  1 Nov 2022 14:17:30 +0800
Message-Id: <20221101061730.8991-1-jleng@ambarella.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221101044433.5627-1-3090101217@zju.edu.cn>
References: <20221101044433.5627-1-3090101217@zju.edu.cn>
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To DS7PR19MB6254.namprd19.prod.outlook.com
 (2603:10b6:8:9a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB6254:EE_|DM6PR19MB4025:EE_
X-MS-Office365-Filtering-Correlation-Id: c74795dc-b4e9-4195-f180-08dabbd0cf62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9XLLWprLmVPRzrzMXa9sbzvsy0HZlHJnDKbhaDVRmY19R1797clWCKknNRjVOAzhCFwJQhtV1ZHCzUHrfR3L8Nj0S/EeJ1AgjPjcY6g+Vkbhl6aSszZgs8MtY4CTyQuIx3LH0y0KBn8OY92VL31E7R0iHXm9fW2bppXTnS8jkyhjJGOzJlcWpQ5Sjp7q+8UiuOHqL2mPK4dZNChimrTCEFEql58zrKQERrhxrr9M7lzS9mOR90kUublP2GghvtqXCIw23QsurgMEQskw3mjH/4WGUCYTy6dgtqK+bodkgBRWj11CbE53qikHjjSMXx+ZEP6Sg7JfOBGEfp4EVuPiLgwZfTGnKr5nWS5FBVsY5hjrKmdP5FwKyFcf/vmRIMnKbSrrfXYUSf3+4imocQZwoglivQWN36rz6hB1Ash016O2Yg6PcmKc+EhIA+3tbED4wnmkZMoa3lTUc5sO3RpwEZg5f5n/AL8ZbcuBhEvpsuUkUiwmWi11kNYc3U8NA+eXW0aps4BOk05NSgqGPgnmnB2SS6hXGCNsoIIwVyWoZOTmcZxJ/QTMpRpIs6OCygJrwV+ID/Tm6DGwuDUj3NzSp1noKDBANApZEnNtuyUeld13h3EJnG5izJsqKPIKBRcJ7Gs7sLgHfuD3+PXMc8wklVTIiyFyQ8OkKmUFvI0mJP/kQakv0ltkbWDuAzE5/lgP2aCzhgJoO6+nBSV9WYbhIf+1N4gub/qqvfjRduUDKIW+S6mOFbh8/2dzMTsBKavkloGlYLUdp34Nr1t9Wf5Z7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB6254.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39840400004)(136003)(346002)(376002)(396003)(366004)(451199015)(8936002)(41300700001)(5660300002)(26005)(6512007)(38100700002)(38350700002)(86362001)(2616005)(1076003)(2906002)(186003)(36756003)(83380400001)(478600001)(6486002)(66556008)(66946007)(66476007)(8676002)(4326008)(107886003)(6666004)(52116002)(6506007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sk2Lf83C0UIpi2GCBDGoNj/s76ru7yLoNpDbnKGPACWSpDquHy3VQvusZBwe?=
 =?us-ascii?Q?JPNzsEGTPmYsI2Vsf1AjFaN7I6m9k3rLlM9+wrbkWibEBe3/F4QW8RP364JW?=
 =?us-ascii?Q?PSR353S1FYwwDXhFpOLyDoOe3s46kSeqNrx9hG6hytcyTTWULeBAYSAs5LY0?=
 =?us-ascii?Q?4qnze9QosQkLMKhLJZdiTNuR+prciiQecycSQkLlv7UUuRPQk3l8YmUA/CXJ?=
 =?us-ascii?Q?GkubgwdbJY+E7vn4uQ0FifF03Sem0Nbsp1HqItMkZubG7glogQuzdI2EezoO?=
 =?us-ascii?Q?GSb0h8fOttDXWEE/9K7VWtdjeVvbAjK/n/U+8mkAQP0UHfn4LrrkU2Q/XJPK?=
 =?us-ascii?Q?rqalNBlJ4QwEGy/WbHy5LGx4tKrEv0mHk1iPKa4tFRpYgqlgcu6R24r39NeA?=
 =?us-ascii?Q?r1wVR3p4Xo25YRNK3wLaVu/tw3ly4QZYyUfKsTJq3AmE6Br390l8VUOiuQw0?=
 =?us-ascii?Q?ftRnbP0f5BILyPZkFHVwqJMtt0ynb2WixshMp3Xi8ejTBqL98eX37jvjHJT6?=
 =?us-ascii?Q?lWWD7OOJNYEJvmXU5nI6+j4N6tGk/zMS9g6oXlyoN9o+mXxpuO9v0wKIWAAK?=
 =?us-ascii?Q?uncvlqhDRioq0hX8AHLvINc8HwWHFe3PQV7l7FU4icnV2lmJ54PiRLsslcCD?=
 =?us-ascii?Q?wouomSHc2le/rVQAFdNAM+C9PVJlMPpmFBC79PCNOdsigj4f8Z12E2bhUnWA?=
 =?us-ascii?Q?pW0sc7d9fl+3qWSjqckvczZGsBLWsgNEb6XCisWrABZNf9RkmANEcnTachad?=
 =?us-ascii?Q?LLuNB0Ti6qMY7DG06IW91gArIfATrLG+I8uF+MV79OBNbuzFGWxo0AtJ9rBn?=
 =?us-ascii?Q?m5uKdof6dFmw8KDGK/ihu7eBXvp3jTz2PCkgnIMq70xo0icFMOvyX4iVLKQ9?=
 =?us-ascii?Q?cMKXXgY9/qiLnMRribuaLpaLT+UUUkc+IQKSsY54M4QsigLGZSbVN9Av1smG?=
 =?us-ascii?Q?seamAwUw5xS4m2EpHZzptCzAKBXbimx3jKHJS8zwjT2gkFMCSB/1bqn70XRh?=
 =?us-ascii?Q?omVkUIhShYIj+W9P5whglmy8is1IAg5sdgVUaJy4ImL7XHgCpbbAxrqTl574?=
 =?us-ascii?Q?D7AYjHZRfTbXIy0YGHHC5vDBZmo00ahOy8tcsD3COSqWw/7beeaZWD/lUC61?=
 =?us-ascii?Q?brr6KQ2FUkIHJcFSmwBXpT+DdUZKBWx9WFumkVu8MB+zErLDLAQpwvvTctO4?=
 =?us-ascii?Q?DJkxHOrHO6CNuyEdWYWSrIkoeiQtyOsxwx6flqQCYrN408dJJ750ZorDg6ik?=
 =?us-ascii?Q?NKIcVEiE1xKnFxKn4HFEG5m6p0W7vzlsqDF4FojNHpxNr/wKB/qPhkDZQ2Dj?=
 =?us-ascii?Q?dUF9gFJdRnQk1+23G2sOEhJHAxmI9QfmizTIU6lN863twQCXM2HkSPWoWO9z?=
 =?us-ascii?Q?r2dRup1BRrmXjI7Yd8p/Xx5KLOTbaGg31PrKDnmAzGwi7j/3bg6nP0nIe/91?=
 =?us-ascii?Q?r5zruztx+aHzrxhnlq5ncHK/d+rkspi13v99pwaSYoSIC3BIf5DX9Dcxc+u/?=
 =?us-ascii?Q?qYOWhf2kbib28KZoWU1fTFsxZAy0cRLjdPssCiYwTu4uxd+T6QMPR66Xcnwn?=
 =?us-ascii?Q?jHyyU7m96OvHwU5yzwLA/MtnZn4zaW6RAoEVneQi?=
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74795dc-b4e9-4195-f180-08dabbd0cf62
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB6254.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 06:17:53.5950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdL2IhtmGj45yl6/ryQ0Rf1RgIJANwwMzwMIBIsI+UiC2B8r4rEcQ2c+yfnxsMdcecA5QgW+Eoq8MPIn/gx0Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4025
X-Proofpoint-GUID: TczERBD7ClnCmw2qFs3OqSPYWFrDI9jw
X-Proofpoint-ORIG-GUID: TczERBD7ClnCmw2qFs3OqSPYWFrDI9jw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_01,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1011 malwarescore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 mlxlogscore=793 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EP0 transfer is bi-directional, but in the cdnsp gadget, the
transmission direction of EP0 is not changed after it is
initialized to IN, so the OUT data from EP0 received by the host
is invalid.

The value of ep0_expect_in will change according to the value of
bRequestType in the SETUP transaction of control transfer, so we
can use it as the transmission direction of EP0.

Signed-off-by: Jing Leng <jleng@ambarella.com>
---
ChangeLog v2->v3:
- Repair my email address.
ChangeLog v1->v2:
- Rebase the patch.
- Make email addresses ('From' and 'Signed-off-by') consistent.
---
 drivers/usb/cdns3/cdnsp-gadget.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index c67715f6f756..526f80651d35 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -345,6 +345,7 @@ int cdnsp_ep_enqueue(struct cdnsp_ep *pep, struct cdnsp_request *preq)
 {
 	struct cdnsp_device *pdev = pep->pdev;
 	struct usb_request *request;
+	u8 direction;
 	int ret;
 
 	if (preq->epnum == 0 && !list_empty(&pep->pending_list)) {
@@ -355,11 +356,14 @@ int cdnsp_ep_enqueue(struct cdnsp_ep *pep, struct cdnsp_request *preq)
 	request = &preq->request;
 	request->actual = 0;
 	request->status = -EINPROGRESS;
-	preq->direction = pep->direction;
+
+	direction = usb_endpoint_xfer_control(pep->endpoint.desc) ?
+		    pdev->ep0_expect_in : pep->direction;
+	preq->direction = direction;
 	preq->epnum = pep->number;
 	preq->td.drbl = 0;
 
-	ret = usb_gadget_map_request_by_dev(pdev->dev, request, pep->direction);
+	ret = usb_gadget_map_request_by_dev(pdev->dev, request, direction);
 	if (ret) {
 		trace_cdnsp_request_enqueue_error(preq);
 		return ret;
@@ -387,8 +391,7 @@ int cdnsp_ep_enqueue(struct cdnsp_ep *pep, struct cdnsp_request *preq)
 	return 0;
 
 unmap:
-	usb_gadget_unmap_request_by_dev(pdev->dev, &preq->request,
-					pep->direction);
+	usb_gadget_unmap_request_by_dev(pdev->dev, &preq->request, direction);
 	list_del(&preq->list);
 	trace_cdnsp_request_enqueue_error(preq);
 
-- 
2.17.1


**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidential Information and is intended solely for the use of the individual(s) to whom it is addressed. Any unauthorized review, use, disclosure, distribute, copy, or print is prohibited. If you are not an intended recipient, please contact the sender by reply email and destroy all copies of the original message. Thank you.
