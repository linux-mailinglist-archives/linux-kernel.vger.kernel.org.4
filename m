Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D508A72A36E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjFITut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjFITuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:50:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E353AAA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 12:50:30 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359IBZNN013302;
        Fri, 9 Jun 2023 19:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=+VW3n/nXZxg1whEY9wfAZZjxf3DEoS4VsO9GtUMTfAo=;
 b=ZCAy2zsfTMWEhTyHinqj4DWXD0+msCU+VVHNVVkdCqA1uLORApXy/j1L5KluNrTH0jQI
 lP3lTF5VS/JoKIb3E8XOHpfYpxVnUVgi/EIdF9yvZBh5o4FcIEhKDfu1OyX0XXz7W4oR
 qPRP7b79qMwIsqEAWzvXWl/KZzoKjZFvDZg1dA39XJ6efGTDXbRcAkCWujCnAwyBcorp
 35zaWJfMj4ELTWdGuZag/k8fzE7QZrs19WZzeHfSTEqhUhoPc9E8730Bx08ZChiGiX/N
 5qqbOJwdaBdSak/jqZt7x3YbHeDu5e23vCeTX9XUiyg6Gw7LDLIsw/8scMraR5shQGIX Ng== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6sqkv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jun 2023 19:50:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 359Jde6m036863;
        Fri, 9 Jun 2023 19:50:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6ntkp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jun 2023 19:50:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMpiR+I1qTe8Xc34xcBsMg9tDLoBAY0BnsWp/wkxnAlgX39FxEqdBlDlwvsZxyu2LLPGcJY8aRbkCMukJl7BxPNvkgCw6BrUIBkUT9gRXC1NAtBB9njpgasO3f6BKzdX/n940s1/tMgBC1/XjnItIAGfxWUVjE4VW1u/QJ2Bq/9Ozml+FXVb42s/UVFvyGYSKJ+ghcQxW/j383EAua2LmRcqHZvfe5Rmbg0yoHEHz2ynvPueoI/KrAtFTp/UkZp7CORRosx7B6VIwS2txupV8vpa00t0jAJCu1AGx4T5S1OUrHjMAhSiGpUBCyqgYX6Xv9mHlkZOqKeLIH7vRQuFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VW3n/nXZxg1whEY9wfAZZjxf3DEoS4VsO9GtUMTfAo=;
 b=GpajcO7E32Li5u9Ah0Vsph4BESTOqQRaNuFeKCBd5l9/XUZI6h9e0W4LysY9syK1LHqOlI2BMqam+IYe0BWcR6tH73OPZJjEJvrWtVUES/VLvQSUO7RRJLE6NEXhEcNaxjWik04Xu5txG+smVk1LEByojb2WixAWHbdZR4vLfIEnx2DisrSYA8sonFXc99ELSjRceSEx87lTe13xXaCmfWAMyPntO86gnFFcjazxSEMGZlkxdYXEmlswSWWKz+3KQggITGzi2qIdGEiRI6Fxzh+oBc7NP5ecXk1nf07DTISdks4N1+Q+qqhBjvNhejnu/rQ6wxbcw3Yl6xJAFDQqtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VW3n/nXZxg1whEY9wfAZZjxf3DEoS4VsO9GtUMTfAo=;
 b=guDH5KBYVEauHsr1OgrD1SlV3JDS3AcXLplLBiKR3oh4KZwxywxGOAXdSzwD5sLPI50Erv8e6Vqray2848J2ChwYYAHRGt44o/s4uqth6WwCsqa/EoVO4XxeYZHi4FQeOo+ZwfNJ3ITnhbOXBuWL63YyqTK6L+B1oHX57A4pImo=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Fri, 9 Jun
 2023 19:49:57 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%4]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 19:49:57 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, david@redhat.com,
        nphamcs@gmail.com, jthoughton@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 2/2] mm/hugetlb: add wrapper functions for interactions with page cache
