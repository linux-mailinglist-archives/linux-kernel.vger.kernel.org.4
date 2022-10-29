Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E58B6124DD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 20:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJ2SRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 14:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2SRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 14:17:48 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6DA3742A;
        Sat, 29 Oct 2022 11:17:39 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 050BE32003D3;
        Sat, 29 Oct 2022 14:17:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 29 Oct 2022 14:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1667067456; x=
        1667153856; bh=kVBk6N/yGZ9tAGNJ6kSU4aOivyafZXMayzGUcpw6CFI=; b=p
        io7zuhv6wY/6zkAwk7bGRGrAr8q5rMpdg7h94jJ2EOs63vVJx70GbMGmM5veUsyv
        m1gRWhGVrW3s5wV7Ml5TwBSew/tc7BYNpWrhFzKYtPx4lkFA1BCHbFo10s6Lu1R1
        GmV3N2kMNAbRCYNgYIobJROqY7v4jqcw2WIYZVEU57uR2xNmpjAQt9uW6OLYFBEx
        431dDpUS0P0kps2NCjcg2hfKUUBRIy1LGUA52KsMOA+S2jdtSYW67mJaV6XicAsa
        2pVZujJQkCD/ReTTdjT3pin+sTm4LiHd/XDOQQ8xOPg4kIAMh2d7TjyyRuBd0SyF
        sziVkAqVc/GxNxxOfgdxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1667067456; x=
        1667153856; bh=kVBk6N/yGZ9tAGNJ6kSU4aOivyafZXMayzGUcpw6CFI=; b=s
        D4G5jWT+qjOh4PqBo8LwTpDuY9nQ3LLQQwV1GkoiUvPSFJl4LnxH3WCfOT8zvoUQ
        ZNPsW58lsHf+ZCBpNC08YH0I28x+YiStvIIxs5kkcsDdNhkfTntKlx2k8yZ75D3f
        H7Crgz11LvYBA8okmBQ6A1h2p8/yJOWmTrcqBOCUt6xptAMDbgEUUwFgX/ZiONcB
        GEUizEJIPaAj0and+PX0Obh+t7uGUGl78Ch4U33YysCQkiSRw+sGs8vGEFxbT/bw
        nYUREoOLiY9+VWORCZzuQc/mwcsPLBLEQ2arSMNQ2zyUc2VsckiooyqXtWZEpIat
        shIkwZcGVVXCgmm3U+I/w==
X-ME-Sender: <xms:O25dY_5HBOYYoqdzRljTYCC8oAumGPppoAtkmKqAthrB6M0Wh3xgmQ>
    <xme:O25dY073nrKLhl-GN0GI0pPVnS894eyX8Yp0MdfR15D0_wgUg7ykr46SrJyK1uzPi
    _1EKS-EaHlSrrAWow>
X-ME-Received: <xmr:O25dY2e4J3ep4qV8vzgpNdbA0n8-Z5-rwldP3LoUvA7YzqzqHsgo1BUXJpfdzgZCItXe3fRi4wrhcWItjjy0y6aHWFWBIg4p2sUVtbh3luNZQ9WicrwVCHupUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdekgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeegudekuedukeduhedthfdtueeujeekleeiveduvefhuefhkeff
    vedtueelhfeftdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehs
    rghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:O25dYwJ6bQEzUwkripURDzw6fgzrALMUSx-WNyqMv6Y9LzKbTs98oQ>
    <xmx:O25dYzKDVmkiLngVYQtkQ-bGteDlXYpvr5it9_7EPZeap2mu75ENRA>
    <xmx:O25dY5xks2IMhMIF47UH7VfWN62nc9XYHLpCnVRopB4N1KR3NIBdXg>
    <xmx:QG5dY0UfvV1RNRLqyImkSyCbm1K1sWMFADUJyvzlEWjXb5KLJ9aLFw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Oct 2022 14:17:30 -0400 (EDT)
Message-ID: <f09812a7-5d7e-f8f8-aba4-7645810a8c52@sholland.org>
Date:   Sat, 29 Oct 2022 13:17:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Max Fierke <max@maxfierke.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20220918034415.74641-1-max@maxfierke.com>
 <20220918034415.74641-2-max@maxfierke.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: vendor-prefixes: Add prefix for
 ClockworkPi
In-Reply-To: <20220918034415.74641-2-max@maxfierke.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On 9/17/22 22:44, Max Fierke wrote:
> Add a prefix for Clockwork Tech LLC, known as ClockworkPi. They
> produce a number of hobbyist devices, including the ClockworkPi
> DevTerm and GameShell.
> 
> Signed-off-by: Max Fierke <max@maxfierke.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 2f0151e9f6be..64f4b899c40c 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -258,6 +258,8 @@ patternProperties:
>      description: Cirrus Logic, Inc.
>    "^cisco,.*":
>      description: Cisco Systems, Inc.
> +  "^clockworkpi,.*":
> +    description: Clockwork Tech LLC

The vendor uses "clockwork" as the prefix in their downstream
devicetrees[1][2][3], so I would suggest using the same here. I think
there is a distinction between "Clockwork" the company and "ClockworkPi"
the product. This is what I did for the board devicetree I sent[4].

Regards,
Samuel

[1]:
https://github.com/clockworkpi/DevTerm/blob/main/Code/patch/armbian_build_a04/userpatches/kernel/sunxi-current/kernel_001_dts.patch#L31
[2]:
https://github.com/clockworkpi/DevTerm/blob/main/Code/patch/armbian_build_a04/userpatches/kernel/sunxi-current/kernel_001_dts.patch#L127
[3]:
https://github.com/clockworkpi/DevTerm/blob/main/Code/patch/armbian_build_a06/patch/kernel-001-a06-dts.patch#L37
[4]:
https://lore.kernel.org/lkml/20220815050815.22340-12-samuel@sholland.org/

>    "^cloudengines,.*":
>      description: Cloud Engines, Inc.
>    "^cnm,.*":

