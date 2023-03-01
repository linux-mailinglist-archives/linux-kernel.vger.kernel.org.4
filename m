Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93E66A6D11
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjCANeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCANeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:34:01 -0500
X-Greylist: delayed 1326 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Mar 2023 05:33:59 PST
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FBF1EBE3;
        Wed,  1 Mar 2023 05:33:59 -0800 (PST)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321AXgnb018604;
        Wed, 1 Mar 2023 05:11:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=DwSCptbdo1s3M6bj4pJDiCwDapfJ8vd8K6tzajKHMSE=;
 b=dP5hZH3NA++YVwYfVp7Ydq0MJB9Vwe+GvHEIVi7FhERFbtt16tRl5Kj1d/U0n2XgWrTS
 gzoYPRyAzkkKjAt++Uh/de0xqvp1y2Bg7sst5+xBH0q/OND8/OTimPaRE8AkMNZ0ryCP
 2AmNW4B4FekSrd+UIyzZrDatnwoZS5MOxCIvrpOqD7sPmD59+SmzmaNFPqFRYKqvt1KL
 O93orSCz08/l+QF+ikz4wRvQSI8WzyU3bIhqZaFFSHFhtTXnde66VVbzhnECnpoIS9mv
 fG0EXCC3AjYQuxu7ucv2eGlvdQzu9i+/BpvRUY8jeRiJD1C6bQs8Ww3lHsbGuY53pztQ RQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3p25280ky9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 05:11:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOYcx24Noh0j1GloLbNelPJMA7XPFVb51ZtNA+4t/DgnbUIGeLl5ZVzwlTX4+8MkjLbwp6iQuwYJ281rXe3PYBks3HygLz9TYzBQYV2CQhnPeYztT09j7rjb8btnZuUbJa06kHsBydcji8OveH1mSgcfkK1rBjaoNvN3U3bUIgefoHxggMXtU1FnZlN+04iYOyOZXYW4JNk3QvnEvsszapMh3xyIxiTf1+21aHzGgtGW+wX0NzPWBdHzlxyHZQk2TtIN8jODJZHtBEf/LMeZ+GDfNqtRkt6iYVIpzv1PaLuyyYnB9/Io9Foh/SubrwplYmXjGaMO4AbSdS/BLXAyGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwSCptbdo1s3M6bj4pJDiCwDapfJ8vd8K6tzajKHMSE=;
 b=Dirn/WyMrb0OFP28IqftdJ6HCBcMgQVB8wmey/+c/QizCCU5he8NOprLUs20uvJnukdpXZmGnRph/6sXL7NaGbwYt5a1vz5dC/V1aGDuUC1vCfsW9OLuCBw1IcnensUejjPzBjOj2uIqvQOjPBfuulYklQzJsrsW/1+GJ5NujRUPhkS8a8auaGh1Ln9IJfefEWhC8zDPV3WwhIOCZyMzihv0JIDsQGUoemvSIiQlaWTG47oVmZ6BJp7J4Gs7wumG4zgKZdU+tefmbyWOeMqlyN8E8SguCUnGsM88hAiejcLOA/zi5Djg/L1R/X9frVvATTtOWH16Jo+pKiMGQ4rhBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=temperror action=none header.from=cadence.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwSCptbdo1s3M6bj4pJDiCwDapfJ8vd8K6tzajKHMSE=;
 b=Za2TvWK2z70OSfH97xQFwhb2SRbwVny/VQ6wyUtaKbhupHqHj0xwBM6o+iMr4WeZWGw8hGTfqfn+A86+ezB6jQ6h+05QYq3uHnIt6EU1HWMROSAA1Uw2qUTJ8sma/2cLgyG7NYI5ffWeHjInjMZ66MahxPY/I3dqCBoCtYeRdU4=
