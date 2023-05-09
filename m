Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F496FBDAE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjEIDba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbjEIDag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:30:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33029D07E
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 20:30:01 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348NxCRp005868;
        Tue, 9 May 2023 03:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=rzqHs8I+DP108ooG5BLH8nDdmXMWMy0bQhUQ/s1jIog=;
 b=KFB6km41iFpJBET9eG5e8JieKZx8VPmFoZzjsRvKHS8E0FNXlExwR33JDDxFYkk1FsYn
 FPZKEMvfv9vx2qWdpnOn2brIL6fpSfti/ilf68cy+UYlCF9FbCSv0vzqhRI+A5UHdYmy
 IApQk3I2gPtA7A0VE85VX+NLb1a4G4j9wHZDkspv9P8g8TDNzCdy0Pyppv1wF9M5Ioxy
 Yo3qzFNooA9oSENqq2Le3IMwjDzAw/SWGo63KZhyPIsI1Lr0MT6kOQbXxhWv8RbfXggh
 P59VUZrkJmAiHy4tKM4+/XSey9x/9spy0nlybFxFEOia2wufOD9rJQQD3/bU4RtrnjTP iQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77d8qxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 03:29:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3492IiGn001772;
        Tue, 9 May 2023 03:29:46 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf82v20cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 03:29:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvZQz1CIghMqJg34LtsB2M6gRMJ+ffmEsdYsqEcYk6HZ/JcdKjyWLnVjA4HSi5nP/Pjuit2IDPzhc+z7IC0KYxh600cgTXFeipmwIw6DXV5WBLNFqBQKMZ7rNX03BSpxEm0m1BJeU10khfsSOPC6pL6QFhm92M35COZ4jU59bH3EI2TRnp9ws5RYE0D0gZrK9+dgRmRoQItrZtszIuhfA5JpBluXg8jCKMeqBciL2tgjadpNYpWtTRFGXTdaepRv7iyqqM3Ch7Eak2BmcccL6O9yqlGsdKErGXg1M4Tl4qYoe0pWeFd6XOohpUYQ8FM6Js11nV/W1fMll3dqY3T6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzqHs8I+DP108ooG5BLH8nDdmXMWMy0bQhUQ/s1jIog=;
 b=eJp51RkiDWYbuTRHi6v3QRX+7NnebcoFTUqlqaqKxmUR3fLztT25t5+bCC3wO7pPZ2VtqMtgHbfR9xmFl/iMxeTR0j/ICV1W4Xr3fyXShe2Sxcesxi0Drcq2pCD2UizI6LZ0Da3Gi9LVUzVF1Vi/Newc4o/yxzGiEYAeTrhUTBwU0tw4jVzwuWDxcB3t+t35YdmGVHQLE0pOCBPxn/TvBLCzHT4l0D4ojT4aX7CWA0je+p8KRTl8eKRbZcaHCE/hHg0IFXFB4TD1zscPpKnlb4UAXxihJZ6n5ydaeW+7fvoja6HnK626N4MFtOGJQpYgJlN9VJOH6wG+sQ5FMt6Fmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzqHs8I+DP108ooG5BLH8nDdmXMWMy0bQhUQ/s1jIog=;
 b=jMz6Rdv+1LAIasxU0wNqQooZD5vwSZdG+VAlWsSt9iDcNMZPWPRfLtLHv887t9oNutI4VZUt7XB9M5pByqe7ZIDajLRhpROOLfvehzgbPDaCvsRF7qbb/UtXyEOA3QlaqQ4LE3Od3JQwpZB/Y/Q8S8D/0iYk8EsZfPRxYeFhovA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4226.namprd10.prod.outlook.com (2603:10b6:a03:210::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 03:29:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 03:29:41 +0000
Date:   Mon, 8 May 2023 20:29:38 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mhocko@suse.com, muchun.song@linux.dev,
        rientjes@google.com, souravpanda@google.com
Subject: Re: [PATCH v3] mm: hugetlb_vmemmap: provide stronger vmemmap
 allocation guarantees
Message-ID: <20230509032938.GB4470@monkey>
References: <20230508234059.2529638-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508234059.2529638-1-pasha.tatashin@soleen.com>
X-ClientProxiedBy: MW2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:907::25)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BY5PR10MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e9b692-9c95-466e-3750-08db503d9fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mphDh9eO4Z2Pe77Saea4Z1uKfT1dToId5IqZE8yAfyCYWuLYkB5l2TAOu1jI1XTkQoqXSTIg908u+bCrK53XtNPRfl0pzy7IwYds5MoR0WQBU5VKi6XWn8PnQdSVbJMvzuZwY0UDrq1qZWS/4aKs1sO4Fq1ULOnL8VnNF/I6zGLkq+MEtdi4oCVym1lN3E+qpS1WctQWeUznK7WhqyBtZToUFH24Qq4NyFlmJgNUZDokliW1CRxtg5rHEBhzjwKQ5Vw7oTi3GPOP3SaekOzdWNj6YGlBGlhnfjlnE5ropR2jlJwoDORROK2e9N+K5Fp2XTpllA82OzK3x7kqGUoDHEMRwOJqX5J6QcIwRsJ8hHQ6TORhamXzxb7BrDuoAybfks11j5W1z0v/yIF4BICQOIqKxeu0Yk4kJQAusthpcjOIGw6e6T4B1p7xsopLfy0uH78l3QkrJpyot4cji9NoTmjXVCqTaZrdsymXRPILct9leQQ84LQkpba+/hRI2UXCxSZpgX/mfr+Nxyy4hWP7xYrg26loQ0G4FBzpKjX5OBcFAXPqd92mTYleK6AyAthC6xGQ7RDnbrj8fVLree0LSm5cO9/ylvxx6SwonmGHbGw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(186003)(2906002)(38100700002)(1076003)(6512007)(9686003)(53546011)(6506007)(26005)(33656002)(83380400001)(316002)(6666004)(41300700001)(6916009)(4326008)(66946007)(66476007)(66556008)(6486002)(33716001)(86362001)(478600001)(5660300002)(8676002)(8936002)(44832011)(34023003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GRFPB1NCXsb2Sn7xid42x/248djyBZfbQmTK63uHpJ8DUFzU8VqLDym+zwHS?=
 =?us-ascii?Q?K/amt8h+PgOVQ0WYSPG4XEkCxKKsRZlCzw8MLnSkxzZujj3YUBbBvmfxg+26?=
 =?us-ascii?Q?MFeCC/GU8npTfifUaMqomMcOR9po6FUTBMJsADI6DAL4cZWZn6vCQQDDFvMo?=
 =?us-ascii?Q?uvQEk5YThQCNShwOxgAXoQ9Ze10j6rZI9AK11o1BpFL2D0I9dH4L0ozBYq0W?=
 =?us-ascii?Q?d6JBIdvFklzQxBHKXQG1G8cV0XCPcqzGTKnfkEXwkuVmgt/jHCrYYyZvG//Q?=
 =?us-ascii?Q?jp5F/h6BzpVyGUa2j30LX0MFq45o2PUM1vXKnsPSAWYfCQa5Pi14W1yOyPOh?=
 =?us-ascii?Q?Dkc417o+7IBQAFvgWo28syJ2ldAt97IKYPnuoNdycoYYrcp/NReAqiiWAO3l?=
 =?us-ascii?Q?eHZjbPAjlMudbCN40TM/W2Gm6w5KuQcZ3PatJW2W8CRphuWYqSDtpyerSZNq?=
 =?us-ascii?Q?TU/M7rYTETTxdD4NJd3nFZDdHERNl+vci1w0ydjra4vDGUXy6oP4MhhUaRLr?=
 =?us-ascii?Q?bvMDeIeWRR3z7CWfSULUbeLLLxhb+eusKUxDS57tREuplwGtN649/DH7OTfQ?=
 =?us-ascii?Q?eEs/jrlU5rndxLnPqzrDh37qtcmeCEYapxyLHyN1x8c0A1gJ8rP+/lH1x2vl?=
 =?us-ascii?Q?J/VOGDfHiBR7/JUV+riziCBHFUxeCa72TeW70dG0++sXvg4DkUaxClkNu9IF?=
 =?us-ascii?Q?ZrLSCnokG6PMxMk4189qGD/kCW1DaQ/3wfZvN4b4GZom4+kWJDcOC7w+ppZW?=
 =?us-ascii?Q?nza746BCHvPmqEw8O8JjViXWa42uDe/Hx7FPRQkkLZSEYqkF+hytHHbdS7l9?=
 =?us-ascii?Q?xAsC7b36/U6NiywzlOV4AFvPs5GwYdyGPFKGff/Rqirt8mSNLJq5cdipUl67?=
 =?us-ascii?Q?OxhkbLeAQcxVgOp4c9lh7aTYavWwg0vNliTL4R1ZCtjV7DMH0c4GCOw3tqLW?=
 =?us-ascii?Q?JHSoc9vNnBAlCdfEEdOMdNp1HAWquFUhFGG31oW0KyVuF+JPWFASuDKdlcCJ?=
 =?us-ascii?Q?PLm/vmhnH3aL5iFMw/1CHH8jW3NL/DkY6jv5PdxuZtKjpEx6D3jkiMCfv1LB?=
 =?us-ascii?Q?eQgd6wlJUGOjBx/KU5XC7utRPmMCPpd40iehOV1nKow6w2hWTVsfN9BO7PVC?=
 =?us-ascii?Q?IBRoayzwLDqxwNokz/wx35Y7/PIYSo/iUd9/2ZGKCM75EBTlzN0UnS1TTfqZ?=
 =?us-ascii?Q?8SumjBHUYfL9PsDrKt8lptRH0ztMHpOC5QGQn+IwZmohHbhRk6IfH1Javp5k?=
 =?us-ascii?Q?JSEXbFioBGyyQM41tKH9cmOimMYWAwkqHhcbj/n6bbEJlEqp08RXhM9XrK4v?=
 =?us-ascii?Q?znYqYF+BmjAuNNEVX7ZThTunSqLCfyJ56mSu/AAaJEvbZLQgtE4lYFsrJ0ay?=
 =?us-ascii?Q?1nWlEOzVoRE82Y0Mr3hsBOSaAn7CYAuGc+EXk+pJgfRzLmkKr6WSkawMl/bB?=
 =?us-ascii?Q?6QcrMIOhwVqrXzwfqxgU91wK8whPDYupb1oxAoijL6E1f9dI8+Zo33i9kIT/?=
 =?us-ascii?Q?jnZmg2uEq3u9q3bnTOsOUtU9KBG4eXEMMqJVQMyAkH6e2QIs2tVykkpqn04m?=
 =?us-ascii?Q?29DsJL1gHn9MyOmQBfIq6VPi1XrgIgB9Y2gOzCEC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Mtuq1uaviJ8YUyZKwZ6XLAL4hMIDBzb79+kdmOe21RVK/pwmLuHZBE9EThfV?=
 =?us-ascii?Q?BtE3+YOI9A48S1QZzgdNPrrt2BUgV69HXBCEen6DkeDvxaWWL0NOmN6pGCDB?=
 =?us-ascii?Q?2Ubdo/wxiTJqh9t9Mky/pCYdABRw4IRu8ztOpVCiYEm1p1BITF/rrBZhls2K?=
 =?us-ascii?Q?9rKgLQ3W06N31au8YFxzWn1EcwbZqrka/D9KW81IJtOOjQKx3BCVY84U8d2q?=
 =?us-ascii?Q?PqNSidilF34pfzyW4XzH/fQlcybDVZ+j62eKzE4Z7Qi27UtPCs2brio0Z3qZ?=
 =?us-ascii?Q?Dx2M9kee0ylC3IxeCCgAgMH69t/J8AbdEiqG2ISn/yyFidO4dhhtHE8MjiAV?=
 =?us-ascii?Q?yZ/9QL4Yy0jpQP0x6e4rEI9Ac4aW88FQ9J3TtxLUbwxSYk0hQVFWpm9YWKJH?=
 =?us-ascii?Q?GHyDWWQp2lwx2JTvCQDA0C32F1Z7l1rgsfWwjuGXq+e5/H8GimWZxyPHDgWt?=
 =?us-ascii?Q?utaP7uwynmXvbMH3OqcPSuaH9y9YC4XaR8Uornfrn3unilVSGfCunUIUCj1F?=
 =?us-ascii?Q?S6gKjf+eMjUm/XUyCqERs8yYW1rwOOoeYwTgSfokgDykzlYPQfPP/6TqBuk+?=
 =?us-ascii?Q?tmzIp9+s5X78/sSHc0zVKzvxxjAcxLmEHIzc+oK8UVE3vm4rYohWxxbQUpL9?=
 =?us-ascii?Q?t80aPqPjXxGtwIVXlnDWX6zOzubVv9c/Y064uv0Bz0emFSlyGJeyKrWHDlNX?=
 =?us-ascii?Q?q6aJPPVMPYEvYTe3c/L6Zw12eIaKVsRrFuS9iG1dIYjighiaavN1Tsp0u5el?=
 =?us-ascii?Q?zypRoxdMuOQDpcuCRCnufs63CRk9tyHotg7T5VPCiYOhDgerzpIazrj5ejN0?=
 =?us-ascii?Q?+QlDNIz965pUsWc7RZIOSCiqw6EbQXd37whWIWdt8d1S8dzce2AbBXdnNGy8?=
 =?us-ascii?Q?K/EJnr0MPYjybCStN8HTnNeH+j1MfRtS4GaFhwriKlJmS2Wco/19BwmXH6q9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e9b692-9c95-466e-3750-08db503d9fdd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 03:29:41.0840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRfYobeYwwwG7NOmdVLBFjXJXbFHNHnNR+5EZousHgPldix1YEySzj3O/23paLZQrh1INTbN3LR7E2EvZBHIVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090025
X-Proofpoint-ORIG-GUID: IcKaZIB0UwKGQqDh32gGsfF_0Zu9EQYa
X-Proofpoint-GUID: IcKaZIB0UwKGQqDh32gGsfF_0Zu9EQYa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/23 23:40, Pasha Tatashin wrote:
> HugeTLB pages have a struct page optimizations where struct pages for tail
> pages are freed. However, when HugeTLB pages are destroyed, the memory for
> struct pages (vmemmap) need to be allocated again.
> 
> Currently, __GFP_NORETRY flag is used to allocate the memory for vmemmap,
> but given that this flag makes very little effort to actually reclaim
> memory the returning of huge pages back to the system can be problem. Lets
> use __GFP_RETRY_MAYFAIL instead. This flag is also performs graceful
> reclaim without causing ooms, but at least it may perform a few retries,
> and will fail only when there is genuinely little amount of unused memory
> in the system.

It may be worth mentioning that no failures to allocate vmemmap pages
with __GFP_NORETRY have been seen/reported.  At this time, this is only
a theoretical issue.  However, making this change lessens the likelihood
of this theoretical issue ever being seen.

> Freeing a 1G page requires 16M of free memory. A machine might need to be
> reconfigured from one task to another, and release a large number of 1G pages
> back to the system if allocating 16M fails, the release won't work.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Suggested-by: David Rientjes <rientjes@google.com>
> ---
>  mm/hugetlb_vmemmap.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

I understand Michal's concerns that this is only a theoretical fix for a
theoretical problem.  However, it seems pretty obvious that an allocation with
__GFP_RETRY_MAYFAIL is more likely to succeed than one with __GFP_NORETRY.
So, this patch will at least make the theoretical problem less likely to
happen.  For this reason I would be inclined to make the change.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> 
> Changelog:
> v3
>   - updated patch log to include details about when the failure can happen.
> v2
>   - removed gfp_mask argument from alloc_vmemmap_page_list as suggested by
>     David Rientjes.
>   - Fixed spelling in the patch title.
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 27f001e0f0a2..f42079b73f82 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -384,8 +384,9 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
>  }
>  
>  static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
> -				   gfp_t gfp_mask, struct list_head *list)
> +				   struct list_head *list)
>  {
> +	gfp_t gfp_mask = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_THISNODE;
>  	unsigned long nr_pages = (end - start) >> PAGE_SHIFT;
>  	int nid = page_to_nid((struct page *)start);
>  	struct page *page, *next;
> @@ -413,12 +414,11 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
>   * @end:	end address of the vmemmap virtual address range that we want to
>   *		remap.
>   * @reuse:	reuse address.
> - * @gfp_mask:	GFP flag for allocating vmemmap pages.
>   *
>   * Return: %0 on success, negative error code otherwise.
>   */
>  static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
> -			       unsigned long reuse, gfp_t gfp_mask)
> +			       unsigned long reuse)
>  {
>  	LIST_HEAD(vmemmap_pages);
>  	struct vmemmap_remap_walk walk = {
> @@ -430,7 +430,7 @@ static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
>  	/* See the comment in the vmemmap_remap_free(). */
>  	BUG_ON(start - reuse != PAGE_SIZE);
>  
> -	if (alloc_vmemmap_page_list(start, end, gfp_mask, &vmemmap_pages))
> +	if (alloc_vmemmap_page_list(start, end, &vmemmap_pages))
>  		return -ENOMEM;
>  
>  	mmap_read_lock(&init_mm);
> @@ -476,8 +476,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
>  	 * When a HugeTLB page is freed to the buddy allocator, previously
>  	 * discarded vmemmap pages must be allocated and remapping.
>  	 */
> -	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse,
> -				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
> +	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse);
>  	if (!ret) {
>  		ClearHPageVmemmapOptimized(head);
>  		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> -- 
> 2.40.1.521.gf1e218fcd8-goog
> 

-- 
Mike Kravetz
