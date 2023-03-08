Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302136B1260
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjCHTqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCHTpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:45:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C1A85B08;
        Wed,  8 Mar 2023 11:44:57 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HibVQ022860;
        Wed, 8 Mar 2023 19:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=sM4/TVNK1XpfeMckZvxmEBpZTRDDXLHFsk4H+LYDE4Y=;
 b=f3PL+MwsY1L8d9bCSFO88OZvoFnhn/BV1fzyXGCiPTLOQJGJ37783+G6n22b004ug2eg
 iAigz7QbWRrfZnENfdpDkLsZ60LwXjU2SdoEiMMhsrVJ2V//aej/aatNvRdBos9NkrZz
 +bOW8jOF2/LmnlIXCr4XckeUL3VZyPvcwhH+DwmHrt7PEOwEDLaMtqJZMist1Ohs47aP
 FsIEOui+3c2KiElF1b1I/rRYsQmSDvzwR+81rrmRp/G5cSvoi+BbOyU9Q9WAzKMTVyOk
 xnzXOInXRZAys5BZafUbaT3vyj8mWBMLQAGvZGuay1SXkJY6foV92QVEhtXk7ic0OVxQ hg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p41620yah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:44:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328JeDV1015603;
        Wed, 8 Mar 2023 19:44:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6femr97x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:44:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ul7aCq+g4233++IyNaYlZ+ssz1uUdtQCqfOXyVVeAacTkJDBylRyu6YpRnsUnB1EzaFw0aveeRPsTfcJuSpGlbQfTqzFP6h2bmkLmClIA6WKOzfZ0XW0Ff+brlLrFsAIbJtqB8dsxpzuL/EcgZZXqnP0fRkSp1qzsI+0AaGydyjJfeBtMhNr4blKEeOtk1xTl+YGZbmGcR0W6pD6bw+IIzKva50XU+AhJkqBIOiMGNYrb9ME8YnlXxGlWMYcSONiTmjQff1tW1qRiVvry7W3D3O33s2AVKBVKjMzY+A8CUNDM+1zLLUX9hai3kiiFvNgDwFsGpYNTW3gtwT2Wimj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sM4/TVNK1XpfeMckZvxmEBpZTRDDXLHFsk4H+LYDE4Y=;
 b=a/XTMhOv0Rt1oz/qfeKwDcrulLMDu3Rmu5Qk9zduz5JJ/SGdtKLzgcqXQZboaAIziGB/GcYWPo3BV4N6F0MYUzswPhA8jlEOZGL6pGZIuM2doFaEr0qxYvnvJXUhEsCbquO1rQK0Luip02h853iw+hWUEBeu0k/rZ54spvqZWTD2tvrf4IFLcXUibpZrbw+uXj4o9c14Cue74SlikH9uppMpmyYAlXHQ64chBMlvgnfIZkxicdG5fzwackgNKlk+p6cQwK3/iM2JiymF3FZ6muzrDjkaRZppgu8rrhGTIslXDHuooT+Jt29wMsx38X1ljU+SGsuxoW7PBKMgNq8QPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sM4/TVNK1XpfeMckZvxmEBpZTRDDXLHFsk4H+LYDE4Y=;
 b=WlDaFMsLMw+zaxalnckuWYOSbhAHUu03yMG8heXfgNzUVR1dPkaZwJFE7kduhT2leQ+cqaQij3HysefMshLZdNSZKG0MIG3gDwLyPj/oYzkmpxiBXXHIzbw0z7LeGW3ahihGn9gLk7yLOP04awG8PdFXqwzznUJqa63g62fdiPQ=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB7034.namprd10.prod.outlook.com (2603:10b6:510:278::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Wed, 8 Mar
 2023 19:44:06 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 19:44:06 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     lee@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/18] mfd: tps6586x: remove MODULE_LICENSE in non-modules
