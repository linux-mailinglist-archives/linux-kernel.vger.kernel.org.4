Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E983643850
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiLEWr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiLEWrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:47:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604ECFCC9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 14:47:22 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5KNvic002036;
        Mon, 5 Dec 2022 22:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=7GEX+lMSuLO5AZR24OJtMlaZIyxCEdgP0f0HCMhszqU=;
 b=vRLKcYX3a2uP9V1qZDLRHPwx6TXSVnJakATmnPCn9Sym96lScWQwSkmFRjPLliyZ94MJ
 6EHnLNZy8CA19SVrwRTF7iiHVhOG/ObWD9H2T46+RZe7yuTOC6SVX+OL2iQ0eovBkyop
 /YbDAe8xLNPX43Gv7T9AF+rIK3k1cr68daGX4PMCKQj4EkBods0ev/eU/iO0R0qemYyN
 FfmPJgjPgrRTOH8GqoljqAZ2sKT9c2jchUyp1QO7zfOfr46uNcj72M2O71AF8ECyfv8V
 pSyLZCyEgUtAP4IscHMPnkDfwjTds+xgAdL4nRHjop7R1c6OM2OZ9Xd6B3z1/aUGkMkW qA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ybgnff5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 22:45:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5L8pS0028054;
        Mon, 5 Dec 2022 22:45:09 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m8ua9xbnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 22:45:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1BkIkdvKLcxE2BgogaX7mURLULcaYpBCwQ3AXrRFq8iqHklKZveYyNaywbgn95CydO+V7qrqGGH8o95yXvW6GkxEgqt9LYr4avBx0le67rG6CteXX9CIjamsdCscRUIoVXMlz8GlES/xXcKgUFMEcfL4V3gOLiaJZqloSg5lysp7oItRZHBTpcl2ffKNnIcyPSJ400yXXzod/JB/s5VZFNU9ITy35FU6nPk5m5/UIAKZ5G56DYaJhZ7R//N89QAuYqIoHnEFhbXmtjzz2I+tjRs3an2rjf/nzL9Ui/AQt3yzDT+ySH6P/Fh6rvs72fSgRGaNpBGnr8RJIgXelX7fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GEX+lMSuLO5AZR24OJtMlaZIyxCEdgP0f0HCMhszqU=;
 b=JRVPMr1K24jd3GPBAs3qcOohGpA0xBGN17W0YJiRrXY2xGxUrV0HMyaZFTMLVQvMujlsRiEj+5cCTTaWsuY0wE0QX2zKvLhjTsp2ExxpK0uY6xZPQON0sgUF53sJ7wIfmt6cuHIabq/HzF/lf6AzYpkP8pkiBeJU0OYmmi6RUvELAtBPtt5oKU3ABF8tjQtpvZHWTJ89aM+6CH/z0DbhXtqF2o2e3PVh5Ds9oS7rlsec1fQ9MF39pgC+alJuzN+bMAq9q3Ic4losHV7jTmOp6pQzetxHnKY1gjSt3Qdpc8MWKYL0zDJGnJ+dIEdx83sLzMCOCQMVUYiTbJCi6QmP9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GEX+lMSuLO5AZR24OJtMlaZIyxCEdgP0f0HCMhszqU=;
 b=yTP7NavilF94VyyO2xkTRfpkEjUgiVmY8whvv3jd+Sc9PYMaKWlpNFp86dVdZTrEvJwPw/uCFWDuow0HJ3suGr67vJEjHaN/f1cchbopOdc1D3aAONVtxBXSRvESd5ERNsYx9oFZYIssUXRHoNabrCwPVobEPgOy4frz7hEqlic=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN4PR10MB5591.namprd10.prod.outlook.com (2603:10b6:806:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 22:45:07 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 22:45:06 +0000
Date:   Mon, 5 Dec 2022 14:45:02 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 07/10] mm/hugetlb: Make follow_hugetlb_page() safe to pmd
 unshare
