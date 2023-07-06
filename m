Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFD274A293
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjGFQy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjGFQyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:54:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C03B1996
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 09:54:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366Fwq1x021378;
        Thu, 6 Jul 2023 16:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=6CgbyzWtcI67fJa22leIIGWm9QIEdLW+6568HFbqgzQ=;
 b=JEYhRpkZmthYLV6r2JKWyoKGBL9onYoWlGJQvoYDRnr3M+uaw6hjh8QF+T2OExTt1L+N
 nF44w73sol6OZwSQw4i6EU/DMbzDRCiIwzkh7Yn9JbOW/5K+WzxdzoLAL/qH8gvF3P9S
 A9Ggv/j4WPjj3uyI6cDRlvqc09Ek/vJda2m5Dzi17lsChpqC3RwkWDlqp7vtQ3cbqz3W
 FIvfg87U7COs4j7B8AA/ewt3F9K+uwQwu/EDTrePRvHC6hjDw54lKaCxve2AkxNCpk70
 Itrp4aF47NiLb+4Ct5VQ1O8Bgg7zJh0TO/JSt3ql8EzJiZ7eFUK64FoGnUye38cpyOXg OA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rp05bg8um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 16:54:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 366GgcUL007290;
        Thu, 6 Jul 2023 16:54:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakd9r25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 16:54:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFok3EkFiqyHLp21ZD3uZhXpuvqE5L2mjboF0dLDbV9LCsw6MAQiOmOwgq2NLLzU6UCaEXxz5lUslRxg4Ps070bKURW7Y96BEPy+e8L3OG96t4JitDpcxld25f374EzA+xfWKMiJBslaPd/Jc9xSqmnj209Q1g3Blq31BabG6tGeCMzFST7PhZJi32eC8tS25P0aJm4aabGBED67+7gvHypJWOKjLTCCbNUxh7qu1JdDg16fn6LJNUPhkIUxvNBOYhUyOXi//MYEjWVTvfLffQ2+r5uO5cU7N9pC+fbgH45WOqHLp3jjmoSvVxe/8BRAkvuw0QZ2wYUfHVzlRsFrbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CgbyzWtcI67fJa22leIIGWm9QIEdLW+6568HFbqgzQ=;
 b=Zf2jVsYrwVaqg3ZouE1qXXf4dovs6/itzHnX2S6Tby+SgJSZTJPxYTzWt6dR/wqiJbywJd0LU1oN1p2lQ+2VPc+vJleGPrvhHCzEVNcvO/kqBAYVRgsgubch7SRgpisFv7noCusvsPIFhRu5PqYHNP0SSFcHdK1jAuLIGvvISUxdtXepb6sIM520RYf34/Nc5EC6TPjoh8cwJqqp4epV8gDhgl5Y489SLpzPSoKp+i34Dvkw3C3lIkhVhA/3z6RoZdzddZawybCgXiEljynFm2GqXbfblrolfRndrXDeW3KGAvwe5/WHSkBkTHikJf4sIRkLdPFWJbDj55BBYBhvNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CgbyzWtcI67fJa22leIIGWm9QIEdLW+6568HFbqgzQ=;
 b=cPiHjN4mbaH5XZ5L9QnR/5yKP5T1Q4CZkQC8FoHN/QJRZyCbAmutRo/5/e5AnISNJzKONkjOrfaBJM4XwlP5bnYPfBTUQEtsYNmzntJBnQDdzGFyh+F78ThboTfrVmTxB0LmRMRU//8aov/CpUZOg8yDSEB+YBxbpGRdOWuK+8w=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4568.namprd10.prod.outlook.com (2603:10b6:510:41::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 16:54:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 16:54:29 +0000
