Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB76D6DA6B3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 02:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238567AbjDGAu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 20:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDGAux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 20:50:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B921B86B9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 17:50:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3370Yfio008788;
        Fri, 7 Apr 2023 00:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=UYK/FdxKEIeSqjUFuCNslnHGFflRX9wWJmDTTG2+SiM=;
 b=VNjkZFvInID6cPKUxYsRzuSN+COO1AVoSvyPTTg1ZRcavS52dH6edwDdxPOO8BJUXDUP
 G4kQWbXq5ILgm+q1pSJsgYovAd9AJ2AjmIpX25y4YeqRn33UTj7SUh5bUlscrFVnikxQ
 pHJrbI6w1bzGdXjcfCOHY3kDkwdLwHd6SqWV8Yl9gRtnAgmA/UzIn/Ldt45ULVXzgBmv
 q41YgCtOmGdeeESv0XNf2VSqOJUykkGFbeZNH5lKSAoolEQHOsTvnuiQewwGBjHkbFeP
 +LQJgSeiJJXIoXBhMCIS3IR1WNGVJFJ9sCNiQKcDQsb5mxGgt8CgCiajWWJ3zy60P2NH vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppd5um75h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Apr 2023 00:50:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336MjFrW036544;
        Fri, 7 Apr 2023 00:50:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3n329q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Apr 2023 00:50:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fszmo9WmUy+B5h0aOhNV3UL4FXHZu4q4NVdIqSpSpe4HN/+sfBNed2xYzTBXgwfyz7D4Xl4Ce3pDIkbSp5yUsD7FUc2wEvoFNjwFBZS0+VX344lt3jdHdxZ9YQ3W2xahhUOVqxxekTQ5v6QxJJhL5xKzKNf+UNMYmgEdJ1+k8J4WTTFX+dpjpkX/6LAyuuNO8gzM7i/N5fLrF/pYvxmwR+4DGbvJwPalK0HtbsE5dkcbCrWr/kImtWyjz8MPsYTPTpxv3CeUGMJcxFfiaQwao+K7UdqG2ZXfi6rvjS1X27HgZH/91L4zC0sZlln5pR8nRpdsBx27K5H9WzQ2y8v8hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYK/FdxKEIeSqjUFuCNslnHGFflRX9wWJmDTTG2+SiM=;
 b=PDunPXKihkWalgcUKEAKSKF8IyZo6463G8tI4mBoMkbKB3YsZ3Cvm4F2m8+x1R5J0ED15U84Jstm3FYiVR577o8sFDM4BHOFVj9kd28s5STbtBU6ZAKQrXygT3l9mTcLcIX00JkRccSU0fHGyM+f1KkeDVhFLqlUdFNbB9n7itqglketsGbILUfoKVy1I/EFKYwX5uiAFBuyzm8Gnb5e/ZolMZQzsrIkpvsPaRvX0KYXCcO9nNvmBW0oAD3c9MmzNujDPwJ6MRUik5Knf3WoldUTHD/2m4RynmG2BWHKhoDpooWH85oX3oqt/LSFS1o5HYCvjsk9Be3cq5MuLwIsXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYK/FdxKEIeSqjUFuCNslnHGFflRX9wWJmDTTG2+SiM=;
 b=H4nUUrqZcsZBSl0bHQ4RY0insh1nRon2rXR5/W2uQfZvzkcVbbD305VCGSnXUjrazWvcgwFdMtDx8UGJfyts2iOGUymSg1LPr4UAXsUaqUpomJTtShwLZvU8ZHvgBvhYTM9kta56r03JN2WqXzuw1sZvwT/e2CTYpHK6gMKbg60=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CO6PR10MB5395.namprd10.prod.outlook.com (2603:10b6:5:35c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Fri, 7 Apr
 2023 00:50:08 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6%8]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 00:50:08 +0000
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
 <20230403052233.1880567-6-ankur.a.arora@oracle.com>
 <20230406082304.GE386572@hirez.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, vincent.guittot@linaro.org, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 5/9] x86/clear_pages: add clear_pages()
