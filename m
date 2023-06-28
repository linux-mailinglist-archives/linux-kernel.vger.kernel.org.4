Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32A5740A24
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 09:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjF1H6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 03:58:37 -0400
Received: from mail-dm6nam04olkn2073.outbound.protection.outlook.com ([40.92.45.73]:28733
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231748AbjF1H4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:56:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJCFe7xmu2mgJEb2TxL7masBXdZW18VPqKSiDZBgxMAgUwAZDMSrX9tIUPlaRrjkX5+X+l/NOyTyRJ5tkl7Pf7fsKzKbUu0a9rB7amDtEi20zKUfsD27Bu4+qWo/N9cjE/vdUBdPVw0qMywMBKI4Kku3z+2o0u0q97onbqnwnszGNmIRStI/+u11Of3nMLVZhzhKb1CyaJX2uMC+0RLSymG4g0ydQwltzDP2bVuIrefWOrW5auVS9aYKOF06yvLlDy7rRNHR+VpGpfEAQHJRFwotRe/gV43NtspUh+AkS7Af1p+J6F+EDXP1eoOkjeLu/cd0W4Q/+6teH7nRoA/D2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7r91z1X4c0FZ7iZhfgbqxVvpsyFW6Thj6k+2pT2XFk=;
 b=kbr6RKIZm9x0AaFS7anX7GazDWAThPF+PgEQV4Vfau5o841WCVw+NVkgr5oDm3jrgdrmWeewbouL5cK35cnmvIUnC9OLhVQJpnBwJpMQfayBWXqv0gqHl7+doRI7hY1ZaKF+qBy6v6I28iRrQwrr7y9igSD5UCCu+7ftq+5pmbxgKpXk5hgUuF+dA7JppuWvXJr6PzWzdAeDjQVjIo26RHyHmAuPsAtTOS/m0Iy+0FLAf53hpGnvEpRiSZdFbLEk3skihGSdjca3iYuUPPUfFMq2w6/dOzNJEBFp/5NdN3p2cmkgWr3rR3J5fCDznPH1KmHaLXzfa0gmajjj2pmZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7r91z1X4c0FZ7iZhfgbqxVvpsyFW6Thj6k+2pT2XFk=;
 b=Mi1LSS+3FYkcz1wQKel+3I6RilETsROayTUp2VcLvczc4BNLJ5O/MACZ+ZkA3S31Kmxg9WIMJCl1W7pwursLFk8rlA2jAn1IqM+hfUJZXA+mpTFTJvHkUgRbm0TGfJQWCG1znDVKHvDoCpyByv2MLNVEh/PEP2pgFoSs3Ith/ZhgM1KYQpR8yCEdOa79PM7OQuYfmQTLT9519MqR2dwAxYbKJr7ZKJgxxuPEa5cN3MMDWBAKFfdd2AT6vh9iL1LyxZS3SADg8z25lc+7SJkpz1XQUudrsWS2PoAE97qrQtwgFSh9EepefchFjBO/32Qv7bu7kEISycpuc1JU2GIRYw==
Received: from CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10)
 by SN7PR12MB6911.namprd12.prod.outlook.com (2603:10b6:806:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 07:45:04 +0000
Received: from CY5PR12MB6455.namprd12.prod.outlook.com
 ([fe80::f849:c65e:3d5b:5d]) by CY5PR12MB6455.namprd12.prod.outlook.com
 ([fe80::f849:c65e:3d5b:5d%5]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 07:45:04 +0000
From:   mirimmad@outlook.com
Cc:     Immad Mir <mirimmad17@gmail.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] FS: JFS: (trivial) Fix grammatical error in extAlloc
Date:   Wed, 28 Jun 2023 13:14:21 +0530
Message-ID: <CY5PR12MB64558542113D0368DD98FA62C624A@CY5PR12MB6455.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.40.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [XeZnY3Yqkxs/mBCyrx4nPnplBakSoDF1OIem7rUUvYTnjEoBfhLeNb3UuC998sFA]
X-ClientProxiedBy: BM1P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::34) To CY5PR12MB6455.namprd12.prod.outlook.com
 (2603:10b6:930:35::10)