Message-ID: <Y450bsp9JRdNTcyO@monkey>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-8-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129193526.3588187-8-peterx@redhat.com>
X-ClientProxiedBy: MW4PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:303:6a::6) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN4PR10MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: d62bad00-53e6-412f-385f-08dad7125a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pr6NBHL4UobAZRzHTPoLk7t861ODqEtkgbwYRVyrFvSYBAxeVXuAGAG8Rw+MmtwuavE5OwoEKQecBYzGXUJU/vbONY5RFi/HQ+5IPNhDGvd7T9dZQek6RoUeCs5QSaXJrkdMDaCY3ZXCDeFVBMyTARmX4x4OQtCUeW4r4jkZQR/vXLaamYj+QEk9KagEuAqsk28AZaIh6z5mWpTyq5QFIP71IJYrS9ZGatxPyZf7SQJ7NbaiNMqFq2lAm4AzVTA4RJZO/l5m9pgU3YJ4yeZBVnkFNpg4VA2efNEczViWjghYpq+offc8cjLVh7yYyEn8mWxCD2jVEi27MQQQBDvzydQ9fw0kYELrC9kvMJmfmwsB2HTVevlmwDnRyroiR3LzQ5NuZpd6xcWT98HpyH+TriWylnh2MbN4aY5bkIYg0bnMtmv/3ZYYBXYuRtosrKfYXT4ov0hDCuCAeOrd6y0+/6jc0OhLixEJFlhIWusK5QLjc0lBjgDUedda5OjhU8ninZNCUPiAyACQno+E0CuKQXDaeyRTLyAyXhcl+bB4JXdJMjwJUjqQCFA8u0s9dRNDuJbHaMkvlXOpNphSAOluNB78kcuKb4XUGT6UDrfEA1RMYDg/ydnlKkai1QiqyLCUyV4bUFug3L3L50/V4P+IYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199015)(8676002)(6506007)(4326008)(83380400001)(38100700002)(6916009)(316002)(54906003)(53546011)(6512007)(186003)(9686003)(26005)(5660300002)(7416002)(4744005)(33716001)(44832011)(66476007)(66556008)(66946007)(2906002)(8936002)(41300700001)(6666004)(6486002)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0uFPbhxF3m8JqIrS1gtQZFMYEtqDIJQ9zQqyza5Dao81YxCD8R5FmnfQZvQR?=
 =?us-ascii?Q?IHJZXiCaR80ZdBcSwWw/mOwqIxfEld7L7kdf/ZgrKdgW4bw3P7zfr57HgWjA?=
 =?us-ascii?Q?l2f9cK2ZnZwUqSYSC3X9V62Jy3aKE9AA469tQNFSk5quiqPXrowz8OXJ/wCH?=
 =?us-ascii?Q?2iN1OIzdcGkFEMunbFG6+Xtc0lTw91wJUM/JEfSj+P8vdEAk8j9Fr/ER8LIp?=
 =?us-ascii?Q?9O0ulF6SsEMoUjqVJj8wbtT/w2xirY8C5W5SFIzhLKWvD8GHWMeBLfyJsslM?=
 =?us-ascii?Q?OjF7+cqEUEzlija9B/W5zIDpAEzfHUWqA3exa7ZSjPuifnCuUa9DqG4di73N?=
 =?us-ascii?Q?6SVJAqtz9J9w3EvvTgo/zTBTfe5vP2VqKUAZNRubqXziXwstKKaVTCRIu0aN?=
 =?us-ascii?Q?b7bv7vAAPL4glXzilQyx/6D0jOqQcXbMq0rIf/3D0rVN8Hfb1X5a6sPXHkEU?=
 =?us-ascii?Q?5A43dCjK0mTAZKNw2z774K6EnqRmMhknMWpQz3qVyIsnKfkMseCLargWCapZ?=
 =?us-ascii?Q?DwQQu0gUYOfSVDzy/y1JJsCacsW9Ozd6knEpdlJKEvKswgIvJd0UqY7sRrix?=
 =?us-ascii?Q?L22e6/hOn/Dpcd9VCwFbFRIB6wEja/pUKJgfvA9HB8wY5SM6AQKtcDQpSnGm?=
 =?us-ascii?Q?AvNM5LvMRWlaeNIqKq7w3RYBgRsdNJlNA1K5quBGYmEWSlRkUHTpM3T+Ue4a?=
 =?us-ascii?Q?DA56QCN9fHg9CcThpLPiQgGSTgFul3vX1xrLLT7jAAZZ41xuxrkLzDHNgGcp?=
 =?us-ascii?Q?egBJipCX9RaHdUHTYStjEzRen7W3BNtVk0ulUggjcePFcljUdpOjZfKB+Agg?=
 =?us-ascii?Q?lGKYaDw1DZVQloD5TLs+l4nv7vwLP+GnfPwTNF+uk3bA9a6rjCEZzp8fGqMd?=
 =?us-ascii?Q?5f6BNfh8/eE918cZCPiXN6fvsZuSlYvhj38j8dymaZw3AW87u2tpXT3EK4MG?=
 =?us-ascii?Q?LWvu1YOtIJQyVoCqUn5wTPjlnaPmdgwqDu4d5CGoHxtTkD2Sm1TOnr9s7a46?=
 =?us-ascii?Q?ym43w3klEiqmZFwO0dSFueAUSF10hxXWA8RqePo+nk1G9yCv0mIIA/4NrthP?=
 =?us-ascii?Q?rYeDt4GRM9kGW+1zn1myH2DsdERxZBR+z/H5bfZZPm8uGdP6BZSG+ZkJIJ0T?=
 =?us-ascii?Q?bCfAznqnDFkp5urvJ7k8Lz3/yUTuUg3KtsRgVCMsCQRbRDNZMhywyYsxZTt/?=
 =?us-ascii?Q?mj0n27uIRvoLtKx3NpKU/8TCeDOwfJNmwBZ4DR1YVr6NWQDIPaWNc67jEJVR?=
 =?us-ascii?Q?iaW/DwHL3VVdPNwPa8yA+8e7ima80AVFEzSPDaGnYnmc7A5fB8p7SYhul2u5?=
 =?us-ascii?Q?O3bWEOLtM9XI4Y5NOHpbHjUah0Jm3tBt4nv8XtzMPua3i8eDiav0Y/RZD/iu?=
 =?us-ascii?Q?Tn2Uao+5gnzB2G9mN2fgHtJOLE4WMWk7unmIYfu011ZZ0Wq4GEvnDLjyIP8F?=
 =?us-ascii?Q?QxrQmWoqe+P8lXjVc8u5UYb50AeV2lq4wVtegrufFTOUsvsJzKH+j9KW/219?=
 =?us-ascii?Q?9BDGXDV+/sG0JCme+dQuuaLD8d38iLFEAhq223qp5wt18gJYuj998joC6qlo?=
 =?us-ascii?Q?iiuIat0WhlLYzscd0taaC4UyqBD8758KyNtejO0YWwCXHATBjq88lGjGoYBn?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?189eByUSMyTlnrGT2+T/vsh3hiXh3zfLMO0rrfd6EafIR1hs60eeYrssoDpB?=
 =?us-ascii?Q?VVqsI5mbgkNfmC8txuVENGsTycneZWl2IFiSRru2Jb266ULxwBKjXzhIOvja?=
 =?us-ascii?Q?jXJr2TCJBBFfUvfChBb0ZcXc995cpvDIsWCFErHXny2GSSOAuodiopuQP7cw?=
 =?us-ascii?Q?HbaEvJoUFt5vyA8KtTZBQPiUCW00hRyW8L/QkiwOs94OstR4RDJvTHvHfd0R?=
 =?us-ascii?Q?f2jR+TjIBYrTw5lJi8kulaxFZMTVyE4wsUIxTymq4UOQM6WRfIwskNJ15jwQ?=
 =?us-ascii?Q?9J9WZGSS/NHUmjrrOOcU+A/GW3phRvYxvcf8bS3RCEVh9ClIITxrF5amD30+?=
 =?us-ascii?Q?P0Ob1VMf4K9U+dYpGNNutq9D5I1kAAwbfng/4Qne11fRHpqj65ccI5BN8jVp?=
 =?us-ascii?Q?HnwacXxIJeBhcjykp/RqnCQ83QKB/vJ6i+1+rmnA8IJ2C6omjEJm7tbg6ywF?=
 =?us-ascii?Q?OB41xfulo2i07r6HQHnouZvJLnpqHux1VpOF9nSo343JjaMaaL+X4HFuOf7Q?=
 =?us-ascii?Q?jv+kvZagrqxR9GFEbxo5DJYLIgubxPGH4WY/YC+Fc9Wlm8O9zwE/VgY8yorf?=
 =?us-ascii?Q?fySQvX32sWE0kin2spekcp13KV8Y1a9L/IqQPEobBed1h4qlIvOt4x6Vv/sI?=
 =?us-ascii?Q?sYgxxVbfWICOX2lAOsKkIht1i56jAcw//ZCXzAbPNnIflYiTga++CJh2nolh?=
 =?us-ascii?Q?/bokhfvzTcX6J/EteMXbWxVYmBB7zr1d3GMcO5rTWGROj+8oG0FGmYl72Mrb?=
 =?us-ascii?Q?hY8H87AMUECjumXTz8F1nlPXXyBrbcol0+X0nykyNP3A4QotUBVEBHasgkL9?=
 =?us-ascii?Q?McT8xJ+94qUh5RB8nLYtlvZJtM8dFp7KFPeVyZVj5Ir9pZevigwvFtvOatwJ?=
 =?us-ascii?Q?ICDEcBpEZcIGVf9kKMZwEhIiSohsXmcDujFhej4MsZW6K767NxQj2TMcjuod?=
 =?us-ascii?Q?Fc4cqHW8gxGxnknZac5tsrG1htXntli+1R5tWKnv0sD39aGSdgbX3kd/UOop?=
 =?us-ascii?Q?7V3nS/omtt9YCOke0oiC/uspe/amXr2YjlMf+6/I1v8iSeNqZNaD1B86SxRR?=
 =?us-ascii?Q?rk/gT0euU/n4mccxyfgpJnHSOyhsOeamZkXzMBJRKO9rcj08nyM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62bad00-53e6-412f-385f-08dad7125a54
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 22:45:06.8095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxlNsa+ub+wBHEQaAIrcZMGFdWbHE3kyJg+43kb0CY+CxywsCMQqTBH9SNVJTmiTMoIhXcL90dZd7wZbNIeeHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5591
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212050188
X-Proofpoint-ORIG-GUID: RKDcNhAfSbW0jM_HxpG6sSkvZIWCBe3e
X-Proofpoint-GUID: RKDcNhAfSbW0jM_HxpG6sSkvZIWCBe3e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 14:35, Peter Xu wrote:
> Since follow_hugetlb_page() walks the pgtable, it needs the vma lock
> to make sure the pgtable page will not be freed concurrently.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Thanks!  The flow of that routine is difficult to follow.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
