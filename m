Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8096F6168
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 00:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjECWna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 18:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjECWnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 18:43:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E3893FA
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 15:42:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HomTN017459;
        Wed, 3 May 2023 22:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=OOrvwsmep8wFKht21oGhx9r49suR81kX+IFpmgNQfBs=;
 b=2H3hFDKYCzd6Q2rhlxL89tCNXScXt37cSqZuxmvw6H5nsv/4Rsw2/RtI5mOpDvd8+71G
 uMJcWy3HqRsrGiykah5tnEcJrdzYDmV1hbXdxZPJY5cn6srpw7jfMGAkw1a7N7tRqjaq
 /Y0EUCSxX5Sv+lvF65UT4Rw5kXRN9mbxeWDewr0OF832pfxrIAUDYr9cHc8l2EFS2M/3
 Tw5WEuOYhZf4EmtTGae91gbHInBLu3h4P0OAun5a52BGJ4RfrtobGwOIXDC8N/KE9IOm
 cs3wu5DWyP7FTILph5lIQo+dVjZmUryTZPKJNP1sZKCT5Kh7Hxn4pKhyXbtDspK7ERqR 5g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4ardvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 22:42:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343Ln8XS020789;
        Wed, 3 May 2023 22:42:14 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7qt2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 22:42:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsFeCZqos2ADs1QYkeYFaML/dJyFeyGY6MnqroEUobZOXZUDz2Y5qe85x40Tzzb+QOS9chdUzeTSS5csHYErubVq94112xg3bzFqjHqbhAekNKFVohLbTguxTk6ko2G74Snr8rlpqJCNUgvFF2tPm3fmp1ObdkpMEFYU2EaXhqwunNCbdXrI8u6YDvRbFhYKltpw3oXskFBFrY+/CcZNnFUbsI/slsQQlJiFSjLJJ4ncGC4uB8SUWhkn4EzS0ovlBbFVSazEsPGqKZQDoupqhQ8G5t7h6wRnycgzzURN48J2N53MRvYlyyCT3kpBsc8uGegPEdEVBC05SmYQmluLjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOrvwsmep8wFKht21oGhx9r49suR81kX+IFpmgNQfBs=;
 b=ZdajVhLHDX3W2HdIivAfQlEX49q+FgSBHKXfwjqXU4+eYmebJ1PlQ0EEJh2R+bhQgQo250d4c+KnX5yCF4Iqlo0wknr2IW37SdfXiVsfboIA894AheUoHbacA5be2BVVuSMMLFNSD7al9BYQS22edSvVrvM1KSCF8BQj+R+FTfDnQjs3zEhBdGHXZQkkQZaUGWpOOIkJMeICS2M/Ns++Vw/lcfVr2H6XNdh6+gCKmN1XJmf1e1Gg3SxPfpemK/MfbuUlYTCIZ09EtQ8ztdDiIeYRMy+OwHR3NDrzECuckIO6hXWXI47iE56JAORLtf/4Fb9QGbi5AHhja/ECmnN5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOrvwsmep8wFKht21oGhx9r49suR81kX+IFpmgNQfBs=;
 b=dAKZVymxeQqgL2vXAOMSNWcZ7BO/ZM9l89itxzTrSBmj/0l2/HHQ4ZkBmqKjOGwT3Ss+OybnVXcgzCoW2GbvWsohIPTEDjvWMYCBhPF03S/xcB0ZFKmXvQVvWdGhB+ZvSCv+EcGyG8mVVYrX47efDwqOvwC+bcr8lkRVJr4/20k=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6846.namprd10.prod.outlook.com (2603:10b6:8:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 22:42:08 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 22:42:08 +0000
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
Subject: [PATCH v22 6/8] crash: hotplug support for kexec_load()
Date:   Wed,  3 May 2023 18:41:43 -0400
Message-Id: <20230503224145.7405-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503224145.7405-1-eric.devolder@oracle.com>
References: <20230503224145.7405-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0056.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::8) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a039720-3c7a-4eb1-33f9-08db4c27a07e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UD69SbbahIZWcG9C62lgu/8Nz16Bc6IcrCDZv5+eG/QmROPbSQsVNh95LvcjFucDJb2CXK2la7xxt68nP2vuM6yMkxBj+49oyEx2EFAhJ2s1dTcKPcB6uKi2pYbbJE1vL5PEaSMgFToExw1rEumFEFrx84Jlpj0Omd8zCgwx8wiC5ubE3I307C2GFzwD2lt/8C9DweTm5oLtxi1vcuSfyzjqiEMWQa+nokVuAlWeeNUG13/vQ1ahwP+dkg3IqFzAOalCQBhzTkgBFURFMUUiqycZjutdhLr/m7y0UzJa1ubmCdZBbOSULujmd/cIk2f1uU6WrMli8lqwwdGlFaz+ZPSd9vXbW1oJY1fFKbdm6r1gnYC7UVoNQ++e8pwbbE58TE35LV9xqy1IB7xQ8RjZwR4KkJrnMIiMuLMwEosOsDB02JrZzfm9Ue8o0lfeR+VVBar3YCmVn+wsdicmuI+YQ4KWU4/NcguGhsX4rNdIMZif6ZcxfEO74SgIoYUFip534zB1DB04yXLLNE5YSaRCk4r/WEg1toSNwfulaOcxCj40L6sAiGl/62FEtGklyrzi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(30864003)(1076003)(6512007)(316002)(6506007)(26005)(186003)(4326008)(66556008)(66476007)(66946007)(86362001)(5660300002)(478600001)(7416002)(107886003)(36756003)(6486002)(6666004)(38100700002)(8936002)(8676002)(83380400001)(2616005)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w0Gb2IIaaIosCRJzERu9Lm5AmE3md6o+HDQ+kYGb5aTJHGWiHzpudrQJX5NG?=
 =?us-ascii?Q?Zu1MAEI3nAetj/1emozKSFCZLSEmUfIYBSdMJH5fnAlifiDWoXKXLYupfh1w?=
 =?us-ascii?Q?4hmI7WDJdssrs1wSVxGg3WxLUVEj63TsKK1yok1uoIeCPxxWPuutcQQS9Cjs?=
 =?us-ascii?Q?+zo9atvhkBJwg9yZ6u2etuEgLEeL64oIiBRZ1uQwtvjIHkgmVPV2+IiWbAVY?=
 =?us-ascii?Q?+/ntDY1qIWyhfuZXkVgrRytylxbO1REA60oT2t47hxVhw1sTEkvJ6/8oOz6p?=
 =?us-ascii?Q?18sO6GlZHqURQ4MkrCLxKi3oVwQUpxnlsTe4TsWQxFk3Us2rOhSYxSelQ8ZH?=
 =?us-ascii?Q?EGBHVF7zdvU1uagEb0VJBkDFCjtqVW6ETRlXbiX8497zu5zK7jvVO7PPog3q?=
 =?us-ascii?Q?Q1rDLQqG5G7YYhgW61I6srFOL9IqhCkcrsaYfYYGXzl3zyAFVDRsWn1SKvml?=
 =?us-ascii?Q?YL+OEvS2wyqQU3vHcv/ZlE8mDAoroy3uhG/4kQNwULrjYhwJS+N3BxV1nhYK?=
 =?us-ascii?Q?MMmmVZ+nzzfMi2ookfDi8KySgR9FVqS31Ho91fKIUW8dFDq1LPIqgaMdMPRT?=
 =?us-ascii?Q?PJ3c1t4Bw3OMZcRQTiu1IgVClODmk4UfNQoNOORH9QZMJjFjIjpermEZHubm?=
 =?us-ascii?Q?RaSv9iez16LfF7DRa81CNwBpnGvazYY3naWE9A+ZhD5MtgNgKCKqGvSW1rui?=
 =?us-ascii?Q?oxFGmA0IS5+kHsBHoOKr8R51NJmzCDT6XQ7j44bsakYb+NXYjRMx2YKxzEFh?=
 =?us-ascii?Q?/yT70rCu2X3rCkIBKTFlY7oSWCLs3IzemHVd0L4Bnh+blTXnrwYR1y/LeAii?=
 =?us-ascii?Q?pXjLmWxYaXXBpc1sC+4ZmoUTXZjYtF+B1BI6cUCTcF4rwPvf+iVPCSsaPVk/?=
 =?us-ascii?Q?MIw8gdOm/+SCmylOzQgUT+lyoggPzT2VO3MPtcJgFRQOtq/wBZ9YmGrukXma?=
 =?us-ascii?Q?Je9YnT6tSngJKBbVfDtD2SVdyMazoRqsIzVAnrdoasnkm991Swg/Y3tBQVX7?=
 =?us-ascii?Q?OJhiaFf2c5adi+qfLgodvuHtxH26cih4FtOAo8TwU2wtLvHlBw0kRSw0u2qe?=
 =?us-ascii?Q?SrTQ42xKQfHfWN+KISn1Z56RLeZ7+N2/xyVCvfFxVSGl+SbZqMSb6xTQLJ7b?=
 =?us-ascii?Q?FWauU/C0+jqMOQMKwefSUIH5k4YsfGdW/fP1I698fgoZSs2LZt5HKM0VooT6?=
 =?us-ascii?Q?TsKg7R3qcC0dxyi/C4rg0VWQ7aMhiu298sbzSzTwxTCetOxRZxiNzKCE5Zzj?=
 =?us-ascii?Q?UDvpCmkttgIw4Jp7xSGQxVGN6RMnlO624sBx5vauzJ+KPsrKQMLhO7sMuXVK?=
 =?us-ascii?Q?jHjgnrfObF7v1Uab9cjATqfLlZJG1UENDPOYnf55s3pIR/1FsabA2fppRvee?=
 =?us-ascii?Q?sXFEvpS1MhNev/tstaSz+pKEhiGoPZWz3h2GASshdfg5MNx5EZJJy04RnmDz?=
 =?us-ascii?Q?sZqlt2El7AVIu84EFYxJNZswploTcz4Y0N2B2rgQp0cvSBhRphqi4awXNCTu?=
 =?us-ascii?Q?QuJtKJGyx7echC2fTkawZRWPBnhgPsEol3kFHh2ZkgGtdeNiVG7xr6XeSRBo?=
 =?us-ascii?Q?O9ugbdTm7rtYZQXdh7SxoGnEoqh0MAG1eDo21Y9IK0Fq5/Z7paeENhxe29Qn?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?hWgEztZHh3IgtWFoeK3YZnBo/7yCnmCt4OyF1tfcDpQJ4LseM/C98ayHJu2y?=
 =?us-ascii?Q?HzcndV/ML2rbvHZuZpLhl+qryLUuCwbpU3V5qgLaThINSVWTE31jMGcpRLMk?=
 =?us-ascii?Q?QGxGy/yxmP5LBP3rkRmvTqh25Gynfbv9Ihhb3DT92XrltJ0iioFheukNR+eN?=
 =?us-ascii?Q?p+ZrMPbiVdr2MBAAQ7sJ3EDqUlqWRTS8Ss/0dnoGPWYbaaJOKEEI+1QDZ40x?=
 =?us-ascii?Q?KsXk15EGJqlQy+wFrjBcr5SS4Rox0A0tS7TrjmJNpZMU4I0nV8UFgRJVALd5?=
 =?us-ascii?Q?gPgurLlYKD2vsvXDdLtDc9+f/uPhcE3JBlOH9XV7NQVQY0aBaxb6dwwu+Jic?=
 =?us-ascii?Q?4it7STnJSszJZyytRSohnW1+IAHYmVZTfDhys2a5R5H1pkWH0Wzv58vqN6ve?=
 =?us-ascii?Q?YGRECHDT6z2W+feK4x4UfZ7JyWEzUqPi3gZqtSC9qOvwTacWAq/hiVM0MIvk?=
 =?us-ascii?Q?QVUBm0lKBeIZk4nyexSICzEDkeH+13483zMEAyb70nZriC50cfVKaUqK3ADI?=
 =?us-ascii?Q?rqlY7KCiDaJ8yL8J4W6QkEO/Taf0l8WDESOIa5IfXQ0ft6d1TkY9BiDMT9In?=
 =?us-ascii?Q?0diusg4bVNod+1JcjlYq7RlB2xPqkYEebsW0oR2MEoOTQMJz1efT7b1RXrv4?=
 =?us-ascii?Q?8l9arDfY8CWsMwkGA7M5OVTLZBAI0CP9B2Bu5Ii4KhiBqLjCAEbl6muIkYGI?=
 =?us-ascii?Q?pvzncH6/62SlnhiX8xvfoXavS/36d6OQIe3x73Id1Huh9T22l3DS1Sod5Bg0?=
 =?us-ascii?Q?E2XxEkJf010OYIYbxvCU8HZjCJGPNLYSiQLJjsKs9jKt4vWc3B0cm5JdQ2mk?=
 =?us-ascii?Q?i5FaM1BnxnspfBgODDmD0hopr973A0T5xNBS3TdwNSppLIzl2YVVGc5KdDSb?=
 =?us-ascii?Q?QoW8N4csO63moZ8s5ZFVTECpCu+irbIF7qjsdRfTJK88zobYyQWfTuvZ3vWn?=
 =?us-ascii?Q?W1F2DIGrWlcLXHGwwDK9+LiT5TflvT25EhnCfKYRwr9GfMxRvcXmc0L1Mstv?=
 =?us-ascii?Q?iyEZdp2M37YZir5DDtek6EbDY9gaOnF2a2hrirzlz1ArNk8eJYkd5w/3/qO2?=
 =?us-ascii?Q?fVEV6l2plmrwhjv1+eFsWhM1ORus+V/O5TdCuBGmtAs4NZ2J2T1nA3aY0DDq?=
 =?us-ascii?Q?1ww4c15otXGaKpzyawWBrxp5deHzK3h5TW1HfyY1JNfCCZoXfQT4FEA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a039720-3c7a-4eb1-33f9-08db4c27a07e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 22:42:08.5788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxQnOjNLdIuBS+17SKLbn1UhNQdt+ES4uPoVRWgs4oQTzCB5CZ4hmmWA5eoilLHfgzrxMEzIo1JHA2fCtIsEPvoqzlA49pyBkuekpPhufV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030195
