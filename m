Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8F07457FE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjGCJFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjGCJFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:05:17 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2114.outbound.protection.outlook.com [40.107.117.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEFEE43;
        Mon,  3 Jul 2023 02:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFLleYF0J0R6KacPulnEj3+MtwbMNuQWdn+BcosqFoyGuW5aXANVtwTmANPfJ7TDQu9d34QcaBsM0V+AwggnYfGToX1yfFl6L7TWIXsA5jIMr6Z9MnyEYkr5xd8Z9NHjSsi8iJSQ6e+2p7q3YPjGoAun8l5faJarsMx7Y6xXOUIECllPZcPE5c5xQ4CQv2d6yVwSGS8nk+tyOm4RLm7ztNych0RZELg2lKSwWvToS7Zb9wm1e19KD2K0syZB/e8fjr5XeSFmOEYwi57YWp56PadKVNF3SGK8aoySYS+JtWQFese7FYFvWO6PeOgOdZy9MvvhMu1+7W7JAoKhXlt/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csZfkdHrHMpJmVGWyQNG7mFt5Qs5fq/20hx9DDm9Hos=;
 b=b06mgmvs0d1B/itJONZ3SFR5SZZNYh+IRk2c3BVDD8mqc1OpPonIqtNs7xlTBKy7jkiYI8TyQSthf0oiKmmx/lZVagNrMHV18eLy8h1ONSU5sZ0aCrHVJGFyrOgyzB3/cGKDD7v/P6BtYVXwXPzNubANJrSJXcbG+GUUmxrl9WntRM1LMlhcBuO2dBEV7Tfhlpr6so+dLazOgJGpbEnpT5vcf3wIkZX457ANfB9ZOseEApZej8nS+Rrqpiki+g2S/Tlwz7LhRVAvHTC7yPCKCiGKBOWXLqS2E43X4VWrSJw9/2nNvFZCu4/QvlZ8+G+0g4DyIC207Xl9VuZYHpVFQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csZfkdHrHMpJmVGWyQNG7mFt5Qs5fq/20hx9DDm9Hos=;
 b=V3PY19hP5/bhwLyHu7GKQRiVGe7O7VZKIE0DzojWb7BiZYDtAhTyQHvIOFD8smRbzYJR0h68O3n28KyS6ZCWgYF748fi4eOddiExNv6zITWzCkjHBiR4JLOnjjTl0LdYdc/9x3QDEuqIh4RyBHn0bCT2aQdE6RFgxcfdS63zVyfX5XX7vJsVfFXFjdmDEZ3o2FDABnOT4OKV/6HFNRwxyOmtu/LtvHT3aRVX+mxrsNxfEQXEeiKZ8HZmYrczG0U4vr1kNlSdrfPMD2dYKcqUYN2plFZwR+gK0PnvNoHa0Xm+y3Swm67fLDLX6tqWwF0nf027Ru17L44IxhPZLQRYsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5850.apcprd06.prod.outlook.com (2603:1096:301:fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 09:05:12 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 09:05:12 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, tglx@linutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, frank.li@vivo.com, wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 1/5] genirq/devres: Add devm_request_threaded_irq_emsg()
Date:   Mon,  3 Jul 2023 17:04:50 +0800
Message-Id: <20230703090455.62101-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230703090455.62101-1-frank.li@vivo.com>
References: <20230703090455.62101-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: 939e675a-b1de-488c-add5-08db7ba49bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYV4QM9pDQWhWsiJzBRz15tR7VpTwoXvFvthBMjbHqZhLQaPjibCtUu+ZMHWzeXghBOlJCGqGSdc4Dt66fXGFcR1tH3oayGNyZY/OP2y6TOt60Mm240ZLSZztk4g/CtjuCnbpZtZQLAbM2XIa3FsJoArIAnA74TvBMPoVc1L95swsDDNis5n4YLYaZ5WClkcEiS0BHDSRaeq0qmqQ1EvmNRkRDltNVz0M/S/zRwUGn17Lz00dBjcFhnHzJ96zouwaWYBIErtcSAUOV3ZTuAN2/9Bc84CkIAiqL8Sk9s1W89MB/DJmsPt+ukOLGVwddNGZv3E9sZdmXNENsOzBvExnQBQdaAmwSoOdOGqkznHvyq/Q/isXgAuA9MTJsvZprxVObjZP+xVbLkGfqFOANVvTp4A8aKb23FROpqp9ngSRlaWNN3VONyD5gy+2BZdWxLkNeWJhnrkp9wv8TQEpdCXGP/QYo4WE8eo6qxutD6GIsT9SQ2oI/JturMOylvky0EuUIqKT15qUjqvcgPOwWgKWXUCiUg4Pcnjn8jWi7jcAJZjdLA8beATYIhZnDczDWkfa3zJJ9qxPa1iVL6JYIz/DPCXwDPu4lNRFb84ztqpi82Gw/CjKVGK1lOXDeQvTMZ/oV/uFgs7px4GK65+Uh6Yxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(7416002)(36756003)(86362001)(186003)(2616005)(478600001)(26005)(6512007)(6506007)(1076003)(6666004)(6486002)(52116002)(316002)(4326008)(66476007)(66556008)(66946007)(38100700002)(38350700002)(921005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3WQpwtzEUhJ5nTx4Tzokn7G0fG0fFLRYuauXFCfQ+zRwOKQGZoZANU+/GuAt?=
 =?us-ascii?Q?InLW7JPkCHq2Org8JEJd3vdUvNlMCrbjJuPQSVGx0w355MjKgHc/noMlBSoC?=
 =?us-ascii?Q?4S4vgMleQ+dh9n3IycqRrjk/d07Ad9X53yowmUXmEVPEK8m4eeosWhto8Enq?=
 =?us-ascii?Q?o/JFpmNI3RD/HbrBrBnF6WMBf+cqEx2FUZNY3M+yXGLmVKigpZduP+/V8kxN?=
 =?us-ascii?Q?8RAMPDziGcadqfrIxtPXmavzVSSBbzhHvFQ6PbQ3jd3k9BHMLkD6ujSd6/Af?=
 =?us-ascii?Q?8VlHKOTIks+zsywZ7YlVc1/ew/RarJDJs1SX7UH4ab48mNB1/4xkqf/sBtUH?=
 =?us-ascii?Q?TGaY6dqJn9qTkQQWcdhf8hZZHqBRCQb1SIWu9YstMxLQarG7sutiy4OjcINy?=
 =?us-ascii?Q?EbMbUZN/tTg5GqNTJyit3umqJmaynClMmeMePHYEybwBeDtysPVciftZW5rk?=
 =?us-ascii?Q?6XUgoaph+JIj73BrkBhxRhv8TolVBaYz0FNa95dKxgmO2Sq68iO3o4g7AgJz?=
 =?us-ascii?Q?lCx26aC3zG5cak20hZipOG/m2a1UFbHNfmxSz/r4UzQy3n7SBpIBbXhpfcjQ?=
 =?us-ascii?Q?Hht72sTS98nX/I4Giowqw+7MsrfsN8pjf4GKZJ/CscSYTK+tRJT36KhMfkWo?=
 =?us-ascii?Q?5yxxzZ9YU1fhe3j9iClZmmBUOqksIEAfDYycHwktHyXVel/gbOVy4dTdvSuz?=
 =?us-ascii?Q?XujsS1PfISNgMRk8GoKveg9d5AHw5NumefUVXLwBKTZ4XNSdqT6oZ9sfIMAa?=
 =?us-ascii?Q?AyTG2WRnak7KJzImdJ+kOJAT7wW6pswzHO+vwslFImPtS6vGYPT0yEfYQfgA?=
 =?us-ascii?Q?TX8u2pLiVrxvBuJ+ot0Lk4MlMH0R7hPAgOkAyf3eswesk7OOfLv7AMMeNn5y?=
 =?us-ascii?Q?eJB2AKeCUrAleiJ0nivVgdETiHUIW2GvsoDj7P8kuzm/V22WIdGEzELCb8Me?=
 =?us-ascii?Q?tjz5cVbAmzFDadw/FoNr2PC9qPT1qPieOgMrB3n9xYFR68hxAxaAVOehDii6?=
 =?us-ascii?Q?K4s7iNGcY3rJ0tgNJj0+UkqiHdgnxrZyn2RPJKL2/G4BawQTmjynsEG5uoi+?=
 =?us-ascii?Q?9a8HsbWhIe7slidcOMADxKRGh2qxxakqP6jAYLpS4ud8+sZvXnC6RiSffprB?=
 =?us-ascii?Q?YUyso/tkkiPqf8tEKKCUd70VgdKNlZt/lEy1MUT3SZFoSaLmy8I97hmrsbRW?=
 =?us-ascii?Q?o++xZrfaNu1BO1IBs68DYU2JR0oLOQD/3GXGNUYAj2nUhtW/o5CB/ncqlT63?=
 =?us-ascii?Q?Qy0h5NlJsqEwdFKSdhXLTfkygzJ2funQHUv0UYF5peLWaExCMBf6lI4Xh5sW?=
 =?us-ascii?Q?rbc+NeNPlDOdDuH2mqE02UXkRMjBifvvS05ZvcjuaS/lf2pr7MJEcX1W3pM+?=
 =?us-ascii?Q?zlxHdhk6iljmuh7LL+W8VS+uFHdrKTGxfpnmr1+10rS7a3Cw+k0Kz7+DT2rN?=
 =?us-ascii?Q?WGGpiHWY10tiqpq6HMvYe++WKfrr3SrqqxMNSTiBrNfyGieGAUPiPwEK1EPX?=
 =?us-ascii?Q?O4ijCihs9tjMjSvBs6N4hZzBujIhcp1fc/VzR9O1Q3kMmC6iSsiQL76Wwz0z?=
 =?us-ascii?Q?e2oMCe19RGt7IJwyOFiy+I2Me1uUsB28rjE720sx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939e675a-b1de-488c-add5-08db7ba49bcb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 09:05:12.5184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32c+wNU9o3xR85LqHZFsLg4P0BXzvlk84uVlv45dzVUAAXx8lG0p5zJblo1Zzo+eKmRFR6XUaTcI6C3v97TWmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5850
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more than 700 calls to the devm_request_threaded_irq method.
Most drivers only request one interrupt resource, and these error
messages are basically the same. If error messages are printed
everywhere, more than 1000 lines of code can be saved by removing the
msg in the driver.

And tglx point out that:

  If we actually look at the call sites of
  devm_request_threaded_irq() then the vast majority of them print more or
  less lousy error messages. A quick grep/sed/awk/sort/uniq revealed

     519 messages total (there are probably more)

     352 unique messages

     323 unique messages after lower casing

         Those 323 are mostly just variants of the same patterns with
         slight modifications in formatting and information provided.

     186 of these messages do not deliver any useful information,
         e.g. "no irq", "

     The most useful one of all is: "could request wakeup irq: %d"

  So there is certainly an argument to be made that this particular
  function should print a well formatted and informative error message.

  It's not a general allocator like kmalloc(). It's specialized and in the
  vast majority of cases failing to request the interrupt causes the
  device probe to fail. So having proper and consistent information why
  the device cannot be used _is_ useful.

So add devm_request_threaded_irq_emsg(), which ensure that all error
handling branches print error information. In this way, when this function
fails, the upper-layer functions can directly return an error code without
missing debugging information. Otherwise, the error message will be
printed redundantly or missing.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 include/linux/interrupt.h |  6 ++++++
 kernel/irq/devres.c       | 42 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a92bce40b04b..cde034006e3e 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -201,6 +201,12 @@ extern void free_percpu_nmi(unsigned int irq, void __percpu *percpu_dev_id);
 
 struct device;
 
+extern int __must_check
+devm_request_threaded_irq_emsg(struct device *dev, unsigned int irq,
+			      irq_handler_t handler, irq_handler_t thread_fn,
+			      unsigned long irqflags, const char *devname,
+			      void *dev_id, const char *emsg);
+
 extern int __must_check
 devm_request_threaded_irq(struct device *dev, unsigned int irq,
 			  irq_handler_t handler, irq_handler_t thread_fn,
diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index f6e5515ee077..f2e669ccd5d4 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -79,6 +79,48 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
 }
 EXPORT_SYMBOL(devm_request_threaded_irq);
 
+/**
+ *	devm_request_threaded_irq_emsg - allocate an interrupt line for a managed device
+ *	@dev: device to request interrupt for
+ *	@irq: Interrupt line to allocate
+ *	@handler: Function to be called when the IRQ occurs
+ *	@thread_fn: function to be called in a threaded interrupt context. NULL
+ *		    for devices which handle everything in @handler
+ *	@irqflags: Interrupt type flags
+ *	@devname: An ascii name for the claiming device, dev_name(dev) if NULL
+ *	@dev_id: A cookie passed back to the handler function
+ *	@emsg: Optional additional error log
+ *
+ *	This is a variant of the devm_request_threaded_irq function.
+ *	It will print an error message by default when the request fails,
+ *	and the consumer can add a special error msg.
+ *
+ *	Except for the extra @dev argument, this function takes the
+ *	same arguments and performs the same function as
+ *	request_threaded_irq().  IRQs requested with this function will be
+ *	automatically freed on driver detach.
+ *
+ *	If an IRQ allocated with this function needs to be freed
+ *	separately, devm_free_irq() must be used.
+ */
+int devm_request_threaded_irq_emsg(struct device *dev, unsigned int irq,
+				   irq_handler_t handler, irq_handler_t thread_fn,
+				   unsigned long irqflags, const char *devname,
+				   void *dev_id, const char *emsg)
+{
+	int rc;
+
+	rc = devm_request_threaded_irq(dev, irq, handler, NULL, irqflags,
+				       devname, dev_id);
+	if (rc && rc != -EPROBE_DEFER) {
+		dev_err(dev, "Failed to request %sinterrupt %u %s %s: %pe\n",
+			thread_fn ? "threaded " : "", irq, devname ? : dev_name(dev),
+			emsg ? : "", ERR_PTR(rc));
+	}
+	return rc;
+}
+EXPORT_SYMBOL(devm_request_threaded_irq_emsg);
+
 /**
  *	devm_request_any_context_irq - allocate an interrupt line for a managed device
  *	@dev: device to request interrupt for
-- 
2.39.0

