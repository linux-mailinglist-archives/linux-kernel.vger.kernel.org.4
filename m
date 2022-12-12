Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D320464AA61
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiLLWgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiLLWgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:36:20 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2127.outbound.protection.outlook.com [40.107.21.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9435514D22
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:36:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0t4i3sjOWmPYlAys7q46PeS835Yi5RPLqANrKV614XHJ7QpSwhUexhwB6glQlIxtHOGsSfG0f9bSdFOBGYarOWFOHdIZVsxYmrpSJWgm5tECpSwF07pKQth0V74cVViPeKgAuF/SZdOIrfteim1e7W/qlAG+EkC6lc4weyuc0ijLlGjeJPiJA66tq5Tmy3XK1MpENrZ/TKS/Zk99++ZlrqGuBr+lOA5r6ZIChCl1G9mIwlKMAAhjzIGFLAnA5NuHFWTqKJoXlY/rasaNytifJG0U4i6CVluu7P5VXngOmjxJhIQnFkyjRsXmBI0mCpE2z6LCG1A5VIJ2lnarPFQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xg8oSwkP6YhLzQsk4Ameh5fiBn8hnqqh435JSW4uy64=;
 b=Rkos9N83/daCL4HAMwY7I68oVDCFfGDCfTY1A28h6IBQ4FGXU5aZrZpbqOm7AljSU0d5Ll/aA/nixCjRH6lm05jjjHbfZb1jeov+P5UokGtAmfWiyS3DZmrWDtbnL4NDPbihIFYH9yCKS2amhOXWmem4VehrE6N7ZrkZrdMkIrG2z+Y3zXxmCz4N0XdXXzbW3OB1sCAkZC5Kt2502Sjc6tC7C+DMsPk1Zy6leToDBi5jCAZJ6EVRX/7oy/gwyTSuEILQA1SuxYLLS+zL0DyBiK1OpxCGRnaN+G6PyzX38eF3gTL5zWid9bgcL1VH1IWEIZ0haAGdxec1IZvYeQ5pfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xg8oSwkP6YhLzQsk4Ameh5fiBn8hnqqh435JSW4uy64=;
 b=jA3cAw5eVcRIYG6drvv9yaZ7S1EH4W7CjUZqsB5tDUr7hftdBeEFc/9im5dOyopllURq7dbT3wsmoWQSH6kmqvBFeCX+5nX0SCvutMavadWOdbfe4/kN0uHmUcjCSiLB2ujBTyXuoCl03B1hFH2YAUr0lLanFIcetmL9tv9hBwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AS2PR02MB9320.eurprd02.prod.outlook.com (2603:10a6:20b:578::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Mon, 12 Dec
 2022 22:36:15 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::a30:dce8:eaa4:7687]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::a30:dce8:eaa4:7687%4]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 22:36:15 +0000
