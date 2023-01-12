Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C40666AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 06:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbjALFKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 00:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbjALFKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 00:10:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD7B4F105;
        Wed, 11 Jan 2023 21:10:29 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C4g5V2020253;
        Thu, 12 Jan 2023 05:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=ppm339U9d2nL/+vfpskCOWZp3lmXL3nB3ypt0v+ucow=;
 b=lk9fQn4mNNtFGJVv9LC6E7nX5fxUuJ7zLmUvIHK2SU7jSR+Be1YDo5NaYjBhNugZJ1o1
 QQhOjetRGCxm4yFfFSn7Vq2QANKzu40Smzz3FJFydzhZFQeuavfd+iUICc3mJDoYgfca
 BiFzA3uErXf7HEECphnjpuY/rZs6YvkCONDreSBIqQe6Rc/0uWQr261cTNaNrcOX2GQi
 Ru8dQgrxWYwBKLi5d2dbIMW0MUwq1Y7bADDJv8ARkxsMTvHcKpyaGeuDgiRgH2zQpzme
 I09QMqxFowK5waiNZefaHFA/xXM6NxpouOXytDpjW2iNfsr5JLhRw3Q1QXSsnRqhbrQR yQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n22x00y99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 05:10:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30C4UCFW034211;
        Thu, 12 Jan 2023 05:10:24 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4fxkys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 05:10:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0vtYrepc9FR6xqBwMrX88Nu1ekuAEcR+8GTVRQj9veQV91ZV4gX3sZKP+dAdh3Qiyiimt2mL0uQs1baOkPUd58LsewYozuxq9anCOCK8pfCpKs2kBZcYXWjRvKMt7E0O8m96YkIZSACQ7tBI4/uzGvzLJ/hVLiwGsgL/dzxdjE6ifAfq7f3Q7WUK/SVzRpL7tr6dU7kvZ6mshujUzvPP4dNJVb/aFGyirPnQUNm4US1w0qnIwc2AswBP9GQCN48VJdVVnHbaeRoCurAZpnXqbHuSyBbv8SQd2rWKH4SY2DtqxmjiE1kitHeJBFTyoxHNAHJoWrvYEnpHmPcP2RI2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppm339U9d2nL/+vfpskCOWZp3lmXL3nB3ypt0v+ucow=;
 b=MC2iv8OT0CYP22GEijp01EF5js6gO/n9FZr3fplJt1UPoumoLsdBc90FzjSs+B/bQXkgzTKvCtadK7YRwWjPn1u6owkmiuC5fcL42sHa6/1JiIFRo/tb1aU1Qa7b2C0E7IKTLbxZt+oaM3lNEpClX0xIBazGH19xmTP4Y1pHvZH0vjLzKJDwHuDyfdvas8Ar9A3dIp1KgyihsZlpTsRJrPJCcZc/M66hzlPZNhlpfZdrgpKNJaMFHNt+0w8E0tJJOAHXDmf/RKwpRJ2IcO5BEtsdVIxNirxccWiokV2dmmRuoFcNZu3TI6lNds3Hp3kYw+4QQX6eO4Ei5pTYi/6TwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppm339U9d2nL/+vfpskCOWZp3lmXL3nB3ypt0v+ucow=;
 b=FAR+kZ1uKtolz6P+XfpLH7fLTIiQKSBq4VGRKao2UKfpo3We20O+W88qreqKU+gsW7A8s+h6Dix0Eo6b4+UNcoWjMNjH/Oj0iVkNo6RHIY97zfXm9Az8FK2a3iVz/0EK7j4gvNOp0KtQLYro6g7HQaw0WrNACMEejfVIqo+ebZs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BL3PR10MB6043.namprd10.prod.outlook.com (2603:10b6:208:3b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 12 Jan
 2023 05:10:21 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%8]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 05:10:21 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: 3w-sas: Replace 1-element arrays with flexible
 array members
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fscguyms.fsf@ca-mkp.ca.oracle.com>
References: <20230105004757.never.017-kees@kernel.org>
Date:   Thu, 12 Jan 2023 00:10:18 -0500
In-Reply-To: <20230105004757.never.017-kees@kernel.org> (Kees Cook's message
        of "Wed, 4 Jan 2023 16:48:01 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0114.namprd05.prod.outlook.com
 (2603:10b6:803:42::31) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BL3PR10MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ffd0e0-4025-42fe-35a2-08daf45b4e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2VDAf7gFfn+GuDDIQbK9yGOxcFKM5+ERP18bSmCfmYWE13VM3EpodxrQwekG9fIL9hgmlS6X0KLq/w1YbyXGZhIYYu67XixlT1lGBLU7uAVfaD1pofDPxKcwHXp3daqVAQLkeHBb+WOlsCwNs9YVnrHRb/cqP8joxvsYv76o2y2k3oBgmQk1R6z+3dDEQ3Y3XtXSPYVGe0YJQBMbVWAtblyeVa1MzCBCy6t3TGlUDFTF9L04zH8MF15yBy0cN1JDZ6gpn4knErPYGn7kg2o0+x3H16Kr2JeoFBMXp5GFDaDGIWYdU6yb6SBxKQygWSRSZDudeMz0xYSK7sXQIcvx6Lm9MEjJ9REdfaX0SusFAxqYCNKUKdUYc5O64dOsL1LeYQb4T+lJRYLaqFiADYLyjK/lvEaGxq0nWCcZMPIPRouw9U2l/L0TEDTeX7hcA3JdpNG1mrxNnKy8VeXnIFHBvOYB6k30y5WOFRG0InSTA+aX9nXWvySMXcmZQp2FSMWEDVVdSIGrme7hVoIA4puS14hIl4Rm83nCtRGwyoIjbtZN7Va5DfoA5oTMD+2j7WlwnAt2ZOpP28SN7ncNoR+ZSAEuhRwgkp3SQ6WwnOOtf5gRznLh/vI3jkGuwHOizPwWVZglNZTBR7nCqMlthjn2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199015)(478600001)(6666004)(6506007)(26005)(36916002)(6486002)(86362001)(6512007)(186003)(5660300002)(54906003)(6916009)(66476007)(8676002)(316002)(66556008)(66946007)(4326008)(8936002)(41300700001)(38100700002)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R6AZlxbsLC21IhiDOCFVP4TwT8OMiNq7OMXSEVnTTLrJFa93GlIZ2eqt5gzo?=
 =?us-ascii?Q?FHmPx75e5Aa13LfMqQRzR2OuWr6Sw9L8hnAjuc8PznHU6CTewUUY4mXRpcnr?=
 =?us-ascii?Q?Twgsv8Hlz7/kesx3XLusgzXRxxKp8Zy5EfQQA8rQRla675xsyVxwb2XNx1BR?=
 =?us-ascii?Q?7GWY8vjYSJ2NsCgx9kkOshHJizw8LZLFEk3giOLlS6OvfX5Do26sklmNDVWf?=
 =?us-ascii?Q?4QsXYQNUQ+7tIwdBh+FsCw/uK0z+xNfkg00+WTHW5zqAIRo1iTo6QRthCzZD?=
 =?us-ascii?Q?KoqEZdkUbLr+xF+ikZdz22yT+1VMzoooLROq/vebcnMI0GwqF1x6tsgqt71L?=
 =?us-ascii?Q?YQ/AQVaqVIbhXgQYzOK4G2tlbQ5nq7yR8i7ZVziipsz+thXxpdnaXfbsP63C?=
 =?us-ascii?Q?nOu5VMvrVjHj0tNkelp0YkdYjFxba+mEX/43WucQDvlTyUMUuEYFFDlLNd3g?=
 =?us-ascii?Q?Cdz1mST7hEREjz3PIjY4iE4jPKXCuMI2Cy8lNyLXYcGU5+ZpG7R4la22aO50?=
 =?us-ascii?Q?hH83swolIR+AtuPKD+VUEUwoebhO6eNP0uwg/dDJz8SybyXXV3XuPFzAPIPY?=
 =?us-ascii?Q?n58149hN3vaus0yh2Oa0fyg2GOLC+q0e4Fo6foenre9Xo3xItPzFH2GPqqlI?=
 =?us-ascii?Q?HP7233E5wa8uyfSgkeGDGGfN8MnVbZDsp02/bW/+UY8hnDXMODKvE/JF7Mcw?=
 =?us-ascii?Q?4y50GXJuqImm+mHteQn+ymkn9mYnFUJLtJCv9z7xaoXY+NQtMF/IRLoq/8MN?=
 =?us-ascii?Q?tbj5Fo2qCJnrSKcDquJTq+eo7M7SruQsi+GifPf2TfA2LeG1qmw7AU1m01zy?=
 =?us-ascii?Q?gl6lnfyl5mL08W+oeywlF5KX49G+QAkKVqYbNZimWV0zfhB8fOw5DLInU3uE?=
 =?us-ascii?Q?dN7WsB+1Xo/Q1YLERfBbSIGXCwM3AFgEswvFGD86Yzqu4oa4jPN5hLM+D+7C?=
 =?us-ascii?Q?8gJPnAV0H84a/PF6/+D+Gp7rTkm1SYXpBfrw3U1s+/PWbxUP66pTXd3syCNP?=
 =?us-ascii?Q?ESngovQ0832Znbn73fgUjyQfLIatIAFjN5BshSvKZLRfAH21FpLUQRTsW+iW?=
 =?us-ascii?Q?r7WFsRD1zTIERq56cTvY9osP/Gxh7zR9g13ztNhyY+68ZtPeKmZnpqJG7dft?=
 =?us-ascii?Q?nX9zL4FA6gXPCzmiOqvUuZx2yJ2JOlY6mXCKr0yJNIa/w1kxjmtH7UnkJMNE?=
 =?us-ascii?Q?+AlwWCuoOKWuVG2lSRp/GJ2HEmcLDKAHGO8jR96TcAlNq8wvs/AknN8xAxVK?=
 =?us-ascii?Q?gHnoyLxsOsxDkR+S0Od002vIZFLeyIRxD91hFAcbfv8xjT3DRjM67ZwqpsMi?=
 =?us-ascii?Q?n9RgT/2Jrt03SEP/O2+ENW6q5556G1InXMCKPiYPaSf/y+pKJTV+ewX+I1YA?=
 =?us-ascii?Q?f1BTu0MF75W36AdSzPQHACcVnkL7lCF72M9tEuBJA/074SWOLI+747AScfW0?=
 =?us-ascii?Q?wzcHtBXmo25nRWEaP8mZkdPzGzFk7cAn3Ecm0lqjo/LlSIWtzbM9Nvtw9unr?=
 =?us-ascii?Q?yREyI6wqkJMWZgOP6ilNrOOoL2tT0nFy4xxYIUPLctrkkS1rscAXJ6R/dskP?=
 =?us-ascii?Q?KzeL4RSrAlDxqfpNd2GvxpsKG+La/h7JSM24lWonsePqYXzJXfmOZL85x+mF?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LWVc11zpGPv39N7bHzCtWcyrAAK3TAwyYJZbLxWSEQzbrjNNKaappWeH8I/Y?=
 =?us-ascii?Q?9AFuh8bpoQ/OkEVe9Qg5n3IWB3suu2npuynsWgK+7tbYWGISk7ROZRnwgiRY?=
 =?us-ascii?Q?dUeObj4YrnQa+lkVAaABEgxRdVsjwmgTkcgkctnnaMeIznnYzpO6eQCI2LbI?=
 =?us-ascii?Q?1Do5ziPQw9taQUa3GlP4b2F/zvP8ijKUb7hVvYUKVDZgAkBXlRun8nRq9RiR?=
 =?us-ascii?Q?p81p3PVrXqZSwjhxNmoMr1zEcdA/YzH24X/5a+pgxKZIElLZJALDLHrg1+pP?=
 =?us-ascii?Q?tQKaabLoty6YIbTNIRCH9ThqMYBJEgGJIUSJidslqVdS3w0QB0RNnASYRvGi?=
 =?us-ascii?Q?4ZobI7+vXdhgy5KqcEf/HV1VKGGNbljZWnfXbI2UaindAB+Wrjqe+3d6jSFp?=
 =?us-ascii?Q?CU9a/boaxqMRWJ98ayFp5Qws9W5VX8TfavPx17Xnvvy1x8BuwQJvUBEH64ib?=
 =?us-ascii?Q?lL1w8pr52megK9LzjkhdLAo1HY6WMw+jvGQRipgYketfoQPE8942zTOPczD/?=
 =?us-ascii?Q?YTsG5FbKXfvWCJSfo4gRl5gsxkMXBXDEeA8XodHym4IElMAj2kVMxjp/9gxm?=
 =?us-ascii?Q?jqnvPcuUtqu4s0b2i83at+dDoyJ78ZxCy80zQxyn+mWaPsbSE2epz0AJs7uE?=
 =?us-ascii?Q?idzTglQLB3kdgXJzFynpRJPoGD/KocfXfEOxh3FFZCs8zKY79mgg2qroHP5m?=
 =?us-ascii?Q?6CtRLOApSBlF7GnVuNMsYn9ypUfPElOOq+zyKRsEvVFSk6pS2OOVL846Rnb9?=
 =?us-ascii?Q?TXQiXWBtfcaCNC6K6il+Ep/UHNeYG9o6ZTbWTNRzMfrKCeyvVsw7y0fKwLt5?=
 =?us-ascii?Q?zb+DeAsReRj2a4tlL3wNcWlKZfXICcIsFG8p+c8BtbFW0t+u2EZsHQk1n1oT?=
 =?us-ascii?Q?jexUVkNWkKfIX3/ebzjIL2jo7JmLDwXKIOqx2LD8lfQOJgO5bFHqYT0LJXxB?=
 =?us-ascii?Q?hZQ8LByFA3hWBQ4F7SLcQXzsz3jxox3Eyr7tUfDVY3A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ffd0e0-4025-42fe-35a2-08daf45b4e1e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 05:10:21.8025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygZStNoDCLMMzky6FIZy/ypZZVEux0jifyRem3ioO9lQt77XoJrXmMbvu61cMvF1qVSpjKC8VJm8OBrns6hsb0O/uQb8UXxwj++QdmWOZpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6043
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_03,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=971
 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120033
X-Proofpoint-ORIG-GUID: oybaqiAAuLCJ74-C_CwYNRTf6fhPZ6dh
X-Proofpoint-GUID: oybaqiAAuLCJ74-C_CwYNRTf6fhPZ6dh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

> One-element arrays (and multi-element arrays being treated as
> dynamically sized) are deprecated[1] and are being replaced with
> flexible array members in support of the ongoing efforts to tighten
> the FORTIFY_SOURCE routines on memcpy(), correctly instrument array
> indexing with UBSAN_BOUNDS, and to globally enable
> -fstrict-flex-arrays=3.
>
> Replace one-element arrays with flexible-array member in
> TW_Ioctl_Buf_Apache and TW_Param_Apache, adjusting the explicit sizing
> calculations at the same time.
>
> This results in no differences in binary output.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
