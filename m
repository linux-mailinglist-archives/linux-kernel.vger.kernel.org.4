Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3E1622D2F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiKIOJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiKIOJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:09:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297D318B18;
        Wed,  9 Nov 2022 06:07:02 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9DlpqS018026;
        Wed, 9 Nov 2022 14:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=WCVIcRGiuqv/jZIS54leCB1/TxNlU2cYFlKnxa/galg=;
 b=cQDpPHgOtLHC/cFWQDTSG7KZpLboxRFjTU849/VQIqSRwd+0oboEM0ib9ItXbigZE3n6
 7mw2LdCx/5tzji4FSQeve0RuCpSRF/asnUmWR/pnSm/3PSmEqVFHDghiL2MppmgE34bp
 MsdkBv8syfjyEYZRTI5jGZW/KIZDBxrLSc5+MwONOia4evTdGyQ/U+gCqmIc/R7Wn9So
 QtSuReKeX0XKN3qAWDOJ842+WtLNgryIaglNn6LF8Y873oeLOu8rswknZTLO3a7ECLUu
 rji30HB+LlUvLPhG0c8YYp7Zhfng9pvB+Vdiuej6trJn4h/NrRw+JwX0rnjhtjIBR9vY +Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krdd2839k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 14:06:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9C8n5n017816;
        Wed, 9 Nov 2022 13:41:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctdn8jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 13:41:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEkyMb+zUjX9eiIclsKhfPg6GrJmzl7N5y+c/dMkv2bLOCshKE/D/b+IIGajFrJ4HPyVvxm3WLC5kYacSSqFUyK1gwm5NjmcK3uiBjwUnJHASPBGvM6vOYiEGXiqvY03FWuYqZtYCanEL2JtSzsl89eqkfoTzBEikB6S2kUY5X1Q1DoMX7pL7FsCrwPVlugYHr5ku15hm1SZoi4p6mDlwR4HSk52KnH+pbGzwCvQhb0xbcUdsThENi1krDjMKsUYUTiq7rtDAqKLLa0kFc5LFoqxGRp++aaD3jfJeFYSRtaQP5Gscl1fRGpcVS+Y5dRjsNswOYtUH80yDQJmtDbCNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCVIcRGiuqv/jZIS54leCB1/TxNlU2cYFlKnxa/galg=;
 b=bwPPI5etaPeib6gOjd0HBcCe4FifMCzIv0EFA7cosCnWy4W0UfIxbP4v7G5NpjfhJ6Xl96vEM2WtUWRkyDq5DqxGiRrRyi4/lwArAUEbCkPIB6u8+3hZYhzuQpb/gTJZxTi4sVKNz7xOfFNApLjxRjTO0Bsj4FESDATXwqOUyk06AlTXFzk10F3zzxH7DLqqDSwh3+EQeQpRPBy63UscRVLxmlrXXRARp6FhvCVGdO5NUlp0uWVVapM1VFd0nS7DOgM3taYWihrfBADkJyNsR8E4oPy9BVptD2QTYVO589Y5RB73pd/8O3EIR7zqR91rA6U7vL/VTQU1uSchtEskpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCVIcRGiuqv/jZIS54leCB1/TxNlU2cYFlKnxa/galg=;
 b=BUUwodVCaCyjzGbm7EJ6jGTudxzczbIp/FqaxfY26k6Av8iIktUF3AueHTdRr5Zod4WixtRMCwB8yGM9BAEiKtIzhw/8IZeWHgKD1/UgtE4TasyRjwKmvfk0GBkspXjMfHpwsWeDMbU4ivibcjuMHj2QGaLIIff6kiFUDqIhGqU=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BLAPR10MB4817.namprd10.prod.outlook.com (2603:10b6:208:321::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 13:41:50 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2%3]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 13:41:50 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH PING v9] kallsyms: reliable symbol->address lookup with /proc/kallmodsyms
