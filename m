Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AB161038E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbiJ0U6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbiJ0U6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:58:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7420979A47
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:50:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RKSPqh006919;
        Thu, 27 Oct 2022 20:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=u6zbU2BSPdZL7Sg8omIRrT53D1K63yIQ9oY99oJNTgA=;
 b=Sw3rYL3G3vqg/fVvu9ZrOHek068Jz0NTRlM9W7cPb3yKm9tJWEq1BHL3fH5+l10bx7dC
 iQqjwJGmmKuevorVAd6LNam8IToNbB0/YF3JB3Ar5V5XrNvU/8fy0UkHjWtExQmeE0nr
 almk3WVtxkIkYWDA6yWyEX/4zjSJdx9BZrzIIg7AhMY35pCVTmUtCjRAK4BXjYwwHi/E
 o3KaMh+maFGIxwDTDqo28CwnDBSYwjAv6cxQAneFHaapMCUUsjoVu5FTe917q4LO3Kk3
 PH/2MciCTGhDC7u0EmhBTdzJQrGRGlOC72AsCcK2zqLwxOGpW7CT5Bg9nhqOK66Etgdn /A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfb0akcjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 20:49:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RIbkuU011915;
        Thu, 27 Oct 2022 20:49:50 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagrd9yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 20:49:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxukPKt/vRQeuAl/G9jKyX+VT8CGomU+EV0gzyF4tnO6JD25znUvVMROwv+AdLr97sNL+gKHhJbb8euI3lzeWLcPReEmKuJwoe226q3T983Nn1R1oeKNVNtiwP94Bwdqxp+yV/iXCpfoCbQkI/ymPBFgjQV/rb5BjtTl5c3NnDCt3A01cgnC8oBlorj87A0+uoP6w4l7ReDVSMyZQzMrkfbexj2gVZpHQ9TtRoLM0LYE8hyqzErBmdEtnLCpjQQ2dMPBiwSBHsVJDiylGK6nxhd6dHM4krW5MDGhc72I9LvPqvTcIsH6ol4CV45MUQl1YcEPNL/kzl9oTMrU18dARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6zbU2BSPdZL7Sg8omIRrT53D1K63yIQ9oY99oJNTgA=;
 b=juwHzNER1wrA1rTEkmChD2IYoTas7ODE6I+T7jAFdy6RjqbJte/KfkZT9Sa1h+z6PwN6titgD6VnGSPSNQtZcjGkJc+ppI35DEYzbyhptvWeIJ5iVTDKsBCUHVJ5brqOUCc7XWgR9wUAUBk4LOFEv99LdZa6Q6ywhZ5/EuiEMeySkYfVgwaKXscYNpLyvDEFnvlYypJqo/8Ix14NKZSt9m0P+8/RpRbTPj712bgSCKPb8x5BLKDplas9MOTDkfPLLey/aHD3tnh20DxEmBK4rRklcdovGmi/90GGv17SC/F7knMb005jpZvFMKG9rZPlX8bm2FoWd1m9HNdcQYqriQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6zbU2BSPdZL7Sg8omIRrT53D1K63yIQ9oY99oJNTgA=;
 b=HchqV+NEUZuufY6QyuzkTm6gYGeroXu63DmCw+4wGQRzCFyg0yYGltrmdlik9kgalhQPSUHw9bLOxXb791c7UYICVqD+YM9TzL7twbRRwqwbYD/znmThyaF1hYcC/gJNfuweIWm5OlOyGvu30i+4L4a3/I6xq9FodTfyncbaluU=
