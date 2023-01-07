Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FFD660B23
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbjAGA6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjAGA6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:58:09 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5287D9F9
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 16:58:08 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306N3qqk032600;
        Sat, 7 Jan 2023 00:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=hd0aN7AxHrYmtHOUyrBXF0WT9NQxZJ8X8b3sQmNeKck=;
 b=cka+QEjVHWcD3GVGhZ6K00ROxgXdvycXKFFoJ1O5z7FIKhU/T4g7Kw/mAkEYG5k2DF+i
 e7OKhMGIe18prmzFAPKXjgV5/l47DTDvUqqEGmZA9Ek7PPLDvIjTzj8SLLlPor3q71QH
 Sn2STNZCqZ7YX0miETYni0fT6bYkqCIR9Dj/wlcKixOYz169cIKVMhOu4zh7GBy9Xy9E
 SCMONTHji8p1FJUqZBJeK6tNvYl3HDkTUibEAb6V1pGjlNLEzGyegS5kxgPb9jVuxV0e
 UOLA0CjamGlGvOYxaR+WcErrjHBmg3mVfnSo+jBYYb+4vOyxYvXbQ/Jsfzl1bs1PcyLC 8g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mxvdgg4hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Jan 2023 00:57:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3070Abqk015265;
        Sat, 7 Jan 2023 00:57:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwepusmea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Jan 2023 00:57:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2Dp5O6vULvviwnnKH02oOeiPvwv6CBm2uYB3qijXd9mCT72OzA1MZxC4xXCGcwvWz1f2+R+xqWGE7Km45I9Adf4qJnbkqI93+y1lmUCnCWo5E6T4lzE+HkWzXGdNNTMd29rMMoR12OciYH7ESTxt+SXHQOnFVO4VOnp0ScrdznJ7UM/li+z6KAvTFWTsmM+IYAAOFFnz2r5fjL+GLMFAh5nhjzRxsGjQj1RMjU6Lt6qpSkQmt6qnZd+S6qzbvMyMcdZQ2Q9X/Wktgdlv+aTO+vdfPiLMnlmA6Dc5Uq+xeSD7JzneIZOSc7lgjzCLvl6Qpa5j1HVr4gwUKM4R5TRJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hd0aN7AxHrYmtHOUyrBXF0WT9NQxZJ8X8b3sQmNeKck=;
 b=oEF66f6y4XJNgprABYJqV9SK0GjZQztZdUhwvGMYV7Uury3ifukGDhoJz74fxorDxIwtWGkQ9gtV1EzmnlJ0/cKgR8iTN2ov6+0rGLbWm1LI93xmOWod3PlkL7wVl1TQ7nkq9jhqc4Vk5MooUc6grYKYFhVNsEN6cPbjpHTgpxrmUKSxZmFP5JZYdOG0z3NbSyLNvH7ELzgga6sC4V+gTyQgAht7KFQCViw2XFL/ugbsRc0jWbdtSpFozaKEwTGFO6Ewc5iIsg5UbKQwveyUJFSYRMWIRuFLgunG1FIQUmyMMx5vu8FiVKBISeoDf02f7Huv86CY6LApm9sPzHyNcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hd0aN7AxHrYmtHOUyrBXF0WT9NQxZJ8X8b3sQmNeKck=;
 b=I7wSKruiuuqTiGxDlx1dBr3lC3e0iz+3xB+nVXrMmv0h1skp4/4RtjLCd1JS5AlXLlluo0XTYoLhvpBUhtlbVBGAuhrKxMSUgdooRmauYSze4+QraWvb4QpJSUdcxONoYLUaUAMW62PHtZKP69lGczFfZ9poeFLl7gLng8ioIXo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB6039.namprd10.prod.outlook.com (2603:10b6:8:b7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Sat, 7 Jan 2023 00:57:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.5944.019; Sat, 7 Jan 2023
 00:57:37 +0000
Date:   Fri, 6 Jan 2023 16:57:34 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, tsahu@linux.ibm.com, jhubbard@nvidia.com
Subject: Re: [PATCH mm-unstable 7/8] mm/hugetlb: convert
 restore_reserve_on_error() to folios
Message-ID: <Y7jDfgeMapZ2PZqe@monkey>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
 <20230103191340.116536-8-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103191340.116536-8-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR04CA0389.namprd04.prod.outlook.com
 (2603:10b6:303:81::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM4PR10MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: a803f73a-08c2-4a48-3015-08daf04a2b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9shRqHkuGa47gsF29kA5oX5o/mLVrHvZROyE3t2/tzZsjm3l9qJCJOcveSxQ1DBdffk7BeNb8U1AiirU9bKjodpHRlpISjJ5CAhOb07n2Qnv3XcbmlCoCG9p/8md4wZV0XtSN2T7atUwtzIb9bX8YeK7UDIdDcGdszC/Qr2GyllZaLTi06ItW3BW1iVBpebz/Pmw9jPFGzR8Tl+uzq+afipnuX+2gtKjWTQkUBxMXOxfy5opBd7dPtRN93mQjcBis7tF9gfHbDCI1lLtZkI4LJVJMXru9v9yslLxoOg6lEyMtu1hgcW4D3xJuMQXWpyl/1bdcp50zsUW04MkjgXO3Zwnr5iGWgww7HpG5DZ8RO+7H+niSHNHHps/FnhQaflJ8wA1FpLxvZODwMGBlq+YJQSOkC8s34NYzNXyUmAiiYyujJhNdP+xP41iOhtM3Fy6QcoUp9lo3AkKf4d5g5apvTx91g3qvBkK2KaSAs3SKZT35uAUHrC7F/pedYrKqQo1t3pobyofw6VexTnc2y/I7EUCLktfT5JuNc26ppOkexCk/jai7ksyfJ8yjuBhFgkGF5Jtqdq/KYPL7dFjTZu2O2yUe6/wjj2vJ89klPnUpktAm6FRITVsPBGiyCXTB2sxBpSyGpxFpX7Xd6kNyg1jUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199015)(2906002)(6486002)(38100700002)(6636002)(316002)(8936002)(66556008)(83380400001)(66946007)(6666004)(66476007)(4326008)(26005)(8676002)(9686003)(6862004)(6512007)(53546011)(44832011)(4744005)(6506007)(186003)(41300700001)(5660300002)(478600001)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+OUJeEYGhemzPImN7iaSnYnhQ3NviesJUkJWupWaf5w1FCeoI2E89I4ZMg4B?=
 =?us-ascii?Q?/8o3PazRgnGXv8wvJINi8azX2F7eQYW/9Rzla4uKDrGCEXl/jupyvYWdNN4S?=
 =?us-ascii?Q?b7pVDIJ5+45wPBdqJJT/xPUdnsaA4f/jjfGIxDo1QhCPx0tgqa1LUW8cTUUy?=
 =?us-ascii?Q?dOoZVpYdjM8Za7YVlpTHHaLTR8rvBMabSAWK4/2VqsIzG6V97SVLHi2tZFVX?=
 =?us-ascii?Q?5hw79n1b1CTHjb4kT6KyeDrHms88azJAvfoOTRH/MLJZOK+08/JQLh4RHzri?=
 =?us-ascii?Q?649qtvVEcda0YktjttqUpy5OS8ecpNGubSTUCqSjjMFaE0qCOzyw37RO1v0f?=
 =?us-ascii?Q?WPgl+U5dPECF4NiflHWyMR2emFUjEf00mrW5PBhDc0YR0dtkXbkuQhNpazAq?=
 =?us-ascii?Q?lX1BCQixtlDwstc6IBi21BB5LCBMb4nxWfF0Gz/7DWRAFZMkaC285CiiMSBN?=
 =?us-ascii?Q?lbRVapfTMJj6fN2SphVEQas0Q37GaBMMV2dKO2FPgAsYDb2k2qZ+G9cb2W/2?=
 =?us-ascii?Q?Y0H4u1gvQEvBYTNnHEyeJ9Uy/aO1JkrrqcVzq1TNQRmpie0G+FsfgMlboyPu?=
 =?us-ascii?Q?AHkAa17APMHDaCOCYGuH8xNYdx+BjilkiNGh2+7Rbb7PTqWj9CivGNxp11Y/?=
 =?us-ascii?Q?HmKKsDoqW8SMpeU3nTbJt2vuFE1UZ7Fkboz9c8BmwIWH6d0Ai8b16G7D6g1r?=
 =?us-ascii?Q?IESuSDqJq3kAofww++hjnL3mTW+qkhrZEedgZvPTDDHDbi7uh5+KhbONDp8R?=
 =?us-ascii?Q?KpRLIA9cM1CPxW8jCUD3KJrY37CD8WzdYRQp0amFyr/htX5ykXUJ/uKMub5D?=
 =?us-ascii?Q?1XXkp4R224I76C9bNnrc4q7jKOr5pWI5K2uCLeWxWRmLpX8LMSx8ZUXjJQMW?=
 =?us-ascii?Q?o2zspLErtCai3dprVzjKSorV6TEdryACOI+TpMLAFNLBR4DyIXve/BfG5Y6B?=
 =?us-ascii?Q?gV6x6U3G1omqfKzycRp2Hwsw0PdPzMlDLCo3bxSaIbh4ymbBWYQTG2wAebrX?=
 =?us-ascii?Q?FfkNi0skKGiNZruGIiOx8CL1hShThDlPpxpANkfaCdBzbC24FDWx9hczwRS8?=
 =?us-ascii?Q?vl83twS3mVC72T9hiQ2tdftZ7p/OYC+9fmgLRxVvulzagLsA+f3/aLtu11ng?=
 =?us-ascii?Q?ArxchDo+W2whnYlfBsxVssa1oqnUHlPvGLfrn7P8f/HBY+f3U5mLxTC2u0NM?=
 =?us-ascii?Q?30Ht05vbAmn/9dk/EsBYiZ9Xiw7D2yGLzmC64CFooXbqim6TfJ8UrzoeSKKg?=
 =?us-ascii?Q?S2AyNtolwsVk+EXXX1SVMNSbjqmWITUkQwF2PSKcBZuSTlMeWgCMH8WJi7W/?=
 =?us-ascii?Q?J6NU3TvFB8Qs9gS6FrJqlYMa+cDgnEwphbfZM7CHOcacPNV0Ysw1q+TWkyDf?=
 =?us-ascii?Q?5yI0KjcagLPPaWEv+omIif45MrSz2o5o3gy2iPC16/PrgNpSzAmReKXrWrdH?=
 =?us-ascii?Q?IivFUMHcASrHgNHtqMe/gOoN4ZVrfCXI4bhBqpK5NOOV74OivjZCtoejGw76?=
 =?us-ascii?Q?10eZFw09Dw55/JauKECTRHrHwnvxSb0km6ZmKgUp1lnK663hDIPLmF/sY+NP?=
 =?us-ascii?Q?p8oF+smgEsf1iQqKq3LR7pPs5voaSD3YVSKLTk6EXa3JEwh89Lchko9FOX7Q?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+A/aiOusJsaT5LoirODpsYZHWhZacV2xnzS0l178/eVnSacJ5eIv6C3LO4TJ?=
 =?us-ascii?Q?Z5AlCy/pw2KQnc3GLQiqzQZv/R/JVDCxbp1TNqDRNyLuRFhVwmJcA2OnxNWZ?=
 =?us-ascii?Q?iiXhzGaIYrMysYNycWyfYYYFLsKON9wSC67mkqVQTI3fnA8ovwW8octwia5i?=
 =?us-ascii?Q?Yi4QuI8kHvwlIovitDYz+5RM/N9vqJQq6c7RfxLBabhUEiaBnB4t/23OCd8q?=
 =?us-ascii?Q?DskqKv2z5vJGk5l1x1D0LwjRaFyOACSK/b/eh9C2YCajKphZonSDDfgeGqiT?=
 =?us-ascii?Q?+eTMA2LupNbDlOfpj9WzkVG1MgV7hYjnGSKD9b9CwKyrmdFUfybh0ueZVUn4?=
 =?us-ascii?Q?Cag7cqHO+HGeP4tegr10Tg4QoZ8Zn71QvG00gt7wRoIe0N4xrqVXv3ltaBvU?=
 =?us-ascii?Q?aaHaXJ+oR09o3aC2t1ACi9zJrzMdvEGYNVBQc4ALvFbULxg9NTS8lWS25kpt?=
 =?us-ascii?Q?0F6BgaAT9nvGLpwgCaUilTt6QoaT7WJNLQCdYbeIzG2jOwAE3fDVHOcYJmP3?=
 =?us-ascii?Q?cwEIe1VfFOv73Lh75Ek7W9jklvFr0AJdZwI3f5aLxxgspVOfKdHj/9Yu982D?=
 =?us-ascii?Q?Deiux3ewKxuCzfxRBNx3HleNepZorGioY3DzrfmcRgqHM2z2vZgHbODS19cT?=
 =?us-ascii?Q?mt4uiB3akUoIDnCH4ENpdVxdSY3kkIjfGlaZtiHpSbHoo//yfwbHKOYPyuB0?=
 =?us-ascii?Q?i+T5mm4BfLb4kVoS4W1y6Eo5+Avh5jFQluVe3kJM2iCjEa6gG1ZOnrOevTFK?=
 =?us-ascii?Q?n4li+kxJL9DxkZwEAxlce9rnUtGpVezRkZe9xQhRImD0Gbp4r+Dak7HWQ6k8?=
 =?us-ascii?Q?XTBVIzgHBuv7ITHwsIsgniW5v+s8wM+n+LQm3gFE3rng2NZMZkSW6owGIZbS?=
 =?us-ascii?Q?yzD+MEbMyS+LJAttploO+8+S0NKWwtHLSuvh3Fj28OgEzp75h35hV7LCWyxK?=
 =?us-ascii?Q?cAMK++T6E7USnuOqQRbdMprtaN96DDbM2gnTj0aUhWc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a803f73a-08c2-4a48-3015-08daf04a2b38
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2023 00:57:37.1115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2jkGV2kF2fPa2PbXoVMuSp8f+s5+CzOGMYCGUd2xL+N2ZIFrP2aWw0s/loa+iQNg7ACDK/YmRHbmo2yfOPJ/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_14,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301070006
X-Proofpoint-GUID: hm2Obx4iXO5lTi43OmbzNYMnXlIN5Tei
X-Proofpoint-ORIG-GUID: hm2Obx4iXO5lTi43OmbzNYMnXlIN5Tei
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/23 13:13, Sidhartha Kumar wrote:
> Use the hugetlb folio flag macros inside restore_reserve_on_error() and
> update the comments to reflect the use of folios.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/hugetlb.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)

Looks fine,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
