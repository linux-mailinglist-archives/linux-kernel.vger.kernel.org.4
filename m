Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1675E6E8D85
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjDTJHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjDTJGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:06:20 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1D45266;
        Thu, 20 Apr 2023 02:01:51 -0700 (PDT)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33K5lkiQ008206;
        Thu, 20 Apr 2023 02:01:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=proofpoint;
 bh=Zs1M5EtolUqj3rEflYU9DZx2RbUyimQ8t9Bbibule3o=;
 b=nsvgI3CohLR7MfDo8lVUoVikBPd2vJTvbi86kCYRmAIXc6Q/4wovBgqB6oXjCkWx+Ept
 dvr99gFgTvi85x3STDnC08hwAT/z3hFlqP9IpvpDhcE+AVG4O9he944YXsFUKqjie3Ul
 RIoysUJcP4jF6Ph5ui3mJ69lEE4JknpzB4qwHBOgdSfvR8nAoWQCmfyq/QlDK4S8s0hN
 d5+naN92I22YvkprO0NbgXIpwm4eBWWFIqdXfwY62OqQeA7YcIXXH3xf+y4TO5Tz5gmL
 re9vLhOyyvMg0f0+ZzCYnlEU3ICQEz7OpZsNmhtjkDk5ISRAfFLv6E/+hLu4FExbhX/8 Vg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3q2dncxarw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 02:01:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/s3JjD/5g9spxqGte24hYKSUySTW7jPc1cTsc9gVImF5bpQnRAN3ij9qWxCOZu1FKIvlovoS/HItFHOeg0IWuHjaT4nQQVnU8V6CurVQ2hdEUAiCHv0pRauoh+KvvbVL/p8rzLNxEt+LA+MyrE1Jo38o7qp4Ok8Q7LMr0BzgF/3horCfGE+Dck1XSif23qWN0cfbvFQWcOtdxYQPeP95ZKD5mdosuEhV90/GMcc2Hm8N5BHAW4jZ3DzVUmAzriSeN/Jx8chyA2bL3wb15KhG5vkJQvZYaJPZHl4yx+cfKWWvwX3SLMfvNRQYSqTJ0o9rhT9UjcA4iCjXGhBc/XtXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs1M5EtolUqj3rEflYU9DZx2RbUyimQ8t9Bbibule3o=;
 b=Iim00SvBivZo+HUscI7k4+/9VaR0ZZf+jefJ8jnP2/D7a/eqMjVid9KNuoV5wBYTKlAfxuqTT20HNtQNL1q4AoBOIeaEm3cdX/XcS7Hkv+z9DEYOnVCc8ueYji060skexZBJS4kXFDTOQD9ZLmn0+C+Zw8Xv2UVaaIGINjbNfgv9+LiUd9h6hJp/XCuHeIkVuHYP1Xn6smpuUcCOCaJ1VZm6W7UYOaAbQo6pq+TR1VDytVbungUu/VkDng9VOM3EHBB7c7cbBOdWEA0bFROzGDhOltVavkAPgxaM9NYChhcNzDh1LJcx1mAfijsJKtYEKj3s1BiGx6tXsmEW3mMgdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs1M5EtolUqj3rEflYU9DZx2RbUyimQ8t9Bbibule3o=;
 b=xGlDDh/dkW/wh09mgNx9zCtkuN00e1ChNHLjOwNh55YibRmewj99h7MwxqoqdKxnOmehenvSofpbJ90ePIjWc8GBAngOR9A2l57OwDmyRyskDqw5LH0kVHzBkOvN0zYUR47WYDTr+JR6myM730meegUB5xu7GKz9ktSa5dHcQyY=
