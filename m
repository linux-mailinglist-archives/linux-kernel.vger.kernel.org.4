Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22FC6C8722
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCXU57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCXU55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:57:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC7849E1;
        Fri, 24 Mar 2023 13:57:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OKo0kD014482;
        Fri, 24 Mar 2023 20:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=bYYuNsPovOgA/7/eKFwxb5IdLm3/OYWbAHCc8RiCKkI=;
 b=LtorFF2TyDGZ9iX4ltr6mJDlcMPyZfjhU4V3PvEgd+VPf9hpd9qU28i5zzBIWmMikeKg
 ROtmKT/WfzqwJUvXvaQvY6+h3HvMExw2Y3fTIVehSImb+FlGWXu7KAGRVlLbHgOE32nc
 mfTX4s5Unm97UYfGkVaWGaMqvruKsizUg0JIgsJkAGVQagT2GR9sT5tlzRKCYrZIm+0R
 bK7BUuDWNbjw9nXoqHX51AZ4RLZfwqzDE+wDhx6W+fXaRlkUHXMkWcYU/gQ1WRYhcOLH
 Gu08A/iMiyHq0Xf4ZHKkKByOvXWfcWgy3ug+uvp8Y4Jj6u0/JVhUG5RwcQjR6kDTpvv1 RQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3phk85r0fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 20:57:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32OJ3wJt002245;
        Fri, 24 Mar 2023 20:57:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgy5efp46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 20:57:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCJwy4QO8yYVywepzZnjc7axxxRka41TvybyKAN36T9sKOqUbycQ1ryPhrivPyPFY4ToFU2styqSSCy16xsJxMMMjscmCO1Ero2kOI6zQKeUgy3EoizY23xX9fbVJGBqTyjven2xVyOYgMrcsKiHmjOVCbrUZemG0ouSahtD0eBCMO3UCzjsA0BfIrQhvVbdxVhtxA8yW07YC3VQ+718ceKKCds2rvQxs0T7sa02tIs44g/dQ1kYQlry5xC3ekp8QmcBjlN0ua38AO2sqT8gu+QCczLvQihM6TtZ4rmSQ/R4Y5O4adoH283pqIS+PUED/Ydp5B0vj6qRmWZxaCUOvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYYuNsPovOgA/7/eKFwxb5IdLm3/OYWbAHCc8RiCKkI=;
 b=iJj0I+SBYToTMuZhSsKeeKsMjXxGCyy4S845Fx+YfJq4/PA8lRYxYXuibJlkXGsRy9AxppWUohtLaz4IzGyTk39oLn/xTZylxMWm/tBDNBg+2CSWxmxAVOMJrvLrgQI0tUA2eeBEjt52Pon6gUNsBnEVG8eVDHH/dd5ii1PEO+YhvhIbQueWWhM6SfoLzxkeLsLRipDJgegGSDpddEMCbTqu37SZpSDCrn1aufQX+yonNj4awvQR0PF8AdSNDFSHIk/DUNiS+CvlbV2SyDVqQRFS5bDwZvAbQy7dgpOj93bZK0f4QIl3Fm3Ni8E7zN6+B5DaiA9F+ERwcYVGccQxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYYuNsPovOgA/7/eKFwxb5IdLm3/OYWbAHCc8RiCKkI=;
 b=z+Q/PMmJlLeo7+rbhzPt8vggOVLTKM9Acz+spqfSbdKxvYRsFk5w4jH6/4wPNhGQ33V4vb5/t/KoeSbt0wky+iDepkMzxzrwya9lrh6Coof4FeDzjnlEMgGRTbsPtAEvtCNIePqpBbRuI52SI3EnFt/jxe7ZKbkbXpOkdW0rPB8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB7484.namprd10.prod.outlook.com (2603:10b6:610:182::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Fri, 24 Mar
 2023 20:57:46 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 20:57:46 +0000
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     don.brace@microchip.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, storagedev@microchip.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] scsi: hpsa: Remove the unused variable transMethod
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1cz4xkgui.fsf@ca-mkp.ca.oracle.com>
References: <20230317054940.86685-1-jiapeng.chong@linux.alibaba.com>
Date:   Fri, 24 Mar 2023 16:57:39 -0400
In-Reply-To: <20230317054940.86685-1-jiapeng.chong@linux.alibaba.com> (Jiapeng
        Chong's message of "Fri, 17 Mar 2023 13:49:40 +0800")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0308.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::7) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: c0132534-edc6-4a3b-7874-08db2caa6b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6Tu8K+KLlFsNX5HMnADaW+vqrXIhN6S2gGRl/9C1/jJOZP7mXMVyZUSZhWV8MfP8FHr2bSC3ke29WDjis5v4dg5UceDgUfFuPASTHc1rP8vBWggheCzCR7tEiYoimp5Ou0sBGLxAODhkXRUJvbxJNhPpgBeO3CzSZThdM0Qwa7g9o7hLvkoWaejPz34OZ21Zr6RVFEgRgnZ6mUGjVngP13qa7vTNCu7yuGwPcKhzfkJksFc8n/CQY1qjaCccEMxYK4s6GjPWlatjDgI341l1PCJmab4k7JtB9Q/Frd4AUAzqtp772D1bpzvMZcZ1fxSz/TloBJAF+HigQhRn6TGKVxA73hrkAHw2QICfdKwuXD3ZD7E/pqhRbgvBQinsEMdCk3flB8cEi1Y22n1E2tWsuuULpUX6FHi1SHSG5KhFZwBb5rMzZvUOzkXlRmqBCt6SCIa+SqyQ29U1nLm9iHIvVYoJkIjxwKIJMY2uoCf8lp0R2of5KX3GEzChIO9YjOPujm1W2bfW+udsY7Ze5QIEZaTBANiDMdQWI4hrFw/9e5MNuE5M+QGDC8zmP+SE6FB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(558084003)(8936002)(6512007)(26005)(83380400001)(6506007)(186003)(6486002)(36916002)(478600001)(86362001)(5660300002)(4326008)(6916009)(66476007)(8676002)(38100700002)(2906002)(41300700001)(66556008)(6666004)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m2x8JxmeXiRMf89e/pMh69midlJocDubz6j40JK2ubJJkr4Qg54s7Ep4zZEy?=
 =?us-ascii?Q?QrR0r+UXwkrU1RHdxr325iN8cV/wL7HIGIuiME5AliREHwrZeRZQW4t4CXzg?=
 =?us-ascii?Q?Gh0lzTY6w8EYqQwlleLM4kZVPiKHh85umdAOlJGCqB4gqjR0XRGUBrYGzKz5?=
 =?us-ascii?Q?KaLsa7BHBGC2DCYorgdHTj13Y6qcoQIdYnVb8UU5ya1M51cnWj9QucOPHba2?=
 =?us-ascii?Q?YBCbwm26S2p+g6RMBN+Nb5T0H0KEU1wrha3jpsQXd3F97IwUvKl4dMeTNnVv?=
 =?us-ascii?Q?cwiyzaaP/l1ouFshG7oNByzJL0T4gRmaB1YDryupSHK1F0aiS2c8VtXYamEO?=
 =?us-ascii?Q?1vU58cqnSxdii1EAQawo56O8JupzfcgnZ7DG/IZ45u2GAgv+853KSlr9uGSS?=
 =?us-ascii?Q?hmGNnG3eTLm+SaBvdbFGktIaAhcQnSdvJHnkjzQq48Zi6otpwbYYofI0g/zi?=
 =?us-ascii?Q?fn+w2WcKxLQQQBOHEh/1W+8Xhi1BE5u/gqruWjbUm32xFIIt0QEhaIRnULg/?=
 =?us-ascii?Q?yrkrwpsK7ngia0D4Wtkv/ZNEsA9Liw5g9Za11TaTxaYxNpQ9nqPjFgw8Jdqm?=
 =?us-ascii?Q?R+CZ9xVBdJfSvbMO9g0ESYNgPEAYQAEi1XhKLFLXCyD53o4gae9OV5j8zhfr?=
 =?us-ascii?Q?h/zXhtY34qcsviJJsKL1+VramurRo9MSVdY4S5DAW5EyykisgwiXQFCTllK5?=
 =?us-ascii?Q?6oTyzaMDpTU+SdyUHbbmP1WqL/5YsmAw0c7l+Rs0taropZTAvCITJi3tYV2l?=
 =?us-ascii?Q?8gB4fkXzQY2HOQl9rXIlDt8SeanaDz5DzVuSuKFIFjiDWFehjzMj/UJYW+c9?=
 =?us-ascii?Q?e8FA/fWzxINtDw/m0+UYqpz6t4zdjR16uqesPcWU4vAoz3BIQcgtBVqhTRCs?=
 =?us-ascii?Q?KfEEWaRblz9/YA26Dq5usDNmXSAo+IfXOfkPW4UfiMUKqk4sVb1I48waJv/C?=
 =?us-ascii?Q?k3TN8yyCMbGstLK7yIO1Q6CwXR0FV29HTgjg3LzgAXsAd3jbi8q8U9qzN12O?=
 =?us-ascii?Q?2dlkWmqFXWY9Zf6fkrc5i3xtyYPYAnEjRaMx0W4rqyeOFnAkPpIkRsQgP+mT?=
 =?us-ascii?Q?Q1/gPOV6PVHj1cZ7SZPDQlOBz8EVAWpJj839P1iXMC0wBY+d6HNZ65JuHyDV?=
 =?us-ascii?Q?xfLPggMfEUYyQSFGOvQ6TNgJ7BAqMv8BW8lrehElj5dr29MytVFuIVbtwe2O?=
 =?us-ascii?Q?DWZTBMWcUmJubsf6ficp0R4wxmAGSaldgapy93mm3dXvJsB3sMyHZGDcsvJs?=
 =?us-ascii?Q?POCohxT0vXc0RINYTXZz+hz+89GvtD/n+kU33OefRZlxXij38GXEQB6YFFei?=
 =?us-ascii?Q?cooI+PrlT1kaMhtCLD7BFPKF5olaNIl+QqBr/TfVRlPciy1m7D+o+O2H3UuN?=
 =?us-ascii?Q?MTjjITgMCN/5rMdrNAuM23d3Q70m5CzLvQufRZxyopcOFIgRQDFcLzUzdPaM?=
 =?us-ascii?Q?k8s4fgcCa6fSI3bMs3Vdmii/N+6ZzazjEM8hdLRu20d9QS3eKnc51mcVMp2Z?=
 =?us-ascii?Q?nFIGHcYGdb7c6lxJPUdhMJKKpdUYUa+NJrTMcGQGrbCnRdGhCWo/TRcoOUz1?=
 =?us-ascii?Q?Az9OvmW/9VQf0C6G6o9qFTJnEQ3/EURaaWdJqjD09sFJZnywJxJOw4Sr9VNi?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uBoVZF6yufQWB6pnGTMkfF+MLgxMdxoza/VdJJI4pZkp/tZ3qb1oMss63nJYslM2jKkdFTY2u8xbNrUdErZ5Y4ERcmz5UfvNFyL6eKi76Qe5i0xCuaXtvbD6N98TAJ1dkL+7wf2d4kpLCCBWFW9YLMsFnAVOctppAoZKlNvQGxCMcqCi5EOps0PimnbeYhqnBjLVN3712brYi9DcSRhyw1C+T9y1HVtHmvvNm7c1tVjmfXcayX2n9hfPJWyRD2zPWxtprnNR7VXuqqkyYzOmTkEPB5ZWua+GnevlPORKvHOUeeZyNnWYDiqmKCz1hYLYHwdyrow0vjIIFLWFiEQ4dd1b2KWGmw3/sOYZHyPFYk7px7ICuoQXW3ImeiyNPHCBPEer1Kv2jyU49AcG8mqrcia5SDX97c8GtJXIOMsaGwpNzaS1bN7MQfG7cXlG3+BBU+B9qQ7KIOkwGL4fLabLFzMGVXu1LeTRChso6BQp114WibMfOA+FwSYw89f3cZkmvRKFZS3Mz0lMAqB/oJhLrbMbpEd53g4GNksScxTL0iBjxYnEkuc4aZKAOBZHInWdM3hq7PR8+QYtEm7eR1iTn8sjSzf/KnPYs+tu4u+BhSofMGZebOg+qGTamKfalokFybVQKyXMDI6Yruk/IT+WJCxu3shPwRINf0NajV0H2aGl9jFhAVBTK8Xjt2dto0XC7192yxXV0p9d3frBiIl3JGhkPqf70zM9UUzUbfLoo80GO2tKU1oznJrsI2mn/pf5rbaGCPC1PWxUUX+yW3CVhZosncyhGoxP5ySVPsJyQrbci+a7N6Ffdh5tkcxuT4/sbbAocQuDZarUe03PYc9xI6nBLTh8SSgSNCXQN0VB5UuBYrEt3GzFMOKbTxFp9AGe
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0132534-edc6-4a3b-7874-08db2caa6b32
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 20:57:46.0713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oyh87aQJ+viFG23M1WaqajE5KrahF6zMENhjYtTNid7KAjm+RWha2czt7ogHb/KLe7I4xnuMgOYXfIXhMu6CXHpeI6gDag1GOFrdEnEtmF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7484
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=769 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303240159
X-Proofpoint-GUID: XN9OZwrCB0ViKmusLF5IhjHMLgqnc9fe
X-Proofpoint-ORIG-GUID: XN9OZwrCB0ViKmusLF5IhjHMLgqnc9fe
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jiapeng,

> Variable transMethod is not effectively used, so delete it.
>
> drivers/scsi/hpsa.c:9478:16: warning: variable 'transMethod' set but
> not used.

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