In-reply-to: <20230406082304.GE386572@hirez.programming.kicks-ass.net>
Date:   Thu, 06 Apr 2023 17:50:18 -0700
Message-ID: <878rf4jz1x.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0357.namprd04.prod.outlook.com
 (2603:10b6:303:8a::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CO6PR10MB5395:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c96b20-2e64-4310-73ef-08db370208e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHcam4fyVeDNP3rJdfE3QycpL0u73ypjdovoCXB3jrQBULNo/YuU1t+JGSoF4+UtYkHmC8/oa428oxR/NmRlRIjFHMTw1IZ55AU0uOX2iHOfkgJvc0CdexowuMmqT4sj0K67sTk2GIFyHLELVzho+1cfc16OrEMC1DofQs9FTLws+KzfNsCo1/6pM8YUVjqqkJRi495goQ163kAlu5JieXI1bLeiK3mrZnLJNORqnAL5o2eY6F9UY2UZAsoYAdNE/3T/pFSFczzPGePbRSj6O27LR/HqELIJkloyZFPInv5/Ke+sU6SiK18qAAtq3RvGEN/GECA4ygiqHUQbJy8KDo6VmUPkridOhMtjy+nldMGOnL9/Q7Zjtvdebeh/W67KPysAh+2QesdQKzAvaDza2yCPwVk/9pPCy/+gBBCSknQeT0VajCbbtzfjJgfFv1vQGi7sKU1425u9dZ3gPSoYOCP0B4zYCKr1emNfT4rZceMUqYiS1cWY8r7KS3F6wg40OK7Vb30l8L5IFxRHc54XngoH5xaeWzd7VjByn8ZuOspM5UCyva83HcagaIygw+33
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199021)(38100700002)(86362001)(36756003)(8936002)(107886003)(6486002)(478600001)(316002)(7416002)(5660300002)(6506007)(2906002)(6512007)(26005)(2616005)(186003)(4326008)(6916009)(66946007)(8676002)(6666004)(66556008)(66476007)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jr9plctcf2T66o3nYEoUJeKsGOwjRFwfJSWgvwIjYFHKh3B58+tr0S1m0rRK?=
 =?us-ascii?Q?UJd37cWc0Q58M5gTzVgONTP2DsWyFa4qIjMd4ffJ3V+j4x1dkP7xLH0MlPTP?=
 =?us-ascii?Q?AEtuAuelaFFp+FL2RozS4Kx6qUzIWGBhFGPbWD8i7DhCqPKNpKQZIt4B/fpv?=
 =?us-ascii?Q?3O00mjCdKRm6/QddlAoJ5TINwuZi92Z18gcjVc55m/rh/O2P0l2bbA0YiSrO?=
 =?us-ascii?Q?kgVQrtYkcckf43sLKeXo/kjTurucAa8zEyx0YRNIYgzOlG+1iiGhqSzZBsuQ?=
 =?us-ascii?Q?vhINCP+fLmSe1TGN2DyblKI/43ILM1nL4x1jn8LFOi9e5Kw81MnG61fJb31f?=
 =?us-ascii?Q?/pDb40kX2q37Tkngww+J6Bj/+J9a/eWMIGtuiHD5o+d8xiFL++O/FzGbyD8F?=
 =?us-ascii?Q?tFVvVO49GqHMUP42nwQim7dwj+IQaiXwFeKKBGUmP6339FMc89dP+9ktTCtV?=
 =?us-ascii?Q?voE08zTNzlq0kG84eC1ppT6pqMLDxYq8sc98m/dTF/NNY6LBkdrmM+UpKUqk?=
 =?us-ascii?Q?7b+KNf6uX4iEoc7gq60Vj+cdkoy0N4UT69F/KIdWY9/+3tPoCtqj5BHSCwzk?=
 =?us-ascii?Q?71nb3Lc/OzVrzt++BLp++nOJRLkHPinGCsPyV9uP83i3Tvbm9tSTylPDEiqo?=
 =?us-ascii?Q?pjWdvumdHLsnvVDoOJ+usJjLpqLTAz0wphi9arkfCaRCJ03CiiASBgoj6Jxn?=
 =?us-ascii?Q?PROUjc10iextMVKl/Urm41hT+q/sNyyjOJqgVRRmC0xA/06zb7S8ZadzGEIq?=
 =?us-ascii?Q?e5bfmrUxG3lIpmRq80yWWSBAc3T0Wbnk3C99tFZGl2l0e58rH0b2x43wRLk8?=
 =?us-ascii?Q?PVmIozatT3jKuQrcPmtenQpriFcsgqaKcjwWz9TMlKrFIHWHKM2Ugir+PmRg?=
 =?us-ascii?Q?DR6syd1vQfcrq3W1YDgETyq4CA82KqVIUe0VW1GR92R0548sBIbCsXGaIbqm?=
 =?us-ascii?Q?CpCfkLjmYUFRvgwcrQowgFHX8UhWasLnYGfNHUZRq8uy0vB9m0pNJbGYaKqP?=
 =?us-ascii?Q?oqfi+GmkeIXgKC8T4Dsv3HRCQ0g7USVs3Hlxt3u8xpc+8fRj9vdQCa7ymOTy?=
 =?us-ascii?Q?QGdad3nj3ON2xqDSNhQ6CPhPzCKYL1fFUB1M/DR273TP6YNElZXrhopXuXW1?=
 =?us-ascii?Q?q/W2jKhMmoomecwoF+oXI9wmBx8M5xP3tQEF/nFkcviu0J2gZumVAtGELUYH?=
 =?us-ascii?Q?6gquwIr0rP3ZbN+WjDS4lG7LYBQztynxUqCStZ8CTuNWQEyIM3fPqHab5f6+?=
 =?us-ascii?Q?UuJjPP+ADOAoH6LEEsMuPWeCU+LUuTsev0PDefCt7yo78fjLk5vf7uewuSmo?=
 =?us-ascii?Q?uE3npHBvrBl2vg3xGe/irBs5W2TgKH5+s/S5frv+ZYojQT2ZD6vTHffqfUgl?=
 =?us-ascii?Q?fsKq876QYPHjJveKbI+//nfaven6IVAbfTKuygyXEKPOOBLpDqd/tgkQhuCP?=
 =?us-ascii?Q?+mvtMSdMem94/vycg+UpLkJKqmTjG7IJskXc9vHAbvuP6OHd8NLDSWo8nt8u?=
 =?us-ascii?Q?A+t6n50aNG6ZoJ5HbQO4SA8yCNQYKC9RPSzhLf40XGeUk5XfkTJGtQP4yxD3?=
 =?us-ascii?Q?Me70jCuALtLbWump3agNcjkTfII2VHIDmQCqz3SZgGaU9x8qzwi6TD7ona4P?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lD2f1E+Spk0JohahrwrQqxTEF0UzsBxUmBPeL7fOC60WSusufaQV8QFDdwTh?=
 =?us-ascii?Q?7ZHunAbG23VW9dvmvIs6OZLGzHHQwLi4aL+g6qvyuPnCtX8ZfKHEE6Eaw1SV?=
 =?us-ascii?Q?G5KJv4eDa5xz7lgaF3ofqViAQRyBoH0mpSb4M5dibw+ffNaTgyJLwVumuEfK?=
 =?us-ascii?Q?kMMsv91tVnxcQWwNbdwHZ6t7jCkAdsMOe1HVunNmpK5dK2LVeLfbn6vyuUBv?=
 =?us-ascii?Q?V24ukF7BUQgm8GCtJ/28tBtyqUHypTfETybBqMF2D4OcQUHRVe0F4vGm9by1?=
 =?us-ascii?Q?abZ+QDgN9+McWpR0BVxXgGpyb3aR5GxwYdcsHXPYydwa56+7g1u5cgrxTD7K?=
 =?us-ascii?Q?DJiKfrj1+7/TyOfJQiuU8RTDyz9pktppbih1zFXB8HA3Du+kk9akH5mdefl9?=
 =?us-ascii?Q?xU0z2iQ3jbPRIZoTY2nGqIBIRRkUidTTgZ3fxJHJ79FI/kwSfu+dPNK3AOtn?=
 =?us-ascii?Q?8gQoy98rlhXI/dus1o+CDHO1gXQFl0FawwQ1cW4Oo2301+7vdnkijAYKZMIY?=
 =?us-ascii?Q?cQFIWeLvcz05D9BN+3ENQNt1IENTmY78l5DuYPpmA1Ja8n8RLq0Rw6xv6Zf8?=
 =?us-ascii?Q?YeQXxvAJc75RNSisQPUNxoCiggq9/xOSL0qDPX6GghI1Be6snaPBeRkjVgtq?=
 =?us-ascii?Q?kY2w7j69aKHmU6J43O42c3jwHAnA/N1krzx3OGsmx/NoAl5Ke026Xcj1hFyS?=
 =?us-ascii?Q?0y5e2CzQTgw1Pvdb6F1zyZ43hOcct+aH7t+R+pJzznFiPdagZkPQZ4fnikvm?=
 =?us-ascii?Q?e86y4uu4v295LfD8zpZa4HWfW32CNsNPl33YjQlPwgwIcjrU/cTtC4nPCBJo?=
 =?us-ascii?Q?YANfx5C4aqwxDz4G7iFmrRrf5ymD70ljmHO4Bn+FxGuFXP5Unbr25MWLTxik?=
 =?us-ascii?Q?golHyv6Y085bKysjufCf8oFPKiWPD5uU4hfDgNj9DI0W42EbG/RTBjoR78zB?=
 =?us-ascii?Q?N+drU+n00DWwA5ArLX04cpop/efnyD/46fvFQIPxH7ZT+OFP7yLv2rkIw3Oc?=
 =?us-ascii?Q?fJKen+MMaineSZj4QlNXEU5qNYI28o8rOrN3kogi5nMIleiQYn0wi8sCI3bU?=
 =?us-ascii?Q?OkVYlrLCDJZz5VYf7NhYfmEKlZt12UtXhplbC712kv4uJrXwx3ZTfWhq56xE?=
 =?us-ascii?Q?tGguJVw3wzNYd3QhOR84OYtoPZWRWqsFzpnuClwTHE98Lk+tdf4RCaw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c96b20-2e64-4310-73ef-08db370208e8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 00:50:08.5364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8AuBtJsMqSkmo91vWvu7tdzdDskxb6+ndkH3wP/9R/4RRprMduMi1XPOgfjO6aKIOWBE5a41DQnZPazCiBFpINzkyx+ZhOBuHumypwIiHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070005