X-Proofpoint-GUID: 7nMNUGutix53MXBxLx7JbdfFRvTuQuSy
X-Proofpoint-ORIG-GUID: 7nMNUGutix53MXBxLx7JbdfFRvTuQuSy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hotplug support for kexec_load() requires coordination with
userspace, and therefore a little extra help from the kernel to
facilitate the coordination.

In the absence of the solution contained within this particular
patch, if a kdump capture kernel is loaded via kexec_load() syscall,
then the crash hotplug logic would find the segment containing the
elfcorehdr, and upon a hotplug event, rewrite the elfcorehdr. While
generally speaking that is the desired behavior and outcome, a
problem arises from the fact that if the kdump image includes a
purgatory that performs a digest checksum, then that check would
fail (because the elfcorehdr was changed), and the capture kernel
would fail to boot and no kdump occur.

Therefore, what is needed is for the userspace kexec-tools to
indicate to the kernel whether or not the supplied kdump image/
elfcorehdr can be modified (because the kexec-tools excludes the
elfcorehdr from the digest, and sizes the elfcorehdr memory buffer
appropriately).

To solve these problems, this patch introduces:
 - a new kexec flag KEXEC_UPATE_ELFCOREHDR to indicate that it is
   safe for the kernel to modify the elfcorehdr (because kexec-tools
   has excluded the elfcorehdr from the digest).
 - the /sys/kernel/crash_elfcorehdr_size node to communicate to
   kexec-tools what the preferred size of the elfcorehdr memory buffer
   should be in order to accommodate hotplug changes.
 - The sysfs crash_hotplug nodes (ie.
   /sys/devices/system/[cpu|memory]/crash_hotplug) are now dynamic in
   that they examine kexec_file_load() vs kexec_load(), and when
   kexec_load(), whether or not KEXEC_UPDATE_ELFCOREHDR is in effect.
   This is critical so that the udev rule processing of crash_hotplug
   indicates correctly (ie. the userspace unload-then-load of the
   kdump of the kdump image can be skipped, or not).

