Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2D2664E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbjAJVaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbjAJV3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:29:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0516560867
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:29:12 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AL79oc003394;
        Tue, 10 Jan 2023 21:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=JSuCthEGD9mFVQwtGBQpQYgIPpxHUVzJky4kAU11Yd8=;
 b=bjHs6MOmTGzeiHevdYCLp9OUxMfy+MIR2ELZC4G02tYO9Fsc5HJSaL/bg9gPquqGyNfh
 cjL1Np2LC6r3yLb8c8HO4HCWxI0Lua5qbozQH+g8D+jzPK9YNWF+lK2LUrEbWsEuXLx6
 uecQYGYq76DDu5dIedNOA3Gz01RB2U9UcICLB9vFuK2TCt3N6XBcsdxjQUONKsKiyCAU
 jjEWcxtv3MqYrb6yGOzbj8evabR5F4trPt8Bv//NZn0R+D+vAb02sL2UKdQgMoqOeDnw
 2mMuphu55zSmVx+n7FYOtvazjNIAJnQB/CiWgwHHNtpMpcqIRvRmKmWOibUnulzPwVov 9g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0scedt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 21:28:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AKY8kS022668;
        Tue, 10 Jan 2023 21:28:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1f5x25br-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 21:28:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5qV87XunAXGbyq6K7n/4PFOCelgPxU+ic+HyQrcTVq2GzfrNpvPPU96qdl3sRGbIFtR3y8wa8uVEUOS0zH9ESBSqpwyifjBjhKJANvuD2Oc1X4cck53jeKBfGwwy9euu+bpjtRkfQ8fhmO5vjij8YiPdCMWMpmz2a083tRm+WYW9VBVmEfOp4B6ULKe9ROhNUP6yj4CEoye27pWdW/1GGjKAWyY1vEhCR40rQ7K8NMM9v1485F/NRauicrYmde7Sd6tN1YnEPzUIoRgNpUvjamD7le9QFB12fmGYiRMBH7GsWwgXY60paebmYedCcB0j3exYLx8RYwCWcvLaABxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSuCthEGD9mFVQwtGBQpQYgIPpxHUVzJky4kAU11Yd8=;
 b=O8SOIX+4kAZVGhWCM45Wk0DvCAs2QMcApXfCZiuQy/I20HQPGWdajE1vP3Q9yRI2bH+DnRV5jgJI5KhXQIDQtVXRgpMlpky29I0k7ti3/hnqZVa3GYYQ5qADSV7c4RKPolNZg6/biPsSxp3e/w3qPQt3a8M5liLXKGdF7ggvp0+lM2L5l8mep0SzPpa18LzchOWiZcUyx0iemGTVmxredMwxVsnpOQWSBuUkFxa4epbNhH/BiqGHGDIFxfw0YA4pRUG1+1/1gnyGL8eY/TK+6z8RNg9bYGVuEj57sEnjaP7G/25SzjBGoo1jPBUOVyqS/ZznmT7DtarefGU0wbFlfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSuCthEGD9mFVQwtGBQpQYgIPpxHUVzJky4kAU11Yd8=;
 b=BVjtNSEAMruyUhcWbt80p6WDBx2GX9o0sPxu6vfc58yh9NA9JbPQpdCvN3QnCur4BdmjUwiUdLV5p6Jz6XdIHFZmCclHP11ERNs5YKuNGCVpgH+Od5+yuCDRplQ+nlG4HkGihtWWvMOJjavtD0fKW8ekdjfNr4JqPZ5lLzE5CKk=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by DS7PR10MB5133.namprd10.prod.outlook.com (2603:10b6:5:3a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 10 Jan
 2023 21:28:48 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Tue, 10 Jan 2023
 21:28:48 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v2 7/8] mm/hugetlb: convert restore_reserve_on_error() to folios
