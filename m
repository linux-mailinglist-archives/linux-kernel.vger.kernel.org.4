Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A705165C742
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbjACTQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbjACTPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:15:39 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF8F1400B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:14:28 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303G3gJo002797;
        Tue, 3 Jan 2023 19:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=/kLUzpy8UWD32yx8z0cP4ik12sH1LgA9cYld5a4WVYI=;
 b=G7VMgJ1yktF5w6/FaZigM5nvvNkIpOxlPDosRY9EN5S27SLZ3ypa5DJdPkjA6AOPRqPQ
 Un54tFrs8Hv7J6MfkLy9PMRIjEjEVqzbfzugzbdNdDwE6/qmy+dN1VQLPL3G//vltBjJ
 3YbRN34aK6K+zptF8SyIjkKN8TvbtPWjTblj+3uEhYnKa/ukuL3X1e/1ev7sm8GQnBF3
 rlSoHnAvFMwDUtHGuxNZa+Ks76MBrtaJy4E8DgKY7BT4DN3isc1SWOT6edn2RqxFVZIl
 G0v0Ek+YSNBK+R48hD4b3u4zmflKqVAvwOXy+6Vo41uPbf6lBCIdz/nBOXaHCyy+NaHc 5g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcpt4w2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 19:13:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 303IOtmM012258;
        Tue, 3 Jan 2023 19:13:49 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbh58pxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 19:13:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEYXeR96jzAuizs/FKpAhbqmPQ3SaWff47mMJi7bGn3K12qV26Rdc41GFzmKWPWPgnaRWwS1tV5TCA/VS/niS6T9OC9m/faFZVt9JUr8+0KZbrcD4vY94OBZ8+TtC7zmPr1YCLTW9qLRRlw32yMbz/02Xz02m2j1/A/oBiljdaIPp1N7v7nDOiyY/KGVJAP29g1p6NlzJWQPJVgcNvvcXwdGLHiAPR+Ba0wPCzbAREWFMpCKi1hxk3I7bbEDYFYFsplv9MqhQ+wStoB+kJjXD5GpDcHasN8HFSuvwyu6BuibV/zQ7XQuz5J4Z4VCa30wvDhkfk04l0tXJt9paVXCiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kLUzpy8UWD32yx8z0cP4ik12sH1LgA9cYld5a4WVYI=;
 b=iaaIVFisu4zxmkRmRbWm59UWcJ+zY+sQZ98fB2s0JJgmzlqkQ+16IJjRkqh3j27vQQ72e+ZNDO/Mb7W5zjqAZuviFJagXprO1JFoBJGGH41DQf6dE5d27a4+sIQ0wCF9YLaSA8zga5BSfOrCcGnwurNHpAgT00CkUWCA0vXnsf+7tddu4OAfLAeWoN5SJ41JmQRFcuMtSjHXkOFzsDu3VjdvYEzMudnyISF0x/NlDV4CijpnIXZnPeJWGgxMW7HORsZsLySp7HlzNRbk6zfQPjEH3doqzWuGJ59aa/vhV/qAQPAQvfZSdw5ppp1uN3gtudJpGTm7ep+OoBiHnxcFng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kLUzpy8UWD32yx8z0cP4ik12sH1LgA9cYld5a4WVYI=;
 b=UnstgL4IhJaz0NzjYF1tD+Arrg0/7ApcOphT7Czlaso2UzuLMF8fiLhKHjfMQAGiAynDUCWWuOksUIHhu0eaKKmoeV2tcffsdXWVrMJPsCfRaOZlatG+iyAosp2sinlaRHzsux40lgudyQa+NLNfctMf6uaQgTV29OQhXawfkuc=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH3PR10MB7332.namprd10.prod.outlook.com (2603:10b6:610:130::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 19:13:45 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 19:13:45 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, tsahu@linux.ibm.com,
        jhubbard@nvidia.com, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 0/9] continue hugetlb folio conversions
