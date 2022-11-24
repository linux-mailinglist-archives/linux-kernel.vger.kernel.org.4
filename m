Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CAE637101
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiKXD2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiKXD2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:28:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B24E31F80;
        Wed, 23 Nov 2022 19:28:04 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AO2iKDo028162;
        Thu, 24 Nov 2022 03:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Z1BdZ7X7hAt/rW0J4UDpLrJTXkhEOYZad21hXJI6TUY=;
 b=sOOfQ/zpGsRIxcSwWWSraLP9BLrhjOgvUGmkrxvhrV3bgMiG/SEubJoWGXkH5VdMzI0f
 +Haq2jrQBAd7P9LICFli6Igj5blFCTZ2cG6wA9TNIriJeDLLW9iuz4S9ZJX0+W6GH/Hv
 /SEhvcJqN3mwyxwl+4xUi6DImV+gJdjJjGvFGQuF2IQ1xK5fda+frhPE9xEitiDLLbxL
 LP/UkTj3gHP8Pu6yD6vuKPCFqCsf1EfK63N/Kem4oBaNyYo+b/P+Bpbq+5X0zb1TZICA
 z4CG3g4Hkoef4ccL+s+4ESfE+M6Le6iPAePjieBRKb2EuKTA/JF76O8bQUBTqt1TSWgk DQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m1p5fhgu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Nov 2022 03:27:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AO0I1UF010837;
        Thu, 24 Nov 2022 03:27:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnkdxxc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Nov 2022 03:27:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZsD9Xvqy4PwID7Q7nHsE66yLNj7ajn0kE2mmQCTtJe3qqR52IQJVayPWXaS4nTsCTjLfkDXS7pt/6tVdtkLSUcUYQhFELiiBiO1ASicKzpzYND5ZI2DUAh5J4jytFnicOrW9Hj2yoz+EtpNyPbGH5IeabittBwGsHL+LBt78T7UeDDjIGWSDMYzCHprAu17Mo9PwzoB0bMa2EqOMvKcrElf/iUIgBe0Xl+RudZiT31JK/FeLPROvJ0awke9Wow7L6rhauQZaBvXYhvhK4ACEFO8+eue4Pu2uL0jUVF3nqBOdMquSBos63Lh9pDUWJjJ++WWbkSn1KS2P+4vKRIEsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1BdZ7X7hAt/rW0J4UDpLrJTXkhEOYZad21hXJI6TUY=;
 b=e3jM9l2nVcMc0J78hlTAJbsp9d/Jw7t7vtt2bbIlkwi5V4n53p1y84SOnHSjrJwGjTFXj/2LRBEaHwQsRV8ZiWWHQXP9MozSC3UHj47HfF3/DMUJTu8YDdchfffVTWE/ZQc4TT8l7J2Qim2AD78qNO7uCPAROyFHdeA6TeTzc/KR1vuRnltdubgKN21nER8C5fGIyl3pVbTkENmw5RovtjrMr/YGBcwnXnMSBDmerK1Kno+YSTTsRoxZ3pf/IMv2Pm3xRsI32UOPEEHYjGpgafqK0Se+thvcINb48PaIgftNo7UM0CynzeVN3MlBFP2y4NOtjbI6bTR7aTyLgqSfyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1BdZ7X7hAt/rW0J4UDpLrJTXkhEOYZad21hXJI6TUY=;
 b=p/rfJ3B04kxacoAqEDhOyJDwKABRFPfesRLUDWL/zJRanJ3XSfFgRNGHz3iFAEshpeWx9B4m/ZpH+0dgycat9reVjdyWlo7fZLFe/2+OblzF+fVK4CcRVsIprNL7vHX/ENyG1l6mCCsyb6tMXN54dvL6mlhgersxJ2RePXPnhsM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6553.namprd10.prod.outlook.com (2603:10b6:510:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Thu, 24 Nov
 2022 03:27:47 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a%8]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 03:27:47 +0000
