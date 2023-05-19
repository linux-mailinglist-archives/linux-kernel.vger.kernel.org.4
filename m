Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532D9708FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 08:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjESG32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 02:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjESG30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 02:29:26 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69221AD;
        Thu, 18 May 2023 23:29:24 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B6C955C017D;
        Fri, 19 May 2023 02:29:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 19 May 2023 02:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684477761; x=1684564161; bh=i/
        I47qKuqB4bMU6D9p4VPqhlV7pgkdTqCfilS1kyhrk=; b=cvQhoQ+6+7tyHLQX+f
        OGY0l2YqyKen3c5oGftHNW1t9NnH6CVH/e9N7MJQMFCzRokvVu1B8GIR149GY9Bz
        hKh7ayxfkFNP6je0N/MPetnp189QzqRt461h66qbXYuh8S5myoJfV60E3rNtV3Qa
        XvCS4XzmrwB839XmiS5K4S8z2i4ViwqSAQI6gLtc/S6Ed05JqJ1kVHhFnqNYoctJ
        4vsUikfelL/0Tb/Cdu/JEnMG0P08tnB2dGrA6k/BDoaNktfJitOExP5nAEG3FQVt
        4dpDBGu0qdIUlHm19H0Disid5MlsPLDYxfG6qR84X9s5Ybf77oO+xD7IvLYElNud
        ghVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684477761; x=1684564161; bh=i/I47qKuqB4bM
        U6D9p4VPqhlV7pgkdTqCfilS1kyhrk=; b=EQBnp+xYFByLFoZ23C2+Yit24Oawm
        21NupXM0wkTiv5lPNJ/jvcsdY6n1YzhhOBCQbfIOeMDW+rQ0Ma+zcQ34BMTzca0m
        YlmfDHwydRbiqDT3MVjhZklIVKGh8LuXDQVkXj6TBog7Va9uS6tFsGE+FPDZb918
        2rY/o5olqLLKmTvAR9XJnwjhBCne+G2TQUOP7S4uGHKrIRCIPPbmrhd2bQEjc//f
        P5tR7Ecn5wgGqmW+/PkDe78Nyyt8ps6WhgXi7qp0u8kYe1Qj0FbwQlPIeai8JEaX
        UsDouVvMsNUqDw6F6X38o00KNh6mhPZPbL4qe4UOHyZ1f96qwKmiongLQ==
X-ME-Sender: <xms:QBdnZBvrlhL4t0XWh-nHfmnIYF3TNDlSS3fp_MP1aiPLlC_jakdNFg>
    <xme:QBdnZKd4VvC8vOhh5fJhODHOCfNZ5Lfkk1XVk9dNIKEhMvx19xG2jRGyk9VLoA0d6
    TB_TGxxJwzNv6bXVBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeigedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:QBdnZEzBiwjQzoBhJBWoRDRMvEXQ3_mVRyfArBaVnV3Gbwyeu_qq9g>
    <xmx:QBdnZIMBH5KcspvFPzoElf4y8gwzs3Q8wNGfR1JN6OOvTA56E39CkQ>
    <xmx:QBdnZB8bl03HM0VghrSpjYgJiTD2-okPXDqTZZMed8rJFlczgz3F1g>
    <xmx:QRdnZIg9y_xyUFUXTuVs55XzKaeMOJWbaV4XmFE0R3Qrkk3bF70fgA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F0459B60086; Fri, 19 May 2023 02:29:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <ed53d7d6-78e7-45af-a441-1c87fba4d420@app.fastmail.com>
In-Reply-To: <20230519045825.28369-2-stanley_chang@realtek.com>
References: <20230519045825.28369-1-stanley_chang@realtek.com>
 <20230519045825.28369-2-stanley_chang@realtek.com>