Date:   Thu, 6 Jul 2023 12:54:26 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     syzbot <syzbot+ca8f1ca3255d1bac5f2f@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in mas_next_slot
Message-ID: <20230706165426.jgwc7s5wolxbbskf@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        syzbot <syzbot+ca8f1ca3255d1bac5f2f@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
References: <00000000000086040605ffcb2856@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000086040605ffcb2856@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1P288CA0023.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::36)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4568:EE_
X-MS-Office365-Filtering-Correlation-Id: 4473525d-d715-4ee6-fc1b-08db7e41a9b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HnQKYNd+rqEwK73JtVIDUFEMuyxkrmrhEt9/pSO9gH+F3+pXKWyzYoEXiWxx318psNdYek1ylYCnVN9TLlYVnBOcu3ncw1XmXQxaE8uYGEzfwnMyBNDMzq3vjnhgXskdRUZYuuAZQ07VythSlYUvS54LaLMQhVJJ964EzTG3LPgt11eKoxFAssg1SUhp8BDqHH7lg+bOznF28sA9GhbT6NdP7nVwlwRbafkMG7sgU2yC301q3H+wR2wax66ylxD/a5dqpPPmjO2qyLtGgAtn3cWU4KpHXOqz2q8T4UHNBt58ssF1HbGB3DT0C/ML3kqeIqKpRF6LXp7kRg3nB8Q4aXwFNYd8PaFxlXXRTe3clGtrlptwZYMyDYdOyB271iVE4e4GjMDApkQje/DQBpMx4VXlMuebPwpcCPdrDgmVmR+acRr2rDRtPjwf20aPvzszkg17RiYo5eNUDN+3HcltqePnAACx+o9EuvODNqGpy/1RBchpuyXuKJ82kRYO1j0IODEPiYEU5Kal08WyKUr5BSFJv4hXwv+AAe9DZ8htksQ3IF/TYLLbmRSyL1PTRbmIGGtjo6YyOtzEygZbT7+nBE+7ArXXyQDtg9yyH7nblTkqvx6+59dj8wt2PSvMtX8BSzsxgaR8N4ULEpE4J5g1oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199021)(30864003)(6506007)(1076003)(38100700002)(66556008)(26005)(186003)(66476007)(6512007)(66946007)(9686003)(4326008)(966005)(316002)(478600001)(41300700001)(6666004)(2906002)(33716001)(6486002)(8936002)(8676002)(5660300002)(86362001)(83380400001)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VydaABE+oqgS/fkZB95G8XWi7DaeWV0eSruj6NjlQ1HLkqBR5oa/+3ur4RYo?=
 =?us-ascii?Q?5+BNgPr/0jpxvspkmz2HSc4LieIZF26K+ANRp2CNvAH9qMDMKtUInn6CnAFx?=
 =?us-ascii?Q?L62PcacPKm8n0ZrNmdCFSEl8ZwFuMsRTsurNDop+k3uOr88mARjCmiSi3qJ1?=
 =?us-ascii?Q?TtrZfiXqSdhcJf0Vn4wfB7nbz4pw6PJrshvlzcPB3g9mAirJXGJxIF5TqAEQ?=
 =?us-ascii?Q?Rs3lzc4oXVg8mO85qUeUPOT1k9kMdUChs7L03YQZAN0J7Z52xUss6qyQaohg?=
 =?us-ascii?Q?whzg3FTlFcwjQOi2u/Udgq7/ZP1w/ghb0kS2SJ7r2Kv3I6mNJf0RxZrGPYst?=
 =?us-ascii?Q?aQ+V+SYW9EILQBz/NgnvlP9wF26vVP77qxKVKC0hiJ9QbxzGAjqzlPpao1q2?=
 =?us-ascii?Q?9h096RIdV+6SmHD580kUpJQRV0ly2td1bS+d03qm+28YDjFR5/rrVBbLe/46?=
 =?us-ascii?Q?xAALXrPsK7lU47RXHL4yNcOep3DM2Xpp2F2WXM8yNsjfdqxXntpKUP8VFnKC?=
 =?us-ascii?Q?m2P3KNql3w3zX2vp15MuTMacJWBQQg6aXCNV+vc4vJhOan01oVGrZG7GxE1G?=
 =?us-ascii?Q?R7enNF/xa0xuFh2bhjmoSlMMAaPpF2ajMIFCzSJ9I9akKhvOV6s1ujEcp3Ru?=
 =?us-ascii?Q?SLNsaTnQe/lmcHCydyNzUGRHQLJlbKWRB0aFSjCWsA/0QF+42nHLKIhBhP1p?=
 =?us-ascii?Q?eAlE9X1rowgV4yMw68jeWpTM9970uJrER8LE5mGSlZUoZmJiex1qUJ8jdQlR?=
 =?us-ascii?Q?O3xtXq9b7VCMkMkChGXtCKq8yqG4Q7wF8CU01FJeDYZeG3+IymeaKqkuYmrg?=
 =?us-ascii?Q?JdeFmrR3xGVfk7Nb4mpKJSWdfHgqNM6EuE2Gu2o/qS4yzZMujAuavIqLLYYG?=
 =?us-ascii?Q?uJz0E8DWPwB661aMnthpVxVNzXcTfcOVszIdS86AFWeM8QlI+ByRKwcKzfMg?=
 =?us-ascii?Q?M3JlVTLwsSbTeSMCLHNrPqhR6Ou/7fdq7nZGUhYwI+U0/PHnodRTYN5THD08?=
 =?us-ascii?Q?+v7i2r4EpNTM7KSoKvaMdN602w7B6PeyacoSprOQ9L1tctQVtXYhaKX4Vny0?=
 =?us-ascii?Q?6dGOcQl74XV9FFXPk22uST1pBfa4cMiwT34BkZiXQWaq9fVAkXjIowWhtWz2?=
 =?us-ascii?Q?lS0bnva8pPtOU/aAc9pLN+2dyt9arHBYM3FjDgEp+xplbC+i3fORGADydTX9?=
 =?us-ascii?Q?iFm9drOuCNmI3qiNBWZdR5ndmzqPRa0UXtgLzb9sFjoTIX2RO5eUc9p7+tVD?=
 =?us-ascii?Q?z4mQkly3i05Pr5tzWaA9/dledVSbV2mrk4FyaBEtyka8VMWWz2NOJeN6x6xK?=
 =?us-ascii?Q?vK4qVigNpZ9itxnzi6l0XTDpnrspgvn4WrPYEnbbamFTgCDbhxmXCbk1UVNm?=
 =?us-ascii?Q?w7OPftkcF99WgT6U6Ks2jpJybmZg/TzpIBdzZTWD7nZL4ulNxixuhmgDhhMD?=
 =?us-ascii?Q?kD+x6V9h4smpL1abkusmr7cxQC0gSgiVbemIkfL/398kAEF22pfl94qyxX29?=
 =?us-ascii?Q?BzUYR4JlTJOAHiGDJ05SEw6JY8J8HzStlrxp7jc5aO6ZN08tA+3VPikV/30q?=
 =?us-ascii?Q?/oxiFkFXUlR2I+44Z/aW92KVaqRsPMoSk203u3rvpWN5s8tr4f35cU7zEjoD?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vHks49OpVV0pPxGcAmkpGhZtEqZQM4ktWILz+LXS/chg2HL0/4O8UtIjEwEz?=
 =?us-ascii?Q?vdX/TcHkWhgZGDBe6Z86Z0tu7fqkuB7nLVQIUnexKJmfvzzM0syaR7D6TQMQ?=
 =?us-ascii?Q?Ux3IuO25Sgc/uKukuD7ECs6N/E4Bx/6k2/x5u8yxGEVKUz0qWeXyVI+Y/L+S?=
 =?us-ascii?Q?rq9fhsaMOYgj+BjHrAtO+GKxpuOkN1Y7Y7O+IUCfZ5+kGxkld1KH1Wc5YHsF?=
 =?us-ascii?Q?yFOeXORGxZoG6/jrfN5rhHXrkEukBuOch0/CFxovvVYRutSwdXdAaSz/VTAf?=
 =?us-ascii?Q?+HS7O2HmNCl7xlvGUIdWZjYe59jv2/z7wAFj6Y7xiUeh/OMOh445jOrciMGM?=
 =?us-ascii?Q?/8x6KIli6vdK4OFIkxHD6hLQKVoJm6ZF5WQE1F3E5NsVNK39ENuNrOJB86+s?=
 =?us-ascii?Q?Yd61f9sQA7rGrWHaZgpB0b8IRjW2W/nHDFh8oPgGPfj5zq8p6GblIC12Q0Yx?=
 =?us-ascii?Q?MvBClzfPrYqyXzAkwhjGRymVZ5zMgbrJi5WEpndZvNGuwzx+11W+m0OAvEuU?=
 =?us-ascii?Q?fIiiNXFnt2zOMrYBbk8k+CjBnojR5nSijP7e+oPjxg9WS4f+BpmlnrhemfM4?=
 =?us-ascii?Q?5G6xYR+T5oLrIYy6W3a9TH0w7bu3Cdc39SekG2tVUPPwdIgakwY0gS9W1h+y?=
 =?us-ascii?Q?JjT5hSF/Dlo/tVCMNocE174xGF1JCfhdCO7Rchz+50ZrstcRhhnLJ/TbVw/k?=
 =?us-ascii?Q?NMzFMpBUxZoEldqQwDkZnkO2rr0jkGMQg1AYuR7N9y9SpkqxS15kwxH97E7N?=
 =?us-ascii?Q?13JP3ODPA47gs+s4CKX5hBbLpG1/FzWZe+b0X5vJsfHlGQEIpuD3w3F+toTw?=
 =?us-ascii?Q?FqHn/jrek5d4VVjHDlP7b0sQtVf/05HXouIU4OoqwcrOAL6uj5T0HhyKJET1?=
 =?us-ascii?Q?FNJ9dZ5SSVO+dB9JGRKntUKIuNG81Sy4ewdFjpip11TqaLatkte9m6roh5BJ?=
 =?us-ascii?Q?lAyyv3V+2oMyDS/+Cmy/3w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4473525d-d715-4ee6-fc1b-08db7e41a9b1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:54:28.9692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lR/BBhvP7raiQplHniKn5xRbl8/McuJxFpP9DGn3RIhL2URkhSwLAuF1+UI0drIBrQU7lU6HXCompJDzpVft+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4568
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_12,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060153
X-Proofpoint-GUID: xEZ0B2spTO0L8W83sUYO6tz_lkUcxEUw
X-Proofpoint-ORIG-GUID: xEZ0B2spTO0L8W83sUYO6tz_lkUcxEUw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is also a result of the issue on lkml [1].  Should be fixed once
those patches are in tree.

