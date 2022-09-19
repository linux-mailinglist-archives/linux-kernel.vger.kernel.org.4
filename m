Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5615BCB68
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiISMFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiISMFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:05:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA1B275E7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:05:13 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JBx8So020158;
        Mon, 19 Sep 2022 12:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=UVdVAsADEvNie8WiD1Ztu2tPcGfyUDYzBBIeKtHoh20=;
 b=oVQyp+eW1ftDh+hvqVrHV13h1/H6ACJ92u1ekzxeV9Gu+fKd+O6rHYbRfGzsoQpnwqes
 98Gy6RzrQPzCjx07WVe+karYz84f3VeXYOvEZrAkZ/jaLUFDrJNBBEDf9NwUQWqs3tYV
 v6MKFNx9PZe6omPfNemTphw8ONulnwiuC06wHVH+FDP0oXXqR55X1cbrMJz/dfGsiRsk
 LqFbSXdXtgjjqqX2B+ovoIyfhczXa89/R/+SNY7uZBVw2+CppYrBQ3WyKhXMAXprmKfU
 pm7+69Tbbetnrof8wr+M70ljvNi2fLpwfd9XbgLMe4HUcGvDF57wH7yXO4HediC0H1Ep pg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn6stbn62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:04:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JB8ufV009901;
        Mon, 19 Sep 2022 12:04:46 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39p2b78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:04:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYN0SiETwl4KSB63L7tz/bydhnbVjuPaZOa9AA5GisRMesLaAiqtpnnugGQuMus2k2HulnM/f0Om7lU8eKm7XQ0hD0WRpnd5g3yG8JBM7UAKBeJpmALtX3ZTbl6GRJ6Cgi4UIzy2aMhYhAiyAMejJbczWUgQX1PV9xz05vDDnfOSlvUVpx/4Y4zXybfLicRkaZ00UPluHgmstr1yDdVTzbr6YEMLK6lT1h7Ra3Snk+kxA3XMSowhGnbDnkIGZX3Ze4jay2rlEftpBK0+cV268tjFE7E3bgM9e0arnX6ZpLPelmP9YAbw6E4O9K9MVtUgtIwWW9g6opSYSlLOhZr5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVdVAsADEvNie8WiD1Ztu2tPcGfyUDYzBBIeKtHoh20=;
 b=Pe+sE8lfsGuH5O/G0+vEF4NU0w8w1GN4BopZ43Twd9se7fdbEGuEDOodS5SQO8OsSsKOsF9uFs5bMqu0OWZmXyrB3uPDhnwGk41UkLcWH/d/KK7767vhh8AMcKDjB9eUp4p0JKRRKrq9CgOGaVMu7u/l4dT//NHdiRMNt7NcQaNBQmLwaEkY6glfG5VlZcWFx1WMCT3jW0jSuIcjYWGEzHK2rRR5+HDpgZx/nrojl1J24Ngns9WaM7uQ97qv34xfDv8WsTrxNzd3F2xBZFnXGnU0wl7EmFbRKaeCh3oXqc8HCXIZOMaTt4QzCbJ8w0Nxur6CLMhz7xfYMg54aMGynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVdVAsADEvNie8WiD1Ztu2tPcGfyUDYzBBIeKtHoh20=;
 b=uGMp6lJaEoq1TScFnu6wYVE6ifYEyT7s0I9cN8MMgEyXw/mop1n99+SXVnZqteqdnn/YoYrmSKkp4ynem0M50zBG7l5Yu0zBBc63e8AB0Jo//9Fzy5u/Gv+qF+Q9CJDs5J8jM8BFngcMmr/wrZx51o4x0VnK1C6dLKV5tNrvNr0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY8PR10MB6826.namprd10.prod.outlook.com
 (2603:10b6:930:9d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 12:04:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.016; Mon, 19 Sep 2022
 12:04:44 +0000
Date:   Mon, 19 Sep 2022 15:04:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     eadavis@sina.com
Cc:     almaz.alexandrovich@paragon-software.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzbot+c4d950787fd5553287b7@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [PATCH v3] fs/ntfs3: add a boundary check for EA_FULL
Message-ID: <Yyhaw8iBPulIO0Pp@kadam>
References: <YyhHowvgEarPqONR@kadam>
 <20220919111954.283125-1-eadavis@sina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919111954.283125-1-eadavis@sina.com>
X-ClientProxiedBy: MR2P264CA0009.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CY8PR10MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 6073fdd4-6066-41a4-f705-08da9a3723ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uUWxDrKZoFeMU0yQ0UiC4bLx5npNTty+Ljb4ooAHX2/mKpfCUP/sQcn8PK+w9qb2LTdg1UxYwfTOqwz8zEGXrpGITRAplrEVnuLGXjQgMSYh4yDwLeUEzVbkHSADQRpH7p6iAVxXKyfuojx3kqFdktZt4SqPMWcdgBChzFmS0v+LkdAj5yocOn6iJrZWPC8vmmQIZfZrVZm+D+Hd7CwHbjsE16mw3FGXy5fA4vZjYCrmlHAHBaAvIdM+ywuFvWiuM/mIUY5EYYimzsQ4DDuKiBvFHt87jDT07+SlRt+LUDNhSAG7EzYxkkrkbA2rNHpkJUjCSBQMUaQK1soa+p+1xat5A4KxUDXgVfpZDqRfjef4uHddUDn0Riac9lioGuT9SbbXKVnY+N8rMppb9PL1XucMMkwIWuNnOmgcfku9rPI522gJOoOboz81hgeC6sQYcVdV5CPXI2i+rMUr6WcAYB2/yQjvIXoGBNMDIRZFEL9AzG5vdIDySkxQ4Wzpq9viJM46EtV2eWgvU0TMDP4DJDIXsTzzSNHZNZAB6qQzPWfEKFX0gV3fu7yjiu4E/zlT27U7aA2Sc8srA53ASx9TOEZ7MBY9pW3spxTLESfRHC8/2IVwyRf0sdKtqCGXagCL9labcjSFv1MeFwqI3ut2/dAPHFrY8Puc2wRjYMHxenq2hj2xuboRhtCtgzrNOZ1pYVqEkucKjC7QqDPsxMWE3CIrE3Gam+kjQ54w4w6HoIJx2Ob7kYEfP+rt1atnyMayVrUSkd9NJRdoHfn+pqEY1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199015)(83380400001)(186003)(966005)(33716001)(2906002)(38100700002)(6486002)(6916009)(316002)(4326008)(86362001)(8936002)(6506007)(6666004)(41300700001)(478600001)(66476007)(66556008)(7416002)(66946007)(8676002)(6512007)(26005)(44832011)(9686003)(5660300002)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8XMOqpo0T/i0lDnhXzXUWYqW3N8Msx0D09BIi271Bw1HFyieOtpf3vr8Yq22?=
 =?us-ascii?Q?JVV2ozoNA8zzO5fPWsjTWZozxKhODJ2Onj6AwFnyUEJroY45Us7yRZE3EGn3?=
 =?us-ascii?Q?NEPIkoPERlqs2XNmrnJz+6bbOQQ87FUdM/EjGHR67UjjKGqwYK7iPlcELj9z?=
 =?us-ascii?Q?+i/vNcgWBuLb+r9T4ZeHZ733o42pEn9bc7BFmumEtKCArEwQqquw+a42GlOP?=
 =?us-ascii?Q?vw7LyqKxu8+NSsNjivhRcO6Yarxz7WF4M2P3IEOLGqlogSdK9DSvc6Q26xt3?=
 =?us-ascii?Q?YkIpiCqERgf73Z/GLmdAVHs7A58wWGLV8HiNxGv15BC2U5f+H8/60Xfgu3M+?=
 =?us-ascii?Q?sUlz2aHpj3DWkMci2wizjirf0bX2JgWL9HXZRT3YLKuyxGEcy2tmD48sleB0?=
 =?us-ascii?Q?QS9lGqA45vn5eh0rWOcSPEHMsftTVrxh5A5kvALnJc5Qu25Y9GcMuiPgPuDq?=
 =?us-ascii?Q?xJ9lHzg4WRDvjs0m5aXk61EVvPgU31ZaswNh+C4utRuSItAE4W4UBPmZ9u9I?=
 =?us-ascii?Q?l4onsflfrVX4Xqu7ImSHUL/KfMadZuDEJItWpeRh6spTo6K36MpokijAjreY?=
 =?us-ascii?Q?VYsEDEvboJUlylflom59Hmz4PmNSXIqRUbHRstnnQikyH9yEvQxDJqOu0BaB?=
 =?us-ascii?Q?c5dPcbfxORxln8JFkdpMKKaH2ZUDqTMSjvqVSGhICqaOhx4wgaZQ6SuYTRtq?=
 =?us-ascii?Q?etyw/T1DgiKg47xLW4ymLhLLna1w/P9lDxB68L7bDUQzfRfhbRXlBvogS/Bq?=
 =?us-ascii?Q?f2Imyo20Rcp4oULLywmsAMnuXOFPjdEpC8BLsodf9ERsnocpfmaXuqj7NG6w?=
 =?us-ascii?Q?r8upUulhNb4xSe+t/M54I2SQ8ju2xmaUy/MhnETHVfyiYBTsuV9AjZMQPych?=
 =?us-ascii?Q?iFrbfKjI7W901sdI1zci7+XPf6J8So4GEHKYCgLdfH0PHLYFjMEPejkHCdEo?=
 =?us-ascii?Q?B6lMTy10SA0YZ1H5idUQTwMe1byp3RHYCvj8DivB1cSMcCytC26fXDRXKhpT?=
 =?us-ascii?Q?0r3OiDv8EDdE+zN658M9pN4TzYFYOkdL5HbbofdsCRL8obgu4ITb1QTj1tSg?=
 =?us-ascii?Q?oUhSez7fwaTzOECUl3lbXXLJ6tWePecNsThpUZRtRscQegau2saz5iYcC3r/?=
 =?us-ascii?Q?TFSYJrq5CpGqUfsy+5dDcQhK2XJFAV/rAs2ZEgh9yRusvjJ4mIe+QSxjcDCP?=
 =?us-ascii?Q?Io9j76RZB0+7VuMM39S2lRcbYijztURySIbjJ5RPcIi2ss9jy2Ozvv/Fx2aL?=
 =?us-ascii?Q?Sb3NUcJ7UkMx2+6TSLHHZpM6E5M0zlQvqdSBGyMKU4oGuEmH7HIaq36y+aJi?=
 =?us-ascii?Q?V0wCf4mmhkPV3HmbMZhWwWqexG5XP5rLs5+edt0D16i19lXB5TMjuGJA53v1?=
 =?us-ascii?Q?g1PuHE68kkXU77mneSFUCxhSjlrDzvJVL0Ylgjul/dFQjhclPpwdXsu3Nyuc?=
 =?us-ascii?Q?hY69faU31Pj54+1+JotP7Te0KiSU0Vb1CURouyw5tA149uf8FsIb6UIw0T3k?=
 =?us-ascii?Q?RelgmX+nEoZBgsT4tVDO5iTd141BiSreE69kvjR7qRVnj1FzJcQ/HkBpHUYL?=
 =?us-ascii?Q?rrbSHqbW0NKoIWXsPgx4d4cNLAghUTeMIU+j2aRv2gh2EbM3JIsliQog/XrA?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6073fdd4-6066-41a4-f705-08da9a3723ac
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 12:04:44.1731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2cDxR3Y5KyM5+EFSi1tFSECkE5BMIXdGg5RzQNkQ+he3AVawCaaT0q+LEvH01P5H/optDyYZ6CvIFxSJ9yEZp/nUjYcaWEXNLA7YU3v4ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190081
X-Proofpoint-GUID: 4Rpih3-1iIM0uHw-JzpPw2MnaVqsSofh
X-Proofpoint-ORIG-GUID: 4Rpih3-1iIM0uHw-JzpPw2MnaVqsSofh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is useful and shows what the bug is however the fix needs
some additional work.

