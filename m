Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAC170875C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjERRza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjERRz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:55:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B112C2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:55:27 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6IoDI006511;
        Thu, 18 May 2023 14:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=RveCcSvwg4Nj9ioOmIG0jRkv1pBMfvzYki92JJYfpt4=;
 b=dOUc4NJxGf4jRm8jkoC4t9FJ04fgyDLT8qz6hRSRwjCmlisM4ouXsc7xTweLJMvc8kkA
 ntqbZR7SsKVQ4zHi68je/B0A+YSwk7XHUUTNfkGTCsyIQf0pk3vYEnd4wdsjzu06S75F
 ZctWSG6C9pCgoQt1fN/gm+19DHPswj9T6IzFqh7VTHXl+hw3RBCjO0eqSHXCDGVvujHP
 A8s/LR6fb1i0x0D922NjlpQtkFvsuaO5heTuC3RxMCaiTQagH0zEShCFVnpSd55LaT8V
 u21L40odi/OmSBIolXM/3FuLJFjxLH4X6RJ+lnIQWDPheWKIGlwU4OA/RiH60mBzmCdg 9w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye82q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IE2jRu025047;
        Thu, 18 May 2023 14:56:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106vmg2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sk2+3Zfi1PE2JV4TTCdnXCPw1v33CCp8afYud5/ZtTVZY3rPVwZ1qccf/R4E+UzE0SHRlJaRoi3GN9en5Y+bZ7K58J6Mo2hsUKiMMhLGErUxGaZ1RsyePzN2UDJqYUuV6zvSMyJnjmyrqtSLDd7XGtoLem4x8tEGXSUmyF1AQMgFRfO6Z3xxwZMtQI6KpDyshybJawZQDr1Osd+D+9Q0dSckz+vhXwqmY8oVTvhU1jd4VIb0J7/6bIPIlLzzqruQcv9zGOsvz+GwxvbrV+dvNdkPgvuErMacXPmNKuQ/cJZ9sV3qic5iZkXRK6Xn6EsWcq3y4F32icDOUw3S9DHbTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RveCcSvwg4Nj9ioOmIG0jRkv1pBMfvzYki92JJYfpt4=;
 b=e5HFn4Ivjgbp9X47X9ogmqCbEzW31AjhBUgSXTaHO7YHVcmH10ZC3R/vRakYzrEbnOLO769XQb+lwbjGxtZRo0lpaUjJ5ePmwVBDKj5vUEGh1YS7cYKF61BMCIf3EYgIv4UvffZOF1usRTvidBsSjf8anBreIwfR0MM/T/GjXryp3Dy/8fG8Wv7KUazwLTWF21grdjtzAgpruNmbSc27WiAROBh7SPVckt0MnPGaAUiNDVGu885p2WQuUpC7+WXBFjgOxpoj0uI4arfaMAsL2jAEqGABhz99h7h9iW2RGLPoyNNF5vwPd1RJhxBxsJeOYLvzp1boIb1sZAkIPuY/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RveCcSvwg4Nj9ioOmIG0jRkv1pBMfvzYki92JJYfpt4=;
 b=QzSHztme4ajPtjSh00b+s6Pl5fBz72UvlFOUq92CP3VlMTy1CUjwLtxVtm39S/wVNowAbjWZGVzYG+mV1+Ujxc22jWdmvxSlC2FpVnDIP8GJmp8Hoe+sj5zg94vqFQl5VIdmRyUDetFxGEBTQUkEXv5gyl/IQIQCsNC7YJLBvYU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:56:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:32 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v4 18/35] mm: Update vma_iter_store() to use MAS_WARN_ON()