Date:   Tue,  3 Jan 2023 13:13:32 -0600
Message-Id: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR10CA0007.namprd10.prod.outlook.com
 (2603:10b6:610:4c::17) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH3PR10MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 11cc39ce-19d8-497c-7ab6-08daedbea262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xHnVcLgBF5wMu1RVhG9qlDNUfDuKUHjxFNU9R9f4bsarEsdPhHGHmR6BTO7BBRqfKJaum/dHJ71BalbQIj0+FRLWh0ZuawDE7pwb+Ai942n9+ReS72z+2cg+z8/Ny7eYHJJIIygOUyfnQyDLVvLZMifxOD4hbp5J3jreL8oJedpjzdER7KLegzSsm7mFVe0owjr/azZYkHdSmlEEiO1/Ar5hJEQ48oXB8RTVHAN21C9u1EcKcWjJbmggN9azQf19dVg59uVvJK+YAq5fjA4uOmNoyigTxXbszudsPkXX57P5A/PzI5UXou7JKZfM9hDCFlHPTwJl13GE5u1Vw/KwXx8fuJV1g01Q0R4kBqdHA1THHHVYCIL7H/XT3+z9dXSKtXY8QWrXXZ4JCRv/a7KLfg0Jd6vNX4GZH5dApdF4IMVCp0ndBNH+6Md3UhhqzpLAGx4lHvDERpSKqByiZamBrdrDHLmexYElO9iheNC2+duJcR1JABrfvKITeqyrAVZBTlR/UVoPRNNqBDTllknPeWgyPiu9JaEGb/Q9vqhkINdem9gIBcvD9ARsCHZ+N32NHk0oJOlsf8ZgRp0Xid34fZotr7lEjVmKk2sBw+1iGFD+CPiuR9fygO7Sc7mns6P7ihoQZq58zhb+3Xvl9w16YZBgac7+CKjVVKGbMELxda08M/pnAIpzgKhfGvvgKCgmptqCqkWu8GBswGnDKQw2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(5660300002)(2906002)(44832011)(8936002)(8676002)(4326008)(41300700001)(478600001)(316002)(66476007)(66946007)(66556008)(6486002)(107886003)(26005)(6512007)(6506007)(6666004)(83380400001)(1076003)(186003)(38100700002)(2616005)(86362001)(36756003)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mu13IMmfaBP2L4gIsWl2Fk3C/DDvCg2vtajacY5NEnYcpCtVIUilYmVm1RvG?=
 =?us-ascii?Q?oOAmBib2YgZNcgWQo+CL7tJHtalacO8WZAjpTHUKjSLt888hEA+nTCOPX/ZW?=
 =?us-ascii?Q?pjuoTl2z3zoi7hvqE2k1QwkvkXSsFpGHTNivGvnzUvQqtRbjaKm3w/hyQ6NZ?=
 =?us-ascii?Q?z1tDRl/N0pyYnElQjeZX/Ol0pjtrzAQdOYaFaR82WtAY28Dg3LSOX4dNveF4?=
 =?us-ascii?Q?IIsiF1VOoGH3GoqY0Z0TxErZ/VXIhXBGxHIvR6Jg957iqLyfHQlvpPm2x6Zs?=
 =?us-ascii?Q?BVF5SZs7G4ku1dyvT4mc2JQIXS2Sfer9o2hnnhvY+Md8R9O47XNUpfm9bzfx?=
 =?us-ascii?Q?5ZhaiyEDnroAfOkLKWEkw4dNMaM4gqiFokpz2Xkye4XOEudhVnaFaDyoCW84?=
 =?us-ascii?Q?pM0+a9esmnLHLPPcOjy8g7HsOxn8Hrnci2jWgwS0tO9IaKDHgJ0o5HV0aloN?=
 =?us-ascii?Q?MNoCAjNISolstETxvkKB6VenA3fERrwOf90oI76RdNm1BiWVxQYKZO1Prg6H?=
 =?us-ascii?Q?dvngmdJlSDyNmGN+Ttwf/D9nlQTBldvPtHu0B4rYv6SXk+geO0V6FuBqiHbQ?=
 =?us-ascii?Q?SsB9zgFgkYZM3iT32SHskeVC9G53W0yowSGRsseWSvwMhY3VP0KBbT+FrT9F?=
 =?us-ascii?Q?KhKG+6QQkXV79ACji4YxRcleDJkzr+WIh6utqakNCOgZnP9dhe48hH5SAJW4?=
 =?us-ascii?Q?wvRrU1TBN0KJNHzqkRZRVA0WQku2FcFvhcZJIbaZ3a3nhaGN5au3IidJvQXK?=
 =?us-ascii?Q?xHvkrxeDhlVKQNipFlyhee1NBSRIUoNU7lZdDeBLfP2CG9t5QzPSeHdB8A0y?=
 =?us-ascii?Q?Y9ZO7cbQ0eZ2kCR215N42ef7dH/hch50fllKv+eyy2DpbsNfhjTdtyCKgZmX?=
 =?us-ascii?Q?NdSxofI3YzbCFr8y5t7N6aPEosk+JyTnItswMtug4c9p2UaLb2PnhJUhYonr?=
 =?us-ascii?Q?Q52/J8B0MnBx7QTbWZe3q5SQ4gE+9q3Mmp0obuzEUFXklI7xiD0256XqPoDO?=
 =?us-ascii?Q?VrmbHr1vk9vVa1x26T1DS35k5k3JQv71OzgGQU/GgvfMq6JkkV5THSmB+8QS?=
 =?us-ascii?Q?sdpBAxdl6ns9dPIayrvt3AZmqu41IyHDu2sDnj0tIgyIgt6H89xtBU9ymYZd?=
 =?us-ascii?Q?WXUiL6CvDqJagjmL0PP8Es4ci4aqoMjt0qUJPRNQwgRr3i/Ztf471YIjWvUV?=
 =?us-ascii?Q?Rw6j6a3fP7QgSGXGHjLIAqiTi9YOdVEUsSF1vlJlH02LSwosPFM+ig+zEPD4?=
 =?us-ascii?Q?LhehQ5yLddxqBz9Zz0MA9Ha6+SchA1/1U9E0R7VcAl9UsHGtjutdcdOWxfMD?=
 =?us-ascii?Q?4a0odNtcL14/wLfpyOJ96pauY9F9naizEni7vjoB3REVzXQSe9qRsRXvmgMt?=
 =?us-ascii?Q?rGCNIkCjB9joqOb7uFjY0tmA8TIUT+ryZ31Llf4xkRIDfkDoas0Wny/02mcL?=
 =?us-ascii?Q?JP65x6y72H5zdJMCrVIrtAPcabIFgG1avfJgXa3s9z8rjSuZPeI7LIv5ZQn7?=
 =?us-ascii?Q?JqsZZiXM5mDWiEHeLjdAezJemiZwjMwDoxtY9sH3fC3W7QoUbzauczwBtqgD?=
 =?us-ascii?Q?YhiaBIMziM0ln87ZAPAXo+yW56FT5p6NkgBy6H/vwgnQtvC0xBhohhOFnvac?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?U3iMskpX4NEmUAfsQ2pIfBvSXV+GpzMfSswsbKtuDaXa8nVMlRFwoS90ifam?=
 =?us-ascii?Q?PRRqmc4cbUrPVRnY30NZVXVjctnZBHRWUaiW1jOE2WRPsx3zt7KDYKg2f7Xe?=
 =?us-ascii?Q?INNgWTv3oq6BK5MqwiExKVoS3FanaCum3+Hkgxwvsmd0tQ9zN6sHcH66IQPE?=
 =?us-ascii?Q?nCihQF+l4FBIToTYAN09QYPIqL0PtlworglCalFllgEGN1bxCLr40jtrr2VY?=
 =?us-ascii?Q?rLG6RFXpPZEeviEQYJUnSR5mP5iTtwd0lN1drML7qiqS3GH2krinpZCxyHNB?=
 =?us-ascii?Q?/2ZD8UFYZlCt5R0U8QWBRzTH1clKQMN5incrgOSM1toXq1yj9Uut3q1uCd+U?=
 =?us-ascii?Q?C4AkDojCCQetYxnwki+wvzGf0FovUALdmTr9mcmLOetiC4dnaQ8RyBZYxNrz?=
 =?us-ascii?Q?njjmXlluLAp8ooizIBaTm6MBbrcS6y1MV2eyjDNJvKFnPcIa8acGKVf3TEMt?=
 =?us-ascii?Q?o0fPd9YZm6smD3o/EGx5yH9sHqX045A6Akw/FYAwCf3itRs/kUFo1V4ImrbA?=
 =?us-ascii?Q?4/NvxB+zAe20M+87Lr9Hbpqobsa0puOd9sc9DT+2BFPAjEdMdTh7WMrSC0Wh?=
 =?us-ascii?Q?FmNoAwnptt+jdJnYyzaLwmvsghrhznnUEJA/g2nq/6SkCzmPH+9z56WcKnoU?=
 =?us-ascii?Q?E7Ioh4/riX0JvnJA4Sc74PJs3qmezUwzlbF7KsCaHdVJGGvFNEmZKBKPUsHn?=
 =?us-ascii?Q?gZ1/vW0Am22DfNXhv6gk2/sx6gwdE90GaEwn6T0LFSDQRs8eX9TGWGw0FSn8?=
 =?us-ascii?Q?6LCRYmWZb6iDRlcu7SUzNJKOuZwJrRtz9pmoFegZe/iDyKhUO3sWjVsdRAe6?=
 =?us-ascii?Q?lsCT0kijzlollCU2DfCIN9zNigMfw8uPGbEJB9CnsRJvS12eSMpUlumZL9fA?=
 =?us-ascii?Q?kz3bBUwDmhojyL7XsOSsYabSKz3JkflERFGT7TzOIi/CSzBzVvDW2mxgboRX?=
 =?us-ascii?Q?yLQ6rowpKvJeSn/ERJ7MFttkn/Iw7WsEHknZMXFDgHw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cc39ce-19d8-497c-7ab6-08daedbea262
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 19:13:45.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DE0jYWr40VwUMern3r2+qp35RZUfIzXFldpVhVGO5nn3QErUyJwE1ank40T9AifW3UvW+b4U0+0dZTbchytds4wqQ8JFRG7gkppJKYL4cGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=633 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030165
X-Proofpoint-ORIG-GUID: 8-kTgbzxnxaUo1TuuMJTVfIg-gV_r9ps
X-Proofpoint-GUID: 8-kTgbzxnxaUo1TuuMJTVfIg-gV_r9ps
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

