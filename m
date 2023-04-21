Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743826EADBD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjDUPJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjDUPJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:09:05 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2102.outbound.protection.outlook.com [40.92.98.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7064CD33D;
        Fri, 21 Apr 2023 08:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8Rwh9cjv3+VzYbU/D98IgIteAqRvE8kIxKsoZWKirW+3Bmt5NWxt3eG1X21fVEMllBBwl733YskHBs80nvh2JDRH+81g7YgRQv5vHdyfKqoC739gqM9t4zVaLG55yq0oFrZ3TiCl79D95lruHYktDpfMJnwLDmhaUXPtQ3ed5plElnty3pPsImHsP60G0DpaNRAJhzeTcHqeVlA3P3OnOOave4E1EMhNe88o0rIql1whQWTshTlg2keCbj8G5U7MOAq2FGWUh5o+nimGD8WgJT+0Q/hcMSLqIM2tb5odcoMTaqlvT9sOcUdWEw1iCsp9QoeZxGZ9urvMMyEYZzaxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0stYfa8pWrKABaWqbIB+UYWYTVgeOfu+z3tRwzeieA=;
 b=gjTADHW59lKpbGqM9omZreHWyQ58ltbrr2QYGzBD4fAneDMaoa6j/9E5sySJ9OVWtjs9YLgPnQbXiMsE7Ub1qYRCrUxGJzqQs20pni/qNTNictL/tczfhCQgnJ+XDIOfMHiJXO6Cwk2dyDdutkoc49WLtKf4C1XdvLlOWfBvOZErF//MZS5VmaZRnzp0HK4M2Ep2moDVYQD6waa+roFMOP0k2FlFb88SKiaPh4LySMm3G6+fWOmxTZCXd/pFC2h0QZAv+5HdHihCR+U/2+fXrmcrAGUFSi4aqjkZK+a3Sp1cqWZifCns/PYne5O34dqnOq+XXijidndljteBKgPSoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0stYfa8pWrKABaWqbIB+UYWYTVgeOfu+z3tRwzeieA=;
 b=FjGGbkuYnkIzYsYzga88fGutpqZ2qvWdMUimHrnPCzUJsWW/ZFXwp9jj85xy0aQT8l7OrnyuF8Zb+wKCfFTUI7m+R/9ei4XK+jxTEvFjcPMu0nmwXtOMsD8sVa/ZOtGG/0TctUG7hUrpMyalveAmdaezalauNloh8ukFaPmaFZkgYaGFm478eamjmBKn/oOS8klQcvqXm7kjQ9XnQ7UKOlFiQWf2TdfEk5AfzcWKQKU7ivOjSNK6vYF+5ck+SSf6StaQd4LngNh+PHhXgvne5sQQ38P003dZIinWyXcJtnnMWV4vVw9A5V48CLomsseO+qdPZZCK9JnK1Fg56Icfow==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TY3P286MB3505.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Fri, 21 Apr
 2023 15:09:00 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639%2]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 15:09:00 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andre.przywara@arm.com, conor.dooley@microchip.com,
        Shengyu Qu <wiagn233@outlook.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/3] dt-bindings: mfd: x-powers,axp152: Document the AXP15060 variant
