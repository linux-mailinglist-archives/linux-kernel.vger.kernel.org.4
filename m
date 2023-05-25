Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CF5710577
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 07:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbjEYFu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 01:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjEYFuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 01:50:23 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DDCC5;
        Wed, 24 May 2023 22:50:20 -0700 (PDT)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OIRAhZ015417;
        Wed, 24 May 2023 22:49:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=proofpoint;
 bh=Zs1M5EtolUqj3rEflYU9DZx2RbUyimQ8t9Bbibule3o=;
 b=HMRuEnsgYWugYdnwFYOqxEGPaHm+AuBNBUpvwFAcomd63rrhngiyVVqkmtzG4EJUmjLz
 81m2b8SNb71DqyVYSz3t9RuhqUMh0XI/5MkUDImlpBvdIwNx72VmjXqmFiBcxGjJAJaU
 h/gD85yQTCaL4rRMI5bhAUwJzX+6I1LR+BjDQ1bWCJpLBPaqZT+bl3GTFl4kJ0hkVX80
 OTP5TJjXdj+uUezQ/d8IepqVdpqY3OLuGg4IiDEk3HcavBkUz3VhAgom6AgfdZfjs6Dl
 G7UESfMC/TbQ0gmmVtJmjrF/uqZaPnwXQ4B/FOj8PRkF19FBjp8W40qJtBCyDVkVksSK qQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3qpssysjjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 22:49:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2AJnJcGSuakdRFeDlUF50XuuiTw6gmT03lnjQlPOEoDoqBpRnnZEGzC1zloJScNK14RdRXEGiDO/KKE2e3nCw4rSJA5BLzX0j8dIQi/cTnV/X2r95zU+rtuRoqOgg/wJSazk3MYCxV1PYu25+Zh9DTQo/KNnwQJ3m43244wbhjAeF/8XqdYStuoN7WEIO0Z4+b2wILAIGrhMhaxhHMGxUOd9FHikE4YleXCpiQtGLn10hDKZNEXvQAFscx/xQBiyyEV+IcAB3IPB+4QhAYsTx3YeLNGcdMZozrdkmVrGgSjhYWMPr8nl5aPwWO7XmPn3ZG5qgD3weiNiSCToAvbgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs1M5EtolUqj3rEflYU9DZx2RbUyimQ8t9Bbibule3o=;
 b=FzTUeCjvBl5qmqgpVBYhIZ7D+5Ul17aPDhwNUqMnrGBaufSbn6p3Bw3FuiQc0hWBLVJYca/OVpsQMNyZ5ZgLMmkGBMHG4ncp2AnamTTdTkr2dsePomN1Qv/p+KGYObUjUbJRBVKOQuDeLeNujh1qDa/o9Z57QKTNTw2XYcbLOgGLZK1RaGuLG17I/GNkWx2wVTebHdaycABYPHCrR0Q5FyyxlNAZBU06phjpH90hunXdPkclAdVEkpaKjMFToen5oMNxjxHDO0TuvZxqXrighx0nzcEHQFhQPvoTu5T3b+rmluGjV5FFTBc7/j0+s0WO5JxW5nfR7jqhg5k1Pku/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs1M5EtolUqj3rEflYU9DZx2RbUyimQ8t9Bbibule3o=;
 b=4B34iXc+O7+qch05eiNsNXUnAgEA0hmikFW+e2T6Ce4CW6mmp3KGFhR8h5q4kRIsae+J17JOXJCaCDqvzbdgOVb1kFlVO6u8axAm5cazh7DUagLI7terf4cfCH39Y/6QJ03iOBijXu0ILHUJV7vAIOsWUOTpRYXCQx4QHJUGU0k=