[1] https://lore.kernel.org/lkml/ZKIsoMOT71uwCIZX@xsang-OptiPlex-9020/

* syzbot <syzbot+ca8f1ca3255d1bac5f2f@syzkaller.appspotmail.com> [230706 01:55]:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11f631fca80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d787595a482d6a43
> dashboard link: https://syzkaller.appspot.com/bug?extid=ca8f1ca3255d1bac5f2f
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/35902c43a7c2/disk-a901a356.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/78b3ce875c7d/vmlinux-a901a356.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/150b1474a952/bzImage-a901a356.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ca8f1ca3255d1bac5f2f@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in ma_data_end lib/maple_tree.c:1459 [inline]
> BUG: KASAN: slab-use-after-free in mas_next_slot+0x184/0x960 lib/maple_tree.c:4725
> Read of size 8 at addr ffff88804b9c5078 by task syz-executor.4/27410
> 
> CPU: 1 PID: 27410 Comm: syz-executor.4 Not tainted 6.4.0-syzkaller-10173-ga901a3568fd2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:364 [inline]
>  print_report+0x163/0x540 mm/kasan/report.c:475
>  kasan_report+0x175/0x1b0 mm/kasan/report.c:588
>  ma_data_end lib/maple_tree.c:1459 [inline]
>  mas_next_slot+0x184/0x960 lib/maple_tree.c:4725
>  vma_next include/linux/mm.h:865 [inline]
>  validate_mm+0x3e5/0x500 mm/mmap.c:301
>  do_vmi_align_munmap+0x13b1/0x15c0 mm/mmap.c:2561
>  do_vmi_munmap+0x24d/0x2d0 mm/mmap.c:2619
>  __vm_munmap+0x230/0x450 mm/mmap.c:2899
>  __do_sys_munmap mm/mmap.c:2916 [inline]
>  __se_sys_munmap mm/mmap.c:2913 [inline]
>  __x64_sys_munmap+0x69/0x80 mm/mmap.c:2913
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f1076e8c467
> Code: 00 00 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb 85 66 2e 0f 1f 84 00 00 00 00 00 90 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f1077b1af38 EFLAGS: 00000246 ORIG_RAX: 000000000000000b
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f1076e8c467
> RDX: 0000000000040000 RSI: 0000000000040000 RDI: 00007f106d5bd000
> RBP: 00007f106d5bd000 R08: 0000000000000000 R09: 00000000000004a0
> R10: 0000000000040000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f1077b1afdc R14: 00007f1077b1afe0 R15: 0000000020000582
>  </TASK>
> 
> Allocated by task 27410:
>  kasan_save_stack mm/kasan/common.c:45 [inline]
>  kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
>  __kasan_slab_alloc+0x66/0x70 mm/kasan/common.c:328
>  kasan_slab_alloc include/linux/kasan.h:186 [inline]
>  slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:750
>  slab_alloc_node mm/slub.c:3470 [inline]
>  slab_alloc mm/slub.c:3478 [inline]
>  __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
>  kmem_cache_alloc+0x123/0x300 mm/slub.c:3494
>  mt_alloc_one lib/maple_tree.c:159 [inline]
>  mas_alloc_nodes+0x276/0x800 lib/maple_tree.c:1282
>  mas_node_count_gfp lib/maple_tree.c:1362 [inline]
>  mas_node_count lib/maple_tree.c:1376 [inline]
>  mas_wr_node_store lib/maple_tree.c:4100 [inline]
>  mas_wr_modify+0x1346/0x2290 lib/maple_tree.c:4346
>  mas_store_gfp+0x30d/0x410 lib/maple_tree.c:5506
>  vma_iter_clear_gfp mm/mmap.c:162 [inline]
>  do_vmi_align_munmap+0xfad/0x15c0 mm/mmap.c:2538
>  do_vmi_munmap+0x24d/0x2d0 mm/mmap.c:2619
>  __vm_munmap+0x230/0x450 mm/mmap.c:2899
>  __do_sys_munmap mm/mmap.c:2916 [inline]
>  __se_sys_munmap mm/mmap.c:2913 [inline]
>  __x64_sys_munmap+0x69/0x80 mm/mmap.c:2913
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Freed by task 21:
>  kasan_save_stack mm/kasan/common.c:45 [inline]
>  kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
>  kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:521
>  ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
>  kasan_slab_free include/linux/kasan.h:162 [inline]
>  slab_free_hook mm/slub.c:1792 [inline]
>  slab_free_freelist_hook mm/slub.c:1818 [inline]
>  slab_free mm/slub.c:3801 [inline]
>  kmem_cache_free+0x292/0x500 mm/slub.c:3823
>  rcu_do_batch kernel/rcu/tree.c:2135 [inline]
>  rcu_core+0xaaa/0x1740 kernel/rcu/tree.c:2399
>  __do_softirq+0x2ab/0x908 kernel/softirq.c:553
> 
> Last potentially related work creation:
>  kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
>  __kasan_record_aux_stack+0xad/0xc0 mm/kasan/generic.c:491
>  __call_rcu_common kernel/rcu/tree.c:2649 [inline]
>  call_rcu+0x167/0xa70 kernel/rcu/tree.c:2763
>  mas_wr_node_store lib/maple_tree.c:4151 [inline]
>  mas_wr_modify+0x1aec/0x2290 lib/maple_tree.c:4346
>  mas_store_prealloc+0x313/0x650 lib/maple_tree.c:5529
>  mmap_region+0x1680/0x2310 mm/mmap.c:2811
>  do_mmap+0x8cf/0xf80 mm/mmap.c:1362
>  vm_mmap_pgoff+0x1db/0x410 mm/util.c:543
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> The buggy address belongs to the object at ffff88804b9c5000
>  which belongs to the cache maple_node of size 256
> The buggy address is located 120 bytes inside of
>  freed 256-byte region [ffff88804b9c5000, ffff88804b9c5100)
> 
> The buggy address belongs to the physical page:
> page:ffffea00012e7100 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4b9c4
> head:ffffea00012e7100 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
> page_type: 0xffffffff()
> raw: 00fff00000010200 ffff88801324d000 ffffea0000849c00 dead000000000002
> raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 26971, tgid 26971 (syz-executor.1), ts 924325306641, free_ts 824783195274
>  set_page_owner include/linux/page_owner.h:31 [inline]
>  post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1570
>  prep_new_page mm/page_alloc.c:1577 [inline]
>  get_page_from_freelist+0x31e8/0x3370 mm/page_alloc.c:3221
>  __alloc_pages+0x255/0x670 mm/page_alloc.c:4477
>  alloc_slab_page+0x6a/0x160 mm/slub.c:1862
>  allocate_slab mm/slub.c:2009 [inline]
>  new_slab+0x84/0x2f0 mm/slub.c:2062
>  ___slab_alloc+0xade/0x1100 mm/slub.c:3215
>  __kmem_cache_alloc_bulk mm/slub.c:3966 [inline]
>  kmem_cache_alloc_bulk+0x196/0x4b0 mm/slub.c:4041
>  mt_alloc_bulk lib/maple_tree.c:164 [inline]
>  mas_alloc_nodes+0x3df/0x800 lib/maple_tree.c:1304
>  mas_node_count_gfp lib/maple_tree.c:1362 [inline]
>  mas_preallocate+0x131/0x350 lib/maple_tree.c:5546
>  vma_iter_prealloc mm/internal.h:1032 [inline]
>  vma_expand+0x41b/0x6d0 mm/mmap.c:665
>  mmap_region+0xaed/0x2310 mm/mmap.c:2711
>  do_mmap+0x8cf/0xf80 mm/mmap.c:1362
>  vm_mmap_pgoff+0x1db/0x410 mm/util.c:543
>  ksys_mmap_pgoff+0x4ff/0x6d0 mm/mmap.c:1408
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> page last free stack trace:
>  reset_page_owner include/linux/page_owner.h:24 [inline]
>  free_pages_prepare mm/page_alloc.c:1161 [inline]
>  free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2348
>  free_unref_page+0x37/0x3f0 mm/page_alloc.c:2443
>  __slab_free+0x2f6/0x390 mm/slub.c:3707
>  qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:185
>  kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
>  __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
>  kasan_slab_alloc include/linux/kasan.h:186 [inline]
>  slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:750
>  slab_alloc_node mm/slub.c:3470 [inline]
>  __kmem_cache_alloc_node+0x141/0x270 mm/slub.c:3509
>  kmalloc_node_trace+0x27/0xe0 mm/slab_common.c:1089
>  kmalloc_node include/linux/slab.h:595 [inline]
>  kzalloc_node include/linux/slab.h:711 [inline]
>  __get_vm_area_node+0x125/0x370 mm/vmalloc.c:2588
>  __vmalloc_node_range+0x3df/0x1490 mm/vmalloc.c:3276
>  __vmalloc_node mm/vmalloc.c:3381 [inline]
>  vzalloc+0x79/0x90 mm/vmalloc.c:3454
>  alloc_counters+0xd7/0x760 net/ipv4/netfilter/ip_tables.c:799
>  copy_entries_to_user net/ipv6/netfilter/ip6_tables.c:837 [inline]
>  get_entries net/ipv6/netfilter/ip6_tables.c:1039 [inline]
>  do_ip6t_get_ctl+0xec4/0x18d0 net/ipv6/netfilter/ip6_tables.c:1669
>  nf_getsockopt+0x292/0x2c0 net/netfilter/nf_sockopt.c:116
>  ipv6_getsockopt+0x25d/0x380 net/ipv6/ipv6_sockglue.c:1500
> 
> Memory state around the buggy address:
>  ffff88804b9c4f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88804b9c4f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff88804b9c5000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                                 ^
>  ffff88804b9c5080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88804b9c5100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 
