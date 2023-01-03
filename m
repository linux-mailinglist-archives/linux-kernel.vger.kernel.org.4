Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43BA65C126
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbjACNtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237607AbjACNtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:49:19 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F97DE9F;
        Tue,  3 Jan 2023 05:49:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CK2tXLe6UQnmQ6uciqZKMlJ/KVXbViPJZ2fkfdQ0bPxQNNQRZyeId6ihPYiJLorfu1tRl2uNIntBbYOHyryCtJoX3aatrxAZwklFXUspCw/7L3PvJGztRDw/ljVXBCQqMVoAD7JY8uRgxxC8JpFBQGBgBWZLCTF3jBbGKR2I6zsclmZUABQDCRMloY8c7SZegMTP2cJ2GN3mVkiQRhGPUwMHpnoV4HyJoDVJgOKyxxoodSvBgVOBK3c+oFO08aq7UmqOsdi/0EHgHixGtplgtmst+cJTacJSlyATbYuUsfckJ4kVJquTBqck2r6S9ucXqo4Y4mHiyPIwxl5vEThODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYn3BTXJX3PNzsTWS+h7j6GkEfMLPB7XXrZ3z1EUwZM=;
 b=H3XLEfm27+LbB6v7l755fISJFeq4C81zbnYa4PjWHxWevE1v4iGk7s80qcSqlSh7GOK0pGRCVAeM/aZsiESexLymmsElwJekw/TMSzx8bbKTb2FXitScJrs/snOTXAw0JKF4/dJrVLsbI50dNb7b2a9Eplng8Oe0ALzRXHMCmaDBfy9spp6eaQrodmrd6+a9OZw3i4xP6sm5uSLTx3nJJ4UB4LG4tv4+lTnm+vNPzG2PxvPfjRIM50sAAYl6GsAvq/rVzgarUFIAJ5Y4R4waG/kDrsoyWbIVB0LtuoupgzMy+Wedhz+qsCcaSDnUkuUdzn9OGz8MQjyBEg8huu9n3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYn3BTXJX3PNzsTWS+h7j6GkEfMLPB7XXrZ3z1EUwZM=;
 b=L7kUHZrxX6NLGNte1qjQf6eB/vMjibktG6qEKPVhGEIRWxgfWoMzLer9EVoiCZfVFeLMcahvbf4QnFZt5eIvZ0Z4l2YCgNkc5Z2iCZ22ZL9VSifvSLZqJ81d36TeneiT+E6X+oE/pKI7NXWsBmbznRU2rUK9At6eJLn+dOpHK3KVKsZmMH4H0kCSPLyZqltCDWGrvDKFqK5yfTYNAc2pO9r72VT10+aSMU/KXtfsh3pBFREvqACX0uokNqoER0tRdB9VoOF02oE73dFC2eWZWNPStGsvB97LQWIeaIxIA+JCF2WHBggb/EUGYDatH2n4QJ40ycYPbOSTv5Ar1wZhRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by AS8PR10MB6272.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:561::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 13:49:16 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1f0:badf:facd:2f29]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1f0:badf:facd:2f29%5]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 13:49:16 +0000