X-Proofpoint-ORIG-GUID: TX8T3-nxbUAklDNeyNQrTSm1g0HYjW1S
X-Proofpoint-GUID: TX8T3-nxbUAklDNeyNQrTSm1g0HYjW1S
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Sun, Apr 02, 2023 at 10:22:29PM -0700, Ankur Arora wrote:
>> Add clear_pages() and define the ancillary clear_user_pages().
>>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  arch/x86/include/asm/page.h    | 6 ++++++
>>  arch/x86/include/asm/page_32.h | 6 ++++++
>>  arch/x86/include/asm/page_64.h | 9 +++++++--
>>  3 files changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
>> index d18e5c332cb9..03e3c69fc427 100644
>> --- a/arch/x86/include/asm/page.h
>> +++ b/arch/x86/include/asm/page.h
>> @@ -28,6 +28,12 @@ static inline void clear_user_page(void *page, unsigned long vaddr,
>>  	clear_page(page);
>>  }
>>
>> +static inline void clear_user_pages(void *page, unsigned long vaddr,
>> +				    struct page *pg, unsigned int nsubpages)
>> +{
>> +	clear_pages(page, nsubpages);
>> +}
>
> This seems dodgy, clear_user* has slightly different semantics. It needs
> the access_ok() and stac/clac thing on at the very least.

