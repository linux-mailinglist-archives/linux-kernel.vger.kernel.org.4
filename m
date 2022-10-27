Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4488860EDE8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 04:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiJ0CYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 22:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbiJ0CYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 22:24:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B015DFD1;
        Wed, 26 Oct 2022 19:24:36 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QM6lRk014666;
        Thu, 27 Oct 2022 02:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=bBgwY3X0d09HWQES82PCEg3eHiTUir8jkOPSu8HOzwE=;
 b=R4wYwYQV4Vp0FEakZ4wZ40PmO/xOnd0XJWuSbL94DHeQKek46jmWk42zDBmQCXSAHbaR
 SpTobt9ImgKkxJx0O2O9Oc+vW2pat4KLwPITM+pFQxu8Lmlmly8tKs4QqvDxAs/fmLUF
 l8c/urariAQZQBY//NJlaLPK79rx0wHy3W0zqa/p09RZP+1TfNPAzB4RP9QL6vvxDyw0
 iyK3ybLWtljAGKnpDkmFTm280a2+pxfGpMptMYiqjETu/pFs3Kor5YH75P0T5XaRSYpk
 l3/Kt18KSXO0y9AKYwfyYzYw5g9F1qwjRTtFxUnii87fulNASMtP/r1SFV/6FMUIkMX6 fg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfays0rwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 02:24:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QM419x017835;
        Thu, 27 Oct 2022 02:24:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagg0pe1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 02:24:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuwfmWcvz0+bimdUJdlqNq6Y0oWHP7nWcn5j4x7jKMWl6Ylii9Z2TVdWsGvtpJPWrY6xGfExpQhubneHOwJtuICob3IF/QU/6uosB8xex6fH/ULxZpv17hnG7PfISsgOB2ScWdHnq+MnfxHNwTlGfel+zaRhwbDSz48kDiWe9DwpWAcV6vMA7GGKAiZwDe+zy1y4hEoIJEq2jAvRq29ZMKEImeIiTxtubEsJZJSdGXBKy/2fznpPLe530/6jPNyTSVnxxWq6Pc6OmCtMohdW1QztTA5nIBOsnpT21RCyIx90+ueT3a3/L+RaLsXg39XED+qoXCRATjXkUL9NlfhWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBgwY3X0d09HWQES82PCEg3eHiTUir8jkOPSu8HOzwE=;
 b=ZsKMsiOXbE0n9xpYJea3P2l5yQqyrmZ5Aaml8iqv0pN2csZomwbpGFaKay+xYxhcILY3EAXOYdQ1wQeFzE+fs1NJ8v7gGh96LbymRcp+9+uwuTv3uMMDwdQ6EpRd2qtgcJjPevGw6vPNqdlTYuRLl3ObUujknUx5hgzrYKoZVmZoO+Oa/6FcQLii1xld8YDRIPwGqnuMDlwKAf6qqLJTlxCKyyHYdhyz1pp9EaH33iQjARfD+1j7a7f4S6m1T9gHjyvs1Acj7Blb6KvgOozUO+WaqOzsBGiH5SexolL6YAsblmq6OQ4syD8CalnZ01exFEQOKWsGxfbueH7AtazhVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBgwY3X0d09HWQES82PCEg3eHiTUir8jkOPSu8HOzwE=;
 b=DSgiB9oepb8qT9rtvGdbOxEfLRg9uMVoG7iq4wOo30gMkecHLL+daxWl6SCTb+yT+/0hFbLw1GAW2UrJhDLOqVWr5tpR9irRLA0jC9PBail8jV6ZFdHWrUVWzXmWlkR+U9hO1FQgdFY/c82WHYmvmWbzFp1UCLHuQLJ9x5BjCXI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ1PR10MB5955.namprd10.prod.outlook.com (2603:10b6:a03:48a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 02:24:21 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::17b2:d97c:d322:c28c]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::17b2:d97c:d322:c28c%7]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 02:24:21 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <chenxiang66@hisilicon.com>
