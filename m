Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A7D6A8C5C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCBW5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCBW5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:57:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3BB5651A;
        Thu,  2 Mar 2023 14:57:31 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K6Yof007625;
        Thu, 2 Mar 2023 21:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=uiqaQzqCT7ZEsqz+GQtsTRnZZsH+FtEgLpPNKxF25Wg=;
 b=NkvXDsvszkeFMXowuPFGrSKTxiB3syS4EK+/UGmMXouC+SPtiyemG7SuC638HJvXlT4R
 AEZjQYCoUp8v36lfozM7XT8pUa9jTdq20MR9WZJrMb6m/7atxM6Qo42VBs/leda/pKjq
 aLD8tVmcYQZd4RohG5+i0Izbh5vd9Y8HiZPlo7CbdI6C5ZxXkifq1C+h/2malyNHhbGw
 jlEHuojBg3yRN/UQW+3w/0mNX25B0P++sJZAj82kTdJu1LlmC8VoCKm245VVNd9acDUX
 M+lbcizl8Y8HuSR2VxEM8w87zsvwkxufxCOJSZkjE/pb8FlXqg8A9OLRJGmgCaYExs9V 2g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb7ww2s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:18:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322KlAK7032965;
        Thu, 2 Mar 2023 21:18:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8samh3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:18:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqLnZ5Kpfcc+xM+9EGFUA2ceCYAX1QqBdh1BXJSQra51NuKn3/XkSx2kdD9jv0UUc7Vzr5D6VWIRzvzE6aA9wxl+lA71w2fpX0NMZiC5SFRJe+cwIi3CTzw6SET/Mmaph5vmtSKUXU/z8WGuaqpxe2DnB8HY0z6thuWo43Vjw4GdlsttgZ9PfJJHEVxHP9nHN2pWRtycbmFcJNC+poB7J7A8FfkjM60V+qbZbI42kmF4v53VWFei6R0Zebe40tkfI2kxr6hFjfhN0Q8LqNwa+QiDJHXNLwwOVGGL5l/mKpB7f9psTsSUXMPeESlHF1NdxnIsw9zHZAGF2gqorAggwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiqaQzqCT7ZEsqz+GQtsTRnZZsH+FtEgLpPNKxF25Wg=;
 b=IZ/EDvO/RBTA+RGCSxBHwiuFnUzz9UXdMQDVPqKF0YKMbcXGxyJZVt2ApGaPzzR5qaoZsSzjmbbFuNA/8nEMEdaVlMKj70CkX9I7WIv862KZeEXxnILBAA6wrPuoiI/f/3GLW4ZQiEgzW3HQuZJrnIiAinBWUVwxmECVl+DiQMIZW3SwWqbWIP6ssc06D7BDi/gXlXjqdVwYRms3NatYgYoSDGD7eMurj2WjMoS3KuVvjt+ayzTZ5jKYudadbuueHZ4Kf50nQORemzJ/b/FrvwPgRFhcmo9/0MoGt8Nd8AjT8kQ5JqOWflb/HHVWt20HsxaVDdQrhNOW3PbZuLyp0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiqaQzqCT7ZEsqz+GQtsTRnZZsH+FtEgLpPNKxF25Wg=;
 b=Y7J+vMzlDqHpAn2JY6fb/gzJDQ0P7kNF4ID5k5lIjIg/lev3OuQR/mEpBTmAkUzByo1AsQiixEo2bzVdR4rR18YWEwVhiW1B+vp+KfNfgHlMEeTeE0E6gwoEDqJoLPNxwNMboYqIQ0jjHcugK/jG0mgfRJWDlYNjQRZU1D5neBI=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 21:18:25 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 21:18:25 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Subject: [PATCH 03/17] braille_console: remove MODULE_LICENSE in non-modules