That can't be right. On x86, clear_user_page(), copy_user_page() (and
now the multi-page versions) only write to kernel maps of user pages.
That's why they can skip the access_ok(), stac/clac or uacess
exception handling.

From core-api/cachetlb.rst:

  ``void copy_user_page(void *to, void *from, unsigned long addr, struct page *page)``
  ``void clear_user_page(void *to, unsigned long addr, struct page *page)``

        These two routines store data in user anonymous or COW
        pages.  It allows a port to efficiently avoid D-cache alias
        issues between userspace and the kernel.

        For example, a port may temporarily map 'from' and 'to' to
        kernel virtual addresses during the copy.  The virtual address
        for these two pages is chosen in such a way that the kernel
        load/store instructions happen to virtual addresses which are
        of the same "color" as the user mapping of the page.  Sparc64
        for example, uses this technique.

        The 'addr' parameter tells the virtual address where the
        user will ultimately have this page mapped, and the 'page'
        parameter gives a pointer to the struct page of the target.

The naming OTOH does seems dodgy. Especially because as you say it
suggests semantics similar to clear_user() etc.

On x86, I think it is definitely a mistake for clear_huge_page() to be
calling clear_user_page*() (especially given that it is getting the
kernel map.) Will fix that.

Even for non-x86, I see just two users in common code:
  highmem.h: copy_user_highpage(), clear_user_highpage()
  fs/dax.c: copy_cow_page_dax()

All of them do a kmap_atomic() so there's really no "may" as documented
above:
        For example, a port may temporarily map 'from' and 'to' to
        kernel virtual addresses during the copy.  The virtual address

Maybe a name change is warranted, if nothing else?

>> +
>>  static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
>>  				  struct page *topage)
>>  {
>> diff --git a/arch/x86/include/asm/page_32.h b/arch/x86/include/asm/page_32.h
>> index 580d71aca65a..3523d1150cfc 100644
>> --- a/arch/x86/include/asm/page_32.h
>> +++ b/arch/x86/include/asm/page_32.h
>> @@ -22,6 +22,12 @@ static inline void clear_page(void *page)
>>  	memset(page, 0, PAGE_SIZE);
>>  }
>>
>> +static inline void clear_pages(void *page, unsigned int nsubpages)
>> +{
>> +	for (int i = 0; i < nsubpages; i++)
>> +		clear_page(page + i * PAGE_SIZE);
>
> cond_resched() ?

Missed that. Thanks. Will fix.

--
ankur
