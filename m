Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7132B610227
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiJ0T60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbiJ0T6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:58:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013E88769C;
        Thu, 27 Oct 2022 12:58:21 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RHnRm4006891;
        Thu, 27 Oct 2022 19:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=iiJCMJoUjqwM83KwK6l1VkMjKa2N85x0ZQLWR7eZw1E=;
 b=zzyRkpmuJSjN+mkWe+bUyjXCgBdk1g9iHLc7rqqqy/Zwj43anR6PmODdfoXevH9suRmu
 Pz6Kd70v8YAGPZN8uQoWopUrd8k4ws3YqvTCb0o13poXc+afORKgnxKNSiKpe1fP5hdD
 VGByOqjsTeqRz2F2dVlaKmg6wnmd9TUF6jOdwOOVUII9HC+OsC57Q5haduNaSS9dCRwM
 J0752ZbQSRAztGCllTo0fNz7di/HPAd2Liw91CSuN25PavBQclHRAd3Vl+7S6sXBB00f
 IO3ylalvWsPJMEReC7EG73yw2D5RqqERtJHmHtYfB26sTV6agR51U2SoFrgeeu4pusIK yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfb0ak7gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:58:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RIhhei006740;
        Thu, 27 Oct 2022 19:58:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaghb10x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:58:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAEGNrsyuVtgDWxr0vj6M0ejAFV+t6TSicQmYiniyJ9ofDhIbIJg65nKweigU6QWh67S5t/XE/2+nGNUmAQRU3Ygh0gApxnlNfxyGXYM0SlDwXSfw9AUD4zR6IXgPli7M8WDH1fOpfS9Gacx7htM0myNHR/MUgnP6JEkh8Vv86px4VrB9D0bxRC733LnMedmn997cuBLbf5cCvIzhhwn+lq+kXfSHA7UloC2KJh5LvC7MpXmjrEyP7FsUe/FF0nI6nrb+1wh8lJwZaQvvBXMOZIo+1G9J0ICPJhBcW8jJH6iAIZjgkA31rKq1dmZdNXSvlIoVOQkQ3OLxRScZ0Imew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiJCMJoUjqwM83KwK6l1VkMjKa2N85x0ZQLWR7eZw1E=;
 b=ReHYJiRvUYSG4Y3uiY+U0woGozBPUQTyD2YBhmxjGKT2dZkUsShOcAEgZXGSWQQHX9EN1dM/mCHfBBursLeQuCsgmuYrwnwAGcxBvrxXQozEnBdArjpDoepffta94mzG/75Vo3PFVi3XLccHBPFNhJ4vUfsVIunFj5JeycegQaOBqj97Eky46fhVw7LDO5LOATeSJt5hS0CJ3L7ndBvzwOblAAKj0Ci4xSt1TykI9hw32YTKTbS1hQoW5iDZtEZtwyPHdV65lc3LfoCgRUwIxUuIQiErYVECaZ0tHkrTEtrQaWeUpUw6Gj3dCR1b21StkLEiOljO7cFdodXWYYt8kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiJCMJoUjqwM83KwK6l1VkMjKa2N85x0ZQLWR7eZw1E=;
 b=rILBoJQ2bE+L0wu6YvrfL+hxrILfTu1H8q1h/Ku0xSLWJudwi9qqvPS+pMvmZ+wQL4xU9c7B4GGVqVb4fnqai8Q9XCKNdH0wq/nHMjmpC1Rnd4tbyV/4MoEkESJkpiF/JCQIPCzKlp/xs8JuuNoFyNQVs3CfjuPLVhnOg88ZoYo=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BL3PR10MB6042.namprd10.prod.outlook.com (2603:10b6:208:3b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 27 Oct
 2022 19:58:08 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::ff03:d749:df80:38e1]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::ff03:d749:df80:38e1%7]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 19:58:08 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, rostedt@goodmis.org, masahiroy@kernel.org
