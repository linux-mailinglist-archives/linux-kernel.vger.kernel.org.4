Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC4961A722
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 04:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiKEDBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 23:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiKEDBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 23:01:24 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A154298A;
        Fri,  4 Nov 2022 20:01:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7FC5E3200495;
        Fri,  4 Nov 2022 23:01:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 04 Nov 2022 23:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1667617282; x=
        1667703682; bh=GTr14r/DVhxNa3bUaiw/EiUiPI9nxDfEqOF6MtdTq9k=; b=W
        ++oHusbnm1iB8F5T+3bq13FIUYbiULNqX7ToFr6kSTvh7WBzGh3b0A03YvtCZ2VZ
        w3/jk6QsfSBfEnz62DX0wYKlC+uXVcqWsd74LrQqtD84R8LNFjf+Bql4nlMHfgvL
        Kv+GYQiBGRUObqT2sOHzXP32/03bOD+2roKYJ6lAWIZjuyD/NPKDpin1KNLBQy+Z
        6zWleCcKmefdPKHYcUtzD2bTmwKIbvz/7VVcZ5LuTd17DAB/PlVl1Foh43HVHjn2
        WjYQSHF23i/gdtrqbrjlBli0azNCHBOi1JdiQYo2Td3U7wHhhSFvYBXxo8fx7d2s
        /uzUEU/bU6Wr1i5DGbjYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1667617282; x=
        1667703682; bh=GTr14r/DVhxNa3bUaiw/EiUiPI9nxDfEqOF6MtdTq9k=; b=d
        ew4Fdx5Q4G3U6oQ5VR92/9j88MiSzaKHhAe5QlwFd6uYv1UlgsOl3KvHd1GySYXc
        6euNBbqQEtHV2GWgOkcd07F4dqVECZQUvYgOI35XxgkhmLKAN4HJO0lvbfxci3qG
        6AMfQWcMUC9tDYtph+JGqYr1bdzczuq+3gTjRHf8yMo+MkAFcSW/RaS7A6UXRKBp
        oth5kw2k/qqhceCf3ttBeDtJnTuDQ0sb6qQKmLPy0d7DQoQnRJz/2y2rfjkeWBzn
        Hjt/fqryBbUldBRXHh2ZCls2L1SlfWF+nUA2LJ1pF53VkxYi8KUPv5kmdqIBoL5J
        Aha0A+NZrGxLXRX19scbA==
X-ME-Sender: <xms:AdJlYzmKrv5q4dzPz3qf0T7zUSlEulAOp9IgBKSyQyB7AJU-f7GTSA>
    <xme:AdJlY20sAmPFwG1DKICGzil2Jd3us-ftg97mVR0WAvuUT073FP07d0R2aYPVxE7z3
    hhfGDtlqw0ugtkYIg>
X-ME-Received: <xmr:AdJlY5ows41Ly55IWOCOVAgEujIdfW9ljxIi3RuZp7yra6jVgTtT0bwxfIeSiHcU0d5aWQ1pm4SAcnNGzTrc4AmpjXSeKHVUuKl2M2xcuo5SEf3HyYMMzaxeqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddvgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepjefgfffhudejfedtuedugeeutdetgfeiteffffehjeeugfeuvdeh
    jeetfedtffdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:AdJlY7l50fHYa3cbn9PWiOz2QBvxGwddx4pX0vgZQy1N1Sx5NU1T2Q>
    <xmx:AdJlYx3OXAp4rzVMFbdeBxo7eooPhf84J3C1O0R5Q4lBgfLIVzgSrA>
    <xmx:AdJlY6tsVHQd3JUe0XYi_g2ZNF3yCYufHz4DopV7XD04hIQMfVnTBw>
    <xmx:AtJlY7x6DK5sd_-kMntyKI4eFoO8L8gtnKUesylppmqtBBmXTmTNuw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Nov 2022 23:01:19 -0400 (EDT)
Message-ID: <dfb0958a-2575-e5f4-a61c-a17297ac6c07@sholland.org>
Date:   Fri, 4 Nov 2022 22:01:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221101123201.3021129-1-jernej.skrabec@gmail.com>
 <20221101123201.3021129-4-jernej.skrabec@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 3/3] arm64: dts: allwinner: h6: Add deinterlace node
In-Reply-To: <20221101123201.3021129-4-jernej.skrabec@gmail.com>
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

On 11/1/22 07:32, Jernej Skrabec wrote:
> H6 has deinterlace core. Add a node for it.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Samuel Holland <samuel@sholland.org>

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 0aa6dfafc197..badc6afd6941 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -154,6 +154,18 @@ mixer0_out_tcon_top_mixer0: endpoint {
>  			};
>  		};
>  
> +		deinterlace@1420000 {
> +			compatible = "allwinner,sun50i-h6-deinterlace";
> +			reg = <0x01420000 0x2000>;

Not that it matters, as long as the range is big enough, but how did you
come up with this size? The only thing I find in the vendor devicetrees
is 0x20c, the offset of the last documented register.

Regards,
Samuel

> +			clocks = <&ccu CLK_BUS_DEINTERLACE>,
> +				 <&ccu CLK_DEINTERLACE>,
> +				 <&ccu CLK_MBUS_DEINTERLACE>;
> +			clock-names = "bus", "mod", "ram";
> +			resets = <&ccu RST_BUS_DEINTERLACE>;
> +			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> +			iommus = <&iommu 2>;
> +		};
> +
>  		video-codec-g2@1c00000 {
>  			compatible = "allwinner,sun50i-h6-vpu-g2";
>  			reg = <0x01c00000 0x1000>;

