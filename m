Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A856708470
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjERO7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjERO63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:58:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E9D1718
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:58:05 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ICFdMs011817;
        Thu, 18 May 2023 14:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=o0r44DGQi8lK2mAF2MeGErME5jJFvB3OhAPffrijvsw=;
 b=lYOeeb9tDTjBgHu760IoeDoitHpUdCuD7LLlDQQ3Ik596W9oIwml1Uo4+egtXCguqkDg
 MZeI7wjRwWiE1SeeZ29uFHVntjvR2vjcXAG9pYgztEgffRAqheI/zMSDJvjjW2XHWk2e
 uC0r1BbIJ9Yl1HMrrb41t4LYkzb2SdRNt9gUsl6nCzjtbzpstfWCAa25epKaEqHWb8QJ
 wmecwGeXsuGEWDHZl+qqiR+ohdZvTTS9gALf7ht/7WAEo2O7TJbMyGpoPGUat0zXKdod
 /gxna+ss1svib4Llf6w1vDDGQ9/rN9iCv0UjhB3n1/8KOqNG/sPetP0bMO9KZSex2lIS Cw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qnkux8am4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IE58OA039952;
        Thu, 18 May 2023 14:56:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106mq77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMFVcldKu0no20qaOBhHqogU9oKB1+MqoJq7sSeAKJdJYvWCVsFBACDJxczQgOKPVaC0MBMss1o2D0x9hb132f1x06LTwiwYCby7+Y2xn49XpY/40PQaglNff9UaSEfmE9xNkpThyKjA75V4kYT7Wu9CIRZagCkRME2m/JM9OadDq5HdN0Y8eyyi76EXXHGPUSCJHWAiO930Zv2Sd2RL4Iz+FtorSwtFt2spOA71+Umhv9ANcJIQXAkGoYe1EX4I2unK5QvMQm4FLhS/8jPk4YQLZzAAeLocpSEiS9QrC6LXv/h1OJcVT6ewLIVMTvf2bjerjLB9ZCMWz90Y6xrotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0r44DGQi8lK2mAF2MeGErME5jJFvB3OhAPffrijvsw=;
 b=FLr3burNW0/jLUid9KA/IGZApPDOhT++qQytnjboiExsQF2ViZ1oNkKafsTRudO5+HwGcqlKDgMvIVMN6rXFtwFQL5oyZpYqG49QqzZgTc0NXkOuNB9h+iWwq9QB/X9rCQ6cj+GpXKWwIA5FwBV11lCKCBGY/omSAsJy7L6dzIIWcpe+RYTEDdMJqBctau3LyjhKHCsS3SqZwRvZH2OzJ27lCeBpT4thHuFVTHyAYoIb80RrTiODa8GyYtOImFAaRdjUMjaKdtdqTj+9f2rUnznIESK3Y2ItSFR7M/byTGhFJTmlnnTgRUXB1ji0Pk5YquY0wZ1z4BLd2egYWqU3wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0r44DGQi8lK2mAF2MeGErME5jJFvB3OhAPffrijvsw=;
 b=s/ySPeV+sbo4/piqxoX5wWOjISchDKODU0DFNs9jD35gQZiVSgeX8L0LbaAiHacRUR5D2GkVg8KfWIukNifzB/KljCq3yw4cAQTo2t3lDeJkDkub468ZmS4a1nsi5A4XMGquRr4FpQjOUVRw+eEL1g6vB508lBKYtHwE4CPCed8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:56:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:38 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 20/35] maple_tree: Remove unnecessary check from mas_destroy()
