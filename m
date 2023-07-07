Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B9274B182
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjGGNLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjGGNLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:11:02 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2054.outbound.protection.outlook.com [40.107.13.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831B31BF4;
        Fri,  7 Jul 2023 06:10:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fW6wORowJcT0IhSi93deq1xfzkNwiHVdHlLTPGV5tLVijkN/h2sinGey+Fnd1lzKNCFZBqlwObIGQCBwKAfRpDk1Tbs20Me3MZEWmNY4JlajDjglvBuZmgm6ywUyhMI7x5BDNVa9wn/CmzwIHkYq0XvrQlrB81/pHeI+nNjqTm+nWwJKDnVNtxjK6+20moP0K9urECYuqf6OXiM8UonoX3scWxXv3YES7NhMwoO31oNnNTWfMI+dhZ7n7LGFpDFkxPXEjr4Efohq+hJgtD4KSIubAcltk+vFizieRKyc/qrmdHrMFmSjT6pjWDaWPMntjWJg0BId7O+9+jeVyDO5fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMq0ue+njo+cH4FjOP6FVncY2qbxB+eHwEiIXB5aWJw=;
 b=HTWzjmRvD0FW51XAC9ZJV1WktAuz7ksIRSuCcvMyQQjJJGkhRq+eHChH+JDtJLGPruFprCSiJCFBRvSxsZsPcLHM2VkCPPTxvontL4Bv48GgRfcdUKpyiZDGe3Pk1VbpbrJMSvXMZ9CnmEVVNaIM4tCK9tqF/ICa7Ht13Lces5wJI8uAd34GFwIlvUuanGtc/z1irIhFZyeEMQ/6e4y7E+mM06fr52X7d6WBC7D70UzRE39/HXLZzX2q7x9raoxnuCRApJxzn1nZ8ma2CJT7KMc7fI2LdICppmWe/IDZ3n75bOoEusWQf1bfjXqv0haffjPUTRkOncFoDcx0ZQIP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=topicproducts.com; dmarc=none action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMq0ue+njo+cH4FjOP6FVncY2qbxB+eHwEiIXB5aWJw=;
 b=Ngxm6L4Jlp4+IS/1rFEbf6rme22m4B5ZIAlwsJd1AFxHOuvRci5GtZRriLOn2vIK2tRItzDyd13A1so8VxlukxDtZ2MU3LnLDyHL28UMSb5dz1sa8Tt6Ptml+0DvDaP14eT+E/DWA4M/L1KNDq8dIXDA4vn3JQ/q+3kHdp7z9CREBDt3IGSmbxhO8sPOsL7MzWDfOaft4TBLdpa8/Z2JOC+yqAAjBd/DJjYrQXI8X+8oJHG9WD/WhOHUyqlxndv0QPmC/c0Ly5Hd8fvkdLdhaLXC9uenWjOeeCRAqE6GDyPmJN++wAq+wlypgg7J6j+eFjZwjgT8A7BLx96VwyJZyA==
Received: from BE1P281CA0424.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:83::12)
 by PAXPR04MB8989.eurprd04.prod.outlook.com (2603:10a6:102:20c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Fri, 7 Jul
 2023 13:10:56 +0000
Received: from VE1EUR01FT048.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:b10:83:cafe::13) by BE1P281CA0424.outlook.office365.com
 (2603:10a6:b10:83::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.13 via Frontend
 Transport; Fri, 7 Jul 2023 13:10:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; client-ip=20.93.157.195;
 helo=westeu11-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 VE1EUR01FT048.mail.protection.outlook.com (10.152.3.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.25 via Frontend Transport; Fri, 7 Jul 2023 13:10:55 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.51) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 07 Jul 2023 13:10:54 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by PAXPR04MB8653.eurprd04.prod.outlook.com (2603:10a6:102:21c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Fri, 7 Jul
 2023 13:10:50 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 13:10:50 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-input@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: Input: exc3000 - Support power supply regulators
Date:   Fri, 7 Jul 2023 15:10:41 +0200
Message-ID: <20230707131042.10795-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::19) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|PAXPR04MB8653:EE_|VE1EUR01FT048:EE_|PAXPR04MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 812932af-2173-46d2-967d-08db7eeb993e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: mvn0Qd/lQ7froOZXNC8/ejotkHq4RrN1uU8VpGkwbsF8q2svkpmH6nTL64izNSL7+4vUJeVirlRb9J2FMU8a6mT91pl4ymUue16mOZVh+JRNFD3TpAYSqN5pL7cD0T+reYaqShCYszq2QnRK5I2KxcyjorYZxeWWYW471a5dUPDnG/jDUOr+9kfeoh7/nmJO9y78L0MaLIywubuyvJyxkhBVlgaznZ11SaLnVvDVL3Mhbrq98BtWKhhc7N27EM0SuE+IE1EOE1aAycRrgZMtLTlT9GFSbMPk79bliZogfplput7MXyhDE+oRNADFR0z/00A4kq01z68BFng3OZGJ3liwxT+N3OB86k9CS0/q6ykba7EfCEAQ6xFEX7LX5Fxah2k323S+AY7UOMH8TltCmy+44q+RL+NgnasOKI/+ABwPQWWnZ7xXkWh8sKFxHGIvePHYeZ+E+I1lk3JwuQS+iRPWve78rUi375RRDVOrJxdzs279HbKvxIlUqqTvdQ1VZp/fPJkOMtBsAT20a3UVGB/SYz3oDpUT/MEq4/LRqvVvsrcEjAAoJBT98mXk6BNfjXQ4cLUIUhG1MWCp3F/vYA/0S10q4Obqhhf5VD+ZvGiLF7FACze6Jye2SQgHNEb/
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39840400004)(136003)(366004)(396003)(376002)(451199021)(26005)(478600001)(1076003)(6666004)(6506007)(186003)(6512007)(2616005)(83170400001)(42882007)(54906003)(66556008)(38350700002)(66946007)(4326008)(66476007)(38100700002)(52116002)(316002)(6486002)(5660300002)(8936002)(8676002)(44832011)(4744005)(2906002)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8653
X-CodeTwo-MessageID: 9f0d0063-aa94-4e75-92cd-87f4e87161ff.20230707131054@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.067a6add-28c9-4499-a235-882581bddc85@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT048.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 593e4393-e610-4b18-2a7e-08db7eeb95bc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5wWpUCp5nGhcgBiVdkIkM/zmnSwSvgnrvVjV+IXY/KR9SWhTBK/c6PAg5sXyqTVA5vuc/AL5z/AAPtW7RxE4YfT7XoX2OuwO8K9AbV/vdKNS87j8CpGHbMrGt4iWekhFd3fr6RjTYQnTZLZ0LKPMC0jeFtqlDMQEdg3eoxrk9JyqGk95+yBK04IILzIonkSF2s0NO0cwyiZDBlTZ4hfhzf8s+/xqu0dADNNNJTtY7YsN2gB5vT2CaS7JyuQwFpBn28IV2NGWj+xJ8q6urcSFR1hPr62hEfQmAm7BZ6bJWy9mRl5rn99il9npsKzijBHwv4tx5QDzz6TQb7UdpOqdAjAbAoeixeIdk8ut3sfMVsoAvDU/Qkht6/R1B8BJaf4MxuXq5o0/f5naWPTJk6GCbf5MbxhlqgU6a6ZUvPDXFLhuXzoQ5wXKwnzVTRwQZQkZhu2Hs7V5LCURn90Vj1IUGG9IcYl3xz3un0oP3JYWjEG/wSaJqaOvDkzmjh/0NFPhwERbTvYMiouB/7D1LnCmltaclFUxjWq3YxT/yGR5RKV5W2vRvJjuJ2lFTD15SfdyncNHLW26zjZUh4Qv9XEgwRAdeF6UiGTP7tg2r7+E0RkKjtlYYnSfMdak13UMdERlne9cNbF3BptCqP3CRKJBCtClxzFdn7NWL3IPHeKX7/3MwEU5npmkyP7SgVNapyQ
X-Forefront-Antispam-Report: CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39840400004)(451199021)(36840700001)(46966006)(40480700001)(356005)(70586007)(54906003)(7596003)(7636003)(6486002)(83170400001)(8676002)(8936002)(478600001)(41300700001)(70206006)(316002)(4326008)(6666004)(42882007)(186003)(36860700001)(47076005)(6512007)(336012)(26005)(1076003)(6506007)(2616005)(82310400005)(15974865002)(5660300002)(2906002)(36756003)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 13:10:55.4768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 812932af-2173-46d2-967d-08db7eeb993e
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT048.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8989
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power supply regulator support to the exc3000 devices.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

(no changes since v1)

 .../devicetree/bindings/input/touchscreen/eeti,exc3000.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/eeti,exc30=
00.yaml b/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.=
yaml
index 007adbc89c14..9dc25d30a0a8 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
@@ -24,6 +24,8 @@ properties:
     maxItems: 1
   reset-gpios:
     maxItems: 1
+  vdd-supply:
+    description: Power supply regulator for the chip
   touchscreen-size-x: true
   touchscreen-size-y: true
   touchscreen-inverted-x: true
--=20
2.17.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
