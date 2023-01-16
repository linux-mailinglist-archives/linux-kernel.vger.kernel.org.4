Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F58066CEAF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjAPSWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjAPSVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:21:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322673864D;
        Mon, 16 Jan 2023 10:07:43 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30GGmmPf015037;
        Mon, 16 Jan 2023 18:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=h7UqVwz4PY1qc0Q4lonz+XNvT1fhhCmA2+707nV6z8w=;
 b=OIqMkfnDhDpDcLz6Q3YX0/OwfCZ73I+zYxCP+gyZ/FiRbV5LiSam/xu7It/4K+qRs9cc
 7GE0FNXIdSk3le1SoYkRya3sL85oLnXeH1l4JxOf9utTMIsCgQ/bbe8YxWXiRc67VhKo
 wvvQwo8GLXmspVZtg9iNsmR5uEtgDCrHwRHzzGNJKKrgYbrgneSySlRXOlOpW+0pirlK
 guh8u4R3CGz1es/c4RZPJdbNKj43J4cSufTveivXhREWLaewRjETrIF6Zxizd47PAlNI
 QbovExAtPycI0o1FR22vue72CgUlEI69uhd2UanjNW9jKK71Bhrlt3DZIbShjhWTM8BG Pw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3jtuk76x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 18:07:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GGSUuL020734;
        Mon, 16 Jan 2023 18:07:38 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rq2wr03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 18:07:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6w1ufKTwvqysntMmZVouQ+a2vCJrHWcfBwGpD1GxNFRUvhJGByOXyNXmduDqTXJLbENA1fmL99OdVnZLa/aUz0gBdt4yBvWi4Luvqulb0DdmtFGncB8L39GqiiPhYFWc0oR1Sj/Z3Ryi+DrgxinI2evgCeTwX6pF9S1+nEl6M0ak8k/Q8rKtelsp0bbCIuYOidXM3B4oQ05e4F0p6vsBAVwZMoXkQhwaH4cEhO62GJH9wrtICH9q63wrZAjm8S/Oa2BuPDoV0kgKVdlfhOBzc50STJGKn4i3a38LE7AUNqoyN6KOjMpTCL8tZ7XkEr2bCU3+GycMxKs9g606ekIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7UqVwz4PY1qc0Q4lonz+XNvT1fhhCmA2+707nV6z8w=;
 b=SU8Wj/88fu7ZCDcmvbIiQJkEqA9pwSUWu1yK2dVbJUae9tnGMCx5ca4C3hhKDkl8n98obgCbbqrE8iHeckoFjroc/a3zIWFtc6dJfCfEQGUUvuj65yqKlyb4gap04EWmiaMHlO2aPZ0/VsyGZDC8SpRf3wICwEjquxkdO2SANt7wEOPusotTK3X0nWCN3893zomdQhrj1vXmltMxrS/UxjaIOztR9ZhTYsCwZPVmDQ1SdzqlOeGXRwNnZtPJns2fMaVUsRBc7+MOe70n8mBhHejW6x/c6ZEdDR6yE2W648R3o2897HW6nutf0ILq50ha+efu9knr6/oDTDebrAQyqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7UqVwz4PY1qc0Q4lonz+XNvT1fhhCmA2+707nV6z8w=;
 b=bGnA9vRjWkKYxD3DzOKkI2gEpc7XT0+Nk1wxEcarnb6IoFOEvgU3yl9x6Im9mfVsvdGGCSuuL6BW2kP5Fhk11984KDXUvINcvcXkgZ7bkt9ye5j0HbIo2qRIP3jdEsZIyMR+34a0oqFumDdggh7Td/BAr2DByrd76PeynptAQ/c=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY8PR10MB6610.namprd10.prod.outlook.com (2603:10b6:930:56::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 18:07:35 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%8]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 18:07:35 +0000
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the scsi-mkp tree
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h6wqs6ax.fsf@ca-mkp.ca.oracle.com>
References: <20230116132415.793bb720@canb.auug.org.au>
        <57bd58f9-7df6-62e6-9d16-83102e942f88@oracle.com>