Date:   Thu,  2 Mar 2023 21:17:45 +0000
Message-Id: <20230302211759.30135-4-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230302211759.30135-1-nick.alcock@oracle.com>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0690.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::7) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH0PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4e4be6-909e-4e6b-d269-08db1b63a8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QlMNMQsIQwVThSMCaU8wPspI01IT/NLTLbyRodu+0FabP5t8+lZvAguwf2xwweJUhgs7nftZUjsYYPO0WZvqi9N9L5S+FeS2E/0g1YlUUCaC/PSJ9sFamryGk2zo/T9z3xbZ47Pe4PsSNscTgSrf8/vCU6WF8ou6fJr18z2Eo1pR3JMtcCcPFeEtHwx/YWQC53LUxCQwZrrpO56xfj2fEWzuxBP599ui+kA8fFpq7hWUsR6RyQp8obBozzyc3YM2sUh77YDIB8HMgpu5CMbCq0qCAv01P8FRe9zApNngQymHQ+mrDyL84Mtw0wh1sHgqkOf70jIiRptnZrb3285+4Nao/lgFRafMtAvAwdBfioRZnd0lgeFT0ZRsTemMgJ1ScEN9HdzU6UhxiDf5MZiPZ5OT3f8VoQIIyIJyEdoFuHKnJ62965jgU7HIDvqymGtLUDI8ujtLFImVnJyl5Dt77tilP0d+zuVZMfWgB+662v7/AaB/Kgyp7sinCrh/Q0yzSRYI/WCtyr45jsO4nPUFZ+BtWZX3PlopjDMZWSbofXYNGBBpWVntyNQLYbeHuIciqF5NFklVgGwyBe9jTgnFi0rXuU6DSHaticUhgGYwDYfMPjDR8zGTlMjRo+W/02p0j0VimwO3wNtqjyCxe9rP8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199018)(5660300002)(44832011)(83380400001)(41300700001)(6916009)(4326008)(8676002)(8936002)(66476007)(66556008)(66946007)(316002)(38100700002)(36756003)(2906002)(6486002)(478600001)(86362001)(6506007)(186003)(6512007)(6666004)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eQN3cbOz5fQnwaFjWBvdiW8clSNI09+hlP04MS++Udn1Sh/GL5RQfo02Sln6?=
 =?us-ascii?Q?0XYCO8a3OQEMhu3GNscmmfbFywVIc4zfzJ0+22vsNhjSpVk8CwfWjcSDLrv0?=
 =?us-ascii?Q?xiPmtq5D751BdvnalRxnULmvGqEn7CsYRJB348X3s5P0IDF4chk1+2cvJF1C?=
 =?us-ascii?Q?svZP4Sw1fStlKmqBYY7GukOXDgW6b7lX0FUnoNR4XNf7Qy3b+LAvn5402szS?=
 =?us-ascii?Q?E3EnywWbjep3JoAYNv3OqCcMIKWHCSH6iWURViYRcNgQNS5gsh5/eH7bRY1z?=
 =?us-ascii?Q?/WZionR55cOl+A1nVJQahhiFJnx/lKlIafjCgy6umytNIIvCKsEKS9LXY38Y?=
 =?us-ascii?Q?xboipiEIwCj+xT4thukAh6UfpOx6Ux3SGArNv2WB58alYYc6PluqtHLfhaDu?=
 =?us-ascii?Q?vXNg2ZX2WY2nX0NiCprrTSvh80GH2P1s63wlJ6bpfX2otXazsVhkXT45Me4w?=
 =?us-ascii?Q?AVt6XjQgvgLFJnxdr1pTO/14XQg2tMT97vahDP/3rPEy8Ka76sSyvk4Wza1r?=
 =?us-ascii?Q?8OWZAgg6N6Yb2zFgfG1/ZPNk/AfJNilw8GnZrTMfW72V8ar9a6W4WVe6bOlP?=
 =?us-ascii?Q?soccxC83Z0f94jPOUpeJ9y8DuSsz94XSqDYYl+J6BwdWGyAP4NxL4Qythso2?=
 =?us-ascii?Q?8WBMrXTwO/KEouLqUIgWBeJFHocONKb9IqhaoV4DM57c8PEI2ai12pfFQMj6?=
 =?us-ascii?Q?uDC7GywwDfuh7koPnAaJ5zD2LwMMrjt5yvlZ5fudp44WXG0eezXQa+Ic7gf2?=
 =?us-ascii?Q?Zb+PLKY0ealUrg+VwrekMx77uVhLwCRWwiIyjp54hSIM3pv0GDo1F7YI27fC?=
 =?us-ascii?Q?L/kqRGf0U26vBxslHtXJf4Oa9EEdvvDh5LnlpLlKISGjufyHyvowKSu+uPKH?=
 =?us-ascii?Q?deYu3pLI9iUQeqCm6f4v254PRs+W90GPN1X+pLuXIGRj2GqKVahqoTUixUqk?=
 =?us-ascii?Q?kQkEJhy4VbbTtrPSr7JbE/V9wRh/uvvOcx+cQ+thCP6krNrJdyp278zhyeOq?=
 =?us-ascii?Q?uSzT8V56Eb/Goph2L8KGiL6vZBphJwPW3BaRYpJRmeGlN/YRplwBb8VeVudt?=
 =?us-ascii?Q?ynegN8vxW+NPEJHm272J+51cH92zlx3BF/Og01INbsNgDL2fnGdckjVm8oKU?=
 =?us-ascii?Q?ze27nmUh6oQhOaNdXKTHP5lr4w9CUpdY6fJ2KSN60Ny0ad1pQ45j4z9U8JPn?=
 =?us-ascii?Q?oF0gn1MgSlgnGnHbOX5UIaxufN6V8QrOXz6zOL/CnYnJBieLPC1tQ0xvdcJ7?=
 =?us-ascii?Q?Kuk5fDTblbq++RkNOzYQCUz4i2OgXnRBcOnVy2vl6RG9psK5xHP8v2jXhxZp?=
 =?us-ascii?Q?Bqs0fvvSdvGkWCeJP6mHZDVgucZwkvUdMCL7iZEKJz2jKrEPVfy8PdPr7GHi?=
 =?us-ascii?Q?lhqe7CeXzw1cdzUEzdvjKjw4iyUgOi0VfJJ/UTmDNMgIRWhwx9d+szHYI+ve?=
 =?us-ascii?Q?pP101KZFd5acZVKuRFyRHFv1CUJ8Ds+GWvBbhwEz9BorSfozagia4oJSQdgu?=
 =?us-ascii?Q?quIn8qA3bkpIh9E4eQgm5cp1wNlOgMmVIBzCI2/YJrzW3+CfivJzloE8bH22?=
 =?us-ascii?Q?FR41A4qV9S6HzfH3/xAyJaGgC0iRJIxTDn6DkJbErPk8JTal/hW+kqcBs1a+?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4shA/TgYOhwrnxsaTxnZ8rSe//7m3ym4FXP9xg8+XRybdMLy4NEIc9G1r4qqmHdsfKWZwYCRs3kcADgUG0SEbF6L3lb83TU7ZXzQ3xfETcGrkJr+OFzpxmnSp+LDiBKekh6XBbl9DapFRY7HFFcW/oN9MGl+rShgD7lDfUIdf/HsdHXHXo0SXlaYOXBiZNCD3Yz/2MEZFMSkT2hR6C6+YVwAnH2b+W7oGBOYNHNwUrSnoRWIX93FLsWuCVjCUPRGrq0O/G4VlxkKDvG43dyDhqhmAyDaCUu92WdEknr67RX2WNZplv5xOY/1gAE4RV76D4jsKBAcLIPoCjgK9gcN6rNjQJkTj65EOE123qLCmZAGNEUI6cP5sDiEKLE6EIIA6+FA5acLsP/8m71s8+2h+fIkV4j3qUSheanJYlSCxwvWn15UxzMuxA4M7EFUq/ex1tXjaPw0YZ6ZFo1SjHfgC3XbEnjSWykVdyoT+b9cZCP7N7YdVskjjTIP0DZIAj21SnFMLEuigBzoL0Yu5mP/GdpxQCKUmiGsSAMl0O6JSt2+kqcIvw9iFpdT2Hc1gg6boYWax/2s+k5GPA71ZNZswa+qWrw9YR5yuuTlk+S3Qj1GDBfUhmQIMrXTZeEGAMZK88dGC3qI8L6jn+Q6dh6uw9SnorFxrmIp3rKX6yZZtmhmc4IZfPq5qMx8SlSZDvMT550o3buVLEffgJ+MB6OfAcGOQWYEA9PoiEUBI5GSW8J/efooIPFIUSrnyvlyzxOW9TJMo7u8vLPSX1Q6WxWKQ/ArDrK5QpofLjOZoEcvVYZh620x7PSnF7LSSHlTB/Wz
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4e4be6-909e-4e6b-d269-08db1b63a8ae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:18:24.9736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAMC+tcUjAUHozoHdheCRMMJgFSZ0xYd0MGLREwLCY9YnrAJ66I6OjYXz9DpLLL6LaHfZ3qmanBrhFRxZKCa8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020183
X-Proofpoint-GUID: ZCo9DlOW2svGE8IONaPDHfX3EuJkTK79
X-Proofpoint-ORIG-GUID: ZCo9DlOW2svGE8IONaPDHfX3EuJkTK79
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
---
 drivers/accessibility/braille/braille_console.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
index c4d54a5326b11..06b43b678d6ea 100644
--- a/drivers/accessibility/braille/braille_console.c
+++ b/drivers/accessibility/braille/braille_console.c
@@ -24,7 +24,6 @@
 
 MODULE_AUTHOR("samuel.thibault@ens-lyon.org");
 MODULE_DESCRIPTION("braille device");
-MODULE_LICENSE("GPL");
 
 /*
  * Braille device support part.
-- 
2.39.1.268.g9de2f9a303

