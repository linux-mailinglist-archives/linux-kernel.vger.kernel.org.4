Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB32B65F9E8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 04:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjAFDEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 22:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjAFDET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 22:04:19 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF126CFDE;
        Thu,  5 Jan 2023 19:03:22 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3061Z4ds031473;
        Fri, 6 Jan 2023 03:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=uVuQW52TQ7ftQPC/7AiRsKjWWcnQ5aEBLKNVgkJXvMg=;
 b=iASW0W8wS0KvCvZ4Np9wgqDbsJMF7agEh0s3ld+l2Tj5IdBBmlGiGEfVqwHZjkj2arlo
 pAcELRzaAK9G/enP3INqr7nKckYHjz3h4RtsQNSHmegb9bkFlcaNRs0mrElkpeq2ek2/
 BsC1PkXD5rbX8f2ME31q8+BkZ2h321QT75aQ1B6YU8B7zUGz9QCVbVCZJKR+Xdp3AOet
 kinCUKO/RfW3KBN0Jd0d3Ac9ScqSqnVi8zFpDKnTdFXkFgTBs849hAsIES9nF3IJ+E1Q
 kjEeoACaUxnvgm1dl4gxAl6/llUwfdP/pdRBCaJfZpe27Ve0x0AgBjWqYggC0e/IvqmY fA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp12cjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 03:03:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3060fwZV040435;
        Fri, 6 Jan 2023 03:03:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkfmssv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 03:03:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUoFGKtjeykj8glpQiUUeRCP6wQtYZjYfbyoyKeLtkIYQS97ekN/M4tb1WzfdTWUWYSABCO49yGheBPogM9OR+4/bmm3V/LO4C6Axgx9JUbm1TCJHlMPQSysCvk9S+JZ36cRpI6FBK7SSea6Enq8caA5/2rYmdM5RfGZeXJxQ/AQaHWySSwjf2XQTO2ZgnIUKtsQQmOYskBAu+leR8Af6IkkBjCSAzNXpf9op50iE0ynlOQCRDQ+pSgdJb3Rh7f37VNXEEfHzC4S3R7uHLMUbILvCOiXbbcVu4+bLo8QxULSdhvSJ61ChiaN6JBBDNkQaZ7ZEyze96mIv5ZZkvLY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVuQW52TQ7ftQPC/7AiRsKjWWcnQ5aEBLKNVgkJXvMg=;
 b=i1kmbMf5FttYIj5XyuRodAeoj332K01mZDT39d9yopYFR9nUqznNi28OAAnXANTjdme/Of3P8gb/55Gg2XMfYFZhCww45IadpBoQSIRQy7ibWkcaGsMpVyd0QdVUTDvkAUO1NLj0ETKHxd1+WesElaYt0vUA144L0YNjoIXDc4Cy1UvJCWguzD8nhTlLbkLxA+NqCVF5QMYM38Bc7MbPMuz4jbtL0ZXw3qMZ3l11uGpUbotGrJrUsWTWhhIy6j8Nz6OC31M8BYxVj9qexOF1M46bHj6fhwqBNTs/psjwhThktOiGVFn5ATsXmZ2VquFySEEf5ty4YgouqiIFimsxmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVuQW52TQ7ftQPC/7AiRsKjWWcnQ5aEBLKNVgkJXvMg=;
 b=keUsNuLpBZiZ9muggDteZ1jVQVwqFLXV9acLeOU4cGbVjBmDKf9Xhjuzijf57RIuohTO9iaLI9afh+QLR65mf+kZcDeXxs3wOuy3OM8wFc1kn9IQK0TBd73E7EsqbqJjjHS2j6WfDtQ7huRVimrgmtmzkIH6MOQlqh95Ok9Unwg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN2PR10MB4285.namprd10.prod.outlook.com (2603:10b6:208:198::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 03:03:00 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22%2]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 03:03:00 +0000
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        jejb@linux.ibm.com, andersson@kernel.org, vkoul@kernel.org,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org
Subject: Re: [PATCH v5 00/23] ufs: qcom: Add HS-G4 support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y1qgz7wu.fsf@ca-mkp.ca.oracle.com>
References: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
        <yq17cy84gqc.fsf@ca-mkp.ca.oracle.com>
        <20230102084707.GA16638@thinkpad>
        <yq1r0w91zbw.fsf@ca-mkp.ca.oracle.com>
        <20230105100044.GA4463@thinkpad>