Date:   Wed,  8 Mar 2023 19:43:01 +0000
Message-Id: <20230308194307.374789-12-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230308194307.374789-1-nick.alcock@oracle.com>
References: <20230308194307.374789-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0229.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::25) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 9adcccf0-5328-412c-283d-08db200d7a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JxT+tKGXfatf6/8NuofsWUGPuqMrwdGUXtPwGOovrUGHclEYdlbDdwPAVPIFRgLqSsXxOstNJG4NKnxG+xPweNs6bvatbRsIRbsTu13QInJ4wsm5oBS5VMZRTPtAM38vEOAjQLDneavtsZJlZ+rWtaAVNUkjp6jMdkZYPc5KyulpkLP8aMng83Y81TLEyRLJZFtkaBOOsxMLYIHlZUw4c0QWqes9KKWEkQdDi9LuLHWKC/8YHp7+5XKZwqsx5AP39q6GaQ+gZX/7oNFi2fmi2utOpaKJwUi2V5uLmo5wTEL+dcVRWlE1v2rIid3b8pBf6Pr/BfuwHblCCBsvjuAqlwcq5bbmshhj5ndVXEaLVNjBpnmUgqkWrUN4OfiGDSDlqPlV9ZjvlBVdCnID0W5CHYWYp5QJKdhwTHHQChl4IuEwWzZ41JjDgyy8W2kZqOMSi5uQFi5GrAy8Olv/t0tLQEo580S9xernvkRUppFyaFUgJlojjt3aUIyozJ5+WvXEjz3VAsjTtfrpUAtJMcnq4V5hEXmmwt/86gKmnTh9Yldwh03B/+mSXVereCfzQaAnSJhagXVOJVHk708Y7pDDZQt7K4zrkzzEvecCQFF8WLbh6/nrUrVysOH+m+UGMP3neWHcUarDDVwDzvTzizyNtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199018)(44832011)(8936002)(6486002)(83380400001)(5660300002)(186003)(478600001)(1076003)(6666004)(36756003)(6506007)(6512007)(316002)(2616005)(86362001)(41300700001)(38100700002)(66556008)(8676002)(66946007)(66476007)(6916009)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?At1nelohEynmT4i81HCjgpgQ6BeGgtG0hI9k7wwi2PaeRUzNhPt67HKn7yQV?=
 =?us-ascii?Q?YmA++OU9N6B2bqob042jCnLHs+XEKgF3u9hdzUrmVBw1W7SAB2eQzBQBs06c?=
 =?us-ascii?Q?wcc2Vn6AE5BTumAbcL4vTZ0wPi4VPkrv9QMOnApZgZdf3mQ6uW+SWNgMSFDB?=
 =?us-ascii?Q?NSWnEuRzHDsPXUwBv1SmdfXijG2tG9fCgct5jZoErImnfoTmA79S7oq34WxB?=
 =?us-ascii?Q?nfSjNXv7nvX7zSAaXfDW9EkwRIu4Eut4wt+umCNGIjumDi2TYmyEb8Xm9w3V?=
 =?us-ascii?Q?rXRutmuI0hsLab77trnKVjyYj7oGxoobJ9ivwyIs3Y9pNbknwHKMkCp7jT5j?=
 =?us-ascii?Q?lTvioYSYQJrRap5fCTkYby5Y5fE0zQN2fjnhOLhYFyl3er/GHGHb0cwye8XX?=
 =?us-ascii?Q?AcxKu4Msn9dP0w8okscGxbssORbBJBGNlI3vdIUP2Sd3gGhjPLrDWq7H8q3c?=
 =?us-ascii?Q?34YOfY2B4FfcDlGvrawsa5RWutyTLSollb76CNm0QGXBGLK4gJZhm54QFviS?=
 =?us-ascii?Q?3NglSaGDJWNwe/+gF3tdLIt/2jN47at2M6ERSdS25j0cNbN44I+0TWL493rX?=
 =?us-ascii?Q?XFBrhBNBKXpLLoFciKV8uP3R7YJniiY6xZUKMqKav6/ZoHPamy3isD7IhAYq?=
 =?us-ascii?Q?VRHPd/7AqLyLV8vUvkwb0VUK2VlBOMyIF0104lLticK3BiLqNP9s0HHEa6ML?=
 =?us-ascii?Q?1cLfVeiPrfizEeHy4SgimG0+jikw+F7fK5Z6U7mywJkoxeZKampqIUWq4ceY?=
 =?us-ascii?Q?2DSzN5ydCbkiTayatRl0ZMxZU25uqfTW2yvaE9tNOoBnC+i0h+Df8GYzxDPE?=
 =?us-ascii?Q?Eb9Qv8hA3BumoFikYvJoTXYBqqRotEi5fCymgdB780TED1ZX70GwBch9nSgH?=
 =?us-ascii?Q?ZGesDgV6UCP7O49/vu6beiWfC3z2xpFl2Yzcq0cxuw5/gEwKhV9ro0IkdgZw?=
 =?us-ascii?Q?BF53ELRQfI3rhDgdwIlEKSdFhEChOLILe2HhPfpsgqmD9jlSME9kUbfq5+2T?=
 =?us-ascii?Q?aYNDuq2Kj3COZV5Xftjqu7DVzXi8p4V+1IT3xXmd1hAoF0FwQm/gCcXlpyy3?=
 =?us-ascii?Q?pp0r4SELs8zLJX76DvJHGKRV0FyidmISlzL7mgn8A3KyZ1fxGZspO1BzV5Dj?=
 =?us-ascii?Q?tO3A70TETXTxfDjm3joIYjlQ28L1cdjgNjNqt6x4Qtc2jo0UUdFCxAzNkBcT?=
 =?us-ascii?Q?vvDfSG5ja+2d39sY4a3v89cE3r8+KbHgYHji++NdihNcwKFg3tSARVsezaXI?=
 =?us-ascii?Q?KL9Ev57fpo3Gkcv+EoUJeAy/dB2e0x3a4zPGDJj9xUyBMFVLnFddxZjbssdF?=
 =?us-ascii?Q?ZK1/Y9PeUd/+6EvB5A4aXzavDjiJwcwcOHON0FXo3vLZR/GE6Djn+OMj/bvo?=
 =?us-ascii?Q?TzFBQik8RPVKskBi6p/B6AzO70HNASIHnhro2EyAHiRp7u+dhXRcLMNZ4BUv?=
 =?us-ascii?Q?ZerDM8tISULYzw5g+HNKgyH2QC+QYlJUwsK1XvIk8H7PfwLZ26UwkYs9c/fX?=
 =?us-ascii?Q?o7zgbgc1BnqYNOUN0MBD+iuEb7JyBzbLpzx2o8hzogiGxoDVQyela2WruzEp?=
 =?us-ascii?Q?YIA519iaWVSm1jpT9ouJ8rDM6GrWhC1AIFs19HxhvkBZPJGMMBgm2o3SPKfy?=
 =?us-ascii?Q?+Ds6lOGsBAQx+Q2HMP2YLbo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zxUjO17BEwN/H4WAULD2b74H2NcskTx7obqy/jilVIZWiMKNQn8QlkLa8njM2KN+Qs5gYmg8GNpLO4244h6UVctYYIcLQP0YjGB2Mzx41qrPbmq5J7+UMhH6qAgnf24obsVVpUsyJhxoB9wZDj3DuDG/Mstfl49V+00YsS9Odkpsbeud0W2hz7bOgJHSYDqg+5VNC7wnHzk6S+FirTxIwdbb0VaR4g/Z4WOMlfF+/0GjBysJYZBRIphQ3KUEy8ZVk7PQ9Ur8JauLkpK28WkZ6ohMJxB+YxyJvVbpMDM65V0Yz9G85xQ4ddyo33NgCdNwHqJd+RfWm/xqjdxmOFgH2WwJ2Ub5baBW9VKrHY0Cvu7L6K4+C6Wcnqg4FGKi8iPhm3JMD+1BnstjQgNyc3N4p+M0oVnl3a5+SccJUYW4EmRdv9iOjz894lqUPn0vP259jC+AmG6f8xYR4qae6CKbK64YjHtg9aVFqpRavJxDYyWgEu6rf/WsVdD0pLqzEl6+TqcBs+zaSUcLI3W9y7BFXznK+/PJbWe4RbVW1lOofvukk8/8+W8SDL9KuzSP1rwhV1aEt9kPhNCz+sE56Y0G0LFNy9iFPKD8dbSfK0owZ/IqFGN15T1JN41zoWCvYRAvVy6WQqO2KmahWaR1H2fxZcA9DusSQxpM3KdArWxuTgOBdwIvGfHkUpshnUnSvatiNeAgYXgs5eg8nQzx/EE4/1Veq/8OnAsw8hjj/fanCHID5e5q1QvPjn1ORQEWH1iMl/lJiCJZhjS+PdqT5Up5qCXOEy20EA7b4vOEd7i7Z10=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adcccf0-5328-412c-283d-08db200d7a3e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:44:06.1552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OD+plcn5h/LZ2kJZfqAAi69PX8ULAiKG7FitkiOsaTTCpsbWCFbV/v4WqsUj1nn7dWnJ766Sua0yNugW4OWr5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_14,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080166
X-Proofpoint-GUID: ktJsMdR280eMyF0TUmE4LFD0iRHZsm9j
X-Proofpoint-ORIG-GUID: ktJsMdR280eMyF0TUmE4LFD0iRHZsm9j
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
Cc: Lee Jones <lee@kernel.org>
---
 drivers/mfd/tps6586x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 2d947f3f606a6..90e23232b6b0e 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -638,4 +638,3 @@ module_exit(tps6586x_exit);
 
 MODULE_DESCRIPTION("TPS6586X core driver");
 MODULE_AUTHOR("Mike Rapoport <mike@compulab.co.il>");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

