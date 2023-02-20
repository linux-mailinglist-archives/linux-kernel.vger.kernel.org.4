Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7361B69C6E6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjBTIny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBTInv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:43:51 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB409030
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:43:47 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ec43so1010792edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oc7qwSosW73sJztVFY9hFeshz9Qo4V+H8pEm5ZTWB4A=;
        b=qQUrk+pzSBrV3nJupE2SwxALGtPLYDAAND47qsEkKuU7gRYe9INWg4gxnvujPSTtnK
         h7QdX9ngNnc0QEFnFJon8fa5yVx1Y68rFyQTbAmu2X5NDzmiTwkkOzksObo2lgbc8qkS
         nxEfhPwdm6A2ND0RnpB29d8nLNU5qTnkKVUcK7P/VYfBgxSKNW7ynWD6ayf2ZfT73B8e
         I7PIsrv+PGiaHb7DgQ7KhUJsOOail+8hLA4dfFBxrgtIuaskqY1zjJDEGrIRwlKF1ZPg
         QSYuaehCT8SPLQb6tovSSH9BY2jxc0ml6sCZOHRvoEUIZmyljR7y0arTpWpOODmMTzsv
         df3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oc7qwSosW73sJztVFY9hFeshz9Qo4V+H8pEm5ZTWB4A=;
        b=u5YsgTGwO9ziPhJtWD27cy+xhfk37iWjjlaZl6puUH8TYZdqbFCGXtFGfgwtwuidQj
         fw0rcjl/CoCZk8G/nhP/fZW/tn4ZOon6yzsbYikZKSF0dSSg3o7FwFI4sti1YMMl8oKq
         jt5Ioei5u49dfz8XUwDYs+Id+7dmObnswg7HoM6xxaAcdNMjufpSH7moRrpOWUDQd8L4
         9KBxJt6ioHNNQgSNNU2gCzrkWcbl7XMbJUsSx3nhvsovz0Cf62Inr2d6vATeOVorjSHt
         F1R97XSXbjpyXCAPSR4hhMnwcod+tZwVam5SOiDHd2Fn3A/MwrY+69Yco2ND1u67Nlk7
         mgiw==
X-Gm-Message-State: AO0yUKVKRvsGqout6PjuIfH+VW/PNc6iAD0qNglpPuOZmQKE6oEAEocs
        SvDaMLjg6CoZuQuq09ZzPm/cqA==
X-Google-Smtp-Source: AK7set+h/km1BcSp8WLRTYcEpcL/rcR4qt7lygIWcCF3VrUjrX36Tgiq7gxwG7osnlP0+WObDSsn9Q==
X-Received: by 2002:a17:907:2da8:b0:8b1:7274:1a72 with SMTP id gt40-20020a1709072da800b008b172741a72mr6245934ejc.6.1676882626033;
        Mon, 20 Feb 2023 00:43:46 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t24-20020a1709066bd800b008c6c47f59c1sm2256212ejs.48.2023.02.20.00.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 00:43:45 -0800 (PST)
Message-ID: <63986fb1-f8d4-f348-bae9-72e08369213b@linaro.org>
Date:   Mon, 20 Feb 2023 09:43:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 2/2] i2c: aspeed: support ast2600 i2cv2 new register
 mode driver
