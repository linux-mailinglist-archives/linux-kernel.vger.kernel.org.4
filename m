Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915216B1250
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjCHTpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjCHTog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:44:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFB6C0839;
        Wed,  8 Mar 2023 11:44:06 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HiWIH009743;
        Wed, 8 Mar 2023 19:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=mXChXz66VFCO9PeiPmuD/uxvckWbHKEY4Hfdreocadc=;
 b=tFUOVug4iRQb0A5rj8qm/CCFej6Lve9tugNyVdhby7SkXCA0ZBH9UUeRG6rJkpiOF/cd
 DtCoRmowecSzbsKbXMelbgZZPjNcV+Q8PNDq9wQUrsUeuxt3cLmgrCOUkzjrX2nsmRZE
 RCPOgOK3b1WGPkQgD9jPvCuocxkSSmyp0WEdTSJBqOh9GcbBgLg4p09gju48itEkiCQr
 tiOXIjVw+Xg568k/+EEqM57sZlCfY1uz2amDra55fCljplBEXazkwPAiBFU017cxv5Jl
 Wz75XyKWPWoHH9Fi1jjIH9neRbjOqZnaBlz32jeSZNNOByLzdXJVxDrNinl13kP7HEon 2A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p5nn95cea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:44:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328JB8EU015264;
        Wed, 8 Mar 2023 19:44:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6femr95m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:44:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLtGwUZcilPqQN5VyboPkXXmwAn/8IHxBjN+Ocj9jmgu8IOG5P+F+Mbj8vbtLPpY+Yemgy+pVTWRLp9nYTjS1bPFZVysHWVsnqdmlelRFNBCwaMS6UB3NyYCy8C10SKGtuvqiAiLW9y5qT3Llyi32crKxM9UQYXTPeHRbIUE0PtwqyXCTxP8JWIHMZBCYRKsRZ2VZ4DSLbnpXnl5RBsmpEiWyo4MS9Evv9dptF3gIui8WhDDY8nk71A9Gln78TahcwDuLlng7CQ2bs/OEAddl+hY3IR6zLLpXy9WMMKOUTzBCELTbUNsae58yeEjEfdwgsUfm6U3aQo/UeY4n1pcdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXChXz66VFCO9PeiPmuD/uxvckWbHKEY4Hfdreocadc=;
 b=Iy/kvw9XqbmebTfS8kDD6bzcON4+EjkPTPprUqGSG7YAs4RzgbkIjZ+drp6YE+CHZYKmk/lme2/N0AHrJT2ZIV9ARt8BdV7LMYT9pdbLQiyybmJ7wAOM8PuvB/tH4j2iBsWhJ1KIOY79olcFQGOzrL3pOZq7Nvx3IwKGOk7/xejI25r16B+OhyBrxFPLgrCPFK7vJnKlBDxov/WnWTPmulh8hIU1qJAvctBfNpm5yAnAgzjkLxtHk/olj8APKTlT2QL5c8Es6nMG1dbfMvP4+AIVppb1zngeqWIDD/r2Hbih63e2Yu036rOL7Rb96mLKzk7fT2dfPcsIK+WxsO4bNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXChXz66VFCO9PeiPmuD/uxvckWbHKEY4Hfdreocadc=;
 b=DrxgoMUJAZlSF6H9xGv2+whBLbdcFHY8l6a4/jqJFzAqeEhG/w1b5TsvM6+fYNEQ2u0cl+e/hOJO+MGA2VYe2catY50O16p91L218+O+YkwTvaHCaVxweWmxDiVvwSrXlbhsSEjKUur6N5lZjZPY8rAqKodNbTs+/rxXZFGgPfQ=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB7034.namprd10.prod.outlook.com (2603:10b6:510:278::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Wed, 8 Mar
 2023 19:44:01 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 19:44:01 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     lee@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/18] mfd: tc3589x: remove MODULE_LICENSE in non-modules
