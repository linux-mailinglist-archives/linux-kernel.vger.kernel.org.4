Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6069A6F12F8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 10:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345408AbjD1IGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 04:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjD1IGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:06:42 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2124.outbound.protection.outlook.com [40.107.21.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33321FDC;
        Fri, 28 Apr 2023 01:06:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hi6w5jA5Hze+G8+4CkyVPCLBJc7dADfBQMEniXP68+eL5yGAXOyza9Uw8bpN1awymZEV5Y79B/R1QfScXDV5cpONL90KK+GPFrVy1y+q+Lb9n1L32cb/efsEh9MKU6dYzrqVj8uDML7x5URaNiQtS15tBPiau3eph48xWabRxUXW8jBcsrTLSdgnkwF6Qadxt/OCSuWodxrrGkhNWOLg/0SVYCtKtG/0+PVR+Dokri9wvEhBMBpbSFHv+x9EdPBZvYdFYNpcn6rIo2Zw/0cCcLyN6LLUoEJz4WxKJzRpwsbyKWMbZpG7El+yJKUDDsRUOi0VOx6h3/1OMNEl+Byyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7RpJBdrzrb/iV38ELquyFRR+Zu5ClYrwbpu/CsZyHM=;
 b=fd4nkdQ7wOAEi0vHZ44+u/XfQdYfm5wX/y5xZ5+oe6b9p3U+lRwMJ9WBuJnQwV+EQqW9+lE5j8y6HvCaoVjky1DOLRabqScQrPB8z+4vK040mWWDMrYd5TF1vriPqFd9lmR1H3NCeGmiacnR/WRqnuIZK0THOGcuv0CYVs3xb+XaYFqVTs45sNhJ/0aL1kYp5oFt4Ynbw0WscIVY4uJIFYZ1YLGk02hVnscQt1hT6K2bc5osUYDPryb7XV8ByHZChmwnIl11uY+TpOYdkR/pLUupexcPwYMGx4KGm6nHulCoR6AD7oy/JxS4u3QWvZnsLT159EKptJCc2viJ8qRyHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7RpJBdrzrb/iV38ELquyFRR+Zu5ClYrwbpu/CsZyHM=;
 b=O4i/9MHmtg47f0euqiRkN9jicO7rqhYcKXQmfn6B3fmv7NRE9hjH55bX8pZZhfTV79IGCymVUQ9uKhoYgb4K6N6mncoJg5JzVr+jniy4ks1SC3+2ZdUtQAG21aiB2z+mMofy+PHhKLGDoMSD/T+yVyv65FvEGuzIfoSrGV6GyPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AM7PR02MB5814.eurprd02.prod.outlook.com (2603:10a6:20b:108::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 08:06:37 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::3d67:4b0:82d5:1daa]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::3d67:4b0:82d5:1daa%5]) with mapi id 15.20.6340.024; Fri, 28 Apr 2023
 08:06:37 +0000
