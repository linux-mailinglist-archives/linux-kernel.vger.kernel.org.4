Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2592B6D6B32
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbjDDSFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbjDDSFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:05:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719AE5583
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:04:44 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334Dx5Dl004322;
        Tue, 4 Apr 2023 18:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=JXzBAQRwuU3hvtr3keklOsIwdYcTc5eA7m4tHvzfsAw=;
 b=MorBdlzK7akgSlLFVS82K8OKXjiVd7YdLVsFCPtCa9H19Mms+pgEkgsGP/CCRwmXG6bS
 2qjrfmCGnFg8xaFEv4OkzTCJWruABDqUbY6OrRTBy43znuPMDtvA5aZbo8/eJX215N/R
 XWeiEHhO3aPug8+XVRkKh07BsHR63diVaIV6M6VJoUfsEkepmJtVHJHI1PYYG4LePZ3X
 myi/WU/smGJIpywQ9mMHpMvS+8rRLCq/BMj2T+MEZrvcb0U9r+iETAFNd6MBcstuhhP9
 1lc8hGrOqpwS+m241CCJUDzqHn2jp416GuvNL6PGH6QtQefPJzgPyUvIpp2DI5vhqmqa gQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcncxhn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 18:04:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334GWe4T021450;
        Tue, 4 Apr 2023 18:04:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptp7geqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 18:04:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFR0mTDRWoqHTPRhdq7ViKQBPqlldlH9ZZ3ljGNTzPPsEbxRS7QZtiQepxKuxkwHgXY9vK/pBKgJL86YnOwnOKcbOaREvrce5fwp/ryLJraUXr2qtsoXY1+28RxbezulJmAXkOn5H7olCPDOUdljiclQgLBPk5tNSquJ2WH3/BLpGWoiantfk5JwsiwhR9Wkh4LjBYGjKRrYHHW1Ur91A1mEWxIAqqWsnNU3mIYEk6I9h52hzbbU8Z3Z1B6JFCQJJllqOG25koB+/RoBqIfqYLqov+53l4mQWUNaIF4FLq2U1VkDhdb15LGeFfzOb68Gzi0AxcKnh6upqyTd0XJ/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXzBAQRwuU3hvtr3keklOsIwdYcTc5eA7m4tHvzfsAw=;
 b=CMtQXGZakkjjAbrKPECVVEFmk84vrXy7u47ZrLnylzKNscNWs/UJksZ2toOkEj90y4v6u9s3ydy7hhLUYi4kY5dOPj2yKdK3gXOSxJZkO11lWJHlh0Mjh04YNfDDqyS95tfPNBtTBVfjuZ9lbt0uMU18suRMOk8nd6oiQqQPU82Kt0sMTMqyfXrSVOGgVbcFtm3b8xZ/qgnQCrL7uNQ1hDAmFmquWEkHNWFNsHFXbfn9gqyHta8oCKQAYiA6SORlFnS2Km4xUFnNFl+lW1Wmi6WOEfuZCcJfpskvEAS8MOl7rA8ptgwia85EOdfJCOtvFNIOwCV/kBQendI8Dl3IGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXzBAQRwuU3hvtr3keklOsIwdYcTc5eA7m4tHvzfsAw=;
 b=SqKybcmHlZtoi7E+/USbRVCokxbBCR8uDwOgIUTD6QXHOy3cKFrWyucbZJTfxIuSWPfYX5zoWIQXjCCGCcQsIj8rM3jNsv2GscDHsHi+8Q2vl7UlNhrqZSfKtejqVwTJDgN2kJo3MLbKCGsPfjhWMyvNb2rhdmyGaIPY8k93aCc=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN2PR10MB4365.namprd10.prod.outlook.com (2603:10b6:208:199::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 18:04:19 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3%9]) with mapi id 15.20.6254.028; Tue, 4 Apr 2023
 18:04:19 +0000
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
Subject: [PATCH v21 7/7] x86/crash: optimize CPU changes
Date:   Tue,  4 Apr 2023 14:03:26 -0400
Message-Id: <20230404180326.6890-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404180326.6890-1-eric.devolder@oracle.com>
References: <20230404180326.6890-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P18901CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::17) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MN2PR10MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: af468a4c-0291-488a-ca53-08db353702b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BBEAjdAMnb/AwMdyn+Yky2WtjbAlCsIYxlH0WX8YhSkTCMnAX5AXpTdoYQ0fO7tYGfXs2660hR0s68k2bW93rjRvoxK2+4WlG3k1iOj6+eiHoH75fh6n83lv9ITw5SSbzQJ5wQjOAmQ6nSrSNQjZRDFg8+O385yDK/lIUjJoYN/5RXGLR+jaHPXjl/KjJLCCWjT59dzMHAgfzxB3HPM08C9vGH4mm1+38lm3wPpN46MisfqSC0SVAivfpTE02kDpgfEdgKHIp0GszbsCfnOqz52hNTS7C7usnskovbN58xSWbZE5wxtosgjaZP+ahjuEaQxnwGtXj95aweQiI9byQm2uLwrr6opGNjM9CgzmI50f1Vr3Vzu17LAiB4cgERRSErrGxNRhfTDf2TX3/Jxol4+SL4C2P+jsOJPZoI/4RDmvaFL3naf7RLJpFS0sIot3Jey6HvWNyg7VCePkiP3NGmowC9JS8NP/A7v5zpgI480CLl+uIR+qo//HU97W6KGc+KtKBDwcmtdrU6Fnt4H5fl5Fzg9QilmADmHHqUua9lIQwHV1wtDT+18S1thmwL2i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(6666004)(107886003)(6486002)(83380400001)(36756003)(2616005)(38100700002)(86362001)(6506007)(26005)(6512007)(1076003)(186003)(8676002)(66476007)(66946007)(66556008)(2906002)(316002)(8936002)(4326008)(41300700001)(5660300002)(7416002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KxKcp8KCB9JSNfJnG+Ma/KKEo1ywjpd+fPjm2KEmyLkoOeqMrT7fkAWpAkus?=
 =?us-ascii?Q?lVc6FqQOLJVgLhPtOzJjTZly5iqQRo4dfM6C+43cDniM8NnFGeAWOWKdK4cN?=
 =?us-ascii?Q?f+PWaDGKs+AKGl+XGyb9YtrL4K8ep81YE7A4aKApvjRahnqlwi2VH31bCc3P?=
 =?us-ascii?Q?sppmU6GYw+WxBrY28DOQC8OtVzFN2/4ZOeHOEOxdDg5ck8QBB2ZGHmlN2+tq?=
 =?us-ascii?Q?9IP6L/cCx5068B50HTo22DWZwp4dU/JucQ1AYFV4+tHvu/37QNA44sRMmWnY?=
 =?us-ascii?Q?8vGNrIeJPPNLWMUDnISFpU7AEcABFnUdFDvYhqNAkB6sb46PgvefmEpxNok/?=
 =?us-ascii?Q?JwL3NPUbAWJ72OovvdjphgVTTitiEigiw0gxBg4PkM6uRPz6VuyKj/z52PuU?=
 =?us-ascii?Q?DWZtE5Ysx1NJLeXdLmpwOrghPU1LeNpDWhIirhY16lMbCTFYuPiYQDsqtKtE?=
 =?us-ascii?Q?aPzgekH1Ow+/yRsdQ7UEwrkbO4KeXHrLSvGyqkehgPZjBsXNFj+4pyDCtqOB?=
 =?us-ascii?Q?aVOlN7SEjtDGRWx9ZvN6R2bpYoqCgew9Sj3rCIsdnG4MXr4H/QRvKyJUVpAl?=
 =?us-ascii?Q?X9C/eiWthOF2d+Y4U5FTLAIn3lebLvzQzY3XAiNe4AdagWc1r59ZL+Kuwl2L?=
 =?us-ascii?Q?LpC/rYCqpkGHQvKdsTlMzcnO13orBHOOBi98uUV0vRG1rWQeO0aBzzWbJ5J6?=
 =?us-ascii?Q?BOHyRUC+lRFbA24/4EsBl0XF87aNHQWy5Jky/MuhVvVXRl0KA9fUP5J6n621?=
 =?us-ascii?Q?GV1XMv9RSUBlXXqcUzVwLOuOvS+FUCon1gJrdixzJmQr83KAvIGPeRtZINaq?=
 =?us-ascii?Q?yfn0HbY9urJMt57Llo/UL2ZYTeaV3Xrhyxxp/tZKuUjJ7GNK3gyaJsu14peE?=
 =?us-ascii?Q?ku5Oeu+HS0CX4VOJQaUiO0WEP/29ZrO0H2f7+K9xrnVMZYDlvNVmIJ26YKcb?=
 =?us-ascii?Q?md3VSUuhrHGpqMkb+/NVi+1bdK8gcsTfzNshpoFePwGXc372r7FaI2/6EYiQ?=
 =?us-ascii?Q?zdjNlJNA2f2NhC1s/B3/38zcMQH3vh2DFcqaXUSldJSpEabr6Do6G4zRlqGq?=
 =?us-ascii?Q?696CTWn2vfVlzenKs8F4Oz1BuDrVSs8OsmibOUffHAi7n2hfXkJRNfKf+ha/?=
 =?us-ascii?Q?NfOnBGRMQ8hzuSCVN+RoYNmstArlgffknFfVMg5ElXWU5ZoGy+NU/QsQRsP1?=
 =?us-ascii?Q?8572ZdZGJpOKN0NaM9nHZIWYaZyJlp1EpePFCrDsmdoCyqUW8x5cdVXEr22C?=
 =?us-ascii?Q?TYkDhZfYEZ2+6P46eoLQihjaK4/5cQMtZUTiX45jh2Ve391IJOb1nuUYfyNk?=
 =?us-ascii?Q?WrlPiO2FUiihJ+wWM1wvLKydejOIQ87GX8YyzRmdAbFXsIo2kVoXRbhaA+0F?=
 =?us-ascii?Q?owYTv8W6Mowz5dqi9fjoW7Vcdu967p69gWJbP8t6GP68LzVN/G3gVJmqXSo1?=
 =?us-ascii?Q?/c6RUZXOArFjp17vsdp2PBG1VS2hPH/Oz4o8sjn2WDYMPM7zZpsb7IECUw08?=
 =?us-ascii?Q?fvmTN4eHCan0BAoBHVdNQwrsm3cok/kW1Y8TXw9AAfy6yqx86yKy6JFoUVeF?=
 =?us-ascii?Q?9QnEAcoIMMz9EkMdavnEYZmCLVA7fF4hj3jkVGPI1xyGHJuHAMoknPLQBF8I?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?v1ND4KBtvlzSZ51U/xkwA5fZftksgqT9xVRcT8SwSjvqInAgBf1Pe4km4FmC?=
 =?us-ascii?Q?Xop87UcxhipLoZ++fkiMom8amFwofnx7xGTrUi6CKlGiWqVxeEItTO54JGm1?=
 =?us-ascii?Q?PxI2s4Y+VnTNLF5JcRZGr/eB6EjIy5He/GHt3GylN8KfmUeEyYYxmTtVB04/?=
 =?us-ascii?Q?VLOJ/Pl3iqw7U6HiDIpvN+ixc4A1ep9aTJ9lh6rl/c0W8pBDZg+e0xMtHzLm?=
 =?us-ascii?Q?46H6ENkxc1tImHLU8kfwnrtyg2gSzehepL0jM4Vln1KfX+dlQqq6uAO3JBsU?=
 =?us-ascii?Q?am4UF77Lbm5ZIsCW/tjwYmuJ0UGPhJ7dp0hXxaZ0DRpfcaeUJBj9AaX4pcxF?=
 =?us-ascii?Q?o7gA26eBwDYWKvCbJ1ZKXldyDttiJ4TrNJfnVIIOqNd4p5i+Y0xcmCXmDDGz?=
 =?us-ascii?Q?mgJuaDYmAxP7QLsmtIhyR0HRP+ozLL5shs25NPTbpr/T1N5bFfxkCQtj0Hcj?=
 =?us-ascii?Q?vX6pshf525FfNv0Ju4kmTjHUbaeyVpFNW08HNOfj4kiYaX9rbmTGDO2pXklR?=
 =?us-ascii?Q?O4Oe9uZhoifgw9OzJHE5di3IqwpF1UBEkuyAWJiNRKOcPDKpqK4UqzRQFzDS?=
 =?us-ascii?Q?jEX1WA/5P3JgC96DE8ETqBJYJcH7GdFH1Es1yj58s27alA3k68LNCLg/Iudm?=
 =?us-ascii?Q?PiSGzRbINozRulFF6VM9FMNea2rhuflu5325itTirrKba0DbNhAzUkVkjbD1?=
 =?us-ascii?Q?8rjKSHVKISj7aQ0+hH48Z3+jeETObOkTBollRmotR/Wh1cBQ+c/qyg7REYhB?=
 =?us-ascii?Q?W/G6dSikgaWtGTKWTa0AOWcoqjumTwrTuQ3IZDUN6kM2+TYlqHptq6s7VqxK?=
 =?us-ascii?Q?fHo2dC8He0gNPqW8BcgYdoM0mzeT9NyUdjQMhBHM30FxJjMNoUwp4xWtdnRa?=
 =?us-ascii?Q?VE4OTcznCJwINMS8mKwQEPWS+56bP61WAitmHruO2H53uln8JRqcJ8YqR2PM?=
 =?us-ascii?Q?CZpHgtFzsgjJuacpb1XkKyoUlwF0G5U1WDb222pz5fezlf0dzD7gwwav3FOJ?=
 =?us-ascii?Q?52i2zEQ8m/rRQUiVAWR4V0I82EiGePrMin+uRGKUWbs5vilHpgm/hgsIQrYD?=
 =?us-ascii?Q?ulMLanJgwSbETgIzyCBLC/wGqbUal+so0TFqw+SNRTQ1pzn/hh9Pf1N5GkV2?=
 =?us-ascii?Q?ojSUKz8zxpDBBCADsUbh3t7JRtvIOd3sJA2oOl3vJdUBrtHoGnmvMOs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af468a4c-0291-488a-ca53-08db353702b7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 18:04:19.1897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oLhnZ9Ma19EifrlUlbQE6EEH9IfqoENpstLctFwJmGCltawrrrxtNZbKqF4uLhRS9/RU+9PYf4/LuQ6m+vrlSHbyjtO2Dm4IN0taGjvvr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4365
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_09,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040165
X-Proofpoint-GUID: BhcuhZpDRW-Lo6E0XWFtvEbRaF4s8mUu
X-Proofpoint-ORIG-GUID: BhcuhZpDRW-Lo6E0XWFtvEbRaF4s8mUu
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is dependent upon the patch 'crash: change
crash_prepare_elf64_headers() to for_each_possible_cpu()'. With that
patch, crash_prepare_elf64_headers() writes out an ELF CPU PT_NOTE
for all possible CPUs, thus further CPU changes to the elfcorehdr
are not needed.

