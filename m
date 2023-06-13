Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF82B72E78F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242476AbjFMPpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242956AbjFMPou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:44:50 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7E8127;
        Tue, 13 Jun 2023 08:44:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id DC23D320095F;
        Tue, 13 Jun 2023 11:44:44 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 13 Jun 2023 11:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686671084; x=1686757484; bh=k3ek7V5og/jAxqAHyIbXVs/nCJAhWpzv8iS
        ulQtMJ8I=; b=i25fvbZ43tfLcBg7k45NhbybIbPtwaulSRLXfJ66DaQlcXJSABL
        r7eWKY6K7m3XIJQVWFNglIOCiR9bsRX9/GUBj+llF3lM4N56JijzFcD/7mtFcYxg
        jAt+m4f2D+CqV0xv9u4LcPsKnNvhpd70vvUhTYrhhRIbiraMVxw3ukhuJi5PZkVE
        Xjjb4yN+c85byOxnXUG5Q8Rqu8Iwy9b78K6Z89+wSUsCk0/rNIKw2r9rMHphg1r0
        gmi7QX0lAUcdZQoXwReWV1+NvicsoCA3N06Aopffw60nVcoYMEOFX6UlweNfKjLA
        zTl39n/blZJsjuVcTnAwuqrYbas4Y/7uA+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1686671084; x=1686757484; bh=k3ek7V5og/jAxqAHyIbXVs/nCJAhWpzv8iS
        ulQtMJ8I=; b=I418A2xfI25DMobOpjWKbzVLIpNs13e84N9THqgblB4uJe3UNPJ
        ih+TfVqdy9Sa/0gyf8o2OXq0VNUWTVNeTuOchjzVlOzisJkG20nnAGnJppJImi57
        sBxTAnFDc4MC9ajdW2o+gDKy4F9DxR/GN2BnXJGEwta1cKAXd/LTJzQMhJsmJDqK
        Irk+LFRV9clRB+VuQsEL//zTaW+eFH/jYv3UEeXRDJxLbQmpQnZMx9RdIwkI9ahp
        q8AiV1X1qBpYGuiD5XfkX7NSp5LqgQq22FNku+iXkxQyiA18pF3afy4HOlyOxq2z
        wGSYHVweeJK3UMkv/jOnniMHGgvVDLDnEsQ==
X-ME-Sender: <xms:646IZEQzojVj5xZjcSvl6kRZkc_i_T5KgclETuTg-EEPBeZl_cHTow>
    <xme:646IZBwIxRJtRLn34PPoxxcKjrU6URojpDzo8zyFfG7ViBZjpKctAn9X_zLDnednf
    __SVRxl913P2JQX9ks>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedujedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:646IZB30Xby_fi7Q1Cyc62rhVyrzNKv3joyg5-E4yn_CXgD5twq9rw>
    <xmx:646IZIBq8hLvqjiSIOzuW2K-nymv4Y2wjgB-rWKyns3AQPkjqyl5eA>
    <xmx:646IZNgcKkc1a-FvHHfcIUjJ9Ku8idAh1sA7PODwY98JPj7j0a9gkQ>
    <xmx:7I6IZGbFSWPsPn9v0o3AjgvqkUPiiqhmRBjUzzXViqSGxhzbhCc7xg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7A948B60086; Tue, 13 Jun 2023 11:44:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-492-g08e3be04ba-fm-20230607.003-g08e3be04
Mime-Version: 1.0
Message-Id: <35e768ad-7f15-48a4-9c38-09570026cf71@app.fastmail.com>
In-Reply-To: <2023061356-matchbook-footwear-d142@gregkh>
References: <20230612025355.547871-1-ychuang570808@gmail.com>
 <20230612025355.547871-2-ychuang570808@gmail.com>
 <2023061338-lunchbox-snorkel-e6a9@gregkh>
 <f8eb6114-8248-8886-b301-c2886e50e016@gmail.com>
 <2023061356-matchbook-footwear-d142@gregkh>
Date:   Tue, 13 Jun 2023 17:44:23 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jacky Huang" <ychuang570808@gmail.com>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, "Lee Jones" <lee@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "Tomer Maimon" <tmaimon77@gmail.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        soc@kernel.org, schung@nuvoton.com, mjchen@nuvoton.com,
        "Jacky Huang" <ychuang3@nuvoton.com>
Subject: Re: [PATCH v14 1/1] tty: serial: Add Nuvoton ma35d1 serial driver support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023, at 16:49, Greg KH wrote:
> On Tue, Jun 13, 2023 at 06:58:32PM +0800, Jacky Huang wrote:
>>=20
>> On 2023/6/13 =E4=B8=8B=E5=8D=88 06:28, Greg KH wrote:
>> > On Mon, Jun 12, 2023 at 02:53:55AM +0000, Jacky Huang wrote:
>> > > From: Jacky Huang <ychuang3@nuvoton.com>
>> > >=20
>> > > This adds UART and console driver for Nuvoton ma35d1 Soc.
>> > > It supports full-duplex communication, FIFO control, and
>> > > hardware flow control.
>> > You get a full 72 columns for your changelog :)
>> >=20
>> > > --- a/include/uapi/linux/serial_core.h
>> > > +++ b/include/uapi/linux/serial_core.h
>> > > @@ -279,4 +279,7 @@
>> > >   /* Sunplus UART */
>> > >   #define PORT_SUNPLUS	123
>> > > +/* Nuvoton MA35 SoC */
>> > > +#define PORT_MA35	124
>> > > +
>> > Why is this change needed?  What userspace code is going to rely on=
 it?
>> >=20
>> > thanks,
>> >=20
>> > greg k-h
>>=20
>> Because the serial driver requires a port->type, and almost all serial
>> drivers defined their port type here. We follow the practice of most =
serial
>> drivers here.
>> If we don't do it this way, we would have to directly assign a value =
to
>> port->type. However, such modifications were questioned in the past,
>> which is why we changed it back to defining the port type in serial_c=
ore.h.
>
> I really really want to get rid of this list, as it's a UAPI that no o=
ne
> uses.  So please don't use it, it doesn't help anything, and while the
> serial driver might require it, it doesn't actually do anything with
> that field, right?  So why don't we just set all of the values to the
> same one?

I don't see how Jacky can come up with a patch to do this correctly
without more specific guidance to what exactly you are looking for,
after the last 123 people that added support for a new port got
that merged.

I checked debian codesearch and found only three obscure packages that
accidentally include this header instead of including linux/serial.h,
a couple of lists of all kernel headers, and none that include it on
purpose. I agree that this header should really not exist in uapi,
but the question is what exactly to do about it.

Possible changes would be:

- add a special value PORT_* constant other than PORT_UNKNOWN that
  can be used by serial drivers instead of a unique value, and
  ensure that the serial core can handle drivers using it.

- move all values used by the 8250 driver from serial_core.h
  to serial.h, as this driver actually uses the constants.

- Move the remaining contents of uapi/linux/serial.h into the=20
  non-uapi version.

- Change all drivers that only reference a single PORT_*
  value to use the generic one.

       Arnd
