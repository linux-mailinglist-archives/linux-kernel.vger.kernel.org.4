Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C84B714F64
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 20:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjE2Sd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 14:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE2Sd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 14:33:26 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199FAC4;
        Mon, 29 May 2023 11:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=D77Hp7t1go5Z1+uiXCnF4+amc9MTSKwzfWot6WkdpQ4=; b=AQ7wO3nT0rdk7HhZCzs9yl3o95
        7PX7MqBvhhWzf60ICDGY6gtko2gjHK1n4s2mpwqrdQenX8U12HLvBlaM+nw1EfQ354lSuWdscyvt2
        fVDbTbH1BLTgixXiTce6v8btFuKpMUdq2Ugkb2yWXPJrihltP0b6zZCw+/l0KBOM7p04=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:35702 helo=debian-acer)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q3hgB-0005hM-DM; Mon, 29 May 2023 14:33:16 -0400
Date:   Mon, 29 May 2023 14:33:14 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230529143314.ac8e6bc1dbf79671cf38e9a1@hugovil.com>
In-Reply-To: <20230529-verify-sympathy-4a486a6cb2c9@spud>
References: <20230529140711.896830-1-hugo@hugovil.com>
        <20230529140711.896830-7-hugo@hugovil.com>
        <20230529-verify-sympathy-4a486a6cb2c9@spud>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v4 6/9] dt-bindings: sc16is7xx: Add property to change
 GPIO function
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 19:19:27 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Mon, May 29, 2023 at 10:07:08AM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Some variants in this series of UART controllers have GPIO pins that
> > are shared between GPIO and modem control lines.
> > 
> > The pin mux mode (GPIO or modem control lines) can be set for each
> > ports (channels) supported by the variant.
> > 
> > This adds a property to the device tree to set the GPIO pin mux to
> > modem control lines on selected ports if needed.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  .../bindings/serial/nxp,sc16is7xx.txt         | 46 +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> > index 0fa8e3e43bf8..74dfbbf7b2cb 100644
> > --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> > +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> > @@ -23,6 +23,9 @@ Optional properties:
> >      1 = active low.
> >  - irda-mode-ports: An array that lists the indices of the port that
> >  		   should operate in IrDA mode.
> > +- nxp,modem-control-line-ports: An array that lists the indices of the port that
> > +				should have shared GPIO lines configured as
> > +				modem control lines.
> >  
> >  Example:
> >          sc16is750: sc16is750@51 {
> > @@ -35,6 +38,26 @@ Example:
> >                  #gpio-cells = <2>;
> >          };
> >  
> > +	sc16is752: sc16is752@54 {
> > +		compatible = "nxp,sc16is752";
> > +		reg = <0x54>;
> > +		clocks = <&clk20m>;
> > +		interrupt-parent = <&gpio3>;
> > +		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> > +		nxp,modem-control-line-ports = <1>; /* Port 1 as modem control lines */
> > +		gpio-controller; /* Port 0 as GPIOs */
> > +		#gpio-cells = <2>;
> > +	};
> > +
> > +	sc16is752: sc16is752@54 {
> > +		compatible = "nxp,sc16is752";
> > +		reg = <0x54>;
> 
> If this were not a txt binding, dt_binding_check would likely complain
> that you have two nodes with the same node address & 3 below.
> If you end up re-submitting, could you change that please?
> Otherwise,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Hi Conor,
for the I2C section, I will use addresse 51, 52 and 54.

For the SPI section, I will use addresse 0, 1 and 2.

I will resubmit if there is a v5.

Thank you, Hugo.