Date:   Wed,  9 Nov 2022 13:41:24 +0000
Message-Id: <20221109134132.9052-1-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0095.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::19) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BLAPR10MB4817:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b0355a-23c2-4a4b-5507-08dac25827b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kIdZvh1zLmTyTDN5N21W+VA8z4yn7FErRKtGYmXiJOC7aoEvDGVAdSZdsBQCtMh5ffAHx5A+lOGoSAfUXoRTi22hs+qf/ZrWdRYyHZ1NcYgQAF/AjfUV3mxmUZH0QG5f3DrRGQTK7+WpTmFIVW0KTLqcvhZqEek+oQP50+C5w4DpScbDn4ILUeqopoedEkxOrxEazI5MtvruCOVyGuDZUehv9R4Izyn4udyeNoa2Yhm/gMxjO+ePczrXBPUGOzNWuIfTO8lESAeqMNac57LDKdxlj2FUSzxQATOZdUl/hYZ22uvK3xri5fNsDj41inQpTPreiObSTSRvpT+9Bq6GRUwr6FZJuZG7AWRDTbnFVUoPLQfcsGph4QQWamtXV8rEIcrAu4MCekbCEDU//UMsYfkrZoeerMwmv6dF52bgFIi5/Ofrs4fv+wfw2mFnvukFgWyh7gjzzOf8QeLWB57NJBOlUyuuyry65ah80cdMFNck9kPGcryo61rZqXOU+QYD+/Tcg4r6YQWMtbLa57DQ1PzBke3Cl28etlWeV8fM+usf841wbLYi2Rcqy8Or6R7aeDUBlWhKCZ90g5LddkxFbieJPnCn+I0FsGuPpmVrNLIlpbc9WO9HNfzjmwPNa9N4AXOJnrfAq/mNnp+6M1f0LsqkOimhxkIORbK+70qHh6ZgVecoo/Cz6dxtxdFgabJJ/KcEU36lXEUkrlynlE/VkIdLJkY4RN8EXnmuLEuB6tfafFyknGsmoAOzoaGQ4KW4rcvHyeqabkfUaKIHyoaw+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(2616005)(66556008)(186003)(83380400001)(1076003)(38100700002)(6512007)(5660300002)(8936002)(30864003)(2906002)(6506007)(4326008)(6486002)(478600001)(6666004)(107886003)(66476007)(8676002)(66946007)(316002)(44832011)(41300700001)(966005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4amX6kt0fj9Q9+ZyQ7DwRsoB1z3X6wFxdG7ffsC/qeEM+ySRvxPD2JbSHUu6?=
 =?us-ascii?Q?4TKnBttgLdNy4Lq/qRKxTk4WNQZwX61VokfowaP8qKfQFcBipQjyWOVKkZS3?=
 =?us-ascii?Q?D7cAo1FBHE2AjkboDx7BizsDvUHW/alDkGXfinabWvkG5gLFYViJURVPTcM0?=
 =?us-ascii?Q?s/oP4nN7lBbxVxEckd+1sKkFTgJH0DZApgahHyqFy+e72MAgxMqKXsz+jYKU?=
 =?us-ascii?Q?YhyaqvVpnYVjDHHWFlkBD3A98/cfFrFA/W9GlsoDnWvKlicPltuzZ1R7yrPI?=
 =?us-ascii?Q?xXAhH1P4+XkMFi+OzApJAIREZWEU2ldW60Hh7tbvxuaUSgyVqzOodRzg/0eO?=
 =?us-ascii?Q?oBhulA5OPF0VD0zHM2FGtQxjLE2UQSOmi3HRXvNPAyufzvVjIc5L1rOlBvyL?=
 =?us-ascii?Q?Ohqm6Wr2MQBCXElp+F/iM7KTfpg25T6WD1x9CEBYb0EPqyO8PAfs7NFR3AfD?=
 =?us-ascii?Q?JUqtJ/DEfZL0aXRX7GIyNmxzU6p7IojpdS7iQNhc0K6lsq//RbkcuqX3phh/?=
 =?us-ascii?Q?C6/HxzKtRlAyGXa96OrU2esH5yL56MJCjSztqqozpeGHF/x/VZ7U+xGzGZ8B?=
 =?us-ascii?Q?Xqux2E02DTGAbkBhvZMGSMWcV9IAgZWkhiLTqkppNypwVVrF8W4sbR/PXrJh?=
 =?us-ascii?Q?brnK+NJ6TWkCyux42iY3C0B8Kax+OYpBs6yEJrL2i2RLSQEhhYphhYed5YoQ?=
 =?us-ascii?Q?5fjUrz02/+rzAAlXADdkK/4BiM/w4U3Kysx0ufuj9pkAz5E2p4ILFjZignME?=
 =?us-ascii?Q?y+w2RlDVBbuGG0SvcC59cFM7kNN/wX8lEFLDBfVvl0mJXkrfFV4Z69GR+XEb?=
 =?us-ascii?Q?Z/0anSqcoguGW+w5EB8jmN1RpfqR6kdurg6Y6XJ4ZwkEufLEVGauo+AiOfpu?=
 =?us-ascii?Q?OJ73TGfybaJMpr4clv/NTWYJqEp5ZQfzvLFTndTA6oWe5gv/bwGNe14vcBXD?=
 =?us-ascii?Q?ZPpMQxiYcWI1AyNWJ5z7vBq0vjbxzBz4xFmjLnBWeMeZqWYcyPWPcBgb15H+?=
 =?us-ascii?Q?i+i7TOvNKnkchQj/G9fy34a5OCY/4calw+zB5jpyOY+nY4MnDYe1XITW253o?=
 =?us-ascii?Q?j/buXz9oNhZfrTcrlJhvu95Snz0xTVBygqyONV5HC45aG+sl6XM6PwYLWAvU?=
 =?us-ascii?Q?xd/VNejK4mC6BsT6SaCcZqIPtpSe8CKiUHxS7ysciEM0hlpqoO19z5eS6Pwi?=
 =?us-ascii?Q?caSbMIrvpHtV80ghUfqoQVDWHUyC9qE/38SHflbA+OQuAeLIk4BjgPYlTBb8?=
 =?us-ascii?Q?ISwxczXiG6wDrrIVUC3PZWbNyz7vgZwvM2ACkJqqVitqTrvCKwcCuIUtFIsh?=
 =?us-ascii?Q?04gmt3eY85SjQQ7tAZW/vFsirdDZDWqaPzm0qT9O2JVj2+qgJhIr4DjK+hca?=
 =?us-ascii?Q?/h6oVFeye19GHCfeJ3lHOUdv3DS4C77gXvSN66sk99sKWQrqU95Gh/5p8rWp?=
 =?us-ascii?Q?pQ0dOVQlM/+0v5T2igOOL2YJXbtNEQ9PxB55xQKMfyuRaiwB3PBdxhg24k+g?=
 =?us-ascii?Q?uUGx2WL3otZO2juhZTq15EVB2kTW4hFlKyCiNykNSWQcZjoQ5OY5OxSq+lDh?=
 =?us-ascii?Q?WK7LCxjPNKLnUbgMnXwAEyiU9ntDR6BH560cylUq0p8oL8c9sIOG7fbcmfH2?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b0355a-23c2-4a4b-5507-08dac25827b6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 13:41:50.6611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7UvcRZIdXIxpGZGu8Pr2uF6QiH8fIaeJRarmJgLeLevK4oMIXiFf+R9R5LKxU10fzqXXSlFC27c5TscgJNAPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090104
X-Proofpoint-GUID: YCD_q5YLzZbtrB7AM4VBQsd05yG9vv41
X-Proofpoint-ORIG-GUID: YCD_q5YLzZbtrB7AM4VBQsd05yG9vv41
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
   https://github.com/oracle/dtrace-linux-kernel kallmodsyms/6.1-rc4


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
 - (This ping) confirmed that series applies atop v6.1-rc4 without
   further changes.

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