Date:   Fri,  9 Jun 2023 12:49:47 -0700
Message-Id: <20230609194947.37196-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609194947.37196-1-sidhartha.kumar@oracle.com>
References: <20230609194947.37196-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0050.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::25) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH0PR10MB4664:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a85cd8c-d8a7-429b-e72d-08db6922b3fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zikLGqoLQ86dtfDps/8D9lPvEkI9F7jviXAda2SwHrbVCMpvH7yBJKR4iE3yyT/+smSEGZ4liHpyaWPYvGQWwdH2jW3I7ZSa25jg0XfHfLBIm+Z4hMdQsoXg+8KIRbANPMVL34oLBfsLxlDASO4/YohXe+DxlwcEBEQ9apOg/lD90pcONK7zmV3ZO2qPlXcM4iywEmnbutFzHppiehtBG9gMEfdJZtrZQCIgHMX93EesCcXAKXUPszPMz2oOcmHftrFiRb027PAMjJ+fHex8h0R/3x3ohw3qvzqQawa4kX1f1warOBR3jStuifk6iCk2Q6VXpW5KmpIElv7+P8RBhdNtsoL+UkI0XTXFEYCcNnkUyIgowIrurG6agqCXClk1AiwRyBSsSj8PBpbzGmTaGs6RRjbJJKq8/Vwe0TUysoXWvaLQ2UQ/8pfn5V7fdHxYkqN2ZdhOfHN1/OhufF1plnleHoPlZhHxy+WsEWKvcaqRLO2Gmi4QdLFDpjabXonkrgwAZw2rqabBwtuj84IPTbOQ2wG8Bji8qxkedO5+5uQsTiZcigvFwEDWIIblP0Bt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199021)(66899021)(38100700002)(2906002)(2616005)(83380400001)(36756003)(86362001)(107886003)(6486002)(6666004)(478600001)(1076003)(4326008)(316002)(44832011)(6506007)(66476007)(66946007)(41300700001)(8676002)(8936002)(186003)(5660300002)(66556008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LvO/sEkUHWKTzNzFYznIzwhRA5m6U3byKCtsVzffb9Cj+tKWAXmlRaksYihx?=
 =?us-ascii?Q?2rJsnpvnGwdZu5UhStx3Vkvzmau9aikWu1BCa9DLbf8v3BokQjUXrfhGhAVE?=
 =?us-ascii?Q?tWyfnEB7HT60d5NRGOHfpLlNziGv48iPz+PP0KrecIz3Mg0ikeX2GSanyc7G?=
 =?us-ascii?Q?nmD6z1K1vdFkXGkuFeSv3asZ6PYyQjdjMJ9lYLMGeiFVNbElGgYFGa4BJRFw?=
 =?us-ascii?Q?WI2cCL4SJmtvJwXIESL2GpUlFyKbdR6Dgwi2WsvCMRikbgy3sZgpL1gIppUL?=
 =?us-ascii?Q?Ah9nesrN/+W7/fi5VzFJm1HTm1IyJvJW1DID/h7J83wuMQ1E85J7BdDIGP0p?=
 =?us-ascii?Q?TDoN81dxv66t+PNplKoVMNO6gwTLUhuhqtZgrSn0/lQwdkJzz872OMZ/gweh?=
 =?us-ascii?Q?Fizk/FuCkdGAxsIw9MAwjF62b4CePtezk9isxLPG3TMzuwIqzV9O8q2l/gbK?=
 =?us-ascii?Q?yXS0tHrei7dgm+WeY+W44l83klhhHvbQ73UTAuH0FeKBZbcwgOQuabIAON4H?=
 =?us-ascii?Q?0k8N3bQ2zuWW2RkH5sJSx+Jxo+/VZCNuFi+EEnsXNXqSgwfHN73RVBXUGf/q?=
 =?us-ascii?Q?2UP+Mwyz3cosQassYl8WUgSOOP0MdPP1Tprk4xTbaHqnCAuEmkDpZ5AUoh8o?=
 =?us-ascii?Q?fi/JnVXxkYwC+gJZ24Xy1CLanEwJ98fq5pxoA6ksBv8oMVNLt9fJDo1IT7jz?=
 =?us-ascii?Q?oVujWLWGflV5V6hm8+pHT10flv5iIyMcUwEvThUv4AfSV0df1cojy+OAV/74?=
 =?us-ascii?Q?TcMLFGZRGeR2kNQU2CuL2XPqdFqTQ+gJLCQ4OA44Z8tcj3EaG3oJCfToUeK9?=
 =?us-ascii?Q?dpSBGwpiZ+OEWcaFuNhnq8r3pNActSNwG7xjRqIAeZUoQ1QB7pgikIGsA4bJ?=
 =?us-ascii?Q?T1y6onP9Mp2OJlB91Ov659/WFnIfIzrpLGnra5WJKyU9/yMdTrkTiUAbSylc?=
 =?us-ascii?Q?6dpKRDcot582AfZIl4a+9ns5CAarhUfHQSIC6s/l11Sh6Rwkeosqx7HSr2Gy?=
 =?us-ascii?Q?cvzRqx/yQXKONgH09Rz8x68ZqxcLFc2U82OFsf9P35G8y/upxfVlAkyJ8nGO?=
 =?us-ascii?Q?6MHMtL7XW0HOkTKL5w39lv/ud4nIdmh86ct8MD4KonPY9VFmtdjMOBVdog0t?=
 =?us-ascii?Q?7iXw0iwhicic7RUaqCHe8a9S+50cqeH2+MJasBMvtelxu2Fuac6RuzmwGmjG?=
 =?us-ascii?Q?sRcCVab0FMqPe9M1rZSMqWU+NCto/XaSNWf2d5G9EN9S8FHT2AmbriNrxYrB?=
 =?us-ascii?Q?10evqIbVXn5S3treABwIphIjDHshJCw29e6Ww37HaNgRixfUUoSUBZIgnydB?=
 =?us-ascii?Q?WWA+SumNckdG8g8gPxiFW/rWyMDVpXqEUITqaHFMJH7cuRpECuZ7mf2yHGM5?=
 =?us-ascii?Q?KZzyfEEcwEPIV3wGi5l6pT1eon6GyPqaUYlgM2z2MnndRsD2xos+O/vlZxBa?=
 =?us-ascii?Q?ikaPO5c4iRAd3mGhnRhI4Q17/yA7TnBdiV2tlACJ9HtoAmtIecPxBRgeDfjU?=
 =?us-ascii?Q?V2du7P2hmAtQYYbAjveZ4oiTIZzl8z/xK6LKh8AtTvLoUeZa0FbeSM4dWPeZ?=
 =?us-ascii?Q?hOyb7WrxTQ5BSkDdh1xlj8ntThhJ5iDgfAlG8XROcNHzwil9NSs5ANn+grym?=
 =?us-ascii?Q?PPDwj5RNgtSYTMZvTDpeLzs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PwElys2aGcY4j1C9PuI6fsgjLSVXqkWDWn3Z2Awlr4740uXKQFxRbOFGoCJZ?=
 =?us-ascii?Q?XskNgtKDNKxtVUFmF6k/AlLbIWt7lRsLRjVHwcaXr8aV+AA0bjkg0m7w1rgt?=
 =?us-ascii?Q?ORT1G+8lU896VGrkv2Cs/QRHDu/cEcYdrEqTKOnaNTvFRPSOu+21Pfag+JGZ?=
 =?us-ascii?Q?Ywc7JogcA6W9neYjUbA28KiDL4+Jv+AGFo5AD2XdJqP8coYDXE690j8Iu1Bb?=
 =?us-ascii?Q?CRcOQZEFj/kONTNqjp2e4xKOUdZlJZ5C7zf5T3BvIHQkaCVo/aStSx2Cxu4b?=
 =?us-ascii?Q?+f2wbB6yksil8mGZulB98aBXzk4KMGJOXismBmRfamrNx3yvhff22rchxVyn?=
 =?us-ascii?Q?oOmPpPCHSLBX2fg9GA/Lr+9J/NJkqRNDAWn6SS0BmAqxxgUoz+1Fes8e7jih?=
 =?us-ascii?Q?pnmwosZsgBYsXMcxxpeMqrhH8Hx2sjL7GMGUDIn3SJ8SfVUG9CeKm8ntkYLA?=
 =?us-ascii?Q?nCS07uTQ/IrXy6vGjupHA0/fQ4jhmUkEW6wmEXrvMg7fcunJnAM34OW2rp7f?=
 =?us-ascii?Q?qiwdsB+yxIb6qx/5s9glzq9iCl9seKNCo+mPOGcHV/Xy5RKof+qQ9n6YBaru?=
 =?us-ascii?Q?pWd0bPXVux0JrFjwmAZoGDDtkSef5E0++k6NRXomAHtrbJe5nV58W6AmEIj5?=
 =?us-ascii?Q?KnJVMyy1cDV0ymAq/Zqnn6KHMFUmmFD3euRMmNM/6/Qwa+3NOA7bH+ool1KF?=
 =?us-ascii?Q?vglRoHasoSAWB9WdkNesNPJJliyoFXaTnvYgU8qSVTt+VGkyPDEiwtAlDREX?=
 =?us-ascii?Q?VcBG8UmfnwCijucpfgXWoMwvJCSuS6UzLZnJSURLxGqfVQZpa/Da2+xiQQkx?=
 =?us-ascii?Q?0yRFVXCYR3P2/9qQLPP4xhZVHTvkFPbbu8dgbDW6+Q9LCUqt/mHcSsHo/Ls0?=
 =?us-ascii?Q?UojSr+90aLJ2O0GR5tVlpiDGguCAY4X5xJ+RYAtLERvrNFVYraD8gAnQTqe/?=
 =?us-ascii?Q?wrpSMYfWN0Ow0TFWQtf6pCLAkC2tOVOhfI8ac5gjREjCZjpd0iHuMkbQDVB0?=
 =?us-ascii?Q?0Lja?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a85cd8c-d8a7-429b-e72d-08db6922b3fa
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 19:49:57.4068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRyzmmcsj4g6CABjcsriLJdDgnMVmnsxg3XzzNU2yP6W1m48Jui4ZRBxjHGvM3Ifh+tVdKAdA3Hd0dpvqhu4frKRObf3WsFOEWIvy4tgEKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4664
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_14,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306090166
X-Proofpoint-GUID: tWI-TjcF9Ds9rt6x360ncLhQRttwLJW3
X-Proofpoint-ORIG-GUID: tWI-TjcF9Ds9rt6x360ncLhQRttwLJW3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 fs/hugetlbfs/inode.c    | 14 +++++++-------
 include/linux/hugetlb.h | 21 +++++++++++++++++++--
 include/linux/pagemap.h |  2 --
 mm/hugetlb.c            | 22 +++++++++++++---------
 4 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 90361a922cec7..90d27a8af4b6a 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -617,20 +617,19 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 	struct hstate *h = hstate_inode(inode);
 	struct address_space *mapping = &inode->i_data;
 	const pgoff_t start = lstart >> huge_page_shift(h);
-	const pgoff_t end = lend >> huge_page_shift(h);
 	struct folio_batch fbatch;
 	pgoff_t next, index;
 	int i, freed = 0;
 	bool truncate_op = (lend == LLONG_MAX);
 
 	folio_batch_init(&fbatch);
-	next = start;
-	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
+	next = lstart;
+	while (filemap_get_folios(mapping, &next, lend - 1, &fbatch)) {
 		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
 			struct folio *folio = fbatch.folios[i];
 			u32 hash = 0;
 
-			index = folio->index;
+			index = (folio->index) >> huge_page_shift(h);
 			hash = hugetlb_fault_mutex_hash(mapping, index);
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -693,10 +692,11 @@ static void hugetlbfs_zero_partial_page(struct hstate *h,
 					loff_t start,
 					loff_t end)
 {
-	pgoff_t idx = start >> huge_page_shift(h);
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma = find_vma(mm, start);
 	struct folio *folio;
 
-	folio = filemap_lock_folio(mapping, idx);
+	folio = filemap_lock_hugetlb_folio(vma, start);
 	if (IS_ERR(folio))
 		return;
 
@@ -868,7 +868,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		}
 		clear_huge_page(&folio->page, addr, pages_per_huge_page(h));
 		__folio_mark_uptodate(folio);
-		error = hugetlb_add_to_page_cache(folio, mapping, index);
+		error = hugetlb_add_to_page_cache(folio, &pseudo_vma, mapping, addr);
 		if (unlikely(error)) {
 			restore_reserve_on_error(h, &pseudo_vma, addr, folio);
 			folio_put(folio);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 21f942025fecd..55f90e051b7a2 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -727,8 +727,8 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask);
 struct folio *alloc_hugetlb_folio_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
-int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
-			pgoff_t idx);
+int hugetlb_add_to_page_cache(struct folio *folio, struct vm_area_struct *vma,
+				struct address_space *mapping, unsigned long address);
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address, struct folio *folio);
 