Subject: Re: [PATCH] MAINTAINERS: Make Xiang Chen HiSilicon SAS controller
 driver maintainer
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1czaerol2.fsf@ca-mkp.ca.oracle.com>
References: <1666784008-125519-1-git-send-email-john.garry@huawei.com>
Date:   Wed, 26 Oct 2022 22:24:18 -0400
In-Reply-To: <1666784008-125519-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Wed, 26 Oct 2022 19:33:28 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0010.namprd05.prod.outlook.com
 (2603:10b6:803:40::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ1PR10MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: cc681de2-8ebe-4b83-2ef7-08dab7c25b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oAdfpQDoH2JK2x8v9oQLgX6Qou3+YiFgzit7HOLP3kw4pWjmSWGhA5zjuY8egXu+w/+btZ+UgYSPZqG3ceMptTxyE0aqRLPwPxshZttgtFYoZ9SLQlrZmS/nx4LSvWIrb7P+kV99aGFk7KdyvSWQ289yqbt7N6c9xpl/GVWyMBvYT0/aQ0FVP+2MKu2wcCbKpUK5/FwiEyKf3HLsYnX4OnYfN5n4+NNokjW1JO1yStLEz97Ic/ZsiaQ74rP5Gj8hFrI7gtt3nPJC2Dm4878R1xq6DcBCId+CxjBkN68IwC41J6avgQJcLcOXmdJfDXG04XrELFqCK12abE7/scx6qkB89Dihkb4XjFQtcJRi4+NVE0hltqPLcyEtMfKLCvuwS1EJ4oZVuvavFS4wGwSyHVs1OWeqlRiHUb0nPVhKiNOHqw7l6Pta8hmh5jCtE8Q264WvUWSmoNAmge/jM2hZNOHSi+cU5Oxg3M4Ahok38+lDQz71fjW2mquZGz+E/icybije1PtCCbd2gBtchjLzLJ9U6vMkAQH3a5uSKzCe6N+/e7hv7/0hl6HXa9m3bHeAmK3kVRSaHO9l/EYpQuPrEnQDa3zVeWUNtHFM6aaJZ6aHbMPECcGqu6dLE+/wto+se4Wd4t4+oHUSgUhhluDuo1VdzsuiIblpdpLIJwyTdzTPLACFK9eaH1CFLdF+FTZctSOqr7ryEk+Mk32TCaF8JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(6506007)(6916009)(316002)(54906003)(4326008)(6512007)(5660300002)(26005)(86362001)(66476007)(4744005)(2906002)(66946007)(8676002)(41300700001)(66556008)(8936002)(6666004)(478600001)(6486002)(36916002)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?duSp33FpBySjbZwfj/LRK4fQLyakke2NNlHcdvgVcZF5JBJ/gixqP6EFrrsH?=
 =?us-ascii?Q?P+IstdtvSAf6uEQ2UN1EVE/KjHI9s9sLg9pdP5kWCXs+7RWX6tN3bpopXF4o?=
 =?us-ascii?Q?R8c1PmhlGxswAycqD24VTFnCdTMexTOMvuEcG2VPocbqhk3MSszTeXLKSKNB?=
 =?us-ascii?Q?0lH/PHovnCOukeXukjOKypK2w3b9qZL/3O1ycssznuQ2Apj9kMRLHcPl0mr4?=
 =?us-ascii?Q?VDuQjY87GeoYQXFSuAyAEX7k6MAshoxSHQ1syXK709BK+DSqsriHPpfWpK4i?=
 =?us-ascii?Q?YrRuEjXuPYIsyp90r2lDYlIWo6EqyTVgRKeFWQ2PwiYZ/g8KhaT9kV/LxlQK?=
 =?us-ascii?Q?27lYEpVckdl9CXLceDTw/oUFBgqizKE82N1YB8GTUzFSn4cpSqtBZLpemFHF?=
 =?us-ascii?Q?pndYnTgcUE5AiEDkfoBU/c04TlHcLivspf/pVR1V6dkb0T5BFGUMMfzstysZ?=
 =?us-ascii?Q?jQM6mDhirs1RDTLkLIYtW2NpCjWfXGLas3tdgVCLXwv/276mSnxzJ0vcmKSQ?=
 =?us-ascii?Q?a7UldybnHvTT7yLWZ+KzqNTvRmJDctze0c0AGFz14C55CMrtl2E4j2SHIQDq?=
 =?us-ascii?Q?6+3H5gTBwvPJqZjeQVwGaQFSt4gITdg3t3a3j9qU9y9El6m5zV3OVO/4XSiT?=
 =?us-ascii?Q?E/A9YCPHEXkxpONis7XyDoO+sTfO6kkVf4Cr+vuZ4IuFQRZYCi++aOBTv12r?=
 =?us-ascii?Q?Cdg2FMvXDARnozt7LjXEYCtW+1+aHTZeyN+WCcYAc0j9fo9bXtiE987hc6aE?=
 =?us-ascii?Q?gR4o/I4jU0Ncdq3Ec+68vlTlnAW7hZEpRYt1tBexAwBzsO4gJlbuwWHvBKJd?=
 =?us-ascii?Q?jU04zPg8kq4CNK00/HCjw5VC6RxP9zhvBzKfI2AHyqQh1yNsk9puVsy9+MS5?=
 =?us-ascii?Q?NRM7nPNHct9LiNwsXoFNzn4QEYQGpoZLjBmRJturzQyAdNXDp0taHPjjM+T7?=
 =?us-ascii?Q?BDwG0k9p6dBBu2XmfHv9YBTJm6FmZ783GVfUN+iHe3VjEOodwjZq6pPTnH6D?=
 =?us-ascii?Q?X4sdiaquVSw1harnnT+QkcuJONCbBRCs2yeAf7ms91VyqXSlSfd04qV2EKPL?=
 =?us-ascii?Q?hTxhjvRg74BXHNkizSEkpGD0OxaHSX9onwfG16uFwArbRlcrlmMmiscq040v?=
 =?us-ascii?Q?1gfl0AWdLGcWTLytWsG3vCkqGeWhJg80IU1tczZ6AZ74U4v1+CiSSaJEErlD?=
 =?us-ascii?Q?HN6sW4aRt3DMEZncifoZiMjjTCUC2YXZm7tXYqLlktENt75YzmeqbEeeJQx9?=
 =?us-ascii?Q?w/MHZjlkFns6sD+CQjLnyMj4gULynlpFd5Kw9AFpueimwSXcNqFGhAtVLoTp?=
 =?us-ascii?Q?W9XbUHiMwlbxtOdJZ2cFam1Xwd8QX6635UAMO4F/y+fPFdF9OL6nz5QBw246?=
 =?us-ascii?Q?t4y7CLKRsyBVU9rADlcQNyFsuWww4CMcFeMXd79S/N1ZltD3HAXJodHnQLYj?=
 =?us-ascii?Q?fCnibhxeUcXTdnlCs06jLzNgBD2fXMUJpjR0QTsrKrkdc/DSOOlkKvoe15v3?=
 =?us-ascii?Q?vKjrNeuqwCunTY/E8w6LGt0yuyLIqbSsLPyfPxTJi0TwWlbskrw5Nz1ISvIL?=
 =?us-ascii?Q?WW7/EVc7hD3EPR/eJt8XN3/GsLjliOOhp15DCqAFa/8pakBztjmekR1b5f5b?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc681de2-8ebe-4b83-2ef7-08dab7c25b6c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 02:24:21.3263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zav/4C+Yyv7RMUMVuyNtAKpKk8Qq/KpM6bO69srS9xXxOxwuKgfi+piyqG27RaO7or8bUFUAJzfDxmg9+0UwncpPfTj08QMAm/gJ4RnC0U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5955
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_10,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=918 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210270012
X-Proofpoint-ORIG-GUID: 8Bs8X1ORBScgWH6itfGuVVyMI_CbPqeM
X-Proofpoint-GUID: 8Bs8X1ORBScgWH6itfGuVVyMI_CbPqeM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> I am soon leaving Huawei, so will no longer maintain this
> driver. However I will stay active in upstream linux storage domain.
>
> Xiang Chen has worked on the driver for as long as I have and has good
> knowledge of the driver, so should do a good job.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