Date:   Fri, 21 Apr 2023 23:08:14 +0800
Message-ID: <TY3P286MB261177CF7AA2959BD9517DA998609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421150816.10513-1-wiagn233@outlook.com>
References: <20230421150816.10513-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [E86eeSOuaUolJc5DwvcotDakMB5SN5sK]
X-ClientProxiedBy: SJ0PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::23) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20230421150816.10513-2-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TY3P286MB3505:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e3c125-47df-44dd-1981-08db427a5625
X-MS-Exchange-SLBlob-MailProps: obhAqMD0nT8wRrMOmTC7gIiazLgnsCtwPWSg96i6vBZA3Z/LzsLlhD0jkyaRL8YuFW7b1ITabVd31bQpc8BcMSm0enZKlQFgjps8mIE9dcc9QBb7A6AuFfagTi/oXWHfLGs/XYdy8KW4AqYEMvH2/QotOKFG/1hG6DSsS7+hrv2xDMRhDN2P7350OVWkEhG2NK3TTa7YsLw5Dpihe24DzDo5lAiN66RVDgh9J2yxtY5tP2nvFWjmD9Vle1oN01lzGP7bmCvVMyeZctFra4sxPzUFacDRY7bKQCttCb608iJv4ymWt8+Ur387tvx+uCAn2n/bWlEmNwh02UW+ciiNkTA7S8rh7zRk2dIHPSWcuEDOGorBDKRJkwKzUTY/fw4reSIwju3gaqX/Bg5EDxmh3BlsVUVQcI1Xsz8+ElVYlFi/ToXsSyKfMgp8YX/+W+RkglUv+/Bx2JmA0DCjHXmQhVbhYZJgRh8gks9qpouExzRVZOta/7utbnc6wwq45XGWZzu+ak9AphcuxbaZMJU3hnoJszNG3aXdQhKydN9NBBFedb/43gMPMcCyWdH+6jqI0ThO7DwLUvJKZLu+jJ5wHp61JVPpkHrvBA72fIJUVUiTW9ti0Xm0G2JMjTz7vNc1vjaIsp3a/d1Fi2DqbkHl8tClN4puoPugOlsqOoV6qOLWh/79d5kuvS8GDK0ZuCEeewnkHmNOiTB/B3juX5hlmWIeMF6UTH35041ns5RO9ymjpZfTnLkL3imEirXDWevAndlG8QEPymZZ4uOFHNglThbyM/T+zmrWx+Hr0KLQlKRZAoFnj7apt5j0IiGtG0bY
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YF/2Sdek8pyN9ob8xvF2iXmxNQBs6NVlGJsQO2h9IYKYVAbcotCeyIIXB6fpmQJLozhjbjrDBEOCMTjSChBJaffYlFRDHJx9sLyCTvsAKXu+ZI6h4GMjfXIk+w70CD6Tt/8rbA5OuxpaunDtFlcxDKJz3RB0LvmYzMCcZ5mQB4NU0eD0b3tQAw1+Ic5TPzSXtH2KsuA5TQzqyi+3aThPaTrlFw+/rNC3iQ+f0QhcGkliGJzKY668YbKE9+AfzWpLBpaRSy/f9k4MHjSV+DPsGqMO1Up1miDClfTsYZkGAGu/0YHxzM5oaWgSV63vVQPfjomDWpsNaChKb5JypQRV3A/FD94PqcP9mdzNq/UIMaGEa6gvmry7BKgNWtIp5lDwGb3lZehiAYNgDHrjMObIn53uvvM0jAjC+eGKvplNivL/aV272NYLzogSuI9tSBvpXiVS7a7Nvrr4CLK0+CsAWACt+2qq6CQeLJU6GABPPoGmoFgWhdTCiB8U846EsXzAMQvSIRmlXf5L2c/Zt5dptXG/9tzn46Ti9Oa1a8uOjMrU5HG/ZNpSAqhIf2nOgCUvoHbVR/Z1j/5wwO1TEPz/+xKbFfvKYmlc8crFu/5ec9Y=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z02WjiFDxMyvaWEoUty52FROugQptFiFi8rmfq0SdyDv6Cj/liIowRpYQyV3?=
 =?us-ascii?Q?yZpdp5qfXilc9GMh1VhhD3NdNmpplDH5l6Pj0Z7PA/SXj/BuIbrD0f6NwpcO?=
 =?us-ascii?Q?ri6zIihZFT7SKreSs3KCJu7WnMvFT8joGeaSdmCR5N3OSUus9qjHktB+hCzB?=
 =?us-ascii?Q?ADHpDLvzBPXLh1Waaamo2hEwiZ9c6J5R0OjKoGqIwv1iDbIcwxWiQJPnU0mF?=
 =?us-ascii?Q?cGSnE5rIll6ACYxgG3fam6HvhMbbrEOqPqSNjnd3nidSPUFXDx2tP6tE97sP?=
 =?us-ascii?Q?eX76IeHOzLxNT7xZh8mKbaZb5KNvqo7NZzWJz1QhHmsOJ50aHNXgL0zZTks+?=
 =?us-ascii?Q?a20VzC6di4xktKjj0Day7bMdBWT3+l8UPWGefPnGmrRFF7rua/aYielZS5Wj?=
 =?us-ascii?Q?0eVInPGOdbY8tW6H31I0zmsCvkxw85zxkSfyJaAdFimCz2bF0O1sqGsOyt0W?=
 =?us-ascii?Q?b/FVcusKGAuTIXMuxhelwbYhCkoxep3TtqOYVZphrtj10wII+9Ggs5SGFJ5P?=
 =?us-ascii?Q?OfGR7F24KKmkEuoDDEFPdvCPskTqHDfI4IQmG8aLjKz0quAFNAlZcn01hmfS?=
 =?us-ascii?Q?9wLfJ96mDHppty79kUU9htlGrA5iitioR8UAOyujwKp2ieqD6n+Phw2lNbEJ?=
 =?us-ascii?Q?nfTzWr2KokuEWJT/ogRPdMiNiZ0wCxLJ0gR1ZvBVnRbDDEaKwJ/MDMKIR4A1?=
 =?us-ascii?Q?ExcAB6Zx1HWalTtZl8evjPY6etocHXdb857CednS9uog+VlJK5YAORj2uDoq?=
 =?us-ascii?Q?EIpe64mJCe6kNaiABGARGIyQJJxnrtpWdgipUbiJqFlsrPkms1Icz091kk6r?=
 =?us-ascii?Q?aMOs8BUClucoVSV/YqocgM9H5ddzGdJM79Qs6ROZC5qGy+23BLE+9Y1XNMba?=
 =?us-ascii?Q?mYcdWvc/860hxf0OGfOaYL73W93GnCSGsFzIXG1zfodcEPCBQ//YWfiLo8Rx?=
 =?us-ascii?Q?UTpWw/O0hI3knMKrlhwfLJds7tbkmwL6TYKoY/s0aH+vOuRh/cINCekyj2fj?=
 =?us-ascii?Q?QFcBMY8OvnQdB9UJWEMrIy6pNa9PDOJl3d6JkfHqcVs/R0ShvsWy3yvHayte?=
 =?us-ascii?Q?oAJw3Fla2InDX8VmVBqZlHw5Maa1WsWz7UF+Tfl0Sf9oHa4Zt4/KDGqm4hEV?=
 =?us-ascii?Q?eyrW9XsUr1kSvya3zv1SyN0EzTP3j54o2Wc7O4DKwnYpxha8Ypczbku8O2Pv?=
 =?us-ascii?Q?kPMQ9hyucMvpMaJNNrfy7hyVCEJwXzB0RE/Q9A=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e3c125-47df-44dd-1981-08db427a5625
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 15:09:00.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3505
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X-Powers AXP15060 is a PMIC seen on Starfive Visionfive 2 board. Add
relative compatible item and CPUSLDO support and disables DC-DC
frequency setting for it.

