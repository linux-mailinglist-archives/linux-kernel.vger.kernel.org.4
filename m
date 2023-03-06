Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97D86AC7DD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjCFQ0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCFQZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:25:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18438CA09
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 08:24:46 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326CwrCj002568;
        Mon, 6 Mar 2023 16:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=y9RXT6YQI6qfXYeSiTIBV2erHTqpwWSMOfMIqjcVYfA=;
 b=A2w241elpR2eE5PFGau6bpO0ip1nbu4qcAU6VYXwk783Dhwjt3DeS8cWnbqOvwayiUr7
 HIDl+RrWNo/IbqzZz2b57E7w3VOUCtUEWCwx0xxnmpDky+9cajfdC0XQIbgsi6Vsh+L4
 B11RWuBj3e1RCAz3Pz0OJxC/CV/gyrEvEDyn8vFSLpV40AFEcTIvv99sHLsXZmXGXNkG
 fcMfVb/8LP9RjCDqpInGXSA5qhH36XHBXJ85hR7XPZgiq0U6QIUlS1ahGOHpYLrT00wO
 Attc69jdvnhQzINAa8MLC923qnmEIFxZ01YknxsV55mnizND1IKi3EZEw0QxZEmW95P/ kA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p417cbavx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 16:23:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 326G3Xj8012362;
        Mon, 6 Mar 2023 16:23:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u2gfbhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 16:23:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eps/GSjvs6r9YUQmmhKHfJhdP7ZfNPcv6DmIZuW7UufnOyI0erGBKNudG2dSH+WSuDpdnvVPB4e3zCQKTYfjwQqp2uJwYG09hkVFKMx7cdFreLxz7s01TwsBr8yM8dIufKWgfWVfOvT9z2kxYispkWmFxc3n0rQM/O03XoZt1OSZWadLoPNKdlnp7POOO2D5HuWV9aybaXUS+Nl5sgjTHXufjXrNf7epFiIGFitxKMqUa3vEEnCIOu37OHel6cPAcG19oQcHE0rrbbfuwNOs/nrmKydQqblYrzvxVjO7BGoAqTo7TjCLCI3QWDYvtkBYRUKojgUKhJ4+VBDyKZSsIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9RXT6YQI6qfXYeSiTIBV2erHTqpwWSMOfMIqjcVYfA=;
 b=Hd7UJmQY1Mgt6iO3919Nn7iiWP5wsks5H6+/kjIFTDP/OioHJv5LL9A6OYGkn8VIshNbNwEfMRpmqVkpIpsAw+Iurqa+1xghDyKDK7mdCsoodqcV7Lu+uJLcP+oZkT0CxfY93VKhUNqv9WbRmZ3syv6YnxlmjGNv/NgbjkfeO6yIkzMk/f1QqZF4g86X/INmkBr6w1bKueE5jYyu4tivMEtodYMyceXtFrl/iMSezwC/4xQ5Xm+8Y8U7KCCwlJc9VBhumSYWSpLI94f4rPK8d3PJV6v0MA7DU0qZN2UKtKh2c5iQpFsWa9wyLZF/phYVWe49Ze4izqD0/JDM7Id2Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9RXT6YQI6qfXYeSiTIBV2erHTqpwWSMOfMIqjcVYfA=;
 b=z+uEfA0xqqKV9SMomjnU4DE3slae7v96B3RooJEk4qxCxxN9VJysax9VibcQOOFoa4Dk78+okKqVbsTCp1XpbxBqS7WA/OrFsZdkIQA/m9Ro2WtOTrIasKLyzJSR4dHvcqtZ+wQSI4fy/tzm6UkruHBFzXkaFUiAdDplZha0qPs=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB6530.namprd10.prod.outlook.com (2603:10b6:510:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 16:23:07 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%8]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 16:23:07 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v19 6/7] crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
