Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD2C6576E2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 14:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiL1NUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 08:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiL1NUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 08:20:03 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3603E09D;
        Wed, 28 Dec 2022 05:20:02 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BE22E320093C;
        Wed, 28 Dec 2022 08:20:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 28 Dec 2022 08:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672233600; x=1672320000; bh=NnxyuSjPe4
        7CKfUwte6w8c6VBQb/k7DbuSDxv2BLmng=; b=WfyjGyqG12yhYjnnlt5yX0bY/s
        c1uKXrryw2mU/oh5Fta4torBmnvK6GXs+ixYQgL4gehIHdm9+XRIBu9osoGiQBh8
        NeOdLruTyqdEMCeb24P06V9X8UDvPJLMD2AaZKvu1ZEY7E/WOVuj3fale9ntQmU1
        EFx9halZUjzdDE1yM+fe2GvuTfbUCq6J6Rs3xtAhg1lU6fRanJ4eLVxyt54smY7V
        srWk/yLwkm2gjFasXJMcXbHIqGAf4S1e8yRED5PDf2sp8/2J2EqaGaaT5v48PbVZ
        1lnhgkDZ+3xXZdvFPKqDAMM3ZpcrNvd7X8v5wPVkF3fsR9PoYi7e8cxBIbRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672233600; x=
        1672320000; bh=NnxyuSjPe47CKfUwte6w8c6VBQb/k7DbuSDxv2BLmng=; b=t
        78bjezcCqMhL/qEsXN52xffaVFBfszMEfSa6xYQ5qvMnN7yLY6C1CG4+bAz3Jj5p
        t6aA2pP6NBzvLJ44oNUwW5NTeXTOmZO6cUqBAd3GptVTdN06CYe/tCtO1tA9sBcf
        djPOjWvjaMj3xx0KdtR5q6WsQfWmrSt80i4+jcA2iWKeU+EoYVMCU6yQuHAasod4
        x9xhoi48jCod2aUzPDWyWpIPAnYag4UQ/7ud5cUe485LHJ4cNax+wDch8ga//idF
        fOLOyWkcUyPsXuioeM2sNvZc9ZFu6mQTn7szkWhm69Q7/563pe6rLYRjGq4EANZ5
        Crr17XPGzwnKFyI/yurbQ==
X-ME-Sender: <xms:f0KsY4-OCSSwjsN2AxNQN5xWdex9kw4YVm79doe5x4daF3525u-ElQ>
    <xme:f0KsYwtJ8KN9cFNO08g3cgCi0zo6kqXw14L1O3k-QsaP8w9lfq9BIVdCaCAOyvSdq
    aNjvqrC_26ZHiH_hg>
X-ME-Received: <xmr:f0KsY-BTc4Z4uRrH-i8QAtF6P9rRSU2VBdNxBDhmncDeM2JCgWFdooSx5xSXls9CWbyLIt1U0KBoXPihbSfzKn4l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedvgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthekredttdefjeenucfhrhhomhepvfhomhcu
    hfhithiihhgvnhhrhicuoehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhkqe
    enucggtffrrghtthgvrhhnpeeiueelgedvudfhkeeufeeiuefhteeftdffhfefudehjeet
    hedtfeeikeevieffgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:f0KsY4di2bMNhJ7Jj3CMM5B-mA0K4lMHMv38ArJTepf789lv8uSa6w>
    <xmx:f0KsY9MBzATAzVxlLCG_NGVeLZgzgBMY6pY7FNodevssuBN3BKlXmQ>
    <xmx:f0KsYyn16n3v4StfC8hzQQ3csWM_XNST5ty3qJEjrQ_V3nDmPlwFlA>
    <xmx:gEKsY_3s_-bJy5Sl3TehTCToUXiFNdCiYP6xr4uUMNDJVqt61kZK4Q>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 08:19:55 -0500 (EST)
Message-ID: <b7204e9a-cb23-c2ed-88de-0d6271bba98a@tom-fitzhenry.me.uk>
Date:   Thu, 29 Dec 2022 00:19:52 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Martijn Braam <martijn@brixit.nl>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neal Gompa <ngompa13@gmail.com>,
        =?UTF-8?Q?Kamil_Trzci=c5=84ski?= <ayufan@ayufan.eu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Robert Mader <robert.mader@posteo.de>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        Ondrej Jirman <megi@xff.cz>, dri-devel@lists.freedesktop.org,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20221227110335.2923359-1-javierm@redhat.com>
 <20221227110335.2923359-5-javierm@redhat.com>
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: Re: [PATCH v3 4/4] arm64: dts: rk3399-pinephone-pro: Add internal
 display support
In-Reply-To: <20221227110335.2923359-5-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/22 22:03, Javier Martinez Canillas wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> The phone's display is using Hannstar LCD panel, and Goodix based
> touchscreen. Support it.
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Co-developed-by: Martijn Braam <martijn@brixit.nl>
> Signed-off-by: Martijn Braam <martijn@brixit.nl>
> Co-developed-by: Kamil Trzciński <ayufan@ayufan.eu>
> Signed-off-by: Kamil Trzciński <ayufan@ayufan.eu>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Tested-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>

Display and touchscreen works on my Pinephone Pro, thanks for the 
mainlining!

> @@ -367,6 +474,10 @@ vcc1v8_codec_en: vcc1v8-codec-en {
>   	};
>   };
>   
> +&pwm0 {
> +	status = "okay";
> +};

Please move &pwm0 before &sdio0, to keep this ~alphabetical.