Date:   Thu, 05 Jan 2023 22:02:56 -0500
In-Reply-To: <20230105100044.GA4463@thinkpad> (Manivannan Sadhasivam's message
        of "Thu, 5 Jan 2023 15:30:44 +0530")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:208:160::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MN2PR10MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: 275ed8be-42b2-4cb4-9bad-08daef9284e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1LspHnm25b5tPp2pYozQR8TABYEW1DVXCeTKwtPdRzTdLmqmdQJ4HZasaRU/Qn4ZGkLMUS6vsVLPuFN72JttJK8STj8tZLYgJ/jNDvU689M0BL3R1o8dfX/Cp+zdG6YyUl4oQlqCY2Xsr0E0i41DwB6ElpRgaM8qvAXSoIupSNpwPpKvSV8ODm4wrzDRgJJUuh6hr4MDwDVVt+cAGBD/xpzF6HKWnzEdTC3E56jSYbkinLDiY8lTgZULHcyoFkCUFWE9vGCB4VK+0hrYKlB2zoYCSANdQj3iz6cbR7VAJTtNR5IaiNAQkTUm8FbeHA3WQV6cqbOmO2B3mV0z2OfZYHDWo/+mBTjgRTE+MYekbUdyTdAGQcbrjSfxhXAX6bFpaEcE25+8XEWpU9+ok/nznHzVXdjjln/q4W2PJKNERgGo4/dp9kwvdbFQQ7Z3jfQhu9cLSlCdz69Y5sy7VB82eZktexmgCGcwApcTJrT38RBCofcjxtBE/fbr0u6pxWrdVaXvvoSAgvCDT7cDT8zAwq7qAfiM/3cyBiC9jhMcYlUE+pKmskPBiK1Ad6K1t8SLuPNacbe0vrN6vZ32ja+2bnC9KwITu7s082gIKjzWj/Um3RGouyCSmDNJ9WssWdBKXcq2T922lRRmWI09Go7iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(4744005)(316002)(41300700001)(5660300002)(8936002)(66946007)(4326008)(8676002)(7416002)(478600001)(6916009)(2906002)(6666004)(36916002)(6506007)(6486002)(66476007)(66556008)(86362001)(26005)(83380400001)(186003)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ItSnNlc+cANIn9KZSL2ue+76GK9bTdG04isftnPStFlTprN4hDtnJXt8ewFV?=
 =?us-ascii?Q?JwDhYgqIeodeAv6W5qD0o3Q2787qbSr95VFxMfPcpeWGkGbFNdB/y8b/DkP4?=
 =?us-ascii?Q?DapPm5rIYTmHz5vEzoDaAfqYjXvwy5nregI/Md/MsEFfJ8UKbyOzAYafhmte?=
 =?us-ascii?Q?3MMM45zJwSdge05XGOfUClqISYTU3DVGQU2UdSIxNyENbO586c1ZW8JANXLB?=
 =?us-ascii?Q?FvDMD0ekPXyXJE9y3/edfvEk40P0UFTUNZjp9YFMoQvJLfh9U3YuuLx3tkFP?=
 =?us-ascii?Q?24QpIVlVyaUzVri8vOLC0CxTciKIyHFA/D5ptpHfaGbM2/SHpKs/hwuMzgxQ?=
 =?us-ascii?Q?DiT7Vm9YepdOXO1DpndChzUtYR8xivMiIlV2k0m+j3X2UXULDxqNQGA0McXq?=
 =?us-ascii?Q?p6a/uwzHI9lMbctwQUsfr0fPYa/8QUxft925jqC9SLurKfR3BDdsIwll3Z/l?=
 =?us-ascii?Q?DQyZ8KPexwXvk6yzebXhmUfnaRk5xKhUYccEQG/7Tdkc1BVyNpzYOBtvEk6e?=
 =?us-ascii?Q?bXTDlPYx9hQM0BNtbCH+j3zefc5VDwGJEw4B9RU7J/bGXqDy8zmRZIlC2Qkc?=
 =?us-ascii?Q?k1p5/iyQjLSwAsCtycYC1Scv36chyiiHT30GtzOmKrxGFBqVfjNwYwhBqboq?=
 =?us-ascii?Q?0eCq3F9MPvZ9Ks3rvfkXK7AwACaz17D5DkV+IFO2T23No6Wwb02vHP1+9VE/?=
 =?us-ascii?Q?lv8u6BGrJsrTnPeXaG0FTOmHlupqzpnfFRMgiWlPKr+PlAU5OOqpyJPj1M1m?=
 =?us-ascii?Q?cdkw6rvvmLOgmNuXKNwoihei7ph5A2c2SWN6201LjgGLXgvxEmhPIVOSD6fh?=
 =?us-ascii?Q?sP+wmC61P0Ka7QtrzDVY/xGGqjuC0wSDE5Wk8qCWJZ7luyp4npc5TusEyuAp?=
 =?us-ascii?Q?Zjji7fVs51Da96PRd3YiWNC60cQMHTeeSJSBnx2iVamPeByUHdME4Zt547CU?=
 =?us-ascii?Q?8H5YMXLkKIN/LJDN8xGCoPpxvp7lgE4gvz9ZdP6XP1XXSASs+5jf8myKA/qr?=
 =?us-ascii?Q?JrmgeJe+RIcKGaKKWhGeCnQgSxOpL8D5z/FCwzSGgfWgt21t4hM6F/nYXlUZ?=
 =?us-ascii?Q?SNO2HkPDBhJUbjBoj3s0RO/p8VkK/7hxkrdjINdZHQvIhnyEOae2I0gyEsiZ?=
 =?us-ascii?Q?iWqNAM9BTL+7BBY5mw2NciXraS/Ls3lcxxMCgnhZRBv0ruBC5MeNtps5Hz7t?=
 =?us-ascii?Q?JvWBNGipcEnFOwRov649F8EFIh4M8MbY2mQSNO1aWXC3tvJHl/Yu/RJ3Bejc?=
 =?us-ascii?Q?0xT4Pny1P+YS/EMbNLnVXLxOx3td9hczg5SAtfF7PUGCY4JDpYW4Psib2d5z?=
 =?us-ascii?Q?ApPuSI3K8KrfKaHWIzOVCY7rSSJrBSYfk4rRz3jpCeEp84lD0OFpZPtFy4LO?=
 =?us-ascii?Q?8hhumvUu77fYaCheBYZfDZFfzfosGQy8seQBg7W4VcL8yE3xpovcY8iq+lzp?=
 =?us-ascii?Q?Cei3lO0Txm6YfVmWfzXGkGmdhYAcf6E2CkyTEyFurWG3PShCJtSvbc4qcT6f?=
 =?us-ascii?Q?djOTyW+HTxubXQkuP6fpetygOXkVmvY/yp1Q/YS9u17aFiTTThO7bo9JgKX1?=
 =?us-ascii?Q?q0XS2kVtCx3D6N8gO7pXpYnhQEXybBp3CIKWFBF2kx30R9tQJYtS6Raj36Yq?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?N0HblXK2nBSXgIG5ltMX2LVIxcZg8NzX2UMq4GY0N5OUnL0URvjsdQpXpAAQ?=
 =?us-ascii?Q?xB88ZUXDaAOmTY7ZuxC/HVCqyc2w+3oiyPRQW8x3O45/v9ppUSFarY83dOJg?=
 =?us-ascii?Q?R1GKEeYbl+0kH2CVteIR7/p73Q+6Bef/0btt81RQWW/AR7Ms6+SzqB0ChUS8?=
 =?us-ascii?Q?p143g8EINqbisie7H5A9pjuTxWyXoYwtajDaTzvlqGmZiZ/5HqboxSsoEVGW?=
 =?us-ascii?Q?0nt7iFjVUCLYF5EmaTMn747XvgEGtrxgC5tfM8nlyr3QkIhiKwohAm9ijeXI?=
 =?us-ascii?Q?l6YV8ZIbwvb/4vTIrkJddtSiGs+TK/UCI/POVV0Pb1anj0USpHurXUuOYaW0?=
 =?us-ascii?Q?w5DolS2Ow7I1/l52GwF9kJbAAGGI4RX67f3yLEhuXJmYKtdnxGrXZfAuaoy7?=
 =?us-ascii?Q?9GKzlypy0LArzT0xgv+jPAvUrcbkAD5D44tIhw8rmqSTcsJ/dhPYPVO1wHdy?=
 =?us-ascii?Q?dhe18eCyp1snYPKi1XeYsiKdIOhYWk2kKFwtLI37FcvA+1WY2jxO1IOXiUtD?=
 =?us-ascii?Q?I3q/PuE9Jsn7FJ5lqq7tLxAKSnkty+Aa6I+DIst3AEOEcHb+B85gIHIsPTJt?=
 =?us-ascii?Q?xFJDwoQBO6BB+3vfrzmNv3fckYg5436IR5kLYrviM1d4wnKWpkTMuPEc/vH5?=
 =?us-ascii?Q?Goe8NweAAnK7mOQr/sG8l/N6c1qHOlKxnFXdGTlMXiJawzVHTcTZb9M6HtTZ?=
 =?us-ascii?Q?1CXXCWQEn+deirZ8Lrx1NvKG15paB48Og8wh22itWsMxkS6pqJXzCGk4td45?=
 =?us-ascii?Q?AK8jWejvLC+QnW8ytxYNX7qtJbukRLjuyfGNxgsYPWNROpiLpjCp66DBh7y8?=
 =?us-ascii?Q?XPfYwp1hq4MW4eLleZhD48nw1nf0JgOK+6eEUkrFmsuLAFQwJi5bcjwF8IYw?=
 =?us-ascii?Q?f4asKoH+OgOz0j0wm0Q6lG0Iw3irvdSUp6VM1b/qX58Dzd6OqmpJtcJ5ELMM?=
 =?us-ascii?Q?fKdgTFgnECcPyXqVmUe+4YlJfiW9dFLgYBNVQ+kLbVrdDYyGVHTfQGESmJh4?=
 =?us-ascii?Q?qJGpii5BlkT4qqV0NoBSeSRoI+Ew8tuTQWfoke5qXTxRc5nivyIHlsOOkHWW?=
 =?us-ascii?Q?EtnY+2HtyO4UXiQS4rfvAv4mRizQv+EIoEwYFY3t066yUz4/8PkR6vfF/v7X?=
 =?us-ascii?Q?Re7yIZI54wxqMAVnYVZDy2vvAi63hpuGytXRihvFWMbhBPMucEaZPaLjhXUD?=
 =?us-ascii?Q?ooU87TDFIXsCdAMH+YErhjzD2b07bjdEr2eijnOVDCZpCe11GaE4h646QHQk?=
 =?us-ascii?Q?AtDvgmornlyLPfQzZNhH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275ed8be-42b2-4cb4-9bad-08daef9284e4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 03:03:00.4090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUokaWzIqED8+qZ2ulpJbDhkMHRvK+ZDo7G245CJDGpmeSRA4qhL2X59nfHEH0Wtulu6R/EXxzllfObaW6UsftOEeC/WQnAi1YsKnRP4Ovo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_14,2023-01-05_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=965 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301060022
X-Proofpoint-GUID: kRIdh_gBaIinaICFHcbD-2qAv-_P4Sji
X-Proofpoint-ORIG-GUID: kRIdh_gBaIinaICFHcbD-2qAv-_P4Sji
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Manivannan,

> Thanks Martin! I presume that you have applied only the ufs patches as
> mentioned in the cover letter. PHY patches are expected to go through
> PHY tree.

Correct, I only took the SCSI patches.

> I cannot see the patches in 6.3/scsi-staging branch yet, so couldn't
> confirm.

I did not push my tree to kernel.org as I discovered that one of the
merges had pulled in a bunch of unrelated commits into staging. Will
resolve this tomorrow.

-- 
Martin K. Petersen	Oracle Linux Engineering