Content-Language: en-US
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <20230220061745.1973981-3-ryan_chen@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220061745.1973981-3-ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2023 07:17, Ryan Chen wrote:
> Add i2cv2 new register mode driver to support AST2600 i2c new register
> mode. AST2600 i2c controller have legacy and new register mode. The
> new register mode have global register support 4 base clock for scl
> clock selection, and new clock divider mode. The i2c new register mode
> have separate register set to control i2c master and slave.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  MAINTAINERS                      |    9 +
>  drivers/i2c/busses/Kconfig       |   11 +
>  drivers/i2c/busses/Makefile      |    1 +
>  drivers/i2c/busses/i2c-ast2600.c | 1703 ++++++++++++++++++++++++++++++
>  4 files changed, 1724 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-ast2600.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 749710e22b4d..c9841568cb24 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1924,6 +1924,15 @@ F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-i2c-ic.
>  F:	drivers/i2c/busses/i2c-aspeed.c
>  F:	drivers/irqchip/irq-aspeed-i2c-ic.c
>  
> +ARM/ASPEED I2CV2 DRIVER
> +M:      Ryan Chen <ryan_chen@aspeedtech.com>
> +R:      Andrew Jeffery <andrew@aj.id.au>
> +L:      linux-i2c@vger.kernel.org
> +L:      openbmc@lists.ozlabs.org (moderated for non-subscribers)
> +S:      Maintained
> +F:      Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml
> +F:      drivers/i2c/busses/i2c-ast2600.c
> +
>  ARM/ASPEED MACHINE SUPPORT
>  M:	Joel Stanley <joel@jms.id.au>
>  R:	Andrew Jeffery <andrew@aj.id.au>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 7284206b278b..f3f7500ce768 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -389,6 +389,17 @@ config I2C_ALTERA
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-altera.
>  
> +config I2C_AST2600
> +	tristate "Aspeed I2C v2 Controller"
> +	depends on ARCH_ASPEED || COMPILE_TEST
> +	select I2C_SMBUS
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  Aspeed I2C controller with new register set.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-new-aspeed.
> +
>  config I2C_ASPEED
>  	tristate "Aspeed I2C Controller"
>  	depends on ARCH_ASPEED || COMPILE_TEST
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index c5cac15f075c..d0ab4d45781c 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powermac.o
>  obj-$(CONFIG_I2C_ALTERA)	+= i2c-altera.o
>  obj-$(CONFIG_I2C_AMD_MP2)	+= i2c-amd-mp2-pci.o i2c-amd-mp2-plat.o
>  obj-$(CONFIG_I2C_ASPEED)	+= i2c-aspeed.o
> +obj-$(CONFIG_I2C_AST2600)	+= i2c-ast2600.o
>  obj-$(CONFIG_I2C_AT91)		+= i2c-at91.o
>  i2c-at91-objs			:= i2c-at91-core.o i2c-at91-master.o
>  ifeq ($(CONFIG_I2C_AT91_SLAVE_EXPERIMENTAL),y)
> diff --git a/drivers/i2c/busses/i2c-ast2600.c b/drivers/i2c/busses/i2c-ast2600.c
> new file mode 100644
> index 000000000000..b5fe0af57d11
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-ast2600.c
> @@ -0,0 +1,1703 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ASPEED AST2600 new register set I2C controller driver
> + *
> + * Copyright (C) ASPEED Technology Inc.
> + */
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/reset.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/completion.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/of_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/i2c-smbus.h>
> +
> +/*
> + * APB clk : 100Mhz
> + * div	: scl		: baseclk [APB/((div/2) + 1)] : tBuf [1/bclk * 16]
> + * I2CG10[31:24] base clk4 for i2c auto recovery timeout counter (0xC6)
> + * I2CG10[23:16] base clk3 for Standard-mode (100Khz) min tBuf 4.7us
> + * 0x3c : 100.8Khz	: 3.225Mhz					  : 4.96us
> + * 0x3d : 99.2Khz	: 3.174Mhz					  : 5.04us
> + * 0x3e : 97.65Khz	: 3.125Mhz					  : 5.12us
> + * 0x40 : 97.75Khz	: 3.03Mhz					  : 5.28us
> + * 0x41 : 99.5Khz	: 2.98Mhz					  : 5.36us (default)
> + * I2CG10[15:8] base clk2 for Fast-mode (400Khz) min tBuf 1.3us
> + * 0x12 : 400Khz	: 10Mhz						  : 1.6us
> + * I2CG10[7:0] base clk1 for Fast-mode Plus (1Mhz) min tBuf 0.5us
> + * 0x08 : 1Mhz		: 20Mhz						  : 0.8us
> + */
> +#define AST2600_I2CG_ISR			0x00
> +#define AST2600_I2CG_SLAVE_ISR		0x04
> +#define AST2600_I2CG_OWNER		0x08
> +#define AST2600_I2CG_CTRL		0x0C
> +#define AST2600_I2CG_CLK_DIV_CTRL	0x10
> +
> +#define AST2600_I2CG_SLAVE_PKT_NAK	BIT(4)
> +#define AST2600_I2CG_M_S_SEPARATE_INTR	BIT(3)
> +#define AST2600_I2CG_CTRL_NEW_REG	BIT(2)
> +#define AST2600_I2CG_CTRL_NEW_CLK_DIV	BIT(1)
> +
> +#define AST2600_GLOBAL_INIT				\
> +			(AST2600_I2CG_CTRL_NEW_REG |	\
> +			AST2600_I2CG_CTRL_NEW_CLK_DIV)
> +#define I2CCG_DIV_CTRL 0xC6411208
> +
> +/* 0x00 : I2CC Master/Slave Function Control Register  */
> +#define AST2600_I2CC_FUN_CTRL		0x00
> +#define AST2600_I2CC_SLAVE_ADDR_RX_EN		BIT(20)
> +#define AST2600_I2CC_MASTER_RETRY_MASK		GENMASK(19, 18)
> +#define AST2600_I2CC_MASTER_RETRY(x)		(((x) & GENMASK(1, 0)) << 18)
> +#define AST2600_I2CC_BUS_AUTO_RELEASE		BIT(17)
> +#define AST2600_I2CC_M_SDA_LOCK_EN			BIT(16)
> +#define AST2600_I2CC_MULTI_MASTER_DIS		BIT(15)
> +#define AST2600_I2CC_M_SCL_DRIVE_EN			BIT(14)
> +#define AST2600_I2CC_MSB_STS				BIT(9)
> +#define AST2600_I2CC_SDA_DRIVE_1T_EN		BIT(8)
> +#define AST2600_I2CC_M_SDA_DRIVE_1T_EN		BIT(7)
> +#define AST2600_I2CC_M_HIGH_SPEED_EN		BIT(6)
> +/* reserver 5 : 2 */
> +#define AST2600_I2CC_SLAVE_EN			BIT(1)
> +#define AST2600_I2CC_MASTER_EN			BIT(0)
> +
> +/* 0x04 : I2CC Master/Slave Clock and AC Timing Control Register #1 */
> +#define AST2600_I2CC_AC_TIMING		0x04
> +#define AST2600_I2CC_TTIMEOUT(x)			(((x) & GENMASK(4, 0)) << 24)
> +#define AST2600_I2CC_TCKHIGHMIN(x)			(((x) & GENMASK(3, 0)) << 20)
> +#define AST2600_I2CC_TCKHIGH(x)			(((x) & GENMASK(3, 0)) << 16)
> +#define AST2600_I2CC_TCKLOW(x)			(((x) & GENMASK(3, 0)) << 12)
> +#define AST2600_I2CC_THDDAT(x)			(((x) & GENMASK(1, 0)) << 10)
> +#define AST2600_I2CC_TOUTBASECLK(x)			(((x) & GENMASK(1, 0)) << 8)
> +#define AST2600_I2CC_TBASECLK(x)			((x) & GENMASK(3, 0))
> +
> +/* 0x08 : I2CC Master/Slave Transmit/Receive Byte Buffer Register */
> +#define AST2600_I2CC_STS_AND_BUFF		0x08
> +#define AST2600_I2CC_TX_DIR_MASK			GENMASK(31, 29)
> +#define AST2600_I2CC_SDA_OE				BIT(28)
> +#define AST2600_I2CC_SDA_O				BIT(27)
> +#define AST2600_I2CC_SCL_OE				BIT(26)
> +#define AST2600_I2CC_SCL_O				BIT(25)
> +
> +#define AST2600_I2CC_SCL_LINE_STS			BIT(18)
> +#define AST2600_I2CC_SDA_LINE_STS			BIT(17)
> +#define AST2600_I2CC_BUS_BUSY_STS			BIT(16)
> +
> +#define AST2600_I2CC_GET_RX_BUFF(x)			(((x) >> 8) & GENMASK(7, 0))
> +
> +/* 0x0C : I2CC Master/Slave Pool Buffer Control Register  */
> +#define AST2600_I2CC_BUFF_CTRL		0x0C
> +#define AST2600_I2CC_GET_RX_BUF_LEN(x)		(((x) >> 24) & GENMASK(5, 0))
> +#define AST2600_I2CC_SET_RX_BUF_LEN(x)		(((((x) - 1) & GENMASK(4, 0)) << 16) | BIT(0))
> +#define AST2600_I2CC_SET_TX_BUF_LEN(x)		(((((x) - 1) & GENMASK(4, 0)) << 8) | BIT(0))
> +#define AST2600_I2CC_GET_TX_BUF_LEN(x)		((((x) >> 8) & GENMASK(4, 0)) + 1)
> +
> +/* 0x10 : I2CM Master Interrupt Control Register */
> +#define AST2600_I2CM_IER			0x10
> +/* 0x14 : I2CM Master Interrupt Status Register   : WC */
> +#define AST2600_I2CM_ISR			0x14
> +
> +#define AST2600_I2CM_PKT_TIMEOUT			BIT(18)
> +#define AST2600_I2CM_PKT_ERROR			BIT(17)
> +#define AST2600_I2CM_PKT_DONE			BIT(16)
> +
> +#define AST2600_I2CM_BUS_RECOVER_FAIL		BIT(15)
> +#define AST2600_I2CM_SDA_DL_TO			BIT(14)
> +#define AST2600_I2CM_BUS_RECOVER			BIT(13)
> +#define AST2600_I2CM_SMBUS_ALT			BIT(12)
> +
> +#define AST2600_I2CM_SCL_LOW_TO			BIT(6)
> +#define AST2600_I2CM_ABNORMAL			BIT(5)
> +#define AST2600_I2CM_NORMAL_STOP			BIT(4)
> +#define AST2600_I2CM_ARBIT_LOSS			BIT(3)
> +#define AST2600_I2CM_RX_DONE			BIT(2)
> +#define AST2600_I2CM_TX_NAK				BIT(1)
> +#define AST2600_I2CM_TX_ACK				BIT(0)
> +
> +/* 0x18 : I2CM Master Command/Status Register   */
> +#define AST2600_I2CM_CMD_STS		0x18
> +#define AST2600_I2CM_PKT_ADDR(x)			(((x) & GENMASK(6, 0)) << 24)
> +#define AST2600_I2CM_PKT_EN				BIT(16)
> +#define AST2600_I2CM_SDA_OE_OUT_DIR			BIT(15)
> +#define AST2600_I2CM_SDA_O_OUT_DIR			BIT(14)
> +#define AST2600_I2CM_SCL_OE_OUT_DIR			BIT(13)
> +#define AST2600_I2CM_SCL_O_OUT_DIR			BIT(12)
> +#define AST2600_I2CM_RECOVER_CMD_EN			BIT(11)
> +
> +#define AST2600_I2CM_RX_DMA_EN			BIT(9)
> +#define AST2600_I2CM_TX_DMA_EN			BIT(8)
> +/* Command Bit */
> +#define AST2600_I2CM_RX_BUFF_EN			BIT(7)
> +#define AST2600_I2CM_TX_BUFF_EN			BIT(6)
> +#define AST2600_I2CM_STOP_CMD			BIT(5)
> +#define AST2600_I2CM_RX_CMD_LAST			BIT(4)
> +#define AST2600_I2CM_RX_CMD				BIT(3)
> +
> +#define AST2600_I2CM_TX_CMD				BIT(1)
> +#define AST2600_I2CM_START_CMD			BIT(0)
> +
> +/* 0x1C : I2CM Master DMA Transfer Length Register	 */
> +#define AST2600_I2CM_DMA_LEN		0x1C
> +/* Tx Rx support length 1 ~ 4096 */
> +#define AST2600_I2CM_SET_RX_DMA_LEN(x)	((((x) & GENMASK(11, 0)) << 16) | BIT(31))
> +#define AST2600_I2CM_SET_TX_DMA_LEN(x)	(((x) & GENMASK(11, 0)) | BIT(15))
> +
> +/* 0x20 : I2CS Slave Interrupt Control Register   */
> +#define AST2600_I2CS_IER			0x20
> +/* 0x24 : I2CS Slave Interrupt Status Register	 */
> +#define AST2600_I2CS_ISR			0x24
> +
> +#define AST2600_I2CS_ADDR_INDICATE_MASK	GENMASK(31, 30)
> +#define AST2600_I2CS_SLAVE_PENDING			BIT(29)
> +
> +#define AST2600_I2CS_WAIT_TX_DMA			BIT(25)
> +#define AST2600_I2CS_WAIT_RX_DMA			BIT(24)
> +
> +#define AST2600_I2CS_ADDR3_NAK			BIT(22)
> +#define AST2600_I2CS_ADDR2_NAK			BIT(21)
> +#define AST2600_I2CS_ADDR1_NAK			BIT(20)
> +
> +#define AST2600_I2CS_ADDR_MASK			GENMASK(19, 18)
> +#define AST2600_I2CS_PKT_ERROR			BIT(17)
> +#define AST2600_I2CS_PKT_DONE			BIT(16)
> +#define AST2600_I2CS_INACTIVE_TO			BIT(15)
> +
> +#define AST2600_I2CS_SLAVE_MATCH			BIT(7)
> +#define AST2600_I2CS_ABNOR_STOP			BIT(5)
> +#define AST2600_I2CS_STOP				BIT(4)
> +#define AST2600_I2CS_RX_DONE_NAK			BIT(3)
> +#define AST2600_I2CS_RX_DONE			BIT(2)
> +#define AST2600_I2CS_TX_NAK				BIT(1)
> +#define AST2600_I2CS_TX_ACK				BIT(0)
> +
> +/* 0x28 : I2CS Slave CMD/Status Register   */
> +#define AST2600_I2CS_CMD_STS		0x28
> +#define AST2600_I2CS_ACTIVE_ALL			GENMASK(18, 17)
> +#define AST2600_I2CS_PKT_MODE_EN			BIT(16)
> +#define AST2600_I2CS_AUTO_NAK_NOADDR		BIT(15)
> +#define AST2600_I2CS_AUTO_NAK_EN			BIT(14)
> +
> +#define AST2600_I2CS_ALT_EN				BIT(10)
> +#define AST2600_I2CS_RX_DMA_EN			BIT(9)
> +#define AST2600_I2CS_TX_DMA_EN			BIT(8)
> +#define AST2600_I2CS_RX_BUFF_EN			BIT(7)
> +#define AST2600_I2CS_TX_BUFF_EN			BIT(6)
> +#define AST2600_I2CS_RX_CMD_LAST			BIT(4)
> +
> +#define AST2600_I2CS_TX_CMD				BIT(2)
> +
> +#define AST2600_I2CS_DMA_LEN		0x2C
> +#define AST2600_I2CS_SET_RX_DMA_LEN(x)	(((((x) - 1) & GENMASK(11, 0)) << 16) | BIT(31))
> +#define AST2600_I2CS_RX_DMA_LEN_MASK	(GENMASK(11, 0) << 16)
> +
> +#define AST2600_I2CS_SET_TX_DMA_LEN(x)	((((x) - 1) & GENMASK(11, 0)) | BIT(15))
> +#define AST2600_I2CS_TX_DMA_LEN_MASK	GENMASK(11, 0)
> +
> +/* I2CM Master DMA Tx Buffer Register   */
> +#define AST2600_I2CM_TX_DMA			0x30
> +/* I2CM Master DMA Rx Buffer Register	*/
> +#define AST2600_I2CM_RX_DMA			0x34
> +/* I2CS Slave DMA Tx Buffer Register   */
> +#define AST2600_I2CS_TX_DMA			0x38
> +/* I2CS Slave DMA Rx Buffer Register   */
> +#define AST2600_I2CS_RX_DMA			0x3C
> +
> +#define AST2600_I2CS_ADDR_CTRL		0x40
> +
> +#define	AST2600_I2CS_ADDR3_MASK		GENMASK(22, 16)
> +#define	AST2600_I2CS_ADDR2_MASK		GENMASK(14, 8)
> +#define	AST2600_I2CS_ADDR1_MASK		GENMASK(6, 0)

