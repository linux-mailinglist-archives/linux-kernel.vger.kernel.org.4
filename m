Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DA36F87E6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjEERqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjEERqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:46:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C112D1A607
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:45:38 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhN2c028545;
        Fri, 5 May 2023 17:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=zUoTYTMCkwTw/+6/qqWbswBoxi9E+3/SfiPHa6ic8us=;
 b=S6+J16g5TMCmzs2AmWW1GYcdLtZPGyPGWv8T1pG7nc+BZcW1lmcrNZxD09oYly8M70cV
 FbJQ5L+0B8AYg2h+bHvOfEU2GqoXfWOqlb3igZcytjWtnEVsUp0YRvcFza3PJku2QZ7Q
 66VqNuGok2FRMLuHt4zqBeSGNlPXEF9wR9T0WeAwrSc31y92QYVp0Ia7waUsIslVk1tE
 7vc1LGP/kszdy5xhhrLM5nhyLmzyMJ/0Lqm9dqgG9L3IBGpcQE4pivHzICs0J8+DdiTQ
 gMN4eCHu08uPp0H6XvU/wOYlNkbJdNiU2/aRysgJdHXh8pW+wy9IUpJmehwfTLEFI9WL vg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t5fwf3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345He9ff024982;
        Fri, 5 May 2023 17:44:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spacjak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3MaMAOFC4V1gilFGPXY/lPcB6TdZPV3EO0krjrGdxPepCfP3lXBFwnYXo2v89L76jBplkSARfISuvDozkVnsV7qmizNguj8rDH6I5KfFmXKOPXuAZ1H5yJsr0AZevikqvFYvTvxxm8uV5SuUqMt7hKb0GpJEdSQGZYzUB2qdw0lWivelO+g/DI2Lf4ccEKMuIBpa9xWwV/dXbRSzDOfgbL73vV6/bPEtnUWMIeZdNjYSQIEWqeKPhvZryX0WzhntYj90x4Dj3PXmmMCO+Wa331HSDSdrwA6BuIRducVWDnJMkbtu7h8l9d/hZzfLxgeRdO2XJ3fj42X8SA+G5aXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUoTYTMCkwTw/+6/qqWbswBoxi9E+3/SfiPHa6ic8us=;
 b=oAnmGBF2Q1TwdV7e7a9MjaFfOTxuq0sc1IOu3JsQ59h6m1EIoFGy6HN4dubcNlapyGumVhJ4+Huwm2scOVLGnE9tchznghX+4Ba+LdWeFxt5RlQ8NlNFZ6HjlPWea9uASG4uM2iZ3BrKrxgbfxHM5y2Vip+nn0d5MCqzrglqKidztkUNe+IjTCD7juMDqKqCSh+z3C8pCOmubjAKt+qOtjw8nt6gWIUWIHvvQ9ggOpWAnNATcnQDJijPDyT8SzveyTxI1WOE8Pl8s/t+3L9VvZgB6vXJUz2p2hOpxOPJux0Qf9QG+pfPJ0TX5a3LCjdQuc//WxPoUZkzGBqtrN3ajg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUoTYTMCkwTw/+6/qqWbswBoxi9E+3/SfiPHa6ic8us=;
 b=wXwrk+1HRcfHv82kgfHWVmyaE1RZ69AQC6amJZZZ1CEkRqn94JsWFswsCB/NR6BHvV/bSlz8dyaL1e6Q3s7w7tMbxL9QRQjG/4zKZhFJE5AUH2OMJOaM5/7XV8R1uShvMG3/g7nUmorvZjYVTX4KuC7t+UzukKy2+xiag1Icpbw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:18 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 15/36] maple_tree: Return error on mte_pivots() out of range
