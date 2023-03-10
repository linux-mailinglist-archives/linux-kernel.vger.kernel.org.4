Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AD16B3C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCJKn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCJKno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:43:44 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462B964231;
        Fri, 10 Mar 2023 02:43:39 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id g18so4856871ljl.3;
        Fri, 10 Mar 2023 02:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678445017;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6D8DgvSllDpIpjkRMtHsbcOPCoCHnTYInoVGhS4b+QA=;
        b=nCHfG0VG+xIVMI3Uz30+lCPQjHMFNzvzKvLr/uxFUsFQf3sK0QzWXC1lkMYIpnb+yo
         kTfC3hUaq8cgGe9xMk6AcbdnaIcg7HQQTQy9FYUYrxXA8lGpEBgL1Dmir6Vjlq8dfPLs
         C7qPdt6AmXMhTO+LAlZFKkmu7qpBvf+EAlj48MXE+EFWNTkHYnE9PYxJfTlLY0JQzVRe
         AVPRBJUNvn2rznC1jaKvMtoRuQcxNZy6ZCXkCfDrMOAox6Fj/UPpj2Qw3RPLR5Sm6Qw0
         QLFfzrkeRntLiy2SEYLW90oHWj4Bztsxrd9uCIC8aMvEDbCJnw1v2hI9WbY/GoLyvewF
         cJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678445017;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6D8DgvSllDpIpjkRMtHsbcOPCoCHnTYInoVGhS4b+QA=;
        b=T3B3OLizAuJI0Zg6TbluSw3X7J2Kf5nIm7E23CJ3+tvn2G4BIY5U1Dwv+xl9CGwVU0
         aTLRnjnnMmyx+AvRWEPO/3Q+2BtnDBeLqo+grUMK5ZnfpE42lFLYRlVy24d9WLdR9Ynm
         xJVFmMrB5hDS275p9jx71m7vZuF7gbAjYuoScGCwGrmUFww/6MuiwuWdoOBmCU3MOUGl
         V+7XtKIu2IDGB9bQ7wczNHi5BbKaZ8GgsEtvbkJ8MHf7vsX/p8uhaR/K8CYwGIYEwBSe
         tHsec0dx+uLiNYrprAPpc51Wa9r2R2WFRjYRJPW8BTG/J7n5s1wt92ze60bzALcFe79+
         6fRA==
X-Gm-Message-State: AO0yUKUmmgs5MLZUblh+re//oD8zomdm1agcGi9/SSLbfdNppxr1KOmL
        +pinZyGNX5BSc9upAAF/szM=
X-Google-Smtp-Source: AK7set+p71/bzHEgwcLpPLO/Pz2JDQS28ccp+iIU3K53kTB52otuWjNtgd3ESU/TF0IRcMCTp5ShaA==
X-Received: by 2002:a2e:4619:0:b0:290:8289:8cba with SMTP id t25-20020a2e4619000000b0029082898cbamr310434lja.8.1678445017151;
        Fri, 10 Mar 2023 02:43:37 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id l20-20020a2e9094000000b00297dad1a2b0sm187498ljg.103.2023.03.10.02.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 02:43:36 -0800 (PST)
Message-ID: <453c9298-d64a-aa77-28ba-ac986dfdd722@gmail.com>
Date:   Fri, 10 Mar 2023 11:43:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH V3] nvmem: add explicit config option to read OF fixed
 cells
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
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
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
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
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230309112028.19215-1-zajec5@gmail.com>
 <ac94f04b-4b25-81e4-386f-55b0a2c7c85f@linaro.org>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <ac94f04b-4b25-81e4-386f-55b0a2c7c85f@linaro.org>
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

On 10.03.2023 10:22, Srinivas Kandagatla wrote:
> 
> On 09/03/2023 11:20, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> NVMEM subsystem looks for fixed NVMEM cells (specified in DT) by
>> default. This behaviour was totally safe in early days before adding
>> support for dynamic cells and with simple DT syntax.
>>
>> With every new supported NVMEM device with dynamic cells the current
>> behaviour becomes non-optimal:
>> 1. It results in unneeded iterating over DT nodes
>> 2. It may result in false discovery of cells (in case DT subnodes
>>     contain "reg" property)
>>
> 
> Am really not sure what is going on here,
> I did raise some issues with this overall approch to start with at [1] none of which are discussed and now I see v3 :-)
> 
> [1] https://lore.kernel.org/lkml/20230309094010.1051573-1-michael@walle.cc/T/#m7706b640979aabf251436e017b8189413661a53a

I updated commit message to address your concerns. I thought I made it
clear. I don't know how to emphasize it better.

I'll try to answer nevertheless, please see below.


On 9.03.2023 10:37, Srinivas Kandagatla wrote:
 > On 24/02/2023 07:29, Rafał Miłecki wrote:
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
 >
 >>
 >> This behaviour has actually caused a problem already with the MTD
 >> subsystem. MTD subpartitions were incorrectly treated as NVMEM cells.
 >>
 >> Also with upcoming support for NVMEM layouts no new binding or driver
 >> should support fixed cells defined in device node.
 >
 > This is not very clear, are you saying that we should not support fixed cells? If that is the case then you are proabably taking this in wrong direction. nvmem was built based on the fact that drivers can read from a fixed offsets. Dynamic cells is something very new, that does not mean that we should ditch fixed cells support in dt.

I DON'T deprecate or drop support for fixed layouts (fixed NVMEM cells).
Period.
I WON'T drop support for old binding. We stay backward compatible.
Period.

In this patch's body I wrote:
"with the support for NVMEM layouts we may & should have *new* bindings allow fixed NVMEM cells only in the "nvmem-layout" subnode"
that clearly means I still want to ALLOW fixed NVMEM cells - just in the *nvmem-layout* node.

I want to KEEP support for fixed NVMEM cells.
I just want them to be preferably defined in the "nvmem-layout" node.


 >> Solve this by modifying drivers for bindings that support specifying
 >> fixed NVMEM cells in DT. Make them explicitly tell NVMEM subsystem to
 >> read cells from DT.
 >
 > Shouldn't this be opposite, let the new providers tell that cells are created at runtime?
 >
 > or even better if there is a way to detect if we can set this flag dynamically based on layout/post-processing configuration.
 >
 > that should be much cleaner approch.

I tried to address this concert in the following part of commit body:

 > The best approach seems to be making NVMEM core looking for fixed DT
 > cells in **device** node an opt-in feature. It's a feature that over
 > time should get deprecated in a favor of using "nvmem-layouts" also for
 > fixed NVMEM cells.

New NVMEM provider bindings and drivers will get developed. I would
want all new bindings to use "nvmem-layout" for describing NVMEM cells
(no matter if fixed or dynamic).

That means all new drivers WILL NOT need to set "use_fixed_of_cells".

So over time "use_fixed_of_cells" will become a minority. It'w would be
pitty to have every new driver to request NVMEM code to skip looking for
NVMEM cells in **device** node.

So my answer is: no. I don't believe it should be opposite. Looking for
fixed NVMEM cells in **device** DT node should be an opt-in.

If by some miracle I manage to get my patches through then you'll forget
about "use_fixed_of_cells" next month. Noone will need it for any new
stuff. It'll stay for backward compatibility only.
