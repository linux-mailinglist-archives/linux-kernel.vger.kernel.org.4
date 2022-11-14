Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFEF6273D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 01:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbiKNAWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 19:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKNAWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 19:22:16 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1378060FA;
        Sun, 13 Nov 2022 16:22:16 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 909333200902;
        Sun, 13 Nov 2022 19:22:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 13 Nov 2022 19:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1668385334; x=
        1668471734; bh=IDAP2us2DsDsssmDKA04JGHmo1I0e3EiZIrt3EYB0Lg=; b=W
        b93L8NQbv94Vh9dsG+G0UsEY00YQ7VB0KMD1CpUzJQy6joCIRAM2m5xsFGgTgoIE
        CL+RuX2pJdAm28uw17U3M4BlC60BaRUCaX2zg//4hB2ZqKzM4b3rau31dIyHOrRz
        4g14LrtzcM67yjo8neakEXfrqn6AcuQo8ikZh/6x4FjyM18iL/YqHydcuagc+yXp
        qx0g4aBEkudmwMB1Jz+9uK33C4nBg9FtBE0e1Wzb98HoHpmToUcOyg1SYJ/gz6Au
        fr1tnrMSJ3g/KywIwTmR+8jTds4DZLtKyzVif5wfwMfLzNke9a+mIDp3wg78aHSF
        no1jrLiW0upFwn3K7tGxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668385334; x=
        1668471734; bh=IDAP2us2DsDsssmDKA04JGHmo1I0e3EiZIrt3EYB0Lg=; b=W
        21IMqghBkMD8ugqIdWxqsVo2R5JptZFTZgD2KlMbaKwpdS1tph9UNvjeF+2BDLmv
        AJwMEAjzS5/P7wa5zFo+kp3d5N6dO5FUSM8/6WF3KtGeSxAMqaX6TvQpV9/O8Xze
        Am3Z0l+8jQS6Mpsqln1dXdlnTTXJ4oF+cjF7H+N95d3TCsvSKZ/G7oFzESdcFRmK
        AdKtSgvZhMZ7cTv/bm6Lm9VXZMfQ5cD8wYW0fimPitRh66UxICXhSHOu84wtYXvG
        MaCTPFYDK8BXg5HfFdEtFX7QRjiAPyutr1LoyvHkRf8Y/YnWddmEMQb6AwAHy7F9
        L4Z6ulIS2Mj1WZ3uCKR0g==
X-ME-Sender: <xms:NYpxYzXYYcG1he7ZCDAJ1WFDtohq1s40vT31MGDaOZKVYfVEJV0hDw>
    <xme:NYpxY7nIus18lf0nHWcC69hmx6VWwTbqiFu8ZDTxidUYKzVSn-qGRH4as6DQqp0tD
    vY7JDbTq-b6ZJi6MQ>
X-ME-Received: <xmr:NYpxY_YEyti0AGbBuxhQ1lzjmQHROmTUshlihKwGeDXwYJpcu2BCqFGjksTq8_5KFoiiJAlSEgZn_vmxlihg7O13RdLVT-J132kqCd9sDwwrdjrBpz5nvoF6Dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepjeeiieduffehtdejudevieevhfeiveegudfggefgiefhvedtvedv
    vdegteefgfejnecuffhomhgrihhnpehlihhnuhigthhvrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:NYpxY-WMJPqgYIFHC_A5YTsNZuBfnab1ZnNg9ohAMAOFk5gzh5__Ow>
    <xmx:NYpxY9l_hQ3o5oPqVgUBzJEUT7aEfbnyyIUK284IYnGdK9KGR7Q89g>
    <xmx:NYpxY7cBpz1qVEgxWowHa2ooZVrIuDOLKcxrgRs7xirGPyVD8sml9A>
    <xmx:NopxY-iwOqF6ZTf2zuXoTzRpMy7slMkyU0GFqkR-Wm9JYK6QOEqZQQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 19:22:12 -0500 (EST)
