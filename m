Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DF8716747
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjE3Pkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjE3Pku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:40:50 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB1EC5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:40:50 -0700 (PDT)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UELu6d010415;
        Tue, 30 May 2023 07:39:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=7cvoUT0UqLeCxmiMeP0N3faJMReaVjatauTQuV30GmI=;
 b=tYLyajEjiawTW4IluQrVzHTIPoC8R3zQWqSpePoXPEZOg3iFgSP8xwIjXcZn9S5sZmYY
 wDdgQ0U1Y20ScLHXl9vHfi0Kw/HIZjjQRMSjjzirRsHa2VLlqDIczRxl4n8hSpO/BdSa
 oFvU1HtbD0kRehW+N8J+phCbvadoGzpPUYwQFxrJi8aJ2xom0nfxEVy4nIbNBTmpq4Lm
 tw1GDhO7KETukNk7fbaUE8rbZKX5r1VG10IoqmwCUK6u2FoEgeOMdNlLAXs1Ni3JuwNG
 BmywUCAyC8Xoqp09jaavGWjz1cPVKLbuf9KvtDpUGet48L6eMOiOh9npXc/8/+XNh4VH lw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3qudex17a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 07:39:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlYFimWULauSeI3WfcIv9CnsVgW5nEQ3Fw9zQgHZbHIHUcrCXTSuMIeF3s3Q44XAmqV3bp3KyLoLW2+j0+b3TE7Bcz1+hYXGnJsu0mjCWCcjqtdayqc3Ev/dUGqf5IjxSAdJE/8WLaCFwNSnYuMUEq8fcVqTPgVuxrdgEUQpJX9UQ+zkH26jHn25g8At1MV3z2+Qy2tcOLGagXxXNEnDdCLoCqLQEUvi1V/XvgU6qPgl1/k7HNl+jOJfLaMjUDXwR5JYQf2A+6mTtpvUAteSHJGT92Ff44ITIsnpO06ccvS//kz1MzSnQyn99BDRmaxNh3eRUkdyUqEHysf9wgDvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cvoUT0UqLeCxmiMeP0N3faJMReaVjatauTQuV30GmI=;
 b=Kqd2bWRiuxVsMSu0kAqDiJix+1BI2mpA+2FL+Fw2/lLB66J89DV/ebl+rZuGM/6nLZ04cGICt+pjR6gqyiUcXZG9UFW06f0G+HngMTMhLYfnY6VFyGaYqb0LO0654wKgJ9Tde88iMHYf/omkRQ0xf7ZWDFY3lO0tedoD5FNChsxJ8gAIaZg0HM2LAxEhmuYjV6MU2ysu3W1EE0w0haUTE6nCzJJfSKqL4odeyzSvUionqETYKJfoz5wIQExBgNzrpW+fhU/59JSubpp0S995LUuR4IRKLAxGkQFFg1WnWT2aDwuUymgze/kQdsxHXsxSYWKHAI5f39cLN+sfKPnK5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cvoUT0UqLeCxmiMeP0N3faJMReaVjatauTQuV30GmI=;
 b=UJMwC5hem0xdkPMt2qRJJCloIgXrht74ozS5sodgHQM3ZhoIsaQLL64Fwalp0eWJ9vy4uaPx/28Hn8oUspMBdPrJ9tvJiBOW9/kt99p0MIOPZKPT1QTxNBWu1Kv2D5+/xIu5kgx6ihOBm0jRNMpIPzVthIrN0gPIMZwFy3p0D+8=
