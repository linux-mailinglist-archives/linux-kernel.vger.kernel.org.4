Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F93B74AF7D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 13:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjGGLIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 07:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjGGLIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:08:07 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2128.outbound.protection.outlook.com [40.107.215.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02878F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 04:08:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnXrzSLwkikbZlgqn+TtqpPl38/LSFT+NerAro+uZlKo7IlOt7Lp/X5f3UFaNKm4N3ICZ2Hv3A0Ea4iD//xFNnZRMfv/NRG4kK8dUz9I0s/0TDBURB3BtlVg+UjnTb/RAisKGHigLR82bVloZ8QiW/jxDQJYVo1AgPLA898GZkdJ8YBeHE1W5YotX3ZB+Z/YaFjWV1+lIxnOIisub6oxbBCUVzoNL296NqagpsVfTCVpdTkhhD0n8/uNW/KIc1IM4U342nskb2pEBDHdPlXDND2pPuzMyW3nLFmqFeH1nIItsZNZSb0fOA6dIy7StYt9F30M05qEkNg/BJu22ZXDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9GqBLW9Sa0jDOR13aZ3KXlgxwJSKj4AA3ZBArCWS9I=;
 b=KLXkOvzHXK4cwCPI8m1CpeYKSKteAj2Idk48EiAc4lqCB7LoZ7FiwwJsQPw4pf5ESxgpZZ+ZQZwgi14toZejvWyXl0WrvxqhQ8+JSBYGy+vrF8KNYUzodstC22v3mJMgm/BSosF295qCE90YWCXuIVXLjFql/q8j8fsZM7GACcZuqRY1HIJFSMs6vvCevxji1e5awJTjkZhDNrdnDaVvU4yg+VtybXVUS1wnru/idyzYZJMmjFwq0Z3VI2vA0D/aRrFdxhE5m7IMcdgHJFbGfIGjCK7AJ1QRP2WIWCsz4MIymREsjqE4e2rFmgxtwXImFGjKKnGDmRpeHfzhDN1PDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9GqBLW9Sa0jDOR13aZ3KXlgxwJSKj4AA3ZBArCWS9I=;
 b=BpwgC7lYin7+tVALYNagrc0ndTnrFGvoVhmYorqtMSXcawpnc8PSuYqZXvgzZ4Jx7fmSnGz28HD8sScFrZJHfxlyzwN/2TGCk9shE1cmMBPc0Knz5PWlsmgqTH/gx/rwlIrKTspkBBlEOqYwNoUQWbStPC7OYrmsetHVM55JBdOGxMFpp2Nt3rczMfI0acUQZdpIOM7lF494qDX9D0jzFLbFizuXSBZd7VhMZANSP2CqTu7oz8MCpmujvDI6uXA7HbGUs5C46qvloe2OZYy0IQwYvQZTVPYgNuylgwjpMKhOuKDnPGa2wfibl61GR6MG5z5Ucp7Jn++Jjvouz4vjEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by TYZPR06MB4030.apcprd06.prod.outlook.com (2603:1096:400:24::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 11:08:00 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 11:08:00 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] fs/udf: Change the type of blocksize from 'int' to 'unsigned int' in udf_discard_prealloc
Date:   Fri,  7 Jul 2023 19:07:52 +0800
Message-Id: <20230707110752.13436-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:404:14::20) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|TYZPR06MB4030:EE_
X-MS-Office365-Filtering-Correlation-Id: 2375ebc7-2a5e-4c32-eada-08db7eda6d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efNTb5rOzuOVdVMc+z1yB75OKFG48jVSovtdMo2A+SMS74T2uqTwjgOcaVkKa62qPy4WUutUUwyhPlKt7Las067eFt8AUOZvQ+tPk3x/xWUbNjqnIWZU6WMsvX2uLfzveuWcidJgxEwMoNjunYCcGQgTvdb7Axkbdnmlo2fLnVNWctX7E1z7sAOHX//+rtFNXkfpo3vCPAwJa7LQ3W0uxD9B/FRTlh8KiqXr/3GOrIaL//bwkfhC44pexDEV37UO418+DY4kviTzK+/c8GEGNT0xY4e0CCkif1pFIM5jeS28n60FcbOXhHx/sd+7BW2oIwQHczvJcZ9qQZReMjfz91QsknEpKRpxe94LbvrfRUSBFMsOD6g7ez3r5TF78Cgg0BDvsZVViNMmk2cif+Qu8rI+g9MM+Dg3fRlYX96LZM2W4xLyMlDS4GXQ7sCWekI44Z+BwP7EbI/6BPGJOkrQgN184QRV3IjuwB82xKHKdNnZf2pLPDr2+XjxSb1NL/+8Pew2hql8WDWaeO9CBA7/wqW7uZ0BKwYIAf8VK7BlfiyujppsjWBw1pt7N6rKDpiny1a1h4Y6lltuLz51z/GmBdiQ/WullUWu5wq3x6Y40+Iy5NbJnc4GNGwL3ltgVg5E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(2616005)(1076003)(6506007)(26005)(316002)(41300700001)(6512007)(83380400001)(107886003)(186003)(6486002)(52116002)(478600001)(6666004)(66946007)(38100700002)(38350700002)(66476007)(66556008)(4326008)(8676002)(86362001)(4744005)(5660300002)(2906002)(8936002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QUAPv3lXSfz3VSkZHUdbwIFT8J1Uci/aZ8Ghhp4A5bJ+iE9rhk+YKPaWFMd0?=
 =?us-ascii?Q?ykNJJCVDpzzTyxYnPdV9LNdr8ChXn6xO6GV7+Buzsgk+rSSi2OehcnQZnDLg?=
 =?us-ascii?Q?eCHrcZKzyPsAH3O7NAHqR0W1yL+oY1G1FvjalA4qcyxesFy/WVPqGSUcJmAn?=
 =?us-ascii?Q?oAHab8pYgstuaoNjc2KMH8Pe+5Yep0YwNC0PDTokv7nruQACT/Iyoe0NMxWV?=
 =?us-ascii?Q?RVXQln/bG4PeItxX0bjoGf7uHnYJce+pAEOHreUnMW/ycJkahWWZF/1ir1ju?=
 =?us-ascii?Q?kKFG5YnI32HcieN70UBwMRMG92mdMc1Jl0aBplj2XLrgVwz7Eb6NuXYhj1WT?=
 =?us-ascii?Q?4kCyB9vzCY7q7eFyyFLWfm1Tr2q0la4kpMpK0iUEniSfvsboqFvrNR0OetPO?=
 =?us-ascii?Q?JNclP07GlqGFxY4QFVbSHqHiD1CQgqHqORxPMEPax5IsegVk1vQvrCoBwPvM?=
 =?us-ascii?Q?iA4bMmd7FFhwbhKvY1yKPJjGFfL5I2rX97l3ffGaXr2QdVqq7kMRyXWLtFny?=
 =?us-ascii?Q?hld0re+XMihDseXjlxiIl9ym8H3ekuAxOODNlvq8qLMlHWU/zh0o/knWZ4Rd?=
 =?us-ascii?Q?/IAr7ZbmEdJaaDhc8i6LAVleJr7LTCSeDGYeMUCMHJ2j2MoAQaen5dyeiVuI?=
 =?us-ascii?Q?oIII6Z/I+bqDXe5q0tm7p9jiNu6mXJLxV7gxFJz17vxgcviVsgO6ZgHWUCnf?=
 =?us-ascii?Q?tQfTlZmJUKbE792JPvXlAqNfg1v3MyiqQOnUn2F5Z7C9YTpmyYP+FtynvWA3?=
 =?us-ascii?Q?dBcR7amJU/qgJkiQztqMM99qGIHPYVbXZtXSIShuSYU19uQRHHYps3JaGA2K?=
 =?us-ascii?Q?/ryj2bJgFUYsPFWNPG3hTORlC0UW5t/tNBn0U70sNzMq5fqN/KEOI3ltrRF7?=
 =?us-ascii?Q?dGK+NwDw5FPo6wd+cQdhIiASU1dWyxhuW/fHnUUdGAErbf2earWjyAeWwCZa?=
 =?us-ascii?Q?Rce6N/nfCqxDx7fFzk+AnA64yZ8iIoBE3gqus8x9GLNvOP9lbzVRwsCQARvE?=
 =?us-ascii?Q?JP44aOT6OMjgRawr24GFOfzI4Wv5ic4GzBCTdMCg2upwEB/M1YMJlPfSLflL?=
 =?us-ascii?Q?/7W26eoQ3Wh6PC40QHOo5hqjaqCYvHN32KrZRuCPoShy3CD0N8io4QwUFZZS?=
 =?us-ascii?Q?EG1E+AJPQ5smTCroT3oM5JHHCLbANpg8Ux9gyfQYjTXWMvFJ7eUzYmQ5i0B7?=
 =?us-ascii?Q?QGLlhSr3oAfdYDLgihk0Ok7qAuoPqbWifn+ik7VzeIwMRfYsz7zr1K29Jed1?=
 =?us-ascii?Q?ZR9nbnq92j+MeMrEbFVvyiN0OZHFvXaD+N+575DSKq3ThPNk5zpmB5KXwxPX?=
 =?us-ascii?Q?M3+oiPigCth0lpWBqwoofHSZioxCngdmCG+kORukfy41dFTjKg2xSMQ5cqB8?=
 =?us-ascii?Q?GzpM3O3IMeX4qKuhnyjsd74v2sLOH2HV3iW0L+RQCC9UJlhAEJd0urgf2eNQ?=
 =?us-ascii?Q?ZVCl6NYJJq/SYPkZQp0TRHKlPgd/e+MuYPyS/Y2EnmrIo6+YzKoy8Y+uCwug?=
 =?us-ascii?Q?X9sxThk2nCdU/hXCyUDOM3kUvcDL04t88TpMuaEx1ypRsjM3uCJGBv8IkKEK?=
 =?us-ascii?Q?v8n5+DfMskhtc54TJtn2HekFWUS/ITS9uXgQIvcj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2375ebc7-2a5e-4c32-eada-08db7eda6d32
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 11:08:00.4501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBxWoiZwmzJMOJ+D2pxCerLTkHnL0uBf/s9HCmDEQ8pjpnm8kfzO00pHbqq3AIqGiw7Z1gm/q9sCQ2fH0tFVnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4030
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value type of i_blocksize() is 'unsigned int', so the
type of blocksize has been modified from 'int' to 'unsigned int'
to ensure data type consistency.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 fs/udf/truncate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index a686c10fd709..c80dfcc583f6 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -123,7 +123,7 @@ void udf_discard_prealloc(struct inode *inode)
 	uint64_t lbcount = 0;
 	int8_t etype = -1;
 	struct udf_inode_info *iinfo = UDF_I(inode);
-	int bsize = i_blocksize(inode);
+	unsigned int bsize = i_blocksize(inode);
 
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB ||
 	    ALIGN(inode->i_size, bsize) == ALIGN(iinfo->i_lenExtents, bsize))
-- 
2.39.0

