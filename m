Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAF66C8730
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjCXVAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjCXU75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:59:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2F4CC08;
        Fri, 24 Mar 2023 13:59:56 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OKxZPK010852;
        Fri, 24 Mar 2023 20:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=khv02PGBbf5T4LMFfePiw2rCUJ3xOZp4VEcNCeFh7CQ=;
 b=2VYUKpEPiiT0G7g0f0G34k8MctIyjrPKZv8pGsm4iEWemcAAb0jXrvIsbLvK5hXb4uF/
 jUAAog+rBuF4ZRsiglOZ5Obdf7+PL22M9o0tbkojdgcda00HtjPjgh4Q19eCpdeYY7ke
 r+3uUY5+IFJ1bqcppv5FxLT9z6bT6na2xiF1Hn4C7RpxRyGtY+CLBFckzGCVMCrF9L/a
 gwx/kxVx9BoRE/WROQe25tDJQqLgQ5+EVH5ulgsIE0SU1r2nkFVsveNImHZMf93wUgD4
 Q+D05e8CJlTjPOPK7BDWB5CatWXSGc0uNov+1glBx1VKoFuZx8ct1wEyYAPQsmEZjN4C kA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3phkcqr00j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 20:59:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32OIgHn7038203;
        Fri, 24 Mar 2023 20:59:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgxpyg8gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 20:59:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkvaEYzYRALeZ/1u72kBVrNsBOcK3QaaZX9GlcKbtMsg7fKIO7t3RBNI5+YGHuE0bgJbinnNOzR01snw/S2/I6VHMa21MJ7AuaHouOfrqsef5zzysHsukHo8lyLN8jjYw7S2bx3lAwiUz/2Iha0ITyCYvOVBQlG1o5PoY0SyQY2TE5B/gKHWVNXHSpYYBkJuUS32tppZDsy6kthUCCKRI7GHSyrn5edU9cRfgpUMyzOTTRsMNsQagBPlowu3jE5/NaG/VYTv0sKTJQtuGmKLE7QBWId9vmXCPQsztSbYP7hsaO8nDilEjlUOOS20gSc0ZMUsyzhTHZAZRGxycGXvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khv02PGBbf5T4LMFfePiw2rCUJ3xOZp4VEcNCeFh7CQ=;
 b=cbPyPTEf7Mzg0Q9AyCg/ZwmFb4clfjWEtaHyYksCwIM+kxUm5ap+6KrEjszZW+uPEXA9wGdF8GkZV9RldRSLCw2IrJpxBUN4p45tjHl3RmDPGl5w16JkN9dRxURHMU5S/3kMr2aheij+hlOWl0/RPS5vHOsaBOC/cDwsnrAqyas060jIANxoKzkKp8Pw0r9I9Elrx0o0kjTD4KbkdtTHJJuPlL8m1AKD8Zx7LVKltU7t1vvUoGK55115c/oMgraRtBbIjOox+d4nV6qEs4+ngJ23Mm3vnDbSdR/UUkPgBCRit5x4EDAqriJRwry0kUOWMUOXJDX7PwCuRVCGLi80Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khv02PGBbf5T4LMFfePiw2rCUJ3xOZp4VEcNCeFh7CQ=;
 b=ayZioqDYlVhykKrkBMkS+AyrWuNRnjcx+pvoMvS+OMGhJkytkNDHfUAtU9xtWFtV/fiRKXt562zPPMXLhB9F0LGF2xVLvZ6SQUyiUwNxe+KEtxskYFTs8/tMy5BVMfAh8Vyy2ZviU9w3h3MDqYuazSQ9Q11CD9qNo13DcqRPOLk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB5675.namprd10.prod.outlook.com (2603:10b6:510:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Fri, 24 Mar
 2023 20:59:49 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 20:59:49 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Bodo Stroesser <bostroesser@gmail.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] uapi: target: Replace fake flex-array with
 flexible-array member
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17cv5kgrg.fsf@ca-mkp.ca.oracle.com>
References: <ZBSchMvTdl7VObKI@work>
Date:   Fri, 24 Mar 2023 16:59:42 -0400
In-Reply-To: <ZBSchMvTdl7VObKI@work> (Gustavo A. R. Silva's message of "Fri,
        17 Mar 2023 10:59:48 -0600")
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB5675:EE_
X-MS-Office365-Filtering-Correlation-Id: a37219ac-6b27-4847-c416-08db2caab497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nzm0oFbhJn3GRCJpZWesGlCqZzVY9gqPtWjz8w7k4Mx+ER5CTaylJJK9cI07wfl56Ao+im6x/Vmdb86odhTKdco6GbruGNcYvoPTaY40hfB2NbpVHqyLEFdB2oLqPTrEL5pQDUsr6pHmAVc4koKpn5Vf7Zifkv0NKGZfhebOvIU95QiH8TrmrJaYZkimRr8LAKPGxKL47S3xfn4uKGWOmOnVwl5VW8X7UhhzRXlCyQ/PYeOG4yjKhR98aQvqLAbIhb/kO+D/zTdUlTt4SlmxsjCTGvrW5ggA46JplbpUDa8De1Xpv4qIYVdy9oukS6etkMxslC1c3M1wJiswPVSGXvCTww7WuQN6Y8C8wCLCwTfxT6tuF3Dx/R7r+GAzKylSY5iyUwyhEIsvfmulwJtkY9y8/co9FgEz1Zp9iRrGNus3c/GRdVYk3FuSg+F0iTRSXIBBJ1/+PQfE7/Cz+QIPfRASj572wZ9+/jLfcbhm1GBJkOZhJItAEXO6lJh258japfEW2fOGvvyAa7vepCZkK4qyv0jAkmXOFFhK6peK20R/FMNjkjwhjyg/vDTZt25P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199021)(66476007)(558084003)(26005)(38100700002)(86362001)(36916002)(2906002)(6486002)(6666004)(8936002)(83380400001)(66556008)(4326008)(41300700001)(5660300002)(8676002)(6916009)(6512007)(66946007)(6506007)(186003)(316002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q2hx3xsJX2okr3P4dXNQL098qbJNCSUE0aZFpmMd8HWiYjG1w7gjLzW4+FBu?=
 =?us-ascii?Q?KOgXZc1CvvcRGfpq/PLuwbFDhQ7LCx9vjV50NKWfqThp907uH3OtZ+MVLsXJ?=
 =?us-ascii?Q?+VFKNKwbrea8UVYb9OouZQdJJ3Ao1ftO/DtxMlWWpE2KqLALCJ8ndJ7QvZao?=
 =?us-ascii?Q?zvFvRYJrwCeSAHLw8HNgNmHtu7U03zZXpwu7Ve/0+W4mvSJSf2mFAP45czaX?=
 =?us-ascii?Q?Jt2tJMAy/iDqsaeuTwLhYnUdrspShKj6HjO9fD+YnvC42LYCyD83dtZ6RkkU?=
 =?us-ascii?Q?Z9Z1xsa0+vUvntiirmmn4kOqX/YdAN+HIEI23uE1BwMFCHJSdS8bfdeeqCJC?=
 =?us-ascii?Q?HpdVyHL1yHgNweDxX+x5443ihUTDdyABGKsfL6Io8NyAVjW8r0/QDtqcZVPj?=
 =?us-ascii?Q?Vvs+UGKkuWIYEQlXxUE1bqjfex1CiD6pUynaHpKdfefMoHOLJy1TqGBx2rf+?=
 =?us-ascii?Q?xPdtzmFS2BIJJAWCWMvndFHj12uOFMCTL9qX6J/CA++ee5GzFWWdSgbjMRMr?=
 =?us-ascii?Q?Hc1B3beJu4644e7aO8X8De11IMgDa7tauD94GDYkdzg3Q/pvI24WTVz8kzwJ?=
 =?us-ascii?Q?OC5wQqgDwe5XUdX3AjlYlnS68UZPKDyM/6/NV+DvpMtcR5vHnRVc9U0m3bSb?=
 =?us-ascii?Q?o3WMp5A2B7dlGjC8YIXWEI88fS3w6Bwer2P25ETflxxA8OAzK5AR2x8zmtwP?=
 =?us-ascii?Q?l+nvWWCHPZDYc5i5HgbZ2204Jjy/nEy7J/vMf9bUG7H81dxdVV3CeFcruqjb?=
 =?us-ascii?Q?A+qkLrce9q0XOM8NuFm0JG2PduCh5DiRkkz5lpmb3QkSMqfBiKbkwwiJw68c?=
 =?us-ascii?Q?YvqTCyKiuQKqnZbNs9vKziRcSeRdGWVr8ZbVw4XwmWjneQm5VLpj5nCwsHPq?=
 =?us-ascii?Q?ZtVjqqvjz7D09LxeQjBEJeJy0jDvA88DRAK37I6pnTmn0TS1vALimMZB/XDN?=
 =?us-ascii?Q?L9F6Xb/03rut+XfNKBiMLZf2Z7a3JrYXXlFAYyMX6e1ugGR5VmCUBcXEXpcQ?=
 =?us-ascii?Q?ElAFS9CHa/6L2mAt5zFZ6jMNzw2GUJRBqTnfEYfrKreDC/XiXLXTOiywNjfU?=
 =?us-ascii?Q?qJ0OOD8znHUmZzUA3L0GAK1Y7qNS/a5NvO4k5wQewHS7SzANoivvh5TbF8av?=
 =?us-ascii?Q?liyMyqL/7DoyHmEfX921YBFeM2ltDdm5N9bdn5s5Yn9uWj6gHAlumb3//26Z?=
 =?us-ascii?Q?LCc1JvQa0ZPRIATSb1f5BDdv7wdOMeLTBQc8dTjauqAhr8i8ivwzs0Zc/Xac?=
 =?us-ascii?Q?eK2ZOl/zZLWMj33RcESByTYfgkab28XjLZLc8pFcoX98bSsQ8CKu7RqYSZFZ?=
 =?us-ascii?Q?oEx8VzNguR1T8opA0fCD5ohX9i1Kgc+c4OHPeA0n2sXjR09j5x7wuDORZzjP?=
 =?us-ascii?Q?U5AkzmJkxx0AIOcnGlusbl4ppQx0vyAoe4oElHgzX8xEC8j5LTzny0TZDA5p?=
 =?us-ascii?Q?srhVK3VPpVttkZvPVcJHdhazCkqxXRvcxqsFnNguhyp6Ha6c0nuEFYhphsHT?=
 =?us-ascii?Q?j/2Xp/rAq1DjvWEK7xWgHKjkcsB+BmVEgs+/EQe/lX/e6Iv2upzTSBliGCTa?=
 =?us-ascii?Q?a3gp4X7nzmU+s/TiltBg9c+asTpA71g5CtRYlzk7ZOcJ7ncR/8D0aBXkaMQ5?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eVoRAcnC8JxFwfvAdU0eW8M7eBfO19vP1jUWJ4utmRw5bbOc9rGvtg35sgCOg9lWQ/aDc56gTCwX0/uwdPyF/2gPYUwbmFQayjWYX2CIvVo7YPRt9Gzh9XpfwI0gWaqK/yWtNI7KUPJpHmwHvVjVhYl0NR8povsfHWRVYhZX4hMxeJcnghUNlkZp0eFxFG13gV/iuyrmkNspLjlrViWKua4ABhyUH5zdlTeHU+D8Y/tqqtP5D5T/qX6Zj99pvNXd4uMvc3zdZqxtjRsr5/MoiXH+VoP+UjpyfijeDvcGGcZeDMKpUTwflrxS+J/c0hOYdqgblAohfXVx5w2zgYKz5wABU9dHVqBHnHb7GkN0BLuuMnI2kXdvOtvjybtjpQLm9g6fWjFfR1rqKOYcs1IV4x8W7EUOKn4CvwCRAWUOTbqFrOu0TMbIexbYFsHc73NX7IuJshdAITdLcsvJoerwG+ZBRpYCQ3P8eu4/5D3z1ehJa5Bk+/oF+H4euwMhMy8hUSlcDmXXfREVih5Xh9B9fsJy6PjBAZGnZW16GWhdYx9kSXeiYz65EOz5ICG/L6cT/8zxG/nyxbLSfyLzneWP+28zocUNcEewQtvD9UmlJ9T/qkgYdXZ28aJHqtD+5Ifb4L2wjkKN5IgFTrETIxwxC37kuyXQhZpFHUg6BH+z3FKFr/iNBcLxCVKCdH6wVf+sScTeKERcRNddX3yndDb0Y870LM1jtKJv3UHPWPy7jrsjV2eZq6TFyB3GrHvx2HLWwniccZNwKT5d1QFTWx3xX43XLBG0kAnCggz6Gre069UZjVDrBL4Qh22/UkzfNAur
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37219ac-6b27-4847-c416-08db2caab497
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 20:59:49.0683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBCBRD8NZxe9JQndhZz23i+1AZcRDbynsOfsyJ/Kll3TzCHyHs4gTdW0Zh/I49if88KhxvM3ASwMYHxCxor7hig0qOrJxNy0w8Oi4sRpdQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=637 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240159
X-Proofpoint-GUID: vjy44Klaqd-loeSm9fYXFQj01vFOEJ2n
X-Proofpoint-ORIG-GUID: vjy44Klaqd-loeSm9fYXFQj01vFOEJ2n
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

> Zero-length arrays as fake flexible arrays are deprecated and we are
> moving towards adopting C99 flexible-array members instead.

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
