Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EAF6EAC1C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjDUN45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjDUN4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:56:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292495251
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 06:56:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33LCYYre006655;
        Fri, 21 Apr 2023 13:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=5F/Bt3x+K1203VADB6V9nMCJXcerC4oTfDvth6igwBY=;
 b=kC6FRTPJHPKQoqSqI8DU9K6s4/ReqjYyn+W+oxCeOdFZYU/o9o0W87UengcdjtSiQcJ2
 D7UmzyHaz8NDru6MG1n0muhc8Z262VlNG4bQIIHsp/Jrrwmu1F2Ubi2oMMndNKiLF5Qf
 8YLVkDQ5DjMg5jG9ldGeTTkgMaY9Nu+fTqbkycvj5q5XMm9cMauPGDkxpFSiv7TuM1c5
 ghtltpCyXC5xmVZUICZtT4ZMfutLYIZgfToMeq4Nl8DT+JHXH73QS+OE2AGedymAU4tQ
 Ft7stj2by7of6ytMKW3QflM6IJOti43oPF+KqehBLFFXjEjhuYtne7+TFOXbmXuqITnm 0Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykhu5b2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Apr 2023 13:56:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33LDLLcr037785;
        Fri, 21 Apr 2023 13:56:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc9n99n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Apr 2023 13:56:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Te1RK8Fm/gsm99TfOe7HXUMWCOCfh5C63h0NnQhJu6yplm7XyLAQts/MY1+WAViQ7vmK8zg2dc0Z8kNbgARkW7B6tuJ2bfyXTeO0lvQn/JqjodethcAVgZCdYabUCQWhqR81lmCOGm/szOXAmkgPiqYP3YEiAJ4yVPXUdNsUhMFZwgDzq2VcSjpLf7GYA1FQGpJsutCWovTYLCBA4NXSi2RfLffugAm1Av4+mZ5X6W2Jy7ntBLmrswXWDJ0OskJMcWkf/olUF6JsrzS7FNezLdtSb0ifOJ/dj+Hy5TkJBaywr4+osqLdyIBpGBhwsSGONdYHTUdS1VFiKrjOEMNRKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5F/Bt3x+K1203VADB6V9nMCJXcerC4oTfDvth6igwBY=;
 b=Aoie/MBg/OKC5i0w5CCJM7wA6ifeOuc7EClVg1SbK/2RKoOUlca/VtG3PT1NGE+iKKtkIF7BoE34BZ/1EC46GBLJEqIPGHMlmOQk0iD11hGzvT2gRMv/RIoNZVFz8C4X6IKDW/PyUDYrX9ylmCZ6ib+vT4FdHhE61BrjcWZC4WjEMSnxaU98ibIAKgdif8yHjfAY3/sloy60is9QoGPt6miDPLCG5AOw95cAUbgRK0D/ucb8yVSJSIRT5oK1csB1BK5nXWhYR6HDB1KqXfAn6P5Nx2a9U/BAUUa2LTjyDdwMkIxapQBhwKNewjTUfYHe4dxjYgZSdE8w6LPUaLQxsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5F/Bt3x+K1203VADB6V9nMCJXcerC4oTfDvth6igwBY=;
 b=fsF9hU9PiFktzwL96H1fDoww5IAGusaR17zHwjkuQSCKIm4MuH8qBTl3SHk3+qNBEI8dWSLbJSWtFxg4K0ShmMWJxpZ0a/cW32NaKH70A4QbkZHK++7bpaXKx+fvAFWxd8cmm/Xa8xt4xMcugFBBNCWTKqVVDghEQAB/bS96TRQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7540.namprd10.prod.outlook.com (2603:10b6:208:445::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 13:56:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 13:56:21 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 1/4] maple_tree: Make maple state reusable after mas_empty_area_rev()
