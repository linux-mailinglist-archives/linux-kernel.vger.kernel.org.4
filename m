Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CE561038F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbiJ0U6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237292AbiJ0U6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:58:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7414779939
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:50:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RKJ3au031832;
        Thu, 27 Oct 2022 20:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=/rL8IgrK9GQ6C3LokNzK44p6vggoezQ5KXXYEbB9CC0=;
 b=MJHKuBV71ZVCsJ5AoQs5JhMzFmmvIT84xxieY0ZHJmcVlMD3h2oqwI4CfUUdOTCPWgEn
 lNlsqnEzsf37C9VZtU8Z/W9usSdvWmulNwNr4fPRb41K6oZMkYfeKB5NJbZn1Nl7HiFa
 2c2Y2Oe5fhEmhmoJh+I1nDuyiFh1S/WAnU93BZ84KQCDfvFtr1gCii6k4LRkoMQy8aCy
 kTVghSwgdxsUU6ES2wQl2VbnE6g97Ly87I6xIgpqMDy83QiYokUVMOrA0orujtDXvC6d
 wGw/LcXsBtYDedQ4eCSqKtWqhrnSSEbvaFPNEwHaRD05fTa0nw9toW90TmjU6Qb/vauK qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfahebp5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 20:50:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RIW2jY032545;
        Thu, 27 Oct 2022 20:50:20 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagnddns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 20:50:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNu2q4Bqr54P97RCOVQnCJdvbl9rypm/UyLlxfyJjhUPzTe+uHy0Y5ip6AlvyiRaUFLs1BiSQsn9k16XrM77Xc1eC/kSAya1OrkUVaUsplfnskLM4oKrtr5Pe9wrBSCXZMt6ZZ5U1vZyGHUEh4xStOBHzMZkteMjdeWLCXDPFeYw49zNzXGDfhWy2M3Hbgn/eDmKtI2YT5n+s61LooiOjbuelwFj3X/8l6aC3+/gEiPAQ5O1HSz/LCpd8UfsYeNRtDvD6bAYT3kAcGAR4/+fquQJuxS1A4s0PHfa/clP+Mpjll/zAQ2hteG34f+zlwkuLc4hz3brm/3oiA5o4/j5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rL8IgrK9GQ6C3LokNzK44p6vggoezQ5KXXYEbB9CC0=;
 b=Z2u0LjqqsdrT7s2N85nbtFc+4LWL7cat/LfpgARegXvQ3s1WM3Uv6zCGaXELJ6R+3sgg4P7SFDLl1mq6xnUDvPX2WbCE3MuQGZmHAsFe91LwCfzkMXFMLzoPayjhXhr13BbQmmhhWjxOPwlwqHFsPQtoU3Hx0/dhp0ZRCVAns5eBtODezTCPtmVBTQpie8mTv/jKv8KPQja2o03hUtWU9ZtdxP5/Ddr8a+89JaGrbJkQI730uw65/NTuPCKa6eXpQCQYPWwJreec9YZxUCwfcma3G4NTwkm7wV/Fv5nxbvBsJXxLkiOV00MuMOHNKJdLHKxkKhtAThBHXe5GYumzMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rL8IgrK9GQ6C3LokNzK44p6vggoezQ5KXXYEbB9CC0=;
 b=MU8csrH6Ylhh+V+0+8SvkQpJjC+8Hi3LZinoyHwsOCrPZLOB4PVBYU+R9Pqaml3XigEeFqB5mz/GpzcJDbfEwrk1EQAoIU87Ehvuo9lqP03uJRO1ws2UeakBE146vOSNN98a+Tl1neTLCp001whEGpDV6m+UTfxCYLz2eXVKU+M=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SJ0PR10MB6400.namprd10.prod.outlook.com (2603:10b6:a03:44c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 20:50:18 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%9]) with mapi id 15.20.5769.015; Thu, 27 Oct 2022
 20:50:18 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH] vmcoreinfo: Warn if we exceed vmcoreinfo data size
