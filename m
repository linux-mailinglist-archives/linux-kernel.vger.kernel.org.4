Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD5A6A8C1F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCBWpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCBWo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:44:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0E31817B;
        Thu,  2 Mar 2023 14:44:57 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K49xr008976;
        Thu, 2 Mar 2023 21:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=RV7zcKhYnC3ioScswFae4sZ5q2elYHJfEAklVpyE8tE=;
 b=CeDsG33gngFrhIMzIaX/WyiZYiBtcU6av7PlemtFxX04QpC2wtDgsI2piwJDzMl70NpK
 6IL1h5pQiGvGHiY5RTY7oaIevvSlyyMOjp6KdttUhFX3XDnWcC5JlcI42jOyeBC1DVfg
 SrUD7e/SkyzjKyl242M0IuZIPNZlC0dtKvEWPVe+3nmIyiN861XlXiexVyyOPlBQCj1o
 xAv4zMfEJXfeoCPd158gP/TXgjThzJ6Q6vf5Vl96Cv5OkXCH2CPtS5NsU9fORziEdU2R
 blSzYrUCZy2GB4vB5nbz63eBOP4c/J5JIcgn7OusN9h4U0xytP4+B8CbxnQwx34K2vJk vw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba2d37a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:19:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322KgJ7m034891;
        Thu, 2 Mar 2023 21:19:19 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sgqpc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:19:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1viD7Evqt81YIKJSwm6jmjrW+swaBjQCmYUV7jnCw5AksrenMyuWrEwXkoLfRPkE7rQK1kEU20EPg7JeVmhLonLoRzHvR8fRSGKWnt5x9HoctTqhSTQLHo49K5x5wM+9T6l2EuAJ3PxCfyyNGEAOG61tZPKDj/ZsxUuqAABroxR8rdmb8KBNHkJ5GedT/d8hnMmnUWXihGnXFUrPTmU64xz4y3FZix0EGYxtbqZ3fp5spcnNsaRAJaxWr8wgjjEJ5pcjhjNo1PZOEaNoay0BAEe15Q4Kkfmge4jhGWBur0Q5wRbvDOmlpAM/RC2ndlZGXQSOUbARrTJHyo08gUg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RV7zcKhYnC3ioScswFae4sZ5q2elYHJfEAklVpyE8tE=;
 b=kHX0+b2n3c8Qdx2rHOP2bK1hpNSh7XsgP6nqBDYuP3eu8c7eW5BWozGzvhkwAxRpEHA30A0yZs7ep4VMlgGwdgCHiyaI9Fu4qN1v6Q7ZXI3XFBwZLNt1ajZ+lZae2puoXVY3oKWCwX0xmlQexTzdGkgZd2gHXRkvYEGRFnY5bmvt8ZQxoiUqN+MlfdCV8PIk9yyglvZep2/mpa9nV3rLwIQp3BBzNmWY/t+kCzU6BVvlyt0vkIDt+1W2gpCdXwk2i3Yf9m/kE73WXCspYZXjRum1tbfAaqrYZT8FezH5fUAWNwseoD26cbuwPUt/Rg/zl2R2aCB060E66ghDGSazXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RV7zcKhYnC3ioScswFae4sZ5q2elYHJfEAklVpyE8tE=;
 b=T93pWNeBl3TPgP3TFxPQmkXsdNspYvn7VrnWxwPOkymb7fSWiPoklwUBOWhO5LcEoj6g+1qNp3YjSXPPe11VA0KPZJAZX/UXPkal2bwmBFzq0ad7jCQCCvZBtU+DhjgdKuLfDCUv6hZqqIbd4exC2gpzTcdyXvOwOSME68BlCQg=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA1PR10MB6414.namprd10.prod.outlook.com (2603:10b6:806:259::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Thu, 2 Mar
 2023 21:19:17 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 21:19:16 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: [PATCH 14/17] mm: remove MODULE_LICENSE in non-modules
Date:   Thu,  2 Mar 2023 21:17:56 +0000
Message-Id: <20230302211759.30135-15-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230302211759.30135-1-nick.alcock@oracle.com>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0511.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::12) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA1PR10MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 91886af9-5834-4a2b-fbd3-08db1b63c78a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Ri5FqhPKc85bDQs+eVTFgGjvSxIUdDGup+RJATPpLRFGsW1rHAAyueYNoLdBL3r7tjgJKSgt36JKqAX9WIWURGzYqh+ruApfJAjI/jNtWX6i38DJ4e3DTJ9xACDtDSqZYCJBggI8r5J7bncTppw7MRnE8I7bQA8TGJ7OBCmTb4tKHBGrMCE1ZSjLDlp8KcaHQPpSQ24ONWjqJZL0/eKrnp2gJds1xgtwiOomHHA5v7sGxa8QHuwwkHEUqQ8qUH5so6W5X4iHcH1TCjw2hbuYTysiHh5tzaF4w+lWpwrVtU7S4A5u9bnruszzToYmS/8cxdbgoz184hP/J+JCn8L1I385/Gxw9ZSowUiwxqlccEAR1Hg1xFqJjWMf3nx/hBi8Q0rQiwyNc9xjbga6HCm/L2cB7xyOyIukm9P6FX1IIXUsaz6A4uKAWMfozE/q5WoASt26O7qDoc1NzL9FQaIZNcrmIYvFDBSh5TspDz2Uedsb9qX1+pVlZBNqpgWN8suhap2xUQWZ+Njy4AqIBZqQfoN5kCfsTj8wipXlNTZRFnGOJKeTj+5VgfmhWoBBZepeNXS38VWY4dQ5134ZSZLSP8cYEbDMjWEyvVDKv9bFc8Ux/pqrWR0l6Fo/DNMu5Rsp58TCT3E9bR4beyPJ7qyxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199018)(44832011)(7416002)(5660300002)(41300700001)(38100700002)(8676002)(83380400001)(4326008)(6916009)(8936002)(66476007)(66556008)(66946007)(36756003)(2616005)(2906002)(86362001)(6486002)(478600001)(316002)(186003)(1076003)(54906003)(6666004)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AViqCwhqNxUPVIqj5oqJA1LIPM96SMeYBOMXCMnpaFHIO0ULnjD/hlsSA5W+?=
 =?us-ascii?Q?rihFBphiS+L04hjrdpO/BvJNhTJxFPGlD8n5jrk9t2WA8okH57tZCxWyyLqO?=
 =?us-ascii?Q?IWOlbDbbyvQpNZxnIiynaoY0eicgotOz5RStBi/xkGYvuE5F1bik7aPaEo9+?=
 =?us-ascii?Q?FgUbNa6EXviPBYbJbStmi57d1Vusz7aGSgKbuQ4MWuMqLVFt07JpnTug86UD?=
 =?us-ascii?Q?oGiWh+t9D9oql7gsf/1+GH2exhFrNhNjg2BuIdNHRuR6MWyMDjjwlMQ1E6ED?=
 =?us-ascii?Q?XSbLaqtSpE0UyNIwSQGdknsns6NDliSy7ddDlrFRQXP7DiHhLCNMOqlj96+C?=
 =?us-ascii?Q?9nzcIukGaj76i4GxfSf2yChuY/ly3iv0qWv2YSGa8YRlqQX6JPl2elJt0aBp?=
 =?us-ascii?Q?fgjXwhxwZABaOdFe4ZeXbs5J0Gz6ogitUlCPEPQ2CHWFXij8K5xe9edC2ExI?=
 =?us-ascii?Q?UmWZUakL/A7kARKQX0bP059gWOucCAsdLh4VYINkO5A55aJiMGHavWCPRXOh?=
 =?us-ascii?Q?beS5x/LjNnsH33ilFCpV1lJhfME5HhodQBwxxq7dMOOu9Osj7JVJQPlMUTIo?=
 =?us-ascii?Q?JG9uv+9B2EXdIJXgRYcENBU7ReQS3OCR2YYTRJya5FQF7OnTPtuPmtzOxHYY?=
 =?us-ascii?Q?SX7PRfrlyGQMzMYHFdIAOBawC1UHFhAZj1zPjwR/995XjVwxf6pMpe1jvisE?=
 =?us-ascii?Q?gI8Y1CaGE6VvJKleJ0MltpKBqTdPvk8+E4sKE2lwGzbF2yIxufeglLYC+gc0?=
 =?us-ascii?Q?h9mEU8Zjx3J0lv437g1oCfQfP2vzk0YMbSYzowfydAuqz9DYKnc7idUeGeK/?=
 =?us-ascii?Q?Ilz+aHwxWP+b6D95c+0mgPrdq4qkgQ0kigSdgDWZUTNquFGmF8UMLToEiGOW?=
 =?us-ascii?Q?xrBF/SbYi/WZ9LDtps4UfanMHe9Je6tyc4SsBAPfbnsiNuK8z3CkPyGb5DzE?=
 =?us-ascii?Q?Q3HdD4HCyMVAWWgi2UL4HPlpjnoCie0Uiik4d0Kbh5XCDWNq+MZsc6Iixt2N?=
 =?us-ascii?Q?wLRCyQ9NKuDP0e5DWHk6VHAFhKOEshTpM7yCmm7foQwxQjNaebUfLmOE8yGv?=
 =?us-ascii?Q?STWOi3uCUa76UM6pYpj0FFBfquBE71Dh86oG+X6f47GuNBrp7wnYxt6x52TK?=
 =?us-ascii?Q?maWAFf//BkrWsz+Yt6fRnIRzDDEnZ3wH0vWJZsDl6Aoj7h8wgjB0ibmZzVtT?=
 =?us-ascii?Q?cJVl/Ru2yqu6hMGBPqcl6f6PggY2hyotZtSOY7iKrU0y2g61sIeQuC8m6H0D?=
 =?us-ascii?Q?4qDn5BBS+TuhEtyKaS+KGZs0meH+ji3zlkB6ETpJWk3Pqv3AIeofuQfkxQzU?=
 =?us-ascii?Q?SIibRxrhhAWIuEYxNFu5xLfmbMsHLLCmlUFJ9KyJj/noB5c13gATcWSrWBTd?=
 =?us-ascii?Q?M4CLsul3Ma8fyVt8Nw0t3LdnhagJq4ISNeIOhkGKUQ3iADjklAlKl0I81cXH?=
 =?us-ascii?Q?EqVaIvXjcjvo08j32Lp5ZzD6qqBWBCTyun4429Hrc6M2LobkEizYF1050VfM?=
 =?us-ascii?Q?NZG2jCzFWFPJG+RZiaJaoEWWewYSG172i1XPiR9ISD2ED7AECBEJisCr+UyA?=
 =?us-ascii?Q?f7rU1MVC2qGGXMo//DdxPrBkpbpkp/Sxjwg2+hQRRhAJkhHO0+WNpkRQzgqa?=
 =?us-ascii?Q?PLf8P5WyXsM34J2J3l8DzqQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/pgxE3EpJ5jsoVty+rKUk9kywSg4E9+Gq+fEoEoTeWzoccmK1BObMvGldi3k?=
 =?us-ascii?Q?rfTVruNmQsDq59ggkCwAuGLFzXpHD0dAHesnAEsMtLmuO/yKCxzBUH3PU3+y?=
 =?us-ascii?Q?WZYQTw8uWNv+vNbNa8EhBM0Lg5Micap/BhM56e4Oa3fSAb53faqIqDKCX5Uu?=
 =?us-ascii?Q?Sw+AWqkVzNGYLTuDQbFr5lE0mFzCdtlOeVgFeKQzh7QrOHg9IKZpOLBwk2Ei?=
 =?us-ascii?Q?GfyKmRkys0pfQ4OOR/fxyKtN2EbIA5x4Djeoayj4tSlp4rJOzFeJVXUJt5Qg?=
 =?us-ascii?Q?tVj/x3UbPY5djMvBmQhhDlN7ZSesnQmZJIpx2oDflY8ofQr4gHHiGbjPuJ3L?=
 =?us-ascii?Q?QgcJ4Zsdwpw6tPZozbHQ/mk7IDys9B91sAI2DvVS1cTuScevLUC5SIes2P5s?=
 =?us-ascii?Q?kQXRGWOCFT8iXtR4nj4VbwvLuuUWU+oK+kpO/17uJ+16WCNCwIz1o+nexZoi?=
 =?us-ascii?Q?wuhE7tycnm4xfXleqGq43qOBbdPO1GCNqMK1IMrJkDmrZgMNmUBUgssSIWAk?=
 =?us-ascii?Q?wNH/qoJIwr9PIs6vjX0TlDzawbRyGrVCIuv9+w5XyfZnSzz0N9MfHGtRMjpN?=
 =?us-ascii?Q?AfoI/su+deV3u4o3aBFa4RQlnIhN8wZrXx+Jj24xKA60CWtR5ZoMNLwivBQ9?=
 =?us-ascii?Q?c4e5bdP4flXoJbRXbYrfwE2uOcZNaHmVqRt/o+s4J24o2hC1QbOF3NvpEUHS?=
 =?us-ascii?Q?XhLj2zNG6Z/36LTAtKribfWqtOmfaA/hBv0UADazomYU/+dR2kz6prOT2nw2?=
 =?us-ascii?Q?Yj7cF666K5fOES4QQPJyen3f4e1rJC+4eN21qqNSpkXKQiHxDfSZggVM2bLU?=
 =?us-ascii?Q?LrRZxdhF+xPxal3zgQMVMgrGdsVk7WRBdUMVhhDt5XZXb5bvSmTa6GgfRMuz?=
 =?us-ascii?Q?FHky46zaB/xNwbfVQJAfG/ib3u+3dIrf/ndnz0Ar76bZLSVSISOxG3hNMbvL?=
 =?us-ascii?Q?/HLjy2C3PVnAvvVGG+3d1hzP30Bza/3GFFeJMFAo0CwCZkyEirkWBwvfF4IU?=
 =?us-ascii?Q?1ei1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91886af9-5834-4a2b-fbd3-08db1b63c78a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:19:16.7481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AMmxKK6oWlpX8ZkFGhzT6OyJP+I7UkPRAPYfRJLNrZrg8nj8IhpFSSqDnR0CXGlmz3eqK/V1yQCbebQHy3Zfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6414
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020183
X-Proofpoint-GUID: Ahq31CGgC8umOSDa9iCW9lxvrmZRTXZr
X-Proofpoint-ORIG-GUID: Ahq31CGgC8umOSDa9iCW9lxvrmZRTXZr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
---
 arch/x86/mm/debug_pagetables.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/mm/debug_pagetables.c b/arch/x86/mm/debug_pagetables.c
index 092ea436c7e62..b43301cb2a80c 100644
--- a/arch/x86/mm/debug_pagetables.c
+++ b/arch/x86/mm/debug_pagetables.c
@@ -71,6 +71,5 @@ static void __exit pt_dump_debug_exit(void)
 
 module_init(pt_dump_debug_init);
 module_exit(pt_dump_debug_exit);
-MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Arjan van de Ven <arjan@linux.intel.com>");
 MODULE_DESCRIPTION("Kernel debugging helper that dumps pagetables");
-- 
2.39.1.268.g9de2f9a303