Date:   Mon,  6 Mar 2023 11:22:27 -0500
Message-Id: <20230306162228.8277-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306162228.8277-1-eric.devolder@oracle.com>
References: <20230306162228.8277-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0162.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::20) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: be4bee16-8bc0-4d7b-403a-08db1e5f119d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/CIBurnTVBm16WDeY6kMnPIf4P78GiZZfnRwW86Kp8Sd/eDtZVCJVqjePpycUn/tOeMGSrUR6teBjWoEvojOjTX5DIQ4KIzAJbOHtc1Dbi+EiOaF/G6pwARhVcE3qcLXDKcjP0T1EJVhAP4oIp97FMtBR4vqtYpl+BDucN3JjIMQmBJ2trJeggfzN6Rv8CJmEZLqMyH/DJMnNnBQ6jpzh+HwGgg501IAaR869o+K1IWmuCaPQuZBT1oF6dN1aFZRr5xy4bzV4Yqv0hETfRd81Y46LmmGtdHzLGzSlkIkWRSl/BVhezLRoMSL375yQkZNMqOK1MBv05D4AnllpTfQU9u0yHCxEkWtjwJJCCw4alGRYOx4vXqq5TMSh7uZN+G3v72B8lpCqUNMHK6EoT6W7XUPIoMssFnPSwwoSMRqP2ZnTflxXNjoi/SM6lj+oeSomqHwcsDXu03L8FBUYzgydxLwIbR6Kv9YvSP7t3CB8sx4Ecy7ZOQY1zNRZGcub6efCyj6ILeAasMl5QcI7Lkrdf/XnSvmD/5DYb4h5tSoJc9mfr+rJSzUuWobMOCZyEksrKpDLwvTquXk41D69cdvlrK01SgllPYis3QeVCIhqeAASUX6Vkol2kJpFcdElZke+Zoe3hZRo9IWQDulLhbDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199018)(66946007)(66476007)(5660300002)(4326008)(66556008)(41300700001)(7416002)(8936002)(8676002)(86362001)(36756003)(6486002)(478600001)(1076003)(6512007)(186003)(26005)(107886003)(6506007)(6666004)(2616005)(2906002)(316002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nTCNfA8ukLpcaviO4FVWpZspORCf6G1YzfTDf2xhMaDlzyL6jVbhl2/L7LZ1?=
 =?us-ascii?Q?0atIjiAkcnITK1+dMM9b/JInI4SxmgtSg8kx5PWIaifp8reKNiIk/hcPfPjN?=
 =?us-ascii?Q?aexj7i1bwnQNQiyHJQp6jStgRb0gBCIbRx4vaAApBuKA4nE9xP9tW8CioOCW?=
 =?us-ascii?Q?z3BliQONXUaMoK3ZHDSHy7lP49t86mh97qNVTCVA4E5dKPzO0gjSOTRj2qmn?=
 =?us-ascii?Q?oRi82hrDORZc205Z3YMOCYi3Um1p+/aC4zY+JPUjTrGn4nfGqqvH4rH3lxb/?=
 =?us-ascii?Q?hibWHFPg2evYW5SbnVW5OYVY151CM/TCrjHmCMEBaoRB988vMwiuDnSzEqlj?=
 =?us-ascii?Q?rmqvBipyw3TuyvKbJtlSy6HKrG75/NRmBKXOCMOZFZ9+KmUq0kMYYhCEeLOA?=
 =?us-ascii?Q?yX+Y6vY63hvsnhx7mxPiOnOoP0/zth1sfWG5OKth6Pf3rRbEX9/Qw5moDP2+?=
 =?us-ascii?Q?PYEAUvC7wUcakWUtkMO/u42iCnt2RsqAQ8eXr5lXL8e5PnpGON3gjjAtRkkr?=
 =?us-ascii?Q?ONIoAAqj3Z+SEI0loZQ4I4MGYLPkn5nR4v71r1i87draMAI1ZBpuLzEY4NsH?=
 =?us-ascii?Q?AkcZmNx69eXjCTbj8/N+KRJFrHaFE/5Y46vXAkaFmCS6sNM9vWe456+1I5jt?=
 =?us-ascii?Q?oTQyQu2CzDGm0himwxrckhhDBJqVSRz/OJJZA4adAwJpCupqa9jLUQetVp3M?=
 =?us-ascii?Q?LMAm6qKpMJMKSP7iv7XSsadUVAk1cWqwCpcdzVg8Lv1GLkzQx8hhYlnouIqd?=
 =?us-ascii?Q?CZywR85SVjEW5K+WqVVtSMpPtVD+O8/9rGyGY1djpQoIMeOIz28umE9l5rYA?=
 =?us-ascii?Q?SmAjFNzJJW4tBctxryj3wx+nKVAjRbs/AKXnXyvzBq2eBNULhlypO04rXjVn?=
 =?us-ascii?Q?VyJm/5IVxlheU6EkfdY/9JyVJ1/iTLuA51El0gMYW1WoVQg6T5zvcKW4CuUY?=
 =?us-ascii?Q?YHr5aksmxgQrMKalNJ6hb8bruMX2nZ1j9wyA89TWHeJoZbVGrS76FMajJ8uZ?=
 =?us-ascii?Q?HP7Vy5oCxEkVsMHdkyaJb4Yq/ZX7zLRYFvxRP4o0FboO/lWM4eR0RfynvaNq?=
 =?us-ascii?Q?pp4bpR1ctR9t2YUv5OfMOOmpTWjJhLgxeMUBws4GddknHVKFojY2YcGNaHek?=
 =?us-ascii?Q?cO4LPdJhkxYE2kdVxMeqgtL6/N3E7TYb2dd3byxQJUt/ihl6KfdnT+Jy4XCA?=
 =?us-ascii?Q?NWPe9wHufVSVmRiJ19Yjud2C3BvCwyYSuEY4dCTnguJajOnnQ54wY7M05Llz?=
 =?us-ascii?Q?nPfhuOehsy10EYzu+VGznBPWiuZa7LHDHNjw25/ptqOznZ/vzJvNibgfYFiz?=
 =?us-ascii?Q?lspdeFjXSYrAi+MolJ+h1qJNTt3gayjBLCUC1ieLjAiM7maVvLo5fulU3OGq?=
 =?us-ascii?Q?ah/xdZ3gLTWxjcFcLfMGUaUqtELz9elv6mA/li0mc/JNsnn1/GKMkc6rD7Q8?=
 =?us-ascii?Q?Kf9Mvc9+8x5XxAVEO8sEIwX80fZgz9xfe305zNwilhu4iaRts92IVzTZXz55?=
 =?us-ascii?Q?GmkscRqKqx6P3ksAgSxfR6pD9R0dpWWgqbwzoBeGM6tN20Y1dURvwZl7qM1F?=
 =?us-ascii?Q?7i0ooqUNez6HzWeXyRjSIj5OIQ0HsPTwV58XFfmowxIkhX91a/k4ZfCbGQJK?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mRxK+B/mwAK9LUFDb5eTm4rJyGbQnkEgiYWeMqKOpnxBxVxBTtl9hr7+4ROt?=
 =?us-ascii?Q?wS6PjQ4VMPWJtsvazc+kfB7X6oJGhRXwEMdmlTeFVFyTvnEIOnQpyAwDrRgg?=
 =?us-ascii?Q?1uGK9gSFakBL6sHofdGIQ6np6AjidfeUVPhc+BqimHeZ7I5ZvzoSvSh7LdXs?=
 =?us-ascii?Q?kl7/BytwYx9LkMYSIi+qMjSoD+4cFsoA1qMYGhRteIkIvw4/i3Cw/5+eK+ke?=
 =?us-ascii?Q?kGrzvY/geSWJCGD2VimgSa7OnA2Xv1X/8SCzGquqZaG7D4BjigJO1kKPybkw?=
 =?us-ascii?Q?mBsRCit+jXcee1WUUKYc8j5ubaHWjHXaQJYHjzlBhv7AMSLQigLui25KVgo9?=
 =?us-ascii?Q?TgMAs7TFJ5DTKzT/cAjrzaSYxUzc8tTAY15898AaEP69aVBGK84szDu7cFFn?=
 =?us-ascii?Q?AgFRSsiloawEY86ODU0/xHSWkGkoGeN/Dbl5GOnxAeyqgz3NI7bLJaBoZlsm?=
 =?us-ascii?Q?Yu2fq9MjqF8j2UnL81S+WBHOWBTx+9zIPFwPiRqZK1En8LtzpK4F+DZLgGEw?=
 =?us-ascii?Q?OR37E9s8vf0LiXfgN9Cix2P8feNW12AztzcAR+wrDS404pVK/xLid8+C+qkF?=
 =?us-ascii?Q?Arp8+FtaJXXzLZI08QiwBFjJA24r5vvaMVIehT+mmzj6ZVw5c0tEVKbCvC9k?=
 =?us-ascii?Q?DyxUPUYbgbzgEBLSio5KxmF3fsTdHiIzBOLtbVQIILr+zcyFBVNakjJ14Yyq?=
 =?us-ascii?Q?2frCS6aQSb0kNk0Rp1dDgdXbz7pySsQ2pg2KPGBsvGaI9qF07Ut+rAkIIVmS?=
 =?us-ascii?Q?Hsm95n5N/6Uaom6cH34m7bW+V01tbWXiW9qqMgrUj7bp/54qQYOj8R31j/rh?=
 =?us-ascii?Q?YAsn9yeJ5WmwSY0lktM2Rqakaekd7RE1wQ+UHY94ElANv43W5dMy7N2rP5z5?=
 =?us-ascii?Q?a3vWwY9kX+CxWA2jA5YJhrNnRgoItGKD081X9bMoljEUYk0bk8GyVOr+uqyH?=
 =?us-ascii?Q?3uTH3lktFTjKJjsdgz21rG5Sb8FeL6o++LFKlYtqxvPfIk7NLVKL/XW26Jw4?=
 =?us-ascii?Q?dHeXwuoyrUz8i0L4pCHf6e+ZGAhe1oLdkIPIOF+uQa0kyu6fC3yuY33Nrz/m?=
 =?us-ascii?Q?GDg7OJJUJ/2VkeOotk/G5WFjF09N2UMou4khLgDpq1bn2FiT98pIub0oMnYE?=
 =?us-ascii?Q?WheFn6tDN831ICmgg+Q7npiL+Lfd3tfPkRsxaw/3qyqaBMjaiVIK9oY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4bee16-8bc0-4d7b-403a-08db1e5f119d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 16:23:07.2270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZIGccj6M/chIdIANF/Py6H6koa9Vb2oU5ypbH3zgG62sdWKtuuVol6/IzRj7cjJai/Qf/73EJxNmcgEj+uFs6W+YEp+nLTDvoILvi88APk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_10,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060145
X-Proofpoint-GUID: ewlG8ZhyAzFce90EDH26uJe3U8OS8hNV
X-Proofpoint-ORIG-GUID: ewlG8ZhyAzFce90EDH26uJe3U8OS8hNV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function crash_prepare_elf64_headers() generates the elfcorehdr
which describes the cpus and memory in the system for the crash kernel.
In particular, it writes out ELF PT_NOTEs for memory regions and the
cpus in the system.

With respect to the cpus, the current implementation utilizes
for_each_present_cpu() which means that as cpus are added and removed,
the elfcorehdr must again be updated to reflect the new set of cpus.

The reasoning behind the change to use for_each_possible_cpu(), is:

- At kernel boot time, all percpu crash_notes are allocated for all
  possible cpus; that is, crash_notes are not allocated dynamically
  when cpus are plugged/unplugged. Thus the crash_notes for each
  possible cpu are always available.

- The crash_prepare_elf64_headers() creates an ELF PT_NOTE per cpu.
  Changing to for_each_possible_cpu() is valid as the crash_notes
  pointed to by each cpu PT_NOTE are present and always valid.

Furthermore, examining a common crash processing path of:

 kernel panic -> crash kernel -> makedumpfile -> 'crash' analyzer
           elfcorehdr      /proc/vmcore     vmcore

reveals how the ELF cpu PT_NOTEs are utilized:

- Upon panic, each cpu is sent an IPI and shuts itself down, recording
 its state in its crash_notes. When all cpus are shutdown, the
 crash kernel is launched with a pointer to the elfcorehdr.

- The crash kernel via linux/fs/proc/vmcore.c does not examine or
 use the contents of the PT_NOTEs, it exposes them via /proc/vmcore.

- The makedumpfile utility uses /proc/vmcore and reads the cpu
 PT_NOTEs to craft a nr_cpus variable, which is reported in a
 header but otherwise generally unused. Makedumpfile creates the
 vmcore.

- The 'crash' dump analyzer does not appear to reference the cpu
 PT_NOTEs. Instead it looks-up the cpu_[possible|present|onlin]_mask
 symbols and directly examines those structure contents from vmcore
 memory. From that information it is able to determine which cpus
 are present and online, and locate the corresponding crash_notes.
 Said differently, it appears that 'crash' analyzer does not rely
 on the ELF PT_NOTEs for cpus; rather it obtains the information
 directly via kernel symbols and the memory within the vmcore.

(There maybe other vmcore generating and analysis tools that do use
these PT_NOTEs, but 'makedumpfile' and 'crash' seems to be the most
common solution.)

This change results in the benefit of having all cpus described in
the elfcorehdr, and therefore reducing the need to re-generate the
elfcorehdr on cpu changes, at the small expense of an additional
56 bytes per PT_NOTE for not-present-but-possible cpus.

On systems where kexec_file_load() syscall is utilized, all the above
is valid. On systems where kexec_load() syscall is utilized, there
may be the need for the elfcorehdr to be regenerated once. The reason
being that some archs only populate the 'present' cpus in the
/sys/devices/system/cpus entries, which the userspace 'kexec' utility
uses to generate the userspace-supplied elfcorehdr. In this situation,
one memory or cpu change will rewrite the elfcorehdr via the
crash_prepare_elf64_headers() function and now all possible cpus will
be described, just as with kexec_file_load() syscall.

Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kernel/crash_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index dba4b75f7541..537b199a8774 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -365,7 +365,7 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	ehdr->e_phentsize = sizeof(Elf64_Phdr);
 
 	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
-- 
2.31.1

