Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5711710D15
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241150AbjEYNRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEYNQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:16:59 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ED999;
        Thu, 25 May 2023 06:16:57 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4QRpVY2Z02z49Q1p;
        Thu, 25 May 2023 16:16:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1685020615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QuDv2Ny6oiXp6mURnH5jCu7g32h4l4gFdh/PW9rVbWg=;
        b=djdATiB+3N2aqZ9qfQ9DlY+GZgKf2aYffJo60RS0r2Z0LqWl/4ElwnD9qepe90C6WR9Byt
        AmNI9/2vbbmOdoGEfPJ8fKTDyW3VJRxnt20TWlhIe84gizBj02l/HZjSVTnHCXftkPH21C
        0ngSw2vfSkrZD7fDCKYYjORBDxZ1UtE+9DRHacj2yYAhl/2Y4SK50eenkcj4MB4gB1urc5
        mtuPfZxad/7oft8rXo121X+ExqQMi1w6QEVpLUokt+4APZoup62uZsnURXwNiF/7HzX2SK
        YROnnzkWN9Qhy1oOlDriGzXhw9hkdQZgq4QkluZbqTMWPHXsVNQMj7IugpO4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1685020615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QuDv2Ny6oiXp6mURnH5jCu7g32h4l4gFdh/PW9rVbWg=;
        b=hL0zQlYJz7XX0zlvdcV7ikpLw5AwNX/RpOePcNkHvuJswg/6yw3VOxx+fB6o2FBF9UpWeQ
        tLcCzWfaWdCwNWSD/zYLLWwwVyyRQsaYA7t/O0T6PRiWxvsGIZnz2cu6YtCDI6iCrkNDoo
        ZoujwEahakAOmnl9timaBuuKGFT32vII/yhiXAFMQZLCKs1LOOLcvr8MMGLU03wjV5NOZb
        fPCMyQTHc1Uf2dVTB3aqo5CFrLuNdHLiGE4b9HGEMJaFfMnUgaGo84wjg83ostJkuZRh37
        rmQDjQ6sOsvpFuDT5Fj7fXp3sMffyYGksGc/1hKyiSU4nKziu1sEEzi1yxGMfg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1685020615; a=rsa-sha256;
        cv=none;
        b=faHfmXhMomZ3Zfka9zPvHXkwv3PuqU1A2WCv/dGIN8H0qrVGPafjeaMQZ4oxGFecemUMK+
        CteyIiEMmmbM9Et0XApNacDOhTOoOTA2zvO9EDkaSN2j1u1ka9q/L6SSH/1wwfhRgi2wGb
        OQfuD01dN6NtmNjqhad/lpGSEi6pbnvl9KAytiTjy+sSHsWowPstWk1gNcjj6ixaL2g+sK
        9ogwMgSLx3lFzAtOkTacAahWWks2XKhxctYOqCXLc8WSQK23YBLrjG2lldlkm7a2nG1BBc
        rVyhTSmjCkZHl3t+NNEiaKolZcmBXqsofHMgmFnXSq5/SzqK27p9M7s4whjfdA==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 9B802634C91;
        Thu, 25 May 2023 16:16:52 +0300 (EEST)
Date:   Thu, 25 May 2023 16:16:52 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joe Tessler <jrt@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-rockchip@lists.infradead.org,
        oushixiong <oushixiong@kylinos.cn>
Subject: Re: [PATCH 20/28] media: platform: jpeg: always reference OF data
Message-ID: <ZG9fxF/JoVXXm/zy@valkosipuli.retiisi.eu>
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
 <20230312131318.351173-20-krzysztof.kozlowski@linaro.org>
 <86431868-488b-4a72-944b-231b6d0382b0@app.fastmail.com>
 <8b7816b0-1daa-1c49-6f9d-40769d228a39@linaro.org>
 <b9342459-efec-4e17-aee6-332ee17f44d2@app.fastmail.com>
 <676cb6ac-84a3-025f-bb05-55dd27c365fe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <676cb6ac-84a3-025f-bb05-55dd27c365fe@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 09:26:29AM +0100, Krzysztof Kozlowski wrote:
> On 21/03/2023 09:24, Arnd Bergmann wrote:
> > On Tue, Mar 21, 2023, at 09:21, Krzysztof Kozlowski wrote:
> >> On 21/03/2023 09:11, Arnd Bergmann wrote:
> >>> On Sun, Mar 12, 2023, at 14:13, Krzysztof Kozlowski wrote:
> >>>> The driver can match only via the DT table so the table should be always
> >>>> used and the of_match_ptr does not have any sense (this also allows ACPI
> >>>> matching via PRP0001, even though it might not be relevant here).  This
> >>>> also fixes !CONFIG_OF error:
> >>>>
> >>>>   drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1890:38: error: 
> >>>> ‘mtk8195_jpegdec_drvdata’ defined but not used 
> >>>> [-Werror=unused-const-variable=]
> >>>>
> >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>
> >>> I see now that we both submitted the same patch, but now Hans
> >>
> >> We as you and me? I cannot find your patch on lore:
> >> https://lore.kernel.org/all/?q=f%3Aarnd%40arndb.de
> > 
> > This is the one that I sent back in January:
> > 
> > https://lore.kernel.org/all/20230117172644.3044265-1-arnd@kernel.org
> 
> Uh, that's from January! It's still waiting in Patchwork:
> https://patchwork.linuxtv.org/project/linux-media/patch/20230117172644.3044265-1-arnd@kernel.org/

Yes... this still makes sense, to remove of_match_ptr(). I rebased this,
resulting in:

From 230cfaabcd2d5a5f0bc74e113fe84f95028bcdc5 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 12 Mar 2023 14:13:10 +0100
Subject: [PATCH v2 20/28] media: platform: jpeg: always reference OF data

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
[Sakari Ailus: Rebased on media tree master, reword commit message.]
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 0051f372a66cf..8bcbaa9658bac 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1866,7 +1866,6 @@ static const struct dev_pm_ops mtk_jpeg_pm_ops = {
 	SET_RUNTIME_PM_OPS(mtk_jpeg_pm_suspend, mtk_jpeg_pm_resume, NULL)
 };
 
-#if defined(CONFIG_OF)
 static const struct mtk_jpeg_variant mt8173_jpeg_drvdata = {
 	.clks = mt8173_jpeg_dec_clocks,
 	.num_clks = ARRAY_SIZE(mt8173_jpeg_dec_clocks),
@@ -1949,14 +1948,13 @@ static const struct of_device_id mtk_jpeg_match[] = {
 };
 
 MODULE_DEVICE_TABLE(of, mtk_jpeg_match);
-#endif
 
 static struct platform_driver mtk_jpeg_driver = {
 	.probe = mtk_jpeg_probe,
 	.remove_new = mtk_jpeg_remove,
 	.driver = {
 		.name           = MTK_JPEG_NAME,
-		.of_match_table = of_match_ptr(mtk_jpeg_match),
+		.of_match_table = mtk_jpeg_match,
 		.pm             = &mtk_jpeg_pm_ops,
 	},
 };
-- 
2.30.2

-- 
Sakari Ailus
