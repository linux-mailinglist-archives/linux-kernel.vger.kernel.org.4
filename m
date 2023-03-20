Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D8E6C2085
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCTS4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjCTS4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:56:07 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F6348E26
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6Z+AS580tduVU+s7Pz2zdIxCh0yLU9IKceeVEgQmj+OOqLGjQlLClQcYBYOzeTFDKVWbm9N8hWUbVruglJIMa+yDFgQkrn7IP2fb4PEgoa1tyjozsQSOXwS/lYRoKJZoLbQ3U6bN9toNtvH1EvDjh6nKcxuxCGvZoBhZUl2weDx677rYFbd81Kpom6c2VUOnhOzugJtwjKjV1fbUBYfbAl8iWdE4HxudnLuF+V5KI1sMxXuDaaRIxIGx8Oo23RmwnJ+oE95Uxm8fMJbnRm6x0m7l/7fjgU0PqKXPxRlCc4VFQ0Tzs2lPZjia3n/KTTrnp9OLF3S7Ree5eD08U8PNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeQHK9btMEEetoQ258/+zZi9o7P0QMgrRsf6CanIx3o=;
 b=EPACSjCOFOL5xBeIgFgngTiAwYmMLJm9tygg+0I1dOB1HfwcfasLPh/dAl6IZjXQOF6xJ728I+Hh1GHp+ArKRcte8MMsnQvMzWHu8X2BnNvZAnbTnklzoPB9nAD/MOpMT2pw6u7Bl2TEU+ydw8+U8uLUz5xlv+G0YR8Eh+xRKJ3IiPLsTCpTyfjgdO6gJOPHAPJ972e29QJbRz6rQmGnhqm+31xUwjKZDn2MPgAQ6dk7dyzvjkzj9Rdd/G9cCiYTlB+KpZKHRwUj0NhuisuYpc0Od6HlITNDF0JK8SvSrnnf2UO7n4io3103SZy+fNyPxKHBjTxnYFPMe/UqkGvxzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeQHK9btMEEetoQ258/+zZi9o7P0QMgrRsf6CanIx3o=;
 b=Wnb6UMn6TCexnHhME+uI/lYxvyVmA/5fwacEpKBYDxSXO9J8qW068JcraRmfVVEbGS1MRIm7J/ZYQ1A4EvJZ4UwBYLvunbeoSxUxt4sdn9AUM3DJK57Hx7DcT6235DavZC+YNZBBMk03CHSDt/gHvARA0U3j5UR4+oFO/Zi7KEKdua7l1/nGx96FzP+DBeelptoJTnSryCE9PZSxlEY+OqbYGceto0ITNdnrFnW7irPjL71sOV4+stdH8+icuo3P0nRuF2roHGUxFZtKi9EGGg/eVjeI6UoEL5tpoNveIrlQL9PUmzwEKCoos156uMdLBZvX41fBGyXlCahNAsXDdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4121.apcprd06.prod.outlook.com (2603:1096:4:fe::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Mon, 20 Mar 2023 18:47:53 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 18:47:53 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND,PATCH v2 05/10] ubifs: convert to kobject_del_and_put()