X-Microsoft-Original-Message-ID: <20230628074421.11317-1-mirimmad@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6455:EE_|SN7PR12MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf9536d-6a83-43f4-4ff5-08db77ab959b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5r3QR5rgPiUggiu/bYUMtQuSUZ5onasfX++37s/zcij1tW6ERrzMS5KpKWzbYQFh6SB6zDn27Z+Lq3BXI71zALvCTx04pObckQqCAnm0CHa0ks/3K3Er1fDeXuAfzeVBToTXBJcFoRv6rMuCRVmPz/Vz9/IANT6kKytUfhyqJIgVfGeruidAjp642IUAIlS/9jmp8Ult8UC1ZwYLT3N0ANAeCOMajCz9rrbTRlAmaMFw6dqHrcuAqfBlBpMX0qjjBlqATSroUfA4iqU5M/IhbbXYpo1YOveGqDPpUTA/9BwAC4x/1taXwiPY2vk+HI9aI2TnAwLlGUYf2fBDrn7blRg6E3626zt/1wvNI53G8nqVhsWI37llv4Pdgjc/c7YnYGC3DTtJ9dRxfL3JPOmMxnIzwhGlZC5q8Fn8Iq67Lj4k2slAyks6WujRFjTC5pTDrAdQ4ItkO3RIBzeojH1x9bKCvZIp9ESlhtWT2j6+a2XjaBExoqef88BWHU/0Nr21Dv9f/dPmTiJwDuLpOBmgI1MqcdLXElTVzc4036AQI/cv7ur+49ys55E8mtm7d/Q7
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8TQ4qYCDVVzBdn+0oAboqMiXUoE+YxKSy7ZsJcSjH2xQbat9GTfXcfGEJ7lq?=
 =?us-ascii?Q?7d33E5iLXDjlhGzEFM+WI8lyDky9Omy8IxQPcgZ+ea/Uk4HkQ4r9aYvWzJQY?=
 =?us-ascii?Q?psfoDaaBMn4SO8hQm9hwV16YU4XGPWrkGEB7RFTEYsBps85IfNUzMPPmpgTz?=
 =?us-ascii?Q?HSnwETlr63S92YbYqpQLdMAjMYzuj4DCKyJs6/kzL5ZGRuKwLxSj9vaBjnta?=
 =?us-ascii?Q?BEQ1nnqDR5cUaQ+dSbz9MXt0VCR9AyrJX2so3b5sUlclIKGwyqqUOMgtXkFY?=
 =?us-ascii?Q?oYx3MaiGt4X8Ul9PsiQrAcnZUmV0+ieEmYoYWNXb9XwQ+ZnddNxGpuMd9Oez?=
 =?us-ascii?Q?6U64iHWJziRfytz6F+Yw+922wk9YJMfjMjyuXw8TzglXHM1c1sqGQjyB7jLb?=
 =?us-ascii?Q?M+3iJiSkBRfr+ojlCfOWU+gMGy79V659htDcE2km5p6vtXsjA+l3+W7r1l3f?=
 =?us-ascii?Q?kHsRCttf4cEABVQnQlqQRo0xPWAxX/bAIPjF6bBgOi5kqS27FtBe8yCxKak4?=
 =?us-ascii?Q?FDy67sY/9g9JJG6EPhbb2jb+ZNsON3F9NmN78vB4V+n1u+XAaKoxXgX3X8eJ?=
 =?us-ascii?Q?F9Bxjn58m1uNw74Bd07lOqBFIC4JoZ75h6KHy+c7tTDTjCKXq7kavotqlOjW?=
 =?us-ascii?Q?NRA12MUZ/klz+SPg+cKcEyFxbVt7ukfQe2IH/xMPuG65xtKuvwtTN2vN0rqs?=
 =?us-ascii?Q?yy499yXmEs0DtmKH1etoojjkahmCedwjs0HCk553AvjSVPED9/Dj+C6PyW7b?=
 =?us-ascii?Q?vnl506FygiKtQaKuL9QB6hk9k5knOsKPQmHjuI7Oob8FW0utANRz1gZCmGHR?=
 =?us-ascii?Q?iNkDyVGvqnp9BpWWC1xN09D2V8lKGBwUTDcBa5BJitDQ0uAfXTd1lVGc6n8D?=
 =?us-ascii?Q?owhZJCCvNPKz44g7KTESa6IgRZrZAcqcUeBZWnrJby96wNAYrTpJv3llAaOa?=
 =?us-ascii?Q?HSpEEMu82lISJyVR2w3OGCsMEd7Yb/9axPVqfYptV153aPzA4kQuqDDG+DBl?=
 =?us-ascii?Q?rZbmKZZMk1BZZTnIcTOx115AWCtU5Z76ByAPpSf8LSdQHuW+NA6STMTY6YIc?=
 =?us-ascii?Q?/ksYwDgmz2Dky9ySTlLKH1EySAIpsx7Ls6661nriRESYLcVBMwuAT8uINDn/?=
 =?us-ascii?Q?DNyNuvn+jLLeLd00UPXJPO24Ws1cLQPXYFhqT/3XILGuIYJgwR004WsBDenN?=
 =?us-ascii?Q?tWqVaGfDhcMFLstMq/PPjgvT0Drx0H4C7PXcfb8wa+OfgLIgw4X/G8IorzMW?=
 =?us-ascii?Q?aViy2ms7l4mZ43lsQ1Wxo+SV93anoV67uwIiQYJfwA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf9536d-6a83-43f4-4ff5-08db77ab959b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6455.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 07:45:04.2206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Immad Mir <mirimmad17@gmail.com>

 There is a grammatical error in one the commnents
 in extAlloc function.

Signed-off-by: Immad Mir <mirimmad17@gmail.com>
---
 fs/jfs/jfs_extent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
index ae99a7e23..399492308 100644
--- a/fs/jfs/jfs_extent.c
+++ b/fs/jfs/jfs_extent.c
@@ -166,7 +166,7 @@ extAlloc(struct inode *ip, s64 xlen, s64 pno, xad_t * xp, bool abnr)
 	/*
 	 * COMMIT_SyncList flags an anonymous tlock on page that is on
 	 * sync list.
-	 * We need to commit the inode to get the page written disk.
+	 * We need to commit the inode to get the page written to the disk.
 	 */
 	if (test_and_clear_cflag(COMMIT_Synclist,ip))
 		jfs_commit_inode(ip, 0);
--
2.40.0

