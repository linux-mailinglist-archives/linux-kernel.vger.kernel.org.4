Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F30A65EFCC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjAEPSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjAEPRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:17:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3374FCE7
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:17:51 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305E4U16012403;
        Thu, 5 Jan 2023 15:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=dK/yPg3DcF43xzFfTNyKdijHmr+2iIu+qNvpwKO/Ayk=;
 b=1AnOsXcPnLA2m2i2yFvX3608c/ja0Xrxpr9/P/8GEsk587MQVF+DG44/Jxxrwvee/t4/
 n7ho+jwBUjBZ8aJVuUqtgfoEBoRfjTB/MppOSUodtq0BK56fH721Gmq3ckoSPQtPmDrQ
 /Z+0M6Kcc5gSXBVynF+udeP0Cjm7m4G3WTWNbznqumuZNQhxvpfYbFN0bgkxWM3+DuRN
 uavVTwOvqO8Xh9/gDq7xMW9LCFkv159HBMwZ83pHXmEjRbVzn9qk2Sufip89phJLda3L
 zBcecSg+LnTT1rEmffxutl8+VHtSpVER/ZMmCBRB7AMGxt638RqIKg9uD/vweBIEyFSY jQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp113f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 15:17:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305EPKoB040165;
        Thu, 5 Jan 2023 15:17:27 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwevjmsmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 15:17:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpIdwzRam8KKLaAzzQxf9re+OaB8MJxE5aBnEZcoNmBV7nhI9RslU3jOPT3/FzoFKnlQU7ZC+DoGVSp/hAOgjTY2Klf5xkRMgRKhvnF26dvnhSGXpyTRz7gOHBJAl3UBG2uzw7zIsGp5brZ6miKBYFmsTcdWxITVbRzF31AvjLteEV/OI37cYRfPGA0gAt1k28WAWMmmZtFvTSwd1hTYsPp95gMH/8MSg2OdHWhL2G1iq5ilfuWT1NsPg9bfgdANoDPPfBIX6Mf04L0xvQvshGCFwALlaDZDDCbZsOUFYC5aMd3km8pPjMoBRVVXOB9f+ocH8ZWpWrMeMyRneQZohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dK/yPg3DcF43xzFfTNyKdijHmr+2iIu+qNvpwKO/Ayk=;
 b=FP6CLbKH4mFL66ZoUMgUPLqUkRuEGvaHXonPoqmFVKf57TpnMTLyBC85lvIDsH9QDYKt5R5yPr2D6q3JZiHufF9spLE2MGmr8JmxIfwwgQK+bX4LgXdHcjbrmpRvS1lTscuJwqSdVDug/hzOwtMm4Hg9pFD3dGZUB9rDNgxdfUltFMg7BtNBHujyyKcuZQkNciMm7Nnruh8AyP8lxQUic9VTBTXbYHnUokSvZORUi3mBvKqqzCizQOyj+L+aYKnBNySHWSWEYmvfG6lw5T/3k4C6ovY6UEZlpSw+Ah36vpsy8W+xVxFiGuXQAOmrPliwODoXAFwD1CT7/QNKD3ZmUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dK/yPg3DcF43xzFfTNyKdijHmr+2iIu+qNvpwKO/Ayk=;
 b=jw8ESSEp8B1thtuHCm2p4BK8Qv9djJJ3n9UmQVqfLPnuP06rU24roqWhK5tAFBx0rdUn8PwIbOqJau8KSsa45XuXak2oLK50LPcCuMVN2MC9B30uSSExQWLSIjJmGASMyMzx3K+OakTMfWvzL1FGDxiX33zHJcbXY28sX1WrO5o=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH8PR10MB6477.namprd10.prod.outlook.com (2603:10b6:510:22f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 15:17:25 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 15:17:25 +0000
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
Subject: [PATCH v16 2/7] crash: prototype change for crash_prepare_elf64_headers()
Date:   Thu,  5 Jan 2023 10:17:04 -0500
Message-Id: <20230105151709.1845-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230105151709.1845-1-eric.devolder@oracle.com>
References: <20230105151709.1845-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::11) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH8PR10MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a581fe-d367-40c4-dd53-08daef2ff2fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jBJ2dQouqyadorISjinSYz5+XZStME605EP5u+tWZYnCvc0G+44EIP6hGDuBgLjm7sEIuqPAWXT4NQ2rSvN4Vji5RRJjj9M20M+D3jB0cnf+9w6BbnAUaIuf+6LrZO4Z9lchLcd3+9KrOW/axZd/Mv6ga8UtrwYzwcP6gsu/NAKLety3cUuSTYWRCqA5TfR513IOzrHQ6BeZCrgkHHGF3SMVT+Czi6hEMcT1XbRC4Lk2paqBR6tfl4jwki6le6B8ARu5mnnZWUBftFIiqALimvelyWIQ4gGHLH9OQ1QXjx0FwdsNRF7r4ZR+boHWD3pdoOxciDwZTbQ0wsekKd1I4WL0auT+zFIc7UhdtnWYMWL3kdsJssZnEpdMDcR5RPyeDiheYNxReopSur52yNlsKPmX7TTQYESV8sz/NNKgykUmhIbDO8wIa0DwKoWDlkbjAUx9z2v2fuuycovBOTaeOEQskfT6GgtNOd+F9Q7TaTGxyMVyoHqoyokylYa8OVb9DZfv5/+v8oo9gYnqKRa3fU2qCy0a7Z0lSD/Ts/MZjgFo9HVrTjfyG8kefgO5yjtHAMKdE5tYUaNF4lHXs5yyEC1lAkMb+YIgwo4YxNnGOzS93IeltP7+FTWC15kvOP9AlSldPMjeyjcKceHKajkShw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199015)(5660300002)(7416002)(2906002)(8936002)(41300700001)(478600001)(316002)(4326008)(8676002)(66556008)(66476007)(66946007)(6486002)(6666004)(6512007)(26005)(6506007)(107886003)(83380400001)(1076003)(2616005)(38100700002)(186003)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eI1R/lr3T3pZKnyxECz7S5zhTtHemHMngP6SzQMzf2Nt0ttM3vbmq8QSwMr+?=
 =?us-ascii?Q?4BKxoSHmIWgL/kpXfDSBLZSZjhjA2lwms3r4Tc8DyUfQg+bME1YDdnQ9/rE+?=
 =?us-ascii?Q?2DHNx5f0z1pEEAZlHhMK1w4JqxXMCi/ymVTL9fhBWfVf9N6XO0doIfF/mJBZ?=
 =?us-ascii?Q?m/thQF1hvAbWDJ8DQCconwIqbMweDl7rwnIWA1SVnGNSuigavG09QcuC/QK2?=
 =?us-ascii?Q?zjVAC+NP3mYgvYxc0Mqq/EaVBe94ng49qwJVitqV0G9PnroUbANCqtsiP+sd?=
 =?us-ascii?Q?szp0cObN/fjS56MgGuJEGQ8kO4nGLKFfvrdYbHjaRnlezIqEGw/QTFhMzutU?=
 =?us-ascii?Q?iea3mlt5pe5wxgRdhp/jT/j2y1oczJkXk8JGckhKJFQVYq91aYg97hWb2OED?=
 =?us-ascii?Q?KLxBhmdETXxH4Kx5LbWJc9yhwTvgalwnVk4U6PG2rkLN+bir+VTIewbGkAQu?=
 =?us-ascii?Q?fmwqpBb+MLAyvY/txmUK+AC5fJtbn29WWF3+SMbezQrgtjhoOSSGCRe6MG19?=
 =?us-ascii?Q?JC004jGN+RjvNMXJzjLhD9itpYoaIcPUdsy3RYgTS7ZQRoyxRBmuJgokK0xC?=
 =?us-ascii?Q?rZwtkq4/HlPf1Me3Fjz5WPNyh9Ci97L8JOmuw8x1byXWgmzMKAnxrce+nGzX?=
 =?us-ascii?Q?uzR9tJyqDAiq1UsxaObVS3DMKnj2inCshu6ljrBNLfEX5BGw2/GKQnNnGlkn?=
 =?us-ascii?Q?IsdTHcTBJxV8Ovi05Hzb6TEluU772Tab3XS+zhFblf4dkBBokaA72meFhs6n?=
 =?us-ascii?Q?dpFQFTEMuU3FJBe3n0MArgAojRXtYUJr7RST5TKbfLb9TrXiIz63uRXreOpw?=
 =?us-ascii?Q?r6J7rAWYNYqAuEQa0ze1y8RCwUy2QqNEgRxwmKUSapQmrtniHhWIqicbqny1?=
 =?us-ascii?Q?7o1Oi9VM8Bg9cRu5tLOVJKdlq83jE81gneSV4VxZyiJ2X94z4KKwvUq/qTD6?=
 =?us-ascii?Q?n+omPWeFlS90xjrRABX/L/YlOF1djZ/1QJmw4P7ltWCrm5sL0RVf6Gbh04mP?=
 =?us-ascii?Q?Uppeoq26/WuWdGFuBrxr8ULr5siktnCr+HctI/gJqMpz8D5lcgCsnGPD9AsU?=
 =?us-ascii?Q?UC4bQA2YOlG/+9Z6hV15bdRZ4CF1kKwk/IZwWSWatKbdEjcyrQimfesOABbL?=
 =?us-ascii?Q?QwmWS1usQo/HLc8DzEr9O5WFRR8M/XjA2Tkg4cZ7lw8l9tMm0Xmsht5pgME2?=
 =?us-ascii?Q?YcJLWZcpyFuGR3fx3KMI4L2CB1ew0N/fo0UNNchEkKr4m7YKwEEF+ppgqy9y?=
 =?us-ascii?Q?OLgiXiiW7q0bX+Cdjvc034UkOwedz+GM8yZv7pIOmPqVtk7BlMjs5yTEF/+K?=
 =?us-ascii?Q?VsgHoPb10K1ZrRrH8EmfQ3cB3cIyFws0Zgi5koqFu05igXKrqd8wckN/fTFp?=
 =?us-ascii?Q?k+qeV3NBnOOLaLYHt6PGZGd2RNudU/ul2k/KvEkbqekdXlhlHQBBV6SwJlbo?=
 =?us-ascii?Q?TIeYISJ8ied1ZOtyZR7E4rOc4Wazn9x/VXOapfmgmmPq/UFxhY5II3862bXc?=
 =?us-ascii?Q?s/UIwKOzdrdX8OYUT4vJR9/NsdBpCLh2OwBOnHDv95/9NoDuYvXmtGF7p8nx?=
 =?us-ascii?Q?f1i7z+mX04n1/1XrSjhNYrPDstgw4Vv8U1Ml4pFr7tOZmENyY9QX32d9DQGD?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JOgbWnk3jY0PNDp5UwOEjic50aXsBFWAOjBIXE43xNKfPUzJBpjQXlLCuPAJ?=
 =?us-ascii?Q?6JeH9CvDvWWvDVuRm+2Vylhp1IFfWOTet/CG+zO9uHaMVJ/Qh/dA+FZlXWRq?=
 =?us-ascii?Q?xhasRUvrLMqaio0LSPOvmpYeIjZSURGhVcG8E9mRY6GYy2skLkAQT0z8AgbF?=
 =?us-ascii?Q?rp9OXPG0nAsjfB1QoxmeQcqHi7NTm9+2zboIRGTjwv6CZsjTtvCIeDOQOO6/?=
 =?us-ascii?Q?7K0fS7uWkbiiqOyy7b6lJi50Q4MfKkelBOg4pbeSxITqo5hnLjmg0yoOlQwr?=
 =?us-ascii?Q?bxJGkc1Y5y+neE2l9s9DS2rcqML7y5Q8rqcHQr4wGTIoo40PSyC2lcwwY5Ex?=
 =?us-ascii?Q?GdlIV06MfWEysWIA/am8At8TyhJ1QEcPNOqnKMagVqDxIy2cUMrPQyTjZidB?=
 =?us-ascii?Q?YzdCoav3VY6t5ZCg1xMycZ9kUeTNP7BY8zr6RsHo/wczVHT19nl/KORlNllZ?=
 =?us-ascii?Q?x+x7Tt2uUVR6naRdHJZAXiQ9KFX60AiJp+ZL3J26UYe7XCN1WCB0fmjnPq+k?=
 =?us-ascii?Q?cDbLah5kQsph6ivFr5dpoaiJGMhgH0Ghpv/+3FJbzJDgSU6cQI8k+FH6JASx?=
 =?us-ascii?Q?OfZu5/NOW8BPEnqy796nITN5FeAmFE7eOzTZ6cnH/7PiRCj/aSloyqyMZYd+?=
 =?us-ascii?Q?lISllkbRS/j2y6u73fhRcVoKXY9PZUOuarhtMFuEH4xLg04hPwpCDSbq3c3q?=
 =?us-ascii?Q?VO0gAoC61z/M8ayp8JPZOztcDYktqEF0BwI3T4gV6MecO6fdAXd4CawjTNO3?=
 =?us-ascii?Q?byIqhy6wYPFYJiMt3tYrlAVcr8dMHnFhIfm/9JWaIFO7Q8TrJtj10poXlPnn?=
 =?us-ascii?Q?2NO/gj0LUjYRJF0efBy3xvyRwtZi5BTCB/2XZrJR2U1f60tULji7iKo/TqcF?=
 =?us-ascii?Q?M04/cMGJ5RwFggWJmn9glQrkIdCfRVyfeLcccIagAr8P5AqcEFTm60vGEZle?=
 =?us-ascii?Q?naqJRJxugh1/447N9xhOBsDoQOVZwAFtN6uFEhS2lnsDb1gbBaNpyiuWZjUx?=
 =?us-ascii?Q?G5EVSkOrY616qoQAp7Ab+qmfeiENfspd6JPQul7lohj/FvP7swI+hW8E38xL?=
 =?us-ascii?Q?xTIlGqSHwR6mUbs34/zykOKE3MS+xpRfzRhCBfNmD0CvpRjiWz+l+k/OpMX1?=
 =?us-ascii?Q?x1sBtR7gPRHBiBT01O0Rt2iOHFSlhUBFLo2pBwj5p6IdXqsIw6M8XqBDKwr2?=
 =?us-ascii?Q?fun+ORUwAadhLhp68hcJlZ1upY3m0zFOydCe4crWhe8KLMUJGJPII3npSzZe?=
 =?us-ascii?Q?hIK8kliIefaExbX2y5Lud8/E8dHKDvOqFnMN2Ky8F8JWhDABOtybpaYBtV9k?=
 =?us-ascii?Q?zq7j8yiFUK/YhmP49ufw/c3fjzo77ws+p3ScWEjvLKj26w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a581fe-d367-40c4-dd53-08daef2ff2fc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 15:17:24.8005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMGjmenyfeReAlPcpGlFGltZiK8L9XzosKRopqny/xuFp+YH7gTU4dZoepXzf2gRDwo7ne4FPvhNc5+cdiSUCPqlJPxJtuRRbvmc5ew8mVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6477
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_06,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050119
X-Proofpoint-GUID: QGM-WDwl6rLpicYkP613CKN3bewjV86z
X-Proofpoint-ORIG-GUID: QGM-WDwl6rLpicYkP613CKN3bewjV86z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From within crash_prepare_elf64_headers() there is a need to
reference the struct kimage hotplug members. As such, this
change passes the struct kimage as a parameter to the
crash_prepare_elf64_headers(). The hotplug members are added
in "crash: add generic infrastructure for crash hotplug support".

