Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101F46B1243
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCHToT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjCHTn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:43:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DA47E897;
        Wed,  8 Mar 2023 11:43:42 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HiGcC011090;
        Wed, 8 Mar 2023 19:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=/lxiSh1mOS/Rmnzx5AnpW1vau+XIB+AgQoc0nxN/jsE=;
 b=R4udNk+aS2sYItTprPigky62jb4i2NnWx1d2zx7+OpErwaOmjzde8C3nPZY7jGWpWfqe
 5oRnwpXP7jAghs8YvM31w4Cbo5Dlc9FZdTcJfx3425oMFA6yR2YgAOXum4+lSaGOl18t
 qeea208mR8m2xVyVT6QM7Mk9MQ5Q5Z8YadEZW+hW01YWbgEyrAW4q0fRgVT2Cw8u9bd5
 3ElJlyqWv0uWmnGfi7uVd9faUgtO/Dkne4kr+0h2sKzQs/j2OISvoNke+mNvPmOVV1HH
 N+O7xLR4fiBaz5Alja/CNd8zLn635XJLvQAM2mXrLZnA7txm3xbiyMen/dbFwKxt5yq2 lA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p417ch1tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:43:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328JUQd6022428;
        Wed, 8 Mar 2023 19:43:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fr980cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:43:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYSjm5lUFABLl2xTOpERI0+WrFx5Y/gMRVgljrViKVa+Nk2qYMLBe2ydIJ2dKL2ljtl5E8dTQA2MzcKLiqIUbSyLEHTusPYz95f3W6jcSrXuFGtkcZ6Kgsr0MzzIdfVdDHi9EeQ+nh0oT6Wz8aE32t8zS96+6aGyTJGOUkPd34C5S+qrbOdIunCBUGgqq3m2P2t0sDg6BVD8KopOWcIiPstqZKh83mKGjz6qAeJjBkn7p3JceRoB8M5twuDEuhroWKyNZhB/2Ptn4lp6CDXw0yBm+NN7W85AR0I+TxzRtepU58A1eaDY2TDXORVtJM5xKXJQtUnRxeUWEowNjl3WTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lxiSh1mOS/Rmnzx5AnpW1vau+XIB+AgQoc0nxN/jsE=;
 b=FTitu3QuAqL9jg+wZSYXDyy9+kRpk+GDuMQXDmkIe3lFNaxTxxkUKQq7NHKAOk8fsr8lHjNDnsn8pLLekADGaF+cLHQ7/Qql9fNJptvizJdRsN1WxVNQ8bJgi5n51zOZS3frde7QBYG4zxQRCfCk2SunkXg7fsOzQ/ElMT0Pm2fZsnpqIXHOulk9JgkPtF/wbVBLoye1+eUaWDLMQVgAH45dc9WODnH3ysgbpZONjHjQfnWQ+205apxDt1ugnsxje6jOLyYshYg9qWVQl+rNHIn4qw1RtN/w2mFjvQf6chREAJYLxIN0XB9Eq61vWVxDZTjz6avwtcdMwhX91Di3dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lxiSh1mOS/Rmnzx5AnpW1vau+XIB+AgQoc0nxN/jsE=;
 b=zsiFrEk69bZQ/9knXe1yPWtbpFvDoiTza6RjrMLtMoJmA4xFnWy8JuRKnCmNTDYJoIEaMAnfA9h6KuIu/IkjLkNjk8epFDLWaXeU/nnp0I7/jJRbW+fAK0u01cNnTBIuoCvfVwQz1h8h9dxzBQR7WsI0wBjiIq8arVDKnq7JjVQ=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB7035.namprd10.prod.outlook.com (2603:10b6:510:275::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 19:43:33 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 19:43:33 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     lee@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 05/18] mfd: da9055: remove MODULE_LICENSE in non-modules
