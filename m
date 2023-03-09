Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C826B2F7C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCIVUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjCIVUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:20:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF61FF9D3D;
        Thu,  9 Mar 2023 13:20:43 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329Kx2LK000795;
        Thu, 9 Mar 2023 21:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=mj3oRn7cqtqWufZO8YKgDOH+0/mjOWgkxXGj4G3KQhA=;
 b=qtDBEAoGI+RrzEXULZxHNfZllj5dd/lA/KOF1U3PmiPrBxqnUqtiZKCt9ncItWFi/4ts
 w8LbfzxBKLbLss8L+EwCSsTMaRkSZ2Z75b62CO7YzETSfQBKrVdpWEFh9KeLJ2hFIPyu
 Yb5Mlb23sZQwDGg7dUqWeNza8A9RU1deegfC4TlpOu7Pd+TwvzKJU5pOqkwEl0/WnY4z
 75zGREasuBXhCMS+TTH1PwN1oiHiU6HBUaiIgY/ukRi5ReevfmQHeXB3LzdZx63zKI5C
 cjcC1v9iytuqQxo0TaqLABgPMDhxSCchnXXI7PUfDKGPeNEm/xf0zGQfOq9BEzMo8Xi+ FA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4168uvb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 21:20:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 329JmY9R022005;
        Thu, 9 Mar 2023 21:20:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6frav3kg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 21:20:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcLNZe7LPe4AKgRxvLZvP0UzDZCvllX4GgReOMddIxrNiOqFBuILwY3bq4IvLqHiBPJjPnKYtN3kjnLhQ6gvRK30yEYjeM/EeZsR5kAGrR+iFnPI4B9EopqLCJrm2elj/pJvBrrZNfWOftqGQggJm5H+H1bLuvUZGDH6tBDj07YOAHCldcHKYdsHy/JK3aLAgcwBBX0Ulq82GG55aw32ELHY1eakrJwsd+caG1wBldTwbsPJYTAZ0E0mzxVSDLFY39cfe/51BHEQGdo4C1ClrRSQjcGCAG3C9kkyHbBSugFPu1wQcSWO/c4fP4e4UkeqXTOekqmThj+d0Lkt4W2R5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mj3oRn7cqtqWufZO8YKgDOH+0/mjOWgkxXGj4G3KQhA=;
 b=BY7CTzYWdXSRkqQ6llwPTTECqSlXhOI1YuU5u/2nK8k9EhrByvnThpNp1lPjc0gfH4ferRV1uw6U9EaGJIvIqZFtYBY8TsC8bpODMneAckxHKSMcxvJTvkks7c4sBbdmaMs1hS6aexfFg06NBXbK4drMkt6mvpMSdRTQG8u/UYkvvwEp7Gr8lAznsn8+vCiN5f6am3UmYkbUsYJIoxeKhB35eJwiwxhui8dRHjYkdJU0Arv6L06B5ZyNyxWSG8GdZ/MRFDndTodc5+1SomFoJlnYujx0GX+JrliqKGco1D+d08+kAaJTO6MijYPtFtpMkECQg5jGu28Qz8Xom6H6Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj3oRn7cqtqWufZO8YKgDOH+0/mjOWgkxXGj4G3KQhA=;
 b=jbhE6XQHgdxXJMqLAeJd2rncbAUZiTs8vmeWUMEvm9dEzawk9UGhrhJMnIyGFIjxBabbAYaCsh9ZEHQrBIk4AoWPo//YHYAtjMwbh4Yy/1gcD0leyn/pbvUyRdjEb7x7vxzHrvpzB0u189zaYpU6tkebGTdBfH6PvzX4gijTlzU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB5858.namprd10.prod.outlook.com (2603:10b6:a03:421::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 21:20:31 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 21:20:31 +0000
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [PATCH] block: don't embed integrity_kobj into gendisk
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zg8lbqye.fsf@ca-mkp.ca.oracle.com>
References: <20230309-kobj_release-gendisk_integrity-v1-1-a240f54eac60@weissschuh.net>
Date:   Thu, 09 Mar 2023 16:20:25 -0500
In-Reply-To: <20230309-kobj_release-gendisk_integrity-v1-1-a240f54eac60@weissschuh.net>
        ("Thomas =?utf-8?Q?Wei=C3=9Fschuh=22's?= message of "Thu, 09 Mar 2023
 20:23:41 +0000")
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::8) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f717a54-4c1f-4588-b4c1-08db20e41caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JfZYU8MZzO0hH3l9w6sNDhg/+KNLmwhgOYV7U+i78rN1TW3vvZCDh3MtF8qhAu9hmfaIylvbmcDDPJizEQXOXpbrmVKBdd0rXRPM4AfTKHjx3DbwpX2hlMogLP/FgyTeWjYrvaN2HHxT37PB0r/I3FroXft08LRPQ43oXElK2BpuHOMxGT88nsvfnTow7kpIZoqhbx1j+/rBbr8WOen2TX1jj+miRuGRslUmjmVve5VXtpVgVA4XFNwQXTFjHAy0K4+IADD1Hxj0WMXZ5fQr8QwAOLDABxa1xaJdUw5xECsIf25EfS4VCpUmfJKMYKUmLgEW5UIIWT1+uVRWOGfYnhN4zcYBFEUBRJhn+Mg0/2rjCxwvdizhHrRIeQlWxL3reNAFnzjUeR9mmRUfS79qQT1DmF8+JinvPBJBv9zHBesYYz9vvdBHW/FT4LTzWnzgihtlv9ouZ1nSNnRM3C05fBMtd9ZyKueZS5N6l+VXwAwiHDu084pEwWkFCZtThe7D/XQeI8s4ce80JWtHqd4X6emDGIuhvBY9O806x+oU1aGa1TYmLYmFne3YRv7to/7jjiT0vNTiBWJYYpV10jiCjMY3p2aljIHfFidK/7xwOenqFiHz5DYPggxarVx9+0X+2TFDuhU09iUTxyf4FrTnJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199018)(2906002)(5660300002)(26005)(8936002)(41300700001)(66946007)(66476007)(8676002)(66556008)(4326008)(6916009)(316002)(86362001)(54906003)(36916002)(478600001)(6486002)(38100700002)(6666004)(6506007)(6512007)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MU3DKzKhbCoHYXyUQ126lqRNQfRiut+paYFhTY5tqezF9f6JM4edbHoKZJ33?=
 =?us-ascii?Q?orYfiRujaDY7jhLrkgV8VvGluc6saGLqSidjllV4PsgLbX9NUkOVjKkxObUv?=
 =?us-ascii?Q?QftSjphMLllS6HzqCUqsZ32B5GAu/jd/Y4jGpmfeDUUkNI4dQoLmZPhEpdWB?=
 =?us-ascii?Q?W/5ydOigVKvsBvaAOFIe3QUZvpnENxbKtF30YhuwQZil20yJSnfwCwn4jhYW?=
 =?us-ascii?Q?0+wVA70LMudTSnT9i2gRDGROne5cRArkvO+RLoSdx0OtK4fMAmCl5ANRScHU?=
 =?us-ascii?Q?GNAfS6x/IV3J9VvXwULlIHyisb0qcvgMVQc2K7jIaTM6FKG+sckBPYKcO2ux?=
 =?us-ascii?Q?lJFVljfOjwEe8Epygr03FInn9rSqyZNNEqyGHjuhVMA/vnYerBY37AZxNZvP?=
 =?us-ascii?Q?341HzegKY09pui6GRLEwDP6mxUPEps2qFSJypM2tN/Ptd6h6R3XOZsAFjBqt?=
 =?us-ascii?Q?sCE1FSSuPFiLyP8mOcHGidoc6v1abf/zd+9TxecW6cwTksU2SAlBl3/6dhof?=
 =?us-ascii?Q?5r9IOg2qME50yYqiXvdxGAr/l8rvW4ov0T4OOEOAHQv4La4LkgQ/6J+vyk99?=
 =?us-ascii?Q?4ByQcGmp4PktJ8FRwQTJ9pyEHQ3QcSW2Ar47vZXikwy0aRzkIkYgQM57N+oF?=
 =?us-ascii?Q?oJ0hAn8sg79i3FeGsmaH12niuRGc7I02ZtQowXlXlNBoYc48CIAd0rfgAqTf?=
 =?us-ascii?Q?43cK+z+L19/g4zjn4brVHCVYrFcV2n+hOMdAUFU764R7ZasFWFP7FMyc7J4s?=
 =?us-ascii?Q?ucFPZNB3/4/6vRpGDf6jn11C8NSG4UXwu39kLxpzzWCF9UdStIedrJdbG6B1?=
 =?us-ascii?Q?37nrtMT/vlhgf9PQewkUTtZM0PwnsnxJpm5t8sw2prtSwmnIsuqR1URJhAy+?=
 =?us-ascii?Q?7eEiMxKLQNRI9eDDwhOd8HiMBWDGNDslI1f+HCQWniduIPaWNP9gMu8SYUIv?=
 =?us-ascii?Q?n5sNDhZ+B54kcHYfGbFLhZRz8FLtyTs74cCkZeYQdMxE8naPbnNuPdLpOQiP?=
 =?us-ascii?Q?JCl6Rp6WKXdXZ0Ko3qx3iGMBzMATgcCGK7zadOF2g38HX4yd2aqqudFSJ1qc?=
 =?us-ascii?Q?rcSPAqUi9wu6wqkG/saUQIJ8fbmCGyJSbFE7t2VmGXv7CW7g4uc0k4Mr+2yP?=
 =?us-ascii?Q?+p+gsqFbANwXAkLJlIqQ02+kMf0CCwIxWlL3XroFwth2sPsC2jU3vedsjrxq?=
 =?us-ascii?Q?obdqZKfytfDJmmIB/tN/uY/iFY0MTMjVOl+GWN9hXSa34YzShH8NtfPLT2nI?=
 =?us-ascii?Q?CXfK6grdKfgv73sWT+dDj6MTjT7B14EnLJl7D4128+v84quOr6XAK1FLlW0O?=
 =?us-ascii?Q?5a9RWp25CCYYCmpfZgefc8RanJPcwdSbizW/1VIpdjpYxhFtP95b5wJt+5Dd?=
 =?us-ascii?Q?M8nJgyagkaFAu2JybPtsuqoE7LdFq0eSKg8hPL54AflANVdeAa4bePDwv/1r?=
 =?us-ascii?Q?Mq7O/7JXoMJJly4c7zSZRYoqUUxldu/3kRsncgW25tnr4XXTMXw60y+txTbL?=
 =?us-ascii?Q?TCl1gbjwTYmIpdSHR/hxJ1ozvMt7kLHsLmX6Pa2ldJovczp3Vm/4FNacncXc?=
 =?us-ascii?Q?YbHC1pwzeqB0ClTA1fs51f1jkRdiMiYOkSIHTKPYELvyCIX4yStbn4vGitF9?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RGA3fmfDDVlQllwpqjQfnIo8fCK1U3/GMK8hXX/zfOqx8g4FB8WXPKrCgBvGlRN8d/6IA1AjYm4eJfVrdKBh137stSphbLkRoCeoxHKtTm6VPg7VvNwN8snRiRZyTQjfDb3shavWF3xSOPnYff7yBFhusJ2ht4StX/NvW5XGxT+Jd74AVni/4O6qv+pOrkb4EDzKH/yrYLkAjobWv2DLmxqpxAhiuxFKsR8LZRAFx9/9VDO22WIAQ2ODEabvbVSoRrnA392g1ZD/qNoYYNfKEbNZ8ix5hfPoeUkSzRpghPie1v889iT3AGiUCJfzxs8Y6y5tXJ/i+MeDYy6HUK4TJAhF08yk8eZ4xb6sO/ERO8uAeQ4e14mvy2i3Bw3NxH3XODUnyvn7nEsu1m+B6uDXl+XPQqf3miRLBbrG9nqPnxgompQrKcXUvk6YrfX2E2pEpf/GDhsVhmHqpXr4ROyMizxYVSNmnM6g3G8+rU6nMGuZdddQQtpM6My4UDoQ5QPTxiH2LpsPhvdPDTR0TnN1RvYhbVmanyzokMe282xbr/W84lP4yHZKhz+qCMveo060H7/OkXr6qJmDOJnnzGx+pxlBpUoMhZt5oXKtphT4lq31Lh6AOYt/oKWNhV9eUiKp9rhTIhW7yuQD53cz5SfapF28x2vxnUKMLkAfWd6j+xmkIXPYl7jPtjITEX39681Jo2M7LuMlQSv9BMw8rSUNdhKnTr/xkalmwTy9/oUFi/BfHcCk0CjM4lZ5eJJZ8kQbtOfYTjNqXcVJ1Cfada3dItbiZWsyiqCCcfDMBOEuOqyXYi0q8GwYKOONjx7RSLmh/NsfrWtIZ3fr3xNyo/DXxuMXBsBvA+bT0lrw5hFFM8/2dR2QepbDJKCw5Q6B383XQaXEZs59s3T+QwLFMsnV/VhJC2RpkKtXL5ivwqegMGY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f717a54-4c1f-4588-b4c1-08db20e41caa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 21:20:30.9777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITW8VYN+sTyPNmul0moyUqbPqte8DBf1Fb1oFbiqBOWs79C4RrCX2gKeuKbtnbQBrzl5TfWLx4Un9IM9ow/jm/YfxU927uks2szQIheZAz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5858
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_12,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303090172
X-Proofpoint-GUID: 9TVmyWAOyjvqlyiBhAPvrWOMhbBqNjaQ
X-Proofpoint-ORIG-GUID: 9TVmyWAOyjvqlyiBhAPvrWOMhbBqNjaQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas!

> A struct kobject is only supposed to be embedded into objects which
> lifetime it will manage.  Objects of type struct gendisk however are
> refcounted by their part0 block_device.  Therefore the integrity_kobj
> should not be embedded but split into its own independently managed
> object.

That's how we originally did it. However, this caused problems for a
couple of subsystems, NVMe and DM, if I remember correctly.

Managing the lifetime of request_queue vs. gendisk vs. blk_integrity
proved to be tricky. Basically at the time things were allocated we
didn't yet have all the information required to complete the block
device setup. We had to be able to send commands to the drive to finish
probing for all the relevant parameters. That dependency was the
rationale behind inlining the blk_integrity into gendisk so it was
always available. Hazy on the details, this was a long time ago.

Another option would be to reshuffle the sysfs bits. The kobj really
isn't used for anything else.

-- 
Martin K. Petersen	Oracle Linux Engineering