This is preparation for later patch, no functionality change.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 6 +++---
 arch/powerpc/kexec/file_load_64.c      | 2 +-
 arch/riscv/kernel/elf_kexec.c          | 7 ++++---
 arch/x86/kernel/crash.c                | 2 +-
 include/linux/kexec.h                  | 7 +++++--
 kernel/crash_core.c                    | 4 ++--
 6 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index a11a6e14ba89..2f7b773a83bb 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -39,7 +39,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+static int prepare_elf_headers(struct kimage *image, void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
 	unsigned int nr_ranges;
@@ -64,7 +64,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	}
 
 	/* Exclude crashkernel region */
-	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	ret = crash_exclude_mem_range(image, cmem, crashk_res.start, crashk_res.end);
 	if (ret)
 		goto out;
 
@@ -74,7 +74,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 			goto out;
 	}
 
-	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
+	ret = crash_prepare_elf64_headers(image, cmem, true, addr, sz);
 
 out:
 	kfree(cmem);
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index af8854f9eae3..e51d8059535b 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -799,7 +799,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 		goto out;
 
 	/* Setup elfcorehdr segment */
-	ret = crash_prepare_elf64_headers(cmem, false, &headers, &headers_sz);
+	ret = crash_prepare_elf64_headers(image, cmem, false, &headers, &headers_sz);
 	if (ret) {
 		pr_err("Failed to prepare elf headers for the core\n");
 		goto out;
diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 5372b708fae2..8bb2233bd5bb 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -130,7 +130,8 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 	return 0;
 }
 
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+static int prepare_elf_headers(struct kimage *image,
+	void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
 	unsigned int nr_ranges;
@@ -152,7 +153,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	/* Exclude crashkernel region */
 	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
 	if (!ret)
-		ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
+		ret = crash_prepare_elf64_headers(image, cmem, true, addr, sz);
 
 out:
 	kfree(cmem);
@@ -224,7 +225,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 
 	/* Add elfcorehdr */
 	if (image->type == KEXEC_TYPE_CRASH) {
-		ret = prepare_elf_headers(&headers, &headers_sz);
+		ret = prepare_elf_headers(image, &headers, &headers_sz);
 		if (ret) {
 			pr_err("Preparing elf core header failed\n");
 			goto out;
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9730c88530fc..9ceb93c176a6 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -265,7 +265,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 		goto out;
 
 	/* By default prepare 64bit headers */
-	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret =  crash_prepare_elf64_headers(image, cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
 out:
 	vfree(cmem);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 5dd4343c1bbe..c8662a48d455 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -250,8 +250,11 @@ struct crash_mem {
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-				       void **addr, unsigned long *sz);
+extern int crash_prepare_elf64_headers(struct kimage *image,
+				   struct crash_mem *mem,
+				   int need_kernel_map,
+				   void **addr,
+				   unsigned long *sz);
 
 #ifndef arch_kexec_apply_relocations_add
 /*
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index f10e2266c310..92eb7dc05457 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -315,8 +315,8 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
+int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
+			  int need_kernel_map, void **addr, unsigned long *sz)
 {
 	Elf64_Ehdr *ehdr;
 	Elf64_Phdr *phdr;
-- 
2.31.1