Date:   Fri, 21 Apr 2023 09:55:56 -0400
Message-Id: <20230421135559.2163923-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421135559.2163923-1-Liam.Howlett@oracle.com>
References: <20230421135559.2163923-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d5221a-4acd-423d-e990-08db42703053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z8Us/q+D1IJJCmx159B4nLNkzdm6tkmn+IxEU+bzMkkNMIxs8gR0pS+SNXFkZ0+/+mfSGiG2IcA4W5zwRa6eJh3szO7RaEt0Z+iRR9ewDL6vUI/Raz2u4etSNIOufwmyTOGc5tlLIfoMAvutYEakl/ND4Hvyn2vzi4Ybmr5bXXHHm0ejqpvm/5kCcDh0gxw52lSYtyrn16T2zkUD6whfZ6Bjy4V6n80cVMsOTQ40WaiQEAKWxWCO6CPSbNkC1MdWvCoRN+3tUk+cGAsmo//z47SMg4SVlVPSizoiCAx0XfDNFzRlTGmv/N5w6O3fFxQ/lx3/l2NgZkN3/PZAvcJifV/kbPeD5AwWN3zwaxorOVCN8F0vWDFnu7Ka8drtylG6Vf5nPPM5NCACtibgSKP6ax/xejfyV8pFU28i1RD9LeT9pqN49w8M8IfEBmHqC/mMOFa1d9yuYxxDATnjXRV1LulYFc7SfU8+ILvGTd+VKtNf2haj7uNYqpKRZXNBROpExhed4rjk2bQLbSzZRB1ElqJ2XK2hJKCqIGtXDFFrma9J3PsYlpioKLDrQriz2z9b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(8676002)(8936002)(38100700002)(6916009)(4326008)(66556008)(66946007)(66476007)(41300700001)(316002)(2906002)(5660300002)(186003)(107886003)(86362001)(1076003)(6506007)(26005)(6512007)(36756003)(83380400001)(2616005)(54906003)(6666004)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bfq/Maaq0p+GzXJPdtmbVDyeR/DN3FXExlQYufhm5rJ6bgvqBFbhFU1UGmtw?=
 =?us-ascii?Q?cmXQ8RnRdxXjozBBrzCS5FL/UZ0Johxjo58jJIF8ityEQRbiwZwWgUJjdfpc?=
 =?us-ascii?Q?Va9AZlHxwRMQ3nH26lydHN+b3RVvCVdePMUzBnbYkkcmyGxsY7x8RcHZQlIE?=
 =?us-ascii?Q?3aMG/FschrLDxzdjTMLHx7dSiWyNusSnraWcj9q4TE3uDg3If/9Aae5OHpOP?=
 =?us-ascii?Q?UUC/jL+akb5cvgkRXjEqlSepz0rqwCFUNinNj/2HaSXpV2ycBDMKiZIBErFD?=
 =?us-ascii?Q?r8HSQ/WHQVC1TYfW5+pX9VmYDR07rGsGWHc1lAamse4w4ptA3hPV8VEKCe1x?=
 =?us-ascii?Q?8sZz1tZWGbXFmZfy2pvEd3OqtXQaDX26Xu3uxo6Z5Dbi/rbaGerC+7CKOodL?=
 =?us-ascii?Q?Tm/7TmBb4+RycyvzEIjRMEtZlw5YmP4DqCOP662igYdy4L9JuJ8P1RjC9Hjf?=
 =?us-ascii?Q?ab/GXWixdv5RV8UlO2PfaKr6Se1QCQkuzjZDArqGobS6qa08Ckyq5DZh+cWt?=
 =?us-ascii?Q?J0IkcrSpBZ8umGCwaGmUagEg2UJcS0aDdIvO5E9t/c2F30P5ux3U2GPeX1e+?=
 =?us-ascii?Q?QBMmeefY2m330Qowc020xjiWmNVK497FwLoIyFTXgh6M6MECjQXg2TJ8t0Oa?=
 =?us-ascii?Q?XJPaXFCSFsf5l5LvKqXU/Hz2VtILreLL2QNJixWLOsmM+H+l5UqaE1iht+nr?=
 =?us-ascii?Q?dtW397ViLAcXOfowE8RW2187uOMnrNerWCS7TVvLgmOQuF4oom+2i+4dA25w?=
 =?us-ascii?Q?TuE17NpWe7VsXuf47ciaXnMRQxIPyWPpkSMK4PFsf+6+/vcBp8L0oW3+6T7D?=
 =?us-ascii?Q?47u5X4HSWMxbe4hF/Re7ILSneqxyKimR75Vzld+CaTl+qphKYPMnA5VcdhK5?=
 =?us-ascii?Q?ulvZJ/e1Z3afaSqf04B+J+gPrPS/qlZ1dZbZ7oRG/rkaOTiT20ISAVqRfJUp?=
 =?us-ascii?Q?7aaobMUk6HMwmmU2yz1vRD+cD4TRBc6/AR4Lt+u+J0srBwubE4yYtn3FMKAk?=
 =?us-ascii?Q?DyAjA3kwp3VNT+yqFOemf2ixRm2zE2aagAUEa7TOz12NQ90NX3Gp12DlRadG?=
 =?us-ascii?Q?mQa/dRiyONacY75fafKnpvZq4B47+lxXn6xmhzxCcjicWK+OCPPqsabJA4DZ?=
 =?us-ascii?Q?QGGrJVAIiax9EKAXyE2NymVS/6cHA93ZdBLd7v+Cy51LijQ8f5kIzwq80oI5?=
 =?us-ascii?Q?wCCjmbyJvr2ietBazd7cz63InuK2RsINNSauVQp7ipu6g0iO3LLRwSj33xJ2?=
 =?us-ascii?Q?LGqkFItt0C647GeshKmaZlzjSEiYg/tGEA5B88pTg60ngGwn9hpaubUrvCf5?=
 =?us-ascii?Q?ZuNitgQXfp3wDBDON+4Ez6uCumjVLCTmvt6RdwB9J0+Pp2b/AKO0nKqZ5gJL?=
 =?us-ascii?Q?LwI3CieBDKrpa0Im1NJxpmOIkUwwkyoi0turh+9uwP/GJ9xO9gRwcm5QlNzL?=
 =?us-ascii?Q?5s1p6Sb1VMAfbkJV6vc4LIvkdxeeQFIhQ+p6lh7O1lWZMDT/oqKxZ+VW+wjn?=
 =?us-ascii?Q?9Y8VTWEsDpixxXhSqUvldAdVpGJbPmkX+k0J+n2xhCXFGiwaG18MtqhnfgDL?=
 =?us-ascii?Q?dhEeKWqF1Aj6GMyZjbBIDiK1HYqN1+6I172+Jqo44YREiQfTPlBKPrLhT3o3?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?EbLDpwN3JTHG0p61fJmq9AZkZFk+X3Vu0zBAf4lhxlpGSAKLr7CbPFBdNUNe?=
 =?us-ascii?Q?rbSY8KjgV4nB2fVAkCQ9AVo1qsWTjtucUa0BKaMWlBqtqnNxZm3tuQcOEtX3?=
 =?us-ascii?Q?QDGlUM9M89p5RRkonSRdbsce/qhfLyVnYZ10B2kb/UL94UL44mHiN1LuAE2Z?=
 =?us-ascii?Q?5dk7B+A+cxK05Jojt7S46Aa0cSxrg360DJuH+MO1g2P12qxpWT2OAyZfxhXX?=
 =?us-ascii?Q?R4AdKadNOYcuACh7L63JOq9+YsdPUzDauAKMFbjR9BJDk6QNnTLPw4tA7s8S?=
 =?us-ascii?Q?e9NaAGB3rQw3xbbH8L8RKZc/TUORo1/lzJSAKpw4emt8MN1ATOGJD2IburJQ?=
 =?us-ascii?Q?30WlseM/a7PZYBx8bOEkZobd6M3GqK80Gi/R0V/lXqXfhs0aqpEackDX0XfH?=
 =?us-ascii?Q?kWoqxHLQCjJulKWNwKb7dRvKgMCicOjDy/12uHRRR+UxmOjo6PJ1rWPfAzHm?=
 =?us-ascii?Q?b9Q1fqSnRBI3nLPAzl2tLlVwrT/IptSrFmBu4JTrFglDlHz2zbtmnsRIua2h?=
 =?us-ascii?Q?Lt1Kb8XyTDx8J7eWl9Ea7DfOIHfAksKA/v3DF7OFgI/MSzfIC+b/zgXYRhyw?=
 =?us-ascii?Q?UbvWTW3JUsIKl3uTWR3mjI2smc+tBDrVVBkiEmP6zXcgLOCs7bfKHu2INMY9?=
 =?us-ascii?Q?hJqGGj66Di+B7ol2GZwor+UfayNU2duyp7cL+NPwqqXGoaVbzaDbvoherAMf?=
 =?us-ascii?Q?/QnPm/Xo0UGk4ESKTaX1OznZjIC8o6UKundMXtGUhSsE0Sviii+zscMcKLlj?=
 =?us-ascii?Q?WNQWkw3p5HiFj3tmykGe5K4qVSNnjK5WU6dO/RHeSnWViPU79ChBvkthsA53?=
 =?us-ascii?Q?dU6f36eQYZDiPByENn45tDBblDYJZXN8+xzHv/cZ5vi+CNH4Dw6JhpyT2Sox?=
 =?us-ascii?Q?5rvBp96WoeuAkNHWlMhsw+569iMENcoS1K+698hvQ/omFEaz8Mv9MV/NZYQ5?=
 =?us-ascii?Q?LcMCUuKBbC6wcgkSlWaP2g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d5221a-4acd-423d-e990-08db42703053
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 13:56:21.8625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WD3iVoEjU+kg3OFzR5BRinRqlKJ8d6K/FIPtj3QBPtN597J+6hkHTmVBYTeg136+TPBDaKMfN5x62dPSWOY7ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210121
X-Proofpoint-GUID: aqNtFYBhF03XyZUJNARd2tSoJb7B5tmP
X-Proofpoint-ORIG-GUID: aqNtFYBhF03XyZUJNARd2tSoJb7B5tmP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop using maple state min/max for the range by passing through pointers
for those values.  This will allow the maple state to be reused without
resetting.