Date:   Tue, 10 Jan 2023 15:28:20 -0600
Message-Id: <20230110212821.984047-8-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
References: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:806:130::22) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|DS7PR10MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: 931f2644-3f35-4a0d-76e5-08daf351a8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Op1fJXOAhxt/B+MP2vi8aVDyrKQCCF16EDsX4LgqB/PPrt9PF9DDVGfeVLiuIjioLTYPNFllbxfN/t/IhjIoYPsgu+Wsr6CXgX4Z6nuf+VRiUCF2QGOq0/bdXt0CMr0azBjSXGrXMnjopwT52E1lwEtKLx8W4C5i7UxjsreAo45ZzWuiBkplfDuXZBiinx1XYaHOtPjvCu1Xrm5a291uCgEcBKX+d6ayMLx3tO+hMARjjKBTu+falnCjcFZ3P9f+ezao1r+amHUCu3VgiN/KbdBXonQ02uIXGKzZ6pqU8tSmCqmkPdIMYnjgq/s4W8JTvPG1U/4G40IG6o1cG8Nay5wCPkjGoFfyFj+V8GPxSFFEcVHYGlNMrDbTKyEssCN+tXhVpXwb2Q1Nc/QCnmjB+ZmTvqVRVzxpZvER0S8myHhVN2DfVOksyL36M0N7xkLnNvGqqM+UwdTXXSZL8EMqW/5OOWhEZdVJ0g3ZWSPc3bwnBoBV31/mFj4DlEaB21GSOwIvk3Cv8y+xGWwdKKkhnvc8Pp1g/sPMcEke62ZD014rn7TC9XR0uqnQeQYHUQgmfXAUZHNZ9H3Ph10RAs2uWQFWYSm9DFoAZzCjCMWGHvBZ40f6oIIE//655Rakwc/2JMGy+y5IIalGp5PVFxgXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199015)(38100700002)(316002)(36756003)(5660300002)(2906002)(41300700001)(44832011)(86362001)(8936002)(66556008)(66946007)(4326008)(8676002)(66476007)(83380400001)(6512007)(478600001)(6486002)(1076003)(6506007)(2616005)(107886003)(186003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7iTJpskraAojz1GbnE2AT2KG5kENru52V+8Ww0Lv8DFjHudNUWU0CAOleQRi?=
 =?us-ascii?Q?Y2nX+ZND1lQ1lZYvxo3xXiWrb6Ccrg0FECyBpgEzNb4k9VBJHX4NxCeylKGV?=
 =?us-ascii?Q?70jrXixozeJ+SqEux7wZvOd6+OipxFNyLxTlHqWmflgg84AIu6hUicNWq1lT?=
 =?us-ascii?Q?r2fsplPflTqgdlskYg8vBoTh8SwS9Gq05JnzpIaWzoq9BodNJUt8gOj3Vovr?=
 =?us-ascii?Q?OrJ4bTKK+2Q8w3RvG/yiGlHi4vzLRWKYCuIqgZyjAXRSaErCDpPmAhWrlZFd?=
 =?us-ascii?Q?ELt0QropSaRN5mbslF6PAP8AJqdhTyqhPwrpWn5w5VCQR4xZYu5a2emskWR+?=
 =?us-ascii?Q?IYgdrkV2z16D3qRzXBMUZfKEeos0x5eOD/svweiYWGgEueKngBZBsnb3kdF2?=
 =?us-ascii?Q?rB7SHl/YtOzy/xS51SiH14oJRNbpbReGD5RCb/pLs/irfZQGGQRbOTSghjdo?=
 =?us-ascii?Q?C8Sc/NT+9u93YjsAXrLse1XZmmyZo+ktB0+ZUuHIX3P3san4LOcYUy08gRtB?=
 =?us-ascii?Q?KjCztnA4ABRcIhAvnRg0+4jMK5Qc2vaiceGjvx0jAoSMeHu5GJNY9AKFsiX+?=
 =?us-ascii?Q?N/7+VyyGg6PFqS3c0RhOPZfHxbVtwasyKOOQsf4wj1BFtYAMn7asrYIFHuol?=
 =?us-ascii?Q?nE5t6rNo3YDIuwbcTmSqDyxsZLGYNyH7krs3AfWB5GvT+AAp/6BoQZMr7pr0?=
 =?us-ascii?Q?INBzn/3LSM5Ggr3NJcQYrpdluTd65uU8I7vXNgBCuACChLycOpDR0A0av1nH?=
 =?us-ascii?Q?JnZEvLHH2Nwiu2PR/sYClkzDN7UrYSEtLk2YPYLwgH1XXdV20ttQRQqByZOl?=
 =?us-ascii?Q?vOx69VKhNf3GdruR8t5yyRfz4BNiSg4xW17bWq9FlsqzFjBc2zjHlCQuuTvg?=
 =?us-ascii?Q?oElRHjXJEy6m04SLQF/vY64Edwg3egHQeAjZ5i284LtFku4dQfpocNUecNrX?=
 =?us-ascii?Q?pw3L63kur+bU5ggia9sop2DF1s96JJceN+EUGEtTFZh3R6butqk9Ebi8D5/K?=
 =?us-ascii?Q?Bwzl3mEquJxHGzDFPlowTJk7kB4yFZcABp5G2GajMrIcPiwT1B0nT3o0UZ4b?=
 =?us-ascii?Q?9MekuXcjNOJCt+/VfjbOkx0SRQIp5iRYLeVOd+ygAGpOu9+CKcOm/HLJIHoP?=
 =?us-ascii?Q?0i7BcHV0Uf/EtTBpApFEXvA5dL+EXHBwFWHuW+qD7TFT5evggEyreBxVYXYv?=
 =?us-ascii?Q?43fg6Ftj+6HktVCdumishP3wnr/fFYmB2izCLN5VIhitpLEEFqYG5ediU6ec?=
 =?us-ascii?Q?WYZEAC/9vaXRhN1YAm5sg7ZDB3pRKcFaRbapM5q9BqKoUQk1VspDhRDiLJ2b?=
 =?us-ascii?Q?1MH0DHN7C105Byu/D/rH6BvANETEYiGnj6a4bpMI8tKk0k3o4+juOjp8tfz1?=
 =?us-ascii?Q?JMNsIw+yc7uEKMbR7t/ynN7pKWEmsqBZx2V9RrP3dNIpsWoXnQGV5A5HD2py?=
 =?us-ascii?Q?xavZRVxYFel2Ji8LufS9y+CKkON8HNyTFXZtZ0v7W7HwL0SGNbotqZSB1H3H?=
 =?us-ascii?Q?DhMV9mq14wV0v2zDT1daeUKVzAr3j2r2qQGQk/plmElcTrangVX6kJNvxkiO?=
 =?us-ascii?Q?5Xqbknt9eghnvpOiInn3keeqZkP/yf2ifDBZlXcvzNQbRrJi0iIRjxHRd+SH?=
 =?us-ascii?Q?lakyd2X4s+IYAm9BdfYZelU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?bRDofkayIcbX0J0MrCaEGjj2IcQyMu1AY6ZZ9k6XDgrbGn2SSgqexySob4tD?=
 =?us-ascii?Q?gzg6BsFmEkyGF+sPzUGeBLbpEuXQv69iqdmeVeDHB4tTrFh13KmFsJrRVSBA?=
 =?us-ascii?Q?uyzBhWkKwZrhkuhs4V2smS9NAjcVPEFGyZ23QDM5fQ51Rxpg8tlEkETHgBf2?=
 =?us-ascii?Q?dPSPR7e+Yz8TPTOBONM2MTQgXzW4+9fW54MopuDRj4L4yAqIqSpuIk1y0XMj?=
 =?us-ascii?Q?47L5rKDadvc4OpKnUlb2zFEOw3C8l7CUAfSK/dQj6aCusnGmKflaWuRiamdK?=
 =?us-ascii?Q?E64/zvzMP9WKWhZ6q7SbG+ngceMJ+ngj9OobWYl2K9HOh8Jp+7r2ZxHle75z?=
 =?us-ascii?Q?Nu6/4csafbi+zRdf4R/eOpUZoOEcihxej/o0Qv/D7ipvk1fZWRF+GTuL8HKw?=
 =?us-ascii?Q?CoFHVUk6UPWk4jKcCdPnEGlQwX7exKb9L5ed5uwq0ki8HyYm/fNVfxVVBbHm?=
 =?us-ascii?Q?HCSDMeV33rWIKJvG0LN1V97SomHhoZ4U8JWV31oq5yOdziyrbqDyCuIBO5Bm?=
 =?us-ascii?Q?2zUr3aNbWcTp4f/kGBLMu8RYsc0ZVjYw5OfgtFkRNrhtPIOsVywrTV43CESz?=
 =?us-ascii?Q?h87JcSi2ck9kh5O7LR8kS2rBN5rIrlYBfOOKzb4WjQmYnICEt+Upq/3iJGy9?=
 =?us-ascii?Q?413E9iKYYAr93yfyhR+kr04rDX+Q5dGbfV9bfNk+MG/eQOfxlcNmzKOedRJr?=
 =?us-ascii?Q?fMGESHwdkQFftATL0PtyEEgmgktLEkxeM5mS5vz1dzxXkk+ozm8uR+tjZhll?=
 =?us-ascii?Q?yZMssxxjqqayeBEjS9yq+gEzpGwfbxRLVGNB3EX5of0AVBrFHdkqhhW4kDtj?=
 =?us-ascii?Q?cp+TpfdPbcSj4QCYro/Bx/VH+zk6UVRN4gVULqVG8TXbCpLkL09y1yFhzKyG?=
 =?us-ascii?Q?ecaB7HM4ykB3a+HxxxxdliBC2H3qakNaAs4W7MzpPdWjoN1gtsnxi6EhyIX/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931f2644-3f35-4a0d-76e5-08daf351a8f2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 21:28:47.9959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOsK31rU8axA2Cv8B8kDQsG8IaEwd+oQ0zNcUBdkQlJJyDCPTTplFYGX2VK/PfgZoyTlXPfEm53Ss5+d7eOpgya0gkjUKz59fKu+pJsSgTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100142