This change works for kexec_file_load() and kexec_load() syscalls.
For kexec_file_load(), crash_prepare_elf64_headers() is utilized
directly and thus all ELF CPU PT_NOTEs are in the elfcorehdr already.
This is the kimage->file_mode term.
For kexec_load() syscall, one CPU or memory change will cause the
elfcorehdr to be updated via crash_prepare_elf64_headers() and at
that point all ELF CPU PT_NOTEs are in the elfcorehdr. This is the
kimage->elfcorehdr_updated term.

This code is intentionally *NOT* hoisted into
crash_handle_hotplug_event() as it would prevent the arch-specific
handler from running for CPU changes. This would break PPC, for
example, which needs to update other information besides the
elfcorehdr, on CPU changes.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/x86/kernel/crash.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 0c9d496cf7ce..ead602636f3e 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -456,6 +456,16 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
 	unsigned long mem, memsz;
 	unsigned long elfsz = 0;
 
+	/* As crash_prepare_elf64_headers() has already described all
+	 * possible CPUs, there is no need to update the elfcorehdr
+	 * for additional CPU changes. This works for both kexec_load()
+	 * and kexec_file_load() syscalls.
+	 */
+	if ((image->file_mode || image->elfcorehdr_updated) &&
+		((image->hp_action == KEXEC_CRASH_HP_ADD_CPU) ||
+		(image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)))
+		return;
+
 	/*
 	 * Create the new elfcorehdr reflecting the changes to CPU and/or
 	 * memory resources.
-- 
2.31.1

