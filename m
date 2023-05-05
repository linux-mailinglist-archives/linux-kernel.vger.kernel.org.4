Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1484D6F87E2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjEERpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjEERpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:45:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315BD1CFF8
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:44:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhOrn003090;
        Fri, 5 May 2023 17:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=vsLFD4dVDOFW21XGcSvKmJrAPSFOY+0Jw3IhJz6RmFw=;
 b=svqagWH6hJ7v01xGAAPpo/MCfbtDqoa8lfcsEgAJaDiyH9Ncj3K1n/VcfXn3DpjMhM88
 0QcwTcY8E1sxbwqHYEc5N+btfN0SBmxUpoclK4ACcpUe6tcKNvXxzTPRMH/gj0Wg5UCT
 f5zKIyhRCgjbKctyERo5C1SAv3EftiRwJiBtwAep4s1K+mj7Bmc76KRhDhPgoyV19GRZ
 AghxW9cDO8IIT0pC+1FpTW4Fv/Xb8byKfieflc0sfacc5rkOtnMPcWNSn/910RySSmeh
 HDgIV7Uig8j/LFXhvSF0otKM+ULVC1AH/GfHym8W7xY5/pDnpDV/Hik2+wyWozNx/HQ7 4A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qburgdkd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345G9u6k010002;
        Fri, 5 May 2023 17:44:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spank6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILGJ9SeYCsKbRPQDym99yPwkmBY6yx/PAIRgkb6fjxbHNB4bIqGJ0kSAcAUJ7gGQUUe9tcmrhlcug5xIcg8mJmV97G0rBs2Rr8Nf0rLSzYGYQeWinzdBxOcgEU9Vw37IIliPEFOxM98N3LOlxaho0VOsv6/id4biiZmMoOy+dKrmmtwPwauYiud/2fSR2H5JG/aouSeufNzcGTSP0gtJRKMo5jZx5kGDpKaoQtsDtzJwVFlHDmz3B7GXPbQdrR8etFHrrW7EHH9ILJ22JapTAsQHT10846s2ALagGHQ6EVNBnnplhuZAXn/7EEG47Q8FhK0dFsRMBmxNT9ZPUGROCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsLFD4dVDOFW21XGcSvKmJrAPSFOY+0Jw3IhJz6RmFw=;
 b=Gwmmkq7rRdeWHTzWTIPJAOBxAqIHIItuQUJ0LurHJ8Uvu+Psg4vFCg/3G+AE3mNcEMqTVdMe62/uWvdrayGu1o2lCb8XVRSXeiBK5xhCnW45hbuJN2bny4nGadoHhhmkYaGE3Gkcn/DUcfmDd+IvX3kxQFScePRliofyOUBbSGazIYdLei9JSBM8n/Pp8J3y97ft3gxJA4yeY0obMmU29hsxqmDu/orjeZ2aRqu6a4kM0Smn3IvULazE2vrJxoecAcZxAfTceWha/hfJvKQmLqQl5ItVHL7JcEz46HNcomfXWxKjkZosl02eQYAZnXapo54LRoh4ZED24Pc8Yv+KQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsLFD4dVDOFW21XGcSvKmJrAPSFOY+0Jw3IhJz6RmFw=;
 b=bsXDo//RRxsMqdDlpj73arzSEW+s/Q5LaRn8zgBLCMPEXiJy4ge5yQx5ISmOHhkjPAgdsqn4oMRl/k+3TdWnMZymfnpb2eymcO+oN+mCfXW0crLH+wXtIUpFo2lq5bzdabVXM25wMQr24ReulOZ+q+3Us3p7pT7RihXSUlNyEps=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:20 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 16/36] maple_tree: Make test code work without debug enabled
