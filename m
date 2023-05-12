Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A30700EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238732AbjELSYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbjELSXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:23:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609B810A3D
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:23:05 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4RZE028665;
        Fri, 12 May 2023 18:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=MMuXGwzfr8FrXvMOM1JZ8fiBmFIW5agQMabZbUAl1DY=;
 b=ziyggmw3Du2LRW8SFWVS8w8EtxGmcthOac+xzdzPrCbs5TwlEDUbmz3Shoo4TKdYqCdR
 3S9aiBkn6dvqs5VRa9279Y7awwGr3qLiknCHuUIb08b/CDx49FXy4nwmr42kqEnjIrBx
 wi2WnfpXGY4KGFDY+2l5bOz01Wv8tEH2DaTcLPcBmT02r2G6JzZdXMaxG1zWkNDvVEeD
 hBAoCG05leLUMJSdrDkt1nFodUYmOjwhxloU2zynPY3vyXGUC0yJy3pkCSwc1XhgUAmp
 zLJ7pvCPaddz/TqJ/MboklPE6ZI++loKEyi9DSPnVM7sguGgqD8m9cAfe1hlZCTTLTqd Pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77dknn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CH5USE018337;
        Fri, 12 May 2023 18:21:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77mjm1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8rmM28DIOixAHMMLBN+wWGDMsduPd4pZFT8Q3oHWPz0AMQte0jsnvhbl7akL/J+KLvYS/6s/1tWuh7hywtsQ0iDIUfxtOWkq5U2J+lnQVsSNN6cEeoK+Q+OZP7bpvLAlAvc3vGKnad2PEgTRVVJiuj1bijg2jXQMQVRjPRjx7zboS8iJTo+5IWqG0pYIwQ4km8msuYV8MSeJuGGcbiqmwqXrTwQemRf6ENKEz2xvPjHMah/vUxQHmictSEz90gEPHwQUcnucO8o6OPkyo6d3sBxsxUmzbwKU1HXcabOKrQxucpjVKKPFjRlKxng9c4ZF6r7vkpJzbdcr4jI7PizqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMuXGwzfr8FrXvMOM1JZ8fiBmFIW5agQMabZbUAl1DY=;
 b=YktJA0pGC//YaHq9zxuMI1DNlkW+dU2f3EdLhGRpDuDZakJ0ilwu3/LyrD72aEaLFpcjvOQIG6cVHBvTp85004S9CXwsD4vUaazLNM2WqS/Yrip2ot0Dmw1veLlh8ykAoapAii4cQsuQ5z2UKS+WHve8TDs8I9tcB0qSv6BzdiMs2Cy2eKvSA98iROnj/vkWD0T3S6gAoC907KjVnvTgdydLFnZvWy9Ta2f5R926YuwtzMjgrWAuFh8mkMWQkZSoeV6JsUtoVz1XDy7RCSfoN+M+HtaIzoq4LAOIW+nX4w2I68ygAAEJlt0R+j8WQRePCEB63cV2L9xN/d7lRirJlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMuXGwzfr8FrXvMOM1JZ8fiBmFIW5agQMabZbUAl1DY=;
 b=MqnSuqfsx8iSZCv8zATq0YDjB+jnLJ4D4ctVKotTCQmIJQydrQNt1cmw6WItpQpmhpN7JKBzMB71u0iwdUHMOqwIQq23lz48IP8rgoV8a384iWm07Ju1FMkjUGTBIWHprsiCjm7nFKD+41QN/bJ+X46FJfpqd++3NNv8FVpmDmg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 18:21:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:46 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 22/35] mm/mmap: Change do_vmi_align_munmap() for maple tree iterator changes
