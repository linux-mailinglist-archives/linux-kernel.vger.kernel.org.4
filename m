Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB43718E06
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjEaWFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjEaWFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:05:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEE8121;
        Wed, 31 May 2023 15:05:19 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJg0YR023256;
        Wed, 31 May 2023 22:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=xInGugiZ7XPkcPsedzXdbM5CzB9u7GHXsVGfcURjDrbzQhaknGR2XGJ56NS/6/yzggja
 VPOAydPJfHnqdWKfwGaK/u9ifeHsUcaFXKqviWnoKC0ClouZrNBb+gUbHiqcsgSxcTgY
 xuCLTUrQ2O8zshue5d3ikssbOeyNlYuhX+y5AblnNutcYFycPZ5XewqgGV82xZg7G2ol
 C7x1HgsCVvvwhiKaZz74f5kGWrPvumIpgLZQ8xdNPMtQgdeoIDXKeaA2tQ1SGorCoN9B
 x5QXLrdP0qIyAeO8nFctXTOZbGHD43N2Exd+gn4RfVmLSc4G4F3J7WuTQ9XxPCKQ2JM/ 6w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhd9y9v4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 22:04:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKb6Js030014;
        Wed, 31 May 2023 22:04:56 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a71e0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 22:04:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h04Ug5mHG19ReUHHGznk7NHBYc9VK3L0ckBdJhDoLhNmyRAsJP6YBM6LV/wMn9hxS/rTHs7BryOWApzJUBmrh7sjv2VqGg3LPxhSWPk0va2cTcnUmiVdcX5hQw9wJKWILilag5lRmwlvDbQY7B/XUMKawX6PBQ5Av4q0xjxOu0Tw/WozH+GYvuC6PBfOw+O+eDQaOx9bvsFRWhT02mcfhvH3+kjSqhYelYU6AyMh4Tkh3+0rhesFdO8OjLHTZjaFlHfVrGlXZaag2dxgO2ysHBM3A9IewjkWSCPDo/dwRzMubkFZKsaOBqDmHGlwC2YXBcILQnJIds6vwqu4cX5c8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=L9AzlO6cZMQi4emRRGA9EqSVUfqCRdh3bpcDEv7eIpT3JDK92D5RaSFWAMAdT9K6h3haGyphzCpRnNIkBVXg1zPA80x7YNkhIvedeZnaDxgas39RS3wYX2i2UOlHgBnRzkvYGL0C4lskyxe37fjSOrO4Tkv/liS4V7DfSqooUAiLWtQJFkeo29dD9aRIJpowOSPeme/rBzDsV1Fnp77MaUVt6WvtCV325RXs6VWjL/6sASgSrWxGeIqrRqTOSLQ8x+5wBl/o0bNLwtCYfmYt8IlvjTI+AzjfiZtD0SvTKNpGYk5Swc2NKlHmU2DrCmCwTp5ME4oCQlnIBr5AzYyFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=JrOsIzXWY7mR/39aXJR/uirnta6mofFNkt6Ap+AREDqmcPsTBt0vM6aYEzuxsFBKlbcbYlDyMuYk1q08XZ5MZG9PJmX49c9id74R2G4a3xJT1nONnlyOPl7nGGE9B6LvXgAWfFBeHwa0yBgWp148bOFVfOaibVqhXRSclTjISQA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA1PR10MB7287.namprd10.prod.outlook.com (2603:10b6:208:3fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Wed, 31 May
 2023 22:04:53 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 22:04:53 +0000
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: sym53c8xx: Replace all non-returning strlcpy with
 strscpy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o7m0cg3o.fsf@ca-mkp.ca.oracle.com>
References: <20230530160323.412484-1-azeemshaikh38@gmail.com>
Date:   Wed, 31 May 2023 18:04:51 -0400
In-Reply-To: <20230530160323.412484-1-azeemshaikh38@gmail.com> (Azeem Shaikh's
        message of "Tue, 30 May 2023 16:03:23 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:806:20::10) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA1PR10MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f10832f-6347-47eb-7ef7-08db6223101c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jhAozi/drZ48vpPqWUXfmZCS9fEVOf9C2lGAIqKlPJ8MA7oZLFCEzwqoMD3Dj/Sd4wXxMdj0OxhecPxBTVTXwkYPcXfNk3Kl40+O9AQUdSPpXopi7U6hDPFn2pSi4RxbH7v61B8NXdUO1nOf9dqg+s3Fg5PXayC8NMlGWXAnafq3RiWf5PWfrYCQINcpjXMGPaBYTYwRB1jx4HP1Gdc79JauUyWO/bjhoU1g/UaKxqxBBJODzN1DGzd8Bbb/dBAQX1/NJ+5aOxscX178ZP8xu9o5lt0IT/t1jhFQK1PFOmW7mL3u0Zg7mj0T2xw/7ficZj3LbKr9u0VYUjBkS2jxxL8heK1cmUuQVjy6jhjjZkEoqpGHW1CilOeqtfpPisNby69WU9/8lS+NKKU4D6l9OghBi2Xn0/zVpfU/1w+gkq1D+9mTEKaXi7V+9DxpEicelB/l2d+W37oe7rgU3AiW8oyEKV4T4uVx5oh3kS028Sgen17nKyFQ03kowDkpJbhMTNLEsUCpuQ+YsKxQuplEcmF/xk8Rix2VCnXd1oQHmsKBAFQY1RqblI2wMe1Rwk7goeTfViiRzZu2z9fnODCP9ilgYxNycCuD5Xq3ljBk+gQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199021)(2906002)(4744005)(83380400001)(186003)(66946007)(86362001)(41300700001)(6506007)(4326008)(107886003)(6916009)(66556008)(66476007)(6512007)(8936002)(8676002)(26005)(6486002)(36916002)(5660300002)(38100700002)(316002)(478600001)(54906003)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SfsrnB+GUaU9ADRsMCTmUK5KrYnV8f+/vuLS8F8Z7KaazMF3MMa3LthqdYZZ?=
 =?us-ascii?Q?kxaYtloTtYZgZFVqmCDnHVKoWtURcBtJq1fUShYlWrd/dmMyByb+3gv+hW78?=
 =?us-ascii?Q?T0sksj5ZkrSRPqV+6qI5+x+sX7ItcbUuy5YnJMvCVijdbsMQsJ/sL6cc1130?=
 =?us-ascii?Q?gvu/thGpimiCAcNXbqwh96RN8ox9iSnrD3GH24Mf6Aaf9Tog5WKFYrsdfkDW?=
 =?us-ascii?Q?Six4es7XIxNQTURT/c2KZN20WIlbupQWzmqmbEVLyE5sHJHjrgCkmLshDNHp?=
 =?us-ascii?Q?+lEMf6am9BLyey5JucY2pc73OVpCEEJtSrvpZfyMAphMpGBvzkGGl3WtAdJL?=
 =?us-ascii?Q?3E/Nn9Gp2T5aSXMNBexiUspVO6fhqbj1KqNhj5llOEEhpFJdfTuVE4RqZscf?=
 =?us-ascii?Q?iX98xVl8JuABOq0nzISGe1RQ51cchiGcqAqhyq6Q53sEByEElSrMSJDYjTn6?=
 =?us-ascii?Q?w6rXfKwxMs9KGQ139jgLPWLDHGfny9K1CqBYK2RQwfe5UjDot7LlXN/YX2AQ?=
 =?us-ascii?Q?MNHg1KsR3yXMLhDcVXFqXqcDyeM77K87E211E29HX39cvANWKpHVWgHd7zKv?=
 =?us-ascii?Q?ZuXZ3TjsRlQ6uqCsKm8j/04y6s6NJDU+puTG0Zo79ooYod5iwCiDs+wJmMrI?=
 =?us-ascii?Q?2C63nJ5zIlUsoWGb+rJU7RCb1Oh2L4zvNUh6JoWBYdJJh2cFm0iPvND10y6s?=
 =?us-ascii?Q?gCvKL72NUERWVT6m42SUQSoa2yUnJC03B0HjgYGOLYr3lXFlWdsiaPxwub6L?=
 =?us-ascii?Q?nI92ASnxNQInmiy+4EaIj4DJ+7rEuh411rKHGIYO2Rv9pYVcaW1SOqQJoPo9?=
 =?us-ascii?Q?NWdDiJxfe/Re49Mi1T0sPuC7Xig61MXuVbbxGBGaAAegL5T3k4OgTot/NDN4?=
 =?us-ascii?Q?rbUrEEmmCdZzA7ExIx46LlyuhC3BN5Je/gieg0edMDR10Wia0sajIhNCeKsY?=
 =?us-ascii?Q?XhB8UBDSjjiM8drE4xJjCKI4IvmWzzIfIOCxaF/v1/NmRH1aOspM/ZwYAIkt?=
 =?us-ascii?Q?UG/U9B5S3fReLmpfV8iTgKPxmkZ+v5ZTlPV1N6C8LhbUhhzrTpgfEmzgnSUN?=
 =?us-ascii?Q?ZExhlosgATn8AF2akxEMSZeGsmURkKGoOzBA4MelRFdKW2o/VqauXP3PdA9h?=
 =?us-ascii?Q?hxuwoL63PehMXQw/uCJcGc40bxv+EQazYy1TCJ7Zi+J8VpiQerUahFp1eYI4?=
 =?us-ascii?Q?7CPpjF778RIFuYuh9nuW2ZvFrOZN35p4krY2HmuJc6MBZZ+OxKvOj+YMmN2d?=
 =?us-ascii?Q?8wXZjNGfreeqeL5OGmWGixUnRX0VF5lvJHJIKlWvv1YAEcrUYmNjOBaLkREz?=
 =?us-ascii?Q?zSjIHCboW6PMb89eWTfm2FMe0DVIQzRlvJNNtdQe7bnLctJcQqxnH6U+Spq8?=
 =?us-ascii?Q?JRLUIXuv5LfBTF0KudpbNCRhRjzqCXRcQ2be35R0OnObqJuXtFtZHUHVzH4J?=
 =?us-ascii?Q?tfhlmnmcCY4FfLscJdlEBDlp/JI/9L1g4YYxDI8x5H8fUI4lZAvyF9GGm6Rd?=
 =?us-ascii?Q?qZssP535zYEt9beHDlVjaXWtGgfn80plYJ3g3z7sqknkDwZhVNlNggPNw1nq?=
 =?us-ascii?Q?hZH0tmHsSaB3JNTxZpuvwHhiTgDY6ksABAdhmM+EQteeFViGYz/Wv0mg9rN4?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: B7CAg9P5CSXuPGYqwtE4xE9cZOnKgvLe/XTYxiqrB2Jn5eDNF3OizwcRnoc/a//BFJOrTeXeKs4US71hkeXhCUXwc8k1XQQ6ksyXJhYKJ45URLHVVrD9M3OEby+zT3EDHSQx7pZVPIhsf21NmeOVhXBfO863fwfxJ0TBsTya4qKthO+OYGweXMSeGshNHLa7VhF4OJgHJ/Y2C3p9XN8oOQlgkcxXrAFniaf/NOQCNtJnJSD7OElrRTfEAnwFJkbyRvcaaSuonnRU/+hO054xnRUlIHS41GBuH1NY7mobGZZL982p70N/ns7R8uHjlQ24xCr7+2lJPGTrayhZcP7edq+NZLt37ZcpgOdBmuusdK5R1CW0G7sYKhXmJdlZA3vM9UD/lCmfHoH8JNIFco3E8Q1vNdactdkbWf+uCYTEQ4RsR98PsY+4VpEBN6AqSKYlpa4FhEFCqR73Po1I+CA8jsB13cH4CX0ZIyqJvtOl6h9Ybsx64rBvlaaPWJG7jxPPeLxblUEHlf5JkzOIMcpweBoFQjyUMq8QIrXqfEk2zz0Wa4zHDCzFpLD8rvg+7WYwCCRB7nfF60+MJ79/9hvf7KgYTw0cA6v253EPwHxryT0SG4qsikzviULUQIyZUd7mbIF1DIPY5ZXHJhGeeV31XmS4GBfup40aLOEEE8e797Se+heUCSo+WxAVo/Y+Do6d9sfxLbrsUcSeLFuI+YrItzmEuZOfvWnsMYp5JfHEEODJNTVs+ID7N25xew5bquvGunFU9cKXeJq7THdNtLz8Bho4ylL0QdsNf6O5mmcQaX1WbuReml2mBJdeFLRlOS5cSJJSMzgeyQYZe2iYjjX9lRdQoQ2Fz4BGSrtgDApCSVE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f10832f-6347-47eb-7ef7-08db6223101c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 22:04:53.8095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCsZRrttomaNr7Ptd/2AyFTIx0BEi6haIoqWgcQKlQminuX9JX3ItB6HUU1t858XR4i7OQTgmQY4IyCMV4R5Tu8gNw5k2AwlebI7kYFQFSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_16,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=961 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310185
X-Proofpoint-GUID: VnW55NJa1tOKKwjeA1Q2YQbW06PEFDB3
X-Proofpoint-ORIG-GUID: VnW55NJa1tOKKwjeA1Q2YQbW06PEFDB3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Azeem,

> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead to
> linear read overflows if a source string is not NUL-terminated [1]. In
> an effort to remove strlcpy() completely [2], replace strlcpy() here
> with strscpy(). No return values were used, so direct replacement is
> safe.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
