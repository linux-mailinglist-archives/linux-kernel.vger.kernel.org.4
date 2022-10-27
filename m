Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6100F61022F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbiJ0T6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbiJ0T6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:58:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2731788A32;
        Thu, 27 Oct 2022 12:58:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RHmxuT019842;
        Thu, 27 Oct 2022 19:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=aV9EStDlUFiVpRAMrN0YzrYdZBeYHzIysbC7g5GURjs=;
 b=HgFNgAk0y2tVKS3NI402PhIkDE4KblsoKzkm9zoMRMtZbmurv8YefPBHLBlisMp5Ygzu
 Pw0/w7/LUabxyv3PDCqIcbd7GzfBabkKUlMhxYqwCaIJ+uYfx9BpaGpJOnOcsibXZYv0
 0GwxIMgcXWpjtf8XFZo3viZ8ozUkdrdx3A0Z7mXQa9zJJwLtYGjR5JSwiTBGR5V4P82+
 h4Md8/D+Q8ajg9I0fH6ixSNHDkCyVLelJqky5wPDRSoRGfyWJbguqgPH/GgbOAep/8yp
 x+7do9dsj2ThYk9aq00HEnMKzGade+NZSeJ586KPNf4U6i0+HJTK2UDNF4c4uvkViqy5 LQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfax7u30e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:58:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RIZSAA006561;
        Thu, 27 Oct 2022 19:58:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaghb17d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/svT/OtwozeGFSY6LJyEFMflZK6vkRdMJxCkYOVnr4P+Q3sJn1x6wFrUUcC3j5ygyB3DudywKzlvghtJrGetxBwF/538typzRoweVCtMCaH23lYhhEWvWWur8mcejmQmNH3uebWK0ga/eSAoE1Pmgd6WO1Gp/Lex8ZD54BJYjq0aoGGHqypw3fts5x56bmiefRRFEwsFXS3P8desSaLGR98+n8FERt6+sAiHMcZdpMxilzpuM6j61J7oEwKOdMlT24qQYj/t4a4dWU577yxd7QKdsa3PUaQPwjDKGPkKwQQeU35J9RBb4WlIO38QsZ+aupo+Cwgq1UvVaVspsD0Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aV9EStDlUFiVpRAMrN0YzrYdZBeYHzIysbC7g5GURjs=;
 b=MVbU0YygvqGywF8rlpKk7poVrDp3qGTFAKi11r8fB3b3keeXefYPfiesYrri+Yf+BlehUSTiKmtYHWa5zYQ9EQk8UcWvzrXyEs+L+WjokxDqvbfYCiKuKvmmokVYxbfuD+EzAXoxJG/Ov+JSQMSj0W68jHNGyqAyzC+iRnwF0nk2QGOv1a5dqQ/ohRnFtHNwjIp8PBHycO3eNpCyqsXrkAqaaxGeHEefl5fa5/JIAndWNRwj4wHc1czNHJ5GmmtBV0v1kVMm/lwjalggMl5Y8pyRko5/wqWYut0DgJgWIaSk7qinqfhQ0h5qvjIAHOEK+6ki3Ian8r3L460ZAn7A3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aV9EStDlUFiVpRAMrN0YzrYdZBeYHzIysbC7g5GURjs=;
 b=U1TfqlGeuIGMGxzRn1HTeywkSqEqTfE71nj/FG0M3wM65uoZdkr8O0I6mCOYtVeBfegmiuT8bFJVp25nJz6/i0aODVM52PfWXJkwG1c8nEDbtKMkrbOzaBSHr0fFZ5+AmYdA+TvPI9atIZTQxgnw3v5w2UhhMJC76X27H9ZczVg=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BL3PR10MB6042.namprd10.prod.outlook.com (2603:10b6:208:3b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 27 Oct
 2022 19:58:21 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::ff03:d749:df80:38e1]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::ff03:d749:df80:38e1%7]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 19:58:21 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, rostedt@goodmis.org, masahiroy@kernel.org