Date:   Fri, 12 May 2023 14:20:23 -0400
Message-Id: <20230512182036.359030-23-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0074.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::7) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: f425f977-84f7-4569-b0c1-08db5315bef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uiDGoZhcdaf5GMhQE5WxtZOpNnb5MzKd9p1KhtWpNrQY/NUtxpe8hzGWVHmiWRsNAnnUWidDr9Kd5XNChYJasDNwHAeQgqaUPZ7t1rxnfW87F+MzEf3fOvLuVN2Ve4qN9JR9RM1TwPLBhRrd1CV7NpCh5xroAUFWatkzoacnXQJ8jKEKw8w6oVKkuYDr/OG4IdqUUIy+MuK6NGQsgcxDQ23K5xXjfBpHozYHjukOnySECOdpymxmw44cEFxJr0xVCB7jhTXJ7kja+rUdGeQvN4jvW1f+dVI+CRzXhCZ6IMEo7DlvYmkj4RPSL+b6HTedHNQb3dW/8msxRTNhc+WnvoLkPH1p5W8lYjv1AzULyc5NmPr5m3u18KCx4yPuIF7XIgurMhfE4XgqTSOdgj/Wh4eC1wRseEmBCc+iapsg6F4os4mFc1eKUTOxR72AEA30Ept3ZLBHvjyEEHfFBlyAockvdJ1FLV1ofxofaXw7F4da+eZb/z+xF6btImS6tIltN6WeaNHlX8D1IhkqnFKuuI1bwgxhiij94zTJcBRXVAHWaTbOdv6PomNFfnGoep7j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(2616005)(8936002)(8676002)(6506007)(38100700002)(26005)(6512007)(478600001)(1076003)(36756003)(186003)(4326008)(2906002)(66556008)(66476007)(4744005)(6916009)(66946007)(83380400001)(5660300002)(6486002)(316002)(107886003)(6666004)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZuxeGDFt4oDsdlK8xKhDHpOD5mk1ZdE0tYsC6Z6oHag0bNqDqfebnT/LwDWv?=
 =?us-ascii?Q?NLwh1gOIloagxB+7+WrnFnUfrTSdiKDgo4hnVIPRwG9EDbYDMWHAKGxo3QWZ?=
 =?us-ascii?Q?Ra1HGRX3z5tGiKNtwbNIpn1+KWdmqC5pjEZHJaNf/efVLj/JE6cFQkIJKrad?=
 =?us-ascii?Q?AoGoprwS47Ny/pRAr8NEaQ6nAif9TGYs5/Xdi9IKGdxZVkH3FpUx4zfCSvpF?=
 =?us-ascii?Q?5Q8s6vTcxI0gfpqtVQTeis022AC8BDwQVNUm6b/vAjz9oD8aS7dAe3dFtoau?=
 =?us-ascii?Q?Ft7F5uNH0U9KpzGTvxoYLuuc3PhStOHB6jv11s53/lXGUrX5WydMrLlD7l6h?=
 =?us-ascii?Q?FGzMjBeG2H9+l0/mWEbxPqEQpKtAzQzlTvP31JhuzEyg5002TGTqxBNKTKHx?=
 =?us-ascii?Q?r6+lA1Ym/wcqiJLUqRQC0h+bDDcmNo+T1aa06a69shq5x7GDxzy/rebkGeO7?=
 =?us-ascii?Q?/us20be6FpJXj4Xa9nxYVXXNAbj+MQ7Zxf/keVvwaFEtGxuANQ9h+ptiH8W+?=
 =?us-ascii?Q?I7GWHvbt48FIZTqT4sGOFCTbJHy4YBv5Z1gia94jELJAPHHQ5XvC6OHdas0F?=
 =?us-ascii?Q?NTNYcmQai0+vqYxiwwykfmAhKSCHU0KD7yvbQTnbni9/42E+WIeqlfqWVkGU?=
 =?us-ascii?Q?FegtMhRuujsG8R69uwJZ0R3VwxE2macFSeJQoGgE1nIpmui716T7CgbHtEFJ?=
 =?us-ascii?Q?98W5fU8D7ndtPbHPDQSWurSU7V5Y89+XGaT392jVYBca9uuhDFCMugsLoq/R?=
 =?us-ascii?Q?2H9mfo+3Eka7EWu4WJvN+tqIfYI9DEapsyXK4h+vNG573DwKSn76R4gPzDGo?=
 =?us-ascii?Q?1muiI807ORDwjHnIdIoNTlGfEm2pFUuy0YHxe1zmGFXoslFr9mNrSsBDQ2zJ?=
 =?us-ascii?Q?D8kPOC7dyACOv2L8pAKUnvzHc/Zw9r6UuDXId191yYH6J/Iyf8ya//bxHFog?=
 =?us-ascii?Q?dFT/wdVi2mTktzbBQdiqVH7QDgAc14mfz8dvs9iyAxzp00fpXEb/tuMuUVEF?=
 =?us-ascii?Q?5SxSfsTBmrXy7sGVooUiOhE8egSpwrL/qTm8enc1/MoY1BM256Hb3pIAGstu?=
 =?us-ascii?Q?ye/Gx8vpPC+2J45A280ChLFU6MXleO6FLE7jiIpEnvmXwRCcnuLFevP372Lk?=
 =?us-ascii?Q?O6z9B72MKncd8JSsmCRFFhaaSS54pEzw1xawrgjHrHtORGYAnfo2TS8UNW6c?=
 =?us-ascii?Q?dyiIaVnbTHQej3aGseumxAvaivgskjt5INemLFIqWVLHAFFgTh1OOvDnVUNh?=
 =?us-ascii?Q?ECRI87JpGz9++0HplivxCP7i0gixaJN8tH/9hk3jctdeRsnd1ZMEEuHqlPVs?=
 =?us-ascii?Q?Y6u54rVCtM2lQHdX5MMJ3SHVHZDsbrF+BZF2pqMK9nTNBRVhizhbJmKba6mS?=
 =?us-ascii?Q?KYffKTHopjpUP+8TWCy6a88nrLlxw2QplHh7j794MjuQA18a0Wos2JxXP1NC?=
 =?us-ascii?Q?4YdrVhUXFHoqn1+383/Iy5KM6g0BhmLa9QOkFWXWArLhBjtGJV0xYW9hB7lt?=
 =?us-ascii?Q?rxagYDRGb3oJA2ViO9zKSV8RHMNjkpwkdJei82GICjApaTn9syvZdNtbMnlm?=
 =?us-ascii?Q?bGPIMIIqNiG1tcXXsrV1D7CbAj4XZfhdUUWfN+lWGqoFoaNPg1kNNGGlcL/1?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X6c64Wf7iJ9ISWmyG1rqRE/3mbTNWt/FJZaygU6vsiP9oBN0HXwLKWntWMebjUMibxsAcWqG+0qhqo89kv6dx/+gFNxIdR9UvWUF4zW1IvvcOwUiAGMlNOyA2B5WYdZm5wsKybvvsA4R0yupmsuQ5hA2vQyGUWYY8T9fUQLLjEEwxmoXattiDeMsRaB2J6H/1i4FjuUkvmF58CFgsr9zYHzfewzXkdrkY7GdNb7CdktTKHBzbB+nA8Qc+WffqociVMVNnANGZgCFcwk/QWkFYQ9YskC2rWBkpu561ImUw35b1zGBlLAlgwK8W5Vi5YS5inpKj4CjXGPPQSj3XgtlxiJP7cncgansrEmCeIGlF4W4hu3++wvbYugTeME4XZch6WQTHI1eDYl6JUMOQl7NV8zhiaEZi5ejDtKB1wdU7DPaiyRqXq8uUKiWNgZ5TxaHFtrglRRzseYtHf97mcMMDT1N7xQNBAsE/GXwDQO5YOZBY+ixC+evCLFJ/z9cNyf9QXZO5Q7YXcrfo1tBbiF+3eC0Brp6ybFshe690kQL6uSW61/0WuVClOyxxbSVzvSs14VHlR+RzDI82L/RFL8lQKMuzNYVspmQOtBEHjsXAbZvhmBI4jDFhB1/ExiybKTjtBFpikAwfVEKZeAsjp60hculEP4mKM0MtFGBg+L315dwCzGXOXeIlUZ+X5SsPvbmUnbj0KfsLH9jnNjyuhhmpN1qXA8oCD5LUbNbY7P0mESHM7jOW5/lIrdFfBx0nDobm7Xj3Ohxf1fCYAE4o//vqXrscf3R90JLGpx0DPChEarda4zBGCiVz8M6nIxp1VpsdMitPLtbndtOwczb4rGGbkDd0yA55ddvoPmQQyeOopofMUNW2/gXtMsRJ1xN9J5Y/ECfc2eWJcZNW0HKr/6rvQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f425f977-84f7-4569-b0c1-08db5315bef7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:46.8884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eWTT8ICBa4rE35mi/tKv8sDzD/iAhuoeqK2jBDtUl/6rw2sDnERpZdWNS5U5LPd84DDJPsH6czaNuLvznDFPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-ORIG-GUID: Iw5rGL0JSCS5bbxnCrzjA4dMGBGe4pLC
X-Proofpoint-GUID: Iw5rGL0JSCS5bbxnCrzjA4dMGBGe4pLC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree iterator clean up is incompatible with the way
do_vmi_align_munmap() expects it to behave.  Update the expected
behaviour to map now since the change will work currently.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index bcebfd9266324..1602c854133a4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2418,7 +2418,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 #endif
 	}
 
-	next = vma_next(vmi);
+	if (vma_iter_end(vmi) > end)
+		next = vma_iter_load(vmi);
+
+	if (!next)
+		next = vma_next(vmi);
+
 	if (unlikely(uf)) {
 		/*
 		 * If userfaultfd_unmap_prep returns an error the vmas
-- 
2.39.2