With this patch in place, I believe the following statements to be true
(with local testing to verify):

 - For systems which have these kernel changes in place, but not the
   corresponding changes to the crash hot plug udev rules and
   kexec-tools, (ie "older" systems) those systems will continue to
   unload-then-load the kdump image, as has always been done. The
   kexec-tools will not set KEXEC_UPDATE_ELFCOREHDR.
 - For systems which have these kernel changes in place and the proposed
   udev rule changes in place, but not the kexec-tools changes in place:
    - the use of kexec_load() will not set KEXEC_UPDATE_ELFCOREHDR and
      so the unload-then-reload of kdump image will occur (the sysfs
      crash_hotplug nodes will show 0).
    - the use of kexec_file_load() will permit sysfs crash_hotplug nodes
      to show 1, and the kernel will modify the elfcorehdr directly. And
      with the udev changes in place, the unload-then-load will not occur!
 - For systems which have these kernel changes as well as the udev and
   kexec-tools changes in place, then the user/admin has full authority
   over the enablement and support of crash hotplug support, whether via
   kexec_file_load() or kexec_load().

Said differently, as kexec_load() was/is widely in use, these changes
permit it to continue to be used as-is (retaining the current unload-then-
reload behavior) until such time as the udev and kexec-tools changes can
be rolled out as well.