Message-ID: <30cd9157-1850-b17f-bfd5-4c378990b81b@axentia.se>
Date:   Mon, 12 Dec 2022 23:36:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Auchter <michael.auchter@ni.com>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH v2] extcon: usbc-tusb320: make sure the state is initialized
 on probe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0031.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::19) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|AS2PR02MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd1fad5-c6ea-42be-675a-08dadc91475d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6wPfPijLnjiOquxP+rWPNEswMH9nDU3Nn/tvUUUlu+0KhKnrUf2uFn9daSLzXXKNJHz8k9pKkJ6oOLRcpZ0dcB1WTf22VuZmnfAqo0Tj39bCgqRcnBvgzdFcjabJleE4j+muz/xSzui1vWgvCYbWRL3i86600YzUDQnwhUjXJzuhzZ1Jg2ke20yjiP1EJw+NR96W2scjoFK/clevH9/h0Fy1stqEgHQP8uKvxI6VQ7v+oYbgA1Rp2edLcq0pDOKNoc2ep1Tus94aWDgftMjM29oBXm8CkaNiFBVZMF3Hi+ISxVcaR8S8q/tFF0OtfEJKevnHbv/qOfUyHs7HNoyZ9+CV3NaijGSLx930JqU6MXfdxFf45dKhZMKzChNIc/14vi8FAFqUlINw3sSyaF82l6S3NdlFpPTPp/Uyqq/pXvjyKF/pE0l/zQHkYqmd5w2NwH0wgCE1i3wnM4baU7eUZzxK2g2NRogxRE65lyXvW3Z6CKiOrnlE/Bv4XLVlVjsmSsOtq0OZxk1ELwFzd/JhAth+ci0GVVaqMghpAg1SVi9l0oohCPD0RCyQjQ17rfvnobI8Fu1FqluQfRmhBftDKflsQwZOmeQMlS/dL7A5MJvNcKJpom9+qbZzZJkkpN4sGmi4aWnxqZHEhP6XXCALzOaLg9R22mJwr9JoC09XsF7/J/UJSD+E61CKuSDkuYW+/4dOLID9H/TeVD5Weh3adLvk0tEParQrp4SWXgS4943QZ1YUe6bj2JxgegIKlFOr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39840400004)(366004)(136003)(346002)(451199015)(5660300002)(2906002)(83380400001)(41300700001)(8936002)(186003)(31696002)(86362001)(38100700002)(36756003)(26005)(6512007)(6486002)(478600001)(966005)(316002)(6916009)(54906003)(6506007)(31686004)(66476007)(4326008)(8676002)(66556008)(66946007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THlEbGVaR0tzd1hxTmY0cWhlS0VITHJzVUpEaHVZc3FySzI4ZDZJWHFHZ1Ji?=
 =?utf-8?B?U0FpeWw5SnVWdHNvRkxrOXVDd3FvQTZIY0RlaDVGREFCa0hIQmljODd5WWUz?=
 =?utf-8?B?cDAyWHZKRE1TSlF6SWdReWdmYTNsTUR3SkpWRzUwTHN0NC9LUnNhUVVnZ1Zq?=
 =?utf-8?B?ajI0NHZGRHFIa25keEVEcmJTck1nNHZhWnRhVnpLSUM3UnlpNEhDN001WDdo?=
 =?utf-8?B?UzNsMldWNVFmRVhqb05aV3B5Y2o0NDhrcGZVajdKWmZ3QzlIUXNlYjlNeW5u?=
 =?utf-8?B?Y3Z1emNFaGllcXhjZzRmTno2MGdSNEFSN0FvaGdHS3I4dDlmNFF4d3RmSWhP?=
 =?utf-8?B?VE9BcVJmdWdJc2R3aG0zZ25vQVh3dk5sUXVVMEJoMzZtNHZ2RXlRODMrTVhK?=
 =?utf-8?B?TFBBcWM5cS96TlJORmdXZG10SHZmb2JWU1NoQmJjN25VeEtlVVBlckVLTEpV?=
 =?utf-8?B?WDV3dWNxNGZuZHFqL2hNWmR0RzhYMDM0MWcveEdMdWlqL2pWMzJJVHUreFg0?=
 =?utf-8?B?SzJuTG5zYkJySXVyanhCU2NhL1hmVmUzYWFpWjBMZ056TW1kbUZ4c1pnTTc0?=
 =?utf-8?B?ejVJVzZFZWFpbjNIczFaR0RoYmJGL3BtN0RNTDh0VEZwWVBNNjZpbFlsN0Qw?=
 =?utf-8?B?VkdYWjIxamFLMmZhalNkRU8zdFIwRHR2YjF5cmdVMGRsOWJjVStJbnVqTDRK?=
 =?utf-8?B?Y0E4WVdqOUJTL0w3NzU0TFJuWncwSjB0TXdPRWpFNFJ3c1ZsdnIzZ0Z4UlEw?=
 =?utf-8?B?RnBJbXMvem10OFl6MDN1aHBOZ2h0Mzg5OTRBbWJNVC9pOXE4WTJZRDZIeU1Q?=
 =?utf-8?B?elJ5MG8wSFBONDRqbVlmTU1wR0x1Um5kb2lrUnEvQmpvUFFtQVlsQ09VdmFl?=
 =?utf-8?B?a2gwbWNBWXBaVEZYMHNHNHN4b0J0VkhkSU9oS1cvM0VTb0M3bDFnbWU1bmZW?=
 =?utf-8?B?TmlsWFJFeUlEYjl5aUlvZjlyNG51RTl6S2xwa2Y1bTVQazFrUG9xVzJ2RUFn?=
 =?utf-8?B?cGozWGhaT2ZNMHh0NDY5Q3RURzMxK3lENmx1b3ZaaVE0em1LekZocUEzTnVJ?=
 =?utf-8?B?NUNPVWprd3I1bjJJdm96N0ZUNU53Z21kVHI1ei80M1ByakVlbDM0V2VtU0RP?=
 =?utf-8?B?SmJYdGtZQUYwUVdmc3E0S3B5cVUyR0NyQWJOT0pyS2xORXFHQU9VOUY4Y25U?=
 =?utf-8?B?b3NJN1k3Z3MwSlVBblQxY1JrdGJBdG0wclc2elBDbjMxZk5SVm5hdzNBWGNN?=
 =?utf-8?B?cnhQeFJweU0waEZGTEJuc3Y1K21oYmtjTllDRGFzSnFCd3lDbkpTS243UEpS?=
 =?utf-8?B?UEZTKzFWTzdYM05oRktHOXVST1VUdGthK00wT2JoU1BlVlZhMHcrOVpCTTB2?=
 =?utf-8?B?R1dyZE5laU80QU5tdFBJTHpaMzAyVWo4MW85dUpQUndJcTJYWVFKRWdKcDlO?=
 =?utf-8?B?K0xKOWxhMndPcStzcTBRR1lnSFMwM1pQUHd5VmptbjdQWFVxQ1ZrVkNJc0dD?=
 =?utf-8?B?a3NXeVBrZC8yTWhuSTFndnFQME5CdDhkVlJkdkhrMGU4ZHRiK3A4VjJiZlFv?=
 =?utf-8?B?RjdOMWtIc2JIRC9sSFdqekNiNkdwWEFUNzhvUlBwN25xZlZ6T2hpUnNHNUEz?=
 =?utf-8?B?blpCdVBZTS9DOXpNYXJDb3ZaMUZyWnVsVEp0WDQ5ZktodlNRTDFKNUJvOTFy?=
 =?utf-8?B?aXpUVW5sLzM4QUg5V3RSajJOZmRrYkhoR3ZxVTNWd2I2R1Z6UlpLUWpsY2NR?=
 =?utf-8?B?aVZ6cHZ3VC9LZ1pnMldIK09YWmZ5MGNCK0ZoTjVodkF4Y2xHTEpjM1MwQk81?=
 =?utf-8?B?M2dOMjFxOHYyUmd0MHFGNmtjemY1T2NENjcyd2xMNGZUMHQrQnZtNHl5cG45?=
 =?utf-8?B?cmRQT1piYVc5V3l1ZjEzdmRCMGV0RHJERVZjUXFtQ1NBNXdNZUtPdmU0Z3Uz?=
 =?utf-8?B?T1VZdS9TU1RQZVEwQkplOUxjbUV1dWl3SU5RZlRjcm41QTViQ2t4TXpIV0ZZ?=
 =?utf-8?B?K1hwbXlPVmRMaHdiMmFoVlNyMDdIcmxJejRXQ2JUeDJQdG91VTNVdzJVNk1l?=
 =?utf-8?B?RE9FTEZZOXY1STVUeWlTcDd3MzcyVDdqQnF2NFUwZUJhOWpnMWptOVdiYmdX?=
 =?utf-8?Q?j4LPrtiDzWf4nyRLp7TpL9vUm?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd1fad5-c6ea-42be-675a-08dadc91475d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 22:36:15.3737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgt7yWuXi0yeTW+xKy4xX4SVUOK1/oYgqf1+TIVLADbKnssHYftMqPVyqFwBkX4G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9320
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the port is connected at boot, there is not necessarily
an interrupt flagged in the interrupt status register, causing
the IRQ handler to bail out early without reading the state when
it is invoked directly from probe.

Add a flag that overrides the interrupt status register and reads
the state regardless during probe.

Fixes: 06bc4ca115cd ("extcon: Add driver for TI TUSB320")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/extcon/extcon-usbc-tusb320.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Hi!

This is basically a resend of v1, the patch has simply been adapted
to fit after the driver changes for type-c support.

Version 1 of the patch, with its brief "discussion", is here:
https://lore.kernel.org/lkml/ab1ad93b-4d39-8863-9704-da779fc4c426@axentia.se/

I cannot see how the patch can possibly affect detection of connector
changes *after* 'priv->initialized = true', so the comment from Chanwoo
Choi is still a mystery to me. The patch is about what happens *before*
'priv->initialized = true', i.e. when the IRQ handler is called directly
during probe. There is no change in behavior after the statement
'priv->initialized = true', and IRQs are handled exactly as before once
past that point.

Please look at this patch again.

Cheers,
Peter

diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
index 2a120d8d3c27..dc586e5e3c65 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -78,6 +78,7 @@ struct tusb320_priv {
 	struct typec_capability	cap;
 	enum typec_port_type port_type;
 	enum typec_pwr_opmode pwr_opmode;
+	bool initialized;
 };
 
 static const char * const tusb_attached_states[] = {
@@ -323,7 +324,7 @@ static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
-	if (!(reg & TUSB320_REG9_INTERRUPT_STATUS))
+	if (priv->initialized && !(reg & TUSB320_REG9_INTERRUPT_STATUS))
 		return IRQ_NONE;
 
 	tusb320_extcon_irq_handler(priv, reg);
@@ -479,6 +480,8 @@ static int tusb320_probe(struct i2c_client *client,
 		 */
 		tusb320_irq_handler(client->irq, priv);
 
+	priv->initialized = true;
+
 	ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
 					tusb320_irq_handler,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-- 
2.20.1