Date:   Thu, 18 May 2023 10:55:29 -0400
Message-Id: <20230518145544.1722059-21-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::32) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 875d706d-cf57-4bac-0bfe-08db57b01520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CbY39T8TPABngFOk3XXWn5+iR6zWcCcBKY7CrBNpW+phjZ2r5zHgJ2XSPylEf9OKCXI17slEOnjCPCP+SPQaH1x/fT3E6cOw3G3LXiUbanRlrMAJJxxZm7AzkrApeYZXT4pQsKi5hes6vO4nTyCqiy3Hsiu+OIHbgSA8MKK64PVl8LPNN5GhgAR3NDbRrFsBQNUPcNJ3n/WO505cvIUTmp85W52Ipr5uXhkgT82j5fG8FYMXGLiyE8ja1xJpRGQPuyyqybAvOfR/Wn6gWR3uj+AdHc7uBYutpEIu9tJ2nBToHsgLz/XnEpdkU6qrMdTd7pWwwjIm6djLYonUhXeYOwbIaYiCoBBjf/wlFZY+WJws9QlWx0r9VbdzHaJZUJRglcFpP/3Fj7yMDjhYzt3UYGfz83OgD5w5CLhSmunGiszb3cqZc0HxDQqPCULaVj/OURTVZP9hYBJq63kMTna8rTAt8Aky8OHVOUdcETrfTuEm8zX8vBFvl4pPinWgUnLws3Ueqy9B0FpYsxZeCWbgxaTnvPjEwtURyYD15DvCTrhp+Nk2tey9jZuMbnALvXEo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(8676002)(5660300002)(8936002)(4326008)(316002)(6512007)(1076003)(83380400001)(6506007)(26005)(86362001)(186003)(38100700002)(2616005)(41300700001)(478600001)(66476007)(6666004)(66946007)(66556008)(6916009)(6486002)(36756003)(54906003)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hGU/L9P0z/sLWHGZmdfo8bPOejmYmFheOhcboWPZGdaLeeIIsfzRLwQdLyPl?=
 =?us-ascii?Q?uCE4vlR0Ao2yrcHQD08aV2TdlxcK6U92L7v58weZqRoRVn2QnVQXxjIoP8x5?=
 =?us-ascii?Q?Z2SV7MqnW8apjiq24Db5V/EIjkyr+3CpmuHEXMim0MPmsb7wuujig7HHMFq9?=
 =?us-ascii?Q?Bk8TeuuayCHoLoDA2NhsECiv2AKLdb9GX4UT4JMitF4UwVTFAYEM01SrZwVw?=
 =?us-ascii?Q?Vn6+81+LELWO1J+sJJngpB/MPM02LmH0RZ8drNv1cnjl0HK0Fr575d9S86o1?=
 =?us-ascii?Q?NLc8jH8arriNFHxoCjQTiul6riBqAnPH9y6C+lPo3hFl1SjTxMkdn88/4iNa?=
 =?us-ascii?Q?rfiEjzulrua1lm7bxJljoKrMkO0ASwtrIoY6EoV0MTUdGL+JIVXhhktqSNRt?=
 =?us-ascii?Q?RmHeeRSdkH2bIZ1r1bx3nk+md/xS25E7FzSjPPCcvLr8zYPXrVNJmp2ysAiL?=
 =?us-ascii?Q?/wfJaII5Gi0Q16CLpVWsisB7ARoIfJb/boblcEpGAB3a65L4kKoziVZ9rZ0e?=
 =?us-ascii?Q?91763O3dsYSTfvzkd5nHLrTiVt9l+h9OU3oucQclbhL2Zh0ceZOuopOQyB/0?=
 =?us-ascii?Q?FbFUyL0r3atgsBN3D0KRwMXCFqKiXWltaaVMvRD8KHhxt0KyucrkoIzGFNbm?=
 =?us-ascii?Q?sFrJIyMTvuwX+UKL4upCOYphzQ1aHauQnOMo5FA87eQHVPnl77JoZNjfpqil?=
 =?us-ascii?Q?j2XDvkk/umM0Zc8gUQJmIQXdfiP19s3XTi+FQAcXJ8tmC1KegW7etdI9pi2A?=
 =?us-ascii?Q?+gbgFaXvmYEIkmBJk0ZagSA7LFAI9kVAXCgqs/j/zqTeO8HsY479mTEsWQ8b?=
 =?us-ascii?Q?pNMqSkg8Zd8uHwhcQeb5xBWk0AqM3SNuaQr6H2vqkP4TDDXksujIW97tUZe5?=
 =?us-ascii?Q?54Z3UXIz/w0uFihNEH7DVglD03AS7sPfhAx36ONi7JEoqkFj0J/Lo/abx/n/?=
 =?us-ascii?Q?GvM9ojtYXDvqWixpda+chy4FgiL6jBiQq3uRZ4UVqjzWjuAA0TheykpI4895?=
 =?us-ascii?Q?qZAKBeNP1H0N2QjPCDZ0nW28Rlses21qpO+lfon9f3rbmd3BQFDd8jDrmmXt?=
 =?us-ascii?Q?2k+O3tcK0CxiKevlB9bcV81jktK6iaTdNbeXvCAuQ6JryrNu21YPUb77IXPK?=
 =?us-ascii?Q?wRZF/cCYkR1QJ5Vh83cJE+izmuC6ed2b+jeMna06Gi2WjJ7wb0UbXXr353vu?=
 =?us-ascii?Q?S09erRG8SXxaOlA00IIUGSfCzeQQpmyWY/EBgb/7egsbreVMcJlW/lna0qVa?=
 =?us-ascii?Q?YtAjS5kcfo6xQLIZcPcxvjPH1cwNJAdpSf9kOHswBZESC+tBgjt1cGJScwj6?=
 =?us-ascii?Q?dmhg7J3mikJ6XJj08Jg9eWhTX6AV5COK3MkoyVxbkpZcFj2K3q/ViW6PpPVn?=
 =?us-ascii?Q?hXufiDCQ1uH8fQc/FsSiJvDxPf/cjWLp8rNcFzu0sy5P/1WOSSXNHjrupWWz?=
 =?us-ascii?Q?ztPB0NRfd7x6bGVjFFIPNaSgrYC1VPRqSu2NZfsJVMVx4rsvfq3hGzywdZNI?=
 =?us-ascii?Q?Mj3Jhzr+tUeBA/4sZywLxf6vAtJQDMCgajgDH1/eOtKcPFtZ6l4q0yCNzvks?=
 =?us-ascii?Q?52KEiWUQSJ/4DluYzt4kivEzoRnbmspW7ahcf80q39Ukhi5ruNvQrbKjkoW5?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?m+FBhrSDkU0sg0onRo7RwX0EAIC3kAa+EgOYyKZeA13eyoHEav/xwqkogp+M?=
 =?us-ascii?Q?24U/9gKtj1Q707/KwFju3P5vpLBqJ3Yg4JJUBTBCzzk72UxRhSiHiRIeWVg6?=
 =?us-ascii?Q?ayJCszqAwPfTXKi/itFOaDPu2CTlzZpwW1tGanSuS1R17kqwb0CQcL9ROHDY?=
 =?us-ascii?Q?w4VYO155CPymw7oK22cET2pdkGLhO71rjV7rL7/B7jkB/BOK7zeHNMyKyLBq?=
 =?us-ascii?Q?Dksu0dATH/0xFEzNxvKZHL/lR7ysKLfoJfbLCRQ2RrEqSySYSj4ETKIr54p2?=
 =?us-ascii?Q?GG2+rs3i9+iSO+NAje9KsCy04l1vJ010Qhbl28rBggpiYVhPVz3k+v3jMfKM?=
 =?us-ascii?Q?rE1yZONoXCY5grP9nSzzZzAYNImhHtFwrfzI+KVRUxgfnvO2W14gkHy0zXSB?=
 =?us-ascii?Q?mkeZe7IMdFd3bnPvE1Zo8HbCIXOuAUwUJ2RsF9FVUrEW//V8gPJrFZrk+vVN?=
 =?us-ascii?Q?pqnua3RaTHQ5q8l3qCjJB2FRZaXC/gPb0raa1FTkCDL1FrjLgDbfmeegn4/n?=
 =?us-ascii?Q?cM9lyPYu8xryUrKFYayLrNCAjPczoaWWxQen1iksyQFYy+2s5cssMCSHj4Od?=
 =?us-ascii?Q?gPVEjljw5tyPnKDQl1L5ggvjrRmocRYe/SS8wUb7h3mDrYbzY/n361CPHIEK?=
 =?us-ascii?Q?PJY9vPWx8U7L75/xmoIrsZDHuxVtU2KLs5yGki4G+arNCFv1mONB/1xIbWiT?=
 =?us-ascii?Q?vOAjsQ+Mf7gQ2VL8ItvCtkRVAGZ+/OrMuH1uTHKcDoIHPxSLffq1MFv/NPbT?=
 =?us-ascii?Q?zbzZMFLG6lKZqjo8FkgbRBXxmH7ubNSflG9eWMmQM0nhC1eZR1V3nNfui8jH?=
 =?us-ascii?Q?K+QvbRUwduqF0nOPdx2UGqHdTGLgbM48eADZw0z02EMYXOIAExSlSrmU3BDR?=
 =?us-ascii?Q?oY+akYNhwGw0eoso6CcZUNP372bENxyWBGZeRjq1c+rzsnLrm/fbf3obxuov?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875d706d-cf57-4bac-0bfe-08db57b01520
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:38.4459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOM15J2Z9KlDho56a5mUaTrloTOrE2kD1LvwSpL+Gk2ENQOK1icfazHNqlVdtLMh/K1FdJ1OBmNIynFCNLOvHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180120
X-Proofpoint-ORIG-GUID: 7G9eij61nVLHRGAzBCMMGRbFfqqx6-Gi
X-Proofpoint-GUID: 7G9eij61nVLHRGAzBCMMGRbFfqqx6-Gi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_destroy currently checks if mas->node is MAS_START prior to calling
mas_start(), but this is unnecessary as mas_start() will do nothing if
the node is anything but MAS_START.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 9f3784f4a5b7..b3e5ae43ff8f 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5816,9 +5816,7 @@ void mas_destroy(struct ma_state *mas)
 	if (mas->mas_flags & MA_STATE_REBALANCE) {
 		unsigned char end;
 
-		if (mas_is_start(mas))
-			mas_start(mas);
-
+		mas_start(mas);
 		mtree_range_walk(mas);
 		end = mas_data_end(mas) + 1;
 		if (end < mt_min_slot_count(mas->node) - 1)
-- 
2.39.2