To:     Wenchao Hao <haowenchao@huawei.com>
Cc:     Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "Mike Christie" <michael.christie@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>
Subject: Re: [PATCH] scsi:iscsi: rename iscsi_set_param to iscsi_if_set_param
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bkoxt4k5.fsf@ca-mkp.ca.oracle.com>
References: <20221122181105.4123935-1-haowenchao@huawei.com>
Date:   Wed, 23 Nov 2022 22:27:45 -0500
In-Reply-To: <20221122181105.4123935-1-haowenchao@huawei.com> (Wenchao Hao's
        message of "Tue, 22 Nov 2022 18:11:05 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:805:de::43) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b42cf2-a0fe-44b0-33bc-08dacdcbdb73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Dac/yHYfRdktVb9OZLG7lJ32YT4Zben/t1zxu1+IQCxyDz2zxqugPNQ4Ayx/OEKrDSekdv8JXgcbo7/PRT6uAULfvNw6Qh/qPu2XHQe5BfUQWkpKzxQ7xr1FBbC3NdkLI5HDSBVT6cqsrWGHWuBkjE+WPPXtUFlDJHIxycTcSPQH9+RhOiYAhvnQNge+AltAtZ2/TL0mcJ3ANw9db4FFmVi4/RGOoJaCNqDxzq/a8fcAnVRrJUzL+hJI+9rjt4vPpNnNI4yFHCbcAJI4Vhw2bS1sneoNgvyme5vb+fzByiss4iZ5dyDl4rLl2kcrzrlMjJ3ORHIyCq2kny1LAifl9K8yQMdVZU813ejVSoP0ONRzPO1+yOA9ZRyzRaa5/2ys4MELNzRKAHAsrARj0Lmb6YbIrhukPfunndfVdzuzmRtv6A8kUVdc6fiTP+cfcRfAQIVzBPGGxAkqi2QKXB1MG6Pnm6k3Co1fMGChPqcLbkWQ8xgDAoOInxOwwPZg3ZUjl4CS45/x39jd+fyQYLI2DnIqM1n7aARWHYkqrjKajF8q3p+/LZlv9C1H45vGFaulXUC8UXSAXFJyHqJ2D/rQqSlRgz3Q7V2ZT5ncJVYTTZSQV3cufqRnFwLo1bruOe5wbAEze0UUTRkoP8b/db72A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199015)(66946007)(8676002)(66476007)(5660300002)(186003)(66556008)(478600001)(4326008)(6486002)(38100700002)(41300700001)(86362001)(558084003)(316002)(6916009)(8936002)(54906003)(2906002)(26005)(6512007)(6506007)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1hoEysorudcAJ/3IFkeKg6IJE5XSGP0Ow2QreFdp9Tr74D7pwX4nJz1N8nf6?=
 =?us-ascii?Q?/rdId8nTMgGOzsTSxKaQ60sciRn/A67Uo1b2pGjDzgrZfaEHI4wZyp2QI+UY?=
 =?us-ascii?Q?QrfnkFldwZgh9ltEc1BZxKkMpJvlCMnKxNmVR2/T9tbOG0giWiVGOHORlmUS?=
 =?us-ascii?Q?NHZ5IwVDiHYEhNqtGnIuTMF/JafgxLH88sc7OOhFFWijTZJMdjRJA5ioKcTh?=
 =?us-ascii?Q?9cdF3SLAE2fXRlv0PMqdLpxaix2r0k9RZsgxxAtdmuKwQz4DBNYbckISAZXO?=
 =?us-ascii?Q?MczKXSbKb14mSSVkxuBS2+Fb//RRfY2KylsBt1KdThpxCmnKnXE/j0k+VHt+?=
 =?us-ascii?Q?os66X2/9kSDv8pRNrvijPQRT9PKBT2K+j5ZQa+JrFgE9ZPMBrgH/jlumLLb1?=
 =?us-ascii?Q?V2HCwUgYTS1b7GwfuHdiforYu0fH5AJaje2zmiVgUccR5Xti4bZuAyUSvFQO?=
 =?us-ascii?Q?S5tTVSSAPe+KehZ9NCsGCfYdQYPyOLJKqowULNXiix3OE3gu22a0neJN2uZc?=
 =?us-ascii?Q?wdNHPBOb/ura2Ui552ns3dJWO7BmLAGgOGxXfk2Y75gijQAKV9kjchTP9CET?=
 =?us-ascii?Q?9Vhj0hTnnIoXD2xFEp9AyEr33M8+JVHUC1TClW4wmcLE9I8WFoHkgNo1bnq7?=
 =?us-ascii?Q?XXYubHwt/r1ox7yBUb9r7fWL54O6gcQMxIQtz8FKumtl3/2e+gaBDkfvgz0B?=
 =?us-ascii?Q?8XKP0VDJirhcTh/ExG7Qb+1bTiML5NJqdgim54p7xVMmoyA0pzLkBdFsXDSG?=
 =?us-ascii?Q?yHGoF5mdo58U1ntGpH1zXn6xYzqwISN5rCT2FJbSTeAj9CszqB9G6nJbg1KD?=
 =?us-ascii?Q?qmcfGKupKq3vuGig+d2hWPF30JIObr/1aP76cH34eJ2paarzSXJ72hQwq3D7?=
 =?us-ascii?Q?5N6jDrWohdi6LqRLkIMApU1/MMPN5gzsiyZ4kZVYcr2syTTW60RAeSv1Ndzf?=
 =?us-ascii?Q?ufY3gIdBlQP8BVjZgBFJhgs0aVchthoPgizsCU5BzYsh/FWOX5nKjgx6vmv6?=
 =?us-ascii?Q?9nloX+NenwFz4WVg9ntslW1ttJ7Pgc0FEL/VL9eOV9nB1G3zrgGzPpkfIeR7?=
 =?us-ascii?Q?C0tVjxFE52+1dVO6rWI6IJyMhhcfMrX0X4KsT/jIf4dWCn0Wf41ggaCBjTIj?=
 =?us-ascii?Q?eQKf812VHAF9TIw+UyPNGgmOKvG6/TvctNedBS6yIrAS992yxZMsOm6d5cyP?=
 =?us-ascii?Q?/bEPVhtHpcCsT1uQyFakLp8ycNxNyAJHRYVUfw39R9KJTwpGGfpYm0NtRQZw?=
 =?us-ascii?Q?09Pj+rUF9Sj7dyfsh5XFy3oCilUHsFI65teWH4t3Q3LkIc/VX5cNWy1OWKbn?=
 =?us-ascii?Q?59c+2hQypJVAxZB7F9XuH1JQoyGMUj/WRTa5qk3cUhSAe5nW/yVJFQGhw9J5?=
 =?us-ascii?Q?sOHHal+YbTOnOj5xWtyIm7iIKxu2c+ITTpM3xFcKP26rjVUiQ3xlV9Wkim8f?=
 =?us-ascii?Q?B1H6BkrI4S55VJqDhmtIKzXLj3U/+a6lHfuNorqBIfKL2ZUe32R7MmiR+sPC?=
 =?us-ascii?Q?V6yBdsIE6ZNZ7YQJVrpqBi3z9jhTqi9xFQbXllIxAwNX9PxCWzWRNqK2r2IP?=
 =?us-ascii?Q?i07k1xQj8YA39Bco9VSxPGBLPk+WAp8Ov1T6Qd8tlYJOQ9ywz4zL4Mp2mZhv?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nF6X1eTwXKElpSNMXdJhiE/bshg4p2Z8YMLgjnvDih0pL52nIwKYmJ39HnRw?=
 =?us-ascii?Q?yL4ovicZM6m74xbhqBL+9E/0hHfj2/h7YM9nhTen7PthWfiEjEdS3gnWuQ1u?=
 =?us-ascii?Q?ugouY4UgiwKmK1Ggm6mvUMyEuLgwOQXqG393uSAHR1PR2SsULp3lLtkhiGgO?=
 =?us-ascii?Q?5OdkWFHEX4pn8vwENrA/I3a7DOtzFfKtMhTT7dDEtirAbdrLHQIzCmWnrIpj?=
 =?us-ascii?Q?o/4vcOFVOjHlRYmYF//06/qMlyO8dvdWeqyaePa9XSPDLmwKjQjLLLq+5VKy?=
 =?us-ascii?Q?foUjpNTOrTuhjAdf/wjX1vMIyea23nV3gmoFpWC+gddQ2R90dzzVtClg6hkw?=
 =?us-ascii?Q?c8CHB4LIS3c2d8OQF1of8ZJ+JgfzTgNE5qkt9yXfC+CDkrcrEb5DOrUOoB/e?=
 =?us-ascii?Q?OKR3DrpimvblXEzLjQRzKViKDLoe65ZKsmxspeickpTiqxACcPQMDVe7dS9/?=
 =?us-ascii?Q?B9pyCbWnoR/S+s6r2sE62rN3lamYKCv7LM4Luo3uyX/CBRXqRYxTxU4v5cxy?=
 =?us-ascii?Q?NNcQQj/rIa62TZq3HTx5oVRHurtt+rDgBpHZXp2KNbW6/qSWMSRfwf/Yf0ow?=
 =?us-ascii?Q?F6XNitRrPoaFK9E5R1PSDOwozc+qcR7XVXD0KEfe2tTv5dsMY2qUxCMc3eQp?=
 =?us-ascii?Q?uLL99E14rRE7Oj0PacG6uFrtawvHFiewtnwW33FFU7+tibN+O2fERxTuMQL1?=
 =?us-ascii?Q?M83aUpjfcKjF/pq2Gz7bcW5iLv7FcmRUCPmjPDOHDd+WF0DBG4ec7j5i3o7l?=
 =?us-ascii?Q?itW/KPmkuqKnDYA7cBOYjwijuJ0dDG4WfdzMdB9/c4CPgLbU96Sfj+gwTeJJ?=
 =?us-ascii?Q?qlWzg2od0KjM3ogxVLfvEFOzVSwgA2+Y3EbuUo3Tb2wOTMpIoNE6vSBOGniz?=
 =?us-ascii?Q?SynxqL630GcQSBh2LIIKiJNm7fjhnqTEo4I1K3ayYsLzZnWGBDhzWEaWubJM?=
 =?us-ascii?Q?H/r15UE608Z2rGyCb8QyiLmF5SijdhyCpS66CbFGQlnSJ+g3AW4tNs4VrjVW?=
 =?us-ascii?Q?MY5KVSk5nlB5iHIlsg4P7Xre+Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b42cf2-a0fe-44b0-33bc-08dacdcbdb73
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 03:27:47.2973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CP/ocI5krsJdzLMiqGBCL+u9OUKMFyECIlc00TJHb/T2w+1jItroUeLb8fabh82FpUGoAVZB6QchIz0As4cqc5oYEAGlllVEu7YA58G2nfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-24_02,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=901 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211240025
X-Proofpoint-ORIG-GUID: dBnXe2n1SilzqkojtScbfGKoFWNNCxPi
X-Proofpoint-GUID: dBnXe2n1SilzqkojtScbfGKoFWNNCxPi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wenchao,

> There are two iscsi_set_param() functions individually defined in
> libiscsi.c and scsi_transport_iscsi.c which is confused.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