On Mon, Sep 19, 2022 at 07:19:54PM +0800, eadavis@sina.com wrote:
> From: Edward Adam Davis <eadavis@sina.com>
> 
> the root cause is: 
> The remaining space after the offset is less than the space needed to 
> accommodate the next EA_FULL struct.

This commit message is not good and does not explain what how the
problem appears to the user.  Don't start the commit message in the
middle of a sentence.

> 
> Link: https://syzkaller.appspot.com/bug?extid=c4d950787fd5553287b7  
> Reported-by: syzbot+c4d950787fd5553287b7@syzkaller.appspotmail.com
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Edward Adam Davis <eadavis@sina.com>
> ---
> Changes in v3:
>   Add Suggested-by: and fix the syntax err.

This is not what I suggested... There several problems with this patch.

1) If we call find_ea() if "bytes" set to a number in 1-7 range then
   then the unpacked_ea_size() is an out of bounds read.
2) The *off + unpacked_ea_size() can have an integer overflow.
3) The math in "next_len + ea->name_len + le16_to_cpu(ea->elength)" is
   not correct.  It should use unpacked_ea_size() instead.  (The math
   is different, this is a bug an not a style complaint).
4) My one style complaint is that "8" in "next_off + 8" is a magic
   number.

So maybe we could separate out the issue with the buffer overflow from
the integer overflow.

