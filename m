Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3595E8614
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 00:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiIWWvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 18:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiIWWvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 18:51:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A1313E7FD
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:51:45 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NJF3UB026852;
        Fri, 23 Sep 2022 22:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=QUo+g68rINfZYk5hasdQW3Ij9pp9I+Q8SBOqkRXwkPA=;
 b=HI2jq9iB2NydU+22IpecuCRohHXKrlJnXB0ymKWCiIGcEiGJEy3g9+eGnMfaHWFN9u/y
 qF4fKJFSjvvnq99tpuTiHTJoKcNT3ktes/QAVnEwu6p1q7dTqK/oY4Etq8/pxad6YSsO
 dSsLBhESiQMcheWhMjaqgHnF0FR5pbXdvMZ+UP/mmCP9Xu4WDWHmHVso+/Q/z0+NPs1c
 ENO3RSivNt1aECAvk+whHEIEQkjL8SUL0utTaZ20IPuZ/WLAIX4mLlczRlt6fODqeAJX
 WqV8QYFny/byrlsCwP4/hhWrYDh1rsTn1pFBnZ424Aljh8MTVZWkCTtHqMln8llrG7kz 2g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn6sttdw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 22:51:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28NKgvCM028899;
        Fri, 23 Sep 2022 22:51:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3d64v5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 22:51:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oC2WxB3GagYW5eWGJyFwttm6rl+t5QRUtDNFDZw/QbwTv9D7wLKqYpig1Xor5D7KvjU4ryPMb65DHFRAczrtWPaf2ATkKGvI0f1zipQNzap0qlnctpqtFaLxUe8gjzdDbzPXj9f0UB8Br1ea3aRmXW8fEEgHB6RUhxzsrj+ZbkMSl1YOs93RqZdwgMlITSNQR7uHpi0cVvzB6WaaKuRjC6GAks4ZTu3Q3AJZawgUHEtgOUQssjhMxLL58AcmpOcfB4qabYkdAzn4+pgJ6obRnqsD0JwlzF55KKowpIl/ADJ7D8vLXVDjSyHluo6GDA7JC1bCyPSA/8lnpykpWhTGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUo+g68rINfZYk5hasdQW3Ij9pp9I+Q8SBOqkRXwkPA=;
 b=io+QTSv5uXAKTOjTquCPPsuChIflLQXx95r0HLWNqrz3zve850x+e8GYK52690fN6nNNi3sDULLWExNzw+/aTWD79gSDLCiBxRETP7YMBi2t373PDB/z7JuWmXUmHdGS0EINwKAKHWkYO8mhXrpQhZv/HeDtnibZ4Elj2YOpuaHOXOfY7iBE51LWjW7PoGZQoFZooyjtu8FeBbLo4ScnlE4xoVtc1QI+QMmY48RIwTVy+yJBgMOfLGkpWvBZUztg091AS2Ipgda9gE1HfGn1bpS0tB2cvAMNryUvsedWLc4Xh5ZzhhYc2+AiLjIWKEMHit+DBV7zJ2/Xifrddi5fjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUo+g68rINfZYk5hasdQW3Ij9pp9I+Q8SBOqkRXwkPA=;
 b=RNPlaqNMLxhZGPPp/0xO8DSZWCIRn8qWKtndZxiwWd5fyq+yMitiUFhicZner3WFKpTGERkXzVGCQoEoeJnhCEabGU9IDuY359wk8vEgpgD1nQf/kZDJdJypZm9OPOS4KecYCtRcpqTXuuzBBIz/WXgKgi9lvR5IXjlhg3wycso=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB4251.namprd10.prod.outlook.com (2603:10b6:5:21d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 22:51:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 22:51:28 +0000
Date:   Fri, 23 Sep 2022 15:51:25 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Doug Berger <opendmb@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/hugetlb: hugepage migration enhancements
Message-ID: <Yy44bWqS2/hJuiZp@monkey>
References: <20220921223639.1152392-1-opendmb@gmail.com>
 <YyzEz4snl2x51iTY@monkey>
 <YyzkoGJsIXVFW6ZL@monkey>
 <829c3fe1-54a2-53ba-9448-d80196b5ebf0@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <829c3fe1-54a2-53ba-9448-d80196b5ebf0@gmail.com>
X-ClientProxiedBy: MW3PR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:303:2a::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM6PR10MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4f0ed3-250f-4ffa-ee07-08da9db626ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMSkDdOR8HcNOt/PHeh4+UjP2pH/8M/sR4er3lz1kVIiE26Q5U2r1G+9B+aUZT9Q7LFBvL7DNhSqBlw1KbRXhFf9E/AUKYIZkqBJkcpmduHkZodgxeTna2NxYoT5G5GKaYCA+HR6ekVfOHw183IlbZsLJnfXCWOVt0qt669qvSSkomwUffnTpVnwPrzA7BDZdP/z48oSBXdBzvgTOcPrB7j6wM+2lPtUiE/nZN3kOjD9qoIqrAJLtHJAOZZG2+PM7VaAl9sRTaD9/16zx5d/3STXziRJZuKxbujH8jES+0Osn1BbRTVvudGaUqgV94j6JdM0dwGyFIE+UH+vLWF+tld+OjAVrGK29zsYHQUHT5kGqVbw/GXc0idQkVcUbOxOTDD9GZ+JU8Bmu/hmwVQdRIQyvoQ1xOGvSt00MgYUIzr/2PuFZXioLD8XXHPfG/FV06Vdv2yJ4qW/iy4fLIvJdGKZUnX2+I0Cqukl1cpre1W9c2iFGqeSTyUeSltstNbYv2KrDz/MSd4Bjf0l3cedITlteEqpPa/Ct8TMQ2mcd/cTKosJfp3zfgyRFUwbJeL1/74sQySOJhNAzcRe1Yivagx7nCOgMQno5qme4vwXqkbIyk5vOnjkZ3HPSIHqEaF0wnKiJo2X92rimkjFCHmaEBJfEddK7/wrXlHohRv5uzqv07msH2DU1OXs8f6JnH/5guSAlEXNpSQpwpLdpK2WyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199015)(38100700002)(66476007)(6506007)(5660300002)(33716001)(54906003)(53546011)(6512007)(66946007)(41300700001)(6666004)(6916009)(8936002)(186003)(86362001)(8676002)(6486002)(66556008)(9686003)(316002)(26005)(478600001)(2906002)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RADcBTHeDjFERQIOCEc/grKrUAinzFOaRMdXPAe7QUUjc4xCX9mQvUaXD28F?=
 =?us-ascii?Q?JMQfVMvgOxruJ2blOmlDjQGVZALi8iH/8Uc9CsA4f/cKCw7ifICey3J3g87p?=
 =?us-ascii?Q?HgiWNQHZYG320roQHJbyo7C2nV+tC41AgmmxX6uEm/4a76Qj1GH9LMFPIRgP?=
 =?us-ascii?Q?7du155TiltiDj/jutgQnm2l7e1VSuTuOz9bx00x51KB0Si1Ev5ugMFsD0p3x?=
 =?us-ascii?Q?wXW4UM8hukdPfm16/jECVlJVPxQlUvwORYy+YLle61h1LQT9Z5jByTPvoZWr?=
 =?us-ascii?Q?C8OKOj7GIwXD+wXdHFnFiBE2mq+ET78t013pT+5+ZYaJg21QdKVn1fV3YPQa?=
 =?us-ascii?Q?JUt75JBgwhPVSNWy77/XSHBe2VZ8Bwwg+n9wta1gG5Gp1y5AvLgYUyhr2ken?=
 =?us-ascii?Q?JTRvy26/yXTkOxxjL2sjchtK7rGNLk1NKEzF+vXakqI9JSOcoEyt9wBPZ5+0?=
 =?us-ascii?Q?nXXoDKXcm4xYt1J7lC6m9A00FW2YqUfyPsZQLXKXpoMcq5+YN7akeNBZw7BT?=
 =?us-ascii?Q?+vQvN0+NS+VKf4idN3xSdxRqB4V9pIjKMgPpm6pgRf4nje5rhteoxuKOvWn0?=
 =?us-ascii?Q?IlbMtKejQJY2/QzMlZFR74S5MSNhLwn+19VKGYWFLnOdKq6WMnsC59VHnuxH?=
 =?us-ascii?Q?ChfgBQgferNNmKvLS2QaAGMXtkBLNnP4HI8r4+mqT/h65kys/ybCJ/jOsjhu?=
 =?us-ascii?Q?lWqf/dOYHyBeqUkq0N17aeA9DAn3EpzCKakSDeZE/zJC8NPu7kIMD+97QXQ/?=
 =?us-ascii?Q?aa2wVJuBduEg/qX9xJdPFNmnekgpPBkyxRKDWyn7Kk6Zv9j0tXT/R2Lyjs+4?=
 =?us-ascii?Q?tQQvjqo4HvKufkJy9lx1DzG2CuNJg1jyIobaV2+uz47c147LZMeVxSsiqHSF?=
 =?us-ascii?Q?9zoCCB95E+vV8wYSh8QyXpn48JxlKD9SnMT2GvXbTi7NFlPowGBExLmsW5m7?=
 =?us-ascii?Q?s8cy/OOQSrvlCosAIW2gAI/qxsjt1yC9NoEMzP4eVXkdIkM3vLjOyfQRIm4e?=
 =?us-ascii?Q?wkqnJ9VZZFPNpwAUDXdSTa5HMHEyLSejTqIsNBWg0CpyFMF1m36FWNgBK4TE?=
 =?us-ascii?Q?l7A3E2G014SyM0Cr1wruizrW+rrG7NdCkxcscKI612zz1xxz1eIjcHpbcDi+?=
 =?us-ascii?Q?dusA7foj1gFe8vxvhIKwQQ7LJ5dNaYLyHDvaorEOUwyw/+2B5tkzLO2khagy?=
 =?us-ascii?Q?egqRor5mqn3hw4pFcuY3k9KnA9PcBXS/ifYZ/lJJgLO/K6UN9h83G0hbT/P1?=
 =?us-ascii?Q?QqPItgUOoQAK675YfkOFzZkW0/i85v34nhXs4YvFL5KDO47L8iTR+eUJ2mx6?=
 =?us-ascii?Q?fztM1fffRcd3SV9TIK/isaxnt5DiNfHmQqBYaS7dLcX7kRWQkMRyCjXOCKpG?=
 =?us-ascii?Q?z3RTSDEysHCVQHFhRUOGdvSTR1PJE+E1qQD4O15J7laEebz50bsS9WtvTiAT?=
 =?us-ascii?Q?YXJEzh+iabJ49Zvx+g97hTCjsYn9IUY0+7nWC5BSnF5oRKq5ChBGhbEJsrIu?=
 =?us-ascii?Q?KJ8/MociWri4lJZTt+mn44/MQAOGRPFhBWllH+NV6ygL7cNp08q6cIyUFk07?=
 =?us-ascii?Q?3l08wsnwdI9+r2cn641/yTkZDUvBQbY92zPnSWVQL0KKDp+LIIf0rL9SzMLQ?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4f0ed3-250f-4ffa-ee07-08da9db626ca
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 22:51:28.8652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHWmO+kt0Clbia5C6cXHXzos2OdbeFADAg794+LaHtZpwtnubYUfyOvSIoHC2q1COuYdlNPTrKT3RbFTcHylmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_10,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209230147
X-Proofpoint-GUID: jQkxXiGZgyu4BOWsUwKfBuJCqPClQflh
X-Proofpoint-ORIG-GUID: jQkxXiGZgyu4BOWsUwKfBuJCqPClQflh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/22 16:27, Doug Berger wrote:
> On 9/22/2022 3:41 PM, Mike Kravetz wrote:
> > On 09/22/22 13:25, Mike Kravetz wrote:
> > > On 09/21/22 15:36, Doug Berger wrote:
> > > 
> > > As noted above, for pages to be migrated we first try to use an existing
> > > free huge page as the target.  Quite some time ago, Michal added code to
> > > allocate a new page from buddy as the target if no free huge pages were
> > > available.  This change also included a special flag to dissolve the
> > > source huge page when it is freed.  It seems like this is the exact
> > > behavior we want here?  I wonder if it might be easier just to use this
> > > existing code?
> > 
> > Totally untested, but I believe the patch below would accomplish this.
> > 
> >  From aa8fc11bb67bc9e67e3b6b280fab339afce37759 Mon Sep 17 00:00:00 2001
> > From: Mike Kravetz <mike.kravetz@oracle.com>
> > Date: Thu, 22 Sep 2022 15:32:10 -0700
> > Subject: [PATCH] hugetlb: force alloc_contig_range hugetlb migrations to
> >   allocate new pages
> > 
> > When migrating hugetlb pages as the result of an alloc_contig_range
> > operation, allocate a new page from buddy for the migration target.
> > This guarantees that the number of hugetlb pages is not decreased by
> > the operation.  In addition, this will result in the special HPageTemporary
> > flag being set in the source page so that it will be dissolved when
> > freed.
> > 
<snip>
> I believe I exposed alloc_migrate_huge_page() and conditionally invoked it
> from alloc_migration_target() when in alloc_contig, which is roughly
> equivalent. I didn't consider modifying the mtc to pass the information so
> my logic in alloc_migration_target() was a little kludgy.
> 
> Like I said, this can be made to work and I'm happy to accept an alternative
> if others agree. I think the isolation test of patch 3 is also still
> desirable.

Yes, hoping to get some other opinions as well.

I do agree that patch 3 is still a good idea.
-- 
Mike Kravetz