Date:   Thu, 27 Oct 2022 13:50:08 -0700
Message-Id: <20221027205008.312534-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:5:177::16) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|SJ0PR10MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: da5fbf64-72df-4902-ab14-08dab85cdb25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lpi7cz4jEQ4RZYipK4WX9E32i6I+I4DB8T5B5kAI/7Gu6d0LfZhwPTRNCN+TVtnWL3XoiZb9KfsswbSpAer9N050434c+VHU/Z90pyPbDYuTisoey9yE5DBcdw710jDNqcE86hKl7Kwi8l4dhFAq9Q6oHomTGuQGh5rplTrSnTdsghWDszq9nmo1DE+yKYsZYr6XMMCCzbreeDcsS6a7hEiHosls+a2KPt6MVwP/jbzV2d7350sk3T8viCka1b+x4qyDjyPPQW+KEh7MSkBTvFSQ8u0+/CyoSnct5MXQDqfPMJc6BqWjyk66AenOMHVJoVd0FoNIpLywmXdISXtdUNTZse8IoUglHxdmXH/cNungT+oMC4XLD6GmU7xZ8hdObMyBCtrYyHocChtWFPsn6xBB0iT3U+jKxsoIFSqucIBkybKRf2n0imkAcoGudRxDGglG9BUVJ06YxqqLFVRvPbTfobh2pcK0FSsPNI1mj3zZi/tRsh9LN5MfGrcOSoF4oHSuvbrcT7v/5TvGSTrMxYmF+IBc3vAh8LIYQLCwNdK06lNaQbYlZ9/c3Ti/1YTfzFn4S1t/2prWyCuNlsEtZAidPq/E3JzK790xa7UY1pe+r9fLSz/iWsvX4aehFLE51Q30RK6NlP/ib+TPTtSIWskbfHrXPRJYFh+YSEznz8ZwFlNETySAQ7r6qieiLMsb/MdHQOx4JsiBxx3wJBG3bHGyuR+JoPRhj+gUQurDd3k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199015)(36756003)(103116003)(38100700002)(186003)(86362001)(2616005)(2906002)(83380400001)(4326008)(316002)(66476007)(6486002)(26005)(6916009)(6512007)(6506007)(54906003)(107886003)(66946007)(66556008)(8676002)(5660300002)(1076003)(41300700001)(478600001)(8936002)(966005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y0lPcquQlI1qTcd4e9A4LwJkW9nr7XXn8Ap9jII+/YDaC7avOHkO00+YiVRK?=
 =?us-ascii?Q?nVh35rNV8RqD/VqsTv4egelzb49x3tF8LEMKZqED39rP6H90DrzzeiHMu+r8?=
 =?us-ascii?Q?DSh7JLyPqDoJpwKhBRz6X+YEddaTE7HKoTrcJoHA0JSH+/UbbTwoHWKLDZKh?=
 =?us-ascii?Q?8kC9XFavvcJ7O/2Fr37FTL4hahkSuBwMrSPNCoIeG4ORieNX4Mme9n2udA9q?=
 =?us-ascii?Q?b4YrY9lxSdGhTnL2P/5+fROyZm3cJAaO1gwbkpf5E5svYcjlg/lI3RlbrR3a?=
 =?us-ascii?Q?Y6TgqSKjVyhj9znql9kwSCiZnsFR4pr8FG3RGwNnUwBZVeu05+Nw8nxMBiF+?=
 =?us-ascii?Q?dQ9S5cJVQLrbjXy756Q43C8hX13743BlFYPcfEkbJVQRuBxSoYcQCop9oc5m?=
 =?us-ascii?Q?MrWqcgHTRzc5xlla+yAlyayNJlUjPEyKHtboXHogEdYl/mvp8AmCVit2XQIu?=
 =?us-ascii?Q?2UcVkoo9HdmkH47edautVFSp2nnoc+0fBkvrmTUz+sIvyN5zHMhNy/PIqdy+?=
 =?us-ascii?Q?K+VbdJXybdPzyQ1c5n+z2/MFGesLBpjuRM3MDJ1dDp2UPmDUXExKXjG+XwU/?=
 =?us-ascii?Q?GzfpmhlP8xr1KFKv2YfSGVhKz0A7OPIQhCYKUkcxpba1u8YrmuC0qkqg52Pe?=
 =?us-ascii?Q?/nik35MzBEjp9rGDUK/lAeG1ZwnKy2guWnJSidS/n2ReU0/GPLcFQGrvRCf2?=
 =?us-ascii?Q?AhPBc2DCzcHXopYlqfhyG15OK3Q3MDi3Muq+7CgULhgkGvZoRRjn8yVZ5byB?=
 =?us-ascii?Q?0UudyoIgHomVOVPWDMJP+3/f7r56si/CMyjGmGXyO8/g0YAT++SpTAuCvq2Z?=
 =?us-ascii?Q?nRKZZmjJhr6QN7Pf2IaVQU7JdTm7m5Kpk3PcsQwF5BEOmtJKCuld0HvdCA/5?=
 =?us-ascii?Q?iI+mB1fgNjY/Nf6m1POryElFIrhKhvcBGi82qJu4h7oyz3Vrb1I6NMti1tI2?=
 =?us-ascii?Q?3MBcZi2A9e3NFyeEv4khJbmS3UDheKalXWsbPjQRkShhXwfeb1FxsECRnjDm?=
 =?us-ascii?Q?8a9l8v4YBLhaBAwpUIR29itU8lS6QXuTl5MorX121x9F6WpbKDaqplK0KB1A?=
 =?us-ascii?Q?7DzW6sTCroFjkWgQGzpArbr4m/GEk/k3auKEWBaeHAJJYDUVYN8k6K7G/0Ak?=
 =?us-ascii?Q?nmfZjsXZNJEDIZMl/3Ue1k9JQAxZsATfth5wg0GWTnQY5Clnf7P33HkST1Lt?=
 =?us-ascii?Q?Eh445Z8b7jl1y/t/Pn4rKOp7cyJ5C6Tx3hfNDLo98HouUWt8Rm7NJy+7PgDk?=
 =?us-ascii?Q?/L09zXwXcFyVmVsZX4wPKbToLaOM21nqTdfAYqgFdyfUXa24KfC+7wmhqXkU?=
 =?us-ascii?Q?Yw2auRqLd8vM2e+8iQrRh+JmxTJhvTamIk5PqRj2kgyO2lzP+K70MY+kidQf?=
 =?us-ascii?Q?noaTB3ip7dSFbA0cCjqCtQ4iv0FT5US2Fw4Hd8CRT+9PEgmB+idiwZe8yt3Q?=
 =?us-ascii?Q?jd+Jn3f/Uuq3BFIOR0/vKcGMRwFzL7zDFGCsGkC33//9B/eSuJBQ38OR4N/y?=
 =?us-ascii?Q?0czFuBwqHsuH9D5w8YJJh8e3BzDhj19uC75x0itfmCCb+vaUG7PfzP4O8D0q?=
 =?us-ascii?Q?Nw93pS54m3QjGPyuJAq3dUzVr02EaBbmHBRt84g2yJzEJVjzRUkKcpJK5R/z?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5fbf64-72df-4902-ab14-08dab85cdb25
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 20:50:18.0933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zf73A1vbMoERzreshDfFU9UxhnZMPLEgN5sPaJyjS5u4Axv6xlsJeG+DQwdONIGgW2JGwxTkWPXrrQzyykL4FfOuH+lav3a36SbUzacBZjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270117
X-Proofpoint-GUID: tQn5C155CiT1z7PsYYA92bz1l9xeyRwi
X-Proofpoint-ORIG-GUID: tQn5C155CiT1z7PsYYA92bz1l9xeyRwi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though vmcoreinfo is intended to be small, at just one page, useful
information is still added to it, so we risk running out of space.
Currently there is no runtime check to see whether the vmcoreinfo buffer
has been exhausted. Add a warning for this case.

Currently, my static checking tool[1] indicates that a good upper bound
for vmcoreinfo size is currently 3415 bytes, but the best time to add
warnings is before the risk becomes too high.

[1] https://github.com/brenns10/kernel_stuff/blob/master/vmcoreinfosize/vmcoreinfosize.py

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 kernel/crash_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index a0eb4d5cf557..87ef6096823f 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -383,6 +383,9 @@ void vmcoreinfo_append_str(const char *fmt, ...)
 	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
 
 	vmcoreinfo_size += r;
+
+	WARN_ONCE(vmcoreinfo_size == VMCOREINFO_BYTES,
+		  "vmcoreinfo data exceeds allocated size, truncating");
 }
 
 /*
-- 
2.34.1

