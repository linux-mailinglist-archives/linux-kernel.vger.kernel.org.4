Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427EF66CEF7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjAPSjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbjAPSiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:38:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D6417CCE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:30:41 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30GINtE9013456;
        Mon, 16 Jan 2023 18:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=S1zgXRVM6tNIyqVnYLdkAJzgZfeC+2ueH6udzxSSJew=;
 b=BiES9JW1fQ9tUoNRBqRh6uDzbgpzJe6FuWmHwxjOIG/hAbQAovrGqwAVbRTqClgzRJ5t
 +osQGp7v1O0mkCDE2hJ6gZ4kjiz/vndeYvkqSJXFE5CbIT/hiYwQXC/XBbkYAPC3Nkke
 FmtVbbZ3clJJJs6uh8pt+MDnyGdhSSGmQOUkG5arec9kBip1FustGb021jdeDweYYKye
 S3mvdrQul/pT+PrAHm2Fr2h3RgbhbJLTBicR9mobi95VrFtFp5YBP/RvZ5zfpPGhmEGt
 QP+VN3Qjk1P3B/ZtygSA4rChfGYgsw5ZPpLiKz5H3LfSJrfAXt8HvnkyVscJAOahOppv 7w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medb8a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 18:30:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GGovZo028388;
        Mon, 16 Jan 2023 18:30:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2r6mgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 18:30:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBC9Q6X+l0iXMPaIEN+2Q7E2rIHfvNLBWqCJKTcVhXXA09IWdKjonwmZRfoxgotfjBCvZRefYNhM+/XnAcGmdDLHBkEc/X1VqD3bdYody+ZSZaaORiUXMBo1SU4/cX5IGVtQ6TtKNTTgDOsG3TXrhBSCHFdLo6l0KV+PP4mD2eGFt1ER3c04AQMv5xmfudsf1ZJspfa2alWXQGwjlm4ayRNYngV/JLcu1McG5pYGIsnH8mec9RY1S4ulkpf02OTPsU+rwoS8t/TkyH1NdMmdMrfMcGulgaiHOrH5kfxA4r/O11XJm+hWYWsWf02g/KT+4RjqYCkOXIt4L2FBQgKxKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1zgXRVM6tNIyqVnYLdkAJzgZfeC+2ueH6udzxSSJew=;
 b=SmQmtGa88QjFyb9XdHd2l4TUD1qiBQxotcF7aN11EkkjOf0C1uDR0FNFODfoDogCYgdaD7Bs8oq5Z+BanLCP5ppiKYtucJ6cY9a2Jaq1ZtKS291FJQ71ZKiZv0ex5QR864n1Q+T+Dg94u5Fw3x7L9MqxkHeNLkoH3CkkA0UWdIdQlQwN4BHIRq4clnNQuZEx0WukC0ZDw8l40cn8RNr2q8Y3kIM8pUvlfqXen2t2YBe5NV8/cgujOntS4qSjxY59gR3JNz2VAwG343hO9+B0Ki45yyL2zwx0kFhCLROColHgn+vykLtxtEnKi74BKsxcinMVHMt6JLQlWMRvbsPNhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1zgXRVM6tNIyqVnYLdkAJzgZfeC+2ueH6udzxSSJew=;
 b=lfLmhkNqu1HnjFKwJ+SONZnFcGQTfem9cfmJmaLJ6ACj9ybYFNolO71m2JB6lTsViCooEY57CZ6nn8YoX+zlztmKJm6n7d/pYJAG7xuPcB2Sh4/ULOENZi3NkF38SNsJdr4Iqj8glN1G9Bh4NdKKAMMSpK8KNLvf1rGjTuZrKok=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB7028.namprd10.prod.outlook.com (2603:10b6:510:281::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 16 Jan
 2023 18:30:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.6002.012; Mon, 16 Jan 2023
 18:30:11 +0000
Date:   Mon, 16 Jan 2023 10:30:08 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Esina Ekaterina <eesina@astralinux.ru>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH mm v2] mm: hugetlb: Add checks for NULL for vma returned
 from find_vma.