Message-ID: <d3ff28f5-0baf-4fb2-b627-442abba88665@sholland.org>
Date:   Sun, 13 Nov 2022 18:22:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221107210208.284261-1-jernej.skrabec@gmail.com>
 <20221107210208.284261-3-jernej.skrabec@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 2/3] media: sunxi: Add H6 deinterlace driver
In-Reply-To: <20221107210208.284261-3-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 15:02, Jernej Skrabec wrote:
> This driver covers H6 deinterlace core, which is marked in vendor driver
> as v2.3. Contrary to older cores, covered by sun8i-di, it doesn't
> support scaling, but it supports iommu and has additional motion
> compensated deinterlacing algorithm.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  MAINTAINERS                                   |    4 +-
>  drivers/media/platform/sunxi/Kconfig          |    1 +
>  drivers/media/platform/sunxi/Makefile         |    1 +
>  .../media/platform/sunxi/sun50i-di/Kconfig    |   15 +
>  .../media/platform/sunxi/sun50i-di/Makefile   |    2 +
>  .../platform/sunxi/sun50i-di/sun50i-di.c      | 1149 +++++++++++++++++
>  .../platform/sunxi/sun50i-di/sun50i-di.h      |  175 +++
>  7 files changed, 1346 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/media/platform/sunxi/sun50i-di/Kconfig
>  create mode 100644 drivers/media/platform/sunxi/sun50i-di/Makefile
>  create mode 100644 drivers/media/platform/sunxi/sun50i-di/sun50i-di.c
>  create mode 100644 drivers/media/platform/sunxi/sun50i-di/sun50i-di.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf0f18502372..df35acab10fc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5781,12 +5781,14 @@ M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
>  S:	Maintained
>  F:	drivers/net/fddi/defza.*
>  
> -DEINTERLACE DRIVERS FOR ALLWINNER H3
> +DEINTERLACE DRIVERS FOR ALLWINNER SOCS
>  M:	Jernej Skrabec <jernej.skrabec@gmail.com>
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
>  T:	git git://linuxtv.org/media_tree.git
> +F:	Documentation/devicetree/bindings/media/allwinner,sun50i-h6-deinterlace.yaml
>  F:	Documentation/devicetree/bindings/media/allwinner,sun8i-h3-deinterlace.yaml

I don't think YAML bindings need to be listed here, since
get_maintainer.pl looks at the maintainers listed inside.

> +F:	drivers/media/platform/sunxi/sun50i-di/
>  F:	drivers/media/platform/sunxi/sun8i-di/
>  
>  DELL LAPTOP DRIVER
> diff --git a/drivers/media/platform/sunxi/Kconfig b/drivers/media/platform/sunxi/Kconfig
> index 2dd15083a1d9..413a79d23625 100644
> --- a/drivers/media/platform/sunxi/Kconfig
> +++ b/drivers/media/platform/sunxi/Kconfig
> @@ -7,4 +7,5 @@ source "drivers/media/platform/sunxi/sun6i-csi/Kconfig"
>  source "drivers/media/platform/sunxi/sun6i-mipi-csi2/Kconfig"
>  source "drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig"
>  source "drivers/media/platform/sunxi/sun8i-di/Kconfig"
> +source "drivers/media/platform/sunxi/sun50i-di/Kconfig"
>  source "drivers/media/platform/sunxi/sun8i-rotate/Kconfig"
> diff --git a/drivers/media/platform/sunxi/Makefile b/drivers/media/platform/sunxi/Makefile
> index 9aa01cb01883..f92927f49f93 100644
> --- a/drivers/media/platform/sunxi/Makefile
> +++ b/drivers/media/platform/sunxi/Makefile
> @@ -5,4 +5,5 @@ obj-y		+= sun6i-csi/
>  obj-y		+= sun6i-mipi-csi2/
>  obj-y		+= sun8i-a83t-mipi-csi2/
>  obj-y		+= sun8i-di/
> +obj-y		+= sun50i-di/
>  obj-y		+= sun8i-rotate/