Date:   Fri, 19 May 2023 08:28:59 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Stanley Chang" <stanley_chang@realtek.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Vinod Koul" <vkoul@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Ray Chi" <raychi@google.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Eugeniu Rosca" <erosca@de.adit-jv.com>,
        "Michael Grzeschik" <m.grzeschik@pengutronix.de>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        "Flavio Suligoi" <f.suligoi@asem.it>,
        "Mathias Nyman" <mathias.nyman@linux.intel.com>,
        "Bhuvanesh Surachari" <Bhuvanesh_Surachari@mentor.com>,
        "Paul Cercueil" <paul@crapouillou.net>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 2/3] usb: phy: Add driver for the Realtek SoC USB 2.0/3.0 PHY
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023, at 06:58, Stanley Chang wrote:
> +struct rtk_usb_phy {
> +	struct usb_phy phy;
> +	struct device *dev;
> +	struct regmap *usb_regs;
> +	struct regmap *mac_regs;
> +	struct regmap *usb_ctrl_regs;
> +
> +	int port_index;
> +	int phyN;
> +	void *reg_addr;
> +	void *phy_data;
> +
> +#ifdef CONFIG_DEBUG_FS
> +	struct dentry *debug_dir;
> +#endif
> +};

I'd avoid the #ifdefs here and just leave the debugfs
code in unconditionally in favor of readability. When
debugfs is disabled, everything except for the one pointer
value should get optimized out.

> +#define phy_read(addr) __raw_readl(addr)
> +#define phy_write(addr, val) do { \
> +	/* Do smp_wmb */ \
> +	smp_wmb(); __raw_writel(val, addr); \
> +} while (0)

Using __raw_readl()/__raw_writel() in a driver is almost never
the right interface, it does not guarantee atomicity of the
access, has the wrong byte-order on big-endian kernels and misses
the barriers to serialize against DMA accesses. smp_wmb()
should have no effect here since this only serializes access to
memory against another CPU if it's paired with an smp_rmb(), but
not on MMIO registers.

> +#define PHY_IO_TIMEOUT_MSEC		(50)
> +
> +static inline int utmi_wait_register(void __iomem *reg, u32 mask, u32 
> result)
> +{
> +	unsigned long timeout = jiffies + 
> msecs_to_jiffies(PHY_IO_TIMEOUT_MSEC);
> +
> +	while (time_before(jiffies, timeout)) {
> +		/* Do smp_rmb */
> +		smp_rmb();
> +		if ((phy_read(reg) & mask) == result)
> +			return 0;
> +		udelay(100);
> +	}
> +	pr_err("\033[0;32;31m can't program USB phy \033[m\n");
> +
> +	return -ETIMEDOUT;
> +}

This should just use read_poll_timeout() or possibly
read_poll_timeout_atomic(), but not an open-coded version.

I don't think I've seen escape sequences in a printk
in any other driver, so please don't start that now.

