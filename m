Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D026E364E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 10:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjDPIyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 04:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjDPIyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 04:54:17 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8347EE2;
        Sun, 16 Apr 2023 01:54:15 -0700 (PDT)
Received: from dungeon.fi (dungeon.fi [IPv6:2a00:d880:11::2cc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kasper)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4PzkWT2GdVz49Q1x;
        Sun, 16 Apr 2023 11:54:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1681635253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5nMXbpDsSDP2uJDYhvOYKtje0EBYRKE7AXenLVV0+Oc=;
        b=Ludl8bYp+1aJGUW1obCxm5OKbfFc/ShYHCvXsqoEjf04uKZqh4cioLpDrN92H3uIYkfNBF
        J7aBgmEs3p6DJs6dU7E6raIceROtjIn8sqMQsojzB5LBs6j4jFj1dWRvHSvATcZTMHzHts
        owqEAsxGgjgbGBdd5iGKrLK6UysPbPBrf7twX5xDE+lIBvvOuCgBTKTKv6KUWN413fL1be
        ZWmQNRjYxdKwD82Lo51FNdRqvZbXxoLxkT4DxbUu1C2e41Jm2pPji/5nedj1TEp9gR35vb
        hXKchKv4ZWriw7aeTlNwC+FJ5cQcPJyuCflc9xkwacbaO+9loe0bzu8hcCm7ug==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1681635253; a=rsa-sha256;
        cv=none;
        b=D4IRqeCjTsnp3U81pClq8py6JPCHe3pXNnphirbG5qev9AIrFbByyUI8VtuLIHa/rPZYXp
        8ehNXswD+tfRMlcXpzc7gVibTid2Jb/t4UiHJQ0M0Iawbfwg2wkt9WvkemksKtr9dn90aO
        fmsGUsYyR5eS1qbH/R9Pp+ckVkRH2Biv2zdhrLex9JYB1Si/VxUI+nGG5HzzevoRXUqRFt
        pFhuaMH/os7DvDl404pbZ6S/nWk/LJYNyMgUnBictzS7YB5JHK/DAFY7MUjdt+xiiJG4jE
        IQrGYm3s5rxy4nQQZ0N5yH94Dgccx8B0A0OSm6zlJQkMMXkk/+V1pH1ps3q4Hw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=kasper smtp.mailfrom=kasper@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1681635253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5nMXbpDsSDP2uJDYhvOYKtje0EBYRKE7AXenLVV0+Oc=;
        b=v9hpXQOryC9F9bAHgWRANFfQqwDuYJK8LvFzQ4UpGBknie3ORB52BV22V4uqlCDA+4JwUj
        nsQ6wBGEXtFKUrz/oIhkyKd3VZYK3hgfMATrm/Cm6YaiyaDxBcK6wYUIfyinztm4XnDdb8
        B7EmkHV0Dwo8W0d/2QQS/ZozICFzdIgKzGM6K5ilNmrR6fSioSY9ExFUNeHK9kmmBjTmqh
        U7r2z2A5XDgl7p2vr+ewUoBgKnDPluDhADJdv2ZqxyMOoC6yGaXERoyC8luD1WWpoRuV4w
        rvxIOaR2gu5AivmJBAcoxShXhqgbbB5gc3gBEKS2cbBIRJ6drRs5LYVPCnxBAA==
Received: from [IPV6:2001:14ba:440a:f000::4] (dktgsyyyyyyyyyyyyyycy-3.rev.dnainternet.fi [IPv6:2001:14ba:440a:f000::4])
        by dungeon.fi (Postfix) with ESMTPSA id 8AB5A3F1CD;
        Sun, 16 Apr 2023 11:54:11 +0300 (EEST)
Message-ID: <57fef05a-e885-f83b-1536-7a9f9e8a4adf@iki.fi>
Date:   Sun, 16 Apr 2023 11:40:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230313010416.845252-1-kasper@iki.fi>
 <20230314070002.1008959-1-kasper@iki.fi>
 <ZDfC9xkDMAJn60jc@hovoldconsulting.com>
From:   Jarkko Sonninen <kasper@iki.fi>
In-Reply-To: <ZDfC9xkDMAJn60jc@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/23 11:53, Johan Hovold wrote:
> On Tue, Mar 14, 2023 at 09:00:01AM +0200, Jarkko Sonninen wrote:
>> Add support for RS-485 in Exar USB adapters.
>> RS-485 mode is controlled by TIOCGRS485 and TIOCSRS485 ioctls.
>> Gpio mode register is set to enable RS-485.
> Which register you use is an implementation details which is not really
> needed in the commit message.
>
> Please say something about how the hardware works and try to describe
> what you are implementing here and perhaps something about what is left
> unsupported (e.g. the fixed rts polarity).

Add support for RS-485 in Exar USB adapters.
RS-485 mode is controlled by TIOCGRS485 and TIOCSRS485 ioctls.
SER_RS485_ENABLED and SER_RS485_RTS_ON_SEND flags are implemented.
There is only one polarity control in Exar for both RTS_ON_SEND and 
RTS_AFTER_SEND.
RS-485 delays and addressing modes are not implemented.

ok ?


>> Signed-off-by: Jarkko Sonninen <kasper@iki.fi>
>> ---
>>
>> In this version only rs485.flags are stored to state.
>> There is no locking as only one bit of the flags is used.
>> ioctl returns -ENOIOCTLCMD as the actual error handling is in tty code.
>>
>>   drivers/usb/serial/xr_serial.c | 62 +++++++++++++++++++++++++++++++++-
>>   1 file changed, 61 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
>> index fdb0aae546c3..7b542ccb6596 100644
>> --- a/drivers/usb/serial/xr_serial.c
>> +++ b/drivers/usb/serial/xr_serial.c
>> @@ -93,6 +93,7 @@ struct xr_txrx_clk_mask {
>>   #define XR_GPIO_MODE_SEL_DTR_DSR	0x2
>>   #define XR_GPIO_MODE_SEL_RS485		0x3
>>   #define XR_GPIO_MODE_SEL_RS485_ADDR	0x4
>> +#define XR_GPIO_MODE_RS485_TX_H		0x8
>>   #define XR_GPIO_MODE_TX_TOGGLE		0x100
>>   #define XR_GPIO_MODE_RX_TOGGLE		0x200
>>   
>> @@ -237,6 +238,7 @@ static const struct xr_type xr_types[] = {
>>   struct xr_data {
>>   	const struct xr_type *type;
>>   	u8 channel;			/* zero-based index or interface number */
>> +	u32 rs485_flags;
>>   };
>>   
>>   static int xr_set_reg(struct usb_serial_port *port, u8 channel, u16 reg, u16 val)
>> @@ -645,9 +647,13 @@ static void xr_set_flow_mode(struct tty_struct *tty,
>>   	/* Set GPIO mode for controlling the pins manually by default. */
>>   	gpio_mode &= ~XR_GPIO_MODE_SEL_MASK;
>>   
>> +	if (data->rs485_flags & SER_RS485_ENABLED)
>> +		gpio_mode |= XR_GPIO_MODE_SEL_RS485 | XR_GPIO_MODE_RS485_TX_H;
>> +	else if (C_CRTSCTS(tty) && C_BAUD(tty) != B0)
>> +		gpio_mode |= XR_GPIO_MODE_SEL_RTS_CTS;
>> +
>>   	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0) {
>>   		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
>> -		gpio_mode |= XR_GPIO_MODE_SEL_RTS_CTS;
>>   		flow = XR_UART_FLOW_MODE_HW;
> The logic here is unnecessarily convoluted here and you also should not
> set hardware flow control mode if rs485 mode is enabled.
>
> Perhaps you can add a local boolean flag to hold the rs485 state and
> test it before the current if-else construct. Then you only enable
> hw-flow when rs485 mode is disabled while stile allowing sw-flow to be
> set (hopefully that's a legal combination, please do try to verify
> that).

I'll implement SER_RS485_RTS_ON_SEND and set XR_GPIO_MODE_RS485_TX_H 
according to it.

I tested sw flow and it works.


> It also looks like you have inverted the RS485 polarity by using
> XR_GPIO_MODE_RS485_TX_H (more on that below).
>
>>   	} else if (I_IXON(tty)) {
>>   		u8 start_char = START_CHAR(tty);
>> @@ -827,6 +833,59 @@ static void xr_set_termios(struct tty_struct *tty,
>>   	xr_set_flow_mode(tty, port, old_termios);
>>   }
>>   
>> +static int xr_get_rs485_config(struct tty_struct *tty,
>> +			 unsigned int __user *argp)
> argp points to struct serial_rs485 to use that as the type rather than
> pointer to unsigned int.
>
>> +{
>> +	struct usb_serial_port *port = tty->driver_data;
>> +	struct xr_data *data = usb_get_serial_port_data(port);
>> +	struct serial_rs485 rs485;
>> +
>> +	dev_dbg(tty->dev, "Flags %02x\n", data->rs485_flags);
> This is not a very informative message. Please add back the function
> prefix so that is also distinguishable from the dev_dbg() in the other
> rs485 helper and use the following format:
>
> 	"%s - flags = 0x%02x\n", __func__, ...
>
> And add a new line here.

I'll remove this debug and add one to xr_set_flow_mode

dev_dbg(&port->dev, "Enabling RS-485\n");

>> +	memset(&rs485, 0, sizeof(rs485));
>> +	rs485.flags = data->rs485_flags;
>> +	if (copy_to_user(argp, &rs485, sizeof(rs485)))
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
>> +
>> +static int xr_set_rs485_config(struct tty_struct *tty,
>> +			 unsigned long __user *argp)
> Use a pointer to the struct here too.
>
>> +{
>> +	struct usb_serial_port *port = tty->driver_data;
>> +	struct xr_data *data = usb_get_serial_port_data(port);
>> +	struct serial_rs485 rs485;
>> +
>> +	if (copy_from_user(&rs485, argp, sizeof(rs485)))
>> +		return -EFAULT;
>> +
>> +	dev_dbg(tty->dev, "Flags %02x\n", rs485.flags);
> Please update the format string as mentioned above.
>
> Add a newline here.

I'll remove this debug.

>> +	data->rs485_flags = rs485.flags & SER_RS485_ENABLED;
>> +	xr_set_flow_mode(tty, port, (const struct ktermios *)0);
> This function accesses tty->termios so you can not call it here without
> any locking as it can change underneath you and nothing currently
> prevents set_termios() from calling the same function in parallel.
>
> If you take a write lock on the termios rw sempahore you can use it also
> to protect the rs485 data instead of relying on implicit atomicity
> rules.
>
> And perhaps you should just copy the entire rs485 struct from the start
> as these devices supports further features which someone may want to
> implement support for later (e.g. delay after send and 9th bit
> addressing).
>
> You should just use NULL for the third (old_termios) argument.
>
>> +
>> +	// Only the enable flag is implemented
> No c99 comments, please.
>
>> +	memset(&rs485, 0, sizeof(rs485));
>> +	rs485.flags = data->rs485_flags;
> This does not look correct given that you set the RS485 TX polarity so
> that RTS is high (logic disable) during TX above.
>
> You need to at least make sure that both the SER_RS485_RTS_ON_SEND and
> SER_RS485_RTS_AFTER_SEND bits match the polarity setting. But perhaps
> you could consider implementing support for configuring the polarity
> from the start.

What should happen if user sets SER_RS485_RTS_ON_SEND=1 and 
SER_RS485_RTS_AFTER_SEND=0 or vice versa ?

There is only one bit for polarity control in the Exar register.

I am thinking of using only SER_RS485_RTS_ON_SEND to control the 
polarity and setting _RTS_AFTER_SEND to the same value.

>> +	if (copy_to_user(argp, &rs485, sizeof(rs485)))
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
>> +
>> +
>> +static int xr_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
>> +{
>> +	void __user *argp = (void __user *)arg;
>> +
>> +	switch (cmd) {
>> +	case TIOCGRS485:
>> +		return xr_get_rs485_config(tty, argp);
>> +	case TIOCSRS485:
>> +		return xr_set_rs485_config(tty, argp);
>> +	}
>> +	return -ENOIOCTLCMD;
>> +}
>> +
>>   static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
>>   {
>>   	int ret;
>> @@ -1010,6 +1069,7 @@ static struct usb_serial_driver xr_device = {
>>   	.set_termios		= xr_set_termios,
>>   	.tiocmget		= xr_tiocmget,
>>   	.tiocmset		= xr_tiocmset,
>> +	.ioctl			= xr_ioctl,
>>   	.dtr_rts		= xr_dtr_rts
>>   };
> Johan

     - Jarkko

