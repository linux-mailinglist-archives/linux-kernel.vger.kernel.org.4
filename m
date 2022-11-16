Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CDE62B09A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 02:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiKPBhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 20:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKPBhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 20:37:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154BC240B0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 17:37:49 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFME2Y0032591;
        Wed, 16 Nov 2022 01:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Ztyi1RGlK+uLaz0jr0oo21v/9Uq3WLzQ06LZjrzQ5fQ=;
 b=ln/GdQgnxk2LXPJO2Rz3FczOourLDJ8BcAWk7yAxQTO7afjl74HEWHgjP+zuoxPDaY8X
 TMNLtywCSP4uGAFg/ctSD3BzFw4B2xWK93JJPnx4WLtP4qBEUmnj6g10//eZVi/qcDhp
 MzyeNNU32xI5pEoRu0d2eYY/w3Qhb5IW+Q6hNtM82ArgoR0AK/uut59J3LztJUtaSGeB
 k6/R4GI980eZQUpfpIl5d3ciVH+MZtFTVD2844rofD0GcirTCyPN5x7Rireo9/HVqo6Q
 /m6RHRToodrpspxbj3cPGWUTf1DV+BauUdf3u65tJ4fz80S9svKo1ToVchieibfwygzJ hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3jskdxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 01:37:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AG1O8pj004752;
        Wed, 16 Nov 2022 01:37:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3k7g325-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 01:37:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADAf7/cTgiok1KT35RQo9Bb13c5+rlHT4NIe42FngmF2Sy/725fWpsrZoG2cGWGopApz/yd0RFhJKU1jFBC6HSVToaEYUMfgEVf7BwB+o0JmwqRiiOqLe8F2zOvuADeCI14j/rXXHjT1csnkfzLHCZAuFqbbIN66Z9V+f45+AYpkZYxcRKUhcubiINSvVFm5dPaA/nWzqrUMhD+FKY+tn4FITImHbaihjCU0QBDKeutmj8BoQ5XgY1eW6OOcW1L9A3FrvI3fODF/H1JTSlDonTCFSlnLlyNhCXTu6HHap614qg2/I8lslNfDxx5xQJUrGSGPiljQ9hAq1nygCzlfww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ztyi1RGlK+uLaz0jr0oo21v/9Uq3WLzQ06LZjrzQ5fQ=;
 b=mr8Eaoh1XOx6Twm/0/pt3JmdRtaGED4ZF1b05tzuKLOZT43vSoBErjW1BecIHRs07btW6sFNXhB1c+vDBgyr19HPg5xETVve48iqM3N5QEGdRrxVFM0MZxWqDmJqoycePKuV/4/+pZyU7Jo/Mnhx8H3F+E53wAZHdtkzuivsbEEzYnL7Z8fZJ6yGgPzOWKTsfKWiSVaC3eUEpsHHKolku0lWL9RE2OvHLXoSJhxnc2rxC0C/BmMvjDtMMtruhPSyg4ZXERd4tEabmbHjvbx1Mc6DmkQ7vmT908oQfsTnsuuqLWDyB7yXPokcH4tFVxpnlq4PjBxwA0ucsrNM2cQ44A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ztyi1RGlK+uLaz0jr0oo21v/9Uq3WLzQ06LZjrzQ5fQ=;
 b=wUQ1XUfZkt+9k4cTQ2SYQs9bWOtLb6RfLXwNGeYZJicTISF3SMuth6Epk0I7raA7qCWTXzez9BbiujNULqqlrWwBVW90tPmDqKzntYcaEmorWHfN/YdELlmV2FTCUPr1tj5q64XH6FHs4wLkj4R3yUE8Hjz0XHO9znVsIJbNWqc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO6PR10MB5636.namprd10.prod.outlook.com (2603:10b6:303:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 01:37:15 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 01:37:15 +0000
Date:   Tue, 15 Nov 2022 17:37:12 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Nelson <doug.nelson@intel.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [ipc/shm]  da74b30c77:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <Y3Q+yAvwfseNPuD9@monkey>
References: <202211151618.9fcf9eca-oliver.sang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211151618.9fcf9eca-oliver.sang@intel.com>
X-ClientProxiedBy: MW4P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO6PR10MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: fec49e77-fe06-4a5a-f373-08dac7731716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ee6DaLRw0UzA1QNy3FvQkhgNnlBDTjFsICTvMTSeex2SG1slTccSG6AmEaCG/CZoGJFNLGZYPhToe0ATY7mowUBpH2g/3f3zqxssHB2T7R5mq2JnzGdABV6jD/kNamLCZe8YvdcXD0d0JqyZj+JMn0cEY0UkeSVwX7xpY1ptD0CKmSSjrQFSlKbgkj6J+PXtS/7CwrdPyBaTppjGjON2Go0xhm2UYePEmuMGYNaMlUH0E9n4qt8h1pF6kfFbVkhYrRBRLs+/Usuj9Y9hAufYp/lagZxfxeV1pMrb3rZHPCC9vtJTTZKiLDsRhMplxso4t959dj5NOxjRpJD3YeY1errS7oc3PYN2QfFTiCz2NdoGCl7xgRjXrn/QxATRrXNKSJ+fQHIrCyEHllIgCwgAQtaZUdIAtRZL96ByGleeqwF/pFuRELQ9h9PgWTeqfEu0OUBlQQavT5Brb48+g+MocQ1cKX/55k1qxcOivGFIsJprVVV+mTKpxjgs7Wr3IVdZXyVJRZlaJ59GHhe1Z23ZuuK5kqsOlc+92E0Xh0gdAQirIsJ53ySbvLRYn2kPXgLdTf/27tCUBPcBwA0+g93uD8T5hz0CseqijskWj0Le4uuK3mhZjQrwE8JRTWtVPn6vi9ilwrzO4ZnarLcJ7ByOcZoNGEwjw3FqwOd39AxEyGbmc5eoTDv+knrqH3N+sktvzg4wE1/DVpPpKY7TArce3Ht3lpQXp4x9W3Tpk414K7UsK/W7NXyP/gzWK1Nie+bUHXbrGmvNGbMl/+92+JfTpsL5InCn8hQxAvxh0XVVmpo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(38100700002)(86362001)(8676002)(966005)(6486002)(66476007)(66556008)(66946007)(33716001)(316002)(6916009)(44832011)(54906003)(2906002)(41300700001)(7416002)(8936002)(5660300002)(83380400001)(4326008)(6512007)(478600001)(4744005)(53546011)(186003)(26005)(9686003)(6666004)(6506007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wJOA0U2l4xgiGj6uSfIXC3kFqMC/iANE0MInPQRIl8Dt24vOMcIvdL1kxBiL?=
 =?us-ascii?Q?CWnrsTQcofpWdQ/xtpd24mJEkrfiSKLy/P3Nhc4jBk7VU/hwurW4emVWFyn2?=
 =?us-ascii?Q?yQs1jrU7w3Tr94f85pp3SmZNnB7p2RfiNbDeYpw0+Q77UQor9JRsNUc1ThQG?=
 =?us-ascii?Q?Zzp/JX1ljQSBAmlRXXFNG11fdGSdDi9E79YKbta4bE9mAi7Dk+u1wobceHGN?=
 =?us-ascii?Q?qsG8Dl8/JN34a2wIkt+1Ah4DP58UXZhCtYMYTf1MNSIc5D+zbxUP3q+w8mML?=
 =?us-ascii?Q?oBByUV53xhyNTvmLj+sC/41DEtc1ZbK3ib1lVjDC0mtEPbbElVe/WDIHIuUc?=
 =?us-ascii?Q?jFGTXJl/5g8rB3xqGzN15GWH236jPWOErE2MCRuy12+BX8RoMXAvKJfgkNCQ?=
 =?us-ascii?Q?OoKbrUXhqH/KnfS+93Y5SZMQYE3P5XcbBDzvLxWjjU9fsjxkHE6WkuWmhvGx?=
 =?us-ascii?Q?t4hwFHwaH42azzd3K9PsVp+nZHGGaZcz1Hdo6BzuoKa/MeU4DW20wQsngpMO?=
 =?us-ascii?Q?eNW1/MC+YiqAcAcNXvr14S5kTZODoftsobXs3XyWUGyu57ey6EafhnqFXuYo?=
 =?us-ascii?Q?nz+hs317gx13kCI6wxHiv/XXzHmFD8SiQKp4j2TwxQ0E+uYx9tKp25CvLyAf?=
 =?us-ascii?Q?Zlj/b3M2wk+xVFUYeOaahQdcRqCJiAu9oJDZ1YOhzUsTaCff+ERsBT8ASqQF?=
 =?us-ascii?Q?yIP2pg46dt1SwsMfPyML6xs15rrQFy1lFNt0N+PRWlatEcY7yo0BVSEB/P1n?=
 =?us-ascii?Q?C5lX49TQoEbhGQNX1nijHjCYkvThJ19kkb7kCF3JIqFIOTWPS9/9xkbkuCi7?=
 =?us-ascii?Q?Xi+6B00PGBhGEFmOWivkunLSekYIkgzlqbKtGEK7HLssfwbkV9D+D35dzOR4?=
 =?us-ascii?Q?QZCWOOpkunZG3MGMFhoJg59py2FsLzmxX6FrfNDqg0soLLPzfeLVz+56a8yb?=
 =?us-ascii?Q?48xqhOE3vpeQs3fMvUZpfU4Bki6/pdeEaS7QwPUhIHZYQJ/vXBjzXbL5Hio+?=
 =?us-ascii?Q?zQSyyRB9tF/lfnI4tTkECihADxhlaAaAS705RwrcAA4r3zEuqmzxiABtPtNO?=
 =?us-ascii?Q?IevX5JcqZtO/Arr/P2L0Pa5n5wlB6DlUeh+yImCN2bgIpnDaZNU9rlQfCcYB?=
 =?us-ascii?Q?c9Cb1TsXKyAObbU709eFiqXDLAdUVBylc0JSl7Q8qTX51RLeEQ6zoIQVYRS2?=
 =?us-ascii?Q?G985r6rx5+J/T90jB6TrWHO83lpyFfo7OoOMdPyayr9jG7cCS+oYfUP1mLtO?=
 =?us-ascii?Q?nNzRh0TDWebCJujaT7K+ogxqzNl5AVBqN/6ziP42zLTAAph//yoSGCm1EE1b?=
 =?us-ascii?Q?AZtAhTRLND4h9MFe7222ektb/J5+8rfntlVEXSroTfWdH8mwZAUG+dMv4B1w?=
 =?us-ascii?Q?QSpW8HFfl4YZwn2kCu8N4woAieIlx4QEUg01bFciyf8+QuO9sTjjqJyhmKpM?=
 =?us-ascii?Q?IzCiqGucBjDZuqV8qhAn8TlmNbFko+AGGSu9vO+1lEdfHH6L5uRJ8qRzoDqk?=
 =?us-ascii?Q?D3qi4Hgrp+B6/6p5h6zW/szyYDiwZ5DUpIUIaMIw3HVw0mgON2eF/clXNqML?=
 =?us-ascii?Q?V6s9/qOpr9xgDg31fmQYXsshdgvOTeq4eeVGUydrrU0aMopSXXc5p6iQfUYI?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?aItMZBeJ5FbV3DDuXw45vDHytrwO8xZyie1QV859L1Rx8GUAwRVCnme3yWNM?=
 =?us-ascii?Q?zg/7JO9PQ+x2hiuReVQqka9zGGDpuPuWbvqrcDlVlInZkHzeq60xs3vcJHvt?=
 =?us-ascii?Q?fjzSJ+aC26uzmp04Gc/Z9GvYjYsBnOjco88dZEgKCMHsPw4biWOOvg4LLt7z?=
 =?us-ascii?Q?R6s0wlclIOFLXG9ztUg0lqpUmRUAusYb4lf+qBUGAj8qWyfX7BxkxcI4JRQK?=
 =?us-ascii?Q?3ouk/dGJ8NMcY0eoODq/eragCwVGXnkHR8ynjxxyQtCqO9xQjdZF5CxRZ4xd?=
 =?us-ascii?Q?/DwslarhSvZBIDvTZZEgUHNc1ogFkf83h5zU9K0JobDK8J+xez9r0VhgzfeS?=
 =?us-ascii?Q?aN8jj3zlfSG8IlTE6MTNoVjVmidaorkfwxdSHZw9GLqUTW04YRT1NofsBR9S?=
 =?us-ascii?Q?ECJFzv80SRocp5yUKMMh8k5i8NFCkZVAAtms8HR/lxQQBqqe0r5wHrs/Y0sE?=
 =?us-ascii?Q?5Zc0cGvaG7kNNVZRHEKm94kLZDlTsFEXIE4CqiqFz7VaPv/9ZzwaUjxibRXA?=
 =?us-ascii?Q?fZzqFTh8B0k9A3/wFGw6I5xkzFFIdWouPOHjnosFTFv+K1ZMaGJpjIGw7NAb?=
 =?us-ascii?Q?/tWSi2HI7rctQ01/B7yrxRPHzOLWv7igsVrjr7mpjbj+/yeOsJP0yuj1UJag?=
 =?us-ascii?Q?BO2G3bK1NjBP5rqDiB3PPMV5/6NTFaqH1K9oRz4DLoCfOoDAsOUTSoLcXlmy?=
 =?us-ascii?Q?umAfgW7pMK13K0unNgwQqu2nC+heS7z8hVKWjcRJZZTjqwxAU+tK9iMtfIG3?=
 =?us-ascii?Q?YZTRKsCqJnFMi7pagxQv0vlUrMNgwKu9pkfCiQxbAuhYVK7MPRLY3FHKM7XJ?=
 =?us-ascii?Q?yZPRbioy9I8gu5cMKJfQ0Z1gU4EpYKlemayuIM5z/NcyREk7194TIFbcdKKC?=
 =?us-ascii?Q?DhcOJAWLAlDsR7JAPCJmU7aPLPqmmWittAmna5hLm5Bf3ePUNOYMT9Z4sCjO?=
 =?us-ascii?Q?kNjNMh8pqHiUTBA5K7PW3FN7RKLLkhRVuFWyXVk86Zbtwkh5cfspRBwJJpiY?=
 =?us-ascii?Q?qFrtUtbWx2xqVpDcwAFm+w3rwsi72py9WzWKV4GfrZfxmcWWIvVnsE/YgYrI?=
 =?us-ascii?Q?ucY/apCC4N51mIYX4hIkYOOOKu0lFxFbTguAp745wtjU1/OVV72/lJNQbplO?=
 =?us-ascii?Q?mA4Z2cZcf9i6XPYuSJhSE3tQpuEODeUgH+AUG9FUD0w3hjU9KdGWnEY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec49e77-fe06-4a5a-f373-08dac7731716
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 01:37:15.1548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQ0hrxZJjP4zuMxgs64dQGgpyujRLXLPxSe6U0Vpdvt5JIs3P1Hijw7OAn1DsJ/6MO6Yz7GZjIPGzDCmbJgNNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160009
X-Proofpoint-ORIG-GUID: qqjVrBO_QJ_hHLke7xvy8AgP_A8NGKrH
X-Proofpoint-GUID: qqjVrBO_QJ_hHLke7xvy8AgP_A8NGKrH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/22 09:24, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed BUG:kernel_NULL_pointer_dereference,address due to commit (built with gcc-11):
> 
> commit: da74b30c774a4a0c62fc3dc2b95a8a3a34a48c23 ("ipc/shm: call underlying open/close vm_ops")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 

This should be addressed in the updated version of the patch.  Commit
2d68cf69b8421542184b313f9b87ba14fea9fc4e in next-20221115.

-- 
Mike Kravetz
