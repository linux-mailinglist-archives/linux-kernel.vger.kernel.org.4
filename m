Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9D264C19A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 02:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbiLNBCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 20:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbiLNBCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 20:02:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BB47658
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 17:02:43 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLOBti014274;
        Wed, 14 Dec 2022 01:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=UytfNc0fGF6mF927YLAgvXdJYxGuLkbynbxyL/fqaPM=;
 b=3GcDsLffNN+0JYxsZ+0QHaD/iHiCIEjaASR+o+nrLaWxo7zAZQwBNR4mj1Kn/3+XpZi/
 VLJYGVq6Sce3uaEzXVCASwJS0nx/3lGSrmVIn+Gmi9rGNWPJAujBVmRDBnQb94JZKSpV
 C1KwRr2y9NKjwoey0CwNO6sOEyl8qOoc0iPvJFNEwZ6uCbXNsZaWh1g3xwZSP8AYgvD8
 B9ZgqgTFWoZFLFPHeENY4FUeI4qnwGlfRgAa5M/9T+kPl1UaMr1XK8+agN4Z6QowJsC8
 FVElvZFGukhfG9R+A+J8zQ3hMOrdxpbWP+gpVrz/zSkf5T4kLOPUO4q3aPxvp2LAeJxE JQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyew8pu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 01:02:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BDNoeP0037311;
        Wed, 14 Dec 2022 01:02:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyekddnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 01:02:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfCHqG6sk6vOr4wHLpMODg26Qu9aG8nUA8SqKUT3SDnrW0a2rX/ZmcBuu+CJuLF3jeGGW50uh6T5CMb6g9OGEcktJk9c3DaT9qi34M1h/F5j4hQer+5BdxpgW+qjq8/F+2F6qZMAOmV9rKndG3oOez+DJbhEn+HYtMv6o4VyCIiWb71CYI6Woz9UeI07WVouj7I2DI0X7C/TVEWAI/SFQbhFRcn1Ti86ETy+6/2HeO2k6YgRfK4wW4vOQH0vLTp3kffjaGc9c8zm1UtoGGRjtDGK7q5VIDyicy69Cje+9KozIiArWcun3hVPgXDBYZhDNq/IAlYPKT2lqJNKZUNgZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UytfNc0fGF6mF927YLAgvXdJYxGuLkbynbxyL/fqaPM=;
 b=gk2WpYkbdDoP+xmmBNpgbxuBCPe9597z6B50cUeuuigh0J/X0zb/hxbbN08MNTTYN/z8UB5xNRvE1PsAxu8M7/hGIUhmJ3Jblt/1mGppTXYVZcE/sg0wjSjCoq1ODFY6P5mAYlR7y/s3PGj3I95Auc/sGsr6lEapyhb9ZBSqfTqz3fxaKYXtIB7kgAZeGZWtiNxmsqUlhSiDcyoCSthtCHEy3lBuYJ5TBtWMi4KlmXk5SP/7J4BxngQhpaVUZaR5AHfzczoxiLAYmIPtJIHfxw3vADWgnF31bXC+JCA4CdDi6xv6LCl5L90gCj1lUCmZHs9hTaT4acawXchtSGTb/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UytfNc0fGF6mF927YLAgvXdJYxGuLkbynbxyL/fqaPM=;
 b=FH0eayFG53ogNGryb1qMqMz1VR0dfAV4J4zzDf1YJoxKfTUjjjYA7odA87paYcBm7I/KXsRtLfi8sRDZybkgkpre3INpYyaI19cYgAl2tjPHmtyFDpZ5lWgr7xJFrv/iWgcH4O5TJn8ujdaszol5WxnMVj7umL6LeKJVW6R/+R4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN4PR10MB5606.namprd10.prod.outlook.com (2603:10b6:806:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 01:02:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%5]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 01:02:28 +0000
Date:   Tue, 13 Dec 2022 17:02:25 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        willy@infradead.org, gerald.schaefer@linux.ibm.com,
        sidhartha.kumar@oracle.com
Subject: Re: [RFC V2] mm: add the zero case to page[1].compound_nr in
 set_compound_order
