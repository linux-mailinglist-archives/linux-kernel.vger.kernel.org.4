Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94ABC6A2146
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBXSQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXSQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:16:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EB66B15B;
        Fri, 24 Feb 2023 10:16:19 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEmset005560;
        Fri, 24 Feb 2023 15:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=7RsJJZnw61AuiRE+jr6r+BLOuFDqxcx8zyuDclRWs0Y=;
 b=1eJjAbJ2kur6SGiDvwqzyHZWr1UwhPNrwB2DeFiX9e+AXuEG+rLQrPNIWLRYuLQfXcz9
 UnLeN0qWdzpW8UW+BgTHuaZw0YqzTWxOdtweOc+E96Vnl/YMvZMJc+j1yPD7Vs29TbWG
 S8a28qxE8G6DHv4/WXcEct5at68hhsBIgY7DUHRmZhyGzph6ZWeNyrBqHa7emfQmvzE+
 zaheVn1xkzgADVVg9+90kYGrqHbm/JRlbJlU3maUKQEIUH3WZYQrQ6NevHQiKOTzEnPn
 MmfNdLObp2toIcHv3Itm5DttHBOcwnLv6dUA2pnevFySfffPKC72yENdPOgq63Hf4UJ4 Xg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntp9tweja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ODXJS6031541;
        Fri, 24 Feb 2023 15:09:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49qnsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzrBNujS2s5rWwYdjEFcHP0s+PmqzdTDVajCpzPTdh55TcE519MeSDPc2gsMGFT3QImCui0ndKOthfCAELEzMfWpBydDGlqG0/EvMWm7ulNLQJd3wNB4f06EUdKEF72PweumF5GVTTs3LG0dyvQE0lYQsto8Gfn2FuCt2l1uOBydC3kL10tItMxggNJaT1CEY/Pvjtg79pYg9D6XZNqMergzlAODN2UzvbDblHvvF23Tybd+oBtnccHRbiWbY9Pel3SdXRTYBmh2sw7Oaw57+Wexun6RSwY73Ep/G5kZG2P+CF/l9//GSCsv2rO8EJvk+9OxE1wFJndC1F43YCc0Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RsJJZnw61AuiRE+jr6r+BLOuFDqxcx8zyuDclRWs0Y=;
 b=XOylDtPgUJV0cNBufhFI66oGC/ze78BwPI938HWKM8qIkQFWnbOignPGHhHIvVShRCZN81g1JgNuWOb7fCVPB6tPOPZHqzBznX5H7eu5u7y+i5AY8jt8eiTN1enlpEROlG80DL6PK1OXoekk0QyW7w1PJOQJFHD6LU3c70sYyuHUy0OeAoULh1gnTpX8W99HxhYPUZkvE8hDTxPbdnKzJR5QYvkJOHDF0xsVssQs+XLsKns9+das5OBFAoTIQicIigHEHJN5MQzLhaSrS8tXAznteTw7tjMUEOGvnjpXFxDkOb9ChsnUsvvBgjM7MHJc5uTiUytiT3vBGhtPfrO0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RsJJZnw61AuiRE+jr6r+BLOuFDqxcx8zyuDclRWs0Y=;
 b=EJx1V1/iOqN2DClIM6Jwy+YQONxUrgqcobvfCiCF1XD/ZmCT5OU5lOd0RtLBhtXiV1HEpLucG2ABafgmSOZIgmUKf+Ch/8y07tV/HYtm0M/PsMEgo/FJ+4PlqVP7dfAfy2DySR47UQM6S1L9rko0sf65g0Q83vdVno5Y0bqFOaM=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CH0PR10MB5244.namprd10.prod.outlook.com (2603:10b6:610:d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 15:09:38 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:09:38 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-tegra@vger.kernel.org
Subject: [PATCH 16/27] memory: tegra: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:08:00 +0000
Message-Id: <20230224150811.80316-17-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0407.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::16) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CH0PR10MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: dc20f89f-bec3-4645-9293-08db167925b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 41Ae2o6YQQtDDOJBMwXLjf+lOe58AGa10rxX51lsIcokK+zdE4lpusY6tWRHwnYK3GMHfAEilb0CUhCQShqMpstvVMifWj3l8t7BdEJsgqXekRPAnXm5jjNVTd70PEQDKOU4NiODliU76I3DEQyDK0p4PJtg3KMRFsu9DsCtKdXeX3ob6REs7heYdHb+8eZK/vNzkA2ivfBRmiltIYKHCkJ/VXLI/cEHL78nsxmY6oRqj7rA7HKTG7VLLDJ+2c7Q9eCxQU2ZTOtkelQtL/R52ZQDGXtNSnw9SniuibHUI0rmD1ifl2YTANVSklLV9fVzVcJH6eeZuzT1VsOfFKHA8XRCo8Ii6GpxiIxNmGnsNiUO8MQJlXSugoqFDQyAqXs0MmMy8uawUjBwTiXrqRYK9qAAB1zphG9xGXuCsjjIAzGV0x8Rq6FacylUQ10QjZlD6iypEyeOzDUmzsKpQFCbaLC5opI+uqyV+1E8oMaynL3+hLTQAxqPhVa+WiV1VT1rcQd+UrLJrnGPK5778XxTw5uo3bBjKgot5nD7u2+9aUl5uKOhMUFvoWnZEtbVFMmd50AKAY2bDPbqEzdq+tHIRj61nVfYNkIdG05vrqdTFUcEAo6+QzFXTh15j2d2KfadKB9pxbVjofZKSTYcx5wf+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(54906003)(316002)(6486002)(8936002)(66946007)(44832011)(4326008)(38100700002)(41300700001)(8676002)(66556008)(6916009)(5660300002)(6512007)(83380400001)(66476007)(1076003)(478600001)(186003)(6506007)(6666004)(36756003)(2906002)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mY3hxCKq3CFiZOX2kF7iurOJExF5QNBN6I4mXx/xhi9euBuS0I1JR5aNRFiY?=
 =?us-ascii?Q?/AHKpJqh3jLVfUuePNya3jLiDGAhGyjHz/gdBmmFTJ7aZvHa4vrR9in/VPaP?=
 =?us-ascii?Q?NXEWssdz78Gkd6uXEAlUFjqK+O+9iJr2m1gC9ZMnXLNCIn6YkBCtBKGEoGwY?=
 =?us-ascii?Q?LuHbVyVDEi7PijYlFhzsWni91mT56rGR0GGguF66hFS919ZplxEZ8f3m+CWs?=
 =?us-ascii?Q?b0ddrJ/vkdIwUpecaiDQuazah2WQqxy49ceOoiYTyGQsIR6xVQ6JAWFixzS1?=
 =?us-ascii?Q?8J0isf0jxMwhT1Fuk9YFSwSupRKeyg3FaTC4SSFS2WibgWDEMtJ4ZP7pHUwF?=
 =?us-ascii?Q?CnzAkTFGeIDEfoDKZCIafSTD6+vqN0Yb5OQNL6nJvLO9H2a3MwMZXtXHxqg3?=
 =?us-ascii?Q?yLVih4KaYWK7HKm9pKnNAdq7hbf6wK0OsfrPoJbzAIDfWDWyiP7H3055zyE0?=
 =?us-ascii?Q?BB3EhNs1ElKA/wziJihFWTH4a2LAibGSgz3ph3R09NfTMSnqFpPGKj558IqO?=
 =?us-ascii?Q?hY1TN0x+o/fLkwcqxVus1IBq/jdQ8MLufAZvwLA2K5PY0WDUPHaD2a9kGpsT?=
 =?us-ascii?Q?zqCZKGEn9/RuIRoZH31+CMrVfFB2xNleiJrrP3GSNXcT6tgLPtxyfII8ltAg?=
 =?us-ascii?Q?/VTCVmprDFbvhFTKIW++7XruOPtmDUvHUm3zhgiw73mkW70UpUg1gydO7deT?=
 =?us-ascii?Q?cDq3a9gQndb6zGijdI8yLO0dfCNhEctqPW3Xy0ef0BqMFq2j2eYeSclQPAmY?=
 =?us-ascii?Q?esxIyqNIKIfMrOg+WBSwaa5sKREm7s87ZpR8QfvqjTJB5QGT0UIdDrzEI0nZ?=
 =?us-ascii?Q?lI4eEfrs232y0UQB06YLaFQZ9PQqnKSYPUV8U7VNuPmtk1Cp0NgjMJeU7yyV?=
 =?us-ascii?Q?cw6N3TYh1db+lq49xdIDva4lya5uCLBxYBg2lVe4hcgQXgiVzNGGYIpkqE/P?=
 =?us-ascii?Q?bQJngh5ROkLToiR/iHrrSw22hsas4SBebgkmNwPRWWOuh40idMq3Ez8eNt0q?=
 =?us-ascii?Q?L7yoFxdAWpQbRFBbhKV6wzf71hQD4Wj+/qTOtxxrO8wP21XyKLvcJOvukJsf?=
 =?us-ascii?Q?Ww7FVJT9iJsMh5kvxM47TaUDO97o+Hk9d46YebZm86AnmBE7+yD9zGIh7+Pf?=
 =?us-ascii?Q?IwY4x49osrh6c50qOLsOsfPrx5yFzWzyTqHJQK2U2J5/YvTQUls3Rb5TUMc0?=
 =?us-ascii?Q?1OZCOOWWVfYyf1xRxWqK5J8KCbVH+2cniNZ5awZgaBB7GPZSz8VVJJVcAvBw?=
 =?us-ascii?Q?hR+fGYlb6mxsjypvYXAFovQix/qMfYewps46kgogH+bLWNI952F3MJeJs5/F?=
 =?us-ascii?Q?9MxVl5l3tbsOZBJvZPsOJ2/TI/gYPPQcWV0Rz1J2Cak15HFFtWcW7XPqjMkq?=
 =?us-ascii?Q?ruwNAfRHpxXmLRFw3L9vGSD1Zyzr0cDIaZ8xj1h7EFp10xx67eHHfzZLyo/L?=
 =?us-ascii?Q?jYKJR1MmSbKbrw7ibXBY+hGvNZDzdN7eWs72o63fLRbUwOwc2WkqfResPfIq?=
 =?us-ascii?Q?8gVlJ7ncSRcbiN/paqrv1+0RudRLwxYDaok/4Rp5mhuTbhB6dK9pjvWpXrSj?=
 =?us-ascii?Q?nkE0SSrk24cVDWaMRwH4RR4g5ErZhm62lEGH4VNMs7KloYWWjL8n1Of+6obF?=
 =?us-ascii?Q?dakNs/9zXwikyefeSz+21as=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/2zH3cHMfxEKZlIeGdwDJCAqQRl9dsOzaGSuEwxfk+aaQLhFTzC8NtXgGF4y?=
 =?us-ascii?Q?ZXyysDvdR67DLeckr8Lw15VUo12HCICPhB+MH5WTdtDGmJtZVhSisvIO670T?=
 =?us-ascii?Q?OuK9sVPKL/kDAFpbscUenarjXWYZdHXn2mpfYTBG8rPM9so2XM4M4ADhDsAF?=
 =?us-ascii?Q?W1R3KpRfhgDcTdRCXO1vk8+uyzc0D+yXDFPIS/s0nRYgtHozG5BYdcVcZonl?=
 =?us-ascii?Q?WPH0WnoQhtmxwjSGHqRJB1QmUQ9U3wkp0BnHN//7c46NgRkIBPIuf8x5HJ43?=
 =?us-ascii?Q?mwD0INkHd+GlrWhZgprh/O+c802N0wquE4EID81u3vzxAmu6HWA9ZKYCpzVP?=
 =?us-ascii?Q?avkVlMHoMhllNlFjKHKIWa9FT97kqhHzJWHuR63Ui2J5G/xvOeQhjaa9RhCU?=
 =?us-ascii?Q?4t+gXiigx3c2E1ylUqZFHeBZn4SAKd7876rDURrZhQHLcKtiBZpdMk9SasVY?=
 =?us-ascii?Q?OdITSdHkOxRYLJ9lGiP8kW63xwKsBbBYT7A84fL9Ny9yaXx1cDWTbmWzM0Hg?=
 =?us-ascii?Q?Sz/kB/MMePdw9P9kEF53B0PQKkakGf8es2Y6FnYPvLeJQn5QuBZoWX6NNFfZ?=
 =?us-ascii?Q?EqJUNvuCaW5vQRn445gsG0lZYyVnijyOh7vJ3OqnDoiPGRmPPQUGNu6/2YLt?=
 =?us-ascii?Q?eYrTdlAi0qlR7q8l9ENhRibrnRV6l7mn6sLjEgyeIN24KS/4urVPQzq3d6tq?=
 =?us-ascii?Q?9VfeY1pZBi1o+joyA/3Jttkh/VldPQNw/N9y8ffVYxqsLpDHqyrgBWmFpph6?=
 =?us-ascii?Q?m3WlEzGWhDoxG+BZ5CviElxD1cBJTWjiIQhrwNq7V9LJqcMdno0Z2C2U4AyV?=
 =?us-ascii?Q?oizqif181ERZyKaxJEQMLJjFoHDu3vLaUCB8rmEaW/X7P9hzUXlG0ExIefIa?=
 =?us-ascii?Q?vNpSUgIxHt2Xct1RA8VU62Jz8of07Aa0wFnn64X9iAnS/6s+Mz8kPmNrK0tF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc20f89f-bec3-4645-9293-08db167925b4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:09:38.3595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9r14Wky0vFE1a2TlfW1jpjymrr2l3XFesYUTdh0GkBJetNeamiWI70V/Y01KN9gc0KuXlxeImgbmtSi5HWNeZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240118
X-Proofpoint-GUID: pXprHV2me5X04anC_r3JQYmGtyxrhVQO
X-Proofpoint-ORIG-GUID: pXprHV2me5X04anC_r3JQYmGtyxrhVQO
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-tegra@vger.kernel.org
---
 drivers/memory/tegra/mc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 592907546ee6..237025ba811d 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -985,4 +985,3 @@ arch_initcall(tegra_mc_init);
 
 MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
 MODULE_DESCRIPTION("NVIDIA Tegra Memory Controller driver");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