Received: from BN9PR03CA0131.namprd03.prod.outlook.com (2603:10b6:408:fe::16)
 by CH0PR07MB8361.namprd07.prod.outlook.com (2603:10b6:610:dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:39:13 +0000
Received: from BN8NAM12FT094.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::f8) by BN9PR03CA0131.outlook.office365.com
 (2603:10b6:408:fe::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 14:39:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com; pr=C
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT094.mail.protection.outlook.com (10.13.183.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.18 via Frontend Transport; Tue, 30 May 2023 14:39:12 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 34UEd8ue045783
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 30 May 2023 07:39:10 -0700
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 May 2023 16:38:56 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Tue, 30 May 2023 16:38:56 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 34UEctwr026612;
        Tue, 30 May 2023 16:38:55 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 34UEcrhK026611;
        Tue, 30 May 2023 16:38:53 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH 0/2] PHY: Add support for single link USXGMII in Cadence Torrent PHY driver
Date:   Tue, 30 May 2023 16:38:51 +0200
Message-ID: <20230530143853.26571-1-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM12FT094:EE_|CH0PR07MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ee764f-8e5b-450d-6717-08db611ba29b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: voPwZ7KPP2ty/CjScF9KiYaMo4k3Wd5I9wlpE37byQww2nKJ5dc11Usw0UXojx2kXYI+Py9pgvPC39zWiZIMpvb6z0OL/OMXsQgladjXy4Z6MMpUIAhxClmlCJ0hn08g+1dPuv0NelE5N7/Cvbrf/EnbM7i5YHPYBR0OQ7YMSyeL1JjBvy66rxaPF8mBzByPaeKFBAG76XY3wAF8SixFMyqfayifTGIyOROQ/mTAyHskKPz3ka4zGW/lYJWFmI7nGeTulmCZj+fjtTfEczJ62ugI3QkAp2oxFEP3J70RGJnlPE8/b181Low9CQFt/pfoMbJjrb4pTVYNQswERwSrrr1TsHPUZkEf/m1eWrt0U8J9n7Lg8uQRdSZmI14vkSgEb56q/1tHunfBJH4Top0elcbPGOnrjY1+J+Yk9CZS7By90m3MQwTxh4/NNcRA0nqQd1sjZQNYSFT68XGZdcvL8/89zEswHINNRsdW+Bii8hD5JtSHCAp81ZmXoapji+jDqo8BYJRsLHMcnKDEjLo7LM9faKXNqxlFG2PHDbcbg4OzESVHQqc9vIIOTquQAybj9+T/JL1KRMXiIKji6b1Y3VraBnH2w8CmdSjle0wd3HdnS/cdwcPLlSlQvkwO0BXsloIGABy8yXUnzhFscfhWVEvSG5z8WdMpQVsgLcFdFFCd5g5HMfDNvt4XFGpUrOUuXnr8aqy80J6PY9viZBbLSVLEhh31QsPcecZ5b6hopLd4IUMI1T2nV19jcvV65rL576Y0QiKX9717ZQLeo2/V+g==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(36092001)(451199021)(36840700001)(40470700004)(46966006)(426003)(336012)(478600001)(83380400001)(36860700001)(40460700003)(40480700001)(47076005)(5660300002)(186003)(4326008)(4744005)(86362001)(8936002)(2906002)(82310400005)(8676002)(41300700001)(316002)(82740400003)(81166007)(356005)(1076003)(26005)(70586007)(70206006)(42186006)(54906003)(110136005)(2616005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:39:12.0505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ee764f-8e5b-450d-6717-08db611ba29b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT094.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR07MB8361
X-Proofpoint-ORIG-GUID: X6YsCO42XcUUpPYEVABRKqyAMv2q2Qo7
X-Proofpoint-GUID: X6YsCO42XcUUpPYEVABRKqyAMv2q2Qo7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_10,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=533
 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305300117
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series extends Torrent PHY driver functionality to support
single link USXGMII for 156.25MHz refclk.
It also implements key:value pair table for all settings instead
of a 3D matrix.

The changes have been validated on TI J721E and J7200 platforms.

Roger Quadros (1):
  phy: cadence-torrent: Use key:value pair table for all settings

Swapnil Jakhade (1):
  phy: cadence-torrent: Add single link USXGMII configuration for
    156.25MHz refclk

 drivers/phy/cadence/phy-cadence-torrent.c | 1732 ++++++++-------------
 1 file changed, 632 insertions(+), 1100 deletions(-)

-- 
2.34.1