Drop indent after #define

> +
> +#define AST2600_I2CM_DMA_LEN_STS		0x48
> +#define AST2600_I2CS_DMA_LEN_STS		0x4C
> +
> +#define AST2600_I2C_GET_TX_DMA_LEN(x)		((x) & GENMASK(12, 0))
> +#define AST2600_I2C_GET_RX_DMA_LEN(x)		(((x) >> 16) & GENMASK(12, 0))
> +
> +/* 0x40 : Slave Device Address Register */
> +#define AST2600_I2CS_ADDR3_ENABLE			BIT(23)
> +#define AST2600_I2CS_ADDR3(x)			((x) << 16)
> +
> +#define AST2600_I2CS_ADDR2_ENABLE			BIT(15)
> +#define AST2600_I2CS_ADDR2(x)			((x) << 8)
> +#define AST2600_I2CS_ADDR1_ENABLE			BIT(7)
> +#define AST2600_I2CS_ADDR1(x)			(x)
> +
> +#define I2C_SLAVE_MSG_BUF_SIZE		256
> +
> +#define AST2600_I2C_DMA_SIZE		4096
> +
> +#define MASTER_TRIGGER_LAST_STOP	(AST2600_I2CM_RX_CMD_LAST | AST2600_I2CM_STOP_CMD)
> +#define SLAVE_TRIGGER_CMD	(AST2600_I2CS_ACTIVE_ALL | AST2600_I2CS_PKT_MODE_EN)
> +
> +/* i2c timeout counter: use base clk4 1Mhz
> + * 1/(1000/4096) = 4.096ms * 8 = 32.768ms
> + */
> +#define AST_I2C_TIMEOUT_CLK		0x2
> +#define AST_I2C_TIMEOUT_COUNT	0x8
> +
> +struct ast2600_i2c_timing_table {
> +	u32 divisor;
> +	u32 timing;
> +};
> +
> +enum xfer_mode {
> +	BYTE_MODE = 0,
> +	BUFF_MODE,
> +	DMA_MODE,
> +};
> +
> +struct ast2600_i2c_bus {
> +	struct i2c_adapter		adap;
> +	struct device			*dev;
> +	void __iomem			*reg_base;
> +	struct regmap			*gr_regmap;
> +	struct reset_control		*rst;
> +	int				irq;
> +	enum xfer_mode			mode;
> +	struct clk			*clk;
> +	u32				apb_clk;
> +	u32				bus_frequency;
> +	int				slave_operate;
> +	int				timeout_enable;
> +	/* smbus alert */
> +	int				alert_enable;
> +	struct i2c_smbus_alert_setup	alert_data;
> +	struct i2c_client		*ara;
> +	/* Multi-master */
> +	bool				multi_master;
> +	/* master structure */
> +	int				cmd_err;
> +	struct completion		cmd_complete;
> +	struct i2c_msg			*msgs;
> +	size_t				buf_index;
> +	/* cur xfer msgs index*/
> +	int				msgs_index;
> +	int				msgs_count;
> +	u8				*master_safe_buf;
> +	dma_addr_t			master_dma_addr;
> +	/*total xfer count */
> +	int				master_xfer_cnt;
> +	/* Buffer mode */
> +	void __iomem			*buf_base;
> +	size_t				buf_size;
> +	/* Slave structure */
> +	int				slave_xfer_len;
> +	int				slave_xfer_cnt;
> +#ifdef CONFIG_I2C_SLAVE
> +	unsigned char			*slave_dma_buf;
> +	dma_addr_t			slave_dma_addr;
> +	struct i2c_client		*slave;
> +#endif
> +};
> +