I've intentionally kept the changes related to userspace coordination
for kexec_load() separate as this need was identified late; the
rest of this series has been generally reviewed and accepted. Once
this support has been vetted, I can refactor if needed.

Suggested-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/include/asm/kexec.h | 11 +++++++----
 arch/x86/kernel/crash.c      | 27 +++++++++++++++++++++++++++
 include/linux/kexec.h        | 14 ++++++++++++--
 include/uapi/linux/kexec.h   |  1 +
 kernel/crash_core.c          | 31 +++++++++++++++++++++++++++++++
 kernel/kexec.c               |  3 +++
 kernel/ksysfs.c              | 15 +++++++++++++++
 7 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 9143100ea3ea..3be6a98751f0 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -214,14 +214,17 @@ void arch_crash_handle_hotplug_event(struct kimage *image);
 #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
 
 #ifdef CONFIG_HOTPLUG_CPU
-static inline int crash_hotplug_cpu_support(void) { return 1; }
-#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+int arch_crash_hotplug_cpu_support(void);
+#define crash_hotplug_cpu_support arch_crash_hotplug_cpu_support
 #endif
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-static inline int crash_hotplug_memory_support(void) { return 1; }
-#define crash_hotplug_memory_support crash_hotplug_memory_support
+int arch_crash_hotplug_memory_support(void);
+#define crash_hotplug_memory_support arch_crash_hotplug_memory_support
 #endif
