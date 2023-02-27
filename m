Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767AF6A43C4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjB0OI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjB0OIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:08:22 -0500
X-Greylist: delayed 2204 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Feb 2023 06:08:15 PST
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F32393F9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 06:08:15 -0800 (PST)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RCIFmC031731;
        Mon, 27 Feb 2023 05:31:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=FAsY5OdVfyZSEob+KVi21g3/vJliuU5Gu+JF74RhGSg=;
 b=O44iYvWGqZR/hQH6Qg3nA53olTDtORwLU3ujzERjgePwu4tBAyf1maBqceR5F+t9uRM/
 6DqdpuLjIUalOBtlD5SpGVy7NSpgSf2sFtPMt7abMMKAAyj0u3nDKnGfyOwcHH/owAPL
 /Uv+qOqdF3HB1q9BpUteNv0V7A7DjWVr1X3ZSF7mWbbkZVXbmGp8+XuFJaExOjnCJZYN
 5IB3dFQAv4B04Hlt7c41XC6QXuMfUnBS/gRVErPV5XSvsOqL1QvzGqxZLIbWa7N7ekVc
 cM64H7Ruhj6lkuNt27iSEoBRcvzwhFNMO/JAohn1g9I+SC8UkVN0ocYJVrCcBl4LdZ0E jw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3nyfs56yxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 05:31:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtUYrhmK66N5PF61ksRnv+MHcWwLuiWuREcK2bhfDwATBJqdudzVopA1Z0e69+ssDyTzidfStreahfnkXsmV98hKU7p4JkoaMGhGLlQhQvy2xzWXM2cLB4SZL/leKScxG0ZGkPPopJzvXunONEmc1x+kfUSMqrnSWkkaxxOEF/FCJGwH1+n/euI4ar32Wch17ek4Z2l6lHwBsF6UJXXQ+d9ybyXPS88qCfjrS47G+7+XED0R5PkKDgkIJr7gCTNMd5skUhrXFiSsk6uZCJsVg9ENrHBBFkYUuAzuu2+en3ViAIpdgROVnd4ELN6f4k6OZg7fdj4/w1HvpKjfHTQWug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAsY5OdVfyZSEob+KVi21g3/vJliuU5Gu+JF74RhGSg=;
 b=DjgdyY08oJ87Hc3O3DyDfeuSvQRsvToZmsdLoqxThyr5Fs//va+pvO8wZjGUEEuKVJjY9HZL/FWlryZhVRK9HxiBTeBthF2cfp3t6AUDTaokk7SlBqAA9lvj9Im+XUXDHlUmLmv7JbvYKbk2F+TWeJ3PgKDAPR6CroNB0KO8ry5hpH0hz4i9c3hSd/p6DE3C3Cz7/hTLgtsVDmRdriFIDRH6NCoe65unfFL/wCbfiMTA5QM+FDIkvLj+s9+fy8VTBiduhgMzAxlyfZ4JhbHMsSimsfpRaOojbdPwO8WSxO2AzsB/HC7J1U/OH64A58x6Xm6mepRMnrJ0xeZoq22PjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAsY5OdVfyZSEob+KVi21g3/vJliuU5Gu+JF74RhGSg=;
 b=LcNwVPaJBgn4Ddb8HicscC2prr1YBxfdzWdVRPKy5vgJ8MPUjlFxlTcdCUzBPN6QLDJ7FxRaRLwHb7iZdubcyAwLIfz+nemmFlr9z4MX4x1jgWRE9y0rYsktAVcUYpQQ+urtMVv8r+iMvUbEfIhbT+wHHad8jVD+zY5lLHWHbpo=
Received: from DM6PR03CA0085.namprd03.prod.outlook.com (2603:10b6:5:333::18)
 by SA1PR07MB8499.namprd07.prod.outlook.com (2603:10b6:806:192::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 13:31:09 +0000
Received: from DM6NAM12FT006.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::d3) by DM6PR03CA0085.outlook.office365.com
 (2603:10b6:5:333::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 13:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 DM6NAM12FT006.mail.protection.outlook.com (10.13.178.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.19 via Frontend Transport; Mon, 27 Feb 2023 13:31:09 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 31RDV74h019544
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 05:31:08 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 27 Feb 2023 14:31:06 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Mon, 27 Feb 2023 14:31:06 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 31RDV5eG029850;
        Mon, 27 Feb 2023 14:31:05 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 31RDV4dI029828;
        Mon, 27 Feb 2023 14:31:04 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <r-ravikumar@ti.com>
Subject: [PATCH v2 0/4] PHY: Add multilink DP support in Cadence Torrent PHY driver
Date:   Mon, 27 Feb 2023 14:31:00 +0100
Message-ID: <20230227133104.29788-1-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu4.global.cadence.com
X-OrganizationHeadersPreserved: maileu4.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT006:EE_|SA1PR07MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: d3dc4e39-ae5c-46de-7bea-08db18c6e2f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTBNMWTsW9nxL3hEDeN1pVPgs/4W3S2r6y2hgbHP/8F+i21z4PXsZJO9D1HJ8OKHYDGVu1A8cZzCJuil9ekyi/7bxUutxs0yIpK2IXTQlj5NiZ2VcKlzivamTkLybmbmjYedghH/+i8sWnEPfsn+pLdsgHIRhqPBbxkvPXGwY3k0dxRGPGhUM530Df/5K2wyxTP967kxL0IZlxk9IBDlzgjHe+NBoRh0+BEjSEVy+9wdHpWPY9mPy3p9SOda5BMdJLp/bMoHPPEqFsR945pxf5aEu57Azeox0waFBJD95O+pg2Il1q08Sf1W82vgaKv8auvV3yLwKktbwKnvnjNVaB4HRATNkdaLw4258ihuiWJX3l/NH2ntLztEwBSnJghgW7sXw6wv+gp+6waNg1KMSh/Ghhl42ryFYe1NZDy12N0hhlh4PtcvetgPsJGPrm+9JIaCy57+ljL/itR9Am1pDtF2Ql+Us+KEHejhGDBXL67PH/fAPKnakX/M4vYYyyXIGpy3mpKTng59WYhFUz/3BDx2eKQb767D7t9qi4kMJX0kR+1zPS9Tl27cmwNUou9n5/X/3+9QjG8+plV90BFsDJ3a6yewvcsbvWXdhWsyKeqbXSvR9iUp5AQZwRALw7ICc+osDrUvumWzIXW4/dWy+vkP7sWfIeixayzGLAzNYNxkDr2CAx2jRD9X8IMuBIEvU82dmf8+mUak/OoJdE3MRQ==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(36092001)(451199018)(36840700001)(46966006)(40470700004)(82310400005)(2616005)(42186006)(316002)(110136005)(36756003)(86362001)(54906003)(40460700003)(966005)(186003)(2906002)(36860700001)(4744005)(5660300002)(8676002)(4326008)(8936002)(41300700001)(70586007)(70206006)(1076003)(426003)(47076005)(478600001)(26005)(6666004)(336012)(40480700001)(7636003)(356005)(82740400003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 13:31:09.2515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3dc4e39-ae5c-46de-7bea-08db18c6e2f6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT006.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR07MB8499
X-Proofpoint-ORIG-GUID: ouI1PpBWMsBmooU9gDfPAw7yDVAa8EZA
X-Proofpoint-GUID: ouI1PpBWMsBmooU9gDfPAw7yDVAa8EZA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_10,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 mlxscore=0 mlxlogscore=905 spamscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270104
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