Cc:     linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v9 3/8] kbuild: generate an address ranges map at vmlinux link time
Date:   Thu, 27 Oct 2022 20:57:49 +0100
Message-Id: <20221027195754.100039-4-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221027195754.100039-1-nick.alcock@oracle.com>
References: <20221027195754.100039-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0169.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::6) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BL3PR10MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: a670a0db-a62b-4dbc-be0e-08dab8559936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dNG75im7d9OgLSMnrqVEUXpHGmbRSb54H41Kr3NFrqzkXhBJaCwE9ozGyFKnkc5NAKvFfTru8bShAboLe0vvC0bsUm5M3P7EBVN+Vc8wTdJa9i3fkgteQbooNNboi8ISznompBu8leVLiUOwR1ffsl5cozTKlGfKEImQhb14FJGT8gyTztSlVDGghNZrZCwaOnhHS4rirYLtSKJnUJ7K/oHmRcKqYj5Gojm84K29aAk8uiJgZHCKN4Sb55l8IJx2GM7pjVCusaUfmvw3PJsDDy8Lo93774i+zkcWN4g3/+iRzdwjFIX05dOYyS9VPpbBiJ8MU3DIXdC27FUeqDfDd0JBYfMjjEmv9YCQR7mIcDCD2vAdf7SHh7oB4njbRGUuLeO2NibJ3Kx1o76FMdGZH5Ks0a/Bzoe6y3BmSZm5jsA7tXE+bTb2L1MtK2pG2ItxuauHAx2AEUpiqZt9gAjWjLSyTh/6h993YNeFBhhg9CERVGx5TAJFDR4PPdUqc8xwKfBu+oCFdM1GR6atWAckFd52PYndRtRpOtr4ds7V6VyYuxrH7PGbpZS3/2xkJrw/U79Js0rkvKhgNzTccatz4EeySx1F5ak0EUutn6SZ0TX4lzkUaxQZj0LETB++K7froJUyeeZM003e8YBSCdk34Mq91gkggud1SBwCAahTz5ByIknwHwBM3iudo0mT91M8qKoF0UmJcybRgoHa3g60Ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(83380400001)(41300700001)(478600001)(66476007)(6506007)(6486002)(8936002)(316002)(6666004)(5660300002)(2616005)(4326008)(66946007)(36756003)(2906002)(6512007)(66556008)(86362001)(107886003)(44832011)(8676002)(186003)(1076003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M4mizavXVZYbWvcW5troWGZN8FS9bTY5tdhJCxRqWjCKJxn+7asWrKPh0Beg?=
 =?us-ascii?Q?/8Cc+Q3O1D+XJIL6KFtCIVYuZy7qqL1UIjGliKHkZbyaHIMH8dH+4AYN4LHb?=
 =?us-ascii?Q?R7vRDxbSq6JYDSNldoqjqSEJtmcxU7BWQGxVAWCxBTggfRfrXgca6bcuIWoW?=
 =?us-ascii?Q?uvEFrQXOIoOfvTgQUxwLBoVcuQQPQMnWF5xmUqvt18w+nz+jw86Kz38I6FWe?=
 =?us-ascii?Q?74yne3qqnmmEP8TbNhU2g4tqdcYZnRx1nw+VyWB0AGBR0m5X0YJfAGHmCBZq?=
 =?us-ascii?Q?SFQj5/Jl3d2Xi1UCwJB9CdpCsgTEmCqfoyrpXRHI9NwxzyGGc9/ts0ZrOm1m?=
 =?us-ascii?Q?8J77/C+L6pbFqL+YicVkllrv/iYWxLqkBnT7oWnynQJL0GmwZ3tjinqPGB8z?=
 =?us-ascii?Q?SjlTVvmH51WqFcl7RavT9DSjASFTDR6Hfxhd8Lz/4ev8jC/qXa/5aVETHN6/?=
 =?us-ascii?Q?LWzjT7LW7RfVC/7KN5AqU24bRTuZF8cTKiJo7wAr3cjr7DSRCHRftEZVthlH?=
 =?us-ascii?Q?bw38Ovru8hs4fWsOUrlYFv91AgogXC+iMu5429q6KcsF5s0ElF3LVfBI2L1Z?=
 =?us-ascii?Q?s/j3x9zJkcjr+sRGzlqkvYj2uiiJMAWZ3NulSvPFII+1SzwDXvVALut+HalY?=
 =?us-ascii?Q?A0INkxKHEQH9ZJqYGumycZ8RxJBlV1Bn3vqB1BevSWqZtQNcWS05DqCaPNE0?=
 =?us-ascii?Q?90EMolKLplciquQWXPrLP33bo70KMtqOHNGk+w8Ep9Wgokbxkv/agDefoDK+?=
 =?us-ascii?Q?J6oVij7SqIRSdTs/uSNEXB7AVwfTrhuRFo8h3pRNaKzm/jCO60fyz0qajzrP?=
 =?us-ascii?Q?yoRJwIqzjyslD8geDCtRpNlR1jNXaiLW911b6jODdXJCbD/Yg04CcRHCEa3U?=
 =?us-ascii?Q?q+01Ye2wJrDZvTqoJA3SCJZSZnoWcqY60xO0/qE7XU7ufoIqPdG3B2jaPKTt?=
 =?us-ascii?Q?OrUJVbkHCyrfrARM29PHuOeO7Vc+JIrllPUYUAMEz8vhQom5t0y4QMCicMfd?=
 =?us-ascii?Q?uvxBV97p9ouMjYzXGUS5kWNu8OIKWyDZSD9YR6dIRxTg1wUFf5kRXLIAxF+Q?=
 =?us-ascii?Q?t8PbuyDpX5vyk73sh3TRfokX8lfRW194QNqEaJNPIIN83bFKeU2Zodn8GU66?=
 =?us-ascii?Q?wNWj91E6aygMhudQunzjBpUUQOLiwnhwu7cyjTgGf0QiulyEd4T6nJjPhqM+?=
 =?us-ascii?Q?AM/zX46BMEx/qyonWlWWtTSwAOItPBalL4IgwRihjtDoX9etCLHMkEHav6Fo?=
 =?us-ascii?Q?4EDd2YyHTPNMoIWEiyc+jBTTgaXNhMGwivt4Ovsi71JuMukrmZ9hFvNZpCfI?=
 =?us-ascii?Q?nNJcspcA8M0tgEIUWV8NRn07D7oHc4ti4S40Akw8GYkCSGqXtTGQBYXOjZTy?=
 =?us-ascii?Q?y/y2y8ui3B3MhOZdz9GtA7ZJZ7YKtR2Jv5rzJ6Gy7Kamcs4E1cL92nPAfF7N?=
 =?us-ascii?Q?prMmkwoWIpoe38g2edcGJrjhdNPkkWnMLTSFjbMqBYvAfVsIqZIVdNpwI8mC?=
 =?us-ascii?Q?jW3bsQ2KQyeOGTBsJxRtcNF08GuSIrjmmae+VRApZq1L+gZwPy2DxxrPBywS?=
 =?us-ascii?Q?b3Auy0/lDD+7X3aPV/Woh+PuUU5P8QdbH+EVn5qk6PdTxeSNB0CKsGoT9pl3?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a670a0db-a62b-4dbc-be0e-08dab8559936
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 19:58:21.0454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSaqiuo//QvR0OyLsd9gCfqsRSn02DgadPjuPEzv4Ui4cJ4Q5mJQmIk1YuA0n53slX8yR/R3+ufHKH9VuDIHbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6042
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270112
X-Proofpoint-GUID: xw32ieTS-9rGNQZnWGHFSMwtENveWB-h
X-Proofpoint-ORIG-GUID: xw32ieTS-9rGNQZnWGHFSMwtENveWB-h
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This emits a new file, .tmp_vmlinux.ranges, which maps address
range/size pairs in vmlinux to the object files which make them up,
e.g., in part:

0x0000000000000000 0x30 arch/x86/kernel/cpu/common.o
0x0000000000001000 0x1000 arch/x86/events/intel/ds.o
0x0000000000002000 0x4000 arch/x86/kernel/irq_64.o
0x0000000000006000 0x5000 arch/x86/kernel/process.o
0x000000000000b000 0x1000 arch/x86/kernel/cpu/common.o
0x000000000000c000 0x5000 arch/x86/mm/cpu_entry_area.o
0x0000000000011000 0x10 arch/x86/kernel/espfix_64.o
0x0000000000011010 0x2 arch/x86/kernel/cpu/common.o
[...]

In my simple tests this seems to work with clang too, but if I'm not
sure how stable the format of clang's linker mapfiles is: if it turns
out not to work in some versions, the mapfile-massaging awk script added
here might need some adjustment.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---

Notes:
    v6: use ${wl} where appropriate to avoid failure on UML

 scripts/link-vmlinux.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 918470d768e9..287a2b2c4d46 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -101,7 +101,7 @@ vmlinux_link()
 	${ld} ${ldflags} -o ${output}					\
 		${wl}--whole-archive ${objs} ${wl}--no-whole-archive	\
 		${wl}--start-group ${libs} ${wl}--end-group		\
-		$@ ${ldlibs}
+		${wl}-Map=.tmp_vmlinux.map $@ ${ldlibs}
 }
 
 # generate .BTF typeinfo from DWARF debuginfo
@@ -144,6 +144,19 @@ kallsyms()
 {
 	local kallsymopt;
 
+	# read the linker map to identify ranges of addresses:
+	#   - for each *.o file, report address, size, pathname
+	#       - most such lines will have four fields
+	#       - but sometimes there is a line break after the first field
+	#   - start reading at "Linker script and memory map"
+	#   - stop reading at ".brk"
+	${AWK} '
+	    /\.o$/ && start==1 { print $(NF-2), $(NF-1), $NF }
+	    /^Linker script and memory map/ { start = 1 }
+	    /^\.brk/ { exit(0) }
+	' .tmp_vmlinux.map | sort > .tmp_vmlinux.ranges
+
+	# get kallsyms options
 	if is_enabled CONFIG_KALLSYMS_ALL; then
 		kallsymopt="${kallsymopt} --all-symbols"
 	fi
-- 
2.38.0.266.g481848f278

