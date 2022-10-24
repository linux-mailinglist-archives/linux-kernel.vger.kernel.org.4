Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2551960BD3F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiJXWTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiJXWSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:18:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E8230F9FC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:35:53 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OI9vSW013584;
        Mon, 24 Oct 2022 20:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=71wRQN4gzMhFn8vn9fIk/q2PpxADx9cDqVlEXUCrtyI=;
 b=oWAfSPL3fYvFFR1oAFXnwbmeR4fP/I59/XxFkGtPcDdn5SYKcyGbcIHRCl/ZD6oiUk9l
 lKqa1LIDR07UsrxjnQNrPr+14bh6zsRlKQAY2CGpDQAE5oDnkwSv+bdiFgvJIcjjzagY
 rsEiiCmIAwiTepMj8GB9JBgTNfEh5T9SCYPzRRkpnSZDQpQE2BQV9NdPZjSthp0XOYKp
 IOVeINozHO1PHBErtaDOzuW8G0Xowt0NX3ifBA2QmlZukQ4Cmaquzct2PDNkDPDdg6Vi
 daxL6qlbnpkC4S6GQMQ+tEIEJKGBsGr33W16ejfO5yxgnkWocG3iOSu5JDluJyzyxpIM hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc6xdw3hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 20:34:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29OIMidB032110;
        Mon, 24 Oct 2022 20:34:33 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6ya7s07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 20:34:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlV74MwZCPbB/h06/qAdhTQ2vTFg3hYis59dF+rbM1wRm+Evy38l8CtahMIuky6Lv9jtlMl01Z1abTcNEhVhvdswW/mSrvZfJKIxfQgy9+4p0kJuudzaC1uddjD32FpxHGMUIzUQZiTauGnA0WLCe47hE9ASCbhRKPGVx3AmcdSsnQFzoBkgUiMlajmWTgQExPbni9fORBzEIGtvuLq/1azCOB1R840a9eAf1kzOJy90AnPiQm3YZ2NAzS+HeLeDLZX1R5cMXM5j9keySSU5kRXmqhbU6MdlqFI4nS04PP+jjYb/0k5NzMywWoWRtUEpOd43DACXI6LBtI0z11ynyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71wRQN4gzMhFn8vn9fIk/q2PpxADx9cDqVlEXUCrtyI=;
 b=VnvnxeYFX+9hzS78arTgLT4Rd8LOMOawRZh/Ea7YQmL5esYg+FEtlOeSuvRax6m+OGIHJ13cq1kQU3cJObjzTNrMMlpz3LJemCRblSj9FMcWhFvyJxmFJ8ibZwOH3Jo+kQfZUD2JwzVTWfalj1P33j42rcPI0D/S7lxKGrh0dpD3iUUKitJUomDRYoCDtWN4IyzV3Cl36a2DaN94XDK/5/irYpJmVbRfv5ZcWNcJQyWtnTMmBSFnDT8Lr80YztJWTemibA/aDZ6IPL1vfolT57J/YgdG4aX0J+9lq2u/+NWWO5OxJpxa/1xKbMBvUBrTKt+iHWYJURk9tI+JGYd5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71wRQN4gzMhFn8vn9fIk/q2PpxADx9cDqVlEXUCrtyI=;
 b=w5XOKa9bFpPqW0bwhukKmxai76w4w/gnYVRIP7DRBHGIEk3+A1u/5lo9HhNlEcb7FyZYJ/O1wytt1LrF17/CUwnIpNW/MS+kFg1f/KzKWD0NFCnFIUVCAXzWvigMEeXFL1YH7lfgnTgOQuvZEsQwMkTM+xKUKVSpBHbUIQc5xpg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB6779.namprd10.prod.outlook.com (2603:10b6:930:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Mon, 24 Oct
 2022 20:34:31 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%5]) with mapi id 15.20.5746.026; Mon, 24 Oct 2022
 20:34:30 +0000
Date:   Mon, 24 Oct 2022 13:34:27 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     syzbot <syzbot+1b27d7a2722eabc2c5d5@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] KASAN: use-after-free Read in hugetlb_fault
Message-ID: <Y1b205IpQEzBwB+T@monkey>
References: <0000000000000eda7a05ebae986e@google.com>
 <000000000000888f9a05ebbad8f3@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000888f9a05ebbad8f3@google.com>