Also add some logic to fail out early on searching with invalid
arguments.

This also fixes the currently unused mtree_alloc_range() and
mtree_alloc_rrange() functions validation of limits to work with a
window size of 1.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 4df6a0ce1c1b6..cf4f6cdcaad38 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4938,7 +4938,8 @@ static inline void *mas_prev_entry(struct ma_state *mas, unsigned long min)
  * Return: True if found in a leaf, false otherwise.
  *
  */
-static bool mas_rev_awalk(struct ma_state *mas, unsigned long size)
+static bool mas_rev_awalk(struct ma_state *mas, unsigned long size,
+		unsigned long *gap_min, unsigned long *gap_max)
 {
 	enum maple_type type = mte_node_type(mas->node);
 	struct maple_node *node = mas_mn(mas);
@@ -5003,8 +5004,8 @@ static bool mas_rev_awalk(struct ma_state *mas, unsigned long size)
 
 	if (unlikely(ma_is_leaf(type))) {
 		mas->offset = offset;
-		mas->min = min;
-		mas->max = min + gap - 1;
+		*gap_min = min;
+		*gap_max = min + gap - 1;
 		return true;
 	}
 
@@ -5280,6 +5281,12 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
 	unsigned long *pivots;
 	enum maple_type mt;
 
+	if (min > max)
+		return -EINVAL;
+
+	if (size == 0 || max - min < size - 1)
+		return -EINVAL;
+
 	if (mas_is_start(mas))
 		mas_start(mas);
 	else if (mas->offset >= 2)
@@ -5334,6 +5341,12 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 {
 	struct maple_enode *last = mas->node;
 
+	if (min > max)
+		return -EINVAL;
+
+	if (size == 0 || max - min < size - 1)
+		return -EINVAL;
+
 	if (mas_is_start(mas)) {
 		mas_start(mas);
 		mas->offset = mas_data_end(mas);
@@ -5353,7 +5366,7 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 	mas->index = min;
 	mas->last = max;
 
-	while (!mas_rev_awalk(mas, size)) {
+	while (!mas_rev_awalk(mas, size, &min, &max)) {
 		if (last == mas->node) {
 			if (!mas_rewind_node(mas))
 				return -EBUSY;
@@ -5368,17 +5381,9 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 	if (unlikely(mas->offset == MAPLE_NODE_SLOTS))
 		return -EBUSY;
 
-	/*
-	 * mas_rev_awalk() has set mas->min and mas->max to the gap values.  If
-	 * the maximum is outside the window we are searching, then use the last
-	 * location in the search.
-	 * mas->max and mas->min is the range of the gap.
-	 * mas->index and mas->last are currently set to the search range.
-	 */
-
 	/* Trim the upper limit to the max. */
-	if (mas->max <= mas->last)
-		mas->last = mas->max;
+	if (max < mas->last)
+		mas->last = max;
 
 	mas->index = mas->last - size + 1;
 	return 0;
@@ -6360,7 +6365,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 {
 	int ret = 0;
 
-	MA_STATE(mas, mt, min, max - size);
+	MA_STATE(mas, mt, min, min);
 	if (!mt_is_alloc(mt))
 		return -EINVAL;
 
@@ -6380,7 +6385,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 retry:
 	mas.offset = 0;
 	mas.index = min;
-	mas.last = max - size;
+	mas.last = max - size + 1;
 	ret = mas_alloc(&mas, entry, size, startp);
 	if (mas_nomem(&mas, gfp))
 		goto retry;
@@ -6396,14 +6401,14 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 {
 	int ret = 0;
 
-	MA_STATE(mas, mt, min, max - size);
+	MA_STATE(mas, mt, min, max - size + 1);
 	if (!mt_is_alloc(mt))
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(mt_is_reserved(entry)))
 		return -EINVAL;
 
-	if (min >= max)
+	if (min > max)
 		return -EINVAL;
 
 	if (max < size - 1)
-- 
2.39.2