+
+unsigned int arch_crash_get_elfcorehdr_size(void);
+#define crash_get_elfcorehdr_size arch_crash_get_elfcorehdr_size
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 0c9d496cf7ce..8064e65de6c0 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -442,6 +442,33 @@ int crash_load_segments(struct kimage *image)
 #undef pr_fmt
 #define pr_fmt(fmt) "crash hp: " fmt
 
+/* These functions provide the value for the sysfs crash_hotplug nodes */
+#ifdef CONFIG_HOTPLUG_CPU
+int arch_crash_hotplug_cpu_support(void)
+{
+	return crash_check_update_elfcorehdr();
+}
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+int arch_crash_hotplug_memory_support(void)
+{
+	return crash_check_update_elfcorehdr();
+}
+#endif
+
+unsigned int arch_crash_get_elfcorehdr_size(void)
+{
+	unsigned int sz;
+
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		sz = 2 + CONFIG_NR_CPUS_DEFAULT + CRASH_MAX_MEMORY_RANGES;
+	else
+		sz += 2 + CONFIG_NR_CPUS_DEFAULT;
+	sz *= sizeof(Elf64_Phdr);
+	return sz;
+}
+
 /**
  * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
  * @image: the active struct kimage
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 6a8a724ac638..050e20066cdb 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -335,6 +335,10 @@ struct kimage {
 	unsigned int preserve_context : 1;
 	/* If set, we are using file mode kexec syscall */
 	unsigned int file_mode:1;
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* If set, allow changes to elfcorehdr of kexec_load'd image */
+	unsigned int update_elfcorehdr:1;
+#endif
 
 #ifdef ARCH_HAS_KIMAGE_ARCH
 	struct kimage_arch arch;