Cc:     linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v9] kallsyms: reliable symbol->address lookup with /proc/kallmodsyms
Date:   Thu, 27 Oct 2022 20:57:46 +0100
Message-Id: <20221027195754.100039-1-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0047.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::16) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BL3PR10MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 08386ad2-f2c9-4ab0-8a5f-08dab85591e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQDK4mCrH3AA5YnyerZYQsMBc/q+kv5IIl7D1DnfuACzL8wJQgmLbAW3w8W595Ovn1a3AcLZIqJ+GmMwxdcQ5ER10uElXslQGpt8+NxdPeF4Y0rOuv8cq24BEtqqGV95YkWNTXLRqcOS/JibL3ESgWIs6XsAjrSsEQTz4SCg/wSorhcuIcyOYT6I1x6yJX9Lpqvrd99EebXrQjublMiBj21Ql+TH2RBDmMx4vsBplfJQQMqviIyxZWqsBI5zDJrk0RtMrmRU8lXgLFcF/vlNSmJhJKvYVFpSIYBJfhNdccW9HWpfkGqmA8LsX0SBr0xaRvr8kjZl+lPrEiPqgVamq4ZIWOFJHCCpFUWVeNXaKh3z3TkrTsZ6xld73xysWQrn4x+QF2gtJKs/SqUke4B9z4sbrO3+XEqHsSZs1JfAda2V5aORLmMqaBBtGyL38dJdr+0UcxZY3X7T4kz1sADC1skOncaJKONZYhPDU+8r0av768DuJ6ghx6Yx2qhwFcsIte54kBpUxFHEPfoSYhZAD4e28qTq1AFtR291KmneekA2CfqDAjd4vCuDpdiCvZIFjT079tFKi4uZCmHF72jqMnunuAKz66vrGCRLGoTdNPfz6eZGslOvjL/4mMiuforkpw+wsGyXPEpYM4r6C/WZnfSxp4GecROMw6sGOX52DeoC3NzhMpd97WkkSFaDjhxh7MUhK2OV0SimcFK6fFKnq224a7L7iTAwXu8MNB0qn/9Utkpd+Z4aW0GHrg4zDK2TOTVnwp9a7Ilj3XjWV+EoRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(83380400001)(41300700001)(478600001)(66476007)(6506007)(6486002)(966005)(8936002)(316002)(6666004)(30864003)(5660300002)(2616005)(4326008)(66946007)(36756003)(2906002)(6512007)(66556008)(86362001)(107886003)(44832011)(8676002)(186003)(1076003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b0notBea2T7HsSs7jUT5gzFCXzAy6eV0rCKw7HNj9WzIxt2P67Xg8jyFUNyw?=
 =?us-ascii?Q?VdRLjcH2MtMyQVjVGI8f/Vl1VTDVSPMFFDxXmln+G2dfGLKD2862crf4qi6Y?=
 =?us-ascii?Q?hyO9NZk44X8gQ0fBX25K+yYw6JgONH5iaczqOvmNOY6geo8jOOXaooP5EEAw?=
 =?us-ascii?Q?TKnUT563HlJmpyhCC/LI3YG6aA1Vn58KEfX+HpMKIjG2Hp1rV4/HWiT8P7dA?=
 =?us-ascii?Q?9VrtifVQ154Yo86m3bmhWVkoi2WajJ9v+aIAvv7tP/Eb6JnidKvwmOTW4FAM?=
 =?us-ascii?Q?JGuEWojaG9eN+WE0L2LYzDiMwoWhAClYIEr35zCKKeeX3yVnrOuHHZCXodWK?=
 =?us-ascii?Q?nH5EhVM932qHKKHLA4JjbowoPiyqXy6mI0GclpMTJZfTM/cHtwf0E1oz5Dmz?=
 =?us-ascii?Q?xtRvPyv0Rnij2pGgwVe6wdHaojxd+tSvyJa8Xmye4ZUNyvCl883c30oXKt+q?=
 =?us-ascii?Q?e8tPSRBjw2KbQXngcGJYFwxeuk3f69TzZbvYyEqF7IGunmlfHJPcnEY5/7r5?=
 =?us-ascii?Q?TgSnRig+hrzHpEAC834UHhCqvRZXeA/QCPJ1lZdIs6YCrfUgIZ5nKhiP8GBU?=
 =?us-ascii?Q?tlK+X6c6HOvgydBinSQAQpHs592uiOEwt6in0MFbDducJY2if5v5eZ840AHj?=
 =?us-ascii?Q?8wJZ2N4//rcwy5iP/yB1X4NaO8Tpm+itA0CiEvMWpAambd57zS0dR/srMTZM?=
 =?us-ascii?Q?aKayx6TT5vwyJt7ClgCqErasxEWmPO+iNpwh8nsx14tmMkTUE6IZ35OuiJJw?=
 =?us-ascii?Q?lrBfCehvLHObgaQiW/EzeXgRfz0KC1FK58PRBI7KfJCfb0WtAvgj2PZyYC+Z?=
 =?us-ascii?Q?5dzU7Aucei3ppfabZ0IUDf85z1R37EOPpbJdRGI+9/AIDOfFe+lSPpxotFsr?=
 =?us-ascii?Q?uYpBKEftLQuoEhVodCGmtyxMF/Rhv9VbKQBoqtHBobXU1rNwgh9OX+51p+WY?=
 =?us-ascii?Q?uQs6smQpblinFh54dRWkMbYviESu05w06A92TbbYVJFXqPtonbCzdWMyLMH6?=
 =?us-ascii?Q?bv8Vq+xV6WfKwZX7qF0M3Xs04oLLfM91xVg31cR8gI3sPSAufAl8Zvr6AVKo?=
 =?us-ascii?Q?R//SmZZiaUvenQr7UScriM2Pjl6NcNT4sbvO/LZmWvFnZFLQxkLwj0aqjK3/?=
 =?us-ascii?Q?3sUwgG8B+5xSad3f/8mobnhdM5FF8kFmGLFN+SRhrhRsgainsiObf4BZ+tst?=
 =?us-ascii?Q?DG64FdsK8dWemvX6QeT9M0xTEEdWKg60bMgcKAZazh67Fw9jnIQtIwjX1Db1?=
 =?us-ascii?Q?k1eL0g33Jv9HWmrldHtR9VPlgtaYDUqbzjzY6Ue23ynMHm9GA/OCM3RcmzZa?=
 =?us-ascii?Q?6R6fnY3G82G3NCxkwGXCcnrRBHoOJW81ZlRPrfYggb2iBtov7+4iR0XQYyge?=
 =?us-ascii?Q?hBxV3UklfV5jv2bW/ZpXtqfCwgv/S/O3zK7OuD0mB+wegsXfk2sBUp5UJZ3M?=
 =?us-ascii?Q?WqjAcS87JdZWN1VRnwxpL8hWVJNmb5ltAU/PEqlK3YgD0xLqiSoa+hy2MYQ6?=
 =?us-ascii?Q?gjiK6nokcd2I8Fz7gYrCf9cNxng/d7Bu0Dp3zNsyGjNu32Ahw53i5bnnkHTd?=
 =?us-ascii?Q?qyaRBi7qgLHbX99rXwiTuiA9r4CJkD5N/juIgRNcphjZQe0iR0CC4ek2yU+i?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08386ad2-f2c9-4ab0-8a5f-08dab85591e8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 19:58:08.7263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: outEQWSDodW42Yt7AJN5KE+d1qCpKVsiR0ZTq4ToYuXTxDXe1fUhs+wQndOowYLb2ri/2XtVQIjiQYyRnrjfDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6042
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270112
X-Proofpoint-GUID: a1aqjqznOkwR8W_Uo7tPG6NwDmfkc6wI
X-Proofpoint-ORIG-GUID: a1aqjqznOkwR8W_Uo7tPG6NwDmfkc6wI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kallmodsyms patch series was originally posted in Nov 2019, and the thread
(https://lore.kernel.org/linux-kbuild/20191114223036.9359-1-eugene.loh@oracle.com/t/#u)
shows review comments, questions, and feedback from interested parties.

All review comments have been satisfied, as far as I know: in particular
Yamada's note about translation units that are shared between built-in modules
is satisfied with a better representation which is also much, much smaller.

A kernel tree containing this series alone:
   https://github.com/oracle/dtrace-linux-kernel kallmodsyms/6.1-rc2


The whole point of symbols is that their names are unique: you can look up a
symbol and get back a unique address, and vice versa.  Alas, because
/proc/kallsyms (rightly) reports all symbols, even hidden ones, it does not
really satisfy this requirement.  Large numbers of symbols are duplicated
many times (just search for __list_del_entry!), and while usually these are
just out-of-lined things defined in header files and thus all have the same
implementation, it does make it needlessly hard to figure out which one is
which in stack dumps, when tracing, and such things.  Right now the kernel
has no way at all to tell these apart, and nor has the user: their address
differs and that's all.  Which module did they come from?  Which object
file?  We don't know.  Figuring out which is which when tracing needs a
combination of guesswork and luck.  In discussions at LPC it became clear
that this is not just annoying me but Steve Rostedt and others, so it's
probably desirable to fix this.

It turns out that the linker, and the kernel build system, can be made to
give us everything we need to resolve this once and for all.  This series
provides a new /proc/kallmodsyms which is like /proc/kallsyms except that it
annotates every (textual) symbol which comes from a built-in kernel module
with the module's name, in square brackets: if a symbol is used by multiple
modules, it gets [multiple] [names].  (We also add corresponding new fields
in the kallsyms iterator.)

But that's not quite enough: some symbols are still ambiguous, particularly
those that appear in the non-modular parts of the core kernel but also some
things that appear in built-in modules.  We annotate such symbols with
cut-down {object file} names: the combination of symbol, [module] [names]
and {object file name} is unique.  (The object file names are cut down to
save space: we store only the shortest suffix needed to distinguish symbols
from each other.  It's fairly rare even to see two/level names, let alone
three/level/ones.  We also save even more space by annotating every symbol
in a given object file with the object file name if we annotate any of
them.)

In brief we do this by mapping from address ranges to object files (with
assistance from the linker map file), then mapping from those object files
to built-in kernel modules and object file names.  Because the number of
object files is much smaller than the number of symbols, because we fuse
address range and object file entries together if possible, and becasue we
don't even store object file names unless we need to, this is a fairly
efficient representation, even with a bit of extra complexity to allow
object files to be in more than one module at once.

The size impact of all of this is minimal: in testing, vmlinux grew by 16632
bytes, and the compressed vmlinux only grew by 12544 bytes (about .1% of a
10MiB kernel): though this is very configuration-dependent, it seems likely
to scale roughly with the kernel as a whole.

This is all controlled by a new config parameter CONFIG_KALLMODSYMS, which when
set results in output in /proc/kallmodsyms that looks like this:

ffffffff97606e50 t not_visible
ffffffff97606e70 T perf_msr_probe
ffffffff97606f80 t test_msr     [rapl]
ffffffffa6007350 t rapl_pmu_event_stop  [rapl]
ffffffffa6007440 t rapl_pmu_event_del   [rapl]
ffffffffa6007460 t rapl_hrtimer_handle  [rapl]
ffffffffa6007500 t rapl_pmu_event_read  [rapl]
ffffffffa6007520 t rapl_pmu_event_init  [rapl]
ffffffffa6007630 t rapl_cpu_offline     [rapl]
ffffffffa6007710 t amd_pmu_event_map    {core.o}
ffffffffa6007750 t amd_pmu_add_event    {core.o}
ffffffffa6007760 t amd_put_event_constraints_f17h       {core.o}

The modular symbols are notated as [rapl] even if rapl is built into the
kernel.  Further, at least one symbol nottated as {core.o} would have been
ambiguous without that notation.  If we look a little further down, we see:

ffffffff97607a70 t cmask_show   {core.o}
ffffffff97607ab0 t inv_show     {core.o}
ffffffff97607ae0 t edge_show    {core.o}
ffffffff97607b10 t umask_show   {core.o}
ffffffff97607b40 t event_show   {core.o}

where event_show in particular is highly ambiguous and appears in many
object files, all of which are now notated with different {object file
names}.

Further down, we see what happens when object files are reused by multiple
modules, all of which are built in to the kernel, and some of which contain
symbols that are ambiguously-named even within that set of modules:

ffffffff97d7aed0 t liquidio_pcie_mmio_enabled   [liquidio]
ffffffff97d7aef0 t liquidio_pcie_resume [liquidio]
ffffffff97d7af00 t liquidio_ptp_adjtime [liquidio]
ffffffff97d7af50 t liquidio_ptp_enable  [liquidio]
ffffffff97d7af70 t liquidio_get_stats64 [liquidio]
ffffffff97d7b0f0 t liquidio_fix_features        [liquidio]
ffffffff97d7b1c0 t liquidio_get_port_parent_id  [liquidio]
[...]
ffffffff97d824c0 t lio_vf_rep_modinit   [liquidio]
ffffffff97d824f0 t lio_vf_rep_modexit   [liquidio]
ffffffff97d82520 t lio_ethtool_get_channels     [liquidio] [liquidio_vf]
ffffffff97d82600 t lio_ethtool_get_ringparam    [liquidio] [liquidio_vf]
ffffffff97d826a0 t lio_get_msglevel     [liquidio] [liquidio_vf]
ffffffff97d826c0 t lio_vf_set_msglevel  [liquidio] [liquidio_vf]
ffffffff97d826e0 t lio_get_pauseparam   [liquidio] [liquidio_vf]
ffffffff97d82710 t lio_get_ethtool_stats        [liquidio] [liquidio_vf]
ffffffff97d82e70 t lio_vf_get_ethtool_stats     [liquidio] [liquidio_vf]
[...]
ffffffff97d91a80 t cn23xx_vf_mbox_thread        [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91aa0 t cpumask_weight.constprop.0   [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91ac0 t cn23xx_vf_msix_interrupt_handler     [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91bd0 t cn23xx_vf_get_oq_ticks       [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91c00 t cn23xx_vf_ask_pf_to_do_flr   [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91c70 t cn23xx_octeon_pfvf_handshake [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91e20 t cn23xx_setup_octeon_vf_device        [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d92060 t octeon_mbox_read     [liquidio] [liquidio_vf]
ffffffff97d92230 t octeon_mbox_write    [liquidio] [liquidio_vf]
[...]
ffffffff97d946b0 t octeon_alloc_soft_command_resp       [liquidio] [liquidio_vf]
ffffffff97d947e0 t octnet_send_nic_data_pkt     [liquidio] [liquidio_vf]
ffffffff97d94820 t octnet_send_nic_ctrl_pkt     [liquidio] [liquidio_vf]
ffffffff97d94ab0 t liquidio_get_stats64 [liquidio_vf]
ffffffff97d94c10 t liquidio_fix_features        [liquidio_vf]
ffffffff97d94cd0 t wait_for_pending_requests    [liquidio_vf]

Like /proc/kallsyms, the output is sorted by address, so keeps the curious
property of /proc/kallsyms that symbols may appear repeatedly with different
addresses: but now, unlike in /proc/kallsyms, we can see that those symbols
appear repeatedly because they are *different symbols* that ultimately
belong to different modules or different object files, all of which are
built in to the kernel.

Note that kernel symbols for built-in modules will probably appear
interspersed with other symbols that are part of different modules and
non-modular always-built-in symbols, which, as usual, have no
square-bracketed module denotation (though they might have an {object file
name}.

As with /proc/kallsyms, non-root usage produces addresses that are all zero.

(Now that kallmodsyms data uses very little space, the new
CONFIG_KALLMODSYMS option might perhaps be something people don't want to
bother with: maybe we can just control it via CONFIG_KALLSYMS or something?)

Limitations:

 - this approach only works for textual symbols (and weak ones).  I don't
   see any way to make it work for data symbols etc: except for initialized
   data they don't really have corresponding object files at all and they
   tend to get merged together anyway.

 - Non-built-in modules can also have ambiguous symbols in them in different
   input object files: they aren't handled yet because kallsyms never runs
   over modules to create the necessary sections.  This is fixable, but it's
   probably best handled in another patch series.  (kallsyms would need to
   do much less work for modules: only the sections introduced by this patch
   series would need emission at all, and no [module] notations would be
   needed, only {objfile}.)

 - Section start/end symbols necessarily lie on the boundary between object
   files, so are sometimes misreported as being in the wrong object file or
   module.  This is unlikely to be too troublesome for these symbols in
   particular, but if anyone can figure out a way to fix this I'd be happy
   to do it.

 - There is no BPF iterator support yet (it's just a matter of adding it
   if needed).

The commits in this series all have reviewed-by tags: they're all from
internal reviews, so please ignore them.

Differences from v8, February 2022:

 - Add object file name handling, emitting only those object names needed to
   disambiguate symbols, shortening them as much as possible compatible with
   that.
 - Rename .kallsyms_module_names to .kallsyms_mod_objnames now that it
   contains object file names too.
 - Fix a bug in optimize_obj2mod that prevented proper reuse of module names
   for object files appearing in both multimodule modules and single-module
   modules: saves a few KiB more, often more than the space increase due to
   object file name handling.
 - Rebased atop v6.1-rc2: move modules_thick.builtin generation into
   the top-level Kbuild accordingly, and adjust to getopt_long use in
   scripts/kallsyms.
 - Significant revisions to the cover letter.
 - Add proof-of-concept kallmodsyms module support to perf.

Differences from v7, December 2021:

 - Adjust for changes in the v5.17 merge window.  Adjust a few commit
   messages and shrink the cover letter.
 - Drop the symbol-size patch, probably better done from userspace.

Differences from v6, November 2021:

 - Adjust for rewrite of confdata machinery in v5.16 (tristate.conf
   handling is now more of a rewrite than a reversion)

Differences from v5, October 2021:

 - Fix generation of mapfiles under UML

Differences from v4, September 2021:

 - Fix building of tristate.conf if missing (usually concealed by the
   syncconfig being run for other reasons, but not always: the kernel
   test robot spotted it).
 - Forward-port atop v5.15-rc3.

Differences from v3, August 2021:

 - Fix a kernel test robot warning in get_ksymbol_core (possible
   use of uninitialized variable if kallmodsyms was wanted but
   kallsyms_module_offsets was not present, which is most unlikely).

Differences from v2, June 2021:

 - Split the series up.  In particular, the size impact of the table
   optimizer is now quantified, and the symbol-size patch is split out and
   turned into an RFC patch, with the /proc/kallmodsyms format before that
   patch lacking a size column.  Some speculation on how to make the symbol
   sizes less space-wasteful is added (but not yet implemented).

 - Drop a couple of unnecessary #includes, one unnecessarily exported
   symbol, and a needless de-staticing.

Differences from v1, in 2019:

 - Move from a straight symbol->module name mapping to a mapping from
   address-range to TU to module name list, bringing major space savings
   over the previous approach and support for object files used by many
   built-in modules at the same time, at the cost of a slightly more complex
   approach (unavoidably so, I think, given that we have to merge three data
   sources together: the link map in .tmp_vmlinux.ranges, the nm output on
   stdin, and the mapping from TU name to module names in
   modules_thick.builtin).

   We do opportunistic merging of TUs if they cite the same modules and
   reuse module names where doing so is simple: see optimize_obj2mod below.
   I considered more extensive searches for mergeable entries and more
   intricate encodings of the module name list allowing TUs that are used by
   overlapping sets of modules to share their names, but such modules are
   rare enough (and such overlapping sharings are vanishingly rare) that it
   seemed likely to save only a few bytes at the cost of much more
   hard-to-test code.  This is doubly true now that the tables needed are
   only a few kilobytes in length.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>

Nick Alcock (8):
  kbuild: bring back tristate.conf
  kbuild: add modules_thick.builtin
  kbuild: generate an address ranges map at vmlinux link time
  kallsyms: introduce sections needed to map symbols to built-in modules
  kallsyms: optimize .kallsyms_modules*
  kallsyms: distinguish text symbols fully using object file names
  kallsyms: add /proc/kallmodsyms for text symbol disambiguation
  perf: proof-of-concept kallmodsyms support

 .gitignore                       |    1 +
 Documentation/dontdiff           |    1 +
 Documentation/kbuild/kconfig.rst |    5 +
 Kbuild                           |   22 +
 Makefile                         |    9 +-
 init/Kconfig                     |    9 +
 kernel/kallsyms.c                |  277 ++++++-
 kernel/kallsyms_internal.h       |   14 +
 scripts/Kbuild.include           |    6 +
 scripts/Makefile                 |    6 +
 scripts/Makefile.modbuiltin      |   56 ++
 scripts/kallsyms.c               | 1187 +++++++++++++++++++++++++++++-
 scripts/kconfig/confdata.c       |   41 +-
 scripts/link-vmlinux.sh          |   15 +-
 scripts/modules_thick.c          |  200 +++++
 scripts/modules_thick.h          |   48 ++
 tools/perf/builtin-kallsyms.c    |   35 +-
 tools/perf/util/event.c          |   14 +-
 tools/perf/util/machine.c        |    6 +-
 tools/perf/util/machine.h        |    1 +
 tools/perf/util/symbol.c         |  207 ++++--
 tools/perf/util/symbol.h         |   12 +-
 22 files changed, 2073 insertions(+), 99 deletions(-)
 create mode 100644 scripts/Makefile.modbuiltin
 create mode 100644 scripts/modules_thick.c
 create mode 100644 scripts/modules_thick.h

-- 
2.38.0.266.g481848f278

