Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2056646138
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLGSic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiLGSi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:38:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC92A419BB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 10:38:26 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7GAsR6010147;
        Wed, 7 Dec 2022 18:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=3A4QlwfpZ2bJhY9y+0833AhQcQZ6BPEH4hAdJhCPzkk=;
 b=o1DVLzGQZz9OZI1CBL4JPiEYzdJIM1jA5W1AWwYDS1oR+pwJNJeTALYTDwE0Bq1/d3Pw
 XarPbHJxfQMa8p9BVxd01WIgQVkVhTLlw41OtGIRXA0xyUg5xTG7pCRtzLSgLjqVFKQv
 uQTdtJZZJPKy9MEMUphx9igO3ARPX826cwBfRZTnzjjqvyNJquPRQy1MNgKXP2BHXX7n
 CLNccQzImmkCirEBJPXpHRhhdXQuiHuO9ihLYSNdjpC7u1Lna4C0o/y+kEA6soqXGHXO
 5cRn3F1xv54ySBKPmmcNtSlRniG2Ar7J/dFLpYWi1prgLV2FsdVGw/cALxflabEF4j3D AQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maujkh0pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 18:38:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7HXC1Y015963;
        Wed, 7 Dec 2022 18:38:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa4qg3dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 18:38:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqoS4LfuRAyeZxbgnjU2iTyXAA/KCK1pVaiz+YsE1cjGxwCayWmi/8jONieip1QHMqO6ZT6Ap1+W5qkOYa7hz9/f+In1TIb4T65jbIrt8KNjxMRZLx5Z+BD9bcCMp6M9DJm7N19BP0yEA72ru6LJZQy+8IB8Z4XCxrqbqzBUtj3L9O6f5dIzbJE3rETEcEtgvcti2alx9Z8PJ56yMwpngSezO4BRdt6YBOrDepXTjhliy7g+I9pYPb7jHqHaAWGZmcGreLIi9sp1QljfoS/mzZ3P2J3ZzUhSFLGshssMfQUK3AxtSFBD5li7rhzYP+hRBu9e8MeJff7RDJgg6WNnIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A4QlwfpZ2bJhY9y+0833AhQcQZ6BPEH4hAdJhCPzkk=;
 b=kvAfxMUVmWjga5osbg4IFu3P+3/PkkYMpI3q1F4Pjfixt3qMUrk2rJLLHXcu8rFEOhcpJkKL7k4jcJ+EJOLt0OFENeb7DybQyzuq0TcmfwlvpYXPszbAxB5U6G/hRBC/IjFcRQTRew8BKGhM6EhJENGbq4QPNYHrbOw1osEEt8DiCVrZgCWHBbiNlhuh2Eq9pgxTtKGZXGHWGs52qKiQaqArw/FvWK+hVI/zkZgZ+bU6GsDUbvPYFqP72bIR6gHp8ZEcEs01cnHFhqUz13go6XP+UUZsbfyftrt/VxFKGyDBVs4vzBwxVGRyqUI6T+kHat6PGS0xzVaKAvaJFToG0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A4QlwfpZ2bJhY9y+0833AhQcQZ6BPEH4hAdJhCPzkk=;
 b=X/ver1sMwS+34LdcjnxY9EU3vRZF77ZrgFmJLYeUv+BJx18METK4HKsWW2j9lz+MSTawtq5qnKUJai1AGh4Nxa+VCMcm8aOUlRbMprecsP0akqidAY2tkXc0rAm1tAjRF4kyCIasAXmTZ9UnyiHxjN4g+SQD2I+CaidzG7B0N/g=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB4923.namprd10.prod.outlook.com (2603:10b6:610:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 18:38:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 18:38:05 +0000
Date:   Wed, 7 Dec 2022 10:38:02 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        hughd@google.com, tsahu@linux.ibm.com, jhubbard@nvidia.com,
        david@redhat.com
Subject: Re: [PATCH mm-unstable v5 06/10] mm/hugetlb: convert
 add_hugetlb_page() to folios and add hugetlb_cma_folio()
Message-ID: <Y5DditEBlPNnD/by@monkey>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-7-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129225039.82257-7-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR04CA0387.namprd04.prod.outlook.com
 (2603:10b6:303:81::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH0PR10MB4923:EE_
X-MS-Office365-Filtering-Correlation-Id: af4dddf8-879b-4333-534d-08dad8822dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ektuvm2vDDM/UbNDW74+5nDhogDE7crEeJIPPxUyQLsYeNokICxpf7nMpAdS6AX8b4gXAgP148NRVEnKE5lQv5II2qEEu3vx9yeJ3CbueCkYrK8jgSDIpR9wwu2hodUR4j5icyFJckmkdP3DbUJ1FkdjFAGgzN+yfdObLWt5DkNK/A5/ju74Us0vhPMOkYOoIF7F5ouQtqlAuLIJuvF3qkYL2uOmtgv6UNbz/s9Fru+KuZebF20j4Ah7VuPzn/VCpue/xkWoix/dd1jEaWsDAsBAcRV0hugJKu44h7aIfxr4uFhvC8SBFKJLzrfgNZVElupQAv2m1SAjAaIaobP9EydwjJ2HDPMVnBM61eJ4MiPxXEgNBPCgqqhONY1wUxWT/Bk6LGfbkC2BpT9kBKPGeUwHwVv4P1SItQ+kF6jT/TpIhxYwk8OCG/k/UXLd/Docp5g9Np0G8GHO74tENhQROGKZQ6iSgiA/pXchsaD/1GR090zeLNIe0JLql5bRuA4Zj/Jj5AGoxp9R6/3JosOMG+pvIRzoZjPhudfup0Oxa/ZpRscCSMc+uQ7rCty5lkbJMa58aoBipniPcViHKoteqn5n5uuf8nlzCd30J8TKDvogmKVI+UXqi7Ks8aeAkwQ0/2vmXseVOR1IvYse1yEGAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199015)(83380400001)(33716001)(6506007)(6512007)(2906002)(86362001)(186003)(26005)(6636002)(41300700001)(4744005)(44832011)(316002)(53546011)(5660300002)(7416002)(8936002)(6862004)(9686003)(66946007)(66556008)(66476007)(6486002)(478600001)(4326008)(8676002)(6666004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g7EFNTTXiTTnFWOEmbIlhfsLpQNhvqNp1WFITfR0LfboiPjuli5Vuj6ll8Pj?=
 =?us-ascii?Q?bxaN+DcUClpCCAZb46hVXLdDDAjrfMCcGeaYcwI1sMt+AgPkh0FAaPn/kwZk?=
 =?us-ascii?Q?E4ls6SDSpOCydYnKFwLgIMn83H0GqAeNg7Mw9cjyoZqgUwMKVRAPipxbIMap?=
 =?us-ascii?Q?WjcfjC6cPoRa2d6ClVvVPOf8sRBcM7GbmLm5qGOIYMN0tLK6xeRaUJQcdSz6?=
 =?us-ascii?Q?Kwq+5uI89JrSISrNmPwBPHZydLgwGC5ESZoVRpf+cac2ugfx+pEvfXnUqGJR?=
 =?us-ascii?Q?6ieAP7HfFA0ClV80reXnXxgp8XAT/L74sEMWgsuBM26QrT6XZFMU2KqG53Go?=
 =?us-ascii?Q?ZUVs7Rejw4RD9xo2feXxyyBD6YCumQL7RDZhxpUSXwr6DY132EY5oQeFVMtO?=
 =?us-ascii?Q?RLvFr5MDL1JyiB40kTZ470KUpWjbnAGdPNsVZczIJsZEeZrnTfWMEKUcY6zx?=
 =?us-ascii?Q?IPtIiF6Hw0BtEjC87qRc/4Oc2ATtCGwDSpFlDlanGhghoJm9VZXHvvvVEesx?=
 =?us-ascii?Q?9DX+tzvxXTqVyI5/KNF4GydImmap4S/dxpuwrBOKpWWhh5R/Jo8T/0JPMYH+?=
 =?us-ascii?Q?mL/vtMu5ztb3TN7NCYOjnWyAAGS2UVJmdR84HHr8mDbuegioSVX4UGz7pZqN?=
 =?us-ascii?Q?K+NVej+xSUjSbiXuI6kVwcJ2676tVL7Q7agfeNbywa+589AS+EKa7572pRus?=
 =?us-ascii?Q?s+iXJwU8SIRPmrGtx6NvLSkXJ/vfwvcDfW+2O7bw0TUdISL3l1LI77Tfo7Ze?=
 =?us-ascii?Q?7Ps8QgAe4FhXqYhDq9KCiUdqxhU2BZ8+ZUP1Q4BwtvUP7Q2HVPTMBV9CzwzR?=
 =?us-ascii?Q?isu2WhePNw3NfedQXCEHucA+FnTvc9WCyAtpbaUzv1ulw0TV3MLy8mExvPrd?=
 =?us-ascii?Q?MiOUsFHJ49vejaodB2lrwN3FOyiLCOD47/QRJSjV/yacRAk/rmzW0sX5YbJO?=
 =?us-ascii?Q?klodXwT/MSrkgsaHbRjmamnOH0fZbkpdK5CNc9A8tYt4oWL1QPF9sXu/gbwQ?=
 =?us-ascii?Q?/kX9MFgMZIDrjoCN3VIWbyzlhuYZl1Q3HtNFUCXODoJwzj0TqwQE0GMS38H0?=
 =?us-ascii?Q?2/Pj0YOKcCf87qp5Ponowgsdli5+Tw894ma8KguL8ytr7RsikyX94nfrpPM1?=
 =?us-ascii?Q?88R9cj47nMb6aKMGrB6FQlQ/UMtqEysAg5KX3WOr7h7QMu9b1/l0Mwzj6J4D?=
 =?us-ascii?Q?vIpxlER/P2I6/wbsUeRGZqxuMKKmUHQ+yxkNSID/0CPcEvvtU1BwbAAeLsNR?=
 =?us-ascii?Q?Z3xEAJGMOENhCP70Jh+GP6r6N5h+djeD5N5LaZkW6Lkcwc8bmiF2pcnr6k2E?=
 =?us-ascii?Q?DzYjwihKCh2J8uoR+ZqNiE5Pe0TQorYu+t6FETdbTgiSpKyMddLgIGwVW/CE?=
 =?us-ascii?Q?OQLz39EEPBcOYylK6yuMYfNQmePw3a3X4H75zZ1gqQhLo6kOnA9P14iTzjq5?=
 =?us-ascii?Q?PoM+5ve8HEPzcq5uY0dNcLXsBk5hE1C0SNhCOR78E6/lhj127cIomIYHqQfV?=
 =?us-ascii?Q?6b8aQwrtUhix2drGI92jJkFfdhoSL8SR/6/pA8g4AtesT+IlnLnl0sSKWUzt?=
 =?us-ascii?Q?Xp/jHjfQVAoRtMGwr4Z0eWcYZhHHWfKPEkNpHHF+mPf4IHPMywZtmL2annnL?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4dddf8-879b-4333-534d-08dad8822dce
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 18:38:05.5159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGMrvfv361iQSg7OLZwtBLoUKg2DOyZkLemZUo1wZKLUFuy+fbhF8fTS3vifluBwuZwlWwc0q+ztvjSZAYBDtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4923
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_09,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070158
X-Proofpoint-ORIG-GUID: tDzfVSoVOHWBEqVnc2cbbN1CNtaIaj75
X-Proofpoint-GUID: tDzfVSoVOHWBEqVnc2cbbN1CNtaIaj75
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 14:50, Sidhartha Kumar wrote:
> Convert add_hugetlb_page() to take in a folio, also convert
> hugetlb_cma_page() to take in a folio.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/hugetlb.c | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
