Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D4B69EA30
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjBUW36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjBUW34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:29:56 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD2F31E3F;
        Tue, 21 Feb 2023 14:29:53 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id i9so7486382lfc.6;
        Tue, 21 Feb 2023 14:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRskwuzUoTseJ7UhE/XiQ/ajutHbx9Jd0AO9KzeF2SA=;
        b=aKFAgFAHiqsL++CU0NQXI3ge3qCJTJWe9hhri5lPXhyFoAESWMM21NLBBPU5G6cNJY
         35lsLXaqrC6Mb6smUaE+WcAfzrsm9gqxGTNY/iMY66IU87+YokTiPTcPT4MAg1ufPqqN
         fQ16flQ0OJ/1LjzFEPXttIEaZA+BGgA59wa2q62W00rcvD7z7rqT3ayvBS5tl0ppMcJn
         IkWVdlg7bPBPCodv4v7h8EVO01zPwNKlvuZ5IwuJgkB8t2e6se9vm3VG4j3pdft/mnmu
         U8Eefz5MvvrPId0lV3ihpW8DC9KN/oUDLeqrl8gAIQSSSvZLw+145WXRdzkKwlM3xuel
         UKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rRskwuzUoTseJ7UhE/XiQ/ajutHbx9Jd0AO9KzeF2SA=;
        b=DK/nhKhaKBL63j2ZHyNugE4TqPMrTWG9Ad+iNVyRlySGQTCpQhaXgIVKYbRP7ZUS5/
         MLZ+FefqZtxFaSiU6nELmVX67NRdhhJflKRoUlSJUu3ZRQJ3Pri4hVeVq2CU+Eqkwp72
         DIKH8r65dMewTp0KsS5B7E9V/S0yA3r4PqLw1Tx/FEqRev6uCFoyQyn5iskorWWYnagj
         SBIuC2PTTPoktxibSLYbrUIoW7EXmjw54eVpOq9IAsJAiACCt+KT2uyZ52gCCBKiSQ4C
         vpsLRyGk+ZGslBsyftNL1nZARjznEEtsUQbO4FxpG63YuS1oDhkdH+W4H7DTrNE7ohGU
         LAMg==
X-Gm-Message-State: AO0yUKVQsrQQIMAsKexzp/RIlaJR2045ASrJiafDx8+VmZYxNiGFPr4N
        O1JKL6Ha94ZiEbPIsQFuB6E=
X-Google-Smtp-Source: AK7set+yBQHNb9hSkW8dFReCGvYH5kUaeuCwO556jqZU4gWvC3OnNb7bh1PGOn5AYoyDdgoJfAwP7w==
X-Received: by 2002:a05:6512:14b:b0:4db:5122:2099 with SMTP id m11-20020a056512014b00b004db51222099mr1807349lfo.32.1677018591920;
        Tue, 21 Feb 2023 14:29:51 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id x25-20020ac259d9000000b004caf992bba9sm1957069lfn.268.2023.02.21.14.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 14:29:51 -0800 (PST)
Message-ID: <101a5bdf-870a-a1bb-954d-1d675ecad5a7@gmail.com>
Date:   Tue, 21 Feb 2023 23:29:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH] nvmem: add explicit config option to read OF fixed cells
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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
References: <20230221145021.31993-1-zajec5@gmail.com>
 <CAFBinCDxB=xtz9mtZupBC7J5oxknN1ENHzJ-cFxX4FTDSgZeFQ@mail.gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <CAFBinCDxB=xtz9mtZupBC7J5oxknN1ENHzJ-cFxX4FTDSgZeFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.02.2023 22:38, Martin Blumenstingl wrote:
> On Tue, Feb 21, 2023 at 3:50 PM Rafał Miłecki <zajec5@gmail.com> wrote:
>>
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> NVMEM subsystem looks for fixed NVMEM cells (specified in DT) by
>> default. This behaviour made sense in early days before adding support
>> for dynamic cells.
>>
>> With every new supported NVMEM device with dynamic cells current
>> behaviour becomes non-optimal. It results in unneeded iterating over DT
>> nodes and may result in false discovery of cells (depending on used DT
>> properties).
> I am not familiar with the recent changes around dynamic cells.
> Is there any discussion/summary that I can read to get up to speed?

Some NVMEM devices don't store specific data at hardcoded offsets. For
such devices we have drivers (to become: layouts) that parse their magic
content. They discover cells and register them and provide matching with
proper DT nodes.

For bindings see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=084973e944bec21804f8afb0515b25434438699a
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a607a850ba1fa966cbb035544c1588e24a6307df

For example driver see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e977eaa8280e957b87904b536661550f2a6b3e8
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=207775f7e17b8fd0426a2ac4a5b81e4e1d71849e

For usage see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c8442f0fb09ca3d842b9b23d1d0650f649fd10f8


> My main thought is: if there are many "fixed OF cells" implementations
> and only a few "dynamic" ones - does it make sense to flip the logic
> and introduce a new "use_dynamic_of_cells" flag instead?

The problem is that there are more cases than just two. We can have:
1. No cells at all
2. Fixed cells in DT
3. Dynamic cells with references in DT
4. Driver specified cells (specified within config)
5. Cells defined in a global table

So we need to reference DT cells explicitly (we can't just confirm /
deny *dynamic* cells).

Another solution would be to have "no_fixed_of_cells" but:

1. Personally I think negation is less clear / easy to follow

2. There may be actually more drivers with no fixed cells.
I think I modified 18 drivers. It seems devm_nvmem_register() is
referenced in 44 places. Few of them may be not actual users but it
still seems to be about equal.
