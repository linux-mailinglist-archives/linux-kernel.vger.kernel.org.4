Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AC765BAD1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 07:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbjACGmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 01:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbjACGlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 01:41:47 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DBDD2F0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 22:41:22 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230103064120epoutp024f3718001ca241576d08ea7019868066~2uVOhw0qk2422324223epoutp02Z
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:41:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230103064120epoutp024f3718001ca241576d08ea7019868066~2uVOhw0qk2422324223epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672728080;
        bh=lDIZB7/G+ylzlsRPmC3u4e8TNdJieudptTdrtvjpWQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pzRhRwJOd1h/ZpN4uBQs7/7fcRGF+NS6VDo3cPnD5ZWu76OIWy/RVHkNYpKfkQlLB
         ekhzEyAzrvuWC7Xi1vjYEmdvqFERkT/TTUJWF0Jqh6gaNWfuoYoi/3Zp+Xe+nz0XLi
         Yg6yWLezZW/19i5BoNz6aHiAVVNDKt4MDv8ZIsuo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230103064119epcas5p48e97da88410f6da913b65b4fe0e0c156~2uVN7t3vG1269212692epcas5p40;
        Tue,  3 Jan 2023 06:41:19 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NmNRc72myz4x9Q7; Tue,  3 Jan
        2023 06:41:16 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.B0.62806.C0EC3B36; Tue,  3 Jan 2023 15:41:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230103045655epcas5p1af06a83208190c471e8cd891ef4760f3~2s6ECyxER2038120381epcas5p1H;
        Tue,  3 Jan 2023 04:56:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230103045655epsmtrp166d4e24859a7083eaa859af9b27e3f1e~2s6EB09ad0134001340epsmtrp1X;
        Tue,  3 Jan 2023 04:56:55 +0000 (GMT)
X-AuditID: b6c32a4a-ea5fa7000000f556-93-63b3ce0c89a4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.94.02211.795B3B36; Tue,  3 Jan 2023 13:56:55 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230103045653epsmtip2a06c8913f72924bd1082a3fdf940f73e~2s6BvY-Oq3211632116epsmtip2R;
        Tue,  3 Jan 2023 04:56:53 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH v2 2/5] ASoC: samsung: i2s: add support for FSD I2S