Date:   Wed,  8 Mar 2023 19:42:54 +0000
Message-Id: <20230308194307.374789-5-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230308194307.374789-1-nick.alcock@oracle.com>
References: <20230308194307.374789-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0023.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::15) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: eaccb648-04a6-464f-ada0-08db200d66eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjJjRJ49JsAEtyigXV6VMDX4hrTI9ZjYAo3J1hZjE1XdSIOYlY/kJrUoB6TFC1AOxjqSm9NLUNqIgGHxhpaYZ5xC/DICWy3Xv2KvpLU+q5+KgQrxC+LoLUzuTSXeJeb9or1RqfuK9UR9U9Vx1GXzh0TUT54xVTqKBKqijQVMpheBtnnaB5UpZYcXp8H8bEWFFFCoZgnnHA7Y6UJx52OlMw/0TOQ7b6r/gZuaytspyX/U6FrFBkRds/J32/tLRpnxtGQ0ppSq4SVL0IIEiqStnwhXp0n8ZDoCZencQkd8I/mHnGFDFR4Xxaw4xCujiGWdJflsAEv4yrdr++vLj+byOYzWXUaaLfyTkHVO+eUW8I44URX7IlCtCcvhMxxKzmnyk0r/0QA8pob7j/LTmGviZKih8nfrtMMlaj6bM3RQQOE2Ulcigx+T8Pc04ORzUo0M1F8PFb+3EU7YxokI0Rq6V2ud/i+TeFJ3taa3b/qdqniQBvGS7jFVlGMBgBgZf12RYdCDH74ULXI436pUcULBeY4s9y/3V0ykh0j8Rq5Uuedegc47pFHmqVNYgHyl1SrWlTKOa7VsBZW8FiSOZY5L7ffIrRcI5AW0DQCyffS4kYvqrnxArCtip2A6uarztv5QZhTC/81Km8WjWYTriCOvnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199018)(5660300002)(44832011)(38100700002)(86362001)(8936002)(6916009)(36756003)(4326008)(8676002)(41300700001)(2906002)(66476007)(1076003)(6666004)(2616005)(6512007)(6506007)(186003)(83380400001)(316002)(478600001)(54906003)(66946007)(66556008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gANS7w/iT5ssN9Cu/iy1RepF1VXcQGTIkrZux8rK9P+qVd9kqQCXsIeIQ+CH?=
 =?us-ascii?Q?jaKp9l6Tb1a+qDeve+S580LfTwZcn1aAq8ZbpnMnQlQkxdoaVdD0J4nmN8Wh?=
 =?us-ascii?Q?VWn7zpgC70LQ0+oUHRZpDehC7LX7rwbCcVFLP5vB4yFyOaUNMXl9zdQTqWuH?=
 =?us-ascii?Q?A60D7VRhQpWHu/HcDkR1+8VMOOAwvyiNw/zbJ0mHL8Le8gZ0+RfQlx9YbwsN?=
 =?us-ascii?Q?RfScggL7qRC+3gD5V4Fjyyi7oI/ZUios0auQgEbAE7hQNsBctJt1D5Ifkugq?=
 =?us-ascii?Q?zDZfyuTw2wLONl41/8WrjwHHmESXgJeh6PUmP4Z6t+GAC127parp1RJ0xpkS?=
 =?us-ascii?Q?mQmjE+fT280LoxkCVUqmvJD5omqoijJdU4y/5qv00OCGtQTe/Z4PM3U4+E+J?=
 =?us-ascii?Q?FvnqhgGNzIXKiSgBtg9n6V7QITzDOCZFosAt+ITZ6qVTHLjlimi2cX05DDCz?=
 =?us-ascii?Q?bMircflE4OhK2xJg13iGbvXIaCw/8d57kHcr6BJ11KeNYm9ZhGg7SUL1k7Sg?=
 =?us-ascii?Q?dQjtgnz9Tt2RpnCmGH/c/7ws0cCJ5R2mOwusq6hI7GiSfycQI/mH4FTRZn+L?=
 =?us-ascii?Q?KsfYipzb5ls2uzNMykY0g0U8x4Svpt1LmX3d255AxUWyV73qOWvGxvnXe05Q?=
 =?us-ascii?Q?xcCVItB1u8mfqGVCOgEPeA5d0GF8n9dZo96aDto4+SC+n73yjv4AvmuXibu8?=
 =?us-ascii?Q?3oJTtloRfwCA3UJj5QBzOs2kMlsCX+B9JW9dq4XE6bbuVSyVGohbRlKlB9j9?=
 =?us-ascii?Q?pQkyWNR+7btbfSCpU2qFk+KIXPl97mcJO4r0ZYFSdvhfapQ2oKHFYe0HPRYL?=
 =?us-ascii?Q?fYyzcIQzT01ExHaGNPolrejgn1cjMmOeTv8GprqoEAUr12VwYecL/VBwpunj?=
 =?us-ascii?Q?FtCZBS0HSet7OBKgAGMHwC4b4yppnG+0JnCa4Q3G9GaQRsG5WzQNKX9A9BEJ?=
 =?us-ascii?Q?MiN3NG3WRBKcK0fmf9ULKs/bmmemKQBrbxUnBpN5PJ9gPDQ0cqX2mhfYGeQs?=
 =?us-ascii?Q?QnvhSWIorkwK++Y620m3oUjHvjJs0h5Kgk8lUbkcNc74YXoVV+l6kEYeEyJG?=
 =?us-ascii?Q?8kOFY+Rw1yo9BuOF1Aca27Rv7gw+8C9dJvXL5fEsaiwaNuCqalV+7lpHaSjR?=
 =?us-ascii?Q?iGZAQnwELD9i6GHDl4W9K9g8KxhDb365wWH2cjzyZnjgyVF19IqLHTG8l569?=
 =?us-ascii?Q?74hmT8gO9QI5IgdnIKp/0o9ZHmTci4Gy2J3hHi2W6d+levGVn6pIJPU+3Jxa?=
 =?us-ascii?Q?G8D6yGdMi45L68Wcb19GpQ9aUIlXL8OPdcPcYc5yCFqiO+m4xKphry4yG1fS?=
 =?us-ascii?Q?6RhTelJ8Hzct7sMKRdd1XPw8Y1FiLc2tBNwDsbyFu5VCerHkUZgz/T05vWLL?=
 =?us-ascii?Q?4UOJtqAMVrajomvMu3bVd992uKUbswJOFcYLHvtibL5pRjmnyn63CN/pYvIX?=
 =?us-ascii?Q?I65ruUXOOuETSZ/X0cOi7UrUMSLdQsnd5LLhsuO1wampkEjL9ouhmPjykBxa?=
 =?us-ascii?Q?jqamur65cl62oid/BfaQqdTq+a3cFTsWNy3C+rOPYVDLDbLXjTO82IBqBtPz?=
 =?us-ascii?Q?vWlkaA2E6TEaKkVx8x/ruuo57nlq1ra862tyrnG3Dy5tnMtJ4KlZCpwZiJgu?=
 =?us-ascii?Q?n8bbnslTcdsIzdHYzUh4py4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1mfyI036jUtbsOKwPBnEIt4gu0GCxgpjp/TdWS+ExfdlmRROeNutUOVndiY8ranQWIqpgTvP4yLbrLc0Xs35tQOEt3crx6CqsySdh06PxnOieZ3U1apLXetMqcUANwUXNC954WrWHy1z49wrd95axnQMTBUD+mykMgflzNf+KeFZJmAKW3g0lEglJQFTe+VQ9qe6gfXjVUXet6yvETiFFyGyRD7G1oIjZFzm9+1135+oO8L4qisKe4iz5dh88dxK9b2ZINLl2HNleFdwCDHJ8s08Uo609UqQFlK1kdz6cbTo1sO2LDYiRcyKxq6tSk49wlg0Fld/+j6Gs3J44g2Op2oO2tYHjOawWa9O0kpfVKyedxhdzDUiJrfoufjGsP1XF7utd7zWH/VejJXN02XAGsdRb8hVZW27evmJr8vqRqoaQlj4mSm/3YHFZeWJPQFBJ1UOfN5Zi56mrtb3FHMEIjMsUNwJsVAWaJxTtjfKFjzOC4nNIxLf4D+KbgdbnChVyklkROXZAeOQm+MQHpuwjAY9gLmRmueF9kIHsIrKUW4FUTwEQ8eS2Dw6rVSU7VT2TsJ4lLjqbabOr0VAN1a3ZGe2Oja7DeUwitLErx9CDLdIzYSkKkGnibYlv33ktU8Buua1eUj7XbU1Rf/7behQQcdzLcYYCa+tmz2Yi3M6H24NWGvVNfZbHvt5ccNDP+KCxMO+EY3CeoKl+8Dk4kFwZo6CDAVOh5nbyihqGJsNPmYfbeL/w9X+kiOv3LfaFloH6sTlwHVm/q5raMTryNCKnRmBtdRvl7D7uf1vVWIhjfmbUBd+8J5YYrOWqtuTLHVX
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaccb648-04a6-464f-ada0-08db200d66eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:43:33.7223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjuqlXh8fzqPpFNtdRvjYp9hP8Cl5t4L2yIV3idSWbyK1vv+RmAxnkG3sSWPYSiH4b7Bl27w/yTDXbqJMHLc+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7035
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_14,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080166
X-Proofpoint-GUID: nirr-FiR-OmgFgZSd9fAqkZz0hLyiGxj
X-Proofpoint-ORIG-GUID: nirr-FiR-OmgFgZSd9fAqkZz0hLyiGxj
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
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Lee Jones <lee@kernel.org>
---
 drivers/mfd/da9055-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
index c3bcbd8905c6c..768302e05baa1 100644
--- a/drivers/mfd/da9055-core.c
+++ b/drivers/mfd/da9055-core.c
@@ -398,5 +398,4 @@ void da9055_device_exit(struct da9055 *da9055)
 }
 
 MODULE_DESCRIPTION("Core support for the DA9055 PMIC");
-MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
-- 
2.39.1.268.g9de2f9a303