Date:   Fri,  5 May 2023 13:41:43 -0400
Message-Id: <20230505174204.2665599-16-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 839cb527-22d8-4cc8-b394-08db4d905a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyI4o3WoxFdD8Y7MScXDJYl+KOPVh0NtpmgaPcV2XZCKLobFz6t8Opd/ewo6bZTgrUt0tGxHbhuNFUQlQxgz9uideDdqVPFxII8vr3sLcyJjKbzQdCTG6H2Bl4ocEUmYU+aT+Z3OwEv83jfkOsPvCegk74xkeIMKIuEq0N8UvUT9UtPINV/g1cMSqt5p/p6NzTsTkLvp6yh+HKgCINz/MFexe7ms2qP0Jdr1pE/AmC/XLFsL61pTXb3d+1/YYLko75X2+26cDD5asrHFTkjuwKS/uEVaTLz9bgqpInrWyVMoHpxMDU0RoFtnhCuUddi9hcN6lMlVU8oyZVg/7QBv/vK0ykbstM6reQLNfc686Qzy8/0JA3R2wamq+lYateSiI99jqKS4ATXM1jI1cz7c6vlsQtvtH0Ga1epwgxy7/oSNnivj/X0arIW0rYb4NIRK5BrTWvkylv4pFxRj55Z2QGmPDDiVSOI2ogdXlSsMmcP0eekjPkazgR7JIJmwbUSGSQaVt4/zLOeoS0SRihti5qLxq3uANpfDFOnlMEDz+ET85OmkKlk57ZZ+Eh8D9n6o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(66476007)(6916009)(4326008)(66946007)(66556008)(6666004)(478600001)(6486002)(316002)(54906003)(36756003)(86362001)(83380400001)(2616005)(6506007)(1076003)(26005)(6512007)(8936002)(5660300002)(8676002)(2906002)(41300700001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3GgGhjxTWnxArczJ3BnSuuiAN4y9go7LZbY0upkf+gVirYXiF4nId+UVPWSO?=
 =?us-ascii?Q?94PHlHX+zbWbnHWGxxEvDvILzC/nK2TOhuego9Uk5uH8XSLXjx/AhKKfq4bK?=
 =?us-ascii?Q?b41vpXZqwphdn2jFaLyb4iomvxz3pIsAjoy0djTsSytQIeOPOlTjUhUQYovt?=
 =?us-ascii?Q?lTbdjPyQE5brzUIMVfw4nVenX4lRXFPHxs6Ne+AKpLtlW/rJlSScFvfeC+w1?=
 =?us-ascii?Q?p54K0WJVTZaHSpB06/CUtnQoS0jW40ww3r/ARg21Lh+pirEQa201shfFCpGy?=
 =?us-ascii?Q?OfzFeRrzljXuSAxfuhmH+L/EoghwoSLnGGB5OTYeNRRjzqCIKE9IL3VpJpAX?=
 =?us-ascii?Q?Ag0bXWggPgE/BColAwhDe40SdTJ2Z+3OX0cGFO3+K3YDZ1U1wct8XmTrvv6i?=
 =?us-ascii?Q?noqLy03rnWk9iwVj30Xotf9kmpGP99WYi+BmiWduk4vj6KyM1sXf3/tcIgwk?=
 =?us-ascii?Q?sxg5Guk/EQEvCpaFiaPZl8ST1hero4MU9AwF+xwLOEBFF1kTAQ5iVc5HrtU7?=
 =?us-ascii?Q?9sI9SBQSXMROQSDzSjSdIMN0SDD8a8f1TvC2ZlsFyGsAeIf5lJ/iC7rewZA1?=
 =?us-ascii?Q?rVUlN8j/mxmjTVzvWYZAxfSeVudRg3RZJPO3YBlc/IEscajIZk6ihpwO2Mnw?=
 =?us-ascii?Q?IK9ZxxarQKOgxB7ZRkQ1s4xwVs2jyeN2AQbQcSN47di/53/yr5gi7+sXJchU?=
 =?us-ascii?Q?OxXfPflO1iJWaOHULBo22jkMBLndVHbEhZvNtiJfLsnLRRjQq+mJ6N4hG4P/?=
 =?us-ascii?Q?Y4CtNOA6XHuzrzlVOHaV85arp+E0UORN7Yu+LKDgetEDIClkdUzCrznOlJwy?=
 =?us-ascii?Q?Rw3Nuu3oHLF9xJvUFaf/3YMcV7m+Jr59mQAQQYNfur+pq3GNKPqgvTkuslOF?=
 =?us-ascii?Q?BQ9JITXLNZ9ab+ApolTRlO91wZl6OElW8bgXR8qgX3U0fv/hT7wh9E/w9AG3?=
 =?us-ascii?Q?TeUkY8HnjV7sie04Aag8LGNiUI8ho0HssTC2QhbD5a2jdtFMZuge/7mRsOkG?=
 =?us-ascii?Q?HT4TR0ml9NvGL7RvCtYkmIMXzmEewc3PMqUVI18q/WfGvX2bS95JNCZ3Ma7g?=
 =?us-ascii?Q?uSTxFBqkzRcs+6enIiS4GfU5iRhY+8MYNAJKbJU1pvnmIbCwvtpgi6cA18eS?=
 =?us-ascii?Q?J7xna9+43ZrOXq3bFug6kKWTmKMOHGEoNudjTdras4dGliCv5bzzVYo/Wmbp?=
 =?us-ascii?Q?AcAIQU1RVQPVCSD6LYV/3vpx9K2924IJbcDjUbz1iosFJsiinjWtuCPnvwzO?=
 =?us-ascii?Q?ubcwwZCEwPbQuTz0+NT7IY+lvHOv4F9sUhpq6YZvcZX5/x0vNttQUelOp6aq?=
 =?us-ascii?Q?4kFW3xKgJWG/FGxjgVCPEvWicsKOSN3cQsu9xN7aNdwmD/PDt118ubKOqJX3?=
 =?us-ascii?Q?njQq0IxeXE1NBq0n+xOwXKNdsW+bIcIT70B3bjgxl/CHn3sqjjHVT2KAzFh0?=
 =?us-ascii?Q?vEfYc2ceBRSpdDr8a7SS0i7HIcsS0QC6N6RaX0SHAJR6J8XbSsjGW0IPGLQS?=
 =?us-ascii?Q?nbYPkeV1ca0qNJRQPCcUPPmWFfzNadaTkoF1MaWBXmo2iIq1YDztpoFZ/eFm?=
 =?us-ascii?Q?vq342SnVSi3gHYoecE1p9eKsvay4bfCEQLsPBLz6PQK1m7hrowzQXQ0mT5WP?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?HgsV0Hurf5gVcIBGcPnOsgcLhEYCxrvekhlpyLJikzUa39lGkemjp4+adaxc?=
 =?us-ascii?Q?PA/4AbnfjLP4CsHWFvT9X6YSL7nnCj0gqKL9F0EDQmPt6P1QRqNOQv135gMy?=
 =?us-ascii?Q?G9+w0LOzBl1ZAdJMcjRdn5387VFa1EjPrl3IFmtNpQChV40kMnpRPVtha3U1?=
 =?us-ascii?Q?lWDLnERUYiRBPQXhO6nzST6+iLnfJ969P2yYLQkE09+KlFCegPzDj30f5xHe?=
 =?us-ascii?Q?mWYOznsx4kXFeOHMx/81bbGDbYD7Cq8OVIwzzD5HdWyKf4y8irwEwrHZGM88?=
 =?us-ascii?Q?F59W67ZNCpysYxDJBXm+xZhPHqfYjNxpccOPJL4VEGUQYsYvF+CS2waXQhei?=
 =?us-ascii?Q?QvRzJo2oaBtwfXOtAENPCdmzARcxUcZ64DQCRAvsbpURZouhVOLYt67NdqAF?=
 =?us-ascii?Q?Rb0JicEZESNkdGM0NEy94O+4wrmK2va3P55GtQtENHmPf8DNePAHtVzbPlif?=
 =?us-ascii?Q?0f+vR6cIjt8qNKmAUc8Z5EmJxy7nxsdntjxeAiAiwNUl71yL7LfSZOngz0Rt?=
 =?us-ascii?Q?H4h5+ihFqrSJAiMfRThKK898IVKNPhM5o6f0e+UpPl7T63EzwjahOzRsAEoW?=
 =?us-ascii?Q?VT2e3olrsoO1BEi07UbGJEcVdqDbv1upzjp+4SK2ZOC9T9PnBfK43ecwCdP+?=
 =?us-ascii?Q?crfGlQDdMMoOZBmBLgBgWCo4IvM3EmtVVqJtFWdXapdV2450JTZzspIYM4+W?=
 =?us-ascii?Q?Z03Uge/ERwXx3VjVn7f+Df9WJQbyDibumuRTdBEpoYzFawSPGOatmsF/SFCa?=
 =?us-ascii?Q?aYKx2913rZ98d4dK9jr4rpiNO1c4Sv1ASTXr5gKlVW1ZEN7/HFNJwP+ktLxP?=
 =?us-ascii?Q?DVOK6SZ5PyNxmt7KCWSd2T0nYHP2RMA8P92O1TJufk58MplJacd6fdJCRK6L?=
 =?us-ascii?Q?zsv4ww1jVC9bYdMGg8vhHtAtTBp4oV9Tts1+3GTFIyhi9E0tD21elt776uED?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839cb527-22d8-4cc8-b394-08db4d905a04
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:18.5093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKizUnttVTJFJjckjIQIzSqfyc/G3oFIUzzMB0zNeqCnJDUaCRCRQOd3bzrCfs+bJRbbCGkg5BQgRUmfHNKrWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050146
X-Proofpoint-GUID: Sf1wnS3f9QUWX7JseDho1HaWH8LxLdhk
X-Proofpoint-ORIG-GUID: Sf1wnS3f9QUWX7JseDho1HaWH8LxLdhk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename mte_pivots() to mas_pivots() and pass through the ma_state to set
the error code to -EIO when the offset is out of range for the node
type.  Change the WARN_ON() to MAS_WARN_ON() to log the maple state.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d7809a7000c58..9f3784f4a5b7c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -663,22 +663,22 @@ static inline unsigned long *ma_gaps(struct maple_node *node,
 }
 
 /*
- * mte_pivot() - Get the pivot at @piv of the maple encoded node.
- * @mn: The maple encoded node.
+ * mas_pivot() - Get the pivot at @piv of the maple encoded node.
+ * @mas: The maple state.
  * @piv: The pivot.
  *
  * Return: the pivot at @piv of @mn.
  */
-static inline unsigned long mte_pivot(const struct maple_enode *mn,
-				 unsigned char piv)
+static inline unsigned long mas_pivot(struct ma_state *mas, unsigned char piv)
 {
-	struct maple_node *node = mte_to_node(mn);
-	enum maple_type type = mte_node_type(mn);
+	struct maple_node *node = mas_mn(mas);
+	enum maple_type type = mte_node_type(mas->node);
 
-	if (piv >= mt_pivots[type]) {
-		WARN_ON(1);
+	if (MAS_WARN_ON(mas, piv >= mt_pivots[type])) {
+		mas_set_err(mas, -EIO);
 		return 0;
 	}
+
 	switch (type) {
 	case maple_arange_64:
 		return node->ma64.pivot[piv];
@@ -5399,8 +5399,8 @@ static inline int mas_alloc(struct ma_state *mas, void *entry,
 			return xa_err(mas->node);
 
 		if (!mas->index)
-			return mte_pivot(mas->node, 0);
-		return mte_pivot(mas->node, 1);
+			return mas_pivot(mas, 0);
+		return mas_pivot(mas, 1);
 	}
 
 	/* Must be walking a tree. */
@@ -5417,7 +5417,10 @@ static inline int mas_alloc(struct ma_state *mas, void *entry,
 	 */
 	min = mas->min;
 	if (mas->offset)
-		min = mte_pivot(mas->node, mas->offset - 1) + 1;
+		min = mas_pivot(mas, mas->offset - 1) + 1;
+
+	if (mas_is_err(mas))
+		return xa_err(mas->node);
 
 	if (mas->index < min)
 		mas->index = min;
-- 
2.39.2

