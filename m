Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BBA63B9F0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 07:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiK2GqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 01:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiK2Gp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 01:45:59 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2087.outbound.protection.outlook.com [40.107.14.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3954286EE;
        Mon, 28 Nov 2022 22:45:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+M/Yh2gO2aQS8TH1rv7aZv09V78PZTGndPGM3SnbiBunfiRyeoi5+Fdr86THw295p1AXDoVa5l2tYwG1o2p53RhSmSzACDpRg3lwSgUXqo2tNSw6moGK82amY6e9a/xUXKbL9tWJyStlVduQ/fuHPeJlEcjaP1w1wS4KhWzHrbOHcQYjsgd+snfQvzEBLjEANDwKRSOoYt3vjgkukc/6tzNyTfDu8sRkJbwH4pGjAzhSngBSq5lg1jXyqiqYGofVq3+nZK6t9QnRA1zt3B+xX8Jo5r5zPHlPiCrBeAg0wqYVVH3esv/vMqS2Bgd0G/5n6ADyIVoH2yA+xG04rd6gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXIVuJRJhG8u0ZCsKopcTrojv3oMYxClgYiutAfHyc4=;
 b=oCmH2rYlnFu6mBL+pMAfOT+i9g5u4UfKXO0B0OVTX93w44AyBhKZWhKQ+8YGIwJhRdejOANpQy5ViT0w4GPEfqCiL+1B27T/Hk9Pznqov4uIVD3taCs/W+eyqr8LkoUfdBpnqBpPYA3nFTXWQvnr15ARA4YzNlzP/dK8UVE/K68nGEgvcT6r/xFo7EYViHTJGyyNqBl9a+VW1J+BWCCQoRlbn+OIxVuVtlyhZ10KGds8278TELw98M3kSaDCj0zseEUW0mBinpKZ7uHCqBP6uP2hWeFKeIo8IXVOsSsxEubiX1ZiPA+RP+Pw6o5dTQUBIdA6j7k4/J6Alsc4KFrx8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXIVuJRJhG8u0ZCsKopcTrojv3oMYxClgYiutAfHyc4=;
 b=ZIXFi8MdyT72tv7qlb3HdnL0wtjkS4vQImaIq+KiF0rjFCK7hghAF20lDJdiY87uvftcuYg1DMApDoX3zWUkko22O+UOhmsclC2hDeQrn9ZgWg4+qk5XjrNEWxpf7yLalrcN84ZHa1ikhFi5HLFOXbpSUBwecppwVnXf6oyOBwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by AS4PR08MB7685.eurprd08.prod.outlook.com (2603:10a6:20b:504::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Tue, 29 Nov
 2022 06:45:56 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5880.008; Tue, 29 Nov 2022
 06:45:56 +0000
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Gerald Loacker <gerald.loacker@wolfvision.net>
Subject: [PATCH v4 1/3] iio: add struct declaration for iio types
Date:   Tue, 29 Nov 2022 07:45:38 +0100
Message-Id: <20221129064540.3218982-2-gerald.loacker@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221129064540.3218982-1-gerald.loacker@wolfvision.net>
References: <20221129064540.3218982-1-gerald.loacker@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0107.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::36) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|AS4PR08MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c704da6-9068-4d7b-9f22-08dad1d55e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KWi4O3/RzXJ9LZb3kja6TUSCemPS9yJA4m02NPvUj28O0b1dY9y3QKPQXTB9DTn6OzTBNg86COiyr6MyRSpzR4HDLoQcYTmy8nfgc+XMWOFO1EozQFY1/RlWuYYSSTaHmYQXIon9kbNFLW7mZHx+hrLmQdKTt6JAqKia+U1AwtCgykUZUixcXfkOL7qQxYVGw2obBTXEdHcMAJYOthIA8zVvWAuRF8agerWU2QlqY2wZMYA4l3EVFr65c4g8VsVMkFdXuTfBffP5UZzRFCPTm0fE9VgTP/2iDY7P2GgTNbeSmC/uewhqv+5zunL1obvM1oiq9ikr6GTpCl45oZofgcW8deSHoOvoSpph12k678Kr1FAA00fwxB3pVVq4c2sV+nb3FX/jZAP3QWiK37SvTpQqzrIo3qQkY+nyLBA5nSl86vdEObNijxug9QZfn0bnYnUNjWpkrfsTc/7fTR4yj76zUmwMh62chlFmuQjm02A65i7lhjDchayykEZsb97jJpxYsz/lHIAS+r6CRen7z5mpQdtzgw7DmVavV6SJlP3W6M8UWj6qt2ke25YgIRdhbelW58tfhbtJN08Lw1fgn84cdDFrl4m6F4Tfeq/DebTFV+oYetWyouqOH9PiF8QOXbrsSNSg7YWQUXoNqt3Lx3DO50FAUADjyl3aSDyZjWPSQJAFxOGHcsdXJmLvchl0fDf6sYAiT8TWrJv1SqCnIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(346002)(39850400004)(396003)(451199015)(6506007)(6486002)(86362001)(52116002)(478600001)(107886003)(6666004)(36756003)(26005)(316002)(2616005)(41300700001)(8936002)(6512007)(1076003)(54906003)(4744005)(5660300002)(7416002)(44832011)(38350700002)(38100700002)(2906002)(66946007)(66556008)(4326008)(66476007)(8676002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X9c8GiOzzAS20shZaVe+6cVLX+iLkOkow2b6nTFagqL2ns7yr66eRSE43vyU?=
 =?us-ascii?Q?EYOdMlsWMhOV0mPDiYsRVXQ1jtA5s8pV7qipB/sEjJJFXBVzbz1GYmQDHQVh?=
 =?us-ascii?Q?FXJNyxFXCXirM70MDTXndaWcxmffRetH8lwhXuQHha4VditJTecqS5WmZkRt?=
 =?us-ascii?Q?dBVDht5yNWlWDod6zWA5K42WkwYc07UYYA3/SDyE/PJbnG3j7eWJ3EQ669OQ?=
 =?us-ascii?Q?+fFArNyNSrdb1rtrF3D+mLc+tBZ1Nw2NR0Ui4Te05EGFTZM1rIEum/Y8WYk8?=
 =?us-ascii?Q?LOLOm+yXYO9+PPJ/naaQ4Si4kjru4+ngtIFSLbN04YrEwcqNtwoQeGB3CfAd?=
 =?us-ascii?Q?6Phjm1Y35usFvwjfozV8IfPYZhn7qXVBExJWNfZD0RH9Iad8IkMj7ABCOysw?=
 =?us-ascii?Q?iwjg5ov/TLZm+QRAUkBWM2uaMJCnGARD83EkrlQ95blYDF6f4qQ6YYLIVEgx?=
 =?us-ascii?Q?WGZlcM2jKL7tqrbqIqIsDz7MO/ByM4xgP588n5BzOqWFIvvls1qzKAlc5Z5/?=
 =?us-ascii?Q?AX1SCONnhDseiSI7qn4sRRmXkLdkuCeBZ8kZcbQTQCSw4O22KotLRn3+N9dc?=
 =?us-ascii?Q?0gJsj0fMYoPirzVn5miVt2JHaOYBwn6lr40DCjSaO4rwgB2MTpiKx9BwS3pY?=
 =?us-ascii?Q?w4F19WjrmJg0CFxrp2q/BqcOdh+MGeaZqZfnlP8ImtmQrZXPY3mwFMZOGBTa?=
 =?us-ascii?Q?KO+QNetEJafQDQMHrqvW/Gsosz9yickceTb2m53fG0MiIbkUNAORQr2RlAZt?=
 =?us-ascii?Q?gvtSeCX8fzKMU8jpBgMAguOXVCyECtcIWfccKkYydyGGf2g4K6sZYi318Fd5?=
 =?us-ascii?Q?tEpHHb7f72bzbL1OSRBqdnyLO2jRNV/dxAqnjtj73PmSxUaSid7EuZxsAoIx?=
 =?us-ascii?Q?slALBeQkODwkU9bAE8zh0mwfefA6KgYeS2Jx4cjuNSmNSxnFHjqL92gXaghM?=
 =?us-ascii?Q?GRqWXZUnWFmNpeuocnsnRTtsXrRLG16UKHSxz5tebWaxXaTD9PRBhCVBPE/+?=
 =?us-ascii?Q?3KXDS1SVwVq6OC77oTcjkXKBdQq8KQ7MDgJjJdUGPLyV+yLf3Pd7Ca0coXnT?=
 =?us-ascii?Q?nmkF69lJDgnkjOkHkFv1jKub0Z+iZEMllX0NuXVo4wQ2yiresjAs+D5bdl1o?=
 =?us-ascii?Q?U2T9dawUcc+Adk3Xa86vH2y2QFRKM8+osub6FR62tZmcebe3Rmyf3kspwFn1?=
 =?us-ascii?Q?fPwqrsSVbhTOyAcd/mQ45/HhIUBD7H/JVepaMxJxre0bwXu+tGEkA0pFOueP?=
 =?us-ascii?Q?WPWm1YdUgV1FKul7rtSLbOwCu74MbOv1HIfDoDkj+mEakoN4nrLRax850Nbt?=
 =?us-ascii?Q?0ViE3VgPFHtJiv3TiiBQElVR6pbEJpz5BL11PAxxJFbJl80GnRzGAZS5U83N?=
 =?us-ascii?Q?LgGXd4Cf+w7tjw6/p7NrpbwNeirfX+CG2W8gXOEJraNJdAEEWgBEUUKV6d9K?=
 =?us-ascii?Q?t1H8PwTcq7fMurmEdneBELuOYKRvbNYqf/4PXzfBpmKCdqhd7p0qGgusUWW+?=
 =?us-ascii?Q?rbVJeeD4diLgocxbYdxNd6H73WegEbUoOVY6UMnkKGoJ6xnXtj8y6HR6CJYr?=
 =?us-ascii?Q?WHV16VY5jir68get7i6tMQDXBHZHkb51c6ii2Fcpfi2u3rM/yuP1YXFk67+1?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c704da6-9068-4d7b-9f22-08dad1d55e45
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 06:45:56.7769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIjKufc3gpTv+M8SfsSmEPOojaZZOozks26AOCN9r64DK95D/3NYvuyrtzOd59YwBXAKQJCJOk2xqV2ELj2i3ugP8arikKDFJOP7c+hT10k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7685
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add struct for iio type arrays such as IIO_AVAIL_LIST which can be used
instead of int arrays.

Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
---
Changes in v4:
 - Add only struct for IIO_VAL_INT_PLUS_MICRO iio type.

 include/linux/iio/iio.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index f0ec8a5e5a7a..e5101bef50c5 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -381,6 +381,11 @@ s64 iio_get_time_ns(const struct iio_dev *indio_dev);
 
 #define INDIO_MAX_RAW_ELEMENTS		4
 
+struct iio_val_int_plus_micro {
+	int integer;
+	int micro;
+};
+
 struct iio_trigger; /* forward declaration */
 
 /**
-- 
2.37.2