From:   Michael Adler <michael.adler@siemens.com>
To:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Adler <michael.adler@siemens.com>
Subject: [PATCH 1/1] USB: serial: cp210x: add SCALANCE LPE-9000 device id
Date:   Tue,  3 Jan 2023 14:48:50 +0100
Message-Id: <20230103134850.53229-2-michael.adler@siemens.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103134850.53229-1-michael.adler@siemens.com>
References: <20230103134850.53229-1-michael.adler@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::10) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_|AS8PR10MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d5a414-4b2c-459d-bec9-08daed914dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gs8TmuuOxVsPnRWN2kmBO0RlG/71dfbkzEigfHHw2rVoRJQlXNeM9EiMlTqR7hzFmwO7vRyQWE4FoiYrQQ46UlXJEmfP6wISIhZQCMNGyyDuEAuRze6K1UPwIyWI+EC97xQ7cMg2zOwA6YF7UW7LOXi8Csmu6dEEiGv734Fy7lBfAMxmhRwgVobTtkXeLzTBeEaH5E+hS+tMzO3F25bsdSWqA18vB8k0+yeIB3iTP9+stCWayf/46fBAwrOpi0MGQWtxTa8YghsDWJ8WGHtEviFM0YzFR2/DTAiVrQzrQ8w3yZvJceeSid0vSrj4bLCA0AnsZdi/FN9ZvLfiuraODPtKtMskYcVt8FW5HWw/ILlCP/DBdwizCdiH/F8gKW2AltCKViPtVsbbHn/rLkn3LQUEPFN4i/nW/MrAwyAP3kDSI4UPedGLZRoVIqVi87Ap+BAUDtn79dk94w4nHOOAkpxMibrRtJyUr9RV+Ey1do4syAb0bMhigS9pxgBmp8XZkEX8ZPfUWv4NItuGxbLwnlnX+QasSv0zbT5r5Vb1lTy+7V2cuFdfY6m7537oSYjPbaHHO8c6eA362MXyY8lMNVsj65uB7M3qKEor9Gs2DMPhLx6iFY7tSJ8I/P5uRU1+JahnQlFSrjkRjC2S2ivwE6vBBwh6u3ORTXrLoUINdnJogkdAbacCGfo4wNQ3GDzEoQfeUtlyLizdlI0H3zPN1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(41300700001)(8936002)(4326008)(66946007)(8676002)(5660300002)(316002)(2906002)(54906003)(6486002)(6506007)(107886003)(66556008)(6666004)(478600001)(66476007)(86362001)(186003)(26005)(2616005)(6512007)(1076003)(38100700002)(36756003)(44832011)(82960400001)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RUjk93zAsnxXPXWbb54c5HOacnjEAYeg/p0bIY6svKHyUupp187bne1PFEuN?=
 =?us-ascii?Q?aXkN519T3Qqx1xfGCooicT4XBba4UOtprGu83GRhmY/HFiHtwV0GkQYK/X+a?=
 =?us-ascii?Q?7rHvUx+1stM6HcvbtgnvYK7hABtTX2gnL4jvSfhi59+aZHFCaaFRz9gQ/QO4?=
 =?us-ascii?Q?K2MANPy4ZZO6gcIbydd8F1SrXEa20EKu/1vecCkVt8+05StqsUB8AFrOPDw6?=
 =?us-ascii?Q?0BCTLZT65HNGgjV9gclU6zTHS0Duorxq1yL1su9JFGLaOg1mnrjA4pPzIwLF?=
 =?us-ascii?Q?P/6J8X2DZmMQ9k4oExerlqL7mWF7NBWDjBXyP+waV5bXFy/A2uDyMF6zwUth?=
 =?us-ascii?Q?8x7eIwYAG53Xnur6VTeNxml6ZjnNO6h10fyBtqtTEzOCMSJn1DRtzK3LyyNt?=
 =?us-ascii?Q?b2xTj7oDyMuapvLLjUPUHAdKkfM90/vxj4cytbN4mDiLPlR41b+CiF4atBpn?=
 =?us-ascii?Q?P4a1g33DS3C9y1RRbVVtDgO7jojdpcdJs6l6Q7Zsj03Y+sa747hQkXrQvhA1?=
 =?us-ascii?Q?oLa0O50ap1Vx2nSltqm1oeRXC+KDQpzu0evIVtZZWEhQ8WwlmoRVEWP5G2Q/?=
 =?us-ascii?Q?Zo4uPbQ04LBv8WsLpSdix1m1MiHRf399gsjHOqkkpMcFox+VLLHZDVjbi1lv?=
 =?us-ascii?Q?L35cooC+hNE5CRrJEMIeJHcToKcenYtrMoaY6Ri8kKYH8M9RJv55iXBemBU0?=
 =?us-ascii?Q?dSBAb++DLJwGoBe9EVvOVK4Z2bFwjYM9MFd4/ODPotXujY+3GPTQGDZSbiFE?=
 =?us-ascii?Q?TdjZxI341N5NW4ZgB7Ya6DmenWiPCJcy+YI7fD9Q95ai4YigIunqhpMBvGIS?=
 =?us-ascii?Q?dQe8UEe2TH/BxokE/plNs/Rd9TKAl9Ca0jKABkvq08eIkZB9gqDIQminQn4t?=
 =?us-ascii?Q?4WJKHBCSsv8ConcHZEQpNgrksfAS2Z8JiHxgqLuM3zIXniG9OhsHwNw6fREf?=
 =?us-ascii?Q?vQiNdSfjIv6I0l3kV88ZSS5ph5i1mW1yQG6QKSwlrylud08TCxTvI8hBGV5/?=
 =?us-ascii?Q?iY/U7T3+no6rAyHp/BIl4+DPE+iOSyp4WA15/ce2WqARPkYlcLFxnzj86/rc?=
 =?us-ascii?Q?CDHEKul5MyJsH5M/cJ0s86T3HyywRPOoDmXYhLisoey6OUMp6k54vTLjy4BF?=
 =?us-ascii?Q?2mZJEP85/ddmhYJQog1oeIWUZIoZE7XnFTMnEz8FmFGMTFjJEBtEV2QaOm45?=
 =?us-ascii?Q?D80PiINj1qCbJKoEpJny0FvvO5gRDR5ReT4nn8Ih4m+u77uJjryWf7+o2hDu?=
 =?us-ascii?Q?cXjA9S3s4u+yOF/q2X9MbcEy4pCj/5n3XGUPsCQvP7AY2aKEMJiDFDvOqU56?=
 =?us-ascii?Q?+04A0jEDlkZtybuMsBzRbYli6rWANhcWJR2Hx8cqnmkTv/LNnO/DtmfKt5Qa?=
 =?us-ascii?Q?AM43XcAJIjlYn2OP3aQ3NuAeaVfPy4XCpdgneGgFsqYchZrRx32n5N0Uxxrv?=
 =?us-ascii?Q?/WWxd5O4hUy+j7mUolxvc8PSVDp88pCU/QwR3ZiS9UqGPhhRjWHiNglWmVbn?=
 =?us-ascii?Q?MPMWDyoeGEDRO76Ch4h9dVaaRkaQY3/uMjGeHkBgK3ebzQR9+zbtYeY2e5ma?=
 =?us-ascii?Q?vpWdhy4HBhDoa94u+VTR1VoJ7beoYPN4iQjOMK01URmgUjp1S2Wbxjlqmr2Z?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d5a414-4b2c-459d-bec9-08daed914dc0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 13:49:15.7802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhZ0owdm20UaIc/tT7BqpzcnRiYpzfjfxn9dcPGIwjAZWNiBRp2sJLF3TvedUTK+dVTODtji44BLA8smfR5i1Oq8aUGQBJyHMrqkZjXEtho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6272
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the USB serial console device ID for Siemens SCALANCE LPE-9000
which have a USB port for their serial console.

Signed-off-by: Michael Adler <michael.adler@siemens.com>
---
 drivers/usb/serial/cp210x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 67372acc2352..832ad592b7ef 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -60,6 +60,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x0846, 0x1100) }, /* NetGear Managed Switch M4100 series, M5300 series, M7100 series */
 	{ USB_DEVICE(0x08e6, 0x5501) }, /* Gemalto Prox-PU/CU contactless smartcard reader */
 	{ USB_DEVICE(0x08FD, 0x000A) }, /* Digianswer A/S , ZigBee/802.15.4 MAC Device */
+	{ USB_DEVICE(0x0908, 0x0070) }, /* Siemens SCALANCE LPE-9000 USB Serial Console */
 	{ USB_DEVICE(0x0908, 0x01FF) }, /* Siemens RUGGEDCOM USB Serial Console */
 	{ USB_DEVICE(0x0988, 0x0578) }, /* Teraoka AD2000 */
 	{ USB_DEVICE(0x0B00, 0x3070) }, /* Ingenico 3070 */
-- 
2.39.0