============== OVERVIEW ===========================
This series continues the conversion of core hugetlb functions to use
folios. This series converts many helper funtions in the hugetlb fault
path. This is in preperation for another series to convert the hugetlb
fault code paths to operate on folios.

============== TESTING ===========================
LTP:
	Ran 10 back to back rounds of the LTP hugetlb test suite.

Gigantic Huge Pages:
	Test allocation and freeing via hugeadm commands:
		hugeadm --pool-pages-min 1GB:10
		hugeadm --pool-pages-min 1GB:0

Demote:
	Demote 1 1GB hugepages to 512 2MB hugepages
		echo 1 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
		echo 1 > /sys/kernel/mm/hugepages/hugepages-1048576kB/demote
		cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
			# 512
		cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
			# 0

Rebased on 1/3/2023 mm-unstable

Sidhartha Kumar (8):
  mm/hugetlb: convert isolate_hugetlb to folios
  mm/hugetlb: convert __update_and_free_page() to folios
  mm/hugetlb: convert dequeue_hugetlb_page functions to folios
  mm/hugetlb: convert alloc_surplus_huge_page() to folios
  mm/hugetlb: increase use of folios in alloc_huge_page()
  mm/hugetlb: convert alloc_migrate_huge_page to folios
  mm/hugetlb: convert restore_reserve_on_error() to folios
  mm/hugetlb: convert demote_free_huge_page to folios

 include/linux/hugetlb.h        |  10 +-
 include/linux/hugetlb_cgroup.h |   8 +-
 include/linux/mm.h             |   5 +
 mm/gup.c                       |   2 +-
 mm/hugetlb.c                   | 213 +++++++++++++++++----------------
 mm/hugetlb_cgroup.c            |   8 +-
 mm/memory-failure.c            |   2 +-
 mm/memory_hotplug.c            |   2 +-
 mm/mempolicy.c                 |   2 +-
 mm/migrate.c                   |   7 +-
 10 files changed, 136 insertions(+), 123 deletions(-)

-- 
2.39.0