Date:   Tue, 21 Mar 2023 02:47:24 +0800
Message-Id: <20230320184730.56475-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230320184730.56475-1-frank.li@vivo.com>
References: <20230320184730.56475-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: f5395184-4d3a-4e82-7bc9-08db29739ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEhAaMGAaAif0F97SU3O1y+2NzLM9BCf4iim6AjQ5jIIAkaxLJqfhfXywgDLzl4tWVCTP7iL5Cnq1jlNtyCVFxW2ONNqHh/lmzJ9wRxw+D/iqw++yvk3E3QQ1tY7oorx4E6h9QnORwoGPZbpSmxabvPAO1pyVx203hHR439tNmZw/cjLfcrbsZLBVeFy0eQmpXl/eUy8Ixtc2zDs8b2Fic6u3+Lpbqk2vTd6ua9OonNrVN4w2zzoJ61ncmOloei0LhF7lTJr4o73khbhbNw5A/PwJgo1lJXYYD4sQDHva2sAan1agj0Epa/XIOqhyEZusqrYGno6joCQhW128kh92kV5++ePG5gVNvUuxXcMB2vmD9EX23AgIzPyr5RUXPRc1VYh61GYzgj2pmwaYHFwTXD/07YFhsP+q+tqrctqJDFXQ48jRX5o880MYfJRWCZbkgmqDU5xBiek4nYTacYsR/5bN1F1EUzf9FxERZx1cJYXawgOI+vtjAdC91l+1Zi6PyC2shQvt6dRqvPoSfZjIj8hZyukmXRsjRdEEvKeVuh4D3YEgBelw1vKlk2JX5ifK+EkfM66nQkp1Ea+IUk3EFj7Z7XTsh/lFvpirzPbWwEJ0A9MJ7anj7QjDEukj0+78PTMNLfcZKptuErFWhZTLvU0LhQShOs7CQ6JB6i/Z2NlNj14OPr9ZTcaNlld04kFsrooCCNl3Dqlps9POVCfuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(86362001)(36756003)(52116002)(316002)(4326008)(83380400001)(6916009)(66946007)(478600001)(66556008)(54906003)(8676002)(186003)(66476007)(6486002)(26005)(6506007)(6512007)(2616005)(6666004)(1076003)(38350700002)(38100700002)(5660300002)(4744005)(8936002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AC2xu3N/VOXcy8p+4XNxyF6Lqo+ZPk1DfwZB6OAHCcBYJWQ781ZB4EYnHGfk?=
 =?us-ascii?Q?yUt2y62bNSC5vMR4uHkVUtzmymS81vHlufYPp3sUKkQvRQBudgWAemnFmrBI?=
 =?us-ascii?Q?EVNzuG5tMtD3LwaqzCk5S/0xuWiIGLyQDD7DCqFACI6jnnCdF+23JjvbI8yq?=
 =?us-ascii?Q?P1OUtc+MGpO2IRYXS+kPSDGXIcY70p3tOFcP5QreRL5Rx1vDHSceFVh827Fj?=
 =?us-ascii?Q?cS8128nuxo5I6J8FWlmrqiqIIIiHxJfxnHICniIw5XHfZAz38SwDmRYRQ9wh?=
 =?us-ascii?Q?QJsDIqlVA7QZF98MlykKdnrK93jb2J8n1jTi9ze8Txpp76ZOgytWRvzwR/em?=
 =?us-ascii?Q?+PkpkKJ7OMUpp0qe+yXH1eoQb9dOduRtExR6rGfGCMxxExEigg1whMJ3tON6?=
 =?us-ascii?Q?8+LPWMH1lGmxwUMEiRYn/4BQxylzU/+K1TtD1lgHuToW3pUPf+FGaP6Rr/3e?=
 =?us-ascii?Q?EpGu53poHklgR/rDWB2y7kPn2zqZ1Qd0sifVhWFwhD25JIcdPK1cDlKWlRe6?=
 =?us-ascii?Q?1oTG7kIDO8w9TZF3v8dYe7+ZIpGb2tkYkGN0oDuZuRUsOpzmQ9w/4hNCGCE4?=
 =?us-ascii?Q?ocLM3YSUWjyJrZaSWvQate+g+zXsM0iD1rZnqj/MTqPJW2u2DhfNdR9hZ1iK?=
 =?us-ascii?Q?iJfx7Ku1QZvR4K19hgJenarDeOaKIPWYg2MZeL3vcCeaeTyCoxVti8wG9gJN?=
 =?us-ascii?Q?89Tc2A0tG3Bymn5Pba+3HC+LRaYDIbasmWfRB0qIkmw1LfI3R4cxaez8Vd1L?=
 =?us-ascii?Q?TzosluMJQqDMSOPOk10wvODco6m70R9MJ5NvUcfPU2eGU9X5O0bol/U+pBlM?=
 =?us-ascii?Q?lmeih31Tu7bsxKgZci7FBHsg8EqbF0q5mGLzaz6a7h/4+4yh3xW50s13+YrY?=
 =?us-ascii?Q?syvxRkX93CmLUX7t7CDrd16y9CNZJ6+MY45EJEX/o/FXfpwLdNpX7y4e/W24?=
 =?us-ascii?Q?rUKI6hhqjP8O09tbtugaUAV5m7SVa9cYFtn7r4Fn7ojb5gqX3Fh6qlACTaUJ?=
 =?us-ascii?Q?TZG8CrFv+0max9uxgka2t3cf3FMyxY9ZJmnt3/Mm4KxlzN6eVafrstY6Xrpc?=
 =?us-ascii?Q?1r7yr31Ga/4MED1yT8+uYbG2JoSd5ED65mMN+Va+qp9KuwebtzDyiBryZsNj?=
 =?us-ascii?Q?WSSv+d72p0MiqyKuRB3+9OYoLlivrvfSmLnmFq91GaqYyUXnb15rjiF75Mqz?=
 =?us-ascii?Q?KfQRNEstVWsay3Ubk4Xa8yv7F/Ru7esWDrTBHDU74gpcoUTdmwJzhx1xfeXB?=
 =?us-ascii?Q?lpbRK1MNWlx649Q2A40VkA+FzoyfU8lcj9AvU1n3n6p9GAfv8ZZGTehcQZbf?=
 =?us-ascii?Q?/d9CPVAhbAhan3AOxF7FiSCJagC/Z7R0GdZHo1AUO93cDjeyQJAbdb/ChraN?=
 =?us-ascii?Q?XB/A2Fgo949rvZF+o6qNzIXEwxohmY8rNOS5UvhYAR124W4y/Yo5Xn95wRj8?=
 =?us-ascii?Q?4E3zHBxkhR6yhtelFocvRKDTqY2Kn2A8NCT8kIeISb8fEVSU9RbPpKmiriaX?=
 =?us-ascii?Q?p3KUnvZj7xB5cHQRtX16lxyr4H/l87fohGDZyjgXQRMBXiFCxHZ2QiQTyfNc?=
 =?us-ascii?Q?aShrTEVUgg4UDH3DS9YVs/hIYunv80nYURkwC/XZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5395184-4d3a-4e82-7bc9-08db29739ce1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:47:53.4931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFErF+C6gPc+D8IqTKY+FjP8PxUra1jpkxHJLXXpiMvl9AUeoIlJ6nXqzldvsyg7P/T/Nva/VVe9d6G4Qkw8nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobject_del_and_put() to simplify code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/ubifs/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
index 1c958148bb87..9571718e61a9 100644
--- a/fs/ubifs/sysfs.c
+++ b/fs/ubifs/sysfs.c
@@ -130,8 +130,7 @@ int ubifs_sysfs_register(struct ubifs_info *c)
 
 void ubifs_sysfs_unregister(struct ubifs_info *c)
 {
-	kobject_del(&c->kobj);
-	kobject_put(&c->kobj);
+	kobject_del_and_put(&c->kobj);
 	wait_for_completion(&c->kobj_unregister);
 
 	kfree(c->stats);
-- 
2.35.1

