Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11EA62CE7D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiKPXG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiKPXGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:06:23 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B67832B86;
        Wed, 16 Nov 2022 15:06:22 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id F355832009A0;
        Wed, 16 Nov 2022 18:06:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 16 Nov 2022 18:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1668639979; x=
        1668726379; bh=KFtL7NqTvZI+19d8wSLjfwbpth3MGn8P3Kyk3c2j8uk=; b=Y
        /2hKiOIIFYsfIXg0J5dZKNKvzMp9OWgrntt40C+kQzXVR1e7YchwUqrBeXu/1fyw
        iR7sRMez5kZ7XAECqIc8PEZ34q/YGeTIn5eotuwcmo/mBnSACJcElJ60e4IKHxWp
        iAVzx93t2AkJSQKSrIXhFoBQdpBtp1zi5Be/x/C/D/pB93xxiZtWqzsG+i9vXi1i
        C5XvH8xe/sAcJHdJbULQTZh/QotZHWnphJGSlUdgwuSDAWWFJ4HHUy/D1Dk5ZKNw
        4686jozx1olB7vAxIZa6F6ZxZwS1GCAea06DOkhL13srusZkenJ+7eNV0Hrgs8Ea
        N7s2IzLKO6wr3m2aKK4yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668639979; x=
        1668726379; bh=KFtL7NqTvZI+19d8wSLjfwbpth3MGn8P3Kyk3c2j8uk=; b=p
        4H5UU8OWML9T4zxjTvCNG0VDoU/eIqvLh37jaQA1fonADnS7T8Ie9j++2aJnhk6j
        LDzb5w2Osj9Qid/pQjCNNCWwmEq8iiJ5K0qsTGHiC5uQ73KC3XAK3ue546EoPNRq
        Pcj9MtA6fIRZoCo4fP40xVYWUnr9zQTkMGYJN6twucfB/gyNRfORndwKTRsqVGSQ
        19bJQrHpsDEhunWFfegDyD6KKdoOhDCYE5ap8e4oNIRHwQTckvT97wNGQgdhRXgG
        BDv7L+mzuMc433fyn1s0OozIfv8NL+eMpdk9iOfY6AHPt6jOaed6/eCqNGfMBfVu
        m8sRsSgglgSt6z4UaLJ5w==
X-ME-Sender: <xms:6mx1Y3SOTuoXLCcmFztQqqhbzuYh7ViHGBdTH7Z5y_xsqKaHvXJVZg>
    <xme:6mx1Y4z7VIpTFMP9eqeQsS-hpQq2Esz1oSnZNNG4Z25j6dBkSaM79pTfrhRQShL-r
    P36nRMcJAtyIs5ftQ>
X-ME-Received: <xmr:6mx1Y806n4QRQ6ImNnqOrCG4t_EC5dZsYYIDSGLw8aCo_IB75i20IZYktRKi655VWeQNApnuH3UD1PKvcNTVhdA8RmkbW7MTAovIdqGb5BhSgRwFJxgG-edsUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeejgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepkeejleelfeeitdfhtdfgkeeghedufeduueegffdvhfdukeelleef
    tdetjeehuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:6mx1Y3Cjf8YLOykp9SXvg66qy0tr21N39MVl18UlsEefSh2mqBjoiw>
    <xmx:6mx1Ywj7sjhQhwWqz76_J26sNkZVKNNbOwX8XorFzDEBGn_KFzfYIw>
    <xmx:6mx1Y7quBM6C0R-VlzqKu6hQAr4E2rUdH5s5AP8_VsR5EZ7FjNHLOQ>
    <xmx:62x1Y5VwdqdwV8gxgtyobO0f2VKwGn-wjEJJa7MscNhxpM95FwKsiw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Nov 2022 18:06:18 -0500 (EST)
Message-ID: <d58b5b89-380a-d967-9cd0-6dcf1bb9fe4d@sholland.org>
Date:   Wed, 16 Nov 2022 17:06:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/2] media: dt-bindings: allwinner: video-engine: Fix
 number of IOMMU channels
Content-Language: en-US
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221116193105.363297-1-jernej.skrabec@gmail.com>
 <20221116193105.363297-2-jernej.skrabec@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20221116193105.363297-2-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/22 13:31, Jernej Skrabec wrote:
> Cedrus (video engine) on Allwinner H6 actually uses two IOMMU channel,
> not just one. However, Cedrus on SoCs like D1 only uses one channel.
> 
> Allow up to 2 IOMMU channels.
> 
> Fixes: 62a8ccf3a248 ("arm64: dts: allwinner: h6: Fix Cedrus IOMMU usage")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  .../bindings/media/allwinner,sun4i-a10-video-engine.yaml        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml
> index 541325f900a1..257bb372d166 100644
> --- a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml
> +++ b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml
> @@ -55,7 +55,7 @@ properties:
>      description: Phandle to the device SRAM
>  
>    iommus:
> -    maxItems: 1
> +    maxItems: 2

You need to add minItems: 1, or else this will require two items.

Regards,
Samuel

>  
>    memory-region:
>      maxItems: 1

