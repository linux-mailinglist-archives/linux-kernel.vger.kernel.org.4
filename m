Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AFB6EDA99
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjDYDUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjDYDT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:19:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01CC4EE4;
        Mon, 24 Apr 2023 20:19:57 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P0iOtc032363;
        Tue, 25 Apr 2023 03:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=v/a5gXd/vjv7nRIemwo86chciL0ou/ALONebBTfLUq8=;
 b=XwhcXi+OCkMbrzUCii/DCzVBcWaTHgH0gKfpYIICgkHaseP2UzDBvg9sqquvbbYK9BVn
 vpUtTEe0opJ+b1uvJvK+KwCVKLOtN855wYjTfZFOv3A67h4Z3iAaReDGWBupnzYylTt1
 ZuWyOUza69uK9x2d2vYF7IErh8KCs2YgTy5wrTr9iU9VNDVuSlaqgAKYzpjfKfNxprIp
 SM4+1tqlMI9Lh6e3kem0NVmtrr0keEoTKG2/fGx1fHYd0TG37yCQwWEnvvOZfABdWXgb
 UZK1T+DvR+u9s76mY6DW/11ddzn7RpvcLOHlyG63Fhhu1PxmKeV6LU7g6W1XTVy7w7vp RA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46gbmd2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 03:19:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33P2VWSK013267;
        Tue, 25 Apr 2023 03:19:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q4615krjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 03:19:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ol6/Md95El+GI8U/p67QKOQiZRMcWyB3e/2KD6c5dATQ4dUTm4S3k4GS0T0DUwp7ZbJXpWGFhb7UjaPOzGSWLQSyRGOH0/j2Uzf9jZCfk0mK+5p+0fDSA9mrtPc02tqAgZ1qD1cBcXKUoLFfC1YSk1xN9IFMJ3BHyAwBO4PrxO7OlMWqvC39+LhKx1mhkCc1d3aa9mn70Cnvy972tlE/h1//y0UfaT/JLGWjmBAWr0cCDAGdi8M/S7Dv3hA7xOSpr6ScMa42Kstvaxo2vDv9xEfFqN4zzKdD8eiruKxjXHg+mQbIx/CPcLcqepkEBVyQ99E7SHdQEqvi1H+jAYD4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/a5gXd/vjv7nRIemwo86chciL0ou/ALONebBTfLUq8=;
 b=Pu6eXmP0oXSeN4N9P3N77Qz69fv7TCRls88Hk46KyQEYUKy6EEbKgWCJLYuUnu3eXVzHdXzsIAhMHsNz3xugChvoxRf2tETYhRB9zvd3YJ8Zhrzweh6xeZdMSdUE2M5DPQB6SHL1WxXCS/ukdEM3xZOooHRK+SeGw1yE7FsUeVGvdYIybqsYBF6wlUPaxyFC/lyTZtEa3Pg/UrGyGNs+SzCLg3uOrwiU1wPHZQlFw/efoMcoYoYqQ83JG55RDf2UzOme2f3Yv4yqMne71uO9qa783EP21KxcsSxL+N0XHtTp112yE0KjuBwjfvG88Ukiy6RYwDWgmSsQ1xE2ordfvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/a5gXd/vjv7nRIemwo86chciL0ou/ALONebBTfLUq8=;
 b=c/5n8P6/Q8jNEFTW0vTwz1W629cq/lyP1OFPCiis4WXvzkiAzODm44ag1gUGSnKd5OfSXkozS+ofnjf/nt27HOjfcuWPlHd+RziLX65i0uRCR/qg+5cbdkGQG8Fuvcrmu54WE4eOlbKBqDewzWpDchl/kNuwoot0wDnpLF+mfSU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH2PR10MB4152.namprd10.prod.outlook.com (2603:10b6:610:79::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 03:19:33 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 03:19:33 +0000
To:     Alice Chao <alice.chao@mediatek.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Can Guo <quic_cang@quicinc.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <powen.kao@mediatek.com>, <naomi.chu@mediatek.com>,
        <cc.chou@mediatek.com>, <chaotian.jing@mediatek.com>,
        <jiajie.hao@mediatek.com>, <tun-yu.yu@mediatek.com>,
        <eddie.huang@mediatek.com>, <wsd_upstream@mediatek.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 1/1] scsi: ufs: core: Fix &hwq->cq_lock deadlock issue
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r0s8k5sn.fsf@ca-mkp.ca.oracle.com>
References: <20230424080400.8955-1-alice.chao@mediatek.com>
Date:   Mon, 24 Apr 2023 23:19:30 -0400
In-Reply-To: <20230424080400.8955-1-alice.chao@mediatek.com> (Alice Chao's
        message of "Mon, 24 Apr 2023 16:03:56 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0036.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH2PR10MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b115a6-89ad-4d4b-76af-08db453be3d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: upmraEGYSSNmcyiaNY/NzSAfMqWPtcNUa0KZ1bNLLCfSmyECJ+N4Dc8XG4B5CeCZAuByPLzvmo414VnnNySVhOCcJLqe4XOFplr8OR6QWd4jJ1qT5o6OF7fh3jXxRFjp8lg70HVvZMM9uzcgie48D1uqshPXjGec/v/1/fBpGPGKP+I2CFx2onFh876h1W7HRj/+qe6osHaz9CGZakichhCFS8wekmxJR1t+lG9mOg5tJu3Ag6XtQhDlwe0lV74YKC0IqP4tFo2juJL9sTyjA4ss0jKad2YGzQkcMrGI85Gnid9QlnS5AzSwm0QoG5x05Db8J1NeVMYnH+7vq+JDCwj5STOCSyyfNnB481NH9VrRTpBoClo8u0U2Jb+4f1vp/OA58GwCro08K19NqIFlEC/l9BPo5tEr49TBezBkS1vrm7cfaIi9jGw8ErGyUgiJ1sAxsqPxJ6XlLICh4FoVDYtW7tWI4Xna8vyFUG76V6GxKyUhLuJglqXfMdhEBHtUdKyM2YmfFXLMBpKStQV7O8l5skleqmKX5G7m4DDPMS6UCNLy9aYGG7ByQi0RGR2h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(38100700002)(6506007)(6512007)(26005)(186003)(8936002)(83380400001)(4744005)(7416002)(2906002)(8676002)(5660300002)(478600001)(54906003)(6486002)(36916002)(316002)(4326008)(6916009)(66556008)(41300700001)(66946007)(86362001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NOc9HimwnVRSIRNemPCmrDy3znLa+wQYS+FCUImjWiKKwB2F1nkRFmghildK?=
 =?us-ascii?Q?o4Ofd+pG8B2+Ae+jxwCXlrLVOMNyBQXh8aM40oQANY99RDXtJJgPCh5PKj5q?=
 =?us-ascii?Q?N6EK42PA28d8ZGlCKWBVYPsiCHASx14G21FDk1a957hvoXF6qA0LbK2W4es9?=
 =?us-ascii?Q?5F6oVS4yrdXbiU6otCOLrLd4oNCqvNf2FFc2eob5t81QMF9TVIx4DZJ3NJjq?=
 =?us-ascii?Q?GN7zxSFpVNtV1owK+wpb47vQ8WajxtfQjdv9RYZM2neN2XZuzc0UujT0owQO?=
 =?us-ascii?Q?gRPI8EGIfjDl9Z2AmTi0MC3r8AVT2EztLAh9fqBsCMfy09Qr8OUDHGiMfKJn?=
 =?us-ascii?Q?0P6IdBXFK03xSRFmvkQNyzQiLTKCo5erSmHu9lrWKsR1dqlwwY54Mj/5+c2t?=
 =?us-ascii?Q?lHBvi5WxSsxvCkcef5SpVoDm28o+btDFDcLXm80PNW0x/1+EtIguHXZzeYVQ?=
 =?us-ascii?Q?dP4QcOLitYOzW7siav3plA49PQdhf8TFb3ozAIil1DpmytCNEIYFaLpT2y92?=
 =?us-ascii?Q?qeerZcze58AoAlxVYG4KdLc7FooNP0hDEz9wRqokpb6ZZc4+aCljiiUQxWhH?=
 =?us-ascii?Q?Dg8y85LZr2fnqIfiQ0CUmDTcbHwrVlkY8HF4bYGz1m7jENQeCsumpHdiYGxI?=
 =?us-ascii?Q?ERCdRwvPYuI0Kdt6yuGsEdgwDN/gnq+7Bu+4jVGnfotEWwOYFjrfT4K1hWaU?=
 =?us-ascii?Q?98iH2Tg62x0bFGfN3twDtrR4j6Iud+9+L0k0c+7syV21haqMWq8bNKnlbpi2?=
 =?us-ascii?Q?R5aFr6xXvOgEkx5mkcDtg30B9qKhb3e5rIfKD8Lp+pd8s49b1AOarHlurlE8?=
 =?us-ascii?Q?KGW8m1x73O3ef3QZG9y+lIF113fEwHOiz9xXstYziwxU11+hoimDwwZl2Mqh?=
 =?us-ascii?Q?5iiK0K0xkFEdLyQrErlMIku8cg11Z5rPE3H0W22wBeZ1IwnhVf1NnMZTlyWE?=
 =?us-ascii?Q?nS43JAR1I4TJ6EZkGit/d2yvuUGB5GP6O/m+3Ok3Mqwmqw/J6EPJ0h29E/SC?=
 =?us-ascii?Q?drLm/JrmJz6OIYQyXx+KjYXBKEyeLIRCRbeMetXz3rkxDpzdR1+hVQGp87rP?=
 =?us-ascii?Q?viT04gcuJluNBcGPZLm0XzBX1NKVAN8N0nzF2Gx+61fZmWggxkBjV4C7mbsZ?=
 =?us-ascii?Q?okOC05OL8uj0KfH9k17egyFD6Cn3tTn9zCSgj6aPvyllmgw01P4lBlKhhcbb?=
 =?us-ascii?Q?3O0v8C8CLl18qUVrnJaipfemH704ToATyLrey9yhcu1Mf/bhenGu+UIWXqJA?=
 =?us-ascii?Q?3FJwPuMBvWErr6fH7AbWM+DK7pkLWlU5jDyUxZfIWni1qlAvErlwjtyApIzv?=
 =?us-ascii?Q?u12IIq892wI7QoyPbvVO1lw9YUmj8PpG1xwZbM0oTUHV9VXRpoQhjrj8Kgqd?=
 =?us-ascii?Q?psC9QI1tGy+932WMgcOInKlJ7ZfWXK+zPIbNOmOaIhiRfgZoMIZnbJkuh2Fd?=
 =?us-ascii?Q?DkhQwkuVYiNQMhsOJfnS17CnpKBT2le+OjYdaTNWGvETVFJjCVKMuZpj/jgc?=
 =?us-ascii?Q?4JWpQUUvOLMorPVJypvYKAhVbig1R/p1QQrw/ms8v0AVXPH+ARV+B79cHGz3?=
 =?us-ascii?Q?qthQum0eUanTGuLuHjDR82DaDRNc+GefuAnlMbWtLdyEm8V0ROZp393a9YsI?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vJaWZIviIJrywKq4/J5wncVa65vi9ObduaXF2BrPj0OCSX6EbLgg0pTJ7N4N?=
 =?us-ascii?Q?DTwGhZkdTYzOEPjpfKsXnQ8Q+ishZDc9KD6prS6Sqm8e0pEQvVKlp3EEr3DM?=
 =?us-ascii?Q?lt3ttZ0y2TN+XjJB+vrbyjRI6/eLRMKocslFldejet1im7o+fD66xtf++DlJ?=
 =?us-ascii?Q?Wn9C7TZ/y2jPpWuwno+xsPxXqkYuvqWH2Qtr20pfoeaoWm7dw1F9bNZtGxsb?=
 =?us-ascii?Q?8b7bvq5IkWzSbDwG8fuWHczAxr2Ihoj985HKEzRaU9lFveD+uGTa0XJT4ef6?=
 =?us-ascii?Q?vcP2vIwImWjzVP95npVR8sIbnQZvnSxOPoseaLiSqheo95Fkx0kQBVO/lxbe?=
 =?us-ascii?Q?km0jsufq8H/2QC5qmtwUh47VE6f9VOdalEecVtiCeSBL8dDhuJtPRIHfus/v?=
 =?us-ascii?Q?wvRMl0PLLgdkXXgUzEXOY90d2cFj5HG5KKBpxtD8WUlSTV90mQu6pouV/WxB?=
 =?us-ascii?Q?X4bX9Kr/H848rR8Xq1vadzRErpKlfhD9rPmH/Vu5csOAO6Hq9dMleTowobwl?=
 =?us-ascii?Q?6P89780zeLLZ69ryV3adHF431btwMQ6IiPjFrOhUv3iYyDLJYdht2Nzwf7c4?=
 =?us-ascii?Q?idR7TXj0LGXXoldTaS2QPdEotyaZTEKgXI8qpxcUUf+d3iVEBUtzlZY11x63?=
 =?us-ascii?Q?SP8RGgBTOAcqti3doU9LItG7QBO1ORKL7yKDnId8FZbzbmZMhXWEj/yPUIsX?=
 =?us-ascii?Q?ZXVL/Jsq+RJiqXW6abkb4TpiuUpZ1JEbUykBAIDxTZ/UIacICCh8nw+OVaVO?=
 =?us-ascii?Q?QW0ec2bPPSndcShHwTpiKR/G+AtB9WP+yk5KV6lMGk37uv7goPAXRiYA0aHE?=
 =?us-ascii?Q?sxq1LfAgHXDvg6ULAK2gmElSL9gWtVeCrgIHbbrXYxgHTnSwRaZtM5ei/lrw?=
 =?us-ascii?Q?aRl5+puJqzBfcfiULkF0FT/iqAlUfUm9JhFvrbCRqU7kPNukpapXADIj40eX?=
 =?us-ascii?Q?c8axp7AEtHrpgApSc4hG+XQD/rpGfWPvXfpyeEqKiOUe/dwtHVGl/f93lef2?=
 =?us-ascii?Q?xbpQa19H+55zOG73Q26xnRd0hbxeWSJgsk+0kWBzyIqDJwz+z7z9QHl60BL/?=
 =?us-ascii?Q?YwRaoaRnejjBzil2nziANL9jEWFLpg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b115a6-89ad-4d4b-76af-08db453be3d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 03:19:33.2548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5kpG/fQT0WZRPs2EjmuV1EH4TGVE94HBLzP0q4p7y49Ymn5Qz7h2Phk1Sp4RAmchPrfvJhE4yjt34PV4Hr8XbSE9PT4UspKjLvL9GUTrDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_02,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=820 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250029
X-Proofpoint-GUID: FUEP8o1L44yFuHFJD3uVzVs2ATg7eVPf
X-Proofpoint-ORIG-GUID: FUEP8o1L44yFuHFJD3uVzVs2ATg7eVPf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice,

> When ufshcd_err_handler() is executed, CQ event interrupt can enter
> waiting for the same lock. It could happened in upstream code path
> ufshcd_handle_mcq_cq_events() and also in ufs_mtk_mcq_intr(). This
> warning message will be generated when &hwq->cq_lock is used in IRQ
> context with IRQ enabled. Use ufshcd_mcq_poll_cqe_lock() with
> spin_lock_irqsave instead of spin_lock to resolve the deadlock issue.

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