Message-ID: <32995b53-7f73-936f-a81d-5f1969f64910@axentia.se>
Date:   Fri, 28 Apr 2023 10:06:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: sv-SE, en-US
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH] ARM: dts: at91: tse850: add properties for gpio-line-names
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::14) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|AM7PR02MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5efc92-c2d1-422a-2b34-08db47bf7d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7s1m+wc6Ptko1ofta91T6d0xDIe8P9QTy92/m+9EoIHn4hEk7GzUmqHUirJnHlC+ipwJMtB5ntWQ37SvftDdjhtlfv9oDbNXGdcmmMi9yqN71+yOZRFzT9jpiz2hesYiLtDJVyDuxe6VzsrbKFNT9BFtAkCT6IoMowpUFF2w7ajVbn+91nVI8eV0NLcYl+xOWM2hoO8ToBtOWyNTi3Sa78GyZeH7uA7WWgZEaiHkChvRJcAKIvsjWsnQDCqwTK4Qk42hYOdrkx2XqUGnkq/T6HJlCCjSp4QLcp5YFHUM6cinKkYKmP2bvBL09zyd60suzDNO4SaHJla87mywLdYLoY/WbSK6kpLu8iDpzJU8aV2Tco2d5xU4FrO4FbDra09z2N5v6IFwVDz8OPCZgktDPzIdQVRZ6rO4uJxa4N9PhhkEoSV1txHnzLk978wVT8zNH0WZK1Wzbs8pjsloImt2nQpB/ZR582sEvAyccrALccFI4T9u4hbfvAS1GFttZcftPn/DuzjkTWuFofUs+F3mV7fQIPQ+xdqDf56zNKBwn2Eb9WCjRr7L5rd7vfRs9i5XWkwGbj/IT5CAzauLBBN0+fAfYK7k5lo3+HXdgvuVQzO3cg9w1ZTsD4K4xDI7zkOmnDwtqojbUN2AKV6nQ0zLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(39840400004)(136003)(346002)(451199021)(2616005)(31696002)(86362001)(66476007)(66946007)(66556008)(6916009)(4326008)(478600001)(36756003)(6486002)(186003)(38100700002)(6512007)(6506007)(26005)(54906003)(8676002)(8936002)(41300700001)(5660300002)(31686004)(2906002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2NoSjc3L01xN1VwUENYYWdqOWtxcUJpamFhKzJpN1RQWW1rT3Z1dmhrcUl3?=
 =?utf-8?B?dGxaZVJhUkhMUEkyM0ttNytHcTUzRW9iNE1wc1VJZEtUeDdoMUc2OXRJa3Ru?=
 =?utf-8?B?ZEQrV2xodllrSXpLR05RT3RzQk9IdWpVOG9iZlBEbVZsVG5HeXBrcnJSd3ZP?=
 =?utf-8?B?bjZBcWNxOFU0bVZjcHdtSEJScStwczNSWDQxd3lTbmh3S3RPc21MelNMOURX?=
 =?utf-8?B?T3I0NVdIUkJzRGJtWmMrZ2tGZnExTEpOQ0JaanJBb1JEd2R3L0F6aHp1ZmQ3?=
 =?utf-8?B?cWF0d1dMbVN6QUhVd2hZU1ZhbDZZbUFuVG9Qc3BBOGJrdG9KYzVrOWNHbjNB?=
 =?utf-8?B?K2FXQVQ3NExtKzJrUHc0NDVqYUlXd2Y4dHJrYk93L1ZNY24vWXhWczhuV3ox?=
 =?utf-8?B?N21qMUFaMGFldm9KL1cxL3VYWEFFNk5ianhhRm5lYmxYdUJocmJlWTZzMVlj?=
 =?utf-8?B?dVJuUTBtMjVqME54dUp0L1pOMHM4R3JnYWNKaGR0dEt2WWVSSWVCRENMRzVI?=
 =?utf-8?B?K1BjNm5ad3pCTytIQWlSQ25sRTlkdDJqUExEdEdKc0JhaStqOHp6Q2d5UnhX?=
 =?utf-8?B?SFh4VitnM1FSdXZUL1JDbnQ1VGpFZUtTT1ZTcEVKbnlSaTlqdVBtZUl3Yi9r?=
 =?utf-8?B?L1QyQVRmcVo0N1ZmRnpKK2k1NWI2R1lLS2U4NUFCN1BqVW9qaW5Yc2c1NVlS?=
 =?utf-8?B?V1A3SkFvM2lJRGtvdTNFNk9ENytDclVqTThGdEE4KzVsVUZBUEpHL1R1VElq?=
 =?utf-8?B?SmxQbDdtaHhMS1FaUmVJb2lBVmgvOU8rQTJmSElEYWtZc3AxRkVsWER5aFZ6?=
 =?utf-8?B?LysyM3hTSCtOZjhSNGV5NXBXaUltSE8wZzk4MTVBRzVKRk1LS3dRSWNzdzg2?=
 =?utf-8?B?SWVmUnBCU3lQdjZBRlFiYUgwSVhLQWRTQTc1bXBsRU4rbzc5WWJhbTloY1JY?=
 =?utf-8?B?c1lZMHZiL2dmeVFFaVJLeWpoQlQ0dXBFeDM3NllINHF5dzVVbm9yUzhLWlBs?=
 =?utf-8?B?VEkxY21FTkE2cUc2ZGlkMHlaRUYvcUVlWjBxN3dlMDFjOUM3VTUrRCs1UG9I?=
 =?utf-8?B?S0dXUWZIK2I3aEJEUnBZYXRFM21LSjFvTW9LT1ZmcEZOcWRrVVhWaXNhT2NP?=
 =?utf-8?B?aXF2N0tINWpiTlpuYnFZNmcrdnYrRXJNZjYwbkRGWDNHQTJEV3pRYisrRkJO?=
 =?utf-8?B?WERnTTR0WnA2dStCcDVzamIwaXlXN2l5TUpzam1WVjNucXNkNFhwV3ZURWZq?=
 =?utf-8?B?dGNPMGVLMlQyNWI5dXd3VlZNMDJqL3JRdmM3dW95dVN3Vk11aC8xYk9hODQ1?=
 =?utf-8?B?bHRxdzBQa0h5ckE4TG52RjhCeEtBS1U5Yks5blh0RElGSWdlQmorb3NtMU5l?=
 =?utf-8?B?NFAxME96NC9HeVpjMDRaQi9kQUpEWnViNVpRYXFieXZlRS9QQk1VaG5Rbjl6?=
 =?utf-8?B?N1RxR1JFWDI3VU9TSHVQVkdzVCtaMFlaRy9aclkwby9PUTB0TE9FeGJRQWxL?=
 =?utf-8?B?TFlyVjhlQ1lUUDRlRi9ucU0vY3NRdmM4anlWeGk2M21mY0M0UStMaS9DUFl4?=
 =?utf-8?B?aWx3am9xY1J6UDhZUFNITmVlYThaY3NtRWVVOWJrRitmWTZxRkxFZUFIZW1J?=
 =?utf-8?B?WVloSE9meVdrVVVoRThva3ZqeS9HWFNCMnlvT0xBREVLK3c0QzRSZmQyLzhR?=
 =?utf-8?B?Y2RDTytDYUcrc0M1QzBwZ3crSlFJcWRpSSswUVI1QnllOE0yRFVmVHgvQmx3?=
 =?utf-8?B?bGQxa0s3T2N6aFhicDVmZmFMMXIyaTBvdlFqYzVOb1drYVlXUVI4QU1MYXds?=
 =?utf-8?B?L2pKWVNVajJQcFViNHJzNkZmNWhNQitkSWorNTZNVmJ0d1RWRTJUejlUeCs5?=
 =?utf-8?B?UDZjMnhtczNYckpUenZrVWFFandsYjZGbm9ENksyMnFlcGZyWDN3bHZZOWhK?=
 =?utf-8?B?QS9sQjFzL25GRmZpUEhRbHJaVFRHZlRaR0NOTUpRQjZNL0ltbWhFbDl3KzU5?=
 =?utf-8?B?WGNraTczbzNLRFVyQmdiMk12cHhrWTdGN2dvbUFUYUNFdFFVRklwLzk4YmdF?=
 =?utf-8?B?VDVHUVNGb3cwOENpb1dKM1VDQWhsWUoyQnF2dXc3d3d5TVJ6eXdDQmxMSFhK?=
 =?utf-8?Q?Xvk2SvCepInLgiJUVeRdeurKT?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5efc92-c2d1-422a-2b34-08db47bf7d31
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 08:06:36.9405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oHokgQboiQUF7/trXMxrNt4booX2nJ+kSIFO/dmaPKWYMVVcnhQbXpFKglEgKM+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB5814
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signal names are one-to-one copies from the schematics, except VBUS
which is an unnamed signal there.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91-tse850-3.dts | 60 +++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/at91-tse850-3.dts b/arch/arm/boot/dts/at91-tse850-3.dts
index b99a4fb44a36..13d92797ada6 100644
--- a/arch/arm/boot/dts/at91-tse850-3.dts
+++ b/arch/arm/boot/dts/at91-tse850-3.dts
@@ -300,3 +300,63 @@
 
 	dmas = <0>, <0>;	/*  Do not use DMA for dbgu */
 };
