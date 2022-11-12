Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FCB6266B4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiKLDvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbiKLDvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:51:21 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2045.outbound.protection.outlook.com [40.107.255.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC27E2CE12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 19:51:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daTb9WZkW/WaV8IXipDgudTDltNtwovnrsxPqW2dPSAAkV8sKBU4KT73cbNHF0az7UiRe+A6WV8Dwqp26oC9KtJR7zdGwp4jlsRoOxzp/IsRC2wnW/WIGmqZ2eA/S8jMi6Ug9j5AHZ8uLuNyhjrGsV8uhf0l5YVlU89oL1YsXO55D/2ehuAnVknShYzVZAexo/JcA4QF8tvCcUtySLMVUflEnwOsDDzzSC1HHJXUJ6SiHD82bM5qCqmRpCkdfRDRslBflT8/ol9HNQyOE20B+3ExG2YYy9nOr93YznbnqfMULvaeQf3P2KpQiVzjJbSJ28CvfudPl8JicfHK7ZbWfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlPnZ0GsPT0ZDi79Gw+w+6HUmAqJ9UpTsGT3NO8c9AA=;
 b=b5wa20+fUtCqyM/Tdfg8CxXVwz7ascy5DAwNMWah0Uf+fAJAlF12Zlvx5rJZ/t5HDv2mM9KwY+gdj+3zA1Z2gg4XshyXS+qjYI06fZin7dlzEetii46cWsLVDDM73YC18PyAWbJ4uSsMmL5Z1pHRttmu0okCCzsDRVHtbIg2aMVti7xFNchmLP8CPHLp8G4KXJfazFjJGbDhGdSrZUBo1BDErFDlpcxHSUCas27e6SJaEdrCj5kzJvPRTaMlyCYrXzoCN0XOmUhqH1jD2wXv1enJXYrrcN9ixPjo3kmnz5pxi9wkG1QHz9xMTCM5sqw3IDXoXBWtlKMYDzRvZOMJrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlPnZ0GsPT0ZDi79Gw+w+6HUmAqJ9UpTsGT3NO8c9AA=;
 b=YI1cauPLJ03c7AdqS51YG6tjRvjIDT5DPpCCkbtHyZLaJygElf5bHEXGT8UvycnwEs2O3yEHMMjKuyzmVrfPC/Ft4IvbIaNeSLV7qwvMaoqmuGwJm/zOGrLKnnS2pXsXLH77ljQBoDr7aywiaR91Yoaj5tbBa0TiGP6Nr/TfjjJfR09h9EbEAAzDT+Qgo8pU1jPOkWdtmIig7oXFRmMBbNrJlyKY18S6D/R1JBg71K86A2TgIo2rRBwkn3sqqm3E7R9QeIHPvrixU5WiBj0/nlpbboNnonVPnYX/St4zCkrZkXPGNiJalt3dZnPxgWaxO/Sikh1sGh40kRbhn8t8JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by KL1PR0601MB4049.apcprd06.prod.outlook.com (2603:1096:820:22::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15; Sat, 12 Nov
 2022 03:51:16 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::3fde:75ae:e50a:7b24]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::3fde:75ae:e50a:7b24%7]) with mapi id 15.20.5813.014; Sat, 12 Nov 2022
 03:51:14 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH v2] genirq: Remove unused parameter force of irq_set_affinity_deactivated()
