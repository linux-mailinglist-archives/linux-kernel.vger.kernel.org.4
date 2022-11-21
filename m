Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F8A632BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiKUSQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiKUSQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:16:37 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C8BC67D6;
        Mon, 21 Nov 2022 10:16:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGes2baC//v96iLNF/YFNOjuqF/5ioBJ7TGi/nHGX/Lk61otRUHWvZqKQ5mk0/2nzZv9VduWLpI/yjzpy2Iy5d5oy6cZoooc9FPWerDq7v2ODLwQvfcaBS6WxJSoO+F78Pz4kVfcekC+iLHpqHqgnwgR/3lL63P41a0W6Oqj42QgVkgQsH/6s2l5PQkXH0n8XXe0ownbXmGRBYLOu6YwzL/h6RI6zEAHzKScg18mVYRfkVM830FR7CPZJSShHL6aN4sQ8ine41Zx1Xdjli+ytjwinju9j86pA81lqUUhPI1wrNN31QXdpOmkcdrykakmewZ/kmAVR97Yt1rnVBo1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZIdA4AzHmLMMUxe3I2F8PMu86GRUHdRa2Bfh+ThL58=;
 b=elek/wpGdDg10PyItMUMOBvSci+RvaLq5Zt9aj5lNr5tEBgQDDJhHPvMQAGCnMSpk6z0xK7APCeg0+1tUl7hMGtpFmP7rAYTODIdhKjEzixRkLgWC06v4SWfcMnN2bs/2Rn8gA8H2KUxahb4qZVuJO1QmDn7OhB+IefQGLm3+cG5kOzJtWinB6XKUQtbIr3SKNUa1ZQyvR3c4r3oNOT/F+E3m21IyH+jgKAF9Hn9enAgd/f5LsRU2nYJ5wd48fFbR4KBw6koHpWBCY81kPXukXogk1BcP6X11OMOO/6Vfd2n8kb5ojF1kRvuQS9+XWr+ndhkt73tBDA0rMVi5/Fz2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZIdA4AzHmLMMUxe3I2F8PMu86GRUHdRa2Bfh+ThL58=;
 b=C3Wx1Om+cYgx9aPWmfC90dKaXTVwD23pNfWwHkjmho+zYv3sn9FphbcJR62p1EsLqx31eYZEbS1wJbryAHCSMhPmj/TluVM/Q+Wu3h89LSRDRIqmkAjwA/0EoegYP8v545x2qjwb16fdSj8VjyI6hCrT5PE7xZPZXEK9wYKcCk8=
Received: from DM5PR08CA0056.namprd08.prod.outlook.com (2603:10b6:4:60::45) by
 MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 18:16:33 +0000
Received: from DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::b6) by DM5PR08CA0056.outlook.office365.com
 (2603:10b6:4:60::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Mon, 21 Nov 2022 18:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT073.mail.protection.outlook.com (10.13.173.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Mon, 21 Nov 2022 18:16:33 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 12:16:32 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 10:16:32 -0800
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 21 Nov 2022 12:16:32 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <lukas.bulwahn@gmail.com>, <ojeda@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bilbao@vt.edu>, <jm@goyeneche.es>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v2 0/2] kernel-docs: New maintainer and Spanish translation
Date:   Mon, 21 Nov 2022 12:16:24 -0600
Message-ID: <20221121181626.149558-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT073:EE_|MN2PR12MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: 2236d80b-4a7e-4fdb-29cd-08dacbec8508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yfr9Pr828ydI+TSQrHKyPj7hnaCsYZbXtUe10mPZK5rgaRxFDZ/CVfXUuB8JSbo6CpIyCXWBv8WuShT+FCCW0tvsDk2KiV2slWNMDvXwo76XfX3plLbF5FC/naL3UYCbTKaqrYwTuKwzM7zv7NKiZ955Ay+GEGDaEU6VqGo9Z16kj0H6oxniYC75tg5W4ckG1SjkdzQfjXkI9KUOmzEeY2ef8IV31A3MBMCbVf/waSs65fr8S+oK7rcEycL4ldU/JWcbRAxsKP2Dcmx8TiKDwBDqUmQvvSMzibUR/s3fdsL4s67018vxe0WCwM5zIgyG8WCTbYIBlcczzXsmaQ2mCc9bhAMl2FaanGVu7NzD2ellFfZpeezL+atuStWu5txs/1ug7UzgQVzgJfm0Jm1IJuXkMcZe7UrXBYftLvF07ele6pHuWrqAgRg7qegfMaBCTvfJVMj2qqL3v5oD1hoNHuWRygMYLmTzURYcYbWVEkKEpre4bif48dzQ5SI4mAMYiM0QVG+LacORFI7SWlAXU4qFh0BefebAGkfTKQohlXHBaE0ghPq9xmeIqfTTZZb/qHeD46CjBbVCQZzdLutLWnkCk9DyIT3xKe6RCmnVvY+NykaX3XhUpU1xv5jnD2IIUCT0RR8cKibXMYbkj5JIHxCbn9GmQ/mtEhx0pVNuBwP6ZsRXomyvERprxtDoASjdahei4I3KGlXMQmJ1W6/4zP4eMVaMEAr5GPG4PB0Na5f1AtO+VXvFyPHXP3rXqwCsy6UXWg3Qo2oXU6nQAhvU9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(86362001)(36860700001)(7696005)(40480700001)(40460700003)(5660300002)(44832011)(2906002)(26005)(47076005)(2616005)(426003)(1076003)(63370400001)(186003)(83380400001)(63350400001)(82740400003)(81166007)(356005)(336012)(54906003)(966005)(70586007)(82310400005)(8936002)(41300700001)(70206006)(316002)(110136005)(4326008)(478600001)(8676002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 18:16:33.0190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2236d80b-4a7e-4fdb-29cd-08dacbec8508
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cover letter for just two patches, but I should provide context.
I was going to translate kernel-docs.rst when I read:

“Initial Author: Juan-Mariano de Goyeneche (<jmseyas@dit.upm.es>;
email address is defunct now.)“

I figured Juan-Mariano (CCed) may keep a Spanish version of the document,
so I searched for his new email. He replied back proposing me to take care
of the document from now on. I will carry the torch with pleasure! This
should also make Lukas happy [1].

This cover letter is also a call for anyone interested in adding new, more
up to date references to kernel-docs.rst. The document has been abandoned
for a while but its original goal is still important.

By the way, Jon, I read in kernel-docs.rst, regarding LWN.net:

":Description: The title says it all. There's a fixed kernel section
  summarizing developers' work, bug fixes, new features and versions
  produced during the week. Published every Thursday."

but I don't think LWN.net is published every Thursday anymore. Let me know
if you want a third patch updating this as well.

I also use this chance to send translation to Spanish of the document.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/Documentation/process/kernel-docs.rst?h=next-20221116&id=f46b4b168cdb3b16ae8c7792c28d0b921db1932b

Carlos Bilbao (2):
 docs: Update maintainer of kernel-docs.rst
 docs/sp_SP: Add process kernel-docs translation

Changes since v1:
 - Update document MAINTAINERS to set new maintainer of kernel-docs.rst
 - Provide context on commit where we update maintainer

---
 Documentation/process/kernel-docs.rst         |   8 +-
 Documentation/translations/sp_SP/index.rst    |   2 +-
 .../translations/sp_SP/kernel-docs.rst        | 641 ++++++++++++++++++
 MAINTAINERS                                   |   5 +
 4 files changed, 650 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/translations/sp_SP/kernel-docs.rst