@@ -411,9 +415,9 @@ bool kexec_load_permitted(int kexec_image_type);
 
 /* List of defined/legal kexec flags */
 #ifndef CONFIG_KEXEC_JUMP
-#define KEXEC_FLAGS    KEXEC_ON_CRASH
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR)
 #else
-#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR)
 #endif
 
 /* List of defined/legal kexec file flags */
@@ -501,6 +505,8 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
 #endif
 
+int crash_check_update_elfcorehdr(void);
+
 #ifndef crash_hotplug_cpu_support
 static inline int crash_hotplug_cpu_support(void) { return 0; }
 #endif
@@ -509,6 +515,10 @@ static inline int crash_hotplug_cpu_support(void) { return 0; }
 static inline int crash_hotplug_memory_support(void) { return 0; }
 #endif
 
+#ifndef crash_get_elfcorehdr_size
+static inline crash_get_elfcorehdr_size(void) { return 0; }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 981016e05cfa..01766dd839b0 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -12,6 +12,7 @@
 /* kexec flags for different usage scenarios */
 #define KEXEC_ON_CRASH		0x00000001
 #define KEXEC_PRESERVE_CONTEXT	0x00000002
+#define KEXEC_UPDATE_ELFCOREHDR	0x00000004
 #define KEXEC_ARCH_MASK		0xffff0000
 
 /*
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index ef6e91daad56..e05bfdb7eaed 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -704,6 +704,33 @@ subsys_initcall(crash_save_vmcoreinfo_init);
 #ifdef CONFIG_CRASH_HOTPLUG
 #undef pr_fmt
 #define pr_fmt(fmt) "crash hp: " fmt
+
+/*
+ * This routine utilized when the crash_hotplug sysfs node is read.
+ * It reflects the kernel's ability/permission to update the crash
+ * elfcorehdr directly.
+ */
+int crash_check_update_elfcorehdr(void)
+{
+	int rc = 0;
+
+	/* Obtain lock while reading crash information */
+	if (!kexec_trylock()) {
+		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		return 0;
+	}
+	if (kexec_crash_image) {
+		if (kexec_crash_image->file_mode)
+			rc = 1;
+		else
+			rc = kexec_crash_image->update_elfcorehdr;
+	}
+	/* Release lock now that update complete */
+	kexec_unlock();
+
+	return rc;
+}
+
 /*
  * To accurately reflect hot un/plug changes of cpu and memory resources
  * (including onling and offlining of those resources), the elfcorehdr
@@ -734,6 +761,10 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 
 	image = kexec_crash_image;
 
+	/* Check that updating elfcorehdr is permitted */
+	if (!(image->file_mode || image->update_elfcorehdr))
+		goto out;
+
 	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
 		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
 		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 92d301f98776..60de64bd14b9 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -129,6 +129,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (flags & KEXEC_PRESERVE_CONTEXT)
 		image->preserve_context = 1;
 
+	if (flags & KEXEC_UPDATE_ELFCOREHDR)
+		image->update_elfcorehdr = 1;
+
 	ret = machine_kexec_prepare(image);
 	if (ret)
 		goto out;
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index aad7a3bfd846..1d4bc493b2f4 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -165,6 +165,18 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	unsigned int sz = crash_get_elfcorehdr_size();
+
+	return sysfs_emit(buf, "%u\n", sz);
+}
+KERNEL_ATTR_RO(crash_elfcorehdr_size);
+
+#endif
+
 #endif /* CONFIG_CRASH_CORE */
 
 /* whether file capabilities are enabled */
@@ -255,6 +267,9 @@ static struct attribute * kernel_attrs[] = {
 #endif
 #ifdef CONFIG_CRASH_CORE
 	&vmcoreinfo_attr.attr,
+#ifdef CONFIG_CRASH_HOTPLUG
+	&crash_elfcorehdr_size_attr.attr,
+#endif
 #endif
 #ifndef CONFIG_TINY_RCU
 	&rcu_expedited_attr.attr,
-- 
2.31.1