Received: from BN0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:408:141::31)
 by SJ0PR07MB9793.namprd07.prod.outlook.com (2603:10b6:a03:4d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 13:11:36 +0000
Received: from BN8NAM12FT035.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::ea) by BN0PR07CA0017.outlook.office365.com
 (2603:10b6:408:141::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 13:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 158.140.1.148) smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=cadence.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cadence.com: DNS Timeout)
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT035.mail.protection.outlook.com (10.13.182.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.6 via Frontend Transport; Wed, 1 Mar 2023 13:11:34 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 321DBTij021365
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Mar 2023 05:11:32 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Mar 2023 14:11:30 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Wed, 1 Mar 2023 14:11:30 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 321DBUoI006173;
        Wed, 1 Mar 2023 14:11:30 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 321DBT5C006172;
        Wed, 1 Mar 2023 14:11:29 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>
Subject: [PATCH 6/7] dt-bindings: phy: cadence-torrent: Add a separate compatible for TI J7200
Date:   Wed, 1 Mar 2023 14:11:24 +0100
Message-ID: <20230301131125.6084-7-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20230301131125.6084-1-sjakhade@cadence.com>
References: <20230301131125.6084-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM12FT035:EE_|SJ0PR07MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe48067-b4d3-49b7-5c4c-08db1a567bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YNfE+H53dPY/expFvpTajdfMxS8PpO21eIgdJoe+oZokJ2v7Tpdo+6soIWOBk6po3HDWCQ8YNQ0PQCIjvG/I8FWnzlbuEhqcQkq1TZejHaR9HqLm2alP9RvkvlmQzUlB0W78jY4ZKaxuA6FGgz5P0gwEiuISF6VP4j2rLl/1XC/UCLleQ/cBTq2czOyoJcsgz2027vgev/yY3iX3lXYIwjMUOIvYim+IoG0AdJDk7NwNrymwR+nPaIQ/SWRcuVQeUIrTyssepqYVlTq9dK253V6PavbmFTj6YoQ3roAL0gD20ym10YN2eVRa/3toHjXcTgom3i1QBmLTA1f/X86A5KVJhDDQ3zhy2VP/KVNcJAKEYRR6CT6ubQ4PHC2agvCRAqlm8unxc98moqBxdVn8panyY3n5pm0W5EkYUnTzudQ0m+8cNNqCQ7H89qXIZIAhgp/x3pLApsu2U9eemtpfOneGcROGTv6wYKbj57vGjv4bCOWJxqs7PmKaiT3Uxxze8Blzvd4ji7AT5QwsB6K0nd6/7075JA/VDPBYsu5XS2CxtieKOD1CRPDw+MQekxk8zBcXkkVI3mIXrPOoIlOo8t0RQee8IlwvoOBrLocbuI5a/SxZbaUVNBXlcn4F9u5qNX1gWwmW0ZDTrWHoqtFWzEcaL+e+F9xe9rt7KpjAqQoOHSTRkiRo7M45gqHWvJzRP5c0EAFhevpleFO3+FDLSw==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(36092001)(451199018)(40470700004)(46966006)(36840700001)(4744005)(8936002)(36860700001)(7636003)(5660300002)(82310400005)(41300700001)(63350400001)(83380400001)(63370400001)(8676002)(4326008)(47076005)(36756003)(82740400003)(70586007)(70206006)(356005)(2906002)(426003)(336012)(2616005)(40480700001)(478600001)(40460700003)(86362001)(54906003)(42186006)(110136005)(26005)(186003)(1076003)(6666004)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 13:11:34.7798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe48067-b4d3-49b7-5c4c-08db1a567bc9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT035.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB9793
X-Proofpoint-GUID: hsVW-ZOJBQze9W4DcIzSiPUcTOXOJww-
X-Proofpoint-ORIG-GUID: hsVW-ZOJBQze9W4DcIzSiPUcTOXOJww-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_09,2023-03-01_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxlogscore=981 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010111
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI J7200 uses Torrent SD0805 version which is a special version
derived from SD0801 that has two internal reference clocks along
with one external reference clock. Add a separate compatible for
TI J7200 platforms.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index 711097e167bc..1906b6df6ebd 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -21,6 +21,7 @@ properties:
     enum:
       - cdns,torrent-phy
       - ti,j721e-serdes-10g
+      - ti,j7200-serdes-10g
 
   '#address-cells':
     const: 1
-- 
2.34.1