Would be nice to sort the above three files consistently.

> diff --git a/drivers/media/platform/sunxi/sun50i-di/Kconfig b/drivers/media/platform/sunxi/sun50i-di/Kconfig
> new file mode 100644
> index 000000000000..cc92f5086862
> --- /dev/null
> +++ b/drivers/media/platform/sunxi/sun50i-di/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config VIDEO_SUN50I_DEINTERLACE
> +	tristate "Allwinner Deinterlace v2 driver"
> +	depends on V4L_MEM2MEM_DRIVERS
> +	depends on VIDEO_DEV
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on COMMON_CLK && OF
> +	depends on PM
> +	select VIDEOBUF2_DMA_CONTIG
> +	select V4L2_MEM2MEM_DEV
> +	help
> +	  Support for the Allwinner deinterlace v2 unit found on
> +	  some SoCs, like H6.
> +	  To compile this driver as a module choose m here. The
> +	  module will be called sun50i-di.
> diff --git a/drivers/media/platform/sunxi/sun50i-di/Makefile b/drivers/media/platform/sunxi/sun50i-di/Makefile
> new file mode 100644
> index 000000000000..225b3b808069
> --- /dev/null
> +++ b/drivers/media/platform/sunxi/sun50i-di/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_VIDEO_SUN50I_DEINTERLACE) += sun50i-di.o
> diff --git a/drivers/media/platform/sunxi/sun50i-di/sun50i-di.c b/drivers/media/platform/sunxi/sun50i-di/sun50i-di.c
> new file mode 100644
> index 000000000000..b2e53052c12b
> --- /dev/null
> +++ b/drivers/media/platform/sunxi/sun50i-di/sun50i-di.c
[...]
> +static int deinterlace_runtime_resume(struct device *device)
> +{
> +	struct deinterlace_dev *dev = dev_get_drvdata(device);
> +	int ret;
> +
> +	ret = clk_set_rate_exclusive(dev->mod_clk, 300000000);
> +	if (ret) {
> +		dev_err(dev->dev, "Failed to set exclusive mod clock rate\n");
> +
> +		return ret;
> +	}
> +
> +	ret = reset_control_deassert(dev->rstc);
> +	if (ret) {
> +		dev_err(dev->dev, "Failed to apply reset\n");
> +
> +		return ret;

This should be `goto err_put_exclusive_rate;`. Otherwise,

Acked-by: Samuel Holland <samuel@sholland.org>

Regards,
Samuel

> +	}
> +
> +	ret = clk_prepare_enable(dev->bus_clk);
> +	if (ret) {
> +		dev_err(dev->dev, "Failed to enable bus clock\n");
> +
> +		goto err_assert_reset;
> +	}
> +
> +	ret = clk_prepare_enable(dev->mod_clk);
> +	if (ret) {
> +		dev_err(dev->dev, "Failed to enable mod clock\n");
> +
> +		goto err_disable_bus_clk;
> +	}
> +
> +	ret = clk_prepare_enable(dev->ram_clk);
> +	if (ret) {
> +		dev_err(dev->dev, "Failed to enable ram clock\n");
> +
> +		goto err_disable_mod_clk;
> +	}
> +
> +	deinterlace_init(dev);
> +
> +	return 0;
> +
> +err_disable_mod_clk:
> +	clk_disable_unprepare(dev->mod_clk);
> +err_disable_bus_clk:
> +	clk_disable_unprepare(dev->bus_clk);
> +err_assert_reset:
> +	reset_control_assert(dev->rstc);
> +err_put_exclusive_rate:
> +	clk_rate_exclusive_put(dev->mod_clk);
> +
> +	return ret;
> +}

