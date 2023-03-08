Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3466B11B8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjCHTGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCHTGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:06:06 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2084.outbound.protection.outlook.com [40.107.103.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46CDB2570
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 11:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNqLeZMT3Z2w+kWtuGVx/lFgfX2pKziN94u6H3ZpUCY=;
 b=6QMFUS5NSz7/PpUhogh6VkjiCjcwx3abibRX231yqO85WYg9HukaSJuEzzqRFiC8pNq0Q+9lBiSED+KKvW3Q90hufgowlpmm3F2sYY5e/9QOpjUKutSUWHTQv+GSlln3R8NUbfrOnCcp4B1Kw/f3QBBr8olQiTL2lnQgZfKT5WQ=
Received: from DU2PR04CA0273.eurprd04.prod.outlook.com (2603:10a6:10:28c::8)
 by AS8PR08MB9503.eurprd08.prod.outlook.com (2603:10a6:20b:61d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 19:05:09 +0000
Received: from DBAEUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:28c:cafe::b1) by DU2PR04CA0273.outlook.office365.com
 (2603:10a6:10:28c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17 via Frontend
 Transport; Wed, 8 Mar 2023 19:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT046.mail.protection.outlook.com (100.127.142.67) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.18 via Frontend Transport; Wed, 8 Mar 2023 19:05:08 +0000
Received: ("Tessian outbound cfb430c87a1e:v135"); Wed, 08 Mar 2023 19:05:08 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6dfe31cc1d6bfa6c
X-CR-MTA-TID: 64aa7808
Received: from 4a672118985a.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EDB280C2-4FF3-4E7E-8778-874B66085F16.1;
        Wed, 08 Mar 2023 19:04:29 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4a672118985a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 08 Mar 2023 19:04:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLqh70LNHrEjDwjQuEI2/WUTrQtGXbLa6bxUQxmmxJrcRRwZf+nnswvIp3HCLD45CwSIJGU3UELtj/yMgShlJxKU4pGoP8UwA57za5lAKqybpH3MkOUOdbqgVz2UX/ymsLCj1SUxhWiwJEfw2GxpqoJiAsCXCm9DiTBAl11ZsQJ+kK1NMb+aq0JT5uP8Ei45m3V86L7DeD5AVEYXmPzGa8jC4eB995ByUpZOGBMLVxEP/0fZxRG0koUs5xxwKTqJO+wwlm+sslEnjxUrIVF5t3f22SMn64wpCwdHNTyO3quEIz+549WOeRQ260qcD5hvnMqoTnf6MnP8tesy8BMDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNqLeZMT3Z2w+kWtuGVx/lFgfX2pKziN94u6H3ZpUCY=;
 b=H62605En/GAACwdx82Xlx+skIsssDyhgjUZA8doNuC9ltKCSE2wB+Dzv8bErIpiuruGel7M5j4jbevjlorJ4kBhx1ShW+2mowjP23REzCGFJu+4ImnbQ/OPGYg4EWXr2y14+jLuX8NF2m4ct9l7I0/glQsGIeeNn2SxEr/VWdr784GacwaeMW7jrCYFySA1X3rZ4ZGDJBp6syixY0vMQSMYmNyktVHe74P/Opbc8CHOkWBPi4Bq2ahfH2Epyp5VfALMcksCgn+obKfhyZbkZYXfIf/FKHTCwg4NW631riiaAzOLvsyD12s7cIHun5PdAkSRzen4ltXc0C5n3uyT9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNqLeZMT3Z2w+kWtuGVx/lFgfX2pKziN94u6H3ZpUCY=;
 b=6QMFUS5NSz7/PpUhogh6VkjiCjcwx3abibRX231yqO85WYg9HukaSJuEzzqRFiC8pNq0Q+9lBiSED+KKvW3Q90hufgowlpmm3F2sYY5e/9QOpjUKutSUWHTQv+GSlln3R8NUbfrOnCcp4B1Kw/f3QBBr8olQiTL2lnQgZfKT5WQ=
Received: from FR3P281CA0050.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::19)
 by AS8PR08MB7992.eurprd08.prod.outlook.com (2603:10a6:20b:571::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 19:04:27 +0000
Received: from VI1EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:4a:cafe::70) by FR3P281CA0050.outlook.office365.com
 (2603:10a6:d10:4a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17 via Frontend
 Transport; Wed, 8 Mar 2023 19:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 VI1EUR03FT019.mail.protection.outlook.com (100.127.144.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.17 via Frontend Transport; Wed, 8 Mar 2023 19:04:27 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 8 Mar
 2023 19:04:25 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.17 via Frontend
 Transport; Wed, 8 Mar 2023 19:04:25 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <nd@arm.com>, <acme@redhat.com>, <catalin.marinas@arm.com>,
        <izbyshev@ispras.ru>, <joey.gouly@arm.com>, <peterx@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v1 0/4] Fixes for MDWE prctl
Date:   Wed, 8 Mar 2023 19:04:19 +0000
Message-ID: <20230308190423.46491-1-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: VI1EUR03FT019:EE_|AS8PR08MB7992:EE_|DBAEUR03FT046:EE_|AS8PR08MB9503:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a21380-8387-4e8d-a155-08db2008091b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Hu1q+ostTYvm1/bb0lG1weZEiMS+othhf2G46uwvpsn0YfyvYVmBwp/UEGrpomDl14p92F/JhKLX1iitwBu7IQwN4Po+WfzostwKqFt+yyT4nr0d8DWfFdL2BeHRK5qbQSDSr+W0X2EuhI8hfjTI3hn9CZEZ4P9T7S6A+TZp1agCBr1PpWcoa9FlJWUgkCiEihdxVyMrvbUKhM4OsUxVc/96gSDhR9cATjK689q6PDQ7h14jJY8tza9NkmvuKnDmCSzZW8jbmnsGvPNlT/ah48U6mNpJ1qYSwWxpDkAG5n8zZgOaVUcNENNY3rWxBuVzlGCewkhmSrqXa2mCGNcdVjWLwdkm4AvdGCiN68AhOYoCPoZO+I0SW5J2DjEocQdt7Li4HhR4mM/yiGMMHC7yKlde29SNPqqT+VzQjnKKQSm0lNbbKd9VVXVykhkwu1Kzc5QGt1g+hnWNVrbKNR8+fR07yx9FeymBg9eZv45JdtMxep5SVOnoGpLwZe0HqWjQxpjEchLhUS2wUFmO0Uw5AHeWUr579kphSpE3fuRSo5sVisdVwL7jA8bJw9GuMaxspK1VydVLl9zVLbwM2pNH7FAy3H+uL23IMfdaFIsAtea/Xd0s4lPYPl6Rqy/Qs4AiT5qvoPFsizKCIPzehViJXBG4GBXZXI04HS2QDP3kDpKf84OTqyCCqIIP7PA57lFgrSgFK2j/0yk0XmZOYUys/cQfGQASpjDlpaMHszAkHhkhxr5egLqeS31MaHNxOByf
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(26005)(8936002)(5660300002)(41300700001)(4326008)(8676002)(70206006)(6916009)(4744005)(2906002)(44832011)(70586007)(2616005)(316002)(1076003)(83380400001)(54906003)(6666004)(478600001)(966005)(186003)(40460700003)(336012)(40480700001)(82310400005)(82740400003)(81166007)(426003)(86362001)(7696005)(36756003)(356005)(47076005)(36860700001)(17423001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7992
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 84243a92-67de-4213-0a0f-08db2007f062
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pSsdHISn9L7t1bDV+W7UD4NJbWkYJ2JpREfU2ltWYSkZvplp1UBG78gTaCJ4z+j/NOtqnmaCF7im+xc4nAhLKeb0TdpJhia0FlMLglmi2m22hSGuwkJh/z28KBaYacgLcXrto7uePsO1rzVG4aQy2pqaxFYej/eVVA6zJNi/tpmVAd75xz60Ft6d/cEBcXAWQAINJDRNysHx0IVtoCl2onUoGOsOn9CbR3M6SNcnrYpG2uLmG531UCSyxKoVBux8lQGeJS27E34fWVJxNaKMBghpRQJ5+iUehlQtmhiuzHpueKTHtKyrIuR+w0HGIU2OtJ1iOk8/caWt9zVvxmUVCCfZPOtdp3QUcXUUkn4Aa2AijR9ukBjr7E6HcaZHvq/pw3zzLzqX5o1DJ+iQLKTqtKW5nKJyxhTLTr/wtySBXo/dL7eyGNWpqzU/5Qzm7c2luh4KAaffKBPii4jCQ0MoCZJ9wp9pfD28iL+kalgOXGKyAt5L6mYzUBMcht0TMZF/R/mMN6nSRaxL4ut+UW/toFPAvZA0hc/AYlWzAg+VoNU0DPnroynY19+jwtTYUw9Zcj+i2LUenpqwpEg+cgQtIYqPKKS6KPmp/B0GblVujXJpi66sL9a70IlK0A9JqIoQlp3zH52vx0WRS1GcJ3zZTdIBQldxyKV9f90b0BJGL+9959i0MvGXo+7MUKYosiDTuOALJyXfse7V4FMOnIxsXg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199018)(36840700001)(46966006)(40470700004)(6862004)(8936002)(5660300002)(41300700001)(70586007)(70206006)(4744005)(4326008)(8676002)(2906002)(44832011)(54906003)(316002)(478600001)(7696005)(36860700001)(426003)(107886003)(47076005)(36756003)(6666004)(26005)(966005)(1076003)(2616005)(86362001)(336012)(186003)(82740400003)(81166007)(40460700003)(83380400001)(82310400005)(40480700001)(17423001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:05:08.7690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a21380-8387-4e8d-a155-08db2008091b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9503
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

These are four small fixes for the recent memory-write-deny-execute prctl patches [1].
Two reported by Alexey about error handling and two tooling fixes by Peter.

Thanks,
Joey

[1] https://lore.kernel.org/linux-arm-kernel/20230119160344.54358-1-joey.gouly@arm.com/

Joey Gouly (2):
  mm: deduplicate error handling for map_deny_write_exec
  mm: fix error handling for map_deny_write_exec

Peter Xu (2):
  kselftest: vm: fix unused variable warning
  tools headers UAPI: Sync linux/prctl.h with the kernel sources

 mm/mmap.c                              | 7 +------
 mm/mprotect.c                          | 2 +-
 tools/include/uapi/linux/prctl.h       | 6 ++++++
 tools/testing/selftests/mm/mdwe_test.c | 3 +--
 4 files changed, 9 insertions(+), 9 deletions(-)

--
2.17.1

