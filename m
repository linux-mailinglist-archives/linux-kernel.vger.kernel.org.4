Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDE3742D88
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjF2TYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjF2TW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:22:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211F73AB2;
        Thu, 29 Jun 2023 12:22:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJ3rq5002966;
        Thu, 29 Jun 2023 19:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=FLMJb8Pu7ToQ3NPu5Kqwnmr09fjMaiEQojRFTeT7OTc=;
 b=P6zb/H0JHr2i+GrRmjElWvCh3mRskfGw0o0sW9udLukyymVMMtwNw36p/a+dcMs+L402
 ndw1TyrpOwZu5p+M++LWTHZcxoPZQvr0xmPubc2yEjEejSKKQIaEUkmnf7yGOS1rfu1H
 gQ3kESGCO2UmJ/VYqNr7MYB+V1MbU6120we8UgHa937ITjl2Z+m+IuSWpgy7XZo5NY+9
 pvx4jYfmYOyb5WvL1Jb4JLFt4YnCW0+0ue8CseCKa0uhKc05ld4lcSZiKFAorTWqL/H3
 H/UOzMs3imV0NEHjPU5DY5I4ASWCtFQcxrvV0SN4evuhO5p5ETiLSgqBLXANurdL73/k 9w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40ebwf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35THqW5c013072;
        Thu, 29 Jun 2023 19:21:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx82gf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTiI/s4Q5gFHLrP8HfO8GBNNQUitvhCZcd872oDrCZZd1qO/yVc/RyGqr6MJ9696n3Mzljusj1w8G8VJlUAhy1ipQdZ7Ao42I6KbaaD6ke9GDSLxZ/uox/xDrq/g4jkwbtJ5SltOauEL41NC6tpo4eWS0BsGtijg+SOrUdxUa9GUzpGL2T5m9Fh8Jiroe2XZTjj2JHT+njJRWb4O5owm80MwjV+MNGT5rufHHod0E7zYCqNA2sMFqbq4Ddgv6aH2p3cF8+JXyC+Gx+D3vKG9UHXzBovTiW7x7h0pmdSGV4Z0yOtNnCCx+ie2Ga/Y4HuJncXKLMJNY7jHtkG8AHchug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLMJb8Pu7ToQ3NPu5Kqwnmr09fjMaiEQojRFTeT7OTc=;
 b=fPDyc7LGl2JNXb8KJGiahUJix9flG2UXHbYYsyUfD86BoNDRmkG22oYDO7pQPDoWxj9bzf982zB/NdGG2huwBliVO/v689qNUT0NwBdJTC7uLeF5mOtmgGlrHpYEqihhjGuUwBwIXhkLqle7GKMB9nAA0svqnuihu4SaLvNhNM6yKb7lW6FbPk2aZ7I1lR8miO2PtWVpXZ0V6MBeDSgySWnZYIlUlvLJp46vaavr/yE/05u7hVuitSc2YQSYvjL7HqGEy4OZ2BOyFsGLIrDvRI6pH+xTaLMX5kDkH0DGj7hDEeYemSHkfBvhry9Ytxy1RZ8Xtl5sZkIBzhYWMsIIwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLMJb8Pu7ToQ3NPu5Kqwnmr09fjMaiEQojRFTeT7OTc=;
 b=KpApZ5+6nY3fj1drAJ6ANQ99sfLJfaHrwKHMG/WrjYSAHhC4uT8kHW8UcNjiUhl9mOtEETqk2fnBq/h8p4CH7RIz+MRS5O90XlNvcx7ftVM+VnzuA+87ti4ooVN9ZpkIwQvTxlOGiy+jAvR50/GCRFWgA8aTh+NmJglL5g5CBqs=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA1PR10MB7200.namprd10.prod.outlook.com (2603:10b6:208:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 29 Jun
 2023 19:21:26 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 19:21:26 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v25 00/10] crash: Kernel handling of CPU and memory hot un/plug