(...)

> +
> +	//Check 0x14's SDA and SCL status

Use Linux coding style. See Coding style document.

> +	state = readl(i2c_bus->reg_base + AST2600_I2CC_STS_AND_BUFF);
> +	if (!(state & AST2600_I2CC_SDA_LINE_STS) && (state & AST2600_I2CC_SCL_LINE_STS)) {
> +		writel(AST2600_I2CM_RECOVER_CMD_EN, i2c_bus->reg_base + AST2600_I2CM_CMD_STS);
> +		r = wait_for_completion_timeout(&i2c_bus->cmd_complete, i2c_bus->adap.timeout);
> +		if (r == 0) {
> +			dev_dbg(i2c_bus->dev, "recovery timed out\n");
> +			ret = -ETIMEDOUT;
> +		} else {
> +			if (i2c_bus->cmd_err) {
> +				dev_dbg(i2c_bus->dev, "recovery error\n");
> +				ret = -EPROTO;
> +			}
> +		}
> +	}
> +
> +	dev_dbg(i2c_bus->dev, "Recovery done [%x]\n",
> +		readl(i2c_bus->reg_base + AST2600_I2CC_STS_AND_BUFF));
> +	if (readl(i2c_bus->reg_base + AST2600_I2CC_STS_AND_BUFF) & AST2600_I2CC_BUS_BUSY_STS) {
> +		dev_dbg(i2c_bus->dev, "Can't recovery bus [%x]\n",
> +			readl(i2c_bus->reg_base + AST2600_I2CC_STS_AND_BUFF));
> +	}
> +
> +	writel(ctrl, i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
> +	return ret;
> +}
> +
> +#ifdef CONFIG_I2C_SLAVE
> +static void ast2600_i2c_slave_packet_dma_irq(struct ast2600_i2c_bus *i2c_bus, u32 sts)
> +{
> +	int slave_rx_len;
> +	u32 cmd = 0;
> +	u8 value;
> +	int i = 0;
> +
> +	sts &= ~(AST2600_I2CS_SLAVE_PENDING);
> +	/* Handle i2c slave timeout condition */
> +	if (AST2600_I2CS_INACTIVE_TO & sts) {
> +		cmd = SLAVE_TRIGGER_CMD;
> +		cmd |= AST2600_I2CS_RX_DMA_EN;
> +		writel(AST2600_I2CS_SET_RX_DMA_LEN(I2C_SLAVE_MSG_BUF_SIZE),
> +		       i2c_bus->reg_base + AST2600_I2CS_DMA_LEN);
> +		writel(cmd, i2c_bus->reg_base + AST2600_I2CS_CMD_STS);
> +		i2c_slave_event(i2c_bus->slave, I2C_SLAVE_STOP, &value);
> +		return;
> +	}
> +
> +	sts &= ~(AST2600_I2CS_PKT_DONE | AST2600_I2CS_PKT_ERROR);
> +
> +	switch (sts) {
> +	case AST2600_I2CS_SLAVE_MATCH | AST2600_I2CS_RX_DONE | AST2600_I2CS_WAIT_RX_DMA:
> +	case AST2600_I2CS_SLAVE_MATCH | AST2600_I2CS_WAIT_RX_DMA:
> +		i2c_slave_event(i2c_bus->slave, I2C_SLAVE_WRITE_REQUESTED, &value);
> +		slave_rx_len = AST2600_I2C_GET_RX_DMA_LEN(readl(i2c_bus->reg_base +
> +						      AST2600_I2CS_DMA_LEN_STS));
> +		for (i = 0; i < slave_rx_len; i++) {
> +			i2c_slave_event(i2c_bus->slave, I2C_SLAVE_WRITE_RECEIVED,
> +					&i2c_bus->slave_dma_buf[i]);
> +		}
> +		writel(AST2600_I2CS_SET_RX_DMA_LEN(I2C_SLAVE_MSG_BUF_SIZE),
> +				i2c_bus->reg_base + AST2600_I2CS_DMA_LEN);
> +		cmd = SLAVE_TRIGGER_CMD | AST2600_I2CS_RX_DMA_EN;
> +		break;
> +	case AST2600_I2CS_SLAVE_MATCH | AST2600_I2CS_STOP:
> +		i2c_slave_event(i2c_bus->slave, I2C_SLAVE_STOP, &value);
> +		writel(AST2600_I2CS_SET_RX_DMA_LEN(I2C_SLAVE_MSG_BUF_SIZE),
> +				i2c_bus->reg_base + AST2600_I2CS_DMA_LEN);
> +		cmd = SLAVE_TRIGGER_CMD | AST2600_I2CS_RX_DMA_EN;
> +		break;
> +	case AST2600_I2CS_SLAVE_MATCH | AST2600_I2CS_RX_DONE_NAK |
> +			AST2600_I2CS_RX_DONE | AST2600_I2CS_STOP:
> +	case AST2600_I2CS_SLAVE_MATCH | AST2600_I2CS_WAIT_RX_DMA |
> +			AST2600_I2CS_RX_DONE | AST2600_I2CS_STOP:
> +	case AST2600_I2CS_RX_DONE_NAK | AST2600_I2CS_RX_DONE | AST2600_I2CS_STOP:
> +	case AST2600_I2CS_RX_DONE | AST2600_I2CS_WAIT_RX_DMA | AST2600_I2CS_STOP:
> +	case AST2600_I2CS_RX_DONE | AST2600_I2CS_STOP:
> +	case AST2600_I2CS_RX_DONE | AST2600_I2CS_WAIT_RX_DMA:
> +	case AST2600_I2CS_SLAVE_MATCH | AST2600_I2CS_RX_DONE | AST2600_I2CS_STOP:
> +		if (sts & AST2600_I2CS_SLAVE_MATCH)
> +			i2c_slave_event(i2c_bus->slave, I2C_SLAVE_WRITE_REQUESTED, &value);
> +
> +		slave_rx_len = AST2600_I2C_GET_RX_DMA_LEN(readl(i2c_bus->reg_base +
> +						      AST2600_I2CS_DMA_LEN_STS));
> +		for (i = 0; i < slave_rx_len; i++) {
> +			i2c_slave_event(i2c_bus->slave, I2C_SLAVE_WRITE_RECEIVED,
> +					&i2c_bus->slave_dma_buf[i]);
> +		}
> +		writel(AST2600_I2CS_SET_RX_DMA_LEN(I2C_SLAVE_MSG_BUF_SIZE),
> +		       i2c_bus->reg_base + AST2600_I2CS_DMA_LEN);
> +		if (sts & AST2600_I2CS_STOP)
> +			i2c_slave_event(i2c_bus->slave, I2C_SLAVE_STOP, &value);
> +		cmd = SLAVE_TRIGGER_CMD | AST2600_I2CS_RX_DMA_EN;
> +		break;
> +
> +	/* it is Mw data Mr coming -> it need send tx */
> +	case AST2600_I2CS_RX_DONE | AST2600_I2CS_WAIT_TX_DMA:
> +	case AST2600_I2CS_SLAVE_MATCH | AST2600_I2CS_RX_DONE | AST2600_I2CS_WAIT_TX_DMA:
> +		/* it should be repeat start read */
> +		if (sts & AST2600_I2CS_SLAVE_MATCH)
> +			i2c_slave_event(i2c_bus->slave, I2C_SLAVE_WRITE_REQUESTED, &value);
> +
> +		slave_rx_len = AST2600_I2C_GET_RX_DMA_LEN(readl(i2c_bus->reg_base +
> +						      AST2600_I2CS_DMA_LEN_STS));
> +		for (i = 0; i < slave_rx_len; i++) {
> +			i2c_slave_event(i2c_bus->slave, I2C_SLAVE_WRITE_RECEIVED,
> +					&i2c_bus->slave_dma_buf[i]);
> +		}
> +		i2c_slave_event(i2c_bus->slave, I2C_SLAVE_READ_REQUESTED,
> +				&i2c_bus->slave_dma_buf[0]);
> +		writel(0, i2c_bus->reg_base + AST2600_I2CS_DMA_LEN_STS);
> +		writel(AST2600_I2CS_SET_TX_DMA_LEN(1),
> +				i2c_bus->reg_base + AST2600_I2CS_DMA_LEN);
> +		cmd = SLAVE_TRIGGER_CMD | AST2600_I2CS_TX_DMA_EN;
> +		break;
> +	case AST2600_I2CS_SLAVE_MATCH | AST2600_I2CS_WAIT_TX_DMA:
> +		/* First Start read */
> +		i2c_slave_event(i2c_bus->slave, I2C_SLAVE_READ_REQUESTED,
> +				&i2c_bus->slave_dma_buf[0]);
> +		writel(AST2600_I2CS_SET_TX_DMA_LEN(1),
> +				i2c_bus->reg_base + AST2600_I2CS_DMA_LEN);
> +		cmd = SLAVE_TRIGGER_CMD | AST2600_I2CS_TX_DMA_EN;
> +		break;
> +	case AST2600_I2CS_WAIT_TX_DMA:
> +		/* it should be next start read */
> +		i2c_slave_event(i2c_bus->slave, I2C_SLAVE_READ_PROCESSED,
> +				&i2c_bus->slave_dma_buf[0]);
> +		writel(0, i2c_bus->reg_base + AST2600_I2CS_DMA_LEN_STS);
> +		writel(AST2600_I2CS_SET_TX_DMA_LEN(1),
> +				i2c_bus->reg_base + AST2600_I2CS_DMA_LEN);
> +		cmd = SLAVE_TRIGGER_CMD | AST2600_I2CS_TX_DMA_EN;
> +		break;
> +
> +	case AST2600_I2CS_TX_NAK | AST2600_I2CS_STOP:
> +		/* it just tx complete */
> +		i2c_slave_event(i2c_bus->slave, I2C_SLAVE_STOP, &value);
> +		writel(0, i2c_bus->reg_base + AST2600_I2CS_DMA_LEN_STS);
> +		writel(AST2600_I2CS_SET_RX_DMA_LEN(I2C_SLAVE_MSG_BUF_SIZE),
> +		       i2c_bus->reg_base + AST2600_I2CS_DMA_LEN);
> +		cmd = SLAVE_TRIGGER_CMD | AST2600_I2CS_RX_DMA_EN;
> +		break;
> +	case AST2600_I2CS_SLAVE_MATCH | AST2600_I2CS_RX_DONE:
> +		cmd = 0;
> +		i2c_slave_event(i2c_bus->slave, I2C_SLAVE_WRITE_REQUESTED, &value);
> +		break;
> +	case AST2600_I2CS_STOP:
> +		cmd = 0;
> +		i2c_slave_event(i2c_bus->slave, I2C_SLAVE_STOP, &value);
> +		break;
> +	default:
> +		dev_dbg(i2c_bus->dev, "todo slave isr case %x, sts %x\n", sts,
> +			readl(i2c_bus->reg_base + AST2600_I2CC_STS_AND_BUFF));
> +		break;
> +	}
> +
> +	if (cmd)
> +		writel(cmd, i2c_bus->reg_base + AST2600_I2CS_CMD_STS);
> +	writel(AST2600_I2CS_PKT_DONE, i2c_bus->reg_base + AST2600_I2CS_ISR);
> +	readl(i2c_bus->reg_base + AST2600_I2CS_ISR);
> +	dev_dbg(i2c_bus->dev, "cmd %x\n", cmd);
> +}
> +
> +static void ast2600_i2c_slave_packet_buff_irq(struct ast2600_i2c_bus *i2c_bus, u32 sts)
> +{
> +	int slave_rx_len = 0;
> +	u32 cmd = 0;
> +	u8 value;
> +	int i = 0;
> +
> +	//due to master slave is common buffer, so need force the master stop not issue

Ditto... and everywhere else.

(...)

> +
> +static int ast2600_i2c_master_irq(struct ast2600_i2c_bus *i2c_bus)
> +{
> +	u32 sts = readl(i2c_bus->reg_base + AST2600_I2CM_ISR);
> +	u32 ier = readl(i2c_bus->reg_base + AST2600_I2CM_IER);
> +	u32 ctrl = 0;
> +
> +	dev_dbg(i2c_bus->dev, "M sts %x\n", sts);

NAK. Don't drop debugs to interrupt handlers. This might flood the log
and is unusable.

> +	if (!i2c_bus->alert_enable)
> +		sts &= ~AST2600_I2CM_SMBUS_ALT;
> +
> +	if (AST2600_I2CM_BUS_RECOVER_FAIL & sts) {
> +		dev_dbg(i2c_bus->dev, "M clear isr: AST2600_I2CM_BUS_RECOVER_FAIL= %x\n", sts);

No debugs in handlers.

> +		writel(AST2600_I2CM_BUS_RECOVER_FAIL, i2c_bus->reg_base + AST2600_I2CM_ISR);
> +		ctrl = readl(i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
> +		writel(0, i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
> +		writel(ctrl, i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
> +		i2c_bus->cmd_err = -EPROTO;
> +		complete(&i2c_bus->cmd_complete);
> +		return 1;
> +	}
> +
> +	if (AST2600_I2CM_BUS_RECOVER & sts) {
> +		dev_dbg(i2c_bus->dev, "M clear isr: AST2600_I2CM_BUS_RECOVER= %x\n", sts);

Ditto

> +		writel(AST2600_I2CM_BUS_RECOVER, i2c_bus->reg_base + AST2600_I2CM_ISR);
> +		i2c_bus->cmd_err = 0;
> +		complete(&i2c_bus->cmd_complete);
> +		return 1;
> +	}
> +
> +	if (AST2600_I2CM_SMBUS_ALT & sts) {
> +		if (ier & AST2600_I2CM_SMBUS_ALT) {
> +			dev_dbg(i2c_bus->dev, "M clear isr: AST2600_I2CM_SMBUS_ALT= %x\n", sts);

Ditto

> +			/* Disable ALT INT */
> +			writel(ier & ~AST2600_I2CM_SMBUS_ALT, i2c_bus->reg_base + AST2600_I2CM_IER);
> +			i2c_handle_smbus_alert(i2c_bus->ara);
> +			writel(AST2600_I2CM_SMBUS_ALT, i2c_bus->reg_base + AST2600_I2CM_ISR);
> +			dev_err(i2c_bus->dev,
> +				"ast2600_master_alert_recv bus id %d, Disable Alt, Please Imple\n",
> +				i2c_bus->adap.nr);

Really? This is your intention? To print error on every error condition
on every interrupt?

> +			return 1;
> +		}
> +	}
> +
> +	i2c_bus->cmd_err = ast2600_i2c_is_irq_error(sts);
> +	if (i2c_bus->cmd_err) {
> +		dev_dbg(i2c_bus->dev, "received error interrupt: 0x%02x\n", sts);

Drop

> +		writel(AST2600_I2CM_PKT_DONE, i2c_bus->reg_base + AST2600_I2CM_ISR);
> +		complete(&i2c_bus->cmd_complete);
> +		return 1;
> +	}
> +
> +	if (AST2600_I2CM_PKT_DONE & sts) {
> +		ast2600_i2c_master_package_irq(i2c_bus, sts);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t ast2600_i2c_bus_irq(int irq, void *dev_id)
> +{
> +	struct ast2600_i2c_bus *i2c_bus = dev_id;
> +
> +#ifdef CONFIG_I2C_SLAVE
> +	if (readl(i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL) & AST2600_I2CC_SLAVE_EN) {
> +		if (ast2600_i2c_slave_irq(i2c_bus)) {
> +//			dev_dbg(i2c_bus->dev, "bus-%d.slave handle\n", i2c_bus->adap.nr);

Drop

> +			return IRQ_HANDLED;
> +		}
> +	}
> +#endif
> +	return ast2600_i2c_master_irq(i2c_bus) ? IRQ_HANDLED : IRQ_NONE;
> +}
> +

(...)

> +
> +static int ast2600_i2c_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct ast2600_i2c_bus *i2c_bus;
> +	struct resource *res;
> +	u32 global_ctrl;
> +	int ret = 0;
> +
> +	i2c_bus = devm_kzalloc(&pdev->dev, sizeof(*i2c_bus), GFP_KERNEL);
> +	if (!i2c_bus)
> +		return -ENOMEM;
> +
> +	i2c_bus->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
> +	if (IS_ERR(i2c_bus->rst)) {
> +		dev_err(&pdev->dev,
> +			"missing or invalid reset controller device tree entry\n");
> +		goto free_mem;
> +	}
> +	reset_control_deassert(i2c_bus->rst);
> +
> +	i2c_bus->gr_regmap = syscon_regmap_lookup_by_phandle(np, "aspeed,i2c-global");

NAK, undocumented property. This is really untested patchset. Your code
does not match bindings which do not match DTS.

Send entire set - bindings, driver and DTS which all work together.

Further you have several other undocumented properties.

> +	if (IS_ERR(i2c_bus->gr_regmap)) {
> +		dev_err(&pdev->dev, "failed to find ast2600 i2c global regmap\n");
> +		ret = -ENOMEM;
> +		goto free_mem;
> +	}
> +
> +	regmap_read(i2c_bus->gr_regmap, AST2600_I2CG_CTRL, &global_ctrl);
> +	if ((global_ctrl & AST2600_GLOBAL_INIT) != AST2600_GLOBAL_INIT) {
> +		regmap_write(i2c_bus->gr_regmap, AST2600_I2CG_CTRL, AST2600_GLOBAL_INIT);
> +		regmap_write(i2c_bus->gr_regmap, AST2600_I2CG_CLK_DIV_CTRL, I2CCG_DIV_CTRL);
> +	}
> +
> +	i2c_bus->mode = DMA_MODE;
> +	i2c_bus->slave_operate = 0;
> +
> +	if (of_property_read_bool(pdev->dev.of_node, "byte-mode"))

This must be gone from DT, as you do not describe hardware but "force
driver".

> +		i2c_bus->mode = BYTE_MODE;> +
> +	if (of_property_read_bool(pdev->dev.of_node, "buff-mode")) {

This for sure is not property of DT.

> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		if (res && resource_size(res) >= 2)
> +			i2c_bus->buf_base = devm_ioremap_resource(&pdev->dev, res);
> +
> +		if (!IS_ERR_OR_NULL(i2c_bus->buf_base))
> +			i2c_bus->buf_size = resource_size(res)/2;
> +
> +		i2c_bus->mode = BUFF_MODE;
> +	}
> +
> +	if (of_property_read_bool(pdev->dev.of_node, "timeout"))

Also will be gone.

> +		i2c_bus->timeout_enable = 1;
> +
> +	i2c_bus->dev = &pdev->dev;
> +	init_completion(&i2c_bus->cmd_complete);
> +
> +	i2c_bus->reg_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(i2c_bus->reg_base)) {
> +		ret = PTR_ERR(i2c_bus->reg_base);
> +		goto free_mem;
> +	}
> +
> +	i2c_bus->irq = platform_get_irq(pdev, 0);
> +	if (i2c_bus->irq < 0) {
> +		dev_err(&pdev->dev, "no irq specified\n");
> +		ret = -i2c_bus->irq;
> +		goto unmap;
> +	}
> +
> +	platform_set_drvdata(pdev, i2c_bus);
> +
> +	i2c_bus->clk = devm_clk_get(i2c_bus->dev, NULL);
> +	if (IS_ERR(i2c_bus->clk)) {
> +		dev_err(i2c_bus->dev, "no clock defined\n");

use dev_err_probe().

> +		ret = -ENODEV;
> +		goto unmap;
> +	}
> +	i2c_bus->apb_clk = clk_get_rate(i2c_bus->clk);
> +	dev_dbg(i2c_bus->dev, "i2c_bus->apb_clk %d\n", i2c_bus->apb_clk);
> +

NAK, drop useless debug.

> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency", &i2c_bus->bus_frequency);
> +	if (ret < 0) {
> +		dev_warn(&pdev->dev, "Could not read bus-frequency property\n");
> +		i2c_bus->bus_frequency = 100000;
> +	}
> +
> +	/* Initialize the I2C adapter */
> +	i2c_bus->adap.owner = THIS_MODULE;
> +	i2c_bus->adap.algo = &i2c_ast2600_algorithm;
> +	i2c_bus->adap.retries = 0;
> +	i2c_bus->adap.dev.parent = i2c_bus->dev;
> +	i2c_bus->adap.dev.of_node = pdev->dev.of_node;
> +	i2c_bus->adap.algo_data = i2c_bus;
> +	strscpy(i2c_bus->adap.name, pdev->name, sizeof(i2c_bus->adap.name));
> +	i2c_set_adapdata(&i2c_bus->adap, i2c_bus);
> +
> +	ast2600_i2c_init(i2c_bus);
> +
> +	ret = devm_request_irq(&pdev->dev, i2c_bus->irq, ast2600_i2c_bus_irq, 0,
> +			       dev_name(&pdev->dev), i2c_bus);
> +	if (ret < 0)
> +		goto unmap;
> +
> +	if (of_property_read_bool(pdev->dev.of_node, "smbus-alert")) {

There is no such property. Don't add undocumented properties to your code.

> +
> +	return 0;
> +
> +free_irq:
> +	devm_free_irq(&pdev->dev, i2c_bus->irq, i2c_bus);

Why?

> +unmap:
> +	devm_iounmap(&pdev->dev, i2c_bus->reg_base);

Why?

> +free_mem:
> +	devm_kfree(&pdev->dev, i2c_bus);

Why?

> +
> +	return ret;
> +}
> +
> +static int ast2600_i2c_remove(struct platform_device *pdev)
> +{
> +	struct ast2600_i2c_bus *i2c_bus = platform_get_drvdata(pdev);
> +
> +	/* Disable everything. */
> +	writel(0, i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
> +	writel(0, i2c_bus->reg_base + AST2600_I2CM_IER);
> +
> +	devm_free_irq(&pdev->dev, i2c_bus->irq, i2c_bus);
> +
> +	i2c_del_adapter(&i2c_bus->adap);

Wrong order of cleanup. It should be reversed to the probe, unless you
have some reason, but then please explain.

> +
> +#ifdef CONFIG_I2C_SLAVE
> +	/* for memory buffer initial */
> +	if (i2c_bus->mode == DMA_MODE)
> +		dma_free_coherent(i2c_bus->dev, I2C_SLAVE_MSG_BUF_SIZE,
> +				i2c_bus->slave_dma_buf, i2c_bus->slave_dma_addr);
> +#endif
> +
> +	return 0;
> +}
> +
> +static struct platform_driver ast2600_i2c_bus_driver = {
> +	.probe = ast2600_i2c_probe,
> +	.remove = ast2600_i2c_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.of_match_table = ast2600_i2c_bus_of_table,
> +	},
> +};
> +module_platform_driver(ast2600_i2c_bus_driver);
> +
> +MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
> +MODULE_DESCRIPTION("ASPEED AST2600 I2C Controller Driver");
> +MODULE_LICENSE("GPL");

Best regards,
Krzysztof