+
+&pioA {
+	gpio-line-names =
+/*  0 */	"SUP-A", "SUP-B", "SUP-C", "SIG<LEV",
+/*  4 */	"", "/RFRST", "", "",
+/*  8 */	"/ADD", "", "/LOOP1", "/LOOP2",
+/* 12 */	"", "", "", "",
+/* 16 */	"LED1GREEN", "LED1RED", "LED2GREEN", "LED2RED",
+/* 20 */	"LED3GREEN", "LED3RED", "LED4GREEN", "LED4RED",
+/* 24 */	"", "", "", "",
+/* 28 */	"", "", "SDA", "SCL";
+};
+
+&pioB {
+	gpio-line-names =
+/*  0 */	"", "", "", "",
+/*  4 */	"", "", "", "",
+/*  8 */	"", "", "", "",
+/* 12 */	"", "", "", "",
+/* 16 */	"", "", "", "",
+/* 20 */	"", "", "", "",
+/* 24 */	"", "", "SIG<LIN", "SIG>LIN",
+/* 28 */	"RXD", "TXD", "BRX", "BTX";
+};
+
+&pioC {
+	gpio-line-names =
+/*  0 */	"ETX0", "ETX1", "ERX0", "ERX1",
+/*  4 */	"ETXEN", "ECRSDV", "ERXER", "EREFCK",
+/*  8 */	"EMDC", "EMDIO", "", "",
+/* 12 */	"", "", "", "/ILIM",
+/* 16 */	"BCK", "LRCK", "DIN", "",
+/* 20 */	"", "", "", "",
+/* 24 */	"", "", "", "",
+/* 28 */	"", "", "", "VBUS";
+};
+
+&pioD {
+	gpio-line-names =
+/*  0 */	"I1", "I2", "O1", "EXTVEN",
+/*  4 */	"", "456KHZ", "VCTRL", "SYNCSEL",
+/*  8 */	"STEREO", "", "", "",
+/* 12 */	"", "", "", "",
+/* 16 */	"", ">LIN", "LIN>", "",
+/* 20 */	"VREFEN", "", "", "",
+/* 24 */	"", "", "VINOK", "",
+/* 28 */	"POEOK", "USBON", "POELOAD", "";
+};
+
+&pioE {
+	gpio-line-names =
+/*  0 */	"", "", "", "",
+/*  4 */	"", "", "", "",
+/*  8 */	"", "", "", "",
+/* 12 */	"", "", "", "",
+/* 16 */	"", "", "", "",
+/* 20 */	"", "ALE", "CLE", "",
+/* 24 */	"", "", "", "",
+/* 28 */	"", "", "", "/ETHINT";
+};
-- 
2.20.1

