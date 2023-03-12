Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FEE6B66EF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjCLNqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjCLNpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:45:42 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26962DE71;
        Sun, 12 Mar 2023 06:45:21 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-76-21-162-nat.elisa-mobile.fi [85.76.21.162])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 61583814;
        Sun, 12 Mar 2023 14:45:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1678628720;
        bh=HY06FK/X1xlEQwlPSr2Kzwr8PW2ACwPKKPD5WqC75QA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1ehpH7fp4JbHWbhhzQPlMtiBhrLhq19IGwdA4eT5CiPYQLGfhqqE6uowTQ1cQoKN
         o8k4c0qo4RtDpmQYspeuE8frJx2t+XdPQVIYQ/Hl0kfew9thjO6n5KNz95T474iJ/L
         s9weY8G18+gV5eenOHxY4slRjNWsNmx9MWEzjDc4=
Date:   Sun, 12 Mar 2023 15:45:13 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joe Tessler <jrt@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
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
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 27/28] media: i2c: max9286: drop of_match_ptr for ID table
Message-ID: <20230312134513.GD8229@pendragon.ideasonboard.com>
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
 <20230312131318.351173-27-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230312131318.351173-27-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the patch.

On Sun, Mar 12, 2023 at 02:13:17PM +0100, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).  This
> also fixes !CONFIG_OF error:
> 
>   drivers/media/i2c/max9286.c:1707:34: error: ‘max9286_dt_ids’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/max9286.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
> index 701038d6d19b..ed932ff9ec74 100644
> --- a/drivers/media/i2c/max9286.c
> +++ b/drivers/media/i2c/max9286.c
> @@ -1713,7 +1713,7 @@ MODULE_DEVICE_TABLE(of, max9286_dt_ids);
>  static struct i2c_driver max9286_i2c_driver = {
>  	.driver	= {
>  		.name		= "max9286",
> -		.of_match_table	= of_match_ptr(max9286_dt_ids),
> +		.of_match_table	= max9286_dt_ids,
>  	},
>  	.probe_new	= max9286_probe,
>  	.remove		= max9286_remove,

-- 
Regards,

Laurent Pinchart
