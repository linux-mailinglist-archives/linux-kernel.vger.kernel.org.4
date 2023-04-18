Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2CD6E6B29
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjDRRdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjDRRdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:33:41 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D196A61
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:33:06 -0700 (PDT)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IFlbAj026747;
        Tue, 18 Apr 2023 10:32:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=6SFNI1IS0AXxmmaup4gcJNyDMC2gPmD84g+Zw7dyq6c=;
 b=qwAq9PCJ1StiYr2k81Cnwgs6exhuHQA8wClg2e0RoznB7sokOIv3rvpPiRGhIUH0zXAB
 gtvaBXygfdm3O4//jIItVlFyX/mKnJ6S8zIWzdR8phaO77mL/9iU0uXa2C8A1vuSoYJz
 riOh/9xiDFU5KE88Ng0gHqusP2ZyBxiGKZXi/+ybr+OxSxQtUyLl49bfKanePLNyL5E1
 y5yvsH4ALrBfagrFgOX1ISoCnorvNvbuqZUI+Rds6HK8gJ0yavC42p/I2QQjD3x/w3HV
 kMGKR6LVVBIGTz/HorkS+cvYFwyadcnU82+AIp/+8jzNtVrSB07nffovVDmU+5NlkiR2 /g== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3q1x590e8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 10:32:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z60X1lFJB40CzWxzuO5iWhTeHdloD3OUMowZnbmfOnhjzoc+DXGRjtxxLcEuBieSmVRJlxaqYfMrccssaVbOnDSIexjS+tEJ11gDHbfLMSs5hAACGMebcJtXzRpoJmB8ss2uvY/4TkKTC4zuKk7UQmJQw5eL8kNrOnpnpj3q/Ghnqx/QdLwko+9uxeYZN0R0f/pzUlix9xxwE5xum9X6ZdkJNFSfPdko9EpKx8eO0zeNK9uPzMziizEbv7unxpYcBkOUfZuQc2w2ke0XPaCWp3d9zQbAvTgNeF8vJDUImmfcv/JB2hsn/9+UfKZHwM2ougseiRtQyoZb7PCH6JbIPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SFNI1IS0AXxmmaup4gcJNyDMC2gPmD84g+Zw7dyq6c=;
 b=YWs3u7kjmXWYy2uvINSBQVJKYbFN0Ctev1xt3JLJO+G0JutXOm3Byn6C931txCVbba+IWXvw94Ags07h/T26eMtod0gjnRRO4PkERTsB341a2E+tOksCrV8ZPCaX046ygexA5BNlvQEgIBCpIBy8NzfEuMXLwxaQmw+VH3K8rAN7C2xC/ppkx4eWlG+jG5NgcwfAArFgwUnhWF/CFkZpG7XNM8TPw60wgcWvPPufpPKKpHzGKkLvJbqgYllOp+LQVbL8rkStgv6ZO9zOxn7PaiCalrl4etJB69y7GEEDgJgfEMN+mAnsWAenB6Y+TU71RZwRAt+5vE/sNYprAOowKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SFNI1IS0AXxmmaup4gcJNyDMC2gPmD84g+Zw7dyq6c=;
 b=Wj8m7utdZ9Xa4Fj/3xZRaKxte5fU7ZNwHOqOP+NN3USJ//KzDKXNDHEo73EFrtSlqif0QVmxNhs5OGfXA2V2PjsJwClAZW+Ju6mWT8QYjFQvMkcPMVmwlAu84DmbjyRCYMoxesmE7vRoJN9zSnKp+JO4Sl/18IPQ7TzbeUmkh9I=
