Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156AC5F99F3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiJJH20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiJJH2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:28:06 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2070e.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::70e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3556BCC2;
        Mon, 10 Oct 2022 00:22:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmOjfjWqKr0fIRg3tID1noIHSpkDFdV/BMYR7zO5bM/8RoNSvARbvZX18ED/r34sSvuYrBJHP5KAOei5BwxgAovccszRfi0mqlPj8qs5cUOQidWZ/w1vbeb9Cd0+kF7KnTKJM4X/XVQ/FiGAKakF0JVXwyzakwkER57XR57MKUKEIBEcv/qvwu/s+ZJBu/WKBBApYQKcSzPTY42lhSqxrpGq4upVXL7PsR9HwXPW9ekUnR8+/KnZOmedUNxk4aQBbfBLMO0qI2x6psg+dMtuuXLNdNsP9zMvVOr6zluiQcOQm5Wj6OVgmywarlRz9u7L8Tc0bZ8YLPYeXz60OzFLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgbqflBWxuge+vseUXggqNFukZMjEaZtxmcYPj1C6wI=;
 b=NEDjQZJQSGl0oBNAKKKdQMnX6oxJvpzfEK3QgxuDV2vWwo1P2UxWg6ecEzD1LD7jpczxrD4dtJtzR4qqRiwg1P9RyJaQzSuzTz711drBwFjgLkY4sQoxZUnCOo+YjBp3hcigFZr8X8WcrJjpgrwvB1vge+47QCy3Bg9j1BAMTq+95nIBeaNlevQ9zgg/YZs3ChTq8A+EVY8iebGSlcR+CmgPIGPvjUR+bHQj1j7kvUMv0Q0FIiDlrgXgLDuYSftLVgibAMp1lh+RcoVZg5xDECIvTQT3GsppU5VBgn18JtnkdcMoNwZhfAjxVZDCTlN/wxYnBzVuVWFrrN3u1qq2Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 145.14.71.66) smtp.rcpttodomain=kernel.dk smtp.mailfrom=zeekrlife.com;
 dmarc=bestguesspass action=none header.from=zeekrlife.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geely.onmicrosoft.com;
 s=selector2-geely-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgbqflBWxuge+vseUXggqNFukZMjEaZtxmcYPj1C6wI=;
 b=Sh5mR1cmGojH9d5NEUNs1wxqZf0KKtRKRA5uDQTkgJRuYNsf89IEid74YMClpl2gIe7GYKPiqByAv1sf+h2heRm0SPPtFZH1cigR8w6ZQ+qZArG0C39j9btM9kJAx3YL2CDh85NRYxHB9hhPT5XLQ9RHdOPUi3eqGsvCjsQO8eE=
