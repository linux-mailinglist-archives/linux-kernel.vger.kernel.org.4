Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41B06C9CED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjC0Hzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjC0Hzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:55:32 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E345E40E1;
        Mon, 27 Mar 2023 00:55:29 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id ED4B5320024A;
        Mon, 27 Mar 2023 03:55:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 27 Mar 2023 03:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=undef.tools; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1679903727; x=1679990127; bh=9Inrf1ZOke+x2q1P5x0Yaqo5GMu+DtQMm2t
        UE2atg+U=; b=E8fDfPjqxMfkNliTqwxFbqAKe5u6GuzECjBRO6dgJLHNofGezwk
        5i/UBav3MvlMOkxvGDTXNuHegTzVwZjoZWvncaDuoxQnDa2mJ34qz0Boz0rN3E8n
        P1SOI/yH0UASz/WaR9b95OAzBM3bO21shwA3DoZry18o+Wq3YXOJ9Htn8N7pMuF0
        CjWbzq6Vlnr5VttVq2drOBsZ/YYpFMkwM+hfeUXv5HIpxbvqgBkKTddv21r+MAek
        SKMISHHHj+SWrbSvmZlyxtFD6XhQ44NEWi98z94ItO918jnuAKiDaaGCNHPBplO6
        AvbTtmaLn9pUuO99CjG4PlWK/yhEqG01HOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679903727; x=1679990127; bh=9Inrf1ZOke+x2q1P5x0Yaqo5GMu+DtQMm2t
        UE2atg+U=; b=DQZETlp5P78NcdUa9qR+Q3GZHzgr+6G2sytU5r8VgI+YqXFS0F2
        R+s45rAsaq/OEBCJ0z82RmZgqCjrTH759QP/mTBb7LL4SR0Md1b6mAiD130lYGpX
        j//Q+VgLnYECDOYBqO4NSb2KrONuRqvqcRyKrXLHbQBRyb+ttSrqM4UNN/cj4Mfy
        HgREg8p9HKjUayAqeQouuEGvy0j4a4bSImnPcEpuseqhcrtuqQU3FOcYnf3ZRaxg
        ktmAEFPpugh3g5xCXBHyNNTk8j8tYdXWXjZrrTBT/Zu8y2yfMwfGmkjnU2L5qzFI
        PInx4iRwCPDM70sCPJcNaoydX/8e6qV02gQ==
X-ME-Sender: <xms:7kshZFVKpbRifoivVRckRW_GqEzxNbIvlcFvTw2g9I3iQts6JVhVHw>
    <xme:7kshZFkge--qWuzITYAYwT2EoyqLtAd6aBUIo7dfNVU5pPb2ajn__6o7Ejo2Yet6K
    ZGvNMx4smlSutXzDXE>
X-ME-Received: <xmr:7kshZBYU6Y0K1NL2x3fP49UGy6-m9omXhbW0Ftbfmaw-pW6f1FWyMv9cWnp9oEPo2htgx98pr52SGCzkGImrB2mD7aIh16IhLRXrx6ntHfJwKX4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehuddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomheplfgr
    rhhrrghhuceokhgvrhhnvghlsehunhguvghfrdhtohholhhsqeenucggtffrrghtthgvrh
    hnpeeggfejtddugfeujeefgeeuieeiudelteeukeffhfeikeduudevtddvhfdtjeduheen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhgvrhhnvghlsehunhguvghfrdhtohholhhs
X-ME-Proxy: <xmx:7kshZIW9dLHHp6LgwLxp__BwG8uIQBeWwbMJjghe1SKgyt9tvAaclg>
    <xmx:7kshZPnz2bkQwt2_g5BgTX_4xbCGXPkhkJrL8fgJVfb3JPe1fETLxQ>
    <xmx:7kshZFczcUvxPIGMlwv0Ly3FrB1fNwMGknc9y-CTLb1zgiPIhj1KwA>
    <xmx:70shZHkkaTltQkfZMJJ3TC0wrKAAwhKusno-62j8d1xCkdovOQJVXA>
Feedback-ID: id76147eb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Mar 2023 03:55:21 -0400 (EDT)
Message-ID: <e4f82c1e-621e-7e94-497d-8c579264f996@undef.tools>
Date:   Mon, 27 Mar 2023 18:55:15 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] arm64: dts: rk3399-pinephone-pro: Add internal display
 support
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Robert Mader <robert.mader@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Ondrej Jirman <megi@xff.cz>, Martijn Braam <martijn@brixit.nl>,
        =?UTF-8?Q?Kamil_Trzci=c5=84ski?= <ayufan@ayufan.eu>,
        Caleb Connolly <kc@postmarketos.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20230327074136.1459212-1-javierm@redhat.com>
Content-Language: en-US
From:   Jarrah <kernel@undef.tools>
In-Reply-To: <20230327074136.1459212-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On 3/27/23 18:41, Javier Martinez Canillas wrote:
> From: Ondrej Jirman <megi@xff.cz>
>
> The phone's display is using a Hannstar LCD panel. Support it by adding a
> panel DT node and all needed nodes (backlight, MIPI DSI, regulators, etc).
>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Co-developed-by: Martijn Braam <martijn@brixit.nl>
> Co-developed-by: Kamil Trzciński <ayufan@ayufan.eu>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>
> Changes in v2:
> - Drop touchscreen node because used the wrong compatible (Ondrej Jirman).


Any reason not to include this with the correct compatible string? It's 
been available since 
https://lore.kernel.org/all/20220813043821.9981-1-kernel@undef.tools/. 
Swapping out gt917s for gt1158 in the node from your previous patch 
should be enough.

Thanks,

Jarrah.