Date:   Tue,  3 Jan 2023 10:26:10 +0530
Message-Id: <20230103045613.100309-3-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230103045613.100309-1-p.rajanbabu@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmhi7Puc3JBj1PLSwezNvGZnHl4iEm
        i0Obt7JbTH34hM1i/pFzrBZ9Lx4yW3y70sFkcXnXHDaLGef3MVkc3RhssWjrF3aLzl39rBaz
        LuxgtWjde4Td4vCbdlaLDd/XMjoIeGz43MTmsXPWXXaPTas62TzuXNvD5rHv7TI2j74tqxg9
        1m+5yuLxeZNcAEdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKL
        T4CuW2YO0AdKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzU
        EitDAwMjU6DChOyMP6+/shdsV6mY0HmZtYGxW66LkZNDQsBEom/rNkYQW0hgN6PEzVO5XYxc
        QPYnRolD3bOZIZxvjBL/Nl1ghOmYuvUCE0RiL6PEpNMTGCGcViaJqz/7WEGq2ARMJVbNaWQF
        SYgINDFJtL2ZyALiMAtsZJQ4fewhE0iVsICzxP8X29lAbBYBVYnF0y4CxTk4eAVsJc6tUoRY
        Jy+xesMBZhCbU8BO4k8HxGoJgYUcEv8ftDOC1EsIuEj8WMUBUS8s8er4FnYIW0riZX8blJ0v
        Me1jMxuEXSHR9nEDE4RtL3HgyhwWkDHMApoS63fpQ4RlJaaeWgdWwizAJ9H7+wlUOa/Ejnkw
        tqrE+uWboKEiLbHv+l4o20PiR/9mNkigTGSU2DD3K+MERrlZCCsWMDKuYpRMLSjOTU8tNi0w
        yksth8dacn7uJkZwKtXy2sH48MEHvUOMTByMhxglOJiVRHgnvdiULMSbklhZlVqUH19UmpNa
        fIjRFBh8E5mlRJPzgck8ryTe0MTSwMTMzMzE0tjMUEmcN3Xr/GQhgfTEktTs1NSC1CKYPiYO
        TqkGptwJ9wUYovYdizrdtD54ovq8R3M0kx/vCOx11JANjN124OAVwTVxswTbOgQXLGJRPaat
        unb35SkVF9nFJp8w7O2LbMqvW/NK6OLBJZfCfAI2ptft33bn4O3v95qzvr1eJNTzau3PVpsp
        jnXKC3nMd574s+UHd+9kmx9cBV7VlwIjj/rq1eUscnI88VNaYNcWpt6c5fsivY2U5+9SmTQ1
        evqmAkHem+bbvry7mzXLTNVG48zqbUEXpWaVb+XIEvNm1Lj54GqN3nlZ6XOmqn8Xx56dbyWy
        zyrU133bqs+6j9pyErRCQ1P1zpcbvAuttPou1Sd84Kr6K6GX4seybJ+xTJ7UoOQUfurm9dU7
        PJRWsiuxFGckGmoxFxUnAgCOAe3CLgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSvO70rZuTDZ5uVLZ4MG8bm8WVi4eY
        LA5t3spuMfXhEzaL+UfOsVr0vXjIbPHtSgeTxeVdc9gsZpzfx2RxdGOwxaKtX9gtOnf1s1rM
        urCD1aJ17xF2i8Nv2lktNnxfy+gg4LHhcxObx85Zd9k9Nq3qZPO4c20Pm8e+t8vYPPq2rGL0
        WL/lKovH501yARxRXDYpqTmZZalF+nYJXBl/Xn9lL9iuUjGh8zJrA2O3XBcjJ4eEgInE1K0X
        mLoYuTiEBHYzSjzec4odIiEtMb1/DxuELSyx8t9zsLiQQDOTRNfTHBCbTcBUYtWcRlaQZhGB
        CUwSJ98dYwFJMAtsZZSY+tkIxBYWcJb4/2I72CAWAVWJxdMuAm3j4OAVsJU4t0oRYr68xOoN
        B5hBbE4BO4k/HSAHgeyyldje8Il5AiPfAkaGVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5
        uZsYwaGupbmDcfuqD3qHGJk4GA8xSnAwK4nwTnqxKVmINyWxsiq1KD++qDQntfgQozQHi5I4
        74Wuk/FCAumJJanZqakFqUUwWSYOTqkGJj0hRbVpzetY1L/bvfq00Eh4BnuNW2PpzAUX1t7U
        9PzPLy3N8nS1o/V3NqHivQZ5z3kYXx14dyOE4UtQgOEtq2SdyQnzlzxr0PipJff/VGdk75sZ
        TikzXix4uVqD4bF2Z9uth0m51zffmhZz8sjr92KsojP7Cp3fRpfaiZ+PvrBrz6NPnffNtBaa
        db+XMq7M0fRuUl5yNdFRh1Fz2YboY1v0tnhKRnAyztx7/7w2r0JwRl/k1x0XL2/Wmx4gcsni
        1oX6Crv7STnHnW9wb1EUCOnd9/RKc0Vs1deZvxkDomfs2a+YYd5zqve3p0SVd+Q10WsOleUf
        jvOvvju58tnJoPpf+cqJdZotfl5JnxZoK7EUZyQaajEXFScCAIuqD+/kAgAA
X-CMS-MailID: 20230103045655epcas5p1af06a83208190c471e8cd891ef4760f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230103045655epcas5p1af06a83208190c471e8cd891ef4760f3
References: <20230103045613.100309-1-p.rajanbabu@samsung.com>
        <CGME20230103045655epcas5p1af06a83208190c471e8cd891ef4760f3@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for enabling I2S controller on FSD platform.

FSD I2S controller is based on Exynos7 I2S controller, supporting
2CH playback/capture in I2S mode and 7.1CH playback/capture in TDM
mode.

Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 sound/soc/samsung/i2s-regs.h |  1 +
 sound/soc/samsung/i2s.c      | 57 ++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/sound/soc/samsung/i2s-regs.h b/sound/soc/samsung/i2s-regs.h
index b4b5d6053503..4444c857d0c0 100644
--- a/sound/soc/samsung/i2s-regs.h
+++ b/sound/soc/samsung/i2s-regs.h
@@ -132,6 +132,7 @@
 #define EXYNOS7_MOD_RCLK_192FS	7
 
 #define PSR_PSREN		(1 << 15)