---
Changes since v2:
 - Rebase to AXP313a series v10 [1] + newest (20230420) -next branch
 - Disables DC-DC frequency setting (Andre Przywara)

Changes since v1:
 - Move cpusldo before drivevbus (Krzysztof Kozlowski)

[1] https://lore.kernel.org/linux-sunxi/20230401001850.4988-1-andre.przywara@arm.com/

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
index 98dc0a1e9da3..f7f0f2c0421a 100644
--- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
+++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
@@ -77,7 +77,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: x-powers,axp313a
+            enum:
+              - x-powers,axp313a
+              - x-powers,axp15060
 
     then:
       properties:
@@ -97,6 +99,7 @@ properties:
           - x-powers,axp806
           - x-powers,axp809
           - x-powers,axp813
+          - x-powers,axp15060
       - items:
           - const: x-powers,axp228
           - const: x-powers,axp221
@@ -265,7 +268,7 @@ properties:
           Defines the work frequency of DC-DC in kHz.
 
     patternProperties:
-      "^(([a-f])?ldo[0-9]|dcdc[0-7a-e]|ldo(_|-)io(0|1)|(dc1)?sw|rtc(_|-)ldo|drivevbus|dc5ldo)$":
+      "^(([a-f])?ldo[0-9]|dcdc[0-7a-e]|ldo(_|-)io(0|1)|(dc1)?sw|rtc(_|-)ldo|cpusldo|drivevbus|dc5ldo)$":
         $ref: /schemas/regulator/regulator.yaml#
         type: object
         unevaluatedProperties: false
-- 
2.40.0

