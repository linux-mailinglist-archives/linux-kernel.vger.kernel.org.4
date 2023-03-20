Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0FF6C1BCA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjCTQfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjCTQex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:34:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C231421287
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:28:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KFwrRj010399;
        Mon, 20 Mar 2023 16:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=uvUkRY8Z7hMLm7nHzyCvvIIfSFPsgzvDK3pE9Qw9ObE=;
 b=SI1Sh8z3RlykdvyLtQhU9wIujTaBfx88D2inhtfgRVElydGoXj0Kmx61Q8n7dfFbCCFd
 mcTu0OiHhSvTuX3JrbwYCZDVw6WzsoCMh4ISGtFoZRqwdDxmpQjkGrmsAa8eNyScqjIv
 zaDCQXmsbNJyhhfrREwkAu4pLZd1f8kP2VrJjtcRpXDpIsSg4isTgmFQQ1A6EPHSibSh
 BcvDMI9FjkxhhCI03XUdAkorFHVRmWhFZdWo1yh7zkrjTGC2P2HSuRodgnPLJ/VBCvh0
 VUPq2mZfojSi4/UwfJyBapCTsLOGw02dFoXvsB95ej9YSMydN6nlDyl0eAp1bFyh2zP6 iA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd433kxw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 16:27:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32KFFMsc006250;
        Mon, 20 Mar 2023 16:27:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r4gq1g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 16:27:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAlhNaPFJX7wVRmHu3JXZOIynIVl+UmR8Uj6EHwkyeaVHzi3RQNFCA+ixU7Pzlx34xIIeUGbycNdouoeuLd66KdKMwq0sz318yftPEqz2PO2q0PJz98/8KK6SIbMBMb7NhQKL+BtgFCMvzKcKyEss4U+Lz2eKaiZ0yXV5mGD1SfgJtRfENBQA09+UyGFvZjbv7Lukp4y76k1UZrNRukiMorJBgoyt5z27rqVBujaEtRAfEACvivNgXkpwwmD5vE7CmFQFa/ZRf8s4f6ih4JuzaTpHMoni1yCzFwfMm/qSMSVIKVKKDHzuwlIlHuwJ9P4sPIid3y7ukCOmgEjfnpvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvUkRY8Z7hMLm7nHzyCvvIIfSFPsgzvDK3pE9Qw9ObE=;
 b=MhCi0IojCr0AOgeLZ7iFj7ThfStvt8JZe3UVy2awd/FhqpAbtFrVIAhFvDS11kaAvw3E7huHTjHeooLldzmkVOBcvntv81hEk90NG9yeAYAN9hJcUXLBfrKpbFV83Zh5lEH6MNEeu2Ow03jJ2OTs9onNlwNaQ+ROYAdf3tbHIYUmwXUwVSdjHaHLLcwucLyD1dK7y84L8jhgjG5YJlkJMNSkuLBRA7ctb7UJsEAeHD4iRndSeMb/zQ7nAli3Z35Jh4/RrHeps0elKQTh8lBKgzJBddbkS2zJmfU3kuqBY8yKl+YrxXlM0YVkcESvfHDjP4m04gnLI/ZZ5DSnzJuJig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvUkRY8Z7hMLm7nHzyCvvIIfSFPsgzvDK3pE9Qw9ObE=;
 b=CEo0QbMXfJTvFnyCLV0BfLZaPNCPq+JDJzBZKSymncosWKvNXqJtnD4S880vfAyJF2gkHWxUXjS8x/NVP3JcWvpC9lfNCBrNlYLHyk7CH0RXOHyVpq30Ezb6rdmrxYgrG8kENLYaKHFs8PjFIeZQ+I+XIFT5wxX+ObqbJITjlj4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4806.namprd10.prod.outlook.com (2603:10b6:510:3a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 16:27:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 16:27:11 +0000
Date:   Mon, 20 Mar 2023 12:27:08 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 2/4] mm/mmap/vma_merge: set next to NULL if not applicable
Message-ID: <20230320162708.xq64y4ig6f3sf747@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, maple-tree@lists.infradead.org
References: <cover.1679137163.git.lstoakes@gmail.com>
 <4d717269303d8a6fe1d837968c252eeb6ff1d7e5.1679137163.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d717269303d8a6fe1d837968c252eeb6ff1d7e5.1679137163.git.lstoakes@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YTBP288CA0023.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::36) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4806:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac13b5f-8495-4f88-3f66-08db295ff4da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qL5+Ey+0/DfPk712j9NZ/d3mo3nAXtzm/ABy0fCzNY2dUveOlNYnCQ2jRE8drCNNZs64RS2F3W9GMYLViOKVqlgeWzabrk3o4JTUaVEZaVym1wA1vWm63VMh7MMz3Eoe9UgyV+qe3XZRIU/3hxgRgYCVGa4a6kpD6+C0Ta+32h7QMzONRZ7jBfwW0lLrFR0gdrVseybgVN4iLNmPXwQHSoOQv+TR0LBQD5inzwKFvvhPTLWLXdxHHEi7f9yn6Ukd2Ys0b099VN9yI2E8zFAiYcRk6Sxp0NrvMqEGDp5FJ4rYsFNUDHrcrv5mDF0sfFK2+TfZWJpLeZ5Vj1T9en70U061tCVt+H77kW9hJA6qjApOSZYGqFebHOZkgcX9W/RmIPoWFLJBylxzKL6fc7WoLSEYuW1rSf9NqjC5gEafxuphB6ivJkrXilC7wJaFDozxQVkclglvWtkchLjCt9xRSVhCrbnTb5FDb1X0Q5AOF15aafhEU72K7PXB7BbTSmbUMAnJuOVonv/puqycXl3NCXNqwpSzvH777Thp26kKxV1OqjEOX1cYK3uVxewbnOuSEBtF4RQVDePfmJqGUwk72brcwpSv/ksspmJDemio1LhIrF7htb6ChKpJdS1V9oKC96t+HYGxezrf+eF1YaUh0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199018)(186003)(6486002)(4326008)(6666004)(83380400001)(478600001)(316002)(66476007)(6916009)(8676002)(66946007)(66556008)(9686003)(6512007)(1076003)(26005)(6506007)(54906003)(41300700001)(5660300002)(8936002)(38100700002)(2906002)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HcCYqbGQIp3q40cAcNVZa6Hn3NfMCzxWt7/ZqYwiCp5dzU/E8QmboyqnU8pf?=
 =?us-ascii?Q?pv2YgyH/KrnlMLwkooHcMPYDdTjQX0EQSjPdokGQnldWRu/u7bplXEo0tW5o?=
 =?us-ascii?Q?ddRtw6i1xvYLPP53YMvLfLlqy/se+LeEyN9tqHzOo1doalk1z7AZE8GOERG+?=
 =?us-ascii?Q?aBckjNNB/laeYEgJ7Mu13f9PnCV8Hg3ScDi5HZIsOFhVpd0svY0OsQYMXNfD?=
 =?us-ascii?Q?ICFlnbEarlbdKVgSii3J7YXBV2IKEBHpiKGngdoPYNshFH/In0J3Zv39q4GZ?=
 =?us-ascii?Q?cMOjA0Bw/Qoq7W065qCIZgT6GT9JthJhE0Oap9mtdm8AtlOHOkRy16xe8G5z?=
 =?us-ascii?Q?3Zl5bQS6QndfTlV5KdzJ8qwy2SpYpvO9OXsTw6t2V6Gjn6oBAhLQiKs4I61M?=
 =?us-ascii?Q?WwTGO79EiW7ZnHb6UhpQ3dYpEHWvZ8GFzlU2vNbKhRgxNRN5RvHPaNCVv0XT?=
 =?us-ascii?Q?eK1oaa7pMW2/VVqXCgtrwL85oqDbhwyKs56kce07Q9jrCKkvehpP69Zd//W3?=
 =?us-ascii?Q?ZSlzqAc0Gzn1ip1tqXl32apL8n4VH28q0RGXF+qVDnhDUfJa+Nj91YZyDzME?=
 =?us-ascii?Q?c70wVuqx3taw0haglCRqfVnKergDuP9eD6eCrWWV9RbZsbObi1BPn3lFcJXa?=
 =?us-ascii?Q?lpmYfrbjDVWqhwWxHfyvCzxuvTeFNlCxytbhtGS2hAd/V6uw2CTzI3oqPI1i?=
 =?us-ascii?Q?M+IHZO8pcgHavUdmMz/Kao2Gyc/HQMmwmvSZCaBFrizVaM6bwKtsWHIxsWiw?=
 =?us-ascii?Q?OLpV2haxgsiT4BrLbsbD09THmzVtixzPetMTvPkubPb5LHEZH2HcGTYTncnD?=
 =?us-ascii?Q?y5hGxAb+oCXisagDJklUvqwxGAsYBsQPyzV6h9Ajg4vCxBN+WF6izEWy0+Ay?=
 =?us-ascii?Q?Vg80B80rXo/wGUksZMCTIjdbWaZRLkK8O4n14oRytICFtWnTtCPuPmw2G4W5?=
 =?us-ascii?Q?mVg/fibhc8cGeTzjGwzzrEzlQnhTp/URvubdLl8o0suKVWGJB85Wets3L1Nb?=
 =?us-ascii?Q?+dRiAbVY3xum7a1dnQLD3hgcgRF+VNlcXzpPTXSAX+D3ypqziGq4/dEBReOL?=
 =?us-ascii?Q?QbUXCOTzv+jczfREqC96eGoW1DV/OG4+C30iuqCeMKRPpgTbjOenggM14XaI?=
 =?us-ascii?Q?tsVOL0ykXkZ30468F8a8vZRiMFGWOj7KJgXJKevybeum5NpleOy679atflJO?=
 =?us-ascii?Q?PdQYT8udIPI2ETKyrOWgqFjYEudXlEAQJqikZ07xFBjZWdRvBB2Y3bm7O8+/?=
 =?us-ascii?Q?c2x+BmTpxZwEAs/xIT+iZKk6SpFEUV+C5I0khezHBMrqOWk7O70KRXN7fWUe?=
 =?us-ascii?Q?wF7CECZ98fNUy4k9rI7K3tY5jg8+3DSzm5uvwkHOaaaqQv/Aj/ubub2PQtKz?=
 =?us-ascii?Q?fumudVr67nzf382DXjRFE/lhfHp8fjoyssWkN/XdE8tKkjJfTJeShV7syQ1u?=
 =?us-ascii?Q?HA2WRNhkfriMSZLBaDEmhUntaxe1tuiv1KDUkj7Kknw34WnFttHLJyja1DN1?=
 =?us-ascii?Q?70VRfpaz4l4QGwetuJmOf0PR9mO3ye6Wt73vXTYyZMbxbGK4qOMe12C5hma7?=
 =?us-ascii?Q?gBWr2Ez+jGH+2pmqywSLk6zRKdM3dzLysKTVPODX3Rze5fhJGNLRLl4c3M/W?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?uGQ8amvLHDpaDCyg1R2+6vZongzyi3xV4Y3QBQlXJMWS80BXQE1n7jPdDaEA?=
 =?us-ascii?Q?L7z2wL+lZnDTMBSrqnYeS2Y/vja8Kl6EmE2s6f33/bfye4ND6XRrcEbYbpLz?=
 =?us-ascii?Q?ezKzscnt1ZTzumphYAqFTwhvx7QhDgNDNh2pTIk2Pjcu80bCPiHJlBxEiVv2?=
 =?us-ascii?Q?ASqqr4dwwC+YEdEEYEYMDI0XiNufxPlewYP/cyh/InjrmKyO4C07RMpet2Jb?=
 =?us-ascii?Q?9z66hsG26SRvOHK/BI19N0AL9fzT0dpgyhy74OV+yTDUP0s7kjsvnglbOyDx?=
 =?us-ascii?Q?BjARW+Y9WNEcFBmMalI04taRpPjE5u3jtovfwhwIp6W5lLaPi89fNhL/fFsS?=
 =?us-ascii?Q?GbD2EjuTOl5M/yFVOargiMz8yO/rRm7HicUIvJbTQkWDEaDV9IfmueSB6t6N?=
 =?us-ascii?Q?5ROSmfOq9G4Z+N2yRriu3qBaah2+CYP7StrF9vgaSdM1qVgm86XIdaylenKR?=
 =?us-ascii?Q?CGgzkc4awLj3+t09kraNJZAaL1QqwXMNqJh/rYGSYHp6AnOHoA7sNQOMRC0g?=
 =?us-ascii?Q?sBM+w9YLQd6enRip/1uR4KaxD6wx63GuLCLTCfzWNkDqjcZCaQGSHp05p/Yd?=
 =?us-ascii?Q?Zd+y6JzamDB/4IdrC1FHY/h+pDh40tEKz2AacUTTvvhkykGZ7gLLnIW23Oel?=
 =?us-ascii?Q?icWZGTxiPJOXwdbpLw9O0jf2fC+i4yPw3zlcfkhVfFkQRcKWOv7tXk2DVlsm?=
 =?us-ascii?Q?oCMqXoJ/Nj2mkXRXUgzP06hvJsqUx+dpxcfBMLh/ELQf+wfaVk8q4ERtARoR?=
 =?us-ascii?Q?3tqjaPX7wEcOjmTqZCYiHHnX3+f4R6p2j488XyI3mDz/c5TwVa58c5Hu1lMo?=
 =?us-ascii?Q?V+38HyayJNSIgzGk9n5tf86FGVt0SXr+rV9+7i5TeQ3xfHGcx4JmKZ1A1/IK?=
 =?us-ascii?Q?xSkeF366TGquokNkKEXXKARl58nYZ9jox9HivFzqiUeBvXCN3f12uYgo0edE?=
 =?us-ascii?Q?Tcmw721Y6YryqiyJWMHlNKT6dUUJ5YxCpoi4ALb1aW1N65SENX2o3BpUDLUy?=
 =?us-ascii?Q?Vr5/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac13b5f-8495-4f88-3f66-08db295ff4da
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 16:27:11.1820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGcI0Kh7RrjyT6V4HCGayiu06s0XQuPr4lb7ihgQM5+p2tu7cvV/rnfx4IJBsm8QgPptXx5p8MuWg1Rsc/y4WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4806
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_13,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 mlxlogscore=679 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200139
X-Proofpoint-ORIG-GUID: K7m-N-zEeK0H6VhQweMcqi68uwuicmR3
X-Proofpoint-GUID: K7m-N-zEeK0H6VhQweMcqi68uwuicmR3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lorenzo Stoakes <lstoakes@gmail.com> [230318 07:15]:
> We are only interested in next if end == next->vm_start (in which case we
> check to see if we can set merge_next), so perform this check alongside
> checking whether curr should be set.
> 
> This groups all of the simple range checks together and establishes the
> invariant that, if prev, curr or next are non-NULL then their positions are
> as expected.
> 
> Additionally, use the abstract 'vma' object to look up the possible curr or
> next VMA in order to avoid any confusion as to what these variables
> represent - now curr and next are assigned once and only once.
> 
> This has no functional impact.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  mm/mmap.c | 61 ++++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 49 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index c9834364ac98..66893fc72e03 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -930,15 +930,53 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	if (vm_flags & VM_SPECIAL)
>  		return NULL;
>  
> -	curr = find_vma(mm, prev ? prev->vm_end : 0);
> -	if (curr && curr->vm_end == end)		/* cases 6, 7, 8 */
> -		next = find_vma(mm, curr->vm_end);
> -	else
> -		next = curr;
> +	/*
> +	 * If there is a previous VMA specified, find the next, otherwise find
> +	 * the first.
> +	 */
> +	vma = find_vma(mm, prev ? prev->vm_end : 0);
> +
> +	/*
> +	 * Does the input range span an existing VMA? If so, we designate this
> +	 * VMA 'curr'. The caller will have ensured that curr->vm_start == addr.
> +	 *
> +	 * Cases 5 - 8.
> +	 */
> +	if (vma && end > vma->vm_start) {
> +		curr = vma;

It might be better to set:
curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);