X-Proofpoint-GUID: cPj94O7dIZTjnwK0wnKPwlQ1Wwdctz9p
X-Proofpoint-ORIG-GUID: cPj94O7dIZTjnwK0wnKPwlQ1Wwdctz9p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the hugetlb folio flag macros inside restore_reserve_on_error() and
update the comments to reflect the use of folios.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c0cfb075cd58..f8cd0c694fe9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2675,22 +2675,23 @@ static long vma_del_reservation(struct hstate *h,
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 			unsigned long address, struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	long rc = vma_needs_reservation(h, vma, address);
 
-	if (HPageRestoreReserve(page)) {
+	if (folio_test_hugetlb_restore_reserve(folio)) {
 		if (unlikely(rc < 0))
 			/*
 			 * Rare out of memory condition in reserve map
-			 * manipulation.  Clear HPageRestoreReserve so that
-			 * global reserve count will not be incremented
+			 * manipulation.  Clear hugetlb_restore_reserve so
+			 * that global reserve count will not be incremented
 			 * by free_huge_page.  This will make it appear
-			 * as though the reservation for this page was
+			 * as though the reservation for this folio was
 			 * consumed.  This may prevent the task from
-			 * faulting in the page at a later time.  This
+			 * faulting in the folio at a later time.  This
 			 * is better than inconsistent global huge page
 			 * accounting of reserve counts.
 			 */
-			ClearHPageRestoreReserve(page);
+			folio_clear_hugetlb_restore_reserve(folio);
 		else if (rc)
 			(void)vma_add_reservation(h, vma, address);
 		else
@@ -2701,7 +2702,7 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 			 * This indicates there is an entry in the reserve map
 			 * not added by alloc_huge_page.  We know it was added
 			 * before the alloc_huge_page call, otherwise
-			 * HPageRestoreReserve would be set on the page.
+			 * hugetlb_restore_reserve would be set on the folio.
 			 * Remove the entry so that a subsequent allocation
 			 * does not consume a reservation.
 			 */
@@ -2710,12 +2711,12 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 				/*
 				 * VERY rare out of memory condition.  Since
 				 * we can not delete the entry, set
-				 * HPageRestoreReserve so that the reserve
-				 * count will be incremented when the page
+				 * hugetlb_restore_reserve so that the reserve
+				 * count will be incremented when the folio
 				 * is freed.  This reserve will be consumed
 				 * on a subsequent allocation.
 				 */
-				SetHPageRestoreReserve(page);
+				folio_set_hugetlb_restore_reserve(folio);
 		} else if (rc < 0) {
 			/*
 			 * Rare out of memory condition from
@@ -2731,12 +2732,12 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 				/*
 				 * For private mappings, no entry indicates
 				 * a reservation is present.  Since we can
-				 * not add an entry, set SetHPageRestoreReserve
-				 * on the page so reserve count will be
+				 * not add an entry, set hugetlb_restore_reserve
+				 * on the folio so reserve count will be
 				 * incremented when freed.  This reserve will
 				 * be consumed on a subsequent allocation.
 				 */
-				SetHPageRestoreReserve(page);
+				folio_set_hugetlb_restore_reserve(folio);
 		} else
 			/*
 			 * No reservation present, do nothing
-- 
2.39.0

