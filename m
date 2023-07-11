Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D3574F82F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjGKSyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjGKSyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:54:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13704BC;
        Tue, 11 Jul 2023 11:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSEo5lv1f/BLskulr7knyySZN0mRsWpWkYOBZNaOJKrCo1f/8atiNah0n4Xd1lwl5Pf2nI/nHcB1kLZ5/ceACHJJRiNXHOQmsuSnAzrX6gf7Ji8ppikjOUZwU8+n7nhT4SeDNNcnEDWvRPX+8tQR1sIN4EbfzWWiDFzbQPNU9/Vm9xT7Pqsb9ny7tGPiDdXzQzerp53URpen1+/dGwBQHy9yJq4ONXluLTyMr7KIjhHBhDcQzlXB7Bou58Jjusv5WF7Na+VnTfJ+u2DPm4Jwh3k3uDArIZk7rqyO2c2nq9HoeQ3s/N0nfvlUw44KYO6QKAApHjU27hKY/QANrpmPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qPOywUylNDoD4N7IvkAXUdMQFOsCQl6ZNhHdj9+U/s=;
 b=DlyK8eBh7lrsKgQke34DEtQwzWsyPWu3ISYb8kb8g/OYjcq7DlNeXUUihcCzkMlnRhYn280fLvZQcbIZk0XMShL+I8A5XFmKy/1yzyVfxSGcuHLnbtuT1yLbH9p4HHNkqFRkVQrUdouYPQivXZQfeImCW7yxu6PCC5e4jJlebQHukROm2dj3uCQmnAOoUtG2l8v+5fNuB3ACQ3SNSv7wq5ciKvSYFywECct/kQN51RlBd95NAc+OI6c8TVq2Dzthk8B+shYEYKJ037S567fXRawjPg8rkf14gZTP3vx3jzI88G4GaWcyi0pIRC2A/reTny2fQzF8W6v+iLgqvR6raQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sightlineapplications.com; dmarc=pass action=none
 header.from=sightlineapplications.com; dkim=pass
 header.d=sightlineapplications.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sightlineapplications.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qPOywUylNDoD4N7IvkAXUdMQFOsCQl6ZNhHdj9+U/s=;
 b=IARat9lDEEDl12jimYFD9ZC3YGRjl5HdGGHO0HInLey2u18YhfOYhkQjsvv4zbSy66KHi9a0HrJmeCWVffHY1dPAP789FF5TNlIBpMj8LT1ZeU56Tl06uNrbAGi5SNQPUBSPGq8el6AJSKQifM8ryXhCJTXBKPQ0rC4J8dRYCvxnIJn33CT1OtwT2hZFfZBJpvFWsbzhH/yBzqfXFUDXaT8U0xkSmPhv2pRv22qpLaNR+wUpyDzCk+bHuaEUQu/ADY9iB/GL8x9HDDHfgyBIZqPr6neNDLpYwXgJ5SOxzZSHkaciOaFNlFwBI4F/hb8545B7fgLJmdf1dkUqiu5MTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sightlineapplications.com;