>  
> -	/* In cases 1 - 4 there's no CCCC vma */
> -	if (curr && end <= curr->vm_start)
> +		/*
> +		 * If the addr - end range spans this VMA entirely, then we
> +		 * check to see if another VMA follows it.
> +		 *
> +		 * If it is _immediately_ adjacent (checked below), then we
> +		 * designate it 'next' (cases 6 - 8).
> +		 */
> +		if (curr->vm_end == end)
> +			vma = find_vma(mm, curr->vm_end);

You can change this to:
next = vma_lookup(mm, curr->vm_end);
Then you don't need to validate below, in this case.

> +		else
> +			/* Case 5. */
> +			vma = NULL;


> +	} else {
> +		/*
> +		 * The addr - end range either spans the end of prev or spans no
> +		 * VMA at all - in either case we dispense with 'curr' and
> +		 * maintain only 'prev' and (possibly) 'next'.

Possibly next here would be:
next = vma_lookup(mm, end);
I think?

> +		 *
> +		 * Cases 1 - 4.
> +		 */
>  		curr = NULL;
> +	}
> +
> +	/*
> +	 * We only actually examine the next VMA if it is immediately adjacent
> +	 * to end which sits either at the end of a hole (cases 1 - 3), PPPP
> +	 * (case 4) or CCCC (cases 6 - 8).
> +	 */
> +	if (vma && end == vma->vm_start)
> +		next = vma;
> +	else
> +		next = NULL;

If I'm correct above, then we can drop this next checking.

>  
>  	/* verify some invariant that must be enforced by the caller */
>  	VM_WARN_ON(prev && addr <= prev->vm_start);
> @@ -959,11 +997,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		}
>  	}
>  	/* Can we merge the successor? */
> -	if (next && end == next->vm_start &&
> -			mpol_equal(policy, vma_policy(next)) &&
> -			can_vma_merge_before(next, vm_flags,
> -					     anon_vma, file, pgoff+pglen,
> -					     vm_userfaultfd_ctx, anon_name)) {
> +	if (next && mpol_equal(policy, vma_policy(next)) &&
> +	    can_vma_merge_before(next, vm_flags,
> +				 anon_vma, file, pgoff+pglen,
> +				 vm_userfaultfd_ctx, anon_name)) {

I think we can keep this chunk with the next = vma_lookup() changes as
well.

>  		merge_next = true;
>  	}
>  
> -- 
> 2.39.2
> 