Date:   Mon, 16 Jan 2023 13:07:32 -0500
In-Reply-To: <57bd58f9-7df6-62e6-9d16-83102e942f88@oracle.com> (Mike
        Christie's message of "Mon, 16 Jan 2023 11:55:23 -0600")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:5:3af::9) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY8PR10MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: f8670f54-0295-438c-3196-08daf7ec8ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D95eT4s/nAbd+Kz9YKaXsNnDNcO/CFA0Kr5LgqCU/fmWvevFFU5GT58xCn+J0Py8r2RqxsdFt+Eqrsv6x1bRH3WqNW2fs5gnjy6rrJuX04MoFWYwr31BEfeL1xAoAjjHnu6hRjrXJCPrVj0Vf4mfE18TMyUycOC7CNnYggeQlIPsW3A8GAvxp4A7XIoox82Y5a5rXQvRGnoP780VX+KsrjcBv10zX9DuUVZR9N98d9q2w8Il/t2qk+wmWM14td0BFgZtyvpgUdB7Dy/HI0GZVt9eLXTFiY4MnDz1A3IwalHr2HAXLnDR/62LvKwQGmgia3uXRRjXzIUdPziTR4jX5mCS7gl0zKIwQKd3CeU99d1eJuTo/DNP7MVP4IGdajdfAOr4hrbXcDV9xgDpkvz+C2mmA6wYaNH6RyRuUa3+eF9XmkSDARnxW90381m3is97GOfXMOyiNQCRRP4aaQ4QX42dYh+P7ugoerydXEmt4cVhQDNjlQ78mAGFDbhth2VVBwRMq7Ud6U77vzox9ZCdrzORS1GWNbhKERNseFxctjTWLZ53fIZ6+0YWoh9Hg4bMc1T4BQC4hWu4IL5PkI6eFMfrieVJpnSwnrEKNq3n/n4K5836TVWvey9HfTKHUhajVSmlg8OPyCv9vct5TI7RvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199015)(558084003)(6486002)(36916002)(83380400001)(478600001)(316002)(2906002)(6636002)(54906003)(38100700002)(41300700001)(6666004)(26005)(186003)(6512007)(8936002)(86362001)(5660300002)(6862004)(6506007)(4326008)(8676002)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XO//UrhnVuOgMO/wPOzpt1P7NKLZVuTSMdUy+tsU8sAcIhoCO9MMHq/og1up?=
 =?us-ascii?Q?XV9sf9OGc2jVni+XtshpxxBYnPffZxgJ5z1MsgyAPIJJ5jobQ2exHY2HyDmI?=
 =?us-ascii?Q?arzNghoADs0QMLITxYSF/knP5pAnPgvzd5RkBMbmITc2KSJDPiyHiez3TQbB?=
 =?us-ascii?Q?RoN1qL9F4ZmKP5ECo+t8iRmNPoNZPG1AmHybnee8OXBOqsDqe5YTtB9VBYd0?=
 =?us-ascii?Q?CoDZUeBI992KyUkJqrrFcqZBQ+WOJi+gptGZc16OybvzsNyhhFg9TOHEEGWv?=
 =?us-ascii?Q?3yZdrAwFSsSWZpb/ULNFuuJ+Qj2lNBV5cw26J6tq3+rLP6BFOFhje0gFbVuM?=
 =?us-ascii?Q?mknMuRDJLREGwsgTnW+sM3ygqGsMTNx98TZAeL1TMD8OB8mwXiJt96TSYHvv?=
 =?us-ascii?Q?b0A+DXBWcmU/5Q1KeVpGJihAOi6upwguR8ZfTSnqOIfFTQwvygU8rdNjX+P9?=
 =?us-ascii?Q?BLZNlOdJRKffxOOZUJjYLfoLzT8pKYyq2HVQwLKSpZeaXaC/wafxxZwNRf0L?=
 =?us-ascii?Q?oJO5vcoHzdtsWD2thXQR87nmpwARHLFO/YksLHr/xNai9+foMiexVDLySwJg?=
 =?us-ascii?Q?NgMf6slv+sMayVlpFUT620jWkoNugPbqk0FXBZcmko3/XsK+y0Y2CWPOrnnF?=
 =?us-ascii?Q?hjgimfAu35xwLvmlAVVkf235kXVIkV9nP7YJBZfoW1VEz07bZKaFXN5KA5bd?=
 =?us-ascii?Q?gmX2GItL7rIduNUSPbW0GbFnG2ttwwjfy/D4GnmvvtCPWfW9bnu6i3gAejGd?=
 =?us-ascii?Q?Q6G73IG5qk7PhzqByL7/t/SDN5YI8Wg0AJLOmM7Akn0+QsICk6D/qI+1Kx7l?=
 =?us-ascii?Q?ybikNx/+0nQZXj5F9MVrsdxNy3OSwBxTbOmGIQruIEWJLTNt/rqQRG/14nSm?=
 =?us-ascii?Q?t5CYbzUwI0ZPGdV9jMK36Ak62Ppx8LppO6aQGxZbWOtEvCgD2MUuqPNDkdyV?=
 =?us-ascii?Q?vg2qbBxiR6oqxPzmyViPYqmQG2FP8LT+w8/MlzIw2dlbYJCZaKvwDbfPu0Iw?=
 =?us-ascii?Q?OLu+TfO/TlWXe0knVWZh+iSSlIwOJWE/+d0rWqM/Pk/aINhPTSQ/IhGfgoK6?=
 =?us-ascii?Q?Pe6ulAdH0CDD7q8f/afyq7NrxpzNHFakHqx2o2UrSsWBVTAEJld7FlSogD+T?=
 =?us-ascii?Q?Kg+OlKxGN6u9FJyeQbEmC5H2dGASpyOHw/4oOcer5GkT5mhEyz7nbjLLSdGo?=
 =?us-ascii?Q?m5JPu/nQXlwT0s0F/iXFocvEyTz/swH/CzalyVTQKgjOW7d3u/THmJnKwrmS?=
 =?us-ascii?Q?zZ6Xwoo6hTIDkGIX7bXfXOBfyDoX0+fHTBbDi707liWjGE1RWqOSxLQXiIGk?=
 =?us-ascii?Q?W4PMyF18Adqeb+6fbMe//gTuZSUyUHUAQZum13H+MCaozgZmOYUlPp/jVLL8?=
 =?us-ascii?Q?ZIyNKMUCtAwAErk4JAfwCB7/Jn5+N7UP03AlYjMBphQToXqZjD9FVhf1XppH?=
 =?us-ascii?Q?HQWO+0emnYPbI2WjA/tuuVvS4MLuoYGTDXn65lJKp2ybx93qw+26sKvhnOlD?=
 =?us-ascii?Q?XvccHF7kkj/rmaUFDEaXCNEWjDZkN/tN44U1Pc6NWvHt7ADTddQobJkRx7Eu?=
 =?us-ascii?Q?i/C5FVWq3WGwxmp3ES4ZOLHtvUtjfakjjnDSNMCmrs8Sb9fm+HBW7S/l9NCo?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pFOxsQ+AL3i1QCTnn4ZrmfXSOWvytMIkUDJtUAbfMRIQS/dAKe5yoVTCG7l41UJi8WEC/KbTgexNMj4TPmxXBZ3wlybUcL0PUvSE/nA58EIn3RznWCrZT/tivpieOYwqiERx3o4uGbeFRqVigRUwJFHBdoyoFybDDgTptHh0OsafxLKZRNYEUS/UCszEgW4R9C11g5TiHne8R/9F2FH94n+IWxorzrYd7x9rhqOgwYHXRrRKYZ7pAvVZCod9s8/6O+6mFuhCMb7NobMI9IxrLvrIMazhnBreEyha+HRSLb04JqrxadfskMe67q0mW601L9T85K2R1jxbChzz/SHYpMbA6cZi+yLBEAkEiwAW6L//LsYLC0dZZPIYgXIeTQghWHypJBnBbk4A7UCfJ+aohaCh1rAn6ds+T4tU6QnswnFYhL61REpntuIRFOCQ8Xbf9idJJ5Esbb7aBWiSKPeumA+4l2D6WDkN9qJ5unZPV/Bkjatuz86m7Ss8Ye+0+xIZdKjgXvQ8pIcrmLBwu5uBxyK2IlI5MATIidXtrUz+9gLAQB/ilrgHNnh6n27bA/BPV8RFdHQQ049FPUTP4c6h1lJq4GmV8k6KB6l7pv0W1VvMkM59LYlXEzW1LSARBL1BjiiVkD4t8Idi6lfnmzyCrrn7zc1RyN4Y18UDAXD0rtUXAsbiGARtYTMm3Ui4Kc9jskF8jyjFOZB/AvK2UjxDlqCP9V/DB/T2s/IbcMkSxkbowNqKGeeK+sgdbOB5FnbJCIsF/d2QS+Nbwuv7TsWkOLYkkwIsd20QIu79UQB6TkSHjGXTYVaB/jasqVkw6IYD
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8670f54-0295-438c-3196-08daf7ec8ba1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 18:07:35.5004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZ+UxLyFZ03Zxeb0A2BRqr8Q5FdJRuSXptt4z2zZZdiry8qmEW0xnyDoO7hdJIl9I7RtUFxM8y6rHahCB4FeZPBP6zk8Kfkvm6t99BBds3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6610
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_15,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=827 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301160135
X-Proofpoint-GUID: z_BXshFWyM63_PVwLbOFo0u6qWTPqN-9
X-Proofpoint-ORIG-GUID: z_BXshFWyM63_PVwLbOFo0u6qWTPqN-9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mike,

> Sorry and thanks. I'll send an updated patchset.

Please just send a patch that I can fold in. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