X-ClientProxiedBy: MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: d02667e5-b095-4990-a3d6-08dab5ff26e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZqSOuw+Ys02L9cEk6bWxpk1snoNYcFFroIdmGUqWaM3kYjvlq3SyM2Qo7FEFOGTegO55hdkQ+67A6cs1BZRaeqZbW1w3w5puBkLW0XXr0q/+vXjS9RxpmGCyz6jKFTN45G8MQf54wiLOKM0LVRJ3zkeBt9xG02Ac29+vfep66QwobgGy2HoyzbUlBzkHunF7iLyTBKhFGANILLzlI1wcTfpOl37LAlK13KgIEiYeMJx1CS6Aqh1VqzVaakhGPH24R82IKh1fxeUJt7rNfbZW18QgfF2a+FlLKLC517BPgKIJK6mLOJkIhFApSU/pCxXgqIRBCYJJOR0ZclW+mFtZ8NrviOUo2smnl3APL5iyXlWBSFkAtx/Sh50gkdJC+bYBfezNQX2o7xCAPv/GtiWsswpHX+vyhGj0QjtbTtpnbwZuXR0tmfSPFwceoIHfS6ko9dCOIWUvKWwWG1i1+Ohx1jhohOYLDZChGXzUAVc5ZyKbvl4o0LGEbQejTNtgWBufSqdPaqZl8hZN/nsKRGEJJMNGHEBlZNw9FxZA1QSrkXSZ4ph9Mgw9fd5EB3g+kDwx+A+EojVwhwQZ6dBOaishrt6D7tKd6di2MoyeZvFJ0FbmPSCLZT5NZzqAa81BV5oLnXFi4gt0u2gGCYfMQOOJ/PUOyxzTtaRKiQj7wEUNJ+nFPY2ec2JqC5cBxS7/lkDCCrp7R+GsOcb2BAFMkdC6I6rCBqHYFE3e48keX3hDqJspwbcQZra+p0HfdhJmpNcu2xgLcu2kzNblCSXh5mOmZVHNpGZNNAu3lCwXK7yMFAaEKWpiZejdDvp9MLL1K6vAsiHngsZiGr5DDZkPFQSV50d5r28Mz/xpRdC0BHIP4/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199015)(8676002)(4326008)(83380400001)(38100700002)(6506007)(53546011)(33716001)(86362001)(2906002)(186003)(7416002)(8936002)(44832011)(9686003)(66476007)(66556008)(66946007)(5660300002)(6512007)(966005)(41300700001)(6666004)(6486002)(26005)(478600001)(316002)(99710200001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2AW/hBdsLls4MjF2AQkmOZnLkqL3Jn1bNOgPlL47CSQxsgiGR+7I+Yg7Rfeg?=
 =?us-ascii?Q?jG3rlnWKV9KMlBhUYEky5H6H43AZZCRi2LSOA4S1uC66C/4gkJz5RPO9Sybl?=
 =?us-ascii?Q?o2G0VBStMpp0lBhCRX2va3PvFuOMnisYdxTBWnD2IhZF+xpPhER/8h4jyKTE?=
 =?us-ascii?Q?FiIikg8TBrmZrrWEPKjDQygAVNeMGNxCLWWTPsGL0OgAc7ZU9sD/zFMq/Udm?=
 =?us-ascii?Q?U8G0b6KR4boRtZum2mSN/ydLWNVLvp4e/N51miWkYtVTN09/lidUQBiXGFQO?=
 =?us-ascii?Q?cZlVoOjOgzg06f6bNSslgpm7oUsVcbXog6BKh3vq06iUpfCAi80D97bTR3Q0?=
 =?us-ascii?Q?oazBv86bKKL+mOn+4pwtT1JjKAAJrKRdOzfVlf8As6X7Vv9kri5HUo1uN61+?=
 =?us-ascii?Q?VTCpBkSzo9Rke/nr4EuDRbFHVTYv6+CFlC20CfDaPzHugNjhnme3MQrNqW6x?=
 =?us-ascii?Q?D/pxoVJORJATM0RS7NMJ8zv7HvHz4YQ/6yF2Em2lJUpoxusg7x2oyZ3gtx7H?=
 =?us-ascii?Q?lTC0m5acJH10wmvaJP4OWFOGMJHlvDtAPZ8kFACtEOfx4HxlGqRdkP/OsuWH?=
 =?us-ascii?Q?qZfEGxwwAc4/KKoP8AHElKcpVhCAZIKEDSqoOmVn/ejlmkGXFOUZZ8B3/57d?=
 =?us-ascii?Q?XSKxdtxrQdJoWegaLb7ac/THSWW7Nnfdtnyg37ta6oreEWl1TtHUBHsyCsKu?=
 =?us-ascii?Q?iBZ+4gysiqwjTI9Focj+RSZbCrxnrJ5Y3d48fxTUqNgA8JXbTlLvPWGdTIl6?=
 =?us-ascii?Q?5O4C8D8ZE+/O4jqnQLz7aejgk3P1vjjrqq/EeqwY27T/+lPjn0Ef/DebTOk7?=
 =?us-ascii?Q?PC9NTGZsb2UU87bXoQ75OowOljeLlhnaFCrkWrYRNdFisxZxKsvn21SOXaZK?=
 =?us-ascii?Q?DIJE22RkoXdxUQbwam3P2P1Wkg7Vvp8b8Xqqdxb0Gozg34LHhRqyRaJiPnjZ?=
 =?us-ascii?Q?5FBsULNNVd+/MKAifXXZytaf3DjhSy75Jcq+wutSCyhkgLgCI5ixUdScajw2?=
 =?us-ascii?Q?Hmsl4Areb7JD/PcC/P9AHVQiLXsbddT2mmEjLIU5D/2GusJ121DIIQRR9WWp?=
 =?us-ascii?Q?0jX+8R4NRFyjCOExhmvipzbrmbm9PBdf7bxLaywc3ePSjDcXHTEzXuzFMSzk?=
 =?us-ascii?Q?y6rSzX6M17r2+7zZehPMKjTJDmX4CjWZdI5NPVl9+FjIGF9zskoXjBVZWCDK?=
 =?us-ascii?Q?vi0Lz4vDQ9bihPkEAbmfCzeY/3M4cLch10F6WyBnGVx8HpXMf1dK544lfSgo?=
 =?us-ascii?Q?QGp0GSWI1YzFu4vLGYGTPxYBYBCdYDMHrH9jRgQ0arcOx6GNg1UssdG/EXhG?=
 =?us-ascii?Q?Q2jPE+GCBNN6sASATE5g1G5Brv1UoWv5W/nTYyiIW0VFwMUrzhSoVyp5ay9q?=
 =?us-ascii?Q?5zvAPJxk6hXC5ekILBeCv9WV5eTqMiR6TwjT67Wi/K1W6pN8OQqlQcPN0jvK?=
 =?us-ascii?Q?iMVb33f5k+I/PzD347mgtjZi50DnXVRP4T5XMFs2WnOezvnWZMXkWw626Iww?=
 =?us-ascii?Q?EORmURMdPKwXu0qc6LyzsFT/MrQz/z/qquyUkEXZoJCETG4aXaLKbWIvPirZ?=
 =?us-ascii?Q?6Iq82DE4B9CUug4yXrGSsCdR1+SibdyfMB0t155tod5idfHPjVk2zAteQWTd?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02667e5-b095-4990-a3d6-08dab5ff26e6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 20:34:30.8094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32xzbfM3Jhx67rSfAybqNa/LfOAV3eELnaUjGZEQDjDJsTAVrCHvYQ+ml98TJzvdTPKxO5OmTfRXOQKoDVcrxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_07,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=938 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240123
X-Proofpoint-GUID: 8DCXguu1zgVT6LIrNND4nSDKKTNKke2x
X-Proofpoint-ORIG-GUID: 8DCXguu1zgVT6LIrNND4nSDKKTNKke2x
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/22 15:03, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    4d48f589d294 Add linux-next specific files for 20221021
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=165e09b4880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2c4b7d600a5739a6
> dashboard link: https://syzkaller.appspot.com/bug?extid=1b27d7a2722eabc2c5d5
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1546e96a880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123eabd2880000

Thanks for the reproducer!

> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0c86bd0b39a0/disk-4d48f589.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/074059d37f1f/vmlinux-4d48f589.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1b27d7a2722eabc2c5d5@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:72 [inline]
> BUG: KASAN: use-after-free in atomic_long_read include/linux/atomic/atomic-instrumented.h:1265 [inline]
> BUG: KASAN: use-after-free in is_rwsem_reader_owned kernel/locking/rwsem.c:193 [inline]
> BUG: KASAN: use-after-free in __down_read_common kernel/locking/rwsem.c:1262 [inline]
> BUG: KASAN: use-after-free in __down_read_common kernel/locking/rwsem.c:1255 [inline]
> BUG: KASAN: use-after-free in __down_read kernel/locking/rwsem.c:1269 [inline]
> BUG: KASAN: use-after-free in down_read+0x1d3/0x450 kernel/locking/rwsem.c:1511
> Read of size 8 at addr ffff88801263a508 by task syz-executor409/3698

Verified this is indeed addressed with,
https://lore.kernel.org/linux-mm/20221023025047.470646-1-mike.kravetz@oracle.com/
-- 
Mike Kravetz
