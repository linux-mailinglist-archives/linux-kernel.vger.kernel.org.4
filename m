Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFED721F57
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjFEHQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjFEHQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:16:21 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B124DCD;
        Mon,  5 Jun 2023 00:15:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 6BE833200930;
        Mon,  5 Jun 2023 03:05:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 05 Jun 2023 03:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685948710; x=1686035110; bh=J0
        4p8yU7rVE6vzX9z1prBkDXh2NOANidZ1xruSUmk4M=; b=xESH+28mSbNvewmM34
        Up/hdlUILTueD97esgYzbscRd60ilVfcpfoDyon9PX/5I4eb9emZYZttRcap4w2v
        SzbLICvFXf19RbxskQgXMXAgPfMrGgYywpaKgZqN/3FwsZDeNIQuQkHrKXQquX0J
        zGBnY5yV0G05Ffm35nQoCj0l0N3TttlcRFzBZcp/uiSeLT523Q2wTBQuBKAGcFu9
        zXqaQqUgh1+kFRBCsEkM4D9JT0Q9gY8jI80o09gxTbXUcVfR37L+7wFjLyX0cxNa
        er3jk69qZJppf4si3Z/kzBt6POV6a0qbw4kr9VV7V8HwfaCaukUxYIJl+ZAmYlOa
        q1+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685948710; x=1686035110; bh=J04p8yU7rVE6v
        zX9z1prBkDXh2NOANidZ1xruSUmk4M=; b=dcek2dcj4hW59qVxhxiv+1GAwbfJo
        3bI15R9XWreRXA5xZ9t+cgR17I65zcJ55OxOnlHtI7N2ThnLKNKE2eHALF8DygxK
        BFMKCajAz/RWZFhfQVQQJJMB+DPCStWw3ZyKJ3MHQBtMMwbie/ct/9iuTtQU5aqh
        SBqqjFuo6mbxfBnWH8qwfg5jNTPCNcW7THEY+Q/JuxancbNYQttD+fcDzGuu0fCr
        A70MYoD4m7Tz6AYQ29qB16IhmZXjEWp/WJy+FSqdw7cLmZO2uhBL9WcFkIQGEVrx
        oxAREy+RHVvXYbG45AZlJIR4GV21UUBElKxifAvknW5wRJ7J9Y46Gae+w==
X-ME-Sender: <xms:JYl9ZDyzcJN2tZm3qfakgRiI1y5imTGnxR7-MuLB2tRDk5YY_Gxerg>
    <xme:JYl9ZLRUSpN440X5x7P1Vtc0J7p_E8lBgS1af9_M1n9sJcoLS25CKxsoISa4hIME2
    tjWCII_UMiJyaWTOjI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelkedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:JYl9ZNUgEKSUTETrHb50fCTrTlhY_d0UoqghJoTERcOFESCArCNDTQ>
    <xmx:JYl9ZNjEnJfnpsJ9xR98LZyWCSVMml4ov4bLpXCAPEQgtoT9E-uwhA>
    <xmx:JYl9ZFCk_Wk0zlS-yalrBx05lJPokB0F_tRm4KlE81akeqzRimmbng>
    <xmx:Jol9ZPlt20zysWbBHN_DIfEqM8K5Ksh8LY_FKGIz15n8QCzYtKlyFg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5B29EB60086; Mon,  5 Jun 2023 03:05:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <d95d37f5-5bef-43a9-b319-0bbe0ac366b4@app.fastmail.com>
In-Reply-To: <c72f45ec-c185-8676-b31c-ec48cd46278c@linaro.org>
References: <20230603200243.243878-1-varshini.rajendran@microchip.com>
 <20230603200243.243878-2-varshini.rajendran@microchip.com>
 <c72f45ec-c185-8676-b31c-ec48cd46278c@linaro.org>
Date:   Mon, 05 Jun 2023 09:04:49 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Varshini Rajendran" <varshini.rajendran@microchip.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Sebastian Reichel" <sre@kernel.org>,
        "Mark Brown" <broonie@kernel.org>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        "Balamanikandan Gunasundar" <balamanikandan.gunasundar@microchip.com>,
        "Mihai.Sain" <mihai.sain@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Netdev <netdev@vger.kernel.org>, linux-usb@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Hari.PrasathGE@microchip.com, cristian.birsan@microchip.com,
        durai.manickamkr@microchip.com, manikandan.m@microchip.com,
        dharma.b@microchip.com, nayabbasha.sayed@microchip.com,
        balakrishnan.s@microchip.com
Subject: Re: [PATCH 01/21] dt-bindings: microchip: atmel,at91rm9200-tcb: add sam9x60
 compatible
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023, at 08:35, Krzysztof Kozlowski wrote:
> On 03/06/2023 22:02, Varshini Rajendran wrote:
>> Add sam9x60 compatible string support in the schema file
>> 
>> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
>> ---
>>  .../devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml  | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
>> index a46411149571..c70c77a5e8e5 100644
>> --- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
>> +++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
>> @@ -20,6 +20,7 @@ properties:
>>            - atmel,at91rm9200-tcb
>>            - atmel,at91sam9x5-tcb
>>            - atmel,sama5d2-tcb
>> +          - microchip,sam9x60-tcb
>
> No wildcards.

sam9x60 is the actual name of the chip, it's no wildcard. For sam9x70,
sam9x72 and sam9x75, I think using sam9x7 as the compatible string
is probably fine, as long as they are actually the same chip. Again,
the 'x' in there is not a wildcard but part of the name.

    Arnd