Date:   Thu, 18 May 2023 10:55:27 -0400
Message-Id: <20230518145544.1722059-19-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: e7bfcd50-2003-4f80-94d5-08db57b0118c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVau9lZyxifVZx7NT8ESzi+G/mvRqreev6gWamrHAQB1erShhkJXWreTdL/2rbuC/a7QXuAtLDgHJY+lZBkSHj/5L63X+yR/tSS5UEZJCh3dE1cpz+AsKOWdjjx4hVKHMAUuTbfBVmnRt2We/r/4H5sEYu2fakDcqVakqbYt/CAgBE9cmEP1pfGTDMgRF61bubZ+noMPq7h7MlQln0HE0y8b/Ls+eu9On2X5AkaJY6gabkbrYEA7zsC1RTy8zUGxhxq99HXGQK9AwYeGblRLIaV1/pi18gzhZpOYyJ9CDlgf2ShhcbyoGYz7OLU9WK0ACBhBC28Z8NrvEWzyv6FC2jhedfz5iY5Ux0CIOsLT0xn+bLbf/5zMRtNx6VLOJ48DAk/V8wEtvwRqvpJQR7/lfsKsWoG6s+krQCY04f2PeLhLp+AOinhu5wVprJi4AgBf5P4IivuuNq/c47z4UAGJdnqKK9g+ImKidvNjSH10b0hZKkDEV6Cg2qzQJMHQVxxluU3Sp5HaRkrdcSBsFcdf6WirlA6Kuy5q9vJyL1ysmR1kviWW0YnAl3lxnx3SVcy/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(8676002)(5660300002)(8936002)(4326008)(316002)(6512007)(1076003)(83380400001)(6506007)(26005)(86362001)(186003)(38100700002)(2616005)(41300700001)(478600001)(66476007)(6666004)(66946007)(66556008)(6916009)(6486002)(36756003)(54906003)(2906002)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K6tuF2EPsOT8UuOXvQBXUFeOkpb0HtJhKIbpx3H+u7egJUu14GZkAHFrakyx?=
 =?us-ascii?Q?VBtWj8TWPr49KH5iovfd/2fXWxqlj0Cb1HcI7VYjg57yIv294oAh29vWdU00?=
 =?us-ascii?Q?z3v62L4CKZP8GzLWd84lvr1yGNdnDsLY74O2GgAvCzQfZaevpLLT+Z9rrPLr?=
 =?us-ascii?Q?0OdeqWSUlqj0DN8R56gvwu2ml45gO+TPxXN6uuIEshjkgP1nyIFuq8Q4Y73j?=
 =?us-ascii?Q?u7qvd9o2F6EiabOCJfIaf0v91yykGB/aUjzZFrbVCjRsu7iQZ/uGw4tfGUhk?=
 =?us-ascii?Q?bwUQlnzabj4i+MzN6M9uasJPeIyzDu9yZQqQWM663WMfChvscCca9axXxSlG?=
 =?us-ascii?Q?Ccr+Tr2Q6MRV+5QwCm+YoOQ3EcN/8Yo/gORSf++odS8Fy/esiRBEyE1RUmO6?=
 =?us-ascii?Q?XEdvcjN0TBeftMvy1u/qrk5RcJDUeRzRDhv89EDTo62EWJYYSWGRgRrHZh7q?=
 =?us-ascii?Q?nzZPj2Z37yk/i0GBnywzk5RV7g1cP6WAT/T3z1bc5FAJjcwkerce8rApUNVK?=
 =?us-ascii?Q?Wc/nJd2RbjTKyROnMFLzdwE/WytAzO37XnObUtLFZdFlzmsIw1YueROtA4xf?=
 =?us-ascii?Q?z1EmwKsCzFtgE948DiptV6syZ5pi4qem8igKZK+JkdPKtAKMv0x49pfONePi?=
 =?us-ascii?Q?v+6Bq3Jkh+c5lwn6V/ve1TVLbJLFUmyvTRIrwOjt9brTD7F3HubjRGAE8Anq?=
 =?us-ascii?Q?LKBB+Ic3Pbl2lqQS03VOppQIfJmtpXImFdyyzu64ujj3245aLEfWCi59Q3WZ?=
 =?us-ascii?Q?E9VnJNRF5iUoEorXIC+Uz2SFnHg0kPEAm5e8dzhNxm3G5SOJq/ct3MB/qOPe?=
 =?us-ascii?Q?eJvYXKadSQN/Q5Fl1PXcp/oniXZAt6FUq0im111/ItFanyI3n6Y8AzqDZUWH?=
 =?us-ascii?Q?cnERQ0r88esm4ATYDPehSiNG0zIL/Ar8rl4ztm80iYxGux8oQ3BCz0i5CmZB?=
 =?us-ascii?Q?EDIK1CPrdAZzJ2TCBfn7oUbIj9VpEMVjCw8nbs+48WDYn7rnnBEPOeAkmxk1?=
 =?us-ascii?Q?pEKuOgnAV9AYmweex+Yt0Nfh+TXUDUKGUMuDVUYcgRmibjrJvzNRnV7Ze84l?=
 =?us-ascii?Q?lktTErtZo7ij0uh/mt24Zw9IloVGxXXSQQS5iulw+25sMQflA263Ei6+nNMA?=
 =?us-ascii?Q?ap3jdnlfE7V5u70tokIeRZytNatNge9rj/8JDfHFMLMmz2r7opyVEbjc4wFY?=
 =?us-ascii?Q?T1N58E6mncUdXHHot/5EGSDJqizHSnYa27f68BO0Yib7a69l6FQetceDAD5m?=
 =?us-ascii?Q?RQQ5OVhv2EW/i/Tw0LQJCp0bQjIE9QnUhjwxFYXIv8D2uWpH3yJCYF6p1fKF?=
 =?us-ascii?Q?yHAY9S/jkumiiR8oDvJQEduXcVKMvlJrT2Wa9CWOGkUekolyJCOASmioj8oK?=
 =?us-ascii?Q?QmRUZP3x+LwWayQZ7r0cUTsc1D+zri5EZUAjzOWFT7Ti0T6vQXd4RKwbHbU/?=
 =?us-ascii?Q?ZJU9jwtQKr6FSuWoJ9aXJDP6LCy1ihMclDfgAKzD1i4r8F/niBiJVppIhqkB?=
 =?us-ascii?Q?cPbF/8BIAxgeVdebQOBvmZ/kEy+GX3ZUnGBs1vN6PVTIjVuguV84QcmVzC6H?=
 =?us-ascii?Q?KN93e2u8LWQfXqBui7M1Lt5EJ8CTQzY579ef9N1tT9D/Ptw/52f4U3ISVxeb?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?wZy9wTR82rKCGijCkdawkTCtKWktxbluo+Cn03o4Ryyyaw0C/OuiYI1zOEfG?=
 =?us-ascii?Q?xuRHZ9JO6EORHPdX65JeTkSpi3edaz4YT+wGeeS3AM8/p18jL/tZtpYPVQE8?=
 =?us-ascii?Q?LrHmRMi98pBclJvvtOYyy2el72EekIGDz5nxcfFoDfX3C5iXBEJvR+J7oEWF?=
 =?us-ascii?Q?/1Fxyxf+2uAHiOwgDPItpYs8JwaoRNnG97F/wNQsgRx8JZtPcf9x7O2nuMNT?=
 =?us-ascii?Q?Uj69jMzvCqVqwgitqS8T7BXdcY77hvQBAstL7SFyV7aPefSzcrAAHTPDb/Pk?=
 =?us-ascii?Q?gVBfN766OfnZP3OPBzVmVAAGZoyx0kEsf/NCahV5Mw1j37imfEKC/sAuFOtG?=
 =?us-ascii?Q?BMK3YVLUTj6U4bOtCcWw4aZsGdJ7qhwceExt5yinJqHaaDv6/7Pd2MNKFWac?=
 =?us-ascii?Q?atVtqcK7a5R4q7Z54vxp9OJNTfFU/9XM/sx9XjxIYspd+Wb4L6jev8APLkrU?=
 =?us-ascii?Q?BRONjISEP02GVWd2VHpA01XUMXajoP7q+P+VQXsBmQGhm2EslbzIMBokwt1v?=
 =?us-ascii?Q?Y4flWTDx3U0DNM/UoSxfD6S6CyS+PnJ6vYEk9PhQpMmKH0128b2h3PRj/5bB?=
 =?us-ascii?Q?fZyr1dpF279FeQixdU0UZvO2MovE/rncHc0pirSpHKujwNQ/iuZxzhRpcoyS?=
 =?us-ascii?Q?kQILAe1pVe24G2PWCdfPJf4tasQTUtX3oTB4dyJTADO1aM8uoIAYdISCwUkl?=
 =?us-ascii?Q?gchMM48Hn/oANuex4JMEu+mBjQZBPqDIXcuHBGE4Y/d9yTk3OSLg48ctV2m2?=
 =?us-ascii?Q?dxem5MWVpVuqXTOZXAlhvQ4XP2Bo1fxTd2dej9wZpP9ua/8KL14VUqz0nPBg?=
 =?us-ascii?Q?JxdwX/cjJcR9lxWndZFde9/8Lx3w2AoHlj6pPMdyqjM+iHzBQVei+KpacWSC?=
 =?us-ascii?Q?OdCLDTVdrWx2Idjdkfqzu5urwhSM2h6kRzegJePO3s0EFyGUxlZJhOHvwQIL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bfcd50-2003-4f80-94d5-08db57b0118c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:32.4325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FtZeMrzo+fr9H6C97+KJZobZqjqON1RrAW9s3oeOC3Dwh8H88YLm0dbjJ6MXqgsj84phdUi5hvltqypauIwIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180120
