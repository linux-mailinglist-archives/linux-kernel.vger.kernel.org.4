Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AF8732294
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbjFOWOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239131AbjFOWOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:14:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F349C10E3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:14:27 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGJdPX008797;
        Thu, 15 Jun 2023 22:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=BYAI68b0FQWjG4QfN8LZVqn25rFQeid25JLED4ss6MY=;
 b=YGaM3D8gzGLSQlQZtCr5uMPBDzp4OlRODmQVQpVbQJv57Obg1/RFdsx/wfJ9kxf9EPMI
 TZdCKFEffQRIHjB4TGsAXileKZtUUMk50Kzct0arkSorv8zNZIy+PoQ6LIkaZAXIBFo9
 Q3zv16bWrR8DcIvQ3l/ZnE4hVoqA+93HBr+j8xeHEsRerU/D7mRbbuhfNzPOyftCliTg
 KCCUgZmkgcdwbdG5Le2JqZIThjgIc9m38X4GiVdPYUpGOIA2eJuEC0UgB4JByDIoB+VU
 cSpAST0OfnEMFkxo8n0/tSGQ+WIcqrhnd1SUmegtYzUlHiImZvhG+aAtZygozkC9fupc pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2au1cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 22:13:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35FKEOHK040490;
        Thu, 15 Jun 2023 22:13:54 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm784ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 22:13:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oel7VCMvbenTGvghjZIRSqU+8vF9Kr0ygZF1DS8yAYyGL2RWGTv0CHcju8N7dp3FXkWBTNx842n/zIvMeaoAoIbVTp7qdnOLq48RiHQMauHtTd6yf9Sbsew+v+6WkN0FKtKkqprIbodjJx6IyT2QmmJbFpSbrcg5zq/1gKy5iT0xUrZIeAIqbaDqM+gmKSKMVZjrZeRgKLVOZqWk7nfiEYio8+MgzCC4Rrb2aN7Fpl5zcgxyCVdIsEbkXARN6imfSY1Nex+EUUqOMzhHtloslDfkLJWlLBBQpgrwR1ln9ALdkBxzPqj+XoWMLufGTMeXaGI1PGYCRy/SS5NQDUM5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYAI68b0FQWjG4QfN8LZVqn25rFQeid25JLED4ss6MY=;
 b=KE72XEwFLnqNQtLdH0uaqpCcbry6oQ3teHJNzzqbatDLhF17lrCIeZTbhSv81ckQpNpntF1PwKgnYxvYatgt9Mog8o80hvRyfjmihNjwN6/oxPOp2YVsyNvG7FKNve6SPxyplc0AgPTq2kXARPmJ2J2EWdmn8mXjjfQsW3JYl6Ywl+bFK/G5TmWjbsijBtWtDOkMSUUF5xhFSStajeLl9Pd2D/ce09ZOU+xLvDpn4Oowjr6m7iYE0Q+6dS1YMGXCxiQUDggV6zatoUiI0IlOWFNhgs33JF88r/dNIF72cMMSqcHM7Qtf8ChRXfY9uv+RMTS81MTfHe+l+4+AMpAZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYAI68b0FQWjG4QfN8LZVqn25rFQeid25JLED4ss6MY=;
 b=x/c7Z2GxgOI88emySkd4cGtmZnGCTxnDCXBf8hZmlbspkf2ObzJHFs2Ea3oABCBM0/xwPnCUR5K0GhBiS9G80lF/vBd4LH2an/UliJaZtl7NjIK1SsHxAgbfWCWR5wO9miDwVLNmmu8L6mKf5+nbMb7FSFGFYnfGgNJPikB4WYs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB6735.namprd10.prod.outlook.com (2603:10b6:208:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 15 Jun
 2023 22:13:51 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 22:13:51 +0000
Date:   Thu, 15 Jun 2023 15:13:46 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, david@redhat.com, nphamcs@gmail.com,
        jthoughton@google.com
Subject: Re: [PATCH 1/2] mm/filemap: remove hugetlb special casing in
 filemap.c
Message-ID: <20230615221346.GA29046@monkey>
References: <20230609194947.37196-1-sidhartha.kumar@oracle.com>
 <20230609194947.37196-2-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609194947.37196-2-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:303:b7::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d8ef260-250d-4c57-415e-08db6dedccda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svaV7NvRSRq1K22wThcu1LB86zX6FOAGho1HV5q9AMAIESnKlqyPoHdNFAVcTgNwlBYWq9kFxX0r1I1zM/1vzy9vIp2W5pSXNqKCYBXYojAE/MslYYWG1mkRRWavCDVy2AGYUjRag3jKr5EiYJN7ZoeyEssty937nO6CQm+chkUDbiQAvNRILPS+7ZZm/5+gBgquidZZdmlTLyMf4yeXYKASNkoRBks5GNWSac4Xs8LUgpGm+PbQ4Qu5Kdx3n0CBT3RNOJmiw1E7XWULQit9Drkiq/tC1UyGdiPDYyy8foiVSccZDBl6PNiEER4bMgfAnAFbxI1TYvrm8UQ8Esdro49/5eW65E+h2N37AsfOkVYw3kpyM/J4l8jxm+G98TXSwbHaB4fpnjGlHxIitthPyFJE3VlkWfnkTQhmuthz7Z/CzgLDLgA6maX3LXJQu2TF8VLqVtKLLTAazqVKG4Fa9mdAq5M/8IzKPAG7GMymICD5QfSaRVSNsS1WcB4vp+gvmNLzBYRiwxBIpJb1gfTCgQzdAETOQgwgWFdjAfksa5AT3W9vH7X25F/Gbj64pkZE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(2906002)(83380400001)(86362001)(33716001)(33656002)(38100700002)(1076003)(6486002)(5660300002)(6666004)(41300700001)(316002)(8676002)(6862004)(478600001)(66556008)(6512007)(66476007)(4326008)(53546011)(6506007)(6636002)(66946007)(9686003)(26005)(8936002)(186003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HIYX7BjE3uJ4iGXDFsTZL4tqmiaXg4h30ZWYmOKVOI4VGPBXD0MhlRe9QP0v?=
 =?us-ascii?Q?KpRaynhrKD8doqysH6+5K8/86aH+lUYEXvIHbRkbGfYonNlPgo3sA0QqQedd?=
 =?us-ascii?Q?L2Gsx/6rs7EK3RsTurBkbCU6NPb/4qPX+UEJXLDU+pqPY/JoRBxD9lirP7ax?=
 =?us-ascii?Q?bjZNNc/z+944lFR/6dc2U+xB5wyrBF078xtAuM4s1cfK+LeHDYZQ1vBi0Jh1?=
 =?us-ascii?Q?xWvhJFXmpTbK9CCJPIyaxwt24YRFejfeirftoc06bHfksU/i9/lq8DEI8/BW?=
 =?us-ascii?Q?xMl5p+fTfj/OgGFs7rKzpIge6MFARw790/xyV07Vo5GoLMWnuQIMYPmQTNIP?=
 =?us-ascii?Q?K7SLXvWegA+kiUaBx+8lE2E83ZNXxRcwGuCMMkrLePGFFolCzMYnlK/p1BYA?=
 =?us-ascii?Q?MO9ptJgZrYVeWpztUiYDntfAeA9WlKMyXoScYsuE63qmPw2+N2YvLSt2LL1P?=
 =?us-ascii?Q?K6GEhxV/Eajj5pd9FOPGcsZfyAPj7sq6t5YjNE7KSlIxUDi24YVJ4XtwzdgW?=
 =?us-ascii?Q?i1fVaNDtBQB9SiJkECNWNlJw4VsPr9ZeSE8WgeZPQGXuwssZykRmbAnB1jSw?=
 =?us-ascii?Q?t0Xd2kGlIuCrmiBCCoJwnUD5Xpxw2gJSQdf0uWa/ksbRySecDHON6Xl6oPSx?=
 =?us-ascii?Q?v9pbfklO/trHr9wPpzgchtVaQNxwLiG/XhN35DNz8aP0/lBN2Ore7iI/m2FF?=
 =?us-ascii?Q?KVhM5GCephz6kui5kz6k4gegWKjxaqzaITyrYvDZZxncQt8xreWX4JmGUxT3?=
 =?us-ascii?Q?IRf6pnprXixP9JhcF1b4bTV/pFmoi1MCtHDufUnJvjllDbfK0notVyBIKCcQ?=
 =?us-ascii?Q?gnNNIUL7nr+QACRKy8uNX3B7JweQ6L8XLQmSX7XuSZvq/CWBn+r42SXAXrII?=
 =?us-ascii?Q?SoZzhlualaL/ekv9Y6ox4+uCeXnz1hOYymslX0SYY0ei/CbkmX/cdtF73E+D?=
 =?us-ascii?Q?lebB9Qdty/bvaZbX91ELf0ZtXH2A5u/lKFjkrGJLfNGkXoAcWToFEtPOcFxy?=
 =?us-ascii?Q?oWgug4Y+a3M9BwqCTr180TMF8lw3/68bDPaKwfulBcxNwJbeES4UR5D0nQb3?=
 =?us-ascii?Q?jOAJ0kJV04sIIsFK0PScDx4hA2f7D3tsQ5p3viEniChzQeks0JAOVX2MFPsu?=
 =?us-ascii?Q?+c6jA3R+7K8jRDU7bHuNj8FwV1ojXSFiYe62dAOs55ZS6XJhyL+iYJb6jein?=
 =?us-ascii?Q?n++zgfnMmMOWKXMxTuvK9do8i8AauB8kkLKgD2w7rFOT6+C/kCbhrm80GMUw?=
 =?us-ascii?Q?dFq129xM0KxsljX4szB1NSWcrB2RIt2e7y8ZRlXRsOoLbyFd03yAw6iBQb2p?=
 =?us-ascii?Q?yUhJXDUF4Js2hFtjEZ3Pl9S7+uRVcrHiz7hPXhkhiHgZkn4hlW2p4ZxVqH1i?=
 =?us-ascii?Q?vDGaTZVHnhUmGWWtBSurIRSirvU3B4b/r9R1D1CRX9OtR27j48Y2tJ9fuW4s?=
 =?us-ascii?Q?tZXoDUQ2ml1nME+Ah196CQ9lyxuPLmqKAc1Wd2gejZ9o6g8Yuc2ty3jEwX+l?=
 =?us-ascii?Q?KwQKw/ew+RsWYOt4xJ2XQh9b2m4MmyY5hwU9Uq72ZIemAoQqofNrpl5uvxHD?=
 =?us-ascii?Q?TFZNDsuFiQ+Xuxb0Qa2ZR0YPutbKFa52+D49POm6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?1QRiuFe2PragcUdk84bJVVGG/BrwpWkOeG7MSkMAXOxCpAeCrlOson2trbS9?=
 =?us-ascii?Q?91ijVVunZxa1TLavHFhQvHVleUNYSepMknnTcEwqg/ci8ypAXjlRWbf3zdZz?=
 =?us-ascii?Q?ifvcFblp7pns0yajWBt28AvrT4hAaqpQJIO+T4eC3F7OUqyZEmBQbkm5ie4d?=
 =?us-ascii?Q?Pc1WD78wCskYBBu/A2+/n1jskU7Psf2B0La0Z1dFW1/FcekQHwb0JUqNFtNd?=
 =?us-ascii?Q?8jz8B54EjgvtgtjaqLUSESDJTy2Ch9D158BpW/xfsOVycF5NtTQZs5yTEI1u?=
 =?us-ascii?Q?ulAELoz60gdPJQ2VlDEwYPsBuIQXz2RLkLCfD5On1VkvivtSGa1mQnZfRPsk?=
 =?us-ascii?Q?vFBLH34QspZmM0c2sm3tOvArz+/vf8BNt0mvLMMyZQ3b8Z4xnm8N7VszSfM4?=
 =?us-ascii?Q?QGoQeA7C0mc9aaa72B5Eskke8pmj5aTiKo1pJ7bAIBPGrkB+xBDoZObOhODH?=
 =?us-ascii?Q?Qc4ymnnV6e0ye0DBWhmHV44JI/g/ULMsJq/K/OKqvcK1jb7ReEnE61Qyqbop?=
 =?us-ascii?Q?KrGbdYvzpZuV6pK/TlYH0+gb79+7IG/HH1ZdFWfxyIp9NO6lZWLW4Zicy+xX?=
 =?us-ascii?Q?k7nKZX3oTgTej5kEXeDHGixgyKVOYracurfOYjMjGsH3CY4TYWyR3QWXuJ0+?=
 =?us-ascii?Q?tqqvAcX4/3weibPAwtS2eOJ1KwXL2j0Uxe4v4ZZAgiWwxHe5M/7cUGKOTPPV?=
 =?us-ascii?Q?Ksxt5Wr7oPr00K5zwwUo5hjA8dJpJubH+vNScQQoofgAb+s5pOeHRuZBNHVQ?=
 =?us-ascii?Q?fbBff5Byfj61ao99Gh7tDmoAJ9zFG0cOC1fT07r2sR+Ck98GlsVtq+AMEXcS?=
 =?us-ascii?Q?2tvYXAvQU8XxOH4pqmd4eAOzoCcCKD2gXlHOg/RhMO86skBt/OOkUuOJAwNe?=
 =?us-ascii?Q?aPwuDQmaUenEzPVfkfRhqi5R1uqqU06QTzdLliGjS3hP6MknXOXoJQAFvorf?=
 =?us-ascii?Q?vpVWzjvibsEWq8wZchCagyU3rEXWwNMeOcxGb5alf96dYPJmwTDjmR5l3b/C?=
 =?us-ascii?Q?N84f?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8ef260-250d-4c57-415e-08db6dedccda
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:13:51.7299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4h8Gao+J/9RPG8m7wMmMgvEg/PJ59Yahm6BB7x+lvGvlHCHJeKJeTP2VYuhkW+XaycE1Fj/pC9sqJCiGbcZWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_17,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150191
X-Proofpoint-ORIG-GUID: FxefJgr3tQfaSvQ4taTpVTZ9I4x5DcO0
X-Proofpoint-GUID: FxefJgr3tQfaSvQ4taTpVTZ9I4x5DcO0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/23 12:49, Sidhartha Kumar wrote:
> This patch aims to remove special cased hugetlb handling code within the
> page cache by changing the granularity of each index to the base page size
> rather than the huge page size.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/pagemap.h |  6 ------
>  mm/filemap.c            | 36 +++++++++++-------------------------
>  2 files changed, 11 insertions(+), 31 deletions(-)

I agree with Matthew that this patch can not be sent independently/prior
to the patch with hugetlb changes.

Code changes to remove hugetlb special casing below look fine.

Does not matter for your code changes, but I think some of the routines where
you are removing hugetlb checks can not be passed hugetlb folios/vmas today.
Specifically: folio_more_pages, filemap_get_folios_contig and
filemap_get_folios_tag.
-- 
Mike Kravetz

> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 716953ee1ebdb..17c414fc2136e 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -723,9 +723,6 @@ static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
>   */
>  static inline bool folio_contains(struct folio *folio, pgoff_t index)
>  {
> -	/* HugeTLBfs indexes the page cache in units of hpage_size */
> -	if (folio_test_hugetlb(folio))
> -		return folio->index == index;
>  	return index - folio_index(folio) < folio_nr_pages(folio);
>  }
>  
> @@ -850,12 +847,9 @@ static inline loff_t folio_file_pos(struct folio *folio)
>  
>  /*
>   * Get the offset in PAGE_SIZE (even for hugetlb folios).
> - * (TODO: hugetlb folios should have ->index in PAGE_SIZE)
>   */
>  static inline pgoff_t folio_pgoff(struct folio *folio)
>  {
> -	if (unlikely(folio_test_hugetlb(folio)))
> -		return hugetlb_basepage_index(&folio->page);
>  	return folio->index;
>  }
>  
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 60f6f63cfacba..7462d33f70e2f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -134,11 +134,8 @@ static void page_cache_delete(struct address_space *mapping,
>  
>  	mapping_set_update(&xas, mapping);
>  
> -	/* hugetlb pages are represented by a single entry in the xarray */
> -	if (!folio_test_hugetlb(folio)) {
> -		xas_set_order(&xas, folio->index, folio_order(folio));
> -		nr = folio_nr_pages(folio);
> -	}
> +	xas_set_order(&xas, folio->index, folio_order(folio));
> +	nr = folio_nr_pages(folio);
>  
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>  
> @@ -237,7 +234,7 @@ void filemap_free_folio(struct address_space *mapping, struct folio *folio)
>  	if (free_folio)
>  		free_folio(folio);
>  
> -	if (folio_test_large(folio) && !folio_test_hugetlb(folio))
> +	if (folio_test_large(folio))
>  		refs = folio_nr_pages(folio);
>  	folio_put_refs(folio, refs);
>  }
> @@ -858,14 +855,15 @@ noinline int __filemap_add_folio(struct address_space *mapping,
>  
>  	if (!huge) {
>  		int error = mem_cgroup_charge(folio, NULL, gfp);
> -		VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
>  		if (error)
>  			return error;
>  		charged = true;
> -		xas_set_order(&xas, index, folio_order(folio));
> -		nr = folio_nr_pages(folio);
>  	}
>  
> +	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
> +	xas_set_order(&xas, index, folio_order(folio));
> +	nr = folio_nr_pages(folio);
> +
>  	gfp &= GFP_RECLAIM_MASK;
>  	folio_ref_add(folio, nr);
>  	folio->mapping = mapping;
> @@ -2048,7 +2046,7 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
>  		int idx = folio_batch_count(fbatch) - 1;
>  
>  		folio = fbatch->folios[idx];
> -		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
> +		if (!xa_is_value(folio))
>  			nr = folio_nr_pages(folio);
>  		*start = indices[idx] + nr;
>  	}
> @@ -2112,7 +2110,7 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
>  		int idx = folio_batch_count(fbatch) - 1;
>  
>  		folio = fbatch->folios[idx];
> -		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
> +		if (!xa_is_value(folio))
>  			nr = folio_nr_pages(folio);
>  		*start = indices[idx] + nr;
>  	}
> @@ -2153,9 +2151,6 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
>  			continue;
>  		if (!folio_batch_add(fbatch, folio)) {
>  			unsigned long nr = folio_nr_pages(folio);
> -
> -			if (folio_test_hugetlb(folio))
> -				nr = 1;
>  			*start = folio->index + nr;
>  			goto out;
>  		}
> @@ -2181,7 +2176,7 @@ EXPORT_SYMBOL(filemap_get_folios);
>  static inline
>  bool folio_more_pages(struct folio *folio, pgoff_t index, pgoff_t max)
>  {
> -	if (!folio_test_large(folio) || folio_test_hugetlb(folio))
> +	if (!folio_test_large(folio))
>  		return false;
>  	if (index >= max)
>  		return false;
> @@ -2231,9 +2226,6 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
>  
>  		if (!folio_batch_add(fbatch, folio)) {
>  			nr = folio_nr_pages(folio);
> -
> -			if (folio_test_hugetlb(folio))
> -				nr = 1;
>  			*start = folio->index + nr;
>  			goto out;
>  		}
> @@ -2250,10 +2242,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
>  
>  	if (nr) {
>  		folio = fbatch->folios[nr - 1];
> -		if (folio_test_hugetlb(folio))
> -			*start = folio->index + 1;
> -		else
> -			*start = folio->index + folio_nr_pages(folio);
> +		*start = folio->index + folio_nr_pages(folio);
>  	}
>  out:
>  	rcu_read_unlock();
> @@ -2291,9 +2280,6 @@ unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
>  			continue;
>  		if (!folio_batch_add(fbatch, folio)) {
>  			unsigned long nr = folio_nr_pages(folio);
> -
> -			if (folio_test_hugetlb(folio))
> -				nr = 1;
>  			*start = folio->index + nr;
>  			goto out;
>  		}
> -- 
> 2.40.1