Date:   Thu, 29 Jun 2023 15:21:09 -0400
Message-Id: <20230629192119.6613-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:a03:180::36) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|IA1PR10MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e4e84c-2b99-47a2-89df-08db78d6089f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GiZt1WEosTVsvTKBrJd42W8NtSkACW43PtEL+bCpKtz0A8ruwVlU9yEAk1ifdcirla2AGy14GnlwPxImauoTVJ+NWeLhdnNKseWPjO/iDBZZz8CrRqByXw4Ge5sHnkrQ0GaIrf8OD9j2Ae+LOF3rHBtSze7i8x/ZdoHVvvtI97+6UPEWGChQVp/9o35zvlDgvEw/LJRBJWyQAazlPqFnyFwZxuQzT50N0dOXKikK0Wt9fDy70aHRb7VJDBsFClM7umrufeIJFuvPcdQOQRvG/ZLoyMcBm5GzTaPA4wYabs45j01zHwykmdEgPkZIojlRhjihDrKrjoTVI9pTjRVZbnShLKamer+/bhylW2hy9e46yymi9bEKwTI6P4sVTpcSgY4c08Lwtqpurxa67oelwjpHUSjhxje5C3LKE7jVABu/a39+81MAxUyhb1yXSLUC0M09TUBn/PmHWOJIVRRo1+CgI1m8VYwYRl3I/ZwLXy0xQr34m8gL89fVBJoMsvYRsvimaDpC+XOieGCie6q5wnH30uqCHaoOJZxvajukA+WzlLSdmhbXVKRz7pJK9MXdr4E546DwYPXhqNhkJQgK1xD5KgfvHjiK8HMwYRr9d6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(66899021)(83380400001)(316002)(966005)(6666004)(8676002)(4326008)(8936002)(6486002)(41300700001)(36756003)(86362001)(38100700002)(921005)(2616005)(7416002)(7406005)(66556008)(6512007)(5660300002)(66946007)(66476007)(478600001)(2906002)(186003)(26005)(1076003)(107886003)(30864003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aBWNh8mkPKdIv++OVmmAvjrF4zLFwgXV/oslOJ0xjfBnFbobhPlfi1sDjmAc?=
 =?us-ascii?Q?WuZCaAGloE8i6Ryt4GwfaYdQ4pJIr4vP8Qvo+yQS+0schyPisHDnU/G9tflC?=
 =?us-ascii?Q?UpDR3KCGcEFT2K5XtuGEuUSHvfI8FlQcDmeblD2KxuqBNje7kOwbxWgLhKkf?=
 =?us-ascii?Q?rvdFaB8hyarJ7Z0D3rj3iE6+10NZs1do0UdvkVAEoudO7GAR3GQkbAyGkwFt?=
 =?us-ascii?Q?GITTTjxRD0LDtEOugGsWM1mOTT0Lfg+xeb1t1jBopa/toUNKq0wzttbTYrck?=
 =?us-ascii?Q?nY8x718dyxeQrBzJ9j4iXsdpDX7KUOoZhKrh0ECOeLrDyUpJNkngSQtqBwUr?=
 =?us-ascii?Q?w3vTV+IQqquU2UX1U+OsDpZiYdqHPtAxwKKj3bESyo+JmDlYJ/3ZL/qfMAzC?=
 =?us-ascii?Q?vlMq8F/ktDH2UyTwoeG88NiDg+ySFuMpUgc24/Oqo/vnZ2Nio7ZmDCc0uap5?=
 =?us-ascii?Q?zoQvsohm7a0cguABQyL40g0rxScFBAhtOO+YrO7giX69ILLuWv3KcVvK1d9c?=
 =?us-ascii?Q?ChCazTOhBcG7wwiFjIA3Tc6HSVPgsyXq9ip3c9d4Fscl32LnkuU0Euer53Xj?=
 =?us-ascii?Q?W/trYwwDKK1qxeAYI1hF0pGdtTbrVg1POsUxG/BErkgJ8GjzyX/FgzZUiamt?=
 =?us-ascii?Q?nRYgwzj5D45S7DTfwvoxIGbzfCad9oXNYlGMcsQ5ChffWmLga37KXAKgVzoc?=
 =?us-ascii?Q?YxXSbx1eFJbTOTThwmZwBkrSMXXdW2UswO6CsG7+gBfq9DXbly1gGsS+uYxA?=
 =?us-ascii?Q?O66vOgUDTwozbf13b4Zyr5aSmjh4uK+Tkq8+9MCVBZ+axVomf4GQVmTk/TV3?=
 =?us-ascii?Q?lG1j0X1nBZEal6D9200axp2zvvnDz1FSS6nvNKHknjVT5/f5Ks3LfSqt3RAQ?=
 =?us-ascii?Q?Y0Ppvif+0gD+ZZI6YxHTLt4np7M7ZgEKAFQn8VfYAKLABQAP5Rd0cqN4Yltl?=
 =?us-ascii?Q?Z8uFwmf4UlCwx+910tkiimpg0z4QsF5go3mnKvOdo1igPqdJwK0xiJE6HXuH?=
 =?us-ascii?Q?0xXKSjX2MIe/Q4hTYp+4GWeMhGP+GGUbHf42YEv4c7LUMpK4kuBnV1AQWRxq?=
 =?us-ascii?Q?MbM+gJXKYSls9jN4Rrz33V+Bizk5QAvdw1142MxGCDK0y+Dsa+G/iv/vkWOF?=
 =?us-ascii?Q?P4a6d0FMNOE6U8XEYYBoWF+ucryHGmUBgY66BLFWw4WfjDYuv+3vMMINkKCZ?=
 =?us-ascii?Q?JcTbWtQUdDMDe2Ln78m31YnfQCyI3Wuck/cGgYMaJvRHqCAKkSgwi4f/2MVV?=
 =?us-ascii?Q?jxHD2+7RZqJ7wg1KSlU+RQhjeQxslfvVTyZ4xz2OEWCxkSraqiWEHVHJsUD1?=
 =?us-ascii?Q?w1ItWyv1AU1Iawdy6736PfWUnehgjhcd7wiSyTgyhW39NmRMDLHJPYURr3IB?=
 =?us-ascii?Q?aMhvN+O6aEblG6Ca44lWh6jIJU/I5spmL+h8M1mFf9QSM+YOuAuPeIn+/3ZS?=
 =?us-ascii?Q?cdJMuQwhlF5jTP9kut2fCTmArKLxgc1nTu7jOc/Ag9SN/73qu7lOrGnua70K?=
 =?us-ascii?Q?NEYOSL/9bqDTGEisF0GKGfyGXpX+9Dtb7JQtRzpwpAgaYVDwNyla5eAq2EBu?=
 =?us-ascii?Q?RFLMIk66kOZGqSQPfK7eYR6yRycB0ypDEXWvAwBYcJ4wgrckro3mmWtf3qpE?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?P2c0Hk+Wyqqloq9xWsSeoCPTX8NTjmT+Jl9Sv3uCGRhrlg/H4x3JDDDulOeR?=
 =?us-ascii?Q?6hYqTy++dAxWTIgNifRFteJqXa3BWh2c8nnyXZTCNAg+f0sWuAFb106gTCHB?=
 =?us-ascii?Q?k7mkW2xliSbe0/UnHAFgvIR6jsmwfFJkepEFgYj/RaXs34DZa5OaaDEoaEzN?=
 =?us-ascii?Q?cwB1MxURqeav87bN66iYTRjl0evAAQZS8IbRURZ/9hkE72dTW+YVTFDzA/b4?=
 =?us-ascii?Q?jgw9M3cNNbOOjVa3+VcAj55Hu+jxTYN7gjlkMZpl9miz31u9wRhiXNiLV/ZZ?=
 =?us-ascii?Q?hem5bjyEFcI0rnVeh2t4uoFU0KAwim+5cbvLGw6C28onHfticokaiNaZEOB0?=
 =?us-ascii?Q?QBU5RYbg27JBn1zC2BF9rPog5BY0bWfRyXBOPPv2bB1UVKBB6GNvEHZ4tpaj?=
 =?us-ascii?Q?t8ZD79umI1xBg8FhoyygHCJMGfugsUXjmumyIiVhxtGh9iDzmIuTKr10Iedn?=
 =?us-ascii?Q?YoJQ4xe4sG08xJHQTqQNKwWGUkGxSmtCq99qtac28WgobywCNfKcLZxkRZVD?=
 =?us-ascii?Q?kqQHxSBBkl0gUJspgjwotXGTJfNA0noR7sAqUofqhl7PkKxSSfspkr71odpg?=
 =?us-ascii?Q?dsaL+mkry1HgOZ4MeUqP/m80i1PUqKnYAijd2vFZzp9xp2WNIwFhQZ742ehz?=
 =?us-ascii?Q?SsRjN90w8sue5048I4sgSs8XPDzPjhmWrhlbTXOOqOkJ/NsoYnN5udaGR+Mo?=
 =?us-ascii?Q?vRh/ix3ZSOzI4mYLvY805Sn4AbmSXiipKIKCvC/ltmeJFzRhWQnDfhVmMZnQ?=
 =?us-ascii?Q?lTV7iKBL4P2yJIuQraIegso2JzmMnSsiJUdWJM0GXvPq1CPwQ9/y54qdCl9h?=
 =?us-ascii?Q?uaAXEXJ3PlSJqoN6/y8Y1iAuRJfVcHhspRilfpFzk0/hSCvYmEM8rjPf5zfX?=
 =?us-ascii?Q?KtEMdw+kCYYR7jKbC7+d89Rncs82FzmRJX2mZ3QWtKi09UP2f5N+sf0mQhcp?=
 =?us-ascii?Q?CW7WviGYvB6/RdWkedPJOpBmfig9YDVazA9F7a213zqryCDoGf1GUDYTSdJJ?=
 =?us-ascii?Q?AHrS+Z023ZST1WhqWBMqMu1tL3pGXquSBAbRaEn3evKJfxIxPnPQvc4RHeQK?=
 =?us-ascii?Q?VdfZp5AP0gw7cQ6Fr5LSd02X8iHq/MoAD0UEiXY4ryQwl95Iiym/7hHkOk4b?=
 =?us-ascii?Q?SxIFCVbdXfYcmLIh+h1A375etd2yOKJERbfB03FWNWfme8k0yalE2KTwHzU/?=
 =?us-ascii?Q?D/xr4wBr7DSYQ3q84d/nDMmXrud1wGWLLa1OuOywfMF9h/sGgkNlBxMz7BGg?=
 =?us-ascii?Q?U9MFZSglAhMwkqldaLEWLLA1G+YcuyQM0tkcTR2iOHdOJph7Nd0Qxp2Y4u3r?=
 =?us-ascii?Q?W3oH8FU4nDTBtFW320PY97GtNmSvr7JM0uhgmc4ZEzr45HlGClHd4MkDPY4G?=
 =?us-ascii?Q?AdIm8nY7BAjX2xNBsutukiNHEohsEk7XO8NzqAYL1cjmsvJN1hKi9OSHUdqU?=
 =?us-ascii?Q?Ubf206KFqME=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e4e84c-2b99-47a2-89df-08db78d6089f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 19:21:26.7474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILaKSs18Ovm4q/jw8t+DPjF261sijOtgLxWBLVHa6HgJuexC8lkQIOqbtIvoFdJ8qn3QEpViiEIbjADCbrHx5c0Kp8/m3NGnz0EiwX2r8l8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290174
X-Proofpoint-GUID: oQRHcoLgzPR0SWLLuzicqo7BBevteThb
X-Proofpoint-ORIG-GUID: oQRHcoLgzPR0SWLLuzicqo7BBevteThb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is dependent upon "refactor Kconfig to consolidate
KEXEC and CRASH options".
 https://lore.kernel.org/lkml/20230626161332.183214-1-eric.devolder@oracle.com/

Once the kdump service is loaded, if changes to CPUs or memory occur,
either by hot un/plug or off/onlining, the crash elfcorehdr must also
be updated.

The elfcorehdr describes to kdump the CPUs and memory in the system,
and any inaccuracies can result in a vmcore with missing CPU context
or memory regions.

The current solution utilizes udev to initiate an unload-then-reload
of the kdump image (eg. kernel, initrd, boot_params, purgatory and
elfcorehdr) by the userspace kexec utility. In the original post I
outlined the significant performance problems related to offloading
this activity to userspace.

This patchset introduces a generic crash handler that registers with
the CPU and memory notifiers. Upon CPU or memory changes, from either
hot un/plug or off/onlining, this generic handler is invoked and
performs important housekeeping, for example obtaining the appropriate
lock, and then invokes an architecture specific handler to do the
appropriate elfcorehdr update.

Note the description in patch 'crash: change crash_prepare_elf64_headers()
to for_each_possible_cpu()' and 'x86/crash: optimize CPU changes' that
enables further optimizations related to CPU plug/unplug/online/offline
performance of elfcorehdr updates.

In the case of x86_64, the arch specific handler generates a new
elfcorehdr, and overwrites the old one in memory; thus no involvement
with userspace needed.

To realize the benefits/test this patchset, one must make a couple
of minor changes to userspace:

 - Prevent udev from updating kdump crash kernel on hot un/plug changes.
   Add the following as the first lines to the RHEL udev rule file
   /usr/lib/udev/rules.d/98-kexec.rules:

   # The kernel updates the crash elfcorehdr for CPU and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

   With this changeset applied, the two rules evaluate to false for
   CPU and memory change events and thus skip the userspace
   unload-then-reload of kdump.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load() syscall.

This kernel patchset also supports kexec_load() with a modified kexec
userspace utility. A working changeset to the kexec userspace utility
is posted to the kexec-tools mailing list here:

 http://lists.infradead.org/pipermail/kexec/2023-May/027049.html

To use the kexec-tools patch, apply, build and install kexec-tools,
then change the kdumpctl's standard_kexec_args to replace the -s with
--hotplug. The removal of -s reverts to the kexec_load syscall and
the addition of --hotplug invokes the changes put forth in the
kexec-tools patch.

Regards,
eric
---
v25: 29jun2023
 - Properly applied IS_ENABLED() to the function bodies of callbacks
   in drivers/base/cpu|memory.c.
 - Re-ran compile and run-time testing of the impacted attributes for
   both enabled and not enabled config settings.

v24: 28jun2023
 https://lore.kernel.org/lkml/20230628185215.40707-1-eric.devolder@oracle.com/
 - Rebased onto 6.4.0
 - Included Documentation/ABI/testing entries for the new sysfs
   crash_hotplug attributes, per Greg Kroah-Hartman.
 - Refactored drivers/base/cpu|memory.c to use the .is_visible()
   method for attributes, per Greg Kroah-Hartman.
 - Retained all existing Acks and RBs as the few changes as a result
   of Greg's requests were trivial.

v23: 12jun2023
 https://lore.kernel.org/lkml/20230612210712.683175-1-eric.devolder@oracle.com/
 - Rebased onto 6.4.0-rc6
 - Refactored Kconfig, per Thomas. See series:
   https://lore.kernel.org/lkml/20230612172805.681179-1-eric.devolder@oracle.com/
 - Reworked commit messages to conform to style, per Thomas.
 - Applied Baoquan He Acked-by to kexec_load() patch.
 - Applied Hari Bathini Acked-by for the series.
 - No code changes.

v22: 3may2023
 https://lore.kernel.org/lkml/20230503224145.7405-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0
 - Improved support for kexec_load(), per Hari Bathini. See
   "crash: hotplug support for kexec_load()" which is the only
   change to this series.
 - Applied Baoquan He's Acked-by for all other patches.

v21: 4apr2023
 https://lkml.org/lkml/2023/4/4/1136
 https://lore.kernel.org/lkml/20230404180326.6890-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0-rc5
 - Additional simplification of indentation in crash_handle_hotplug_event(),
   per Baoquan.

v20: 17mar2023
 https://lkml.org/lkml/2023/3/17/1169
 https://lore.kernel.org/lkml/20230317212128.21424-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0-rc2
 - Defaulting CRASH_HOTPLUG for x86 to Y, per Sourabh.
 - Explicitly initializing image->hp_action, per Baoquan.
 - Simplified kexec_trylock() in crash_handle_hotplug_event(),
   per Baoquan.
 - Applied Sourabh's Reviewed-by to the series.

v19: 6mar2023
 https://lkml.org/lkml/2023/3/6/1358
 https://lore.kernel.org/lkml/20230306162228.8277-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0
 - Did away with offlinecpu, per Thomas Gleixner.
 - Changed to CPUHP_BP_PREPARE_DYN instead of CPUHP_AP_ONLINE_DYN.
 - Did away with elfcorehdr_index_valid, per Sourabh.
 - Convert to for_each_possible_cpu() in crash_prepare_elf64_headers()
   per Sourabh.
 - Small optimization for x86 cpu changes.

v18: 31jan2023
 https://lkml.org/lkml/2023/1/31/1356
 https://lore.kernel.org/lkml/20230131224236.122805-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc6
 - Renamed struct kimage member hotplug_event to hp_action, and
   re-enumerated the KEXEC_CRASH_HP_x items, adding _NONE at 0.
 - Moved to cpuhp state CPUHP_BP_PREPARE_DYN instead of
   CPUHP_AP_ONLINE_DYN in order to minimize window of time CPU
   is not reflected in elfcorehdr.
 - Reworked some of the comments and commit messages to offer
   more of the why, than what, per Thomas Gleixner.

v17: 18jan2023
 https://lkml.org/lkml/2023/1/18/1420
 https://lore.kernel.org/lkml/20230118213544.2128-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc4
 - Moved a bit of code around so that kexec_load()-only builds
   work, per Sourabh.
 - Corrected computation of number of memory region Phdrs needed
   when x86 memory hotplug is not enabled, per Baoquan.

v16: 5jan2023
 https://lkml.org/lkml/2023/1/5/673
 https://lore.kernel.org/lkml/20230105151709.1845-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc2
 - Corrected error identified by Baoquan.

v15: 9dec2022
 https://lkml.org/lkml/2022/12/9/520
 https://lore.kernel.org/lkml/20221209153656.3284-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc8
 - Replaced arch_un/map_crash_pages() with direct use of
   kun/map_local_pages(), per Boris.
 - Some x86 changes, per Boris.

v14: 16nov2022
 https://lkml.org/lkml/2022/11/16/1645
 https://lore.kernel.org/lkml/20221116214643.6384-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc5
 - Introduced CRASH_HOTPLUG Kconfig item to better fine tune
   compilation of feature components, per Boris.
 - Removed hp_action parameter to arch_crash_handle_hotplug_event()
   as it is unused.

v13: 31oct2022
 https://lkml.org/lkml/2022/10/31/854
 https://lore.kernel.org/lkml/20221031193604.28779-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc3, which means converting to use the new
   kexec_trylock() away from mutex_lock(kexec_mutex).
 - Moved arch_un/map_crash_pages() into kexec.h and default
   implementation using k/unmap_local_pages().
 - Changed more #ifdef's into IS_ENABLED()
 - Changed CRASH_MAX_MEMORY_RANGES to 8192 from 32768, and it moved
   into x86 crash.c as #define rather Kconfig item, per Boris.
 - Check number of Phdrs against PN_XNUM, max possible.

v12: 9sep2022
 https://lkml.org/lkml/2022/9/9/1358
 https://lore.kernel.org/lkml/20220909210509.6286-1-eric.devolder@oracle.com/
 - Rebased onto 6.0-rc4
 - Addressed some minor formatting items, per Baoquan

v11: 26aug2022
 https://lkml.org/lkml/2022/8/26/963
 https://lore.kernel.org/lkml/20220826173704.1895-1-eric.devolder@oracle.com/
 - Rebased onto 6.0-rc2
 - Redid the rework of __weak to use asm/kexec.h, per Baoquan
 - Reworked some comments and minor items, per Baoquan

v10: 21jul2022
 https://lkml.org/lkml/2022/7/21/1007
 https://lore.kernel.org/lkml/20220721181747.1640-1-eric.devolder@oracle.com/
 - Rebased to 5.19.0-rc7
 - Per Sourabh, corrected build issue with arch_un/map_crash_pages()
   for architectures not supporting this feature.
 - Per David Hildebrand, removed the WARN_ONCE() altogether.
 - Per David Hansen, converted to use of kmap_local_page().
 - Per Baoquan He, replaced use of __weak with the kexec technique.

v9: 13jun2022
 https://lkml.org/lkml/2022/6/13/3382
 https://lore.kernel.org/lkml/20220613224240.79400-1-eric.devolder@oracle.com/
 - Rebased to 5.18.0
 - Per Sourabh, moved crash_prepare_elf64_headers() into common
   crash_core.c to avoid compile issues with kexec_load only path.
 - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
 - Changed the __weak arch_crash_handle_hotplug_event() to utilize
   WARN_ONCE() instead of WARN(). Fix some formatting issues.
 - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
   and CPUs; for use by userspace (udev) to determine if the kernel
   performs crash hot un/plug support.
 - Per Sourabh, moved the code detecting the elfcorehdr segment from
   arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
   and kexec_file_load can benefit.
 - Updated userspace kexec-tools kexec utility to reflect change to
   using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
 - Updated the new proposed udev rules to reflect using the sysfs
   attributes crash_hotplug.

v8: 5may2022
 https://lkml.org/lkml/2022/5/5/1133
 https://lore.kernel.org/lkml/20220505184603.1548-1-eric.devolder@oracle.com/
 - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
   of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
   is not needed. Also use of IS_ENABLED() rather than #ifdef's.
   Renamed crash_hotplug_handler() to handle_hotplug_event().
   And other corrections.
 - Per Baoquan, minimized the parameters to the arch_crash_
   handle_hotplug_event() to hp_action and cpu.
 - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
 - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
   to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
   by David Hildebrand. Folded this patch into the x86
   kexec_file_load support patch.

v7: 13apr2022
 https://lkml.org/lkml/2022/4/13/850
 https://lore.kernel.org/lkml/20220413164237.20845-1-eric.devolder@oracle.com/
 - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.

v6: 1apr2022
 https://lkml.org/lkml/2022/4/1/1203
 https://lore.kernel.org/lkml/20220401183040.1624-1-eric.devolder@oracle.com/
 - Reword commit messages and some comment cleanup per Baoquan.
 - Changed elf_index to elfcorehdr_index for clarity.
 - Minor code changes per Baoquan.

v5: 3mar2022
 https://lkml.org/lkml/2022/3/3/674
 https://lore.kernel.org/lkml/20220303162725.49640-1-eric.devolder@oracle.com/
 - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
   David Hildenbrand.
 - Refactored slightly a few patches per Baoquan recommendation.

v4: 9feb2022
 https://lkml.org/lkml/2022/2/9/1406
 https://lore.kernel.org/lkml/20220209195706.51522-1-eric.devolder@oracle.com/
 - Refactored patches per Baoquan suggestsions.
 - A few corrections, per Baoquan.

v3: 10jan2022
 https://lkml.org/lkml/2022/1/10/1212
 https://lore.kernel.org/lkml/20220110195727.1682-1-eric.devolder@oracle.com/
 - Rebasing per Baoquan He request.
 - Changed memory notifier per David Hildenbrand.
 - Providing example kexec userspace change in cover letter.

RFC v2: 7dec2021
 https://lkml.org/lkml/2021/12/7/1088
 https://lore.kernel.org/lkml/20211207195204.1582-1-eric.devolder@oracle.com/
 - Acting upon Baoquan He suggestion of removing elfcorehdr from
   the purgatory list of segments, removed purgatory code from
   patchset, and it is signficiantly simpler now.

RFC v1: 18nov2021
 https://lkml.org/lkml/2021/11/18/845
 https://lore.kernel.org/lkml/20211118174948.37435-1-eric.devolder@oracle.com/
 - working patchset demonstrating kernel handling of hotplug
   updates to x86 elfcorehdr for kexec_file_load

RFC: 14dec2020
 https://lkml.org/lkml/2020/12/14/532
 https://lore.kernel.org/lkml/b04ed259-dc5f-7f30-6661-c26f92d9096a@oracle.com/
 - proposed concept of allowing kernel to handle hotplug update
   of elfcorehdr
---


Eric DeVolder (10):
  drivers/base: refactor cpu.c to use .is_visible()
  drivers/base: refactor memory.c to use .is_visible()
  crash: move a few code bits to setup support of crash hotplug
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  crash: memory and CPU hotplug sysfs attributes
  x86/crash: add x86 crash hotplug support
  crash: hotplug support for kexec_load()
  crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
  x86/crash: optimize CPU changes

 .../ABI/testing/sysfs-devices-memory          |   8 +
 .../ABI/testing/sysfs-devices-system-cpu      |   8 +
 .../admin-guide/mm/memory-hotplug.rst         |   8 +
 Documentation/core-api/cpu_hotplug.rst        |  18 +
 arch/x86/Kconfig                              |   3 +
 arch/x86/include/asm/kexec.h                  |  18 +
 arch/x86/kernel/crash.c                       | 140 ++++++-
 drivers/base/cpu.c                            | 141 ++++---
 drivers/base/memory.c                         | 242 +++++++-----
 include/linux/crash_core.h                    |   9 +
 include/linux/kexec.h                         |  63 +++-
 include/linux/tick.h                          |   2 +-
 include/uapi/linux/kexec.h                    |   1 +
 kernel/Kconfig.kexec                          |  35 ++
 kernel/crash_core.c                           | 355 ++++++++++++++++++
 kernel/kexec.c                                |   5 +
 kernel/kexec_core.c                           |   6 +
 kernel/kexec_file.c                           | 187 +--------
 kernel/ksysfs.c                               |  15 +
 19 files changed, 922 insertions(+), 342 deletions(-)

-- 
2.31.1