X-Proofpoint-ORIG-GUID: TjvGn7p7v5cv94hSr8X2r-ykWeNCozLt
X-Proofpoint-GUID: TjvGn7p7v5cv94hSr8X2r-ykWeNCozLt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAS_WARN_ON() will provide more information on the maple state and can
be more useful for debugging.  Use this version of WARN_ON() in the
debugging code when storing to the tree.

Update the printk to a pr_warn(), but this will only be printed when
maple tree debug is enabled anyways.

Making all print statements into one will keep them together on a busy
terminal.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/internal.h | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 8d1a8bd00124..644fa8b761f5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1047,18 +1047,17 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 {
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-	if (WARN_ON(vmi->mas.node != MAS_START && vmi->mas.index > vma->vm_start)) {
-		printk("%lu > %lu\n", vmi->mas.index, vma->vm_start);
-		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
-		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
-		vma_iter_dump_tree(vmi);
+	if (MAS_WARN_ON(&vmi->mas, vmi->mas.node != MAS_START &&
+			vmi->mas.index > vma->vm_start)) {
+		pr_warn("%lx > %lx\n store vma %lx-%lx\n into slot %lx-%lx\n",
+			vmi->mas.index, vma->vm_start, vma->vm_start,
+			vma->vm_end, vmi->mas.index, vmi->mas.last);
 	}
-	if (WARN_ON(vmi->mas.node != MAS_START && vmi->mas.last <  vma->vm_start)) {
-		printk("%lu < %lu\n", vmi->mas.last, vma->vm_start);
-		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
-		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
-		mt_dump(vmi->mas.tree, mt_dump_hex);
-		vma_iter_dump_tree(vmi);
+	if (MAS_WARN_ON(&vmi->mas, vmi->mas.node != MAS_START &&
+			vmi->mas.last <  vma->vm_start)) {
+		pr_warn("%lx < %lx\nstore vma %lx-%lx\ninto slot %lx-%lx\n",
+		       vmi->mas.last, vma->vm_start, vma->vm_start, vma->vm_end,
+		       vmi->mas.index, vmi->mas.last);
 	}
 #endif
 
-- 
2.39.2

