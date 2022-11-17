Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89FB62E3E7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240510AbiKQSOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbiKQSOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:14:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567FA8515F;
        Thu, 17 Nov 2022 10:14:00 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHGxXvt019741;
        Thu, 17 Nov 2022 18:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=1B9D2wIZCmxcFTd+gMx0y/vLCFgWJbGMWbKm1INvv5s=;
 b=oyIm9bczJNi+S4VowNXif9BrOT4QVR0La8/aNtqgP64g61bvTW/9WUQ20W9MI7VxrU+f
 ggT1wx2lN1+4H6MYjUtdTCuhK/nqe+R601hLbSTSTEISFy6glkqz211hYcVCaPJrUkdN
 vHZAACfw7fmioX/L99Yo4e9lirSEBQ1HTN7yt30n0F/pKUO+Efvw7rzs1qsKHOXJ2U4o
 +UlJ8hwJfPXFLO4yU+rsivsOk+1nGCj1DrvL60oxo7URYlzp4IgQOwmYs3dSe2lt3x7y
 n3FFSbq7lPvsed3vzDlWyhH9+GhgmEe8iNZj85GLNmGfQvxdpZ7/U2TmETHMSU4pow84 iA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kwryb87sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:13:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHHMwCS010865;
        Thu, 17 Nov 2022 18:13:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x9eqaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:13:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQ8K2fWZwFcZ7XdenFaxQ1KJqNavclfGNT2CxdrDHA2VRIfeu3ifCmI4Hl8l/uLng/MKynsoZ7w8RyQqtZJNDUNO9agagpuYcs/FI3itwKM4i0x9w1OOrP6yfvURv5u7KKFd/QEoCLxByuP7W0SKSriuYaE6qqShsY8DydTulLossReTcDMp/hA47ON1fGq37UjPeMIWuMotvH8BYJojQHMDXPEv4YBPIET3GeNxqmC8ERyMnZuSVuEVEYiRaNhgjF0HhTU0wGXauy0o/raukJ2jou7EqURNyIjq+Bb9ViqimbcPbElEYvRl5d20Wcf7wr8PH/bwzyTTIpZVb8PLYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1B9D2wIZCmxcFTd+gMx0y/vLCFgWJbGMWbKm1INvv5s=;
 b=VUqYYbJqQORXa//08cCUzF3af+5yqCjAYcFfhVjx45apk9xL8+iXIHzOvrtoPmsjtyswTnA72gRAPtrlshU/K7MlkolviNN19oQmr0FsN5S7/F5cV0NkjE/sPKhs6s24fQYzP/7YKJPU79AjPilYZqMZsJ2u1+ZfkcjvAbRYMASS9bZ7arwZSFHQ+/mqbIBZHIhWqgASDoCO8an2tDUPmRP4fRjJhN+2n9ccwcc5eCWyfgP+556E8fIxGnSMzyQEAsC4/Ewb4ZFLNjTMjiJ5mwO5QS45OFzu5BBcmPiU7uijpGRnFf4ppl4QViDtDmmNJ3NS9yvr1sAGN4cJmaOn3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1B9D2wIZCmxcFTd+gMx0y/vLCFgWJbGMWbKm1INvv5s=;
 b=rmXTxVMV/uYbZCNJWkdi0Qhau/Ns5mNJG9pp324yFN36vJ2x3XIWT4NOPuqfZ8eTn6Ogf2wVYMhu47ez3oTOQfKtZfqJx+9nIX2vk0AnL8KmvuBYYPBCzDaIMF/jIEK4idcjvltxY5GOiRLj3fzS2s+VrZEwm0Uwr+/EI1fka90=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB5052.namprd10.prod.outlook.com (2603:10b6:610:de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 18:13:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a%9]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 18:13:48 +0000
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     <james.smart@broadcom.com>, <dick.kennedy@broadcom.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] scsi: lpfc: Use memset_startat() helper
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y1s9wiss.fsf@ca-mkp.ca.oracle.com>
References: <20221111074310.132125-1-xiujianfeng@huawei.com>
Date:   Thu, 17 Nov 2022 13:13:46 -0500
In-Reply-To: <20221111074310.132125-1-xiujianfeng@huawei.com> (Xiu Jianfeng's
        message of "Fri, 11 Nov 2022 15:43:10 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0194.namprd05.prod.outlook.com
 (2603:10b6:a03:330::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB5052:EE_
X-MS-Office365-Filtering-Correlation-Id: 92796a50-4c53-4ece-8979-08dac8c77946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9BjU6HxORpxzU31b2BYaH85gr4ht61HAP84/w/sMrtoGqK7ejVIVvFVoutWv+nyfvXZmifE/bvFLGWAS4TjzNPAgb6PiG41z6DVzoDGUCcwvglffYFhl/L0CwQRrvsVZXq4Nr+4fkJvz6wMzjnG6nlWbnYUWnbjf2YPxfudYm04fWsdiTUC1/AQKRtw+aPe7d2jO09zW7GoHZLEPjqY0iHRcousM7QSESC8TzXvbok45tv7lF/fi9wzrZ+cPypY6f+5e09aRdnWPNpBfZCJau3/5FBb+oRlTZoho0anjQ2jFI0EuZdMiyo2Cl+zriHrIpCIJWPecPnrEqiKph1BDFTbdyWRRehNR+JIOSXgq+TA+6VDwogpju6OvHzOOc2+bakePS9tFo39bguUIN9yAeOWtI7PryeCi/yKHRHidQBDdUOWn4KXJOJsaodeHLt09EhnkDbW3JzAqqQdS0D/rsc7b8CgoDiS72ty6xpzelocAyPFKetfFu9G9CqfT9GQp6Y6ZELXcItPT+6RfDljxZZq4CyE69JpR6FPuLRsr0Zd6FwRf6LN/2eyAut6KSAOqIOUTEhh8UBfWn3EvH5vhV5CMI2bIjlwdK00NGNmuTQh4w156PB9cVU7nIFAQEOaFYlgtU6/1JJEli8WgG2PwqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199015)(186003)(5660300002)(6506007)(54906003)(316002)(6916009)(41300700001)(26005)(6512007)(66476007)(4326008)(8936002)(66556008)(8676002)(66946007)(38100700002)(2906002)(558084003)(86362001)(36916002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hFAnhzTG47FLLhdVUdqt85I8/P+vFP0vNhhYyWAEqtR+b9qIZZIQXGC/TKTU?=
 =?us-ascii?Q?CFRhH8/c3y7YiWdo7LCH5ijafPSpz6HwNcw5xrwWqc1LLCPgN5o2GwuygsXJ?=
 =?us-ascii?Q?rVNjUDRYY+yEHTdhF/M3VpLFswY5W+GPZ66h5pTVikDP3rP0BpEK9yVTItYM?=
 =?us-ascii?Q?YxPXYEGERerdFAwqELeS6SDsMSVLiwwMHaN9wlch35PdJO96LuFYs0a0sLBq?=
 =?us-ascii?Q?XwtAfvTvfiNBmUPjRfsgo27+YkbGb3cmzydQCJ+A+p+23rgYXXVXoOm3vFZR?=
 =?us-ascii?Q?BN+FSJDKag3QqEOoNhUoTXSdRwpMaAVcb5LmynL8MowaHTThJK+JkfK/p42n?=
 =?us-ascii?Q?V3muOWAhOt04Xhff/ix1ktN7KPzYN6z2i3d5b+gfWrQY3I8+T+vCZjEW0fEQ?=
 =?us-ascii?Q?CBOBV+I5P/wPx3OGgjlkHjtzjXjdh6VzMvNYZOJqz1kRnovQMrFOW2t/I2XG?=
 =?us-ascii?Q?/AtoGZnH0lkx59qnsMGL4MFrWKR9/rZSlIhdlmosp6J7y1P5BxbuOkoMMKBu?=
 =?us-ascii?Q?sgMrO+jazXsgRiIYG5VLBchCpw0tZtrv8nC39WbulB2ACS8PuRoCsraNgBnh?=
 =?us-ascii?Q?jrACUkyaRmqQp4PbVhX8BspBaJHxE31oEqtcwe8Ku2eoWl1v9yVkTo6rVMpM?=
 =?us-ascii?Q?qMsY9S5qI9uOmHpTDTn4MLEEtdubCiLiakNbFkZMxnUY51cjUAzbV1avNyQg?=
 =?us-ascii?Q?EcEcYwOg9LLKnzxYZkIJEw7yGGTWdawo4dRaiN8D5bV551SKLb95wkKdkScE?=
 =?us-ascii?Q?8ARrWL1HDibUxsgR77qQDZvD3DafeGjBbASWA77PFYnttRqS0XnDtzC0Jyf2?=
 =?us-ascii?Q?2FPA36+kPgoS5Ssv7uqbsO3kTDz3d8iESkbpDC0z57LZJS58eIYSOzAcJIAs?=
 =?us-ascii?Q?wz+SYt4jH+Tsp6x2dzGKKnosWhsNdI65imbdcFL7Pw2x1UondfFBrqc7w9n4?=
 =?us-ascii?Q?gk9vXtHUvmEstorA7V0zBMsmeY8MnwqaQ1RQZKOfnT2qax47AreTO7WucB/L?=
 =?us-ascii?Q?b/B9E/0RDDVf+j0QL7kSaeRJht2AJIniLbwzSmoKlbE1onnjnPFTWkUPUKHo?=
 =?us-ascii?Q?Lv1f943vvW6J07m5wFmFst/ziWju9BJYfkQqNr36wC3vSYGcKQkA3nmNsuXd?=
 =?us-ascii?Q?SD/JOU9fsfLl/C1jNjlS+I6/Szi7472g47z7QruSHSKgMPBxTmfIEMOzzz2A?=
 =?us-ascii?Q?BHS0XqYqTRucT/3eToAlMVwQzWWFKV9Z2k3nkmRU/a5nNtg/YPPwXIF4pfsZ?=
 =?us-ascii?Q?3hzbVVaAeUA6A4R5668fVk6Cj7mUcaWGDm8I1y1ZKYIEEErMha/KvVxKPefm?=
 =?us-ascii?Q?ei/zhMV3m68MX9rKTtMvY5kMPeIjZfSGwi9KzDqnur80yDv3Ar/TOdAZ9Wk0?=
 =?us-ascii?Q?bVskIqVAGrPMC9mhEFdwg12JByIcMjHDJUiUy8SqY0wJELdfnRw3FkPK2exb?=
 =?us-ascii?Q?DPq5gMIaF4d4rVWSek1qWFFEQqvHRMBP9wQri+Qem+vxJZkOCsAps/vBHGqs?=
 =?us-ascii?Q?n9XwEdkEiesLhKTV45pSqGIyGqbb4BUMH2wrp6wCboijtHVyzy+ss7+ObzMd?=
 =?us-ascii?Q?nui5UUBztNnaDkZb4YXxc5iZWotP/D+ZqCbjO1lWGwGK4qmoePfHFUJl1YLa?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DndUz/0MObsU3zH+DQa6riC7B1Awv/gPhwZ4i5V4pYc9Gu2nX6a90OxRU+JY?=
 =?us-ascii?Q?EKli2RxY5TobcFr4YA24StK3Np2bHj33x53JdhkUvPPLtEd9pXJDwibxuUW8?=
 =?us-ascii?Q?vf05DG62fb5Ws988S4QKuBErn288doe5rU6WbfNTuTLieY3lvOOYl43HKzNb?=
 =?us-ascii?Q?Pt7PQuqQyuN3xNrtdhKrtum3ccdGXa+TZs0cv4Md5QGoxjWM1nFynKfY92RW?=
 =?us-ascii?Q?Q4O+zZBU2CRHJfLc1DD7abfkbjcj1wbW7ZWoeUxZEb4TyymWd9o1XXVas//i?=
 =?us-ascii?Q?ry9a8jKH6fRRn2pk+rvdacry3X0IHQrjEHXD/+jxnglyQSLBxviLjNrAV0u6?=
 =?us-ascii?Q?Z6R9Ur6Wq3KKL+kQp1n1giijTiDtyvM7GUwjHeFD5derKlKPCQXvtWVEdu2M?=
 =?us-ascii?Q?fieqxfpQ9nE7ErHWJZLYiIgcF66EP9r3CC6jTCWPbt5+DSct72UJJpCTb2Cd?=
 =?us-ascii?Q?jZoxDjZaY9fQcLTE1+f4nU2vdATpLLKTiJ9wQ5YxpS+PJS1xAjJ71hORcc92?=
 =?us-ascii?Q?cBzHg+hoehtYb30gMACyR9gGyfbkHne/5lsq78/YelRrSeE/b3qq1whKxqLb?=
 =?us-ascii?Q?0aWf+AE1RuN7jKVEoPHGMQAYGnyAJM2FdW7d5+rBe/COjV735TZo82hhXuyY?=
 =?us-ascii?Q?XP2ftbad36LseJQbyF3nq4WcQ8LDuwtZAyKSsBo5yhCFsQ0B234wgNfWM5eF?=
 =?us-ascii?Q?G3Qp1OCY390Ki1tdZBtTNkCCW4iGsKSUyrl6EPRQXgCHozDSljeo9YhQuSCV?=
 =?us-ascii?Q?tTlQQoiweBxrtKP2j0rTc3GG58TOCsk8Etqnn7i+wD55BszilvqL8pbga2LM?=
 =?us-ascii?Q?e9gAqx6mDDzts0NZxFGYmObe+hXJs1cujVm/QZkJb7/XWDKSri3m2tFFItIz?=
 =?us-ascii?Q?geFW0+zGci9yTuB/WexN3YCFFAzp4kLhIBQAFGZWYFJjkNtlryhat4jixJkP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92796a50-4c53-4ece-8979-08dac8c77946
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 18:13:48.6621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faQghLPQy/lDRI0I7TzH0YmkqNxa+8Jfmu/+C2iRe8Z4qei25vfozUpRpmAqCnqwjMySMdeRslepGD+Snzzypv3b/zRuBVHxIm+sfkUYAUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5052
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=743 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170132
X-Proofpoint-ORIG-GUID: bZjHhONjRcFD5CQusFWQ3Dg7RbGnmlpX
X-Proofpoint-GUID: bZjHhONjRcFD5CQusFWQ3Dg7RbGnmlpX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Xiu,

> User memset_startat() helper to simplify the code, no functional
> changes in this patch.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