> +#define DEFAULT_CHIP_REVISION 0xA00
> +#define MAX_CHIP_REVISION 0xC00
> +
> +static inline int __get_chip_revision(void)
> +{
> +	int chip_revision = 0xFFF;
> +	char revision[] = "FFF";
> +	struct soc_device_attribute soc_att[] = {{.revision = revision}, {}};

You should probably check that you are actually on the right
SoC type here as well, not just the right revision of
an arbitrary chip.

Ideally I think the revision check should be based off a DT proporty
if that's possible, so you can have this code in the boot loader.

> +#define RTK_USB2PHY_NAME "rtk-usb2phy"

Better avoid hiding the driver name like this, it makes it harder
to grep the source tree for particular driver names.

> +	/* rmb for reg read */
> +	smp_rmb();
> +	regVal = phy_read(reg_gusb2phyacc0);

I would expect that you don't need barriers like this, especially
if you change the phy_read() helper to use the proper readl().

If you do need to serialize against other CPUs, still, there should
be a longer explanation about that, since it's so unexpected.

> +
> +static void do_rtk_usb2_phy_toggle(struct rtk_usb_phy *rtk_phy,
> +	    int index, bool isConnect);

It's best to sort your function definitions in a way that avoids
forward declarations. This makes it easier to read and shows that
there are no obvious recursions in the source. If you do have
an intentional recursion, make sure that there is a way to
prevent unbounded stack usage, and explain that in a comment.

> +static int do_rtk_usb_phy_init(struct rtk_usb_phy *rtk_phy, int index)
> +{
> +	struct reg_addr *regAddr;
> +	struct phy_data *phy_data;
> +	struct phy_parameter *phy_page_setting;
> +	int i;
> +
> +	if (!rtk_phy) {
> +		pr_err("%s, rtk_phy is NULL\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(rtk_phy->dev, "%s: init phy#%d\n", __func__, index);
...
> +	if (!phy_data) {
> +		pr_err("%s, phy_data is NULL\n", __func__);
> +		return -EINVAL;
> +	}

You can probably remove most of the debugging prints.

> +	regAddr = &((struct reg_addr *)rtk_phy->reg_addr)[index];
> +	phy_data = &((struct phy_data *)rtk_phy->phy_data)[index];

Why do you need the casts here? It looks like regAddr should
be an __iomem pointer. Please build your driver with 'make C=1'
to see if there are any incorrect address space annotations.

> +static int __get_phy_parameter_by_efuse(struct rtk_usb_phy *rtk_phy,
> +	    struct phy_data *phy_data, int index)
> +{
> +	u8 value = 0;
> +	struct nvmem_cell *cell;
> +	struct soc_device_attribute rtk_soc_groot[] = {
> +			{ .family = "Realtek Groot",},
> +			{ /* empty */ }
> +		};
> +	struct soc_device_attribute rtk_soc_hank[] = {
> +			{ .family = "Realtek Hank",},
> +			{ /* empty */ }
> +		};
> +	struct soc_device_attribute rtk_soc_efuse_v1[] = {
> +			{ .family = "Realtek Phoenix",},
> +			{ .family = "Realtek Kylin",},
> +			{ .family = "Realtek Hercules",},
> +			{ .family = "Realtek Thor",},
> +			{ .family = "Realtek Hank",},
> +			{ .family = "Realtek Groot",},
> +			{ .family = "Realtek Stark",},
> +			{ .family = "Realtek Parker",},
> +			{ /* empty */ }
> +		};
> +	struct soc_device_attribute rtk_soc_dis_level_at_page0[] = {
> +			{ .family = "Realtek Phoenix",},
> +			{ .family = "Realtek Kylin",},
> +			{ .family = "Realtek Hercules",},
> +			{ .family = "Realtek Thor",},
> +			{ .family = "Realtek Hank",},
> +			{ .family = "Realtek Groot",},
> +			{ /* empty */ }
> +		};
> +
> +	if (soc_device_match(rtk_soc_efuse_v1)) {
> +		dev_dbg(rtk_phy->dev, "Use efuse v1 to updated phy parameter\n");
> +		phy_data->check_efuse_version = CHECK_EFUSE_V1;

I'm not entirely sure what you are trying to do here, but
it looks the purpose is to tell the difference between implementations
of the phy device by looking at which SoC it's in. You should
only need that very rarely when this information cannot be
passed through the DT, but you literally already have the
per-SoC compatible strings below, so just use those, or add other
DT properties in the binding for specific quirks or capabilities.

> +#ifdef CONFIG_OF
> +static const struct of_device_id usbphy_rtk_dt_match[] = {
> +	{ .compatible = "realtek,usb3phy", },
> +	{ .compatible = "realtek,rtd-usb3phy", },
> +	{ .compatible = "realtek,rtd1295-usb3phy", },
> +	{ .compatible = "realtek,rtd1619-usb3phy", },
> +	{ .compatible = "realtek,rtd1319-usb3phy", },
> +	{ .compatible = "realtek,rtd1619b-usb3phy", },
> +	{ .compatible = "realtek,rtd1319d-usb3phy", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, usbphy_rtk_dt_match);
> +#endif
> +
> +static struct platform_driver rtk_usb3phy_driver = {
> +	.probe		= rtk_usb3phy_probe,
> +	.remove		= rtk_usb3phy_remove,
> +	.driver		= {
> +		.name	= RTK_USB3PHY_NAME,
> +		.owner	= THIS_MODULE,
> +		.of_match_table = of_match_ptr(usbphy_rtk_dt_match),
> +	},
> +};

Remove that of_match_ptr() and ifdef CONFIG_OF check here, new drivers
should no longer use static platform device definitions and just assume
that CONFIG_OF is used.

     Arnd