Date:   Fri,  5 May 2023 13:41:44 -0400
Message-Id: <20230505174204.2665599-17-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 2670660a-b603-48b2-7531-08db4d905b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8TGdmnkzIRsSFNkPqJNGpVn0bfO+k/vgQ8jnY3vbZu3QUOIeQxLloZuu56dA1UUCnpDhg/3M1jcy4Hl3Wy4AdnDcEISQzRdApPvHKmHVdVyOaWXzggrn1SzUmGw+RVhUclK2YCooSajirrCbv6Fiffes3HKRpisHIPsWWDsNhPXi7+zGQMDmGTJCq+4xUj4tJPCGbthSHXlffnARk72IFN/eoePMesmDTVmmBZudbF6HOvPEkh/S3ZdYfO2vi77FtTG069nkc85Tt92UEzPhyQkBzh9hHZSEBdKQpaRPfINbgzUlPu8lzY8d1wk6fg0E9w68YRRCVacAqhvqhx2u1nuyx7hHPyASeqWXZa2Ry8lBaVzq8MfC04imsb8ADSfKBrrvXSh+kyiEwOehIAr+WN+9uBhiXkNG2E/svbLqblVV5bOcGl60dGZIR6+nkDbJuUpUXEWG2EGqWv9Yf6XQ6w+Fbd6nLfeLxkuBKw7xBjTuPZnKfCECc4esXXgVAG7NpVfkQGBA7yfzDjjO3SWtjjeu+r5fadwNPRcgKZ/a42RWKO5KGOxj0OK8J3sjkGW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(66476007)(6916009)(4326008)(66946007)(66556008)(6666004)(478600001)(6486002)(316002)(36756003)(86362001)(83380400001)(107886003)(2616005)(6506007)(1076003)(26005)(6512007)(8936002)(5660300002)(8676002)(2906002)(41300700001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c2MOHj8wuPtnb6hy4CQ0Xf82O6ZqmJ9XJghZitue/6GYV3EfTt7aeVcERLU2?=
 =?us-ascii?Q?FYDa1SE0ek8GiekrcV5SVKfBbYSsdwzzOVtKzlyFqpzys5sYvvCG3GGDeCsB?=
 =?us-ascii?Q?PFuscM9Bq+v8s+TUNGTsOGnDgwIFGUsW2yz4hPSd6ZOb109K3oP0MGMHSa9w?=
 =?us-ascii?Q?QXN0me9csIssxaT5WdZD0DmdgpFvuuhPe7fW+jxAUprFZU+1uP1aJQR699QL?=
 =?us-ascii?Q?+J8Hfh7II2eBfC84vXuOz7TR9TM709cxrmMy1LfjFPoCavbcfUPwF43QhqP6?=
 =?us-ascii?Q?gBCBpSEdxwPWQx99dfb97dLiQOuuMsyCrYYkvKhvKDBHLt4g7TZOocFi3DZv?=
 =?us-ascii?Q?lpb4BuPqvRJkv7RuL3xQUtp7U2poQW+5hYpaGSoiJdJRCLHINqiX6N6vQvzU?=
 =?us-ascii?Q?ttl+fPvlyqUYTyqfPmB/aABexoRP6tIWAovTdr0B7UEUXTwMgC1fAUkrGx+N?=
 =?us-ascii?Q?lO4eZ01wanTDbV8xQIfCVALpAVfx+hCDyoZWx0kEOg8e+a95F56WLIG5+3xx?=
 =?us-ascii?Q?utqd3PU3Eadya4/BnUQsI8P2JNSux3K7BYMKp7Y0yTPuEGctgroiruieCGm8?=
 =?us-ascii?Q?GS0amdPOfZHMgvc6uHhtpKmeakzSVqyOCok0LmOVfOKUrFYyNPjLB4b5PnvY?=
 =?us-ascii?Q?b3CSCZcBh7Xa0xCCgX1W8f6UW5R+4c+wpt3jlJFTFupaqFZ+fG30qLsrDmtD?=
 =?us-ascii?Q?HMWVnGk0wTFd0h+mkfiNoiNGotcdEKBRc6Fa0zSfW7RjiDrjMSvDIt1JovUp?=
 =?us-ascii?Q?g01Fw0GeaKoixlvSWg/Hi5HiHalW3/6OTekFRZSpmLCVu5SphHR6oZFe4Av1?=
 =?us-ascii?Q?nfp/VGi/ijGf7i8VXfFULy6XGk5uKasumrodGOyzqPx79aMey1rfIWveVMqj?=
 =?us-ascii?Q?xQr3IeE5TMHk2X3NftGnweu6VEyjFMiwC0VYHnSOp5cXhAcLgMlaeZEWZkh0?=
 =?us-ascii?Q?vuCa6Ral/O9RLDqkpV0OM/8e2Y++CF1pFxjY4Qk5LI/SlVa5eOziDZQq1B1Z?=
 =?us-ascii?Q?bHD+Q0n80MFnA0nA+LnDtCe7aZPb81cyWMNF30AmmRCGB94kYSskb1cSgCsm?=
 =?us-ascii?Q?3p9HkX8X/n9xreWtTb8A/4ABnjvhFQ1ot0hW7k1MbIu0y9W6zTQtCu4NjKx0?=
 =?us-ascii?Q?rlnvHdjGi0amwPVgbhEBF4tc795Xd+hDD8ufBuORWSs5ePXA8En/LUu2aHR/?=
 =?us-ascii?Q?sEXTSSPTuj8uPbG5HooPy3XNZvba+rhv8HVa76zOUl+IFmqruj7dw6DIFlLM?=
 =?us-ascii?Q?EMqMS34zWWnTx3Y3+B/m874y457+m+ci/MXKtOiI5FlNzO0HI4U7JqQjKF6v?=
 =?us-ascii?Q?O3XHT9/Z9O+7aMNs7T9XILSVy4a2/1WseCiNZtWYyJ44cvR8sCQk1Umlw1Ff?=
 =?us-ascii?Q?7EqP3cz+1frgt1wReeGQ6gNSYAR24z1OoCPxixZWpU/XBWl0BzWfD/DWVbRH?=
 =?us-ascii?Q?orAaiiDJe/653QsX72GTAMWYo6ICouPCl6xVxgsqvFdJ80IOV+Nl16YHpCjv?=
 =?us-ascii?Q?7+LJ1BLCkgxP49aUe2MVu4owQJOye7VkqIC4kg0+N6NaU5IEvnrPgp6gMjmA?=
 =?us-ascii?Q?cxH6y7Ac10WudeJubvDMh0dl0h1AKStPvKfS97AMJkqFimpHfigLHxgRwCs5?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zBRyU4HVJjiXzmA5Rj5NNDApjMgvjWETgWJwtn1J0WXHGP7h6TNbIpvxpMI1VR5kpLBnjbvItfdQbaCkvURiHQgmC2JSK8xc9A8hpWOD8kyqCZ+/wKaUVT15TLwNFyVD5VwFjn4h50LP5tgKCIq8kxdVsNEK88n3i4Uig2tHOKqt5caGcwnqxaHMCwkgltq3RZY8NERryf2a0havd5YvNgdPkImYyF0ZbrXxfbiO9njQyDqk3iQV0pF2J4Xs0NcLaQPJPa5LlnzM9VHOujV9LQxO1qVoHZjkj/F5Kx8+6u7j1sDJImcXn3U8qZUEzx3kH5dHyZfFDGDh4qEh1XD30LiOnBwURPuZ8430CVz+tzdJcOHuvHXWId3PKb4i4RJ4Hia5Wn+ptVN7GFW40EdBjVnMl3+0P2hw9LLa93OrfS7quaxjLVL+dGW7++z9kCo27K6y2UdM/lHJvELzTCuLmGOSOSF26Ht/iEl8hPgluPLTCaanniS8B6ZO5W8yXpZ1px8I/Sucj3bkqgEBAAOZzMA0e3BwvulvBngviFCoOEU8amqoR4UkawwEyFrvcrAXHWGGfxerR5z6AzWZVAFPivl8NY0V7DorEyz8mE0Og58JQGsXLoVEwtEetsNXB/Z/6cUJyIeWjiIJTwwumToTKUEiS9cq4HlTgRrgPB4PMmFFp6cJlvrd6EA/RIp8Qc4j90cNfYejASzPsjmeeJdCY5fIUIJb+heDc9aFktRhZ0uB0OQlzNAXaf3RJlmOx3gfv5DxL+Qauuk6V0hiG4qyStmCglB87PU3r/jpR2oMwaMrilLEEKCRCywhJvHyXSpF8s003M+rGzbgXG5fegGV4bfg6/7doGj/su4Wft8LV+KaoaOQdpMYIEjAhuUMoakLf1+c87fZlKvIo19L1flPzg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2670660a-b603-48b2-7531-08db4d905b71
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:20.8945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXa4InUvnLumFw1a6PPqjmIGovt7FZ0qPhaFUGJrraOJEjyqRT3pXJCLvPgEnpa+eDPS08/66DMWzAGHnMQrwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: bjqzePQZIItG1aC03WhxDSled2RIkHjh
X-Proofpoint-ORIG-GUID: bjqzePQZIItG1aC03WhxDSled2RIkHjh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test code is less useful without debug, but can still do general
validations.  Define mt_dump(), mas_dump() and mas_wr_dump() as a noop
if debug is not enabled and document it in the test module information
that more information can be obtained with another kernel config option.

MT_BUG_ON() will report a failures without tree dumps, and the output
will be less useful.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/Kconfig.debug                | 10 +++++++---
 lib/test_maple_tree.c            | 27 ++++++++++++++++++++++++---
 tools/testing/radix-tree/maple.c |  1 -
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index be272aa2fc0a4..17ba96a3c7bfe 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2293,9 +2293,13 @@ config TEST_XARRAY
 	tristate "Test the XArray code at runtime"
 
 config TEST_MAPLE_TREE
-	depends on DEBUG_KERNEL
-	select DEBUG_MAPLE_TREE
-	tristate "Test the Maple Tree code at runtime"
+	tristate "Test the Maple Tree code at runtime or module load"
+	help
+	  Enable this option to test the maple tree code functions at boot, or
+	  when the module is loaded. Enable "Debug Maple Trees" will enable
+	  more verbose output on failures.
+
+	  If unsure, say N.
 
 config TEST_RHASHTABLE
 	tristate "Perform selftest on resizable hash table"
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index d6929270dd36a..93b40a78c4f55 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -11,12 +11,33 @@
 #include <linux/module.h>
 
 #define MTREE_ALLOC_MAX 0x2000000000000Ul
-#ifndef CONFIG_DEBUG_MAPLE_TREE
-#define CONFIG_DEBUG_MAPLE_TREE
-#endif
 #define CONFIG_MAPLE_SEARCH
 #define MAPLE_32BIT (MAPLE_NODE_SLOTS > 31)
 
+#ifndef CONFIG_DEBUG_MAPLE_TREE
+#define mt_dump(mt, fmt)		do {} while (0)
+#define mt_validate(mt)			do {} while (0)
+#define mt_cache_shrink()		do {} while (0)
+#define mas_dump(mas)			do {} while (0)
+#define mas_wr_dump(mas)		do {} while (0)
+atomic_t maple_tree_tests_run;
+atomic_t maple_tree_tests_passed;
+#undef MT_BUG_ON
+
+#define MT_BUG_ON(__tree, __x) do {					\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (__x) {							\
+		pr_info("BUG at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+} while (0)
+#endif
+
 /* #define BENCH_SLOT_STORE */
 /* #define BENCH_NODE_STORE */
 /* #define BENCH_AWALK */
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index ebcb3faf85ea9..cf37ed9ab6c4d 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -22,7 +22,6 @@
 #define dump_stack()	assert(0)
 
 #include "../../../lib/maple_tree.c"
-#undef CONFIG_DEBUG_MAPLE_TREE
 #include "../../../lib/test_maple_tree.c"
 
 #define RCU_RANGE_COUNT 1000
-- 
2.39.2

