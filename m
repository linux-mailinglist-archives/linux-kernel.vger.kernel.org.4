Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F43465EF37
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjAEOtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbjAEOtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:49:11 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DBA5AC63;
        Thu,  5 Jan 2023 06:48:56 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 18BDD3200947;
        Thu,  5 Jan 2023 09:48:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 05 Jan 2023 09:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672930134; x=
        1673016534; bh=V6G1v0bX0D4UJNGGt2xLs1w58IJyGOC4jf7dccTEEPM=; b=1
        gZckvrW14EF6QB1iyxkjWAB6iRnHIiVv2ITPJDMOAekUfAtApvHM4joaNEsNOTPz
        dm3iPtBjbXT4UaiyshKQ7x2M9bSXx7PR5x0ao4mHvjuJvXLV5YQjcsIwmdizvyxR
        J8FFXJG4EoWwR3gajt9fQTRjmkPZra4YljZh21KuppF6OBhIzlmdClElEtm2m1tx
        4yiw4oOIoqELlaB5ahYbxjeB6uB7XzysI7VPsqns2BaboVLGIDyBCtsKBx+eSJBP
        sKhMKbVzNp0QwShyyyDt4w0JKxiHp04InkVNB4jDvkhTLK5kHUacKKEkds2otrcd
        xCilLN3Xtiv9UpUJnbqWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672930134; x=
        1673016534; bh=V6G1v0bX0D4UJNGGt2xLs1w58IJyGOC4jf7dccTEEPM=; b=c
        NOnBTbP9S0V2/aQUaA120sVik6fZ0yLzAfug1DGbwRkHr5kGzXq7wLs81ycuGu+S
        pSddtWpa7rIvSaym3JpoG6hsxAbcr4Ga2cWr6hWkM/cN5F04En3rzIQNZ2q6elLe
        n9Y611F4OYGB22rrilQ9mQqAVCR64GxgF96nRaeVqqcpT5fgmLCCSFt+me3GpPa6
        7zqLyHEmY54YecWhB/MfI3973WARveHAUWZaHl5fAIhXltYID+l4BSGxLZEEDhMj
        oatK+gHoGaubk1+APfp0w9EEaB3/N1ROSp3dUpZ9W7+NygTlSOmG9jxDgPGfQfFi
        xYw3BS/RnUVy3dVxqwbWg==
X-ME-Sender: <xms:VuO2Y_NkVNEO0nT_BMvVb77DrTxIi28CSm96zlAn9CwDF011NETtkw>
    <xme:VuO2Y59pmwVnoaXykU-NV9RLgQIww6y6kd7P6f1lUnUxRakts76Xi-b1iQtGvzciu
    kFbD_w2H8dTOa7D3A>
X-ME-Received: <xmr:VuO2Y-QqBTy4JTZ1d_rCLqaM23Fa_KzSSvi1hfjSucarsOpGiD4ouNXPfi2g4BhqAfs_VqgYXARxGsUHj0ULvzvFrZFWA9c2sJyB96bHyUcpufT3-k61FFwqNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeekgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepheffgfegtedttddutdfhfefhgefftdeklefgueeltdettdekgffg
    ueehvdfhffdvnecuffhomhgrihhnpehlihhnuhigqdhsuhhngihirdhorhhgpdhgihhthh
    husgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:VuO2YzuHz7nqtQ1CK9xQOK1ubF4Qr2BoMFzRtn8v2K3OS98dKrCkMg>
    <xmx:VuO2Y3dag6Hskmc6IZJ5Xd_6lHgdqLmZsIYERnaxh3D4Qh_ZmgPMmw>
    <xmx:VuO2Y_0Kz-AfUxMnu_kCWQjpj2xSV-bTlRpBvpAavLLn5Sv0cL8JeQ>
    <xmx:VuO2YyDiQLu7j2MiOI9kd-2203LolwT-LoaxhNGV0RgrSj2KADdDXw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jan 2023 09:48:53 -0500 (EST)
Message-ID: <383edfed-c9fe-9214-5b61-dbe6f017e03a@sholland.org>
Date:   Thu, 5 Jan 2023 08:48:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-sunxi@lists.linux.dev
References: <20221231164628.19688-1-samuel@sholland.org>
 <20221231164628.19688-2-samuel@sholland.org> <Y7ap2dZdCHLNzzHb@aptenodytes>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/4] media: dt-bindings: cedrus: Allow power domain
 references
In-Reply-To: <Y7ap2dZdCHLNzzHb@aptenodytes>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 1/5/23 04:43, Paul Kocialkowski wrote:
> On Sat 31 Dec 22, 10:46, Samuel Holland wrote:
>> The Allwinner D1 SoC contains a separate power domain for its video
>> engine, controlled via the "PPU" power controller. Allow the
>> power-domains property so this can be represented in the devicetree.
> 
> I've been looking around for information regarding the PPU and couldn't find
> anything about it. Do you have some reference where it is mentionned?

There are some oblique references as far back as H6 in some user manuals
(in the bus block diagram and interrupt list) and in the vendor clock
drivers.

I gathered some information here:
https://linux-sunxi.org/PPU

It is used by OpenSBI for CPU idle:
https://github.com/riscv-software-src/opensbi/commit/9dc5ec5c.patch

and I have a series adding PPU support to Linux for the Video Engine:
https://lore.kernel.org/linux-sunxi/20221231160402.16157-1-samuel@sholland.org/

> I do see a power domain driver (apparently for the GPU) on recent allwinner
> kernel releases but that seems to be for arm64 chips only.

Yes, there is an older GPU-specific power domain hardware, and the
generic one found on D1/R528/T113 and newer. However, I found while
writing the Linux driver that the two are more similar than the vendor
drivers would imply. Most of the registers from the old hardware remain
in the new hardware; they just are not used by the new vendor driver. So
you can reference my Linux series for a full register list.

Regards,
Samuel

>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  .../bindings/media/allwinner,sun4i-a10-video-engine.yaml       | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml
>> index 541325f900a1..d5be7f604e8c 100644
>> --- a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml
>> +++ b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml
>> @@ -63,6 +63,9 @@ properties:
>>        CMA pool to use for buffers allocation instead of the default
>>        CMA pool.
>>  
>> +  power-domains:
>> +    maxItems: 1
>> +
>>  required:
>>    - compatible
>>    - reg
>> -- 
>> 2.37.4
>>
> 