Date:   Sat, 12 Nov 2022 11:50:54 +0800
Message-Id: <20221112035054.2028-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To TY2PR06MB3424.apcprd06.prod.outlook.com
 (2603:1096:404:104::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3424:EE_|KL1PR0601MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: 163fb42a-6a8b-4723-360e-08dac4612566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHKJcUSLP81EBO/vHAtgYgmha43qTddHjgB9Qz9i4ahqWkFJS0jmyXJMGyxDvz2H4VJs8D25oiOdHVNHl8iYNXeAYHcWqJH+muzyXcNrV7yoR71zH7G+IRrR2eEQhdxWt3uj51Q0lQRwU7OndVhVmyt99xTflNWCG13FNUEPJvng5+Cyc3Hv6Xc6FI8uaV1OfopgCCJ6yEqnwVZjM6gJIjXESyuVjH7Q7eInUOCyDl/ll6qRvo1EC7lMS32Aiabv7tCj4mLgmAkOecOqa8ZFsppxHUMfxuAuR3qsIsVzqIiYa+CP+wws7QCIKTgOmK+rbGIoNKMGaKTKTpOCLwamXtqCRDWpPKhFCyF4ZCSCVXf09zTZEOh2NTkG++7c9v7CRVLwKi3ck6S9xZhfex8hKfjLMnSKnCGdat1cZwgESHEWxL6a+l9YDz4n+EXoGQTHFhrszxP1XtUwIwYXfeqwKyZ6lkbUfzglD1KeKTlwbpjGmckZJuOho/m+7jCytUKN1sedlyInCQwoTkdD4ud3EPWeJoPdQV/zXJ4X82NiteMdRQOFkkyDKM6vDtZlNCajWvtRlOlMtXpi6WP3jwXLhcP8e5vRu0ZuahLrbwHKjRS4hfMsut5/XFWDZnKrcvABRaxipF0/mm5fYLLc15jo0NOkE9muvKOUhC9ZxAVZgDBT4dLi+8jtlpEgEzOSLrqGYiqySA2+ExpSF8LyfElloEfemkGRBC0R6N77smfYR65jdmGJkDg5Bc4+cH+erFwlxXkqJ0fHob3OagRgSykHKNW6H8Kqlh33ofPXfNFdE3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(39840400004)(136003)(451199015)(107886003)(6666004)(8936002)(5660300002)(41300700001)(44832011)(36756003)(2906002)(4326008)(478600001)(966005)(66476007)(66556008)(66946007)(8676002)(6486002)(6916009)(316002)(83380400001)(38100700002)(52116002)(38350700002)(86362001)(6512007)(26005)(6506007)(186003)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2YuT47ZbW4Aa8QI1ini27l4LIRm/vZH4/AOl0g/jmSym5aQ5I/LemEdzHJnL?=
 =?us-ascii?Q?RdNJGJqQ/ltNcDZh03211fJphQCYYdmAwC9TGihoo0Yc303Eqf0/0eOcxTyo?=
 =?us-ascii?Q?ccvXzNI8H3Bfnn8eDElkqUWlsEHnwlzrXzl2r2f6eb/x0eJmOkWpBR+i98TT?=
 =?us-ascii?Q?6rbRW0WGDMEZF0+rcxZNk7cLINu5QpnPzNGGRl4R+V7JIo43p9Hgh7AJJYHx?=
 =?us-ascii?Q?WITyJSLAM18GkhCvm93E4bYVV3b1xyPr3cHnIrC9KwnWsxXRx4oPNeIJ7DPN?=
 =?us-ascii?Q?UtL7kt7trmjRZVyDNREReFJvJ5ifoG1r3TQceEyh4sYLPQl6ZBJMwX0p9+Iz?=
 =?us-ascii?Q?cpQv/2h1B5RJc69VeDkiXhJ/Pm9K4ijeXbYMeV2EDTzYsm+7kgR0IoiaGMEJ?=
 =?us-ascii?Q?9Yh6hDb8K0Wx75m5BKMhVFOzy81vUQHo2D6dA4tVsKlnKXadX0r7PhRBu1+Y?=
 =?us-ascii?Q?hW/QTfTRuuwc74Fzvtlu6B+xNKmpAl8Fc9qvyJAiBclh6XwoKQau4Ej1sMeG?=
 =?us-ascii?Q?FCtpoR/EQGqdwtknuj0hNSpU41x+n0FKnfT1L1TfvjOM4F13gZIVNZ82/yoy?=
 =?us-ascii?Q?6AUWESJEYKqQEY+Jh4tqET0JrxTxhLAdaj1sBzdxuTmJ5AcqggiCuCoyfbaY?=
 =?us-ascii?Q?q1aPxVtWKth0+LGwGD17dIKqwrCeAsturwISHIZYKUdYtwn3gkGBxcqgiAhx?=
 =?us-ascii?Q?+L1V0WVJsDJUz/UVUU6Y91qWl8Dv2Gj4QWXibfHPZUsgM8TdAhnCKhOQuOMr?=
 =?us-ascii?Q?LZs6NvS08uArqWp8skPemigUPJQCISMydUBZb1u1tKg/D8SiRP+vk55wBThl?=
 =?us-ascii?Q?cLcGnnbn09rfESArCGL2Pjxqu193iUkD89FWrMOqtXagByTubuqeMMSmU9wK?=
 =?us-ascii?Q?GpxYTgSFvLjcobaNPpbfqGwIepvgKtWLP3iRwqixfWNlBiN79rt3EsxlArsa?=
 =?us-ascii?Q?wq0HxCN+YaAkJSFLASKCsFKmO9nJZSs6c7lryAp/Fm+4Tz7kUBlNlKaNuKch?=
 =?us-ascii?Q?2u526jOLORyZuaAW8VxA/lUWxJKjO2esoOjoAsOnJda/Ny6MpnS6uWDfNAEz?=
 =?us-ascii?Q?a/KASx9Owz0rErhz/cZqyVlgoFoLn6xUT067Y0zUwQSLrowzyfMwYZX7V8rj?=
 =?us-ascii?Q?do5bQBYS3ZEHwDH7Og9V3SV9ifvq0PbBDa1IKxbZLm7+FJHp5wCCSAIg1cT2?=
 =?us-ascii?Q?REK3Zz6y/eTyHucAYd5+OycCUvG6a1D8jPDFAEfymIx2x+OsdKKsz8tFnGsv?=
 =?us-ascii?Q?eKBtE8vUf+84kMHR3stHorISqqcQawyx3CcPSE9agqUqzVgD8psFXy1jVEJ6?=
 =?us-ascii?Q?ljqqmeUJDo620GvbJNMbJJTUiS3szHw3VnKsTl2GSBN5W3B7aDg5Jx8/owqF?=
 =?us-ascii?Q?qYc79/dywbttCLIbIl+xcBWNOIMmei5Vkq1sKZpwri/CLMhsbwz44CET4b5S?=
 =?us-ascii?Q?MsQ3CkRur5pE6KSpxjIDWL//ZoseFdLN5mkyJdvB8iukqTc/Urg6rgeVJESD?=
 =?us-ascii?Q?N+4ujR8a7CkzGti6SR0MXikJnxlJnikEznzXrHPNyBL2lLLWOdC9ecnO2tKc?=
 =?us-ascii?Q?L5aihfPTn7Nkq30YAGvJLj7jpF6C8U+C//Hmnq4nGo9DpLTtrv9Hi9v4yoFK?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 163fb42a-6a8b-4723-360e-08dac4612566
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2022 03:51:14.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zohcIl8hliRyVU+KVR2D7Pyaih/0meZZjIPoKs7KnWj+Qluk/GN78YVKQv8KjjRTXB+GfkHRn7W6QOECpUZ3E9qQ5sxldBd9CcUFpmBAqA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The force parameter in irq_set_affinity_deactivated() is not used,
get rid of it.

No functional change intended.

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
---
v2:
    Del "Fixes: baedb87d1b53" of v1 git information because it is just a cleanup,
    suggested by tglx.
v1: https://lore.kernel.org/all/87cz9tcqg5.ffs@tglx/

 kernel/irq/manage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 40fe7806cc8c..5b7cf28df290 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -321,7 +321,7 @@ static int irq_try_set_affinity(struct irq_data *data,
 }
 
 static bool irq_set_affinity_deactivated(struct irq_data *data,
-					 const struct cpumask *mask, bool force)
+					 const struct cpumask *mask)
 {
 	struct irq_desc *desc = irq_data_to_desc(data);
 
@@ -354,7 +354,7 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
 
-	if (irq_set_affinity_deactivated(data, mask, force))
+	if (irq_set_affinity_deactivated(data, mask))
 		return 0;
 
 	if (irq_can_move_pcntxt(data) && !irqd_is_setaffinity_pending(data)) {
-- 
2.25.1

