Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02CD64E677
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 04:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiLPDs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 22:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLPDsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 22:48:22 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2098.outbound.protection.outlook.com [40.107.117.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB48646664
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 19:48:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqxateY0FzZrlg0nd6zO1+CfTw466JZVlslrUyWNqb7cR4j9Q5tTi6xtT4AbdoL1gCsFw03Pn/5WsXkZF6q/ea+0I+W2BA8ktbVDmzqvV7Gjg+B3p5XeHuPJqlPooIGGZ0MGI1QxwuLViSIsXIcMKm309nVew7FN/puvXcCuHBqUgnPOFuq4xIXxC/3J06JEFfS4OH+fE3A2f2znZxZt9oGZX0yjV2gz6q6fJSYi8S91YIvf4LAe72MOpoMfy+t25pXZmwR7re88LC2U8LhoIIXvfZjZeQt3rRMiibSKNAeMUYVvrtQiR7QD+gu2oljqUwqjtMXf6RhlYxO3MgLH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07xIwyomg0crIck0R0MlHXyNC6CsCyUV6ff9zKM24Wk=;
 b=Co60kp9DDAq64nU6oIhi6YNoRPxg0YIUHW1GLG3UTXMVqkTrKuSKclszaJCwmsGmgNAow/Oj5fsTxE7GBO99QZel3evRYVhZy6d797/L0Zk1m/CFSoGGjnG+vIepcKyFptXu3IpMC4x0bHg5+aVw/fYfXMGAlzB9+rLgYPaRzKdr9kdYtNnHLA7FUqTeriaRwHdiBwT6euouPeaGBcj4LzaJSe/IT1wG7WiuLI4gy7SxNMBHu1vEk5Pn+Wm+9Z4Gqx72B5u3HjoVaJ/sXL+23uoTylE5huFacly+Uwg6nqH2NDCgJNcfZslX/8w4AeclHTOuLFIHJmW8GXn9bYgvfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07xIwyomg0crIck0R0MlHXyNC6CsCyUV6ff9zKM24Wk=;
 b=M4GASpWnyDXV1a4hb8oNq0P07zebVhobSdFcD3a9fm5GQKD2NPEY5bo0PyuL13nd0ma6c2w5FQJas4qQ1xg/t/TR4GnVygqlUGnW/W1Vg0ugKKlLWhaDMLmXpxgZm1qBUGJQlGCTzVLaAKGXIHZLGB7wZdEUAgsYDnI4JO9fStcZx8Tr7P6MrM2YbVsaR2tQp2qyHVwZAIgxlh4sNvYhGaclYx0W+DVTV0C+5xxaiQb7Jd7SImXFstIT1XBugW2qdkHkPHQzcVHYQidtEUUR/SF1LlIBBYMY+ztqpYSx0dV4B/TH7/ecxX+0K4jMA/lyAEh+iFFfkkMy5H+MRWHpFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4283.apcprd06.prod.outlook.com (2603:1096:4:15b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 03:48:18 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 03:48:18 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: merge f2fs_show_injection_info() into time_to_inject()
Date:   Fri, 16 Dec 2022 11:48:11 +0800
Message-Id: <20221216034811.4603-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <dedae282-2d13-cc12-95b8-98cfd377d98c@kernel.org>
References: <dedae282-2d13-cc12-95b8-98cfd377d98c@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f54ac54-3a56-4e1c-0524-08dadf185e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFokE8k8kn05cuBOfyqCBWAFFcOc3aNCRNXYn1pIZQ97faC1HTFq2IozzyX/8SxjBu0EX0bx20BFxH3+u+0PRWdRcizdkmXW9NLmZ5yhMqfbPhI4OmCXJdDZuTJwhBv9io16GtBjniSajgVBtHjOUo9O5BsLZ1OB6Rrmtndqmz/ky7DCOEmdNjZyGHTv0TE6txYrQTv0GM0oJA9gmo1izy4FR3febPMvL0Lelvd3pPjuAOjjxlnzUPOhM8DAzWbNSSqJ72kwhacERPgoTEqMW+vdLv1TVc8AG7/FcaXGXVjJKM/dtxlKBIdHscf3l3bKYMgXqyNdDTiClo0XC7guSIFyeFSclV7OY5lv0vupKTOfDNh2wO/dw4cJbFfFlcASwzJZRzRoqr4OPUZlbOQ3QE4LjK1oPOEuCiI54PLFDXaXh8fQ/XMQtbzbko0/bUoG1TWdKEY7xrehHq8SCTJh7AcG351eOUkyGFL4c/oQruMX443WoxppUlJEeoibGJqJuY2DkLeHLo8IMudbYZYUUyKwVNnR25PYI1iRk6Aq1mts/cuWbDDBy2ImehXzzpiIHGkIS2biiSVis5zfyvGgX5WhL8/daxVcTV+HmHJH1AlEgzkO3tUTVK9V0iL5dLwy0mMS4+ByzI9r0FpR89agEKoiGenS6n7XVZLASJ+r+xDOj7nZrT5FmQCRF05GgWdtl5YE2QOCW3pqVBuxYFf1iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199015)(6666004)(26005)(6486002)(478600001)(6506007)(52116002)(2906002)(186003)(6512007)(86362001)(83380400001)(38350700002)(38100700002)(316002)(66556008)(66476007)(1076003)(66946007)(2616005)(8676002)(4326008)(8936002)(36756003)(41300700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b8SGHTKucZCFGyQptmhTQyt6TSS0E1X69dG6xLQ5mtcGIPxCm+o2l5TD/ZT7?=
 =?us-ascii?Q?TRIPP6rhI0fy5aYEKRhNaxX0AzOzYBcwf3owDlZkXqyC2ZU9t+HpNAFW8MDS?=
 =?us-ascii?Q?DuC6uQmbDjZ1gF51dpLUK8GWldFeuEconiWzel7qwCmGIxbzbYw92eMwu8Va?=
 =?us-ascii?Q?RZFiovxMUhcPUyjvLa/yEmDmJsx1yquYhGN8gKrh5XYeRgjs34KaKJ8j+Zwb?=
 =?us-ascii?Q?FBfO0B7UFHGntlqaePE9sAPh7qPqLGjhbVTk1cPR7/xe2OceoEDzYKCoivKs?=
 =?us-ascii?Q?hWFXAHM7musldCFoaE0euHl97k/mI4LeUeaob77IfEwmDcTUA60QgOGpI5SO?=
 =?us-ascii?Q?YL6lyJVYvp9thQGp37/XQ4G8ks2Xz0irTmtgr1Z4bqXCCE6opcXWuCZkTTt0?=
 =?us-ascii?Q?dOZ5iw5qoeVttpEKHmVtfmOgJcK6zlnjHGB06o9axO9xPtykBymHuAmaNayJ?=
 =?us-ascii?Q?K3kBsXGSWsJIXIZzOTwP93UCIEMIwA9AQv4lNiSwUatwe2Fv7F/atZh6yZIp?=
 =?us-ascii?Q?vTOjeEiqiWq+MfZ/dQmLP1msq6HeRwqoNxEuEY9UtgxQ4yQXi+atVNaUgnT3?=
 =?us-ascii?Q?NxqWKRr1B8GbhA7G4PhAqrT5NsjLbN63+Ln/MIX9wmDY2wZcsoWGc1n0kGcZ?=
 =?us-ascii?Q?n8QXPG+Wu38b/Y2oqASr/h3/dlKAEId+TPvRFA9ULF6adLiMS1NhHHIELWBS?=
 =?us-ascii?Q?m1Q/VWtPpNIuq0NIZUMkhT6lU4JAKzHpd8cJYP4IhO0yXHKF14mslnNnA0pN?=
 =?us-ascii?Q?DriZsNsGCx75hTRmDFedzqtFqEJJZA5cNRHTVhR/vF/mx2JTXZM9efsuCXpF?=
 =?us-ascii?Q?B2uOs7Sljb8MkCjOo4kEs9WrJd7KurLszUPX31TKbQFYWqemGLnIKoxLpA8S?=
 =?us-ascii?Q?GuDIdlOJyrpxtOAsCs7jcxtmyqD5/JwDNbVNlOd4PiBypxPZ1u8ti/8XyZCe?=
 =?us-ascii?Q?SHmNY/X+l81WNjaIaYRn5hRD9ASl99U7ESz9gT04Ax4YbeW0LHOqT9nWeYvB?=
 =?us-ascii?Q?0kZ6C7fk7Lw3sENRrXScgpOAo7R8upNq30oLEVMDtUjr7cO9F8szIpGVCcSI?=
 =?us-ascii?Q?tsbvWTH4uW73AlDPg59Ym1uQ4gBD3IZ7IJ6e0sMSfj/ru+bStfjMzvcwjWOE?=
 =?us-ascii?Q?qo/GvqCybBvTB3UUDW42nin2rYyVORxFPewLmb+gcuR3v48JgRi1ScxqkqD1?=
 =?us-ascii?Q?Sej3ftiRcxILZqIISXaOb+I7ZIaHzFdW3GC+SFo9WySJ+AP764TCLx7v2KfC?=
 =?us-ascii?Q?NnLe+rhNpUu5p3laC4DRSaJ5rtgXzjzIW0skpcaYJSK8SrB3nTsjhT274G7m?=
 =?us-ascii?Q?uIv64iOk5EGPw7Gafqqyh2xvgdHPlcqPbN6FEJm/wvAykcpQ/QPmBJ2pAGAv?=
 =?us-ascii?Q?o6HGQQG3Dn5v97qKcG8z2MguKumcYWkkDrbShCCReJ2zAz2hx0/9mcQjbDmG?=
 =?us-ascii?Q?kMa3kY6VEiWQqvnhv1c4FsAAl+3wrdpce7ZHgCf2rW3494gIz0k6udU6cpfN?=
 =?us-ascii?Q?TN/DywTZ+aa/+yEtDeuPRag8B293syvJQUg31QpR0oCa0+VZrI53EbqR7aMN?=
 =?us-ascii?Q?Bn9U2fIlBYeCieG5eNW24cdl0OF9v/QJ5/YJERD5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f54ac54-3a56-4e1c-0524-08dadf185e6e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 03:48:18.5011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BI4rDmsq912CZZ7HjupRjbEMyELT8M91c5yRBVFtPFWZp9Dsg94ggiSxEACq99j8/vNKMRBALdveDLmxcv5ToQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4283
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> After moving f2fs_show_injection_info() core functionality into time_to_inject(),
> __builtin_return_address(0) result changes from return address of caller of
> f2fs_show_injection_info() to return address of time_to_inject().

I tried the __builtin_return_address(1) parameter just now, and no error
was reported when compiling, but a null pointer problem will be triggered
when the kernel is running.

I thought about it, and the print address didn't seem clear enough.
Let's just print the line number of the caller?

#define time_to_inject(sbi, type) __time_to_inject(sbi, type, __func__, __LINE__)
static inline bool __time_to_inject(struct f2fs_sb_info *sbi, int type,
                                    const char *func_name, unsigned int line)
{
    struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;

    if (!ffi->inject_rate)
        return false;

    if (!IS_FAULT_SET(ffi, type))
        return false;

    atomic_inc(&ffi->inject_ops);
    if (atomic_read(&ffi->inject_ops) >= ffi->inject_rate) {
        atomic_set(&ffi->inject_ops, 0);
        printk_ratelimited("%sF2FS-fs (%s) : inject %s in [%s] %d\n",
            KERN_INFO, sbi->sb->s_id, f2fs_fault_name[type],
            func_name, line);
        return true;
    }
    return false;
}

Thx,
Yangtao