Received: from DM5PR1001MB2153.namprd10.prod.outlook.com (2603:10b6:4:2c::27)
 by MW4PR10MB6632.namprd10.prod.outlook.com (2603:10b6:303:227::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 20:49:48 +0000
Received: from DM5PR1001MB2153.namprd10.prod.outlook.com
 ([fe80::ab16:a248:e8a1:8f17]) by DM5PR1001MB2153.namprd10.prod.outlook.com
 ([fe80::ab16:a248:e8a1:8f17%5]) with mapi id 15.20.5723.026; Thu, 27 Oct 2022
 20:49:48 +0000
From:   Julian Pidancet <julian.pidancet@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Julian Pidancet <julian.pidancet@oracle.com>
Subject: [PATCH v2] x86/alternative: Consistently patch SMP locks in vmlinux and modules
Date:   Thu, 27 Oct 2022 22:49:06 +0200
Message-Id: <20221027204906.511277-1-julian.pidancet@oracle.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0047.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::16) To DM5PR1001MB2153.namprd10.prod.outlook.com
 (2603:10b6:4:2c::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2153:EE_|MW4PR10MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f82a339-9778-42c6-1d46-08dab85cc923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogYJ467FEFS2W1lPpR5kEaAqLeJcBPU1FDACLLwfKR6Y0Qse9KZBgeTBb9LyLXU7iQO5iYt4/u6Q1gIiagULGY2PiOKxfs/3iOszO3woHfQgUDifKYvCw+WoASox1Dwb2N3eJvC0shdnRILZ1cf92/0zWcEAh9sFnG1PdrydCpPA5ldJbIX15YwGCiIeKVRDGrgSk4uQ7KrfIq+UTFJ2TxK5G3YhRJUwEfVor9fm9+O5Z/etBf1X2RmdmRsf1cmNFpcBuMqUDSMyow+HyEV/a9MlOJ6dxpoN70rFEQzaRE3uq7t/1HfOnu9/pk0cUyb6NunrpEwjPXMiWAaIUljLGdB4I76dTknxFJ2FI5HpGcS3jHMA9f2XckbrNFWjGS4t6NvDhoHVx3zMvX9GA5s3BCe74rWCj8+tR5E2WLTJsXga37z7ACti5fS91+4BAFClU347QLRKj0WV77fhpL55cPkSj3BistXMQuQPTBAYcYpkNkgaIrqpCtw2Rlm0VdHDYvUnGjHyCik/SY7vWzn5iqke06BjcvMOi2lUP+Qv4OamcD0sZL9kFZD7GjbdXwdU79EllcpnonsW20jmAGAynBDmhA2gisXtg/rLa0dRSXEtjsCUvqjz9x3DX0iHq+kP3vML5kl3Ec2MfQ9W5VyuOg6+CRhbQWl3apCckcArvvAGnuxZdzYNnT8RN7uYSWNP/Jt4yrktaw9THFOCwTrQQ70Vmrocij/XqSmSSSZzOJ6PdB/SRfSSvz2COGUSFnWfO9wAhy6J1kyTti79iOHZvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2153.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199015)(86362001)(8936002)(44832011)(5660300002)(41300700001)(36756003)(38100700002)(2906002)(2616005)(186003)(1076003)(83380400001)(6512007)(6486002)(966005)(6666004)(66476007)(478600001)(110136005)(66556008)(4326008)(8676002)(66946007)(6506007)(316002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8MZrL+KUOHmObeHz8GE2msdmrCU3G8MpifaiMjVaaC2WYIHgTCVDYIEHoVWp?=
 =?us-ascii?Q?E2ZLkq1XqahH9u0YI/bhEUBlurE+aZc9MIsbhj73FRG4mBbY1MzbocVCGu1M?=
 =?us-ascii?Q?yuaMhsrAPr37/td9QnWovPpPHuEvYaJ0eJKJvakb7pr8TU4+/c6SsyVz6yxS?=
 =?us-ascii?Q?movmBvvlehXsqFAsBOtNy3gi+17QEvuHLtdQpGUVUlwuko8B7R8dTq85y/iV?=
 =?us-ascii?Q?1mryyUlSW5TFJMfpa4IKkqWd2+MBDt5ftJrbrES8qEAvTNJw3u2AJdXmR6as?=
 =?us-ascii?Q?RN/CQqc9vn7yZliw2Yq073unKBwMGNGD2KJnNeIkxPkqjjx7P2d5Z5QbzoqY?=
 =?us-ascii?Q?DOllfQIQ99E5APDCL/iX6+E2E4H0YJ0yr8x+tkXL5+ScQ8Yvgc7/zyANg6Y3?=
 =?us-ascii?Q?HAZ+KNSFfWaBh0ZXUXqXSdyUcRuyVv21PBdzPHi+rBLJMd+nlwjOHOrXbnEq?=
 =?us-ascii?Q?Iz9tTy9ugaCOrnRPLEwEervjcZBTan3MM26hBmOGqf2ZSFDCtnIkVInao4B9?=
 =?us-ascii?Q?Dpu3r405lZG53T6iy/4OGg3ujvpciIA/R9cIsRXdTv1gu1yFKQUaCKimplxO?=
 =?us-ascii?Q?SqXt6xFfx9iKaAIuJtcCkhhdiHwNY2NGTlldzk5rMteF6eGCoXx+L5jAoQSn?=
 =?us-ascii?Q?T8k9SqCMvqVzdEixNK78BzNOQmWNSE927NlBB9UZQ3sND1nnFU5cCMSyhU7v?=
 =?us-ascii?Q?DOndmFhelEgDsNh5kwx6+c6kg+gNIB8UOY0OllZuNRqRwBmF1rCh5bcqbV8M?=
 =?us-ascii?Q?Zq/4TLgmjfpiNQpVaizO55B6eXxKvIh5fGPNNoSwAXOy7VCA96AyKUwQR8bd?=
 =?us-ascii?Q?CY7j4JuFvPKeMyx2cSgXo8ST3U8qVXS139BWfYPwNIqI32zNSi+KoUf/2KVf?=
 =?us-ascii?Q?E7f65fHu+2TsumpS6tM8HjHLorgJWkI0rG0F+ipV85myMqH1ClHvTQLSaVZ/?=
 =?us-ascii?Q?asl0lLS4zCTA944iwLke94vxIGLPhMCaQdqbYPDRi97IPSK0a3tiT3EWAf2x?=
 =?us-ascii?Q?8zYhIy1zHbg8m+uIwH9AnxXoHQinXytw/PT+pevgmxU5+PiPGNdvnKkilmot?=
 =?us-ascii?Q?W1o57sDXp5+I/uu/F9+VS2bLzfNNbhBNrGaMEV9WkskxX9ISpB2QnpnAgm0Z?=
 =?us-ascii?Q?4IvKvY5IZDaNaqGS3Fdy3+kVHAhzc3Zeh6S8mEtam8+tjGJCkaV6JPfpS7PU?=
 =?us-ascii?Q?va7HgVHNey/VQSNMoXDgNIyjlUN+EbZvOAJxV3MC8NdITfTaQlnTwQPf0d3W?=
 =?us-ascii?Q?0N2/ny6ZuoqcF30wu580WDJTKAa51gDYyVW0aVvAgeB5uYAWycxtqqyeHHkh?=
 =?us-ascii?Q?o3J4nzoQoaNO7g1ouHa63GeLuBJf9pKUyU4lSDV6KdtTs/M0ONzCVcpHT1qL?=
 =?us-ascii?Q?lmCt1l60JhAkXXu7CJjqm+27KHukQy0GY0ookwZf5ug3eweXHgFjLwNmgLZk?=
 =?us-ascii?Q?lYLQsVsrQ1ie4N+JCgg+iNU8evZMdbcysNgT/EpABA4ZbfXg5+v63esX+5dV?=
 =?us-ascii?Q?onGUWwr4wzeYhM1X8xGWSNzjaQSiGW1DubeKaLklwv7DPIy89juWicQJmrxw?=
 =?us-ascii?Q?dj8xgOhR+bvGI4ZRdeaOrGsRQnSGTry8uRyfcKwuuQ+eYWgWDcOVUaep2tY7?=
 =?us-ascii?Q?qa9BTlQvkTxw7qysb+tpwJs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f82a339-9778-42c6-1d46-08dab85cc923
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2153.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 20:49:47.9557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dvmg5N6DF72pttTCqE+ynP1VSJ4NXYpqPloDXPlRPUcA74Ez14sXhEqtVdlevJJDaFuhh/LJTJMo/rtMPKNeMmUZ1f2rNgFACtF3w16CYqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270117
X-Proofpoint-GUID: t9wzHz53Fn410tEeyy647hCqXXvzz1QK
X-Proofpoint-ORIG-GUID: t9wzHz53Fn410tEeyy647hCqXXvzz1QK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alternatives_smp_module_add() function restricts patching of SMP
lock prefixes to the text address range passed as an argument.

For vmlinux, patching all the instructions located between the _text and
_etext symbols is allowed. That includes the .text section but also
other sections such as .text.hot and .text.unlikely.

As per the comment inside the 'struct smp_alt_module' definition, the
original purpose of this restriction is to avoid patching the init code.

For modules, the current code only allows patching instructions located
inside the .text segment, excluding other sections such as .text.hot or
.text.unlikely, which may need patching.

Make patching of the kernel core and modules more consistent, by
allowing all text sections of modules except .init.text to be patched in
module_finalize().

For that, use mod->core_layout.base/mod->core_layout.text_size as the
address range allowed to be patched, which include all the code sections
except the init code.

Signed-off-by: Julian Pidancet <julian.pidancet@oracle.com>
---
Public tests: https://gist.github.com/jpidancet/1ee457623426f3e3902a28edaf2c80d0
Related thread: https://marc.info/?t=130864398400006

V1 -> V2: Reworded the commit description.

 arch/x86/kernel/module.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index c032edcd3d95..b1e6e45a5e10 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -251,14 +251,12 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
 {
-	const Elf_Shdr *s, *text = NULL, *alt = NULL, *locks = NULL,
-		*para = NULL, *orc = NULL, *orc_ip = NULL,
-		*retpolines = NULL, *returns = NULL, *ibt_endbr = NULL;
+	const Elf_Shdr *s, *alt = NULL, *locks = NULL, *para = NULL,
+		*orc = NULL, *orc_ip = NULL, *retpolines = NULL,
+		*returns = NULL, *ibt_endbr = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
-		if (!strcmp(".text", secstrings + s->sh_name))
-			text = s;
 		if (!strcmp(".altinstructions", secstrings + s->sh_name))
 			alt = s;
 		if (!strcmp(".smp_locks", secstrings + s->sh_name))
@@ -302,12 +300,13 @@ int module_finalize(const Elf_Ehdr *hdr,
 		void *iseg = (void *)ibt_endbr->sh_addr;
 		apply_ibt_endbr(iseg, iseg + ibt_endbr->sh_size);
 	}
-	if (locks && text) {
+	if (locks) {
 		void *lseg = (void *)locks->sh_addr;
-		void *tseg = (void *)text->sh_addr;
+		void *text = me->core_layout.base;
+		void *text_end = text + me->core_layout.text_size;
 		alternatives_smp_module_add(me, me->name,
 					    lseg, lseg + locks->sh_size,
-					    tseg, tseg + text->sh_size);
+					    text, text_end);
 	}
 
 	if (orc && orc_ip)
-- 
2.37.3

