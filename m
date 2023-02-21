Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B0A69E999
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBUVi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjBUVi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:38:56 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23DC2DE55;
        Tue, 21 Feb 2023 13:38:25 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cq23so22504172edb.1;
        Tue, 21 Feb 2023 13:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2x4QxJv4nKAQD6nmh3v1P/gvRFcvPZ/+reUMK1IHmk=;
        b=hvcbbxjHy3yfhZZaSoQ20ukzgEnIfEyrMlnC1c8Mj23mZ7Z3onoLj/8XHMhGA9BGdj
         2e55K/WV6r5hQDtRQOvv6Luyw8hQYXkV9vDaxVFsHD77eysOg2nkgkw+/JjpTCkAeFBN
         lznssBgKnma18h7wVh5jhzY5IReazXSbGL9j8s7utXvSkeXZmD8s6kMSM7EcRgZLCYyG
         yYnuxUfUfSGSdRy10QjagUJAF3urpw1t3CZN0Gk6ajP79qxMM1PpbRMsSgckdZqlRUJa
         cllc8OuefC+uCPx2sarqRn+81n7w22uOi37fJj34mGr+UEKjzYlRxX8OQjb0wgqBB63z
         ZHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2x4QxJv4nKAQD6nmh3v1P/gvRFcvPZ/+reUMK1IHmk=;
        b=cGrDUPUYh6tJgtK9uY2LzRprp9wzIpCraYt/681iTtfO+o/0p17YmzY+PiUmDPUUBD
         kHkd/79eWqzVsVVw9q/wQ5ajhrz0/iM720JAmWvkrZrZCjOu5P6BXfxD8V0Oxz9CLYOt
         5UDMWBm26ychWX1vqfj/08n6zjv4176+YLT1c9Q/289E6MGZGf1co5m2fSV9ZW/uONWF
         siRY0iIUyCIKCBhDsMuoMoLXmyBIJ68HasMFrT1/LHo73fQSKHYaxDQyX8TwBc2EVqA8
         VRrF8W71EfsIL79shXLIqy3cVavH/wpfh/MfWVrr2US3v7GOLpx9GDm3/7Ru1wwqytAf
         Y8/g==
X-Gm-Message-State: AO0yUKWi2kvNdDXP89K5xNAVZZLym2lkPP9Xvr5MLW38vhDhE5ZGCrBW
        VugcCQpSzVqlXXxLhuM3jf5ZrWLohA8EG3JZnzA=
X-Google-Smtp-Source: AK7set+WgWx80yG+IPD6BZtc2LM511WxHd/1uNy9RyymaByA5DzDe9ltu/NxF8DAR1dqIEJxGGjio8OxlPTpsYlt4UQ=
X-Received: by 2002:a17:907:3d91:b0:8af:2e89:83df with SMTP id
 he17-20020a1709073d9100b008af2e8983dfmr13559381ejc.6.1677015504149; Tue, 21
 Feb 2023 13:38:24 -0800 (PST)
MIME-Version: 1.0
References: <20230221145021.31993-1-zajec5@gmail.com>
In-Reply-To: <20230221145021.31993-1-zajec5@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 21 Feb 2023 22:38:13 +0100
Message-ID: <CAFBinCDxB=xtz9mtZupBC7J5oxknN1ENHzJ-cFxX4FTDSgZeFQ@mail.gmail.com>
Subject: Re: [PATCH] nvmem: add explicit config option to read OF fixed cells
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rafa=C5=82,

On Tue, Feb 21, 2023 at 3:50 PM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> =
wrote:
>
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> NVMEM subsystem looks for fixed NVMEM cells (specified in DT) by
> default. This behaviour made sense in early days before adding support
> for dynamic cells.
>
> With every new supported NVMEM device with dynamic cells current
> behaviour becomes non-optimal. It results in unneeded iterating over DT
> nodes and may result in false discovery of cells (depending on used DT
> properties).
I am not familiar with the recent changes around dynamic cells.
Is there any discussion/summary that I can read to get up to speed?

My main thought is: if there are many "fixed OF cells" implementations
and only a few "dynamic" ones - does it make sense to flip the logic
and introduce a new "use_dynamic_of_cells" flag instead?


Best regards,
Martin