@@ -755,6 +755,16 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
 	return folio->_hugetlb_subpool;
 }
 
+/* Wrapper function for __filemap_get_folio*/
+static inline struct folio *filemap_lock_hugetlb_folio(struct vm_area_struct *vma,
+						unsigned long address)
+{
+	struct address_space *mapping = vma->vm_file->f_mapping;
+
+	pgoff_t idx = linear_page_index(vma, address);
+	return __filemap_get_folio(mapping, idx, FGP_LOCK, 0);
+}
+
 static inline void hugetlb_set_folio_subpool(struct folio *folio,
 					struct hugepage_subpool *subpool)
 {
@@ -1021,6 +1031,13 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
 	return NULL;
 }
 
+/* Wrapper function for __filemap_get_folio*/
+static inline struct folio *filemap_lock_hugetlb_folio(struct vm_area_struct *vma,
+						unsigned long address)
+{
+	return NULL;
+}
+
 static inline int isolate_or_dissolve_huge_page(struct page *page,
 						struct list_head *list)
 {
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 17c414fc2136e..ae8f36966d7b3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -860,8 +860,6 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
 					unsigned long address)
 {
 	pgoff_t pgoff;
-	if (unlikely(is_vm_hugetlb_page(vma)))
-		return linear_hugepage_index(vma, address);
 	pgoff = (address - vma->vm_start) >> PAGE_SHIFT;
 	pgoff += vma->vm_pgoff;
 	return pgoff;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dfa412d8cb300..824d6d215a161 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -951,7 +951,7 @@ static long region_count(struct resv_map *resv, long f, long t)
 
 /*
  * Convert the address within this vma to the page offset within
- * the mapping, in pagecache page units; huge pages here.
+ * the mapping, in huge page units here.
  */
 static pgoff_t vma_hugecache_offset(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address)
@@ -5730,7 +5730,7 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address)
 {
 	struct address_space *mapping = vma->vm_file->f_mapping;
-	pgoff_t idx = vma_hugecache_offset(h, vma, address);
+	pgoff_t idx = linear_page_index(vma, address);
 	bool present;
 
 	rcu_read_lock();
@@ -5740,13 +5740,16 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 	return present;
 }
 