Received: from PU1PR06CA0020.apcprd06.prod.outlook.com (2603:1096:803:2a::32)
 by KL1PR02MB4834.apcprd02.prod.outlook.com (2603:1096:820:5c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38; Mon, 10 Oct
 2022 07:20:02 +0000
Received: from PSAAPC01FT052.eop-APC01.prod.protection.outlook.com
 (2603:1096:803:2a:cafe::47) by PU1PR06CA0020.outlook.office365.com
 (2603:1096:803:2a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 07:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 145.14.71.66)
 smtp.mailfrom=zeekrlife.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=zeekrlife.com;
Received-SPF: Pass (protection.outlook.com: domain of zeekrlife.com designates
 145.14.71.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=145.14.71.66; helo=CN-BJI-EXP64.Geely.Auto; pr=C
Received: from CN-BJI-EXP64.Geely.Auto (145.14.71.66) by
 PSAAPC01FT052.mail.protection.outlook.com (10.13.38.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 07:20:01 +0000
Received: from Zbook.localdomain (10.186.26.31) by CN-BJI-EXP64.Geely.Auto
 (10.186.65.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 10 Oct
 2022 15:19:57 +0800
From:   Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Yuwei.Guan@zeekrlife.com>
Subject: [PATCH] blk-mq: initialize csd/fifo_time before use
Date:   Mon, 10 Oct 2022 15:19:16 +0800
Message-ID: <20221010071916.1075-1-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.186.26.31]
X-ClientProxiedBy: CN-BJI-EXP57.Geely.Auto (10.186.65.69) To
 CN-BJI-EXP64.Geely.Auto (10.186.65.77)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAAPC01FT052:EE_|KL1PR02MB4834:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ee6d2e-d9e5-42ec-c34b-08daaa8fd8ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/CFsPMaa2OBNIApjR0P+aWuBF64Bhuc2v3kKvwn5SCXJDym3aEEkJ5E688PTD6Oodwmsx6ivlcnUvwiJIBZfoKWJb1PrCh8UtxJftOttPOlvx1nHMEfeUk5v9IsrCBUkOxHSYfkKqkYwFbIeDhq5wjSwAmI+qF4lkfS3i6jEvIGuBFmZC+tdl4PzD1R/x98svAKSlsKYHy06ycqZOLhCwsxo+LwhlelFYg5xSzytY9NCav47WhscRYB5P81v9gb1Uqj23tzA4m9V09eo9aepBdynL0eb8BCgtOTT6tWPFpXc04pNG0mYnF48+vGP922jy+W+o3EK6z6epEkRn823E5GMXR4OlXjKYz8RpC+X60mgev4MHAf0PescX08JAHkX03dhpmbKsGVDCAN6pTrr8c1jBHZLIrQKhWfAUMaqyDt7wY89dIAbssXFXzhK57SeqZhuqQfeW9v4n4lFdMsJX6NvyJgwoLcryncT1bVidHgzatQ8gqNPEzLVaAyWRVgzddN6mFpI9OglhyUJpjs71ecoWzi4OqivqhCDLn0N0Pdv3y9KLABaWx+Ep35IRAQfvgrqekMJvtaamcPb1vWdX0CXys2ZykdscJ6yxIl18UTRDhElfI2yHTpHwRriZ+M6c0/j8MhS3vM5T5wiwJ905bYokElf3JwExgSl2ZZNU+wrrfJDYDBdQwjwV32PJCqfkc5LmM53AN8txBDCRe0O1RvvAiD0oQKhXnOIz+6JM+ZY56INqC2Xo8QrDMOHpta88cx4ObQTlnD1QQn65P3SoMUktXGolrIsg034Slbr9I=
X-Forefront-Antispam-Report: CIP:145.14.71.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CN-BJI-EXP64.Geely.Auto;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(5660300002)(8936002)(2906002)(41300700001)(316002)(6916009)(54906003)(86362001)(70586007)(70206006)(336012)(8676002)(107886003)(478600001)(6666004)(4326008)(83380400001)(186003)(356005)(36756003)(82740400003)(40460700003)(82310400005)(36860700001)(16526019)(81166007)(40480700001)(2616005)(47076005)(26005)(1076003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: Zeekrlife.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 07:20:01.0402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ee6d2e-d9e5-42ec-c34b-08daaa8fd8ab
X-MS-Exchange-CrossTenant-Id: 6af81d03-dafe-4d76-a257-3cc43cb0454f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6af81d03-dafe-4d76-a257-3cc43cb0454f;Ip=[145.14.71.66];Helo=[CN-BJI-EXP64.Geely.Auto]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT052.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB4834
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

csd/fifo_time need to be initialized before use again,
otherwise, it will keep the last tag value.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 block/blk-mq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8070b6c10e8d..f55d41f1d150 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -383,6 +383,9 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq=
_alloc_data *data,
        rq->end_io =3D NULL;
        rq->end_io_data =3D NULL;

+       /* initialize csd/fifo_time before use */
+       memset(&rq->csd, 0x0, sizeof(rq->csd));
+
        blk_crypto_rq_set_defaults(rq);
        INIT_LIST_HEAD(&rq->queuelist);
        /* tag was already set */
--
2.34.1

=E5=85=8D=E8=B4=A3=E5=A3=B0=E6=98=8E=EF=BC=9A=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=
=89=80=E5=8C=85=E5=90=AB=E4=BF=A1=E6=81=AF=E5=8F=91=E7=BB=99=E6=8C=87=E5=AE=
=9A=E4=B8=AA=E4=BA=BA=E6=88=96=E6=9C=BA=E6=9E=84=EF=BC=8C=E9=82=AE=E4=BB=B6=
=E5=8F=AF=E8=83=BD=E5=8C=85=E5=90=AB=E4=BF=9D=E5=AF=86=E6=88=96=E4=B8=93=E5=
=B1=9E=E4=BF=A1=E6=81=AF=E3=80=82=E6=9C=AA=E7=BB=8F=E6=8E=A5=E6=94=B6=E8=80=
=85=E8=AE=B8=E5=8F=AF=EF=BC=8C=E4=B8=8D=E5=BE=97=E9=98=85=E8=AF=BB=E3=80=81=
=E8=BD=AC=E5=8F=91=E6=88=96=E4=BC=A0=E6=92=AD=E9=82=AE=E4=BB=B6=E5=86=85=E5=
=AE=B9=EF=BC=8C=E6=88=96=E6=A0=B9=E6=8D=AE=E9=82=AE=E4=BB=B6=E5=86=85=E5=AE=
=B9=E9=87=87=E5=8F=96=E4=BB=BB=E4=BD=95=E7=9B=B8=E5=85=B3=E8=A1=8C=E5=8A=A8=
=E3=80=82=E5=A6=82=E6=9E=9C=E9=94=99=E8=AF=AF=E5=9C=B0=E6=94=B6=E5=88=B0=E4=
=BA=86=E6=AD=A4=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E4=B8=8E=E6=94=B6=E4=BB=
=B6=E4=BA=BA=E8=81=94=E7=B3=BB=E5=B9=B6=E8=87=AA=E8=A1=8C=E5=88=A0=E9=99=A4=
=E9=82=AE=E4=BB=B6=E5=86=85=E5=AE=B9=E3=80=82

Disclaimer=EF=BC=9AThe information transmitted is intended only for the per=
son or entity to which it is addressed and may contain confidential and/or =
privileged material. Any review, retransmission, dissemination or other use=
 of, or taking of any action in reliance upon, this information by persons =
or entities other than the intended recipient is prohibited. If you receive=
d this in error , please contact the sender and delete the material from an=
y computer .