Message-ID: <Y5kgoTVteXm0QFgT@monkey>
References: <20221213234505.173468-1-npache@redhat.com>
 <Y5kPKpNp5qCnZEWy@monkey>
 <CAA1CXcB653kDtF90oWUgVA3TDUrJHac-WPe1HdsQtRwtN5B3gA@mail.gmail.com>
 <CAA1CXcDK=bpAbmkwyssja9d7eA3iEtNQ2aNaQo4DkdjV3YvOVA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA1CXcDK=bpAbmkwyssja9d7eA3iEtNQ2aNaQo4DkdjV3YvOVA@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0331.namprd04.prod.outlook.com
 (2603:10b6:303:8a::6) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN4PR10MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: bec2442d-8f9a-4fd5-6222-08dadd6edea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dp+MS0ag1/7t3ztk004WVMKH6VX2C/PCj5gKP2PIJ+GETmEyDdk9WxkhIAmnUYcxLOpqcQCQRzqAMQ5PEZvx6nfx1UHmMH1OtWMXLc1z4p5ri6q5mAlIKDBy79JMGk3QEP5/ysnFaORp5X6M1I3D9kl89VeQJWQoIbVhKVWVqmbxxWkiq11g/1T+dTmRDpaWX4DA7JhZ/NlXZs/R8qErbyv24PIOhRKTwkUqHzH4+RcDJrD9wQtiR3yanYs6GKZZrPmC0QdkkkuTrA2wwLQVDVLx8bFp6KXU3pUXLcwwHiGEGTJFRKyq9K1Fpmiql9uNEDp1y4iitrmvNVn1gnCACX2I/CWLvgIyw7MBXfUQAfWIynxbcyld60S7maY0WGWEFzvN8MUYIALXXJPMaAZ5TfSy/KLLf0D754gFP/dUuvsCxftbkzno7MpNyZ8gUEppIeEC6w0OCNUY31luu+cptRzo78XuMWxfldeBCJZDk7P803wv07SnPBghjXtZjyCuTM9NAcFUjFnKGtq5IzpEuC3MbqnBYQhSpMCThqMJyQed5xq4FDZ6Zdj9bk2BFAHbQ7NAtM2qYL0OxGq3HL0leJQqgIYrSve9OiJemsJizlSfIrMgijeqRxt2sEExiqnjrTkHnGP7/FhouQqD0Dg9Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199015)(38100700002)(33716001)(86362001)(8936002)(478600001)(107886003)(6486002)(6666004)(66476007)(66556008)(66946007)(4326008)(6916009)(316002)(186003)(6506007)(83380400001)(9686003)(6512007)(26005)(2906002)(8676002)(4744005)(5660300002)(41300700001)(53546011)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x+3bMpKxx9aZHm8/dHgA5tz8/xtqpg36fgf6rcWogKhIe1fV3AMuKlov7ecn?=
 =?us-ascii?Q?Dhgh0evXlLpaVYo8agS0YMv759frIPPbkB3ev9/UyYqP0G5keYnDODms702V?=
 =?us-ascii?Q?KsbAghKyjA76pv0xpAcccJCguTellqRnDArT5oXwGkLH8OITBmENzvOTO3vl?=
 =?us-ascii?Q?7z37T7CWd/4SOtW1UizJRC0FN5O0SpId+FTEK4ihDh+u0QhVDFtCUpmyeqEk?=
 =?us-ascii?Q?l8EiZwyUhdw66s4w8JjN0pZZqnzXJG2Hy59Tz63QCLwx5KLe+7bwQZQzlXs0?=
 =?us-ascii?Q?ZSap6c9X9S82NidChWUw9Ip8IdlpXJ/y9FoOBkVGL/Nih1y1w6vzp6R5CGUR?=
 =?us-ascii?Q?GonRPfa+zJGX0BUo+ZyCjBPWc4yfNenz51GnlBoLfTTinU1pUhJX/lMPscII?=
 =?us-ascii?Q?7Rq6A6P+5aHFVnjlnQ8uWssn51djTs9iA1VT72pC4UwXJxCOtbidEpw+4LZW?=
 =?us-ascii?Q?UgcnR9nHeMWtf/RzKzqnajYNtq5gZcHwgVcbBw5q+qJat1x5qG2xv50qt/GA?=
 =?us-ascii?Q?eNDJdciPXVB9PsNT0qKdsADrFLGp/htCdSG3MUx6jte9hAfvh9ng3oXuGtQN?=
 =?us-ascii?Q?pIzhDgBylmwiPqo0VdXK6QSvb06P/4q42x1njcKeGxGbKuFUYjWhxVeyKP5K?=
 =?us-ascii?Q?D6I5X+ZwDipVGVdw1Lw8daQXg/OLoeWkeecTmirmJkdBTd0nOlWs8v6ZDFUW?=
 =?us-ascii?Q?88CLGluLmd8AmmGEJ1aNjy/RtRslKSiWVAoM0DSjyc9GHD/930FaoIaUIj76?=
 =?us-ascii?Q?FJxV0kqwXwydnWpNg1KTsEFNO1HXJCrPo7mfyeRFU5GqZwd1Zd5EGz7VFTWU?=
 =?us-ascii?Q?e04g9DdnXxnBOOOBj4Y5VB91ZSNqcyE55CHN77WKwA1MsreWG0P576bvA9Uz?=
 =?us-ascii?Q?pqLAuWloRZxk1rkJMhQCQ7g+l+RwtwvP9SzXMGPV/bNJNZQM8KO1ZU0QDWXb?=
 =?us-ascii?Q?8sD29pk2nKDV0EOeNPm1LQkuyLlK5M/1UJZlYMDPllMquW8/DH9dFFBkULyC?=
 =?us-ascii?Q?uU3Yz0wnH0Wzx1ATmTV3g5C0+x5OQb73gUP+zj88Gct/HZ1qg5CnLJ89Sqof?=
 =?us-ascii?Q?yyf8UHfilXDL89mF2rxcU5b4HmkTx1zOuPuP+obBSP4Q+4n23bfbQietbM1M?=
 =?us-ascii?Q?mSzmpf4fYnZHeL0lfweOZ31786MISDQHAFMCb9ivMOE/cIUk9SyPeiU+bkCc?=
 =?us-ascii?Q?2zQ9qXrss9Wu47Ltx1hOt9Ha84Em5UiNIPRLgsb5k24TnxDCnoqaMSpMJkDn?=
 =?us-ascii?Q?Wa+g+22SV4bkacNpNHmHIs5hVS8bzD5c5NztxIgsCyag+f7H4x/CKyi0iwyX?=
 =?us-ascii?Q?WMQGYvwKp9dTNmX3Tj8//WVpnUy40Ijbt1e/fqxEU7VPvh7eaY6k8qEDEhz/?=
 =?us-ascii?Q?Qh6EwKRg7/8bRpf8ZUqK9H3WyiSzBHEQKOs5f/Qv/ICjH4C8kYb78Gl3Pr7q?=
 =?us-ascii?Q?As+OpKmi/Eq5XJTkYDNq7r4jYT3toERph4y2GATvrx1dIbb2J4gFE7Rz8LZu?=
 =?us-ascii?Q?y6Tp0bol2mUKbr1zGaQ7LasEVT9XHzDzub2+uHtIuOXjB0bDxM8blaWr5+y8?=
 =?us-ascii?Q?45BFc38leSlDtuMWycPMgO+g254IqIqw9dQ585VPFS2DY5SsFJpCw9qGdP+j?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec2442d-8f9a-4fd5-6222-08dadd6edea6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 01:02:28.0901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KACEz7ejZHV8iax8IGsfukq944dKd4mzLpO+CktlvGerjg+B283aiLyFnctJJJOHx/rbaBapT2/ShzBcfbTIbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5606
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=998 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140005
X-Proofpoint-GUID: LHuzE2SRxoUta4mGKGc8FiKwl-CeiaN2
X-Proofpoint-ORIG-GUID: LHuzE2SRxoUta4mGKGc8FiKwl-CeiaN2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 17:27, Nico Pache wrote:
> According to the document linked the following approach is even faster
> than the one I used due to CPU parallelization:

I do not think we are very concerned with speed here.  This routine is being
called in the creation of compound pages, and in the case of hugetlb the
tear down of gigantic pages.  In general, creation and tear down of gigantic
pages happens infrequently.  Usually only at system/application startup and
system/application shutdown.

I think the only case where we 'might' be concerned with speed is in the
creation of compound pages for THP.  Do note that this code path is
still using set_compound_order as it has not been converted to folios.
-- 
Mike Kravetz
