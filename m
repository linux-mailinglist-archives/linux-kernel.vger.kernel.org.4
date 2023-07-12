Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219E874FF3C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjGLG36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjGLG3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:29:36 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2106.outbound.protection.outlook.com [40.107.117.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099CF19B6;
        Tue, 11 Jul 2023 23:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwwTEQIwDjTE0UThI+J9XqaFXX/Uf7C3OXInMbAMNQDj7JbDSGfIJsJXQr3Esj6IB8smKvcQc8yPe6Qb5ZpPTd9XTiymSPFnHxoN8mQ4Ro1GDBr3vfBwv488/jo5YzbUeYpMZpTIzVy3U7csWzmDI59mYI4DxqFH4H6ebyMh/Je04yGjMCRuvfNff935pDuJtUgDdwrFdEajtDiJqhiaSrOEmeFnFZImnpIB6KXBA6gShe1Dn09Uh1w0Lkfy7LvUUF8zcXAXH9gRK0uIz1A4Nc/rnWEHXEh2lzHU5pBlO62aTe8zIEj3ddW4Bg6CgsKuOAsm7HbygAqf7VwWf3Yi3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U9RbbpvPbDlne/ItwXTOSs0VMG50R1PH1ftJ2Kkx7E=;
 b=eOZ3r9SBDSKbzDq4lcb30a7tAiodz8sgpLZZ+ArYIT5vZxh+e8K0l/CRMN0DhM6iH4SlcPqcskNqddZ0kGNFlZWzmxvY/JIzN0esdtcppYz1gFCiGiZp8YQBo+yJIN26AWkHegOcGmgBJmVQq3pCVk5CS1k2aU1mNZAkGRGhpEoJALkofeD0fN5pLt0A2oCZVyljKjgQ3RvhapIno58AQuPu7pKDJyvaqdFhNUA9CUL63etBbdMzEHtPvqbMfzdTNyo2fLhAHyiBnmF20KBWmV8J/bJ9ca4TbBt2NqEAsIxd7CRl3TleA/xkfkW8Iz31GcmcxK3xn3w6IB76JS1hRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7U9RbbpvPbDlne/ItwXTOSs0VMG50R1PH1ftJ2Kkx7E=;
 b=Hh/ummKKENrftyPjdCMRNrez+cmZ1k3eamRw+Ga8wskgk57LSU5X4E8i7M5Yb9FIOXp5viOM8WhptsUIgtU1u59a+8A4uAr+CHE2AI4C/hGL4RUkpKj67HlhfMtDUu/PQJyd867qoSG78t6BTuDgB6oEnEMrusrDLR+LitV7LPUSXqDXOrzvEIZfPqFzYl8J4xclO2+W2lKu7Ou5hoXR9AA6uhUe3TMgyZfa0RkgGw+Duw0IEtz7K2SAUSoBYyyXE7mezWuV8y3U8vJ+RJmwnjdvPZYmniZ1DyLPOk+2/NzIg21wQaEAZ2qpTFM1lmmQ0Ya+xVIKhMA6eTMTuYPKjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB3963.apcprd06.prod.outlook.com (2603:1096:4:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 06:29:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 06:29:18 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] serial: omap: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 12 Jul 2023 14:28:44 +0800
Message-Id: <20230712062853.11007-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230712062853.11007-1-frank.li@vivo.com>
References: <20230712062853.11007-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB3963:EE_
X-MS-Office365-Filtering-Correlation-Id: cb208d51-c514-4cce-6087-08db82a1525b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IeIUpMB3fItTt8h6Ui+Xgex7750skcrtVKiGJugHG0UAgldX23ilpfx+okHECdxwTwRNDrpFMWtTF7Syoj/0z2rqizreDyxBrHQebuRPeUHFk1mvvkbniEyR3SmsgEMCx248d37cB2VlvD1ZO7Gt+zNevMmnF8Dp4ZQGPm4VeP7JRpI1EUltA0wVc0g/gEnBtZRnUC9OfC8Dhw9KDHzfUoSyy6s7o/7rv3JyF4qb3qRB+2PShDOoj+2ULWhTr2BnTPPgXUMyOEckGXY8PcCQ/SfUmsB62UarGEQ8Px4hZpdHi5G0ohZvcUUYLiu9gjqPmQ2Clx+8fV3R8+m1x3vnJ1EznAkCC7+SZecqgT2CigjmVp/MTOqXb3URQuVdA1NkuHN4NZwQ9zoZiEehXm5LWsSie6Mq7+CzpXC2M9QXHcQ7Iep6jD1kPC4Hu4B/R+rQgNOudxEqX6iPIKEnPACBfG43X10037xoeKjfXM0tBtUNqokdVKTfVrsyW8bjizypgvRowFxj1HUWC1KZpF1Hj+HZspPfbwfIkxxyF0PfdgvWvxGltyzP4Gy+tA6dw+jaKgm7n3fAS3DM9EFtDaDaXRJl2WlkKHlymQBZba9JYM71EqIX1QbPFDNlW+e1Rua/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(41300700001)(316002)(8676002)(8936002)(6512007)(478600001)(110136005)(52116002)(66476007)(66556008)(6486002)(4326008)(66946007)(83380400001)(1076003)(6506007)(6666004)(38100700002)(38350700002)(86362001)(36756003)(2906002)(26005)(5660300002)(2616005)(186003)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iKfrOFYy35G9tWPB83a9FidjB5XvLe/nq6xsZDGyqAwwyQbI/1U1Fo6d55um?=
 =?us-ascii?Q?O/duM5yOB84Waqv9UNnNzSdpYzgldFyEB2G61+Gg5qHZ1wncI09+b0wMBAC7?=
 =?us-ascii?Q?xjoJDrzTCUl0S3yd84tQunatT6T3Gv2MzAnu9dT80qDrQuqAxnNbLzMmIR13?=
 =?us-ascii?Q?mQyyQcyP7iWV3dLHXGDuy68uxixoT/lIScTWJtbSbR8DLKXqlYPffkJMs13Q?=
 =?us-ascii?Q?8OT7TWqdzUdlnKGJA03BuZJ5vEzlj8E5uogZdqMXvAPUmsy6wTQLgeFWXnHJ?=
 =?us-ascii?Q?FqjCy1z54ApDp6Oooifd8gZt3Zvr1KThNgs1+QQXm4AY1o2Y33KfT4K6KUSh?=
 =?us-ascii?Q?aJtOVm3RZkrf3vKDD5KtV0hd3ER8EXkt2w8yl++Yyo1iJcRtiorM6bUmJNLG?=
 =?us-ascii?Q?Z8STA6coc4VHMLu+HPR1VoJo9PKj7jEuJDm+DWxQc+NmS4dTodNjyExx6QKa?=
 =?us-ascii?Q?CDofyofKon33d0LLT06Oihlo1Ga7tXDdTp79KgdyvaEBE6DTWM9UZSldXm36?=
 =?us-ascii?Q?YeNKknimgBzZb+LSCsW4bk4Mfb4u/zULF1wKAjSpM0gmH7lO4eGX+X4G1xvE?=
 =?us-ascii?Q?EyQKP4Zg5dolR5gXe5ziAsCtspMWS2M0itAxRK0H+nSpxsI/sqxuoLrLTU/P?=
 =?us-ascii?Q?iUXLJhQCqVBXWkIxnwbaGpxKftiBeMcLy8OSkB3x5N1G5gdaiZjLGnlu2Y+/?=
 =?us-ascii?Q?cS0LsMHdQg0osY+j4KxagwEsnxb1Fjri5qdBJ4jqPdICnUkVJmqQFQbdEQKB?=
 =?us-ascii?Q?bZcmr3L48ikjYrI1rQJHNwnXOi7dtlQCRZqqhsi3KA4FfCOWB+GwoCYhZO38?=
 =?us-ascii?Q?Z9W73CxrwY58PFsQVlJRFSLQlWlUxS5X+ycB4AueACGTvZ6u0VbWtltQjRVm?=
 =?us-ascii?Q?V/eMV6dYRxAAL/wEhjja4NtLjdHVGbYZUq4541Wz0/cCTXv1Hdd53LwacUp7?=
 =?us-ascii?Q?0huuLMvItR8lzAHxi0VUrjJacPCKcBvtdNHf5XvHu07KiIa1juikiTBgjbVb?=
 =?us-ascii?Q?mNdjYXEsCcY8Vn+F9J2KEHPv9EpS2Kjrb8kLihura08OjJ7Qo8GswpeeoG7u?=
 =?us-ascii?Q?XuZ2KjPtLjv2l3rSqDMLTM3GM5lOjYjZ0I5DJrfByggsQSuSQTi1H75MlQ3C?=
 =?us-ascii?Q?PTVQk93VswA40CuKFSSAwoxFK8H3g+GAhZ2jY4I7c3NYxG4sl/zXKgLae//E?=
 =?us-ascii?Q?w9+xhD7RZ9QCasDRYDKMGUivC1s+zi1hL6TlplMgVUJX5HGMIXDWV6e2uI1l?=
 =?us-ascii?Q?7Bl3BYFZHckZfOAkRgbFJTTFOBR3S/sYeY+W8+hb8EbT6TIDAjW9907vw2N2?=
 =?us-ascii?Q?2qhOjvt1g/+9OF20zFwN3HlczLb6dKN692E856k7DDESxU4ywzUEQQQS9YT8?=
 =?us-ascii?Q?ZwiOKIVK5DXOl+ydqCTmO253FYXFrInNGvI+AoGN31qIGQfMHtRA8CDsE+L/?=
 =?us-ascii?Q?RReE2HzB35wCiNvJf5luTbr41BfM/IsjwiicPSL5a1j7w+ZgE83URICTB+Y0?=
 =?us-ascii?Q?/9wZNkh6HQBLrc0Wznb9NNFbHMBxnK9JBgHsw3dKeKfRWflcKrAffSo32arm?=
 =?us-ascii?Q?xdpwYuK9BxXIw1OZSqEDHMt7B4I7jkv2fYOLPINO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb208d51-c514-4cce-6087-08db82a1525b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:29:18.8292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zfaidbTAH3xEh6yecW+CjXwzq6WfCTPG2w2j+74bx1m/1cebqlcIPqZbxU01l7okYr2CsAzrT3GdhwWG0T0qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3963
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/tty/serial/omap-serial.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 82d35dbbfa6c..180428f45ce3 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1573,8 +1573,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 	if (!up)
 		return -ENOMEM;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, mem);
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.39.0

