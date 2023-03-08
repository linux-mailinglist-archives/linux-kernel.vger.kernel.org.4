Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B4C6B10C7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCHSNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjCHSMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:12:55 -0500
Received: from 16.mo561.mail-out.ovh.net (16.mo561.mail-out.ovh.net [188.165.56.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCD1CE96F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 10:12:40 -0800 (PST)
Received: from director8.ghost.mail-out.ovh.net (unknown [10.108.4.98])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id D1E83206F5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 18:12:38 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-cqldr (unknown [10.110.115.240])
        by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 1EF4D1FDE9;
        Wed,  8 Mar 2023 18:12:33 +0000 (UTC)
Received: from RCM-web1.webmail.mail.ovh.net ([176.31.238.120])
        by ghost-submission-6684bf9d7b-cqldr with ESMTPSA
        id NAwlBhHQCGQKAhoAZIOUGg
        (envelope-from <rafal@milecki.pl>); Wed, 08 Mar 2023 18:12:33 +0000
MIME-Version: 1.0
Date:   Wed, 08 Mar 2023 19:12:32 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
        linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org
Subject: Re: [PATCH V2] nvmem: add explicit config option to read OF fixed
 cells
In-Reply-To: <20230308190636.7fabab9c@xps-13>
References: <20230224072903.20945-1-zajec5@gmail.com>
 <20230308173256.3837b87b@xps-13>
 <91ff425b4c901648b1faf34c784f20ad@milecki.pl>
 <20230308190636.7fabab9c@xps-13>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <5974d28426057975e701c4a8454b5a13@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14994172011305216839
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvddufedgieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtkehjtddtreejnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeejvdelgfeutdfhfeelheegfedtleduleeuvdfgfeefvefhvedtheetjeetfeehgeenucfkphepuddvjedrtddrtddruddpudelgedrudekjedrjeegrddvfeefpddujeeirdefuddrvdefkedruddvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrrghfrghlsehmihhlvggtkhhirdhplheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedupdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-08 19:06, Miquel Raynal wrote:
> Hi Rafał,
> 
> rafal@milecki.pl wrote on Wed, 08 Mar 2023 17:55:46 +0100:
> 
>> On 2023-03-08 17:34, Miquel Raynal wrote:
>> > Hi Rafał,
>> >
>> > zajec5@gmail.com wrote on Fri, 24 Feb 2023 08:29:03 +0100:
>> >
>> >> From: Rafał Miłecki <rafal@milecki.pl>
>> >> >> NVMEM subsystem looks for fixed NVMEM cells (specified in DT) by
>> >> default. This behaviour made sense in early days before adding support
>> >> for dynamic cells.
>> >> >> With every new supported NVMEM device with dynamic cells current
>> >> behaviour becomes non-optimal. It results in unneeded iterating over >> DT
>> >> nodes and may result in false discovery of cells (depending on used DT
>> >> properties).
>> >> >> This behaviour has actually caused a problem already with the MTD
>> >> subsystem. MTD subpartitions were incorrectly treated as NVMEM cells.
>> >
>> > That's true, but I expect this to be really MTD specific.
>> >
>> > A concrete proposal below.
>> >
>> >> Also with upcoming support for NVMEM layouts no new binding or driver
>> >> should support fixed cells defined in device node.
>> >
>> > I'm not sure I agree with this statement. We are not preventing new
>> > binding/driver to use fixed cells, or...? We offer a new way to expose
>> > nvmem cells with another way than "fixed-offset" and "fixed-size" OF
>> > nodes.
>> 
>>  From what I understood all new NVMEM bindings should have cells 
>> defined
>> in the nvmem-layout { } node. That's what I mean by saying they should
>> not be defined in device node (but its "nvmem-layout" instead).
> 
> Layouts are just another possibility, either you user the nvmem-cells
> compatible and produce nvmem cells with fixed OF nodes, or you use the
> nvmem-layout container. I don't think all new bindings should have
> cells in layouts. It depends if the content is static or not.
> 
>> >> Solve this by modifying drivers for bindings that support specifying
>> >> fixed NVMEM cells in DT. Make them explicitly tell NVMEM subsystem to
>> >> read cells from DT.
>> >> >> It wasn't clear (to me) if rtc and w1 code actually uses fixed cells. >> I
>> >> enabled them to don't risk any breakage.
>> >> >> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> >> [for drivers/nvmem/meson-{efuse,mx-efuse}.c]
>> >> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> >> ---
>> >> V2: Fix stm32-romem.c typo breaking its compilation
>> >>     Pick Martin's Acked-by
>> >>     Add paragraph about layouts deprecating use_fixed_of_cells
>> >> ---
>> >>  drivers/mtd/mtdcore.c          | 2 ++
>> >>  drivers/nvmem/apple-efuses.c   | 1 +
>> >>  drivers/nvmem/core.c           | 8 +++++---
>> >>  drivers/nvmem/imx-ocotp-scu.c  | 1 +
>> >>  drivers/nvmem/imx-ocotp.c      | 1 +
>> >>  drivers/nvmem/meson-efuse.c    | 1 +
>> >>  drivers/nvmem/meson-mx-efuse.c | 1 +
>> >>  drivers/nvmem/microchip-otpc.c | 1 +
>> >>  drivers/nvmem/mtk-efuse.c      | 1 +
>> >>  drivers/nvmem/qcom-spmi-sdam.c | 1 +
>> >>  drivers/nvmem/qfprom.c         | 1 +
>> >>  drivers/nvmem/rave-sp-eeprom.c | 1 +
>> >>  drivers/nvmem/rockchip-efuse.c | 1 +
>> >>  drivers/nvmem/sc27xx-efuse.c   | 1 +
>> >>  drivers/nvmem/sprd-efuse.c     | 1 +
>> >>  drivers/nvmem/stm32-romem.c    | 1 +
>> >>  drivers/nvmem/sunplus-ocotp.c  | 1 +
>> >>  drivers/nvmem/sunxi_sid.c      | 1 +
>> >>  drivers/nvmem/uniphier-efuse.c | 1 +
>> >>  drivers/nvmem/zynqmp_nvmem.c   | 1 +
>> >>  drivers/rtc/nvmem.c            | 1 +
>> >>  drivers/w1/slaves/w1_ds250x.c  | 1 +
>> >>  include/linux/nvmem-provider.h | 2 ++
>> >>  23 files changed, 29 insertions(+), 3 deletions(-)
>> >> >> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
>> >> index 0feacb9fbdac..1bb479c0f758 100644
>> >> --- a/drivers/mtd/mtdcore.c
>> >> +++ b/drivers/mtd/mtdcore.c
>> >> @@ -523,6 +523,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
>> >>  	config.dev = &mtd->dev;
>> >>  	config.name = dev_name(&mtd->dev);
>> >>  	config.owner = THIS_MODULE;
>> >> +	config.use_fixed_of_cells = of_device_is_compatible(node, >> "nvmem-cells");
>> >
>> > I am wondering how mtd specific this is? For me all OF nodes containing
>> > the nvmem-cells compatible should be treated as cells providers and
>> > populate nvmem cells as for each children.
>> >
>> > Why don't we just check for this compatible to be present? in
>> > nvmem_add_cells_from_of() ? And if not we just skip the operation.
>> >
>> > This way we still follow the bindings (even though using nvmem-cells in
>> > the compatible property to require cells population was a mistake in
>> > the first place, as discussed in the devlink thread recently) but there
>> > is no need for a per-driver config option?
>> 
>> This isn't mtd specific. Please check this patch for all occurrences 
>> of
>> the:
>> use_fixed_of_cells = true
>> 
>> The very first one: drivers/nvmem/apple-efuses.c driver for the
>> "apple,efuses" binding. That binding supports fixed OF cells, see:
>> Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
> 
> I'm saying: based on what has been enforced so far, I would expect all
> fixed cell providers to come with nvmem-cells as compatible, no?
> 
> If that's the case we could use that as a common denominator?

Sorry, I don't get it. Have you checked
Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
?

It's a NVMEM provied binding with fixed cells that doesn't use
nvmem-cells as compatible. There are many more.