+#define PSR_PSVAL(x)		(((x - 1) << 8) & 0x3f00)
 
 #define FIC_TX2COUNT(x)		(((x) >>  24) & 0xf)
 #define FIC_TX1COUNT(x)		(((x) >>  16) & 0xf)
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 9505200f3d11..dcb5c438cb2f 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -50,6 +50,10 @@ struct samsung_i2s_dai_data {
 	u32 quirks;
 	unsigned int pcm_rates;
 	const struct samsung_i2s_variant_regs *i2s_variant_regs;
+	void (*fixup_early)(struct snd_pcm_substream *substream,
+					struct snd_soc_dai *dai);
+	void (*fixup_late)(struct snd_pcm_substream *substream,
+					struct snd_soc_dai *dai);
 };
 
 struct i2s_dai {
@@ -111,6 +115,10 @@ struct samsung_i2s_priv {
 	u32 suspend_i2spsr;
 
 	const struct samsung_i2s_variant_regs *variant_regs;
+	void (*fixup_early)(struct snd_pcm_substream *substream,
+						struct snd_soc_dai *dai);
+	void (*fixup_late)(struct snd_pcm_substream *substream,
+						struct snd_soc_dai *dai);
 	u32 quirks;
 
 	/* The clock provider's data */
@@ -940,6 +948,10 @@ static int i2s_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		pm_runtime_get_sync(dai->dev);
+
+		if (priv->fixup_early)
+			priv->fixup_early(substream, dai);
+
 		spin_lock_irqsave(&priv->lock, flags);
 
 		if (config_setup(i2s)) {
@@ -947,6 +959,13 @@ static int i2s_trigger(struct snd_pcm_substream *substream,
 			return -EINVAL;
 		}
 
+		spin_unlock_irqrestore(&priv->lock, flags);
+
+		if (priv->fixup_late)
+			priv->fixup_late(substream, dai);
+
+		spin_lock_irqsave(&priv->lock, flags);
+
 		if (capture)
 			i2s_rxctrl(i2s, 1);
 		else
@@ -1410,6 +1429,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 	if (np) {
 		priv->quirks = i2s_dai_data->quirks;
+		priv->fixup_early = i2s_dai_data->fixup_early;
+		priv->fixup_late = i2s_dai_data->fixup_late;
 	} else {
 		if (!i2s_pdata) {
 			dev_err(&pdev->dev, "Missing platform data\n");
@@ -1563,6 +1584,31 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 	return 0;
 }
 
+void fsd_i2s_fixup_early(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct i2s_dai *i2s = to_info(asoc_rtd_to_cpu(rtd, 0));
+	struct i2s_dai *other = get_other_dai(i2s);
+
+	if (!is_opened(other)) {
+		i2s_set_sysclk(dai, SAMSUNG_I2S_CDCLK, 192, SND_SOC_CLOCK_OUT);
+		i2s_set_sysclk(dai, SAMSUNG_I2S_OPCLK, 0, MOD_OPCLK_PCLK);
+	}
+}
+
+void fsd_i2s_fixup_late(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
+	struct i2s_dai *i2s = to_info(asoc_rtd_to_cpu(rtd, 0));
+	struct i2s_dai *other = get_other_dai(i2s);
+
+	if (!is_opened(other))
+		writel(PSR_PSVAL(2) | PSR_PSREN, priv->addr + I2SPSR);
+}
+
 static const struct samsung_i2s_variant_regs i2sv3_regs = {
 	.bfs_off = 1,
 	.rfs_off = 3,
@@ -1652,6 +1698,14 @@ static const struct samsung_i2s_dai_data i2sv5_dai_type_i2s1 __maybe_unused = {
 	.i2s_variant_regs = &i2sv5_i2s1_regs,
 };
 
+static const struct samsung_i2s_dai_data fsd_dai_type __maybe_unused = {
+	.quirks = QUIRK_SEC_DAI | QUIRK_NEED_RSTCLR | QUIRK_SUPPORTS_TDM,
+	.pcm_rates = SNDRV_PCM_RATE_8000_192000,
+	.i2s_variant_regs = &i2sv7_regs,
+	.fixup_early = fsd_i2s_fixup_early,
+	.fixup_late = fsd_i2s_fixup_late,
+};
+
 static const struct platform_device_id samsung_i2s_driver_ids[] = {
 	{
 		.name           = "samsung-i2s",
@@ -1678,6 +1732,9 @@ static const struct of_device_id exynos_i2s_match[] = {
 	}, {
 		.compatible = "samsung,exynos7-i2s1",
 		.data = &i2sv5_dai_type_i2s1,
+	}, {
+		.compatible = "tesla,fsd-i2s",
+		.data = &fsd_dai_type,
 	},
 	{},
 };
-- 
2.17.1

