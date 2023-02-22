Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B7069F463
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjBVMTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjBVMTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:19:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281E9392A1;
        Wed, 22 Feb 2023 04:18:56 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8x8Hm011289;
        Wed, 22 Feb 2023 12:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=McxsJ7xw8hGURuOvqjqA3eAo2XMuU36PPRZmV55rBFE=;
 b=ZGyA4YikEVvtvisITt+QEvsznyRInBvHKH/hQ8565yKCm2MX4vpOLKrgD1sxh5t9YZh0
 kYmbQjbgNtFGzvGwl8xtXFSKSrP8+yMsoduyDvaajBbpgBjDN0mGUYYZpNExgh0bmUz2
 wavlmBW9fE/fy3/O3dlLc03edUsgYmPpienuKFTyT2LfRlBZMNzeo+2/PN/SmrnRHd2t
 17tPBCsvFqdCFUnuFAi0hrOerIwkhHEG+gur8spcFVLE2AiiNzPs8DlULC3Elll4+q0w
 UdXiOIhpwwsvb6i4azNUPSSo8QmOLGSqjb5zI1ZSyvTIrVG6j33wA/81kq8FPSy3Ek9r EQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn90qqq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:17:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MBimc0006828;
        Wed, 22 Feb 2023 12:17:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4d21x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:17:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mo3WTV8jqiRhcVnEIVr8pQcohvy0VX7uqveJVFhVW1AQsrJz+8xITOEFpQkZOATLH0AgJsM7WH0HHnjJkfpt1Tr+0bGheZmmHPHrre9XIQcrCy3SkBKNVCwadDzmYJWCbtK8qR3jOHABqRuw8NnWc9FMv2hyknd/WSBM0YG3rwCnHFs+J8C/vZ2jtyBowFaLw6tUPTTO28p085jYyhx7boCybQTgbx67+0VrBuDrrEzFLJ3PY1fYnIIYqPu9vT2h6IdwqSAU04VGWf3R1suxfuzLbd738NvSMs96A5s1THT9XsTIj3KvHqVwFb9z0VZXT3OYUkFOTc+eMzCwwrJzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McxsJ7xw8hGURuOvqjqA3eAo2XMuU36PPRZmV55rBFE=;
 b=I1DWHGf/CeV1bef2uwwNejWQ+F5Ei1fLF2JJXwxjjjj669hmZURMJbb3xG6Xj/ulEyurByWws523JChwe0tCDQn1A5MUILwWiOcj90uhj1XVlctNcA82Fy+xhGUeWVdOmS82MFiNbMwTsHosIwhkpKlBfnNa5xYE30ObmQ1XwcAsuXe7O1lzGeUUZCujqgEZx2fl2fTZMO0zTZt1H43xrIEK1e6jy5NEfbTw6h2J3hzwZpE7ObIKCIthDNaks3z/HwBQbEW0Hbpa8a1wye8c8PRtkZF6ws1SlgV8q3Z4UoTUMWW0TOh/lgVNbBTkJT9votc6LN5dGkIOKrQ2jXb37w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McxsJ7xw8hGURuOvqjqA3eAo2XMuU36PPRZmV55rBFE=;
 b=KxRgZXoGSm4xoWUC10NThVXb71pJMGYPDq2UiPD3zryDoPDvtIaBWzbOt2HDU6/VoYBObHp3dJRDe0rRq0DzcTvUT27RGAk7XKUAYHLx3/CB9a2dxC/AYsuIeHvVFhbMwwvP2kssd0CXXT8i281wqy/xr7UIwQ8n/EF+emmlhqc=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH8PR10MB6412.namprd10.prod.outlook.com (2603:10b6:510:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Wed, 22 Feb
 2023 12:17:01 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:17:01 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org
Subject: [PATCH 26/27] kbuild, phy: intel: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:52 +0000
Message-Id: <20230222121453.91915-27-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0042.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::13) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH8PR10MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: e6dba15e-52e2-4f10-03d0-08db14ceb3af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRk45MYoFv2S8w+HRg8Gedja6EZF3OI7Ortivyzx++ggJgYXG+y7lhLkzLDyNOQ2Fv+M1yaGcEvhZ1JVycFW0fadjisa4g/oxSDLMz+nbKH6C5kNDXx9jmvFb7XUWMFyIe8gNRzpWV34hipQKdAi7dBESRzIa0syJqR5aQhfsZvLXWznLjuW/loPwYO2AqVwYwrq1vDd+sdPadvTkB2NS5w/U60ctsbwuYHrwZyOGX/vewBkSx92k4ltPY3g6Lv9kU9IhOtO5PQr9f//r4WCm9gGwfhIGnZCgh/nRqTFY+ZJ/pNU/o70GRCCm472hznqrnfQ/mmlLTJwbfX3gWx1Ishq5Nmj/RI1YjIsxJDs34/Mc/Ez3B4rQy3dI0Hi1Rr/KV87mJ7mC56wtT/FLXadks00IAavym9RCgxk9XwrUvckdJ/QJBwNoUy/N1fhRn/tIUwzzr5oh0T2QW1Tw4HD/5cboiRN2sNeDPpxxP1gx2KoguilBE81LmGzXjPDiQgCZ6zDRYn/ZhyZ3lQyeV/O0Hi7lItnZw2O09Si0QZlDFMxSdvBastAQTiMH91eiL+KlHHclTR36A2qLplXo/xOfCn9nLuTvBge3YTybhdvE6xjI/KagM5UNqQFi84VjYe0tlsOeASE8oDXojP6ODTfaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199018)(478600001)(86362001)(54906003)(2616005)(6512007)(4326008)(316002)(6666004)(6486002)(1076003)(6506007)(186003)(44832011)(36756003)(5660300002)(8676002)(38100700002)(66556008)(66946007)(41300700001)(66476007)(8936002)(83380400001)(6916009)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tqnB++FQfFN8JlnQxLlDmbQSu/+/nwcuoxIhFxcM+OLDn9TTVAAa5XBA90A+?=
 =?us-ascii?Q?JDtc9V/U/OsxuDhdRVgaSIaDpwdDSlNIsovjrxmmTHZqRhLnERIhPy7sEC0k?=
 =?us-ascii?Q?q3hok4HcXl5EG42kK1y0cWXR4HUsr9ueFVfboRgB9cYj6JNrY/FS6Ewlui8Y?=
 =?us-ascii?Q?o8I7TaC7TK1pvgBshP+MYAtCRvEnH2icWXT/M0YTlCWZsZli/grfpqg9MenN?=
 =?us-ascii?Q?i6BnVjJnpuJLncqucRljDvLHrq7l+zHIlbg6b3zo7PP14icznCyK2mIhzjhM?=
 =?us-ascii?Q?cU/vuPrS98aI+uAw4FLhS1gIs+gjqTD3UMRT8Sz8EaIRZoGPMkJsEKggXBdx?=
 =?us-ascii?Q?phdR+UMY1ZOSuxgoKlgCubqS6Q084ewiV5S2XZZbwQwEZVcgAt6MGTLPyHF9?=
 =?us-ascii?Q?mKfgRyGVzDWLGejImeVlOJGwdmJis/zv1rZSL1OgckxwMuHlEuov6pOQ0fx2?=
 =?us-ascii?Q?Es33SM8lhIggupWp7ecLbBwrcc9NLmJuLXYeusHDEMZNNMLIEWh3vUl2EBbU?=
 =?us-ascii?Q?x3PlN7IdT7RccB/UoGfu0AGOE3DBEVy7hApJNb+yX3S/sAtC0Fpvpuu7KqCd?=
 =?us-ascii?Q?3Y5tC3H3Ub9nHKiusoKErjJG6HnORb5xxF7IS/82empkZHx3cUvc30700pt5?=
 =?us-ascii?Q?YpfkMiAYcapcusLOD8TdmAJoRJlMubMG3BVeXcwwZR3nwsPyWtCkc524Byk2?=
 =?us-ascii?Q?mlw3pZTlIPXlK4dNL4mr6gBsSs7hk7Qmns7RYQlYppvY7F1F9uqY0XqfcOkg?=
 =?us-ascii?Q?6N2OJi+wGBc19IVNlC1fxLzMFpv/o5opusGuIPwEc5Piu7/5SH6lJ1bx4Xue?=
 =?us-ascii?Q?/PbVwtCRjMBvunWuIrS61MnrU7OLuw6rSnkPwoQRxtkS+uYpIJUcNxiIt4C4?=
 =?us-ascii?Q?5pkUjaBYyM2qOiLhydkVZPOl/nlSNc4XvX9ky3iqrck7xzFze3MW+tBb8g2l?=
 =?us-ascii?Q?aoPg2bAhocjbmcwKezPToY0nkVgfSyKGSJNzYMnBtr2NjlNfnLPVmH2awloh?=
 =?us-ascii?Q?4F7OBHdhKMZp+3Njr7/HAcc2juIe7C1vmavVgHq1oHkznn7o9pf/lJ8Es1mo?=
 =?us-ascii?Q?kIQA1QTg+0ytWpYR1QYemfNMBNWGsI+bSs3nn2nlyGl7NzsXeIwDl9efCuV+?=
 =?us-ascii?Q?eQujG9A5T7zpUYz7feh17mHBcg6dFAwevGgAaJ9IIpGluO9sGaV0M+72MLx2?=
 =?us-ascii?Q?hcMqL4Ns44bW9PMZ7t6yN83EpqjJMaUimMJhezkD1ijk5uk5Sm+DDGN7Ralr?=
 =?us-ascii?Q?O6GfcFuzby4mPwiprLu+puzeqJ1fCqnE9L3z/+wW/u3Zve2tcMrwmsnMLoVN?=
 =?us-ascii?Q?eXeh8nAGeIn5PFrYWRdSnXYtTRUXTkubxSZxocAPFn2GCh7vGRY54O4RdfzS?=
 =?us-ascii?Q?XhvtC36SjWjSyoGtQzlmkhHpx6AQck/UB1gYN55eMD+dqY6QBusvoJj2KAVj?=
 =?us-ascii?Q?XJKFS0ylEmbtFBF7N2LMD20Lrm3PyNMgoTPWMn1MjUuf8uv8bMNf/aEJm5Vy?=
 =?us-ascii?Q?Ub8M8PvSCQRNpoPAI8oa8nu0RMwu5ynPGDaFeg6PHysZYDDiCf59tkGCEZCe?=
 =?us-ascii?Q?uvTdFRElvHEoLGvmsJ1Acj6DnjyFnRvqIHmmmzjyI6ob/jli8LqBHaSmoB54?=
 =?us-ascii?Q?xH3NP21mxUCHrSQr0MFdMCY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ewgU839TBodQzdAHbMvga6u0QmvdQNZ49m5+xMQjG4isFeQr+91Q9Fn2dLjJq7/gJc48egDhDHEd4KhQwPnuqA9+Q2k2E9GogeoeirYzz495m5nB41JzOH6SYFBAo8+X89AQnOq4g294l3PgpL01qxR9z4c+CiBsIQyFljBcGOH9bJJTmP93/X1G573NRgmoOgYXJ39NZwordlhk6YF+3W8uH2fFbpGtnV1PqUMzKlmWSKBk1DXYQENTElKuG8NPOzR5RW0EldouQxQ6k4ic5etZsB5dOYro2CahbU01jooOr8o+Ww1Y5gYgdfz9KWiqWRI8NxweK6D9ybgoNH39tw1b9xAWrsJmifJuEwElmbKmCxlwzPbjjyFKVEnDOzEh7n8pyhuGkRXICRVdX/k0FEuuZV8DST95fcy/BjOknETlXV7iYIO47gMUOcX7025bJB96nNEIQb4RaVKTCrjW0NSR5DfKRashwSxbbnBnbRMIiqXhDnjeIl6WpbL0bzGepaMLjwTsG142B8oF5IkYSCxwVVhFzmuCWEanOFQN1WvXf9jdKDyh7uV74SsuhAhiOhpdPusTY7TE47yMaBsNOOlx8ioAM7d6tuhzEvpqQnPqScQvrTu5+kJWdcUTuDYr+EJI9Tv72s6wowzPVoGIu0K4TG1o/eziBhDjQxtNdpEeCFUfuE4qQITC6TTyg2hG/5raByZbEL9FD5hCXZ1uI0d4H0Sok1u1uMwjq8vS7fofgBGFemT5o/tEvPoE+fne9+92umIccIVU612oX4EKYIKvx0VzvHY4bpPhzlH2xsHJyNCxEU1+YHH3Er0wwUwe0Cz2aMoLTX4O5vT3U0LRCpLSI4Ilw0W77rmJeuA8KvTGxcMADNtnFnVRBFo9zM2/WN2lhrKXPS61U1iquViau+KLGP24HiQxi7JikhPy1RI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6dba15e-52e2-4f10-03d0-08db14ceb3af
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:17:01.4717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRkRHQNf8UIbJGeVrVaOqy+ERAtPEi/U8Om2B4kHipdAwCA+S7TmlV7yQQr2Drbg31pwtRDDHbvtdlvCuMCKoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220108
X-Proofpoint-ORIG-GUID: sSmjl_qIziGg_7CNEb-H13KwTtk4Odse
X-Proofpoint-GUID: sSmjl_qIziGg_7CNEb-H13KwTtk4Odse
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
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org
---
 drivers/phy/intel/phy-intel-lgm-combo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/intel/phy-intel-lgm-combo.c b/drivers/phy/intel/phy-intel-lgm-combo.c
index 6010e246d52e..8c764c457c1c 100644
--- a/drivers/phy/intel/phy-intel-lgm-combo.c
+++ b/drivers/phy/intel/phy-intel-lgm-combo.c
@@ -616,4 +616,3 @@ static struct platform_driver intel_cbphy_driver = {
 module_platform_driver(intel_cbphy_driver);
 
 MODULE_DESCRIPTION("Intel Combo-phy driver");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