Received: from DM6PR07CA0127.namprd07.prod.outlook.com (2603:10b6:5:330::28)
 by BLAPR07MB7780.namprd07.prod.outlook.com (2603:10b6:208:286::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 05:49:49 +0000
Received: from DM6NAM12FT029.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::69) by DM6PR07CA0127.outlook.office365.com
 (2603:10b6:5:330::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Thu, 25 May 2023 05:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com; pr=C
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT029.mail.protection.outlook.com (10.13.178.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.16 via Frontend Transport; Thu, 25 May 2023 05:49:47 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 34P5nhWm101837
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 24 May 2023 22:49:47 -0700
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 May 2023 07:49:43 +0200
Received: from eu-cn02.cadence.com (10.160.89.185) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Thu, 25 May 2023 07:49:43 +0200
Received: from eu-cn02.cadence.com (localhost.localdomain [127.0.0.1])
        by eu-cn02.cadence.com (8.14.7/8.14.7) with ESMTP id 34P5nhFr243911;
        Thu, 25 May 2023 01:49:43 -0400
Received: (from pawell@localhost)
        by eu-cn02.cadence.com (8.14.7/8.14.7/Submit) id 34P5nhjv243908;
        Thu, 25 May 2023 01:49:43 -0400
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <Daisy.Barrera@siriusxm.com>, <Cliff.Holden@siriusxm.com>,
        <tony@atomide.com>, <jdelvare@suse.de>, <neal_liu@aspeedtech.com>,
        <linus.walleij@linaro.org>, <egtvedt@samfundet.no>,
        <biju.das.jz@bp.renesas.com>, <herve.codina@bootlin.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v3 4/4] MAINTAINERS: add Cadence USBHS driver entry
Date:   Thu, 25 May 2023 01:49:16 -0400
Message-ID: <20230525054916.243330-5-pawell@cadence.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230525054916.243330-1-pawell@cadence.com>
References: <20230525054916.243330-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT029:EE_|BLAPR07MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: dc8bf103-6813-403b-6100-08db5ce3d983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OZ9D+s/9AG+ZbAZfzzOvEaqCcpkDd9H1CjdsgW35i81IHPPGWy2ka4zL57DN5Mns3Dd1L/IUYWwPXkkBvOwIT4lBxR0ubYrZO5PnPzYTNBOXApZ5R1K9zCBMLK4WBhtv9/66gS3s+Nr27SpBAaSx0Ynzw8QrMvBuzLnXE5p3JKFOrpAl7ESog3AKm+cf2T4PzU+SEhaUYvvCasX8fbvjkSliMUcg4UrZQcqqgY0akKPr+wgZjw+HHQdrQYEyIfMPVavJQaY1XQTi5R0NHhoQbbDP8GaLOrTDm7/RGFv5GbwdfnyX2ykl8qRENP+y1NWlDwU+XxNfhdhDxuY1S6J1NwophxxBPnenN2UyH3R+MkVGLjA8FduKwLP2OYA4BM+daXlvg9oP8npIje8fi1lVf0RCJSM9mCsI/fixZCQBuwehdnWdjBilpHKa2s8GUyH+r94HSS5XHJKUH/11YRcGQKjohzyKFYZxA2YcLiFqImQCKEGULFieST8TRiQSyqNVtb5mYwLECUykTQqWCnMasZ7icEQx6j4trcmQs8GqPBh9n/AGPUbbRyqvlXD+KvVfH7EU6xdxoZggcSlr7IHx7N6VKqtQMEZGym9Kj4cCVGk9xUrYbCRL+7Odn4aJ4acCUeP+5CNWs02JGHI7FFfcA8b/x3YI8D56KKDavIqYiSfB1XfBRKbTrzujlm+8LRhyjAtxvCZebfhnCoqvG6h4RA+n4MgH0dD2V5SvcLnuGf5L5t6drsheExSPytd92wpqeyBNsnfwTvHesRX538OVaQ==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(36092001)(451199021)(36840700001)(40470700004)(46966006)(356005)(82740400003)(6666004)(6916009)(70586007)(70206006)(4326008)(81166007)(478600001)(42186006)(54906003)(316002)(41300700001)(82310400005)(86362001)(40460700003)(8676002)(5660300002)(8936002)(36860700001)(7416002)(40480700001)(107886003)(26005)(1076003)(336012)(426003)(2906002)(4744005)(47076005)(186003)(36756003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 05:49:47.8717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8bf103-6813-403b-6100-08db5ce3d983
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT029.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR07MB7780
X-Proofpoint-ORIG-GUID: ZM99dK8D49m-SaSOjhPYwB0oXPDN2ADb
X-Proofpoint-GUID: ZM99dK8D49m-SaSOjhPYwB0oXPDN2ADb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_02,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=770 spamscore=0 suspectscore=0
 adultscore=0 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305250046
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