Patch 1:  Fix buffer overflow:

Add "if (bytes - *off < sizeof(*ea))" before the call to
"ea = Add2Ptr(ea_all, *off);".  Then remove the "!bytes" test.  That
test is wrong and useless.  Also remove the if (next_off >= bytes) test.
That test is also insufficient and no longer required.

Patch 2: Fix the integer overflow bug.

-		next_off = *off + unpacked_ea_size(ea);
+		next_off = size_add(*off, unpacked_ea_size(ea));

We also need to change the types of next_off and bytes to size_t for the
size_add() to be useful.  I forgot about that last time I sent this.

After both patches are applied the code will look like below.

regards,
dan carpenter


diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 7de8718c68a9..bf53ed96b03f 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -41,17 +41,24 @@ static inline size_t packed_ea_size(const struct EA_FULL *ea)
  *
  * Assume there is at least one xattr in the list.
  */
-static inline bool find_ea(const struct EA_FULL *ea_all, u32 bytes,
+static inline bool find_ea(const struct EA_FULL *ea_all, size_t bytes,
 			   const char *name, u8 name_len, u32 *off)
 {
+	const struct EA_FULL *ea;
+	size_t next_off;
+
 	*off = 0;
 
-	if (!ea_all || !bytes)
+	if (!ea_all)
 		return false;
 
+
 	for (;;) {
-		const struct EA_FULL *ea = Add2Ptr(ea_all, *off);
-		u32 next_off = *off + unpacked_ea_size(ea);
+		if (bytes - *off < sizeof(*ea))
+			return false;
+
+		ea = Add2Ptr(ea_all, *off);
+		next_off = size_add(*off, unpacked_ea_size(ea));
 
 		if (next_off > bytes)
 			return false;
@@ -61,8 +68,6 @@ static inline bool find_ea(const struct EA_FULL *ea_all, u32 bytes,
 			return true;
 
 		*off = next_off;
-		if (next_off >= bytes)
-			return false;
 	}
 }
 