Received: from BN9PR03CA0193.namprd03.prod.outlook.com (2603:10b6:408:f9::18)
 by BN7PR07MB4356.namprd07.prod.outlook.com (2603:10b6:406:b0::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 17:32:15 +0000
Received: from BN8NAM12FT082.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::77) by BN9PR03CA0193.outlook.office365.com
 (2603:10b6:408:f9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Tue, 18 Apr 2023 17:32:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com; pr=C
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT082.mail.protection.outlook.com (10.13.183.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.8 via Frontend Transport; Tue, 18 Apr 2023 17:32:14 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 33IHWCfI017486
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 10:32:13 -0700
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 18 Apr 2023 19:32:00 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24 via Frontend Transport; Tue, 18 Apr 2023 19:32:00 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 33IHVx6V025660;
        Tue, 18 Apr 2023 19:31:59 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 33IHVvKF025647;
        Tue, 18 Apr 2023 19:31:57 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <r-ravikumar@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3 0/4] PHY: Add multilink DP support in Cadence Torrent PHY driver
Date:   Tue, 18 Apr 2023 19:31:53 +0200
Message-ID: <20230418173157.25607-1-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM12FT082:EE_|BN7PR07MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: 251e0c61-094b-4f07-7427-08db4032d9c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QLo3iczZha7SRbFpEfkFFW46GJFGHbKXW8hd7ATFoI+4YRJGzX181MyU/4M6xdnf0Y3095MglOxCDIcXrSAJC958qUOenqHoYqvbg3qDXNJc+Zw+2NXvfss1R0OL6aR98FmoXgSRMKsDjujXH8JZRnrl311+3iZfNXEF+INVIgd2uZTSg+PJ2z/FIQLdPIZvVLnToECNykcrodRAGfmf8BlkbLRpy8amvbvB58AnhacFz8Hi+SRGa2bUX6RQqJqdXFGdBH4EMuxLKvHTZt5T0wZBn0YyXeEbgvpjFVCJhkgvFsTnuXcho5bR7nrLs5ihLXo9pMS8uVDihieHNKGrly0EIk1KK3TB26dxUyHXDvRQZ5ANHQGrrE6YwZT1pxmMG6lxu/8Pe/I1wDlwiWJ8I5oZM8536PIZnrwsJIQEnyofcCsYespiygwGz8lXCVzqs84SwI8CCksXOPTbjGMR0tmrvd8AUnkz7NeLDjB0ZRoqBMQqK0C/XPcBLbH4tGw52g3Jli9DlJgNnevko8giXpos6h1FuYCPa3qH+ocjbeEeG7P1XTMwppxVMcs40C6FZld+Xfuj6C/yoiTXPt36xR6Z9NuQlgh7p92hFj/8Iw/B2xIlBEOKu5knPEoRM6JwYjJ5c2m2nHDuIdfWfKOmsQdvyKe1F1svPz2wooF2UIrGExTXaVUYkxHW/vIyKUrBCrzPt4StWpQd/AOkYVl1TA==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(36092001)(451199021)(36840700001)(46966006)(40470700004)(36756003)(40460700003)(82310400005)(2906002)(4744005)(5660300002)(7636003)(356005)(8936002)(8676002)(41300700001)(40480700001)(86362001)(478600001)(110136005)(42186006)(2616005)(36860700001)(26005)(1076003)(54906003)(186003)(6666004)(966005)(336012)(426003)(4326008)(70206006)(82740400003)(70586007)(83380400001)(47076005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 17:32:14.8051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 251e0c61-094b-4f07-7427-08db4032d9c9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT082.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4356
X-Proofpoint-ORIG-GUID: ATxaMMojaHpyhYeVxQUa4I4ShPFh4Umq
X-Proofpoint-GUID: ATxaMMojaHpyhYeVxQUa4I4ShPFh4Umq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_13,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 suspectscore=0 mlxlogscore=831 lowpriorityscore=0 malwarescore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180144
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for multilink multiprotocol DisplayPort
configurations in Cadence Torrent PHY driver. Following configurations
are supported:
(1) PCIe + DP
(2) USB + DP

The changes have been validated on TI J721S2 platform.

v1 of the patch series can be found at [1].

Version History:

v3:
   - Rebased on latest PHY next

v2:
   - Rebased on latest PHY next
   - Fix review comments in v1

[1] https://lore.kernel.org/all/20220127142958.23465-1-sjakhade@cadence.com

Swapnil Jakhade (4):
  phy: cadence-torrent: Add function to get PLL to be configured for DP
  phy: cadence-torrent: Prepare driver for multilink DP support
  phy: cadence-torrent: Add PCIe + DP multilink configuration for 100MHz
    refclk
  phy: cadence-torrent: Add USB + DP multilink configuration

 drivers/phy/cadence/phy-cadence-torrent.c | 720 ++++++++++++++++------
 1 file changed, 526 insertions(+), 194 deletions(-)

-- 
2.34.1

