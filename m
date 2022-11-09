Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909E8622CDB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiKINwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKINww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:52:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DF21CB24;
        Wed,  9 Nov 2022 05:52:51 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9Dk6D6027859;
        Wed, 9 Nov 2022 13:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=aV9EStDlUFiVpRAMrN0YzrYdZBeYHzIysbC7g5GURjs=;
 b=XxBi5hGE2C/ioVCERDjycR5Lw/3khtCBlrC+aGCHilJtq5ijgEGRmjV9IA6UrH36gc72
 Xn4BaInT3pBMN5ky6Fw3Im79fB2IHt3MQydkBFQI34tYqC/BMpWhNDC9x9yxrfmaFmeD
 2ObKncTZYdmd/0kGn9AT/XxdLZW/lyP3Ok3jdf3wyCG/MGBB+qDfDGfe+7Blkq5014Kb
 GPoDGS267gro+rvlrMb7rCJT9MDPsTo9nyOT+37t/71Ss85sTwv6f5vVRR3hgabMS6DY
 //oAzPGs1NkvkIR33t2RsAEOlLe0T/kMrgKJlhzs8E75O6X7pjkkCymQsRwtQZhzjPJC rQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krd2w02vk-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 13:52:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9CgvIk004294;
        Wed, 9 Nov 2022 13:42:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcq3ddus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 13:42:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5NRjr1llKNL3FihA4kjrC5tJMHWrbyo5V37neI2/NeqqvhUSe17TEnBShcEJUIjvjzlkItcv5sl+SpRq0qlsw75UuSJNnfuU5F0j2caubqTuLq1CP3sEUEwFNKrno0FEu2rKRrei62MaDPuAS+bjOwZINZdpwapIvbxaq6CWS/2uxUPDyI0vBgYoDJnq3qPeu2Jzyt+D3uOlLC+HClbiaz60oRaCVfg4ZW/y3A6xZYn8dguRVIpQ4Kn1C8yKArl8xAfi9QIJEkdDPqO0dqx/eZo/8cI4MkfaVv5U6Y5uMlRQTRN6b1KjEI+afGOE3liaav3rOAMpCYASeCUl8vktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aV9EStDlUFiVpRAMrN0YzrYdZBeYHzIysbC7g5GURjs=;
 b=i1w0Nx0RJYyJlgJ/rRc1eMQMkck2rPZ51ur8/T/ig7IimQzy9HKu5JgJ9EvwW5TxNvWje6HhMeniRYs0lA16VLRfx9q96ymJMgn1rs09cX7l5Und9J/UPVYdMe1FI5HBUJUZNdi8dmMzGD1bpt9RnYasUknSOdtXF5YGxmtM4r3/3LzR2eEzgpnMeDRR8t5gvHIdYMW/GBhaf+rED+9iDuPaoefAP7HdelzcJY4q0tIpR71bB7pj5demutFFgCXoigwmqTq4HbiGaZMmSIofi3m3AV3442TKKG3xNqutyzQ0IRtg0OOnZDOa7whirvW8v2i36oN4wDUAxasgnKVOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aV9EStDlUFiVpRAMrN0YzrYdZBeYHzIysbC7g5GURjs=;
 b=KG9Riv9baNnLy13HwWeS0cO2FhILkJOes4fyQmPRGPeezqD2huZn135AwK8FrvcpMTCdWGF9fn7MA7bnsiWwT2F+pnyk46iUpTdr81QGwMCv5JiueZI6S5YWZCXrzMy5NL0Po/8M2xryFFMgTOXQ/ZsJpSC4SBeO3BEedGi2Plo=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BLAPR10MB4817.namprd10.prod.outlook.com (2603:10b6:208:321::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 13:42:14 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2%3]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 13:42:14 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v9 3/8] kbuild: generate an address ranges map at vmlinux link time
