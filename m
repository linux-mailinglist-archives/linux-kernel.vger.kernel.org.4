Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA4F723C32
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbjFFIvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjFFIvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:51:09 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CB1EA;
        Tue,  6 Jun 2023 01:51:05 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b038064d97so52315675ad.0;
        Tue, 06 Jun 2023 01:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686041464; x=1688633464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3LyP+Z9NNAVlxInFThzoTXjCjQlj1Y+95abXImuM220=;
        b=W//RhwuIZQPX9tzpKHck+JrB5rbaef5jXmyzVtv/B/pIH0qW2UBIzXQkBEGwqMbPv4
         1KpIlTXFmyK6cpjtl9ndkuJTH+vlzUJQqOM5B/L7Q7hNMMg4/8YjyvmUDj62d7JnYC0J
         tErmOQodV9ir+4AfIIqep+620axSOl2fUfw/5BfmKcT/Yp1aCATnv0PGE495FWa9oE9D
         s3lrHDbaWgIoF9qZatcyCmUi2nYnR9OBvR3C8W24PuT1wKUp+DNsTm0P0/RAW5/ly7SS
         1PQETBWBZXdPfLDF+roDhwvM4+FW0+WTGRm6uxthcEUkpSCVjpXv4URnLRnpMV8CiuuX
         cDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686041464; x=1688633464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LyP+Z9NNAVlxInFThzoTXjCjQlj1Y+95abXImuM220=;
        b=iegXpZL/RnlCtEd1C7PiTqkbXEV1bLpET63AdiNTwwIzRxjJYtBOb0eIEYX9h17lwr
         trxSLQPUTLa86CV9lIZ3BBd0pNXTVyIZqQ1ypw8gkXGV9v/D6g5UtKJ6Ps1RZq/NbCEO
         LtitCM1t7njK+kXpozqrMLWKRKJ4l5Z6ORTUrzhT2InHLZuUDHg3LwljQHK43VpMeqJV
         91jl8azoCpYIeaJq32uqT+NeUCg5lbyUXQTH/r/P+dKjbBrbUBu/XBUefY4um74gOFBt
         j13H0X2ne9duhALHod3T/MHVcQ88MeviUzN8drHHyxFPImsZUAWvRPDsGQtpI96T7ToD
         K+qA==
X-Gm-Message-State: AC+VfDzK42fJeqjcASOT5LGGvSvj8QBbaRf5ecBW3Y++DNIsTXTv8t6a
        EBx48o67VorRoHIoaUg2S5Q=
X-Google-Smtp-Source: ACHHUZ7niiG1opqGZlfRCBDjxeT1R5ZcfkeiMVRVUDL+ULM0PqsKF4GEx0154D98Wn0zo5vKJ+zB1g==
X-Received: by 2002:a17:903:2291:b0:1ac:a88a:70b6 with SMTP id b17-20020a170903229100b001aca88a70b6mr11017125plh.31.1686041464106;
        Tue, 06 Jun 2023 01:51:04 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s8-20020a170902988800b001b23eb0b4bbsm352680plp.147.2023.06.06.01.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 01:51:03 -0700 (PDT)
Message-ID: <33c6f81c-c9a2-2ca6-e9b5-3093a07c65d5@gmail.com>
Date:   Tue, 6 Jun 2023 16:50:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 10/10] tty: serial: Add Nuvoton ma35d1 serial driver
 support
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, tmaimon77@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-serial <linux-serial@vger.kernel.org>, arnd@arndb.de,
        soc@kernel.org, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230605040749.67964-1-ychuang570808@gmail.com>
 <20230605040749.67964-11-ychuang570808@gmail.com>
 <6687b98b-81bd-a6c6-3d38-c1b35b3a1a6@linux.intel.com>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <6687b98b-81bd-a6c6-3d38-c1b35b3a1a6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/6 下午 04:19, Ilpo Järvinen wrote:
> On Mon, 5 Jun 2023, Jacky Huang wrote:
>
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> This adds UART and console driver for Nuvoton ma35d1 Soc.
>> It supports full-duplex communication, FIFO control, and
>> hardware flow control.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> A few stylistic things below, should be easy to address them I think. In
> general, this is in quite good shape already.
>
>> ---
>>   drivers/tty/serial/Kconfig         |  18 +
>>   drivers/tty/serial/Makefile        |   1 +
>>   drivers/tty/serial/ma35d1_serial.c | 808 +++++++++++++++++++++++++++++
>>   include/uapi/linux/serial_core.h   |   3 +
>>   4 files changed, 830 insertions(+)
>>   create mode 100644 drivers/tty/serial/ma35d1_serial.c
>>
>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> index 3e3fb377d90d..71ea5138adce 100644
>> --- a/drivers/tty/serial/Kconfig
>> +++ b/drivers/tty/serial/Kconfig
>> @@ -1555,6 +1555,24 @@ config SERIAL_SUNPLUS_CONSOLE
>>   	  you can alter that using a kernel command line option such as
>>   	  "console=ttySUPx".
>>   
>> +config SERIAL_NUVOTON_MA35D1
>> +	tristate "Nuvoton MA35D1 family UART support"
>> +	depends on ARCH_MA35 || COMPILE_TEST
>> +	select SERIAL_CORE
>> +	help
>> +	  This driver supports Nuvoton MA35D1 family UART ports. If you would
>> +	  like to use them, you must answer Y or M to this option. Note that
>> +	  for use as console, it must be included in kernel and not as a
>> +	  module
>> +
>> +config SERIAL_NUVOTON_MA35D1_CONSOLE
>> +	bool "Console on a Nuvotn MA35D1 family UART port"
>> +	depends on SERIAL_NUVOTON_MA35D1=y
>> +	select SERIAL_CORE_CONSOLE
>> +	help
>> +	  Select this options if you'd like to use the UART port0 of the
>> +	  Nuvoton MA35D1 family as a console.
>> +
>>   endmenu
>>   
>>   config SERIAL_MCTRL_GPIO
>> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
>> index cd9afd9e3018..0e823851c42c 100644
>> --- a/drivers/tty/serial/Makefile
>> +++ b/drivers/tty/serial/Makefile
>> @@ -93,3 +93,4 @@ obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
>>   
>>   obj-$(CONFIG_SERIAL_KGDB_NMI) += kgdb_nmi.o
>>   obj-$(CONFIG_KGDB_SERIAL_CONSOLE) += kgdboc.o
>> +obj-$(CONFIG_SERIAL_NUVOTON_MA35D1) += ma35d1_serial.o
>> diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
>> new file mode 100644
>> index 000000000000..6c19da7731a6
>> --- /dev/null
>> +++ b/drivers/tty/serial/ma35d1_serial.c
>> @@ -0,0 +1,808 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + *  MA35D1 serial driver
>> + *  Copyright (C) 2023 Nuvoton Technology Corp.
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/serial_core.h>
>> +#include <linux/slab.h>
>> +#include <linux/tty_flip.h>
>> +#include <linux/units.h>
>> +
>> +#define MA35_UART_NR		17
>> +
>> +#define MA35_RBR_REG		0x00
>> +#define MA35_THR_REG		0x00
>> +#define MA35_IER_REG		0x04
>> +#define MA35_FCR_REG		0x08
>> +#define MA35_LCR_REG		0x0C
>> +#define MA35_MCR_REG		0x10
>> +#define MA35_MSR_REG		0x14
>> +#define MA35_FSR_REG		0x18
>> +#define MA35_ISR_REG		0x1C
>> +#define MA35_TOR_REG		0x20
>> +#define MA35_BAUD_REG		0x24
>> +#define MA35_ALTCTL_REG		0x2C
>> +#define MA35_FUN_SEL_REG	0x30
>> +#define MA35_WKCTL_REG		0x40
>> +#define MA35_WKSTS_REG		0x44
>> +
>> +/* MA35_IER_REG - Interrupt Enable Register */
>> +#define MA35_IER_RDA_IEN	BIT(0)  /* RBR Available Interrupt Enable */
>> +#define MA35_IER_THRE_IEN	BIT(1)  /* THR Empty Interrupt Enable */
>> +#define MA35_IER_RLS_IEN	BIT(2)  /* RX Line Status Interrupt Enable */
>> +#define MA35_IER_RTO_IEN	BIT(4)  /* RX Time-out Interrupt Enable */
>> +#define MA35_IER_BUFERR_IEN	BIT(5)  /* Buffer Error Interrupt Enable */
>> +#define MA35_IER_TIME_OUT_EN	BIT(11) /* RX Buffer Time-out Counter Enable */
>> +#define MA35_IER_AUTO_RTS	BIT(12) /* nRTS Auto-flow Control Enable */
>> +#define MA35_IER_AUTO_CTS	BIT(13) /* nCTS Auto-flow Control Enable */
>> +
>> +/* MA35_FCR_REG - FIFO Control Register */
>> +#define MA35_FCR_RFR		BIT(1)  /* RX Field Software Reset */
>> +#define MA35_FCR_TFR		BIT(2)  /* TX Field Software Reset */
>> +#define MA35_FCR_RFITL_MASK	GENMASK(7, 4) /* RX FIFO Interrupt Trigger Level */
>> +#define MA35_FCR_RFITL_1BYTE	FIELD_PREP(MA35_FCR_RFITL_MASK, 0)
>> +#define MA35_FCR_RFITL_4BYTES	FIELD_PREP(MA35_FCR_RFITL_MASK, 1)
>> +#define MA35_FCR_RFITL_8BYTES	FIELD_PREP(MA35_FCR_RFITL_MASK, 2)
>> +#define MA35_FCR_RFITL_14BYTES	FIELD_PREP(MA35_FCR_RFITL_MASK, 3)
>> +#define MA35_FCR_RFITL_30BYTES	FIELD_PREP(MA35_FCR_RFITL_MASK, 4)
>> +#define MA35_FCR_RTSTL_MASK	GENMASK(19, 16) /* nRTS Trigger Level */
>> +#define MA35_FCR_RTSTL_1BYTE	FIELD_PREP(MA35_FCR_RTSTL_MASK, 0)
>> +#define MA35_FCR_RTSTL_4BYTES	FIELD_PREP(MA35_FCR_RTSTL_MASK, 1)
>> +#define MA35_FCR_RTSTL_8BYTES	FIELD_PREP(MA35_FCR_RTSTL_MASK, 2)
>> +#define MA35_FCR_RTSTL_14BYTES	FIELD_PREP(MA35_FCR_RTSTL_MASK, 3)
>> +#define MA35_FCR_RTSTLL_30BYTES	FIELD_PREP(MA35_FCR_RTSTL_MASK, 4)
>> +
>> +/* MA35_LCR_REG - Line Control Register */
>> +#define	MA35_LCR_NSB		BIT(2)  /* Number of “STOP Bit” */
>> +#define MA35_LCR_PBE		BIT(3)  /* Parity Bit Enable */
>> +#define MA35_LCR_EPE		BIT(4)  /* Even Parity Enable */
>> +#define MA35_LCR_SPE		BIT(5)  /* Stick Parity Enable */
>> +#define MA35_LCR_BREAK		BIT(6)  /* Break Control */
>> +#define MA35_LCR_WLS_MASK	GENMASK(1, 0) /* Word Length Selection */
>> +#define MA35_LCR_WLS_5BITS	FIELD_PREP(MA35_LCR_WLS_MASK, 0)
>> +#define MA35_LCR_WLS_6BITS	FIELD_PREP(MA35_LCR_WLS_MASK, 1)
>> +#define MA35_LCR_WLS_7BITS	FIELD_PREP(MA35_LCR_WLS_MASK, 2)
>> +#define MA35_LCR_WLS_8BITS	FIELD_PREP(MA35_LCR_WLS_MASK, 3)
>> +
>> +/* MA35_MCR_REG - Modem Control Register */
>> +#define MA35_MCR_RTS_CTRL	BIT(1)  /* nRTS Signal Control */
>> +#define MA35_MCR_RTSACTLV	BIT(9)  /* nRTS Pin Active Level */
>> +#define MA35_MCR_RTSSTS		BIT(13) /* nRTS Pin Status (Read Only) */
>> +
>> +/* MA35_MSR_REG - Modem Status Register */
>> +#define MA35_MSR_CTSDETF	BIT(0)  /* Detect nCTS State Change Flag */
>> +#define MA35_MSR_CTSSTS		BIT(4)  /* nCTS Pin Status (Read Only) */
>> +#define MA35_MSR_CTSACTLV	BIT(8)  /* nCTS Pin Active Level */
>> +
>> +/* MA35_FSR_REG - FIFO Status Register */
>> +#define MA35_FSR_RX_OVER_IF	BIT(0)  /* RX Overflow Error Interrupt Flag */
>> +#define MA35_FSR_PEF		BIT(4)  /* Parity Error Flag*/
>> +#define MA35_FSR_FEF		BIT(5)  /* Framing Error Flag */
>> +#define MA35_FSR_BIF		BIT(6)  /* Break Interrupt Flag */
>> +#define MA35_FSR_RX_EMPTY	BIT(14) /* Receiver FIFO Empty (Read Only) */
>> +#define MA35_FSR_RX_FULL	BIT(15) /* Receiver FIFO Full (Read Only) */
>> +#define MA35_FSR_TX_EMPTY	BIT(22) /* Transmitter FIFO Empty (Read Only) */
>> +#define MA35_FSR_TX_FULL	BIT(23) /* Transmitter FIFO Full (Read Only) */
>> +#define MA35_FSR_TX_OVER_IF	BIT(24) /* TX Overflow Error Interrupt Flag */
>> +#define MA35_FSR_TE_FLAG	BIT(28) /* Transmitter Empty Flag (Read Only) */
>> +#define MA35_FSR_RXPTR_MSK	GENMASK(13, 8) /* TX FIFO Pointer mask */
>> +#define MA35_FSR_TXPTR_MSK	GENMASK(21, 16) /* RX FIFO Pointer mask */
>> +
>> +/* MA35_ISR_REG - Interrupt Status Register */
>> +#define MA35_ISR_RDA_IF		BIT(0)  /* RBR Available Interrupt Flag */
>> +#define MA35_ISR_THRE_IF	BIT(1)  /* THR Empty Interrupt Flag */
>> +#define MA35_ISR_RLSIF		BIT(2)  /* Receive Line Interrupt Flag */
>> +#define MA35_ISR_MODEMIF	BIT(3)  /* MODEM Interrupt Flag */
>> +#define MA35_ISR_RXTO_IF	BIT(4)  /* RX Time-out Interrupt Flag */
>> +#define MA35_ISR_BUFEIF		BIT(5)  /* Buffer Error Interrupt Flag */
>> +#define MA35_ISR_WK_IF		BIT(6)  /* UART Wake-up Interrupt Flag */
>> +#define MA35_ISR_RDAINT		BIT(8)  /* RBR Available Interrupt Indicator */
>> +#define MA35_ISR_THRE_INT	BIT(9)  /* THR Empty Interrupt Indicator */
>> +#define MA35_ISR_ALL		0xFFFFFFFF
>> +
>> +/* MA35_BAUD_REG - Baud Rate Divider Register */
>> +#define	MA35_BAUD_MODE_MASK	GENMASK(29, 28)
>> +#define MA35_BAUD_MODE0		FIELD_PREP(MA35_BAUD_MODE_MASK, 0)
>> +#define MA35_BAUD_MODE1		FIELD_PREP(MA35_BAUD_MODE_MASK, 2)
>> +#define MA35_BAUD_MODE2		FIELD_PREP(MA35_BAUD_MODE_MASK, 3)
>> +#define	MA35_BAUD_MASK		GENMASK(15, 0)
>> +
>> +/* MA35_ALTCTL_REG - Alternate Control/Status Register */
>> +#define MA35_ALTCTL_RS485AUD	BIT(10) /* RS-485 Auto Direction Function */
>> +
>> +/* MA35_FUN_SEL_REG - Function Select Register */
>> +#define MA35_FUN_SEL_MASK	GENMASK(2, 0)
>> +#define MA35_FUN_SEL_UART	FIELD_PREP(MA35_FUN_SEL_MASK, 0)
>> +#define MA35_FUN_SEL_RS485	FIELD_PREP(MA35_FUN_SEL_MASK, 3)
>> +
>> +/* The constrain for MA35D1 UART baud rate divider */
>> +#define MA35_BAUD_DIV_MAX	0xFFFF
>> +#define MA35_BAUD_DIV_MIN	11
>> +
>> +/* UART FIFO depth */
>> +#define MA35_UART_FIFO_DEPTH	32
>> +/* UART console clock */
>> +#define MA35_UART_CONSOLE_CLK	(24 * HZ_PER_MHZ)
>> +/* UART register ioremap size */
>> +#define MA35_UART_REG_SIZE	0x100
>> +/* Rx Timeout */
>> +#define MA35_UART_RX_TOUT	0x40
>> +
>> +#define MA35_ISR_IF_CHECK	(MA35_ISR_RDA_IF | MA35_ISR_RXTO_IF | \
>> +				 MA35_ISR_THRE_INT | MA35_ISR_BUFEIF)
>> +
>> +static struct uart_driver ma35d1serial_reg;
>> +
>> +struct uart_ma35d1_port {
>> +	struct uart_port port;
>> +	struct clk *clk;
>> +	u16 capabilities; /* port capabilities */
>> +	u8 ier;
>> +	u8 lcr;
>> +	u8 mcr;
>> +	u32 baud_rate;
>> +	u32 console_baud_rate;
>> +	u32 console_line;
>> +	u32 console_int;
>> +};
>> +
>> +static struct uart_ma35d1_port ma35d1serial_ports[MA35_UART_NR];
>> +
>> +static struct uart_ma35d1_port *to_ma35d1_uart_port(struct uart_port *uart)
>> +{
>> +	return container_of(uart, struct uart_ma35d1_port, port);
>> +}
>> +
>> +static u32 serial_in(struct uart_ma35d1_port *p, u32 offset)
>> +{
>> +	return readl_relaxed(p->port.membase + offset);
>> +}
>> +
>> +static void serial_out(struct uart_ma35d1_port *p, u32 offset, u32 value)
>> +{
>> +	writel_relaxed(value, p->port.membase + offset);
>> +}
>> +
>> +static void __stop_tx(struct uart_ma35d1_port *p)
>> +{
>> +	u32 ier;
>> +
>> +	ier = serial_in(p, MA35_IER_REG);
>> +	if (ier & MA35_IER_THRE_IEN)
>> +		serial_out(p, MA35_IER_REG, ier & ~MA35_IER_THRE_IEN);
>> +}
>> +
>> +static void ma35d1serial_stop_tx(struct uart_port *port)
>> +{
>> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
>> +
>> +	__stop_tx(up);
>> +}
>> +
>> +static void transmit_chars(struct uart_ma35d1_port *up)
>> +{
>> +	u32 count;
>> +	u8 ch;
>> +
>> +	if (uart_tx_stopped(&up->port)) {
>> +		ma35d1serial_stop_tx(&up->port);
>> +		return;
>> +	}
>> +	count = MA35_UART_FIFO_DEPTH - FIELD_GET(MA35_FSR_TXPTR_MSK,
>> +						 serial_in(up, MA35_FSR_REG));
>> +	uart_port_tx_limited(&up->port, ch, count,
>> +			     !(serial_in(up, MA35_FSR_REG) & MA35_FSR_TX_FULL),
>> +			     serial_out(up, MA35_THR_REG, ch),
>> +			     ({}));
>> +}
>> +
>> +static void ma35d1serial_start_tx(struct uart_port *port)
>> +{
>> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
>> +	u32 ier;
>> +
>> +	ier = serial_in(up, MA35_IER_REG);
>> +	serial_out(up, MA35_IER_REG, ier & ~MA35_IER_THRE_IEN);
>> +	transmit_chars(up);
>> +	serial_out(up, MA35_IER_REG, ier | MA35_IER_THRE_IEN);
>> +}
>> +
>> +static void ma35d1serial_stop_rx(struct uart_port *port)
>> +{
>> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
>> +
>> +	serial_out(up, MA35_IER_REG, serial_in(up, MA35_IER_REG) & ~MA35_IER_RDA_IEN);
> These should be split up to:
> 	reg = serial_in(...)
> 	reg &= ~MA35_IER_RDA_IEN;
> 	serial_out(...)
>
> There are other cases too besides this one, convert them all. It will help
> with some line splitting challenges too you seem to have below.
>
>> +}
>> +
>> +static void receive_chars(struct uart_ma35d1_port *up)
>> +{
>> +	u8 ch, flag;
>> +	u32 fsr;
>> +	int max_count = 256;
>> +
>> +	fsr = serial_in(up, MA35_FSR_REG);
>> +	do {
>> +		flag = TTY_NORMAL;
>> +		up->port.icount.rx++;
>> +
>> +		if (unlikely(fsr & (MA35_FSR_BIF | MA35_FSR_FEF |
>> +				    MA35_FSR_PEF | MA35_FSR_RX_OVER_IF))) {
>> +			if (fsr & MA35_FSR_BIF) {
>> +				up->port.icount.brk++;
>> +				if (uart_handle_break(&up->port))
>> +					continue;
>> +			}
>> +			if (fsr & MA35_FSR_FEF)
>> +				up->port.icount.frame++;
>> +			if (fsr & MA35_FSR_PEF)
>> +				up->port.icount.parity++;
>> +			if (fsr & MA35_FSR_RX_OVER_IF)
>> +				up->port.icount.overrun++;
>> +
>> +			serial_out(up, MA35_FSR_REG,
>> +				   fsr & (MA35_FSR_BIF | MA35_FSR_FEF |
>> +					  MA35_FSR_PEF | MA35_FSR_RX_OVER_IF));
>> +			if (fsr & MA35_FSR_BIF)
>> +				flag = TTY_BREAK;
>> +			else if (fsr & MA35_FSR_PEF)
>> +				flag = TTY_PARITY;
>> +			else if (fsr & MA35_FSR_FEF)
>> +				flag = TTY_FRAME;
>> +		}
>> +
>> +		ch = serial_in(up, MA35_RBR_REG);
>> +		if (uart_handle_sysrq_char(&up->port, ch))
>> +			continue;
>> +
>> +		spin_lock(&up->port.lock);
>> +		uart_insert_char(&up->port, fsr, MA35_FSR_RX_OVER_IF, ch, flag);
>> +		spin_unlock(&up->port.lock);
>> +
>> +		fsr = serial_in(up, MA35_FSR_REG);
>> +	} while (!(fsr & MA35_FSR_RX_EMPTY) && (max_count-- > 0));
>> +
>> +	spin_lock(&up->port.lock);
>> +	tty_flip_buffer_push(&up->port.state->port);
>> +	spin_unlock(&up->port.lock);
>> +}
>> +
>> +static irqreturn_t ma35d1serial_interrupt(int irq, void *dev_id)
>> +{
>> +	struct uart_port *port = dev_id;
>> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
>> +	u32 isr, fsr;
>> +
>> +	isr = serial_in(up, MA35_ISR_REG);
>> +	fsr = serial_in(up, MA35_FSR_REG);
>> +
>> +	if (!(isr & MA35_ISR_IF_CHECK))
>> +		return IRQ_NONE;
>> +
>> +	if (isr & (MA35_ISR_RDA_IF | MA35_ISR_RXTO_IF))
>> +		receive_chars(up);
>> +	if (isr & MA35_ISR_THRE_INT)
>> +		transmit_chars(up);
>> +	if (fsr & MA35_FSR_TX_OVER_IF)
>> +		serial_out(up, MA35_FSR_REG, MA35_FSR_TX_OVER_IF);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static u32 ma35d1serial_tx_empty(struct uart_port *port)
>> +{
>> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
>> +	u32 fsr;
>> +
>> +	fsr = serial_in(up, MA35_FSR_REG);
>> +	return (fsr & (MA35_FSR_TE_FLAG | MA35_FSR_TX_EMPTY)) ==
>> +		(MA35_FSR_TE_FLAG | MA35_FSR_TX_EMPTY) ? TIOCSER_TEMT : 0;
> To make this check cleaner, add this and use it here:
>
> #define MA35_FSR_TX_BOTH_EMPTY	(MA35_FSR_TE_FLAG | MA35_FSR_TX_EMPTY)
>
>> +}
>> +
>> +static u32 ma35d1serial_get_mctrl(struct uart_port *port)
>> +{
>> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
>> +	u32 status;
>> +	u32 ret = 0;
>> +
>> +	status = serial_in(up, MA35_MSR_REG);
>> +	if (!(status & MA35_MSR_CTSSTS))
>> +		ret |= TIOCM_CTS;
>> +	return ret;
>> +}
>> +
>> +static void ma35d1serial_set_mctrl(struct uart_port *port, u32 mctrl)
>> +{
>> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
>> +	u32 mcr;
>> +	u32 ier;
>> +
>> +	mcr = serial_in(up, MA35_MCR_REG);
>> +	mcr &= ~MA35_MCR_RTS_CTRL;
>> +
>> +	if (mctrl & TIOCM_RTS)
>> +		mcr |= MA35_MCR_RTSACTLV;
>> +	else
>> +		mcr &= ~MA35_MCR_RTSACTLV;
>> +
>> +	if (up->mcr & UART_MCR_AFE) {
>> +		serial_out(up, MA35_IER_REG, (serial_in(up, MA35_IER_REG) |
>> +					     MA35_IER_AUTO_RTS |
>> +					     MA35_IER_AUTO_CTS));
>> +		up->port.flags |= UPF_HARD_FLOW;
>> +	} else {
>> +		ier = serial_in(up, MA35_IER_REG);
>> +		ier &= ~(MA35_IER_AUTO_RTS | MA35_IER_AUTO_CTS);
>> +		serial_out(up, MA35_IER_REG, ier);
>> +		up->port.flags &= ~UPF_HARD_FLOW;
>> +	}
>> +	serial_out(up, MA35_MSR_REG, (serial_in(up, MA35_MSR_REG) |
>> +				     MA35_MSR_CTSACTLV));
>> +	serial_out(up, MA35_MCR_REG, mcr);
>> +}
>> +
>> +static void ma35d1serial_break_ctl(struct uart_port *port, int break_state)
>> +{
>> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
>> +	unsigned long flags;
>> +	u32 lcr;
>> +
>> +	spin_lock_irqsave(&up->port.lock, flags);
>> +	lcr = serial_in(up, MA35_LCR_REG);
>> +	if (break_state != 0)
>> +		lcr |= MA35_LCR_BREAK;
>> +	else
>> +		lcr &= ~MA35_LCR_BREAK;
>> +	serial_out(up, MA35_LCR_REG, lcr);
>> +	spin_unlock_irqrestore(&up->port.lock, flags);
>> +}
>> +
>> +static int ma35d1serial_startup(struct uart_port *port)
>> +{
>> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
>> +	int retval;
>> +
>> +	/* Reset FIFO */
>> +	serial_out(up, MA35_FCR_REG, MA35_FCR_TFR | MA35_FCR_RFR);
>> +
>> +	/* Clear pending interrupts */
>> +	serial_out(up, MA35_ISR_REG, MA35_ISR_ALL);
>> +
>> +	retval = request_irq(port->irq, ma35d1serial_interrupt, 0,
>> +			     dev_name(port->dev), port);
>> +	if (retval) {
>> +		dev_err(up->port.dev, "request irq failed.\n");
>> +		return retval;
>> +	}
>> +
>> +	serial_out(up, MA35_FCR_REG, serial_in(up, MA35_FCR_REG) |
>> +		   MA35_FCR_RFITL_4BYTES | MA35_FCR_RTSTL_8BYTES);
>> +	serial_out(up, MA35_LCR_REG, MA35_LCR_WLS_8BITS);
>> +	serial_out(up, MA35_TOR_REG, MA35_UART_RX_TOUT);
>> +	serial_out(up, MA35_IER_REG, MA35_IER_RTO_IEN | MA35_IER_RDA_IEN |
>> +		   MA35_IER_TIME_OUT_EN | MA35_IER_BUFERR_IEN);
> Align to the parameter like this:
> 	serial_out(up, MA35_IER_REG, MA35_IER_RTO_IEN | MA35_IER_RDA_IEN |
> 				     MA35_IER_TIME_OUT_EN | MA35_IER_BUFERR_IEN);
>
>
>> +	return 0;
>> +}
>> +
>> +static void ma35d1serial_shutdown(struct uart_port *port)
>> +{
>> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
>> +
>> +	serial_out(up, MA35_IER_REG, 0);
>> +	free_irq(port->irq, port);
>> +}
>> +
>> +static void ma35d1serial_set_termios(struct uart_port *port,
>> +				     struct ktermios *termios,
>> +				     const struct ktermios *old)
>> +{
>> +	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
>> +	u32 lcr = 0;
>> +	unsigned long flags;
>> +	u32 baud, quot;
>> +
>> +	lcr = UART_LCR_WLEN(tty_get_char_size(termios->c_cflag));
>> +
>> +	if (termios->c_cflag & CSTOPB)
>> +		lcr |= MA35_LCR_NSB;
>> +	if (termios->c_cflag & PARENB)
>> +		lcr |= MA35_LCR_PBE;
>> +	if (!(termios->c_cflag & PARODD))
>> +		lcr |= MA35_LCR_EPE;
>> +	if (termios->c_cflag & CMSPAR)
>> +		lcr |= MA35_LCR_SPE;
>> +
>> +	baud = uart_get_baud_rate(port, termios, old,
>> +				  port->uartclk / MA35_BAUD_DIV_MAX,
>> +				  port->uartclk / MA35_BAUD_DIV_MIN);
>> +
>> +	/* MA35D1 UART baud rate equation: baudrate = UART_CLK / (quot + 2) */
>> +	quot = (port->uartclk / baud) - 2;
>> +
>> +	/*
>> +	 * Ok, we're now changing the port state.  Do it with
>> +	 * interrupts disabled.
>> +	 */
>> +	spin_lock_irqsave(&up->port.lock, flags);
>> +
>> +	up->port.read_status_mask = MA35_FSR_RX_OVER_IF;
>> +	if (termios->c_iflag & INPCK)
>> +		up->port.read_status_mask |= MA35_FSR_FEF | MA35_FSR_PEF;
>> +	if (termios->c_iflag & (BRKINT | PARMRK))
>> +		up->port.read_status_mask |= MA35_FSR_BIF;
>> +
>> +	/* Characteres to ignore */
>> +	up->port.ignore_status_mask = 0;
>> +	if (termios->c_iflag & IGNPAR)
>> +		up->port.ignore_status_mask |= MA35_FSR_FEF | MA35_FSR_PEF;
>> +	if (termios->c_iflag & IGNBRK) {
>> +		up->port.ignore_status_mask |= MA35_FSR_BIF;
>> +		/*
>> +		 * If we're ignoring parity and break indicators,
>> +		 * ignore overruns too (for real raw support).
>> +		 */
>> +		if (termios->c_iflag & IGNPAR)
>> +			up->port.ignore_status_mask |= MA35_FSR_RX_OVER_IF;
>> +	}
>> +	if (termios->c_cflag & CRTSCTS)
>> +		up->mcr |= UART_MCR_AFE;
>> +	else
>> +		up->mcr &= ~UART_MCR_AFE;
>> +
>> +	uart_update_timeout(port, termios->c_cflag, baud);
>> +
>> +	ma35d1serial_set_mctrl(&up->port, up->port.mctrl);
>> +
>> +	serial_out(up, MA35_BAUD_REG, MA35_BAUD_MODE2 | FIELD_PREP(MA35_BAUD_MASK, quot));
>> +
>> +	serial_out(up, MA35_LCR_REG, lcr);
>> +
>> +	spin_unlock_irqrestore(&up->port.lock, flags);
>> +}
>> +
>> +static const char *ma35d1serial_type(struct uart_port *port)
>> +{
>> +	return port->type == PORT_MA35 ? "ma35d1-uart" : NULL;
>> +}
>> +
>> +static void ma35d1serial_config_port(struct uart_port *port, int flags)
>> +{
>> +	if (flags & UART_CONFIG_TYPE)
>> +		port->type = PORT_MA35;
>> +}
>> +
>> +static int ma35d1serial_verify_port(struct uart_port *port, struct serial_struct *ser)
>> +{
>> +	if (port->type != PORT_UNKNOWN && ser->type != PORT_MA35)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct uart_ops ma35d1serial_ops = {
>> +	.tx_empty     = ma35d1serial_tx_empty,
>> +	.set_mctrl    = ma35d1serial_set_mctrl,
>> +	.get_mctrl    = ma35d1serial_get_mctrl,
>> +	.stop_tx      = ma35d1serial_stop_tx,
>> +	.start_tx     = ma35d1serial_start_tx,
>> +	.stop_rx      = ma35d1serial_stop_rx,
>> +	.break_ctl    = ma35d1serial_break_ctl,
>> +	.startup      = ma35d1serial_startup,
>> +	.shutdown     = ma35d1serial_shutdown,
>> +	.set_termios  = ma35d1serial_set_termios,
>> +	.type         = ma35d1serial_type,
>> +	.config_port  = ma35d1serial_config_port,
>> +	.verify_port  = ma35d1serial_verify_port,
>> +};
>> +
>> +static const struct of_device_id ma35d1_serial_of_match[] = {
>> +	{ .compatible = "nuvoton,ma35d1-uart" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, ma35d1_serial_of_match);
>> +
>> +#ifdef CONFIG_SERIAL_NUVOTON_MA35D1_CONSOLE
>> +
>> +static struct device_node *ma35d1serial_uart_nodes[MA35_UART_NR];
>> +
>> +static void wait_for_xmitr(struct uart_ma35d1_port *up)
>> +{
>> +	unsigned int tmout;
>> +
>> +	/* Wait up to 10ms for the character(s) to be sent. */
>> +	tmout = 10000;
>> +	while (--tmout) {
>> +		if (serial_in(up, MA35_FSR_REG) & MA35_FSR_TX_EMPTY)
>> +			break;
>> +		udelay(1);
>> +	}
> This can be written as:
>
> 	unsigned int reg;
>
> 	read_poll_timeout_atomic(serial_in, reg, reg & MA35_FSR_TX_EMPTY,
> 				 1, 10000, false,
> 				 up, MA35_FSR_REG);
>
>

Dear Ilpo,

Thank you for your suggestions and the provided examples for modifications.
I will modify the driver based on your suggestions. After a few days, if no
further comments are received, I will submit the next version of this 
one patch.


Best Regards.
Jacky Huang