Date:   Wed,  8 Mar 2023 19:43:00 +0000
Message-Id: <20230308194307.374789-11-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230308194307.374789-1-nick.alcock@oracle.com>
References: <20230308194307.374789-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0507.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::14) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f165f4-855c-46ee-9f47-08db200d77a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZPacPagJIeujnrGuREnfXyrh3toLAQDNZidNCXlLfRKvO0v+lClysUGy2MXl4BbmY0h+sNNbwPkpdtKMzkgxN9XO5qeOZNpkt7Mjuv+wnq8CpU08tEFBwYIDvQUcDrq40rMSpqpb5rVaV6t4H/hFE//eWBkSqLeEmcEfpOVaiSRfqSob9fDcUZeAX8QsNQJme0OfqbLk/gXaLa/f+zZwP8wTO86AhiGIWhXIsyDqkd4uh/BJzIuVvO6fNIgF/vVK01v3M20WdUgoo4tiv5trYBT+766Wbk1xtrKpI/1TiEAh7ulrPwDqS91V46j2FnjUnrcebO1tlbUFOi/vooX8ygQlsWoEPX1g7glr3c0cy2sKNul0tvwzz7hcqEKQ6IuIxco9T4Prdhet3P/BH2ChcCVDEoaLtKVgvWgyD1rbHEi/YKYRYPTEskIW7hdtheDJp0CL5wpgCNU8vCfJhqXqvi35kVLQLamMHH0mNHcrTmpHzoq+lur5D3h4SaPkRFwuWTssU9sBtphehZSnouw1wpm71dM1HS4s0j9apuIU0IBscZDQV83n4XJ/IwBcPaXQJFdbmk4X4cIwTCtdJPhh4cq9E1zc/lABhu+g00qrcmJNqgqP58lYTuOgE35lJQianjZji03i6/83+ACGpT4RxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199018)(44832011)(8936002)(6486002)(83380400001)(5660300002)(186003)(478600001)(1076003)(36756003)(6506007)(6512007)(316002)(2616005)(86362001)(41300700001)(38100700002)(66556008)(8676002)(66946007)(66476007)(6916009)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qKfcI4cHyOrfbbLsI/YwfgRAex6/ZZvXveenClUxeoZZLbmrIHHuZL+EMhdA?=
 =?us-ascii?Q?iKA7lb3xBkEVsP1Bk3Y1OxQZumuyfXfRThosJmlIcRTPqHQtTJSYa7eYnHQE?=
 =?us-ascii?Q?cnLiWQV9T2VMD1p9F/80H1wBCLwZ3//7WM+MId30QqCVDtldK6jtMfq1D9GY?=
 =?us-ascii?Q?YUu6XZH7bckAN4PFHR/ZKTvEoPAgbUvFy5twil1QsreSxN6Pz0oDiHGLyCJX?=
 =?us-ascii?Q?MM6MJ8sbmfw58t7m2DB6aLxk6SyhaHxL10b+BUnv4rabvCoplLg3Ux2K0jMi?=
 =?us-ascii?Q?dcwfhX5sfS0tp2kep43OCOm0wIdExR1FIUrWzl5VsayxIycmUkLDdkXLHsOw?=
 =?us-ascii?Q?uIva1jBuuyUcjniLYUZwxxtJYlf9pRBhvfnejF70JSusjzDivCY02DqBYFA9?=
 =?us-ascii?Q?j2RzRD2+AAgliU3ADB0MXJ7HM8nfWxOgU90e2UA5T78W3/Qrd7jdjf3c8Myr?=
 =?us-ascii?Q?JLr8QpCRlpSssUjE23sDTQ5Um9hUbHCRZvlPLwGOPklkrzbcscEPtWDU7bWs?=
 =?us-ascii?Q?D30v8n+ctRja1ajOY9zAoyA9ytlObkzmojMCEowYzNUFPryyGJX2rMCOLbQR?=
 =?us-ascii?Q?CnOd6R1GE03tS7s7qpagfqroeQ+/pr8g/utfL7XuUVFhBZ0Efhx/iEpsYhul?=
 =?us-ascii?Q?IECbVres/zpf7E9frqYC2D37rpa1n9w9rFr9tJ5dCNa8UPyqC62J2+nyBY+O?=
 =?us-ascii?Q?bHis3D2zwrBR7hO9AAjPHrTHVXXCXeuKWt3w1I7xuT6+L3whha/+Zboqyqbq?=
 =?us-ascii?Q?tsgng6bKDWp3it5xq7OopCGEUUxaODhu6IfFUjRv4NG9Q4wx406DOLE6Dv1Q?=
 =?us-ascii?Q?X3v5qiqtHmRxHGdEvypYodOhStQ6Ua/CzocTIxde03SIPmFHuAAl6vJkAES1?=
 =?us-ascii?Q?L2SoLJuvS/BU8r2XwSmSaWXBjBTzhdLqMit9mjCcmRftRlp8rV+DxHxI52RV?=
 =?us-ascii?Q?qe8Ho3fVKXsvrCDtL/HyzsZhrg7FGAtGYg8AbctSnVKpljLbp6AZYjPT6Dfl?=
 =?us-ascii?Q?n2ML5Yt8V7HxZhyw1GvxDuMYWp85SMDM1mpylDzz0cQIT4hrj8K+me11dcr5?=
 =?us-ascii?Q?dpeXDw+ext0k0TesZKsOw9GCczqQ9j/mHBMkjas4q3czftkWGlcZzOMwfBld?=
 =?us-ascii?Q?1F7TXSzC6KuWJDdTXZV9y+06YkeOlbJDdvEOrGVggFRjYHeOHFEGzplAJLA3?=
 =?us-ascii?Q?NVEslbjk9PO88pDwFPRFp0Z9mbnUkh+nUHVoClPv/QnB5UFpcX9FXHq3wwQ8?=
 =?us-ascii?Q?uxSRWjQ3ik/6bwfSu31WDWgtoY+IXMueJZvvZzlOOjnob23TsxGcNeDthfrf?=
 =?us-ascii?Q?l/jwyZ/a0xWQ+lDxzHEP43llseAVJuqS/fZKvlAqN43EiEojuYWdv6pkeZQ2?=
 =?us-ascii?Q?nKTLOj4ZbMSMCRBkGghfTbEzhlZ/v2lupdzQJg5TF+5qJJWxB0kuNVJ2uG4Y?=
 =?us-ascii?Q?SV1iak1z7YpPwtO3Q8tMwgnDeUrjJYQ9/Ut4X2A/hD0WnMAugUBDaZe+JA6A?=
 =?us-ascii?Q?9p//l9yHB/77YcJzU3HUUXIP4IXMebPWRoRgQzseOsw3LGAoyDlAT7Jrw1mN?=
 =?us-ascii?Q?KSGqAhXVFUjs78rfC+nK+ZI8F4dOPxAHZWR2GmvYxzd/gVL/DmGdelQqeHk9?=
 =?us-ascii?Q?QwW+VJgx92MrDGgZCKvpQRw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XPQ1TeZ7F1yjmcviAXjtzdBK0n0jx+UtMcQbaHRB8z6xFnud9RwuxCwe6uQ2tSUXzWUKL/amBMPgtQfXQhR6krUyrKNseLu4Vv16OPXdVD13WQGsRimmbZdA4X+YZngL7CZdCwZY0lN8JQtUZxq9XSp3UTe96gDLuL3ppgNo4p3AGMPa9mje44rLWLW4F+kcWsbLnYyiXIYI694cc1VvQPKAs/lGqN5c5YIBbFWZP0Tjd3bTyedfK6eOTXK26SUcCjejOlfnlXmS7+3x0dvm+RnUj0RUC3TogIvwMAus2nj5pdT+mliRCKLYvv5vz6sk+KPAm6/fiD6dJt+vVM5B8AjkRuJUD2T4R2BKW+Rqpo7O61qeAIvHfeZpuOqy24DtZ1ykAHMjoA+isaRDDOry9ei8ldW41euMl2oeb4E/FlpKphJ3gIBUMAROgJVFTbP7I3UtJ01jpdgMZD3AM5KrxZE1y3cdNKFbTO5snMc8jVLaq7BLACj+Nzm3x7UYLnBa6xGPiXwDZO13/ogiugVOOURf8yx2x8ZGI1YQBboGYUAeTtSNAjdx5KPHKrJ4weFVD5gBG3hw8q+M+wQccDH5tmEdh87lLyIGgm8W1vtzfXJBjksdkcbKvNX4WZ/S7NqxSM6n7aQg1l068VwAT1Z6Z6EjuNcZ3BBhaGRWHyP6Z0VlfGcF9oS1LzaUw1mtk5IQ+VuL/A4N4ABqDP30CLNbT+odlidlSTvkNB4kH47900NVakZu2Fn1z9f+Z+620bmvpzGZKLizyuFld6aHOcWKtIF1o6gwt5CueyLKR8GHzCU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f165f4-855c-46ee-9f47-08db200d77a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:44:01.8263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: piE7EpExju7gDzUp1fL7DUNZKlomy0APd824yxh6c3bobgo+tR4kcyivxrG0A9NYMrLsf/fDgVe36Ljq1z5hyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_14,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080166
X-Proofpoint-GUID: LVm3lJCz5L_JiUCx3oQYJ7QV6ryHOc6X
X-Proofpoint-ORIG-GUID: LVm3lJCz5L_JiUCx3oQYJ7QV6ryHOc6X
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
Cc: Lee Jones <lee@kernel.org>
---
 drivers/mfd/tc3589x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index 1f6e0d682cd9f..cbfe19d1b1459 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -502,6 +502,5 @@ static void __exit tc3589x_exit(void)
 }
 module_exit(tc3589x_exit);
 
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("TC3589x MFD core driver");
 MODULE_AUTHOR("Hanumath Prasad, Rabin Vincent");
-- 
2.39.1.268.g9de2f9a303