Date:   Wed,  9 Nov 2022 13:41:27 +0000
Message-Id: <20221109134132.9052-4-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221109134132.9052-1-nick.alcock@oracle.com>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0498.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::23) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BLAPR10MB4817:EE_
X-MS-Office365-Filtering-Correlation-Id: afb6815c-2e84-413a-f672-08dac25835b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NbK1l019LIxsZU1Lr3YMh5A82u//oGck1lhjYxhYof5Y2bCWv+JDZ7M+4QgGR6qbHTZaKe65dGzkBKFiqzIQFGyRyAre8r2cxO2TEVMZAdY1glYtBCMaOnByI33h+JBDemItkmMA+ezVPNKApjw3Uxu5V+cVJJbVW2rjGphuvTfJEp/FhXFzxiCf9VpCU2tf+xDdzroYyCKl5KZnjA5XEv55O24+hiCUa1fx4eTWYwQk1VpXOQgRFe5y/LQtkwRJkpGHAlCnyt5LCMKU4xTuWvrPiIIrzs4vVW5xeHIr/GxcMw2pwExVx2HXq/goll/kJCKtKs8p6Bjm/Tb/zUcfm6KG6mZNGm4uHCXSPDtvll+8dXHeSK2PpqHfb+n7CixNxCTQW2w+gpzkb45f23E9TlRU98V3qtjQRQn7JzScICPS7j4Z5J/qrLvd6MtsTVj7jPHX4GkUCZZpBYtshump84CK80cvQpPpMH/CmamsqjrYhMssyydyaZFZUxb6rAGEiFdCGPcZoKWNBPehpEw3LymirYKWWEXPIgmJEmQppmpCvfchucX/GQU249TPex8Uo4qG5GzF1J4XB2Dp3JuZ/pDN5hzuis8uupLT1f5WtSbLZ3OU82rIuIbzmpZP7ex35J1pxzB9v47Wgl0K1IAWwRTOy7GvmPfeYD+r9H4zEuV+dPgVQGDq6EUqC9CDcOO7W6zfHxWZ90Qvy/lew2MSUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(2616005)(66556008)(186003)(83380400001)(1076003)(38100700002)(6512007)(5660300002)(8936002)(2906002)(6506007)(4326008)(6486002)(478600001)(6666004)(107886003)(66476007)(8676002)(66946007)(316002)(44832011)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p+r8FjoIiEgvVGQ6+F+RCpQET19jI/aCh0N3oKKA910HOr0OW3TTB0qbR/1m?=
 =?us-ascii?Q?SUI5I21M3mYQKKKJN5BPuGrxBKGmQGpslYlkzynky9SlavilhVz6wjMbWSW3?=
 =?us-ascii?Q?Zwj9+KbtcQ98qPKLWMwTRRojOoy1UoWTIFFyTx6qu7wdn0Q6vPzy/cSGwg8/?=
 =?us-ascii?Q?b7xI2uZidufqUUQfQ8BFDEbEYVQb8I5bqHzPXIHRKJAiNJcYAL8Vqkg9Tbee?=
 =?us-ascii?Q?HGds2b9jpRlISYkQjXeGTxnCEMFTgy2ttaglJQsf7Zxo0Pa3WvsWXfDOgGjB?=
 =?us-ascii?Q?k2DO8/AUYNQEKHpipZBxTATowO/cszT7PLwGNpKDCttWf876dyo1XVMN8sky?=
 =?us-ascii?Q?exWPbuQcBcuYB9fW8iqp5HLdCWTRoo9PCCz9m41kuxJmDpornsM7nyYbr1Ur?=
 =?us-ascii?Q?pY37d4arTWlJ96lSMBhq93ptgkljjKJjYnZYIF+UdTF6AgdC2q+nhPS1WhRm?=
 =?us-ascii?Q?6UFm7PK9hVoaDZVmbv33dL+TPNMI8mllGrCFHeh2DH4PSi8nNU34gmUc9bHD?=
 =?us-ascii?Q?6Re+Kj9mo1TyN9St28VT72vblM3741w1CcNmcI3w6CxI7hSOL8MrTDpQyWKy?=
 =?us-ascii?Q?7ykm3R5KpjsrlSXUP9JcIwZ4foY85ItbXvzhEBLmwegK9sCQowrk4b9miXxr?=
 =?us-ascii?Q?4YeVLkNRbQZ3AqDrjvx+41VCTyXLd1NoHKxs9uR2rYXmpjuTHjUbnkjGwPV+?=
 =?us-ascii?Q?lNdJM1l0CDAg5SqAkY9WvbszMnVRWj3tYYTuttvfIhlVgC+TxYOv8rsOBUcF?=
 =?us-ascii?Q?whMHmEd/CWIor2GLQZYuoyIaamcK1t5nE5mijLS4VXzZtVGHvxAF68RYYfTn?=
 =?us-ascii?Q?4vNv2SvI+Chn6rVFPCz+kkz/J5IQhNkg7oXT454NLU2y/U3DDpXCId02PEne?=
 =?us-ascii?Q?ii8OVwqu5Y8St2teWnakQgIgyq9jlumvf6YTzFpFKRTzlyzcr+VVUzTfRgJB?=
 =?us-ascii?Q?6CHw17o8Re0Gy/Q1x4GkznHnfHgGkn0HMl6VOi6ZONM/IB35XPjPhyYlJe6O?=
 =?us-ascii?Q?QtHKPBnoMKCp4puB/9Ohev0Ki8joXDkPYtkw7JoSw8YNLGyOVKT74x5zoK6B?=
 =?us-ascii?Q?kbIMR9V2pF8rp50ds6ozPocnO0OznnEcfqPRIpYU2/xeCh0YywiPMAO5Z2Fn?=
 =?us-ascii?Q?NNLxLGC/AKlUnblMrTljYr7WQvZEs/dDkscu354CIwAUaTsTYLinHwsCFGNJ?=
 =?us-ascii?Q?eYZrHf3Pi5DDWG4+8//Zn5kgRfwLw+ILBu+fPxpVKmhF2exQb+wcdlZXm9ZS?=
 =?us-ascii?Q?1e9Oanc5G6tvui4QbG5OrNzcHmjuCZm7iLZDDVFWN4q0uhNJvk6HlgI+Z0nF?=
 =?us-ascii?Q?oPDfCn7paz58D8SmRVvBn3JOAvKbn/aYSlegINZ04vB6ocuKMYH8QPMazYHt?=
 =?us-ascii?Q?pH28rxfrklPzne7/VPIdNdr0HvGEK9Tuz5QlVIK+FPjFfCroUPRz5HNIX3eP?=
 =?us-ascii?Q?l2mqPMd1811DWS4YmyYdNoDojb7f3Qb2LrjOTE6u7TKDc+YOWmgPgwB1WRk0?=
 =?us-ascii?Q?iYpPNTSUyDoN6e2Lma/kx345R6nmaR2jcOfoWW89XwJpop2ZOepSHmjaxPFi?=
 =?us-ascii?Q?f02cBhsW4JkFVxa5L6R46hoPLuXhyy4/W1cVvwKzn1wAYWwRGR6te7AeO+iA?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb6815c-2e84-413a-f672-08dac25835b4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 13:42:14.2340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wtNMI8wTYpWEN6SsgB/CeHaoTuItycXuDvBpTrXGr2ifOJOUrQtmM1dxm4ip97YhNQhag2zmPN3tsbXyfkVJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090104
X-Proofpoint-GUID: TfL92OZ6CTu4Z4YCWvfZ9Yg_oI7A6-wr
X-Proofpoint-ORIG-GUID: TfL92OZ6CTu4Z4YCWvfZ9Yg_oI7A6-wr
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