Received: from SN4PR18MB4918.namprd18.prod.outlook.com (2603:10b6:806:215::8)
 by LV3PR18MB5687.namprd18.prod.outlook.com (2603:10b6:408:1a4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 18:54:09 +0000
Received: from SN4PR18MB4918.namprd18.prod.outlook.com
 ([fe80::c27a:8a05:c369:eb0b]) by SN4PR18MB4918.namprd18.prod.outlook.com
 ([fe80::c27a:8a05:c369:eb0b%6]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 18:54:08 +0000
From:   Patrick Whewell <patrick.whewell@sightlineapplications.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        William Gray <william.gray@linaro.org>,
        Patrick Whewell <patrick.whewell@sightlineapplications.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: venus: Fix firmware path for sm8250
Date:   Tue, 11 Jul 2023 11:53:30 -0700
Message-Id: <20230711185330.10106-1-patrick.whewell@sightlineapplications.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::14) To SN4PR18MB4918.namprd18.prod.outlook.com
 (2603:10b6:806:215::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR18MB4918:EE_|LV3PR18MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: f9804f98-d278-4805-4b97-08db82403534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V3nZ+nK8fIcQ3C3DdnkWmxBPwoSqxIxz3f1FjRdoJ2HxELG9/DZrMZioMf8IB6YF0Ap7V3loE4jZZbFXnZAbHm1n5FIkDwTWIzGny7vFb14V4k0aJdgvegfsV8Sd7aMm3VkJTxISyE2DyVrBKT+HLtzJ/F/OoDdnSfvA2B7zb8/SQ0Y8yuVu8kKsaMS9QTeCiuqi+Yp3QUZUb1K7dfw2BgnZfOLvauLqHsS+tFUqFHKrCp6Jt0kJaEZbgCkG6hb9swyW6IuaFpnsnK+yGtxJX+rwWzoMSTMqr1b2jXe/OlukGAKgFmLzX5sl80SHrJrWkeApx1Bch2fKyHMJjClYUH8h/hv24dWdaOAFUYTM+p2aoV39h/7azrnrW3w86CzWtTxFqnYzdjqX+RKqMJWldh4wUT+RylIS7AXMprkKKwZCddLVFZLc3O5kn9fsfoQmnu77jvNHZzJGwPYm4lCDfI7k+zNFCMn25flH0Nb/1SDqj2fz4E9udSzqzPIW0NuvsRVDzvtUCl4MeYz0cfr7UIqrsveolwuZn1qOrmlzkooZKoSYE73l02IxKzyS43EEvvc2ceMIVIazi0RmSuIP0Qz/TBqcdu6FqK3soyIKxwHYDgPaDcyNrrthaHKHs01Ypm00wrgdWyAJM5ky8j2/ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR18MB4918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(396003)(376002)(39840400004)(109986019)(451199021)(38350700002)(38100700002)(36756003)(86362001)(8936002)(7416002)(5660300002)(478600001)(6506007)(1076003)(41300700001)(44832011)(8676002)(186003)(6512007)(26005)(2616005)(4744005)(2906002)(316002)(6666004)(4326008)(52116002)(66556008)(66946007)(6486002)(54906003)(83380400001)(66476007)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gkgAxjnAKkziyMLGQYb/Y9OG2ldXcPSaBLlak41YsA6zSTgndUUPGa/WYb91?=
 =?us-ascii?Q?dNXxTKVhk8XT0c1Kb/6f4Z6IqMyyzuBYQU7miotGeuLuOfLaf1laYNldZHDm?=
 =?us-ascii?Q?owlsYM/TTTtJwiPHmbR8iFXZwS5YS6CDA0TwRg02v88uuZwLFcvwLu+BtX8S?=
 =?us-ascii?Q?BbBNUcURTyP8Ooua5F84vEJ9fzlzT6pJj+au42dtr0gtinkecVUJ6v0JPWJc?=
 =?us-ascii?Q?XAK+s3T9OABQjY/ZEAKHBUyhE4OlCkrKF9V2aAieZ7wojYN13hlpJxb/dL6W?=
 =?us-ascii?Q?9rpireIuJl7YVXOWFljsirSAtLgZ2CXcZRiU+VeRGBUSLa4EokWUYTXkse9H?=
 =?us-ascii?Q?034qElCWlkVWoKsS/NCZYZYCpLi7VfnK/LlQc+cbEsZlCYJvd3Nyq93puUPY?=
 =?us-ascii?Q?ls0SlUsbeqonGT9DQTIk4rlsOPhEildMDKBDhD9nMv82cGz++OpMwMP5YiWq?=
 =?us-ascii?Q?OMyN/iXDNndDV9+W3rWW9JjeFbQIOPASmS75DEgAf77oDGA1zTwoE7/iC0TF?=
 =?us-ascii?Q?nBsi/+fRrH4nXEnPfTmfB+oZq65AOHhZLwxJvhoptJk6qp/EjJtkTUxOKQRa?=
 =?us-ascii?Q?dgpijFgCwRx0o4knRN/T87LpqTA7QFSg4EZYDAhVgzMmrnwzBAuE9VVkLEyd?=
 =?us-ascii?Q?K7ghQdsux2+y4XJeSeN1E5dRmujDXeLgcaN0i9okihyR68xKgEz4WULzNNaf?=
 =?us-ascii?Q?9Dj9wobrFDo3JW7J+4BLb7wcBtWDFqibmhQq/4yRYZFE56uU03ZJQEom5nEo?=
 =?us-ascii?Q?JAKXNFwy8izBe7L5kRYSG5j9TO0450a6+TJNPH2pLvTTh0mLz/SJ09Me92NF?=
 =?us-ascii?Q?O5Aq13tBofIA5eflZxSczkxHX+5HTqg6ISdL/E9NJhkVqwTNenIodFeCDQMs?=
 =?us-ascii?Q?r0SH+Jw2Wxchb8oKgP7UNmkHEV0CLLpm7IEvb3ME5eeSaCzdm4J3AOForTcj?=
 =?us-ascii?Q?jgFKteynJoo5Xc0jr3nKToizWIhffBMsXwUm7IYr6cP67+qYEGDejyWX2zqD?=
 =?us-ascii?Q?zr4MwiFXgXRUGethccr4zeVyNOwrvbxsJlz/VMlQmYSrAAzsHnsOefMnkqkH?=
 =?us-ascii?Q?C8n+psJ9QQeLX0WbMAHJMZmmR7d067wqHvkspDgdjQSv6m0Tv85Ic+Cj8PMj?=
 =?us-ascii?Q?WhaPyvyrYfgRybvIFL2/uhOpBEaUykn8voJcv5CYnkX+jPU+ddoDsTxAHwOQ?=
 =?us-ascii?Q?ttuiDqdcilaMKKvHGosKT3ppcGcTgbi6xT6ZBDlRQ0VinhEc4dWGMb5cMYoq?=
 =?us-ascii?Q?+06ynjd7VrnDFS/A06o1QshicvPskSiiO37L3+bjfo28zPOYwagVCbwMWQm/?=
 =?us-ascii?Q?jvXWhnyHSIqNpjuYCXUuqIyGBapBG4vMP3l83t7TYLHQpGbQBElx0eQlinLp?=
 =?us-ascii?Q?A3bV0xdhTRkC9sworV+cOgMZDsvalT8ftuSd82bfSSrpqntboApkWYnKxfIK?=
 =?us-ascii?Q?T0ug7gWqBvhzmFpX+VQknOsKwXDCg7i+C0O6CPHc1qoNTEg/hcCmk+RTxDX/?=
 =?us-ascii?Q?kxh2TLLVgyVACuExCPUJDNR+61kbTw+spKJo5S+IgDdaryJjOhedjapL/d5k?=
 =?us-ascii?Q?k2Hg+sZYUes5AaKY1KP3XREKbUKLHk0LxhjJjJoFzYmlqSNAu5HmD/NhXWNA?=
 =?us-ascii?Q?KpEmcAcua6DYFHaX8HsRWo/Av3RzUWTs24DlE+SiZxEN?=
X-OriginatorOrg: sightlineapplications.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9804f98-d278-4805-4b97-08db82403534
X-MS-Exchange-CrossTenant-AuthSource: SN4PR18MB4918.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 18:54:08.8349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6f56283c-2197-4913-9761-239c8b420cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkSO9S4S7Qg0BGO/LLFqNg6cLE6RduoP3hNVVRl4HfbRdVj7zMjNLqEQjT1LHjs5ngl3ip+2IfmKXww58N32kNH5nSCdpZo/9EYUlsvgKd0s2OP5iPf5kSwr6kGAztrfb5jY7yTi99p/+IKKtoy6gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5687
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware path for the sm8250 resources is incorrect. This fixes the
path to address the firmware correctly.

Signed-off-by: Patrick Whewell <patrick.whewell@sightlineapplications.com>
---
 drivers/media/platform/qcom/venus/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 2ae867cb4c48..348085f8fc9c 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -814,7 +814,7 @@ static const struct venus_resources sm8250_res = {
 	.vmem_size = 0,
 	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
-	.fwname = "qcom/vpu-1.0/venus.mdt",
+	.fwname = "qcom/vpu-1.0/venus.mbn",
 };
 
 static const struct freq_tbl sc7280_freq_table[] = {
-- 
2.25.1