-int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
-			   pgoff_t idx)
+int hugetlb_add_to_page_cache(struct folio *folio,
+			struct vm_area_struct *vma,
+			struct address_space *mapping,
+			unsigned long address)
 {
 	struct inode *inode = mapping->host;
 	struct hstate *h = hstate_inode(inode);
 	int err;
 
+	pgoff_t idx = linear_page_index(vma, address);
 	__folio_set_locked(folio);
 	err = __filemap_add_folio(mapping, folio, idx, GFP_KERNEL, NULL);
 
@@ -5854,7 +5857,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * before we get page_table_lock.
 	 */
 	new_folio = false;
-	folio = filemap_lock_folio(mapping, idx);
+
+	folio = filemap_lock_hugetlb_folio(vma, address);
 	if (IS_ERR(folio)) {
 		size = i_size_read(mapping->host) >> huge_page_shift(h);
 		if (idx >= size)
@@ -5913,7 +5917,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		new_folio = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
-			int err = hugetlb_add_to_page_cache(folio, mapping, idx);
+			int err = hugetlb_add_to_page_cache(folio, vma, mapping, address);
 			if (err) {
 				/*
 				 * err can't be -EEXIST which implies someone
@@ -6145,7 +6149,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Just decrements count, does not deallocate */
 		vma_end_reservation(h, vma, haddr);
 
-		pagecache_folio = filemap_lock_folio(mapping, idx);
+		pagecache_folio = filemap_lock_hugetlb_folio(vma, address);
 		if (IS_ERR(pagecache_folio))
 			pagecache_folio = NULL;
 	}
@@ -6258,7 +6262,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 
 	if (is_continue) {
 		ret = -EFAULT;
-		folio = filemap_lock_folio(mapping, idx);
+		folio = filemap_lock_hugetlb_folio(dst_vma, dst_addr);
 		if (IS_ERR(folio))
 			goto out;
 		folio_in_pagecache = true;
@@ -6350,7 +6354,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 		 * hugetlb_fault_mutex_table that here must be hold by
 		 * the caller.
 		 */
-		ret = hugetlb_add_to_page_cache(folio, mapping, idx);
+		ret = hugetlb_add_to_page_cache(folio, dst_vma, mapping, dst_addr);
 		if (ret)
 			goto out_release_nounlock;
 		folio_in_pagecache = true;
-- 
2.40.1