Received: from MW4PR03CA0073.namprd03.prod.outlook.com (2603:10b6:303:b6::18)
 by BY5PR07MB8136.namprd07.prod.outlook.com (2603:10b6:a03:1de::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 09:01:15 +0000
Received: from MW2NAM12FT050.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::e2) by MW4PR03CA0073.outlook.office365.com
 (2603:10b6:303:b6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22 via Frontend
 Transport; Thu, 20 Apr 2023 09:01:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT050.mail.protection.outlook.com (10.13.180.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.11 via Frontend Transport; Thu, 20 Apr 2023 09:01:13 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 33K91A77014545
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 02:01:12 -0700
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 20 Apr 2023 11:01:10 +0200
Received: from eu-cn02.cadence.com (10.160.89.185) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Thu, 20 Apr 2023 11:01:10 +0200
Received: from eu-cn02.cadence.com (localhost.localdomain [127.0.0.1])
        by eu-cn02.cadence.com (8.14.7/8.14.7) with ESMTP id 33K91A4d081016;
        Thu, 20 Apr 2023 05:01:10 -0400
Received: (from pawell@localhost)
        by eu-cn02.cadence.com (8.14.7/8.14.7/Submit) id 33K91Akd081015;
        Thu, 20 Apr 2023 05:01:10 -0400
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <Daisy.Barrera@siriusxm.com>, <Cliff.Holden@siriusxm.com>,
        <arnd@arndb.de>, <tony@atomide.com>, <jdelvare@suse.de>,
        <neal_liu@aspeedtech.com>, <linus.walleij@linaro.org>,
        <egtvedt@samfundet.no>, <biju.das.jz@bp.renesas.com>,
        <herve.codina@bootlin.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 4/4] MAINTAINERS: add Cadence USBHS driver entry
Date:   Thu, 20 Apr 2023 05:01:01 -0400
Message-ID: <20230420090101.80812-5-pawell@cadence.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230420090101.80812-1-pawell@cadence.com>
References: <20230420090101.80812-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu4.global.cadence.com
X-OrganizationHeadersPreserved: maileu4.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM12FT050:EE_|BY5PR07MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ae4e63-5575-4b3c-a15b-08db417dcafa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ku9McllYcjO4ij/bQ8Lky9tbGoWjb99zzp8UD7dT+P9SC9A5t79P/Cbd3CXQV4Np8/HKPQxheeIk4xMA/DVE9f4ItzmpK+X/O6iv1paVKabVKR3rSky4XXbdPk96Igc9J5C+cmZFqoYQxb37ZvIf1v0s6idthhciUhd4K3SATVEqdxCb4Fr2pS/kYZDK0lZRmymxKe+SC3SWcO8OBzXbs1YZy6LW3yQqfdJ1bgF6uz0rVaorhQpZr5VQ6i4MRcB5c1F3ZaxGo5r22i87YQbQ9PXIx2OlUJsvBjAR5/0sK3wl+ILeb+ByDHvMCFUwqixMRjZJp2HHGQjyks0QivruMNZQzN2WXDpqxeWts8CtvzccZQd7pa4Sa4YPcUn7deYfS4vemuAH2oTv5uSzJL2j3g7j5t5zuLbhVPkSyfp4Q5pCcu4Hq28MmGot/lOieBO6bMtam5g70tv6zwBsFjA0MuRW2v8QmcZ9LHKnkM6IWInR2ca9ik+wQR801oYD4uqaDyFmbTv9uiVA97h69vnyywnZGT8Jc1fD9740CL3aRYdBlG7XkT5hoMaR9sTHPoD1CMyLxSSeG7LSI/wQiAjpBxd+qhl4Te7SiD1CzbXLBcUfi+SggKeNFBLUkU7/xcde0aTOblhpK5o7YqL0YQl+LjLQAO+LtpExEaUooA13zvCRosxt55veXpfQAI3ahpFVkvRiq2dvAGmKnBEpRePVHg==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(36092001)(451199021)(46966006)(36840700001)(40470700004)(8676002)(41300700001)(8936002)(47076005)(40480700001)(4744005)(2906002)(7416002)(5660300002)(40460700003)(54906003)(86362001)(356005)(36756003)(42186006)(478600001)(82310400005)(2616005)(7636003)(1076003)(26005)(107886003)(336012)(426003)(186003)(6666004)(82740400003)(316002)(4326008)(6916009)(36860700001)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 09:01:13.4572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ae4e63-5575-4b3c-a15b-08db417dcafa
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT050.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB8136
X-Proofpoint-ORIG-GUID: 2tYgSjxSOBAppJmjhFRUs5A4XyIq-M3z
X-Proofpoint-GUID: 2tYgSjxSOBAppJmjhFRUs5A4XyIq-M3z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_05,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0 mlxlogscore=747
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds entry for USBHS (CDNS2) driver into MAINTARNERS file

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c269a15609e2..8b289d52d983 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4523,6 +4523,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
 F:	drivers/usb/cdns3/
 X:	drivers/usb/cdns3/cdns3*
 
+CADENCE USBHS DRIVER
+M:	Pawel Laszczak <pawell@cadence.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	drivers/usb/gadget/udc/cdns2
+
 CADET FM/AM RADIO RECEIVER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
-- 
2.34.1