Message-ID: <Y8WXsOaR+pclaUNp@monkey>
References: <20230116103947.73153-1-eesina@astralinux.ru>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116103947.73153-1-eesina@astralinux.ru>
X-ClientProxiedBy: MW3PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:303:2b::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: 62fd6bcb-2a06-44b7-26ab-08daf7efb3f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6Jubeh2dXI7bgdyYEYenyzHX7xeCdlkwBLBp1CZwiTD7B0o500B/MKye9MR57oLv1USri+4GxtivXa/+Oe4vySOuO3qjsMJry0jMxrqnmQPcdnp05mCZoAm/65tvMxlEwZTCJcFq/xKNzkLh/+6jYZc4PPYLr7eVf3yhFe8NqkTKRcCBi1Un8g4cQqHQ9fshEaYpvyFvLeCk/9ZWe1pZ+lxyEla9oQDViIBipugRCFOpqLtGjW/EcJ/A3HODQM3VL8z6Ly3U4DOe6Mossevx45dFRaRqoRiE9XOjWMMQnNNWdZcmCW98SNH0ypluf35yp3uQWafbmkA5qLSU1sdkQWGfQ31j48Zvsv0sWC+GRAom9dxJEoP9s3Mqg8K5ST05aERt/VnfQd65stIex4GaGtgsqrofYZcTN6BCkiBQ+tNjfh78ZHQ3eJJQN+83CorikTH9fg/qAqETkqERX9WCY5wwnCKQ9YiRBiTjS1B0JgEr66Rd/y0NqN+gKaWqBdfgi7mloxMfLa9UAL1mOxTvM4UOD1e0nqI7K0MHUt6fmaiMkTdbT+K5uN6laNQDdWRpVr/HF4Luo483CMcP/A6F31yrRp0WdlNENCOHFaKjFwII/C2bljoVn3soa0nOL/UlSNqNFSNCXYUQIGKgClUI1dNCPFMBoyQeMSuedHjzW2x5B9bHA6ht4/RJ07TSfwV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199015)(33716001)(6506007)(26005)(6512007)(186003)(9686003)(478600001)(6486002)(44832011)(4744005)(2906002)(316002)(38100700002)(6666004)(83380400001)(4326008)(66476007)(66946007)(8676002)(66556008)(41300700001)(53546011)(6916009)(5660300002)(8936002)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SoscocU/FKGr197tYrZVtgCPWPmv4h9XS45/jf1y5/bTXm1ATKItPfFjQHD8?=
 =?us-ascii?Q?bxxXR4G9lav+m1WNa5o3NU3dQ4oxvW41L5zhJY1W+2baWNVnn4IHI83mOYO5?=
 =?us-ascii?Q?e7Loh6tmnXpqVfwMcsjm//f4xFD3iuW3eDn9W0SitaZeb7QbphTEzGjIKeH0?=
 =?us-ascii?Q?99OV2tGpuL4N+AqYTipKLU0tTb7RqIDDkjm0JbewZToYWsxH1L/YIDreRBLM?=
 =?us-ascii?Q?s27qfAXwjpRG6jMK0S0kZUV/pZPkz27jqAvDiIRIA0h7lrJS7fBv92g6KUPH?=
 =?us-ascii?Q?3OFM4Kcr2yQjXiWYnk894M3A8ku8OTm5tFh/+gp9iyZfdw8Cwulqfjedgzmk?=
 =?us-ascii?Q?kRVIfwgh7aZuMj0QfoUOOzgX0V33Mmj8pmT9jlIEqytRRxOZmyymnp78aNlP?=
 =?us-ascii?Q?2WQfVrLBjIvVnTelP0dcbtxVeWmeGoYUsSUx2FGoSC4lTXlgg6ePpvAmw5xN?=
 =?us-ascii?Q?yaBaQukHGHFJOZaiteMn/+7uUCVg05j9x0jb2j0LbwxAcA+jsV2efRYW6qaL?=
 =?us-ascii?Q?l6s3Rxk4U2MUcoq1B65IvXARa8gs8FSxx92ImUpTujTPVbNMHTzS7W/Svzze?=
 =?us-ascii?Q?4XrSB+62/YA+juZimMWqvtK9G2zzoQ/sh28vv7poZ9ZOEbYH2YUglz+BGdSV?=
 =?us-ascii?Q?OS3GnEUEaUrXhj0bYynCmNhcBW1TT/oLakqBS8ai0EA7Df+uJESeZqDyJ8La?=
 =?us-ascii?Q?Ty8KiZhnZfyceK/q9WsWvyny+Xl2NVN8rLIl8On1khzkkYgv6iXW+bo05scj?=
 =?us-ascii?Q?KlrTBzrRwOOltfZI+fEQBovxw6CUCtUYfiqlwSpprectITAeqTFd62avkuOU?=
 =?us-ascii?Q?FcTO5UoCugq9aSurQTVeckLCMPFfDQpcMfM/2cItRvyYRWMGf5OS2c7RvNiJ?=
 =?us-ascii?Q?SinTdAR3Hr+4peAg/raHFyIaFUyWV2ebjVnU+vRdfVaI7bGInwzkojC3Zi1p?=
 =?us-ascii?Q?5XEXcga5+VX/QRz7SCeJU2XPbbGdgpCkuO/3fIPYQDPqsKyhPMj5po04oPbl?=
 =?us-ascii?Q?EvXhHHhuVYQn5RApSXIIYCMFFFsfigvz7Q4jb5LhTQUB0MwqYBkhNUGlicIg?=
 =?us-ascii?Q?Zy+8HaBuNdV7i/ixRLaPT5ydlWL8usM6N3FBnTtMsNwM61XyF9fuYW9mofCK?=
 =?us-ascii?Q?oEXBy7789zYLM/MFeqGNVxNzHCRS6xKin+XqdTqRSiOmlLBye4qBdfetyeyW?=
 =?us-ascii?Q?WQMk8p8NFaemnWf0ryhS5uRi2IDt9/hVC331/7RxUD54+H/ldMRwVnJCSc4E?=
 =?us-ascii?Q?sxpYaDIwQv9HkgPjx9PJ5I++MTox05CSSnB6+H5waQJfzAY7WpCtOr3O+6lG?=
 =?us-ascii?Q?efsO/phbVm+SPvSNkNax+J0eLKmQUsViXW4MkV3olGUGdA4IlhQS+A2GgeGt?=
 =?us-ascii?Q?vaX1zS+h2UMfUhYEUpLeYIFO9ciKC03ytp6aZcF5wWrZQfL17trEzfCrLL/d?=
 =?us-ascii?Q?NqamD/JcBs8+fTZhot4r0fovxF0hH6T6ic0UzdrmNI8mxbAJOxFL8M5gcGPP?=
 =?us-ascii?Q?YLkrRSMBFIEnFoNEUbN6zsijNUBZwXQZl+MPC4kgufEafPD+5BpCBKg1/h9x?=
 =?us-ascii?Q?HKH9orlIrfb4wGTFtJcYDBqWIagHZbXdaChJlR2IxH432//ZOadDlOHhjoOt?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Qx61PkzfI2tqa5etq/cicM5/sDRrSuzz+NH36PAbjwpTxBs6WF+zaS4i2kkrVVGI7cBs99oOsvbbNFGUe+dlj797l0hsSobLmTSqIZ2tE4Qb9suUx7reGvOUfyJa3Cipj5jTYyWM95sAZsujfXVs67tRleXZTmJTtWINB/qvEU0Uv13mpx7UDwRa6fqLxRK5W337bp1rHvFE3rDwf/oqo/mf+vuuMJsTF078+Jl6jU1TxAONJkvzqv1EL0PcrDUXY7eA/3mriqMzvd7eYBXwrT+johCpkjLwnIP4RXde9tMs2t3oY3Nh58B+EqNIMO6z7nV+p+FDnkwrsjvcbRDjzxgIIsp1MSCKXjpakmeygfcHJSAm9Rc3XnVkUZ0eSR+rtgwCDirXRVKoJTlgiAuj2CRfkZ8LgZPhGt9WVAwTXSD/tWV+9lwfiyHE/6MvX4dOQ+Ddw5sjuTQsquRrPaEvs+Zs3f2c49ff+PsRoQbVJDDup55Ao9deT2kak+d58j/cEFLPT1XszaeY+yeRYv3rWoCx7YcpHn6MiG/x4+30hDEB4liyhiaeLAYYDoqjk8TLkF/YtepgMrhtU4q+STXcgLLywou09Azp3BZ0UKhJSrdUENfN+O+tQYmjUBzRm5zYEUsxzmBD8ftS8fbpI32YZ8nd3SrIVLSzOcHhkfjpE5M9dxap5Au9hnn3ZGgbjIMSDLy5M/20/LsYHGE4pttHbq54PffuPlZtrbE9Zu0Jj3AA4GkngBbqHHtjayknWkEVl62UphBW9pF63jtBaghqsyZaaGrps3qhWFwL2XtC+Bg/NnPpof2+ujnnYHQ/sW0u97MDZ6muPtPcRMubQ2nmXLgNSE1/TNmSQKyt6ciPeUlIkL6aOpf5waCBRQRwA8vvUlwQM8AEkPniw/VSRoScexJLzRub2gOPzUDwl0n1y88=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fd6bcb-2a06-44b7-26ab-08daf7efb3f8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 18:30:11.8880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scc8hUGBMSlqr0AXk2pvps1KOcPzIjoddqIPAyoPdgxn9RYfopJq/nkN3qb0RiwNh43qEMJZGUBn0BOHrLPKzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7028
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_15,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=633
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301160137
X-Proofpoint-ORIG-GUID: PB17w4UpP0An-PTYrk2zqbmEL2g7-dno
X-Proofpoint-GUID: PB17w4UpP0An-PTYrk2zqbmEL2g7-dno
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/16/23 13:39, Esina Ekaterina wrote:
> find_vma may return NULL, that's why its return value
>  is usually checked for NULL. vma should be checked before dereferencing 
> 
> Found by Astra Linux on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Esina Ekaterina <eesina@astralinux.ru>
> ---
>  mm/hugetlb.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)

This is not the latest version of the code.  What version are you
targeting?

I would claim that find_vma() can not return NULL in previous versions
of the code which this patch seems to target.  Why?  This routine is
called with mmap sema held and we know addr is part of the vma. 
-- 
Mike Kravetz
