Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9017E641318
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 03:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbiLCCCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 21:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbiLCCCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 21:02:06 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCDEA9E8D;
        Fri,  2 Dec 2022 18:02:05 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1414F5C0086;
        Fri,  2 Dec 2022 21:02:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 02 Dec 2022 21:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1670032925; x=
        1670119325; bh=S0NzbHNIAiwIskxOXPjYN0odudyl1Jgaifx5SiPE8rU=; b=O
        fD41iGhaxp1TMU39xNDN0hiws8ith/AkDhK0UXzuGCBATOxVhJPKMKXWYCAy3nf9
        UMKD8D8NNCqVy1BN5h7in/cQTaN+BO5aRUGOd9zc73FTxHL9EItPSSrwD3m7+Wfg
        HrbosXwh588WQJcft6CAm7pe4VG4yun8QHMoJZ1SI6jPOidERNuCsry3yaVSgUmm
        Y+WT+yDEZRpsIVbk23TNJzuYaSYSFTKoAhZ5hyDO3Jd4NgP/GoWzAshSZDH2g5ES
        Fn2JKT9/R0oWpj9vBGtKQmL7K0u3K8X/aTka+pHI6VioPYf2fck8MGLxmXxAKy+m
        Tuc+nUmrD7aOgSx7lRggA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1670032925; x=
        1670119325; bh=S0NzbHNIAiwIskxOXPjYN0odudyl1Jgaifx5SiPE8rU=; b=C
        4e31EijofWm+tmlo+sd7gMaDMWfYK0/F1RFudCAkFgFuc3gZBqThm5Zj2h0uUZgJ
        vsG+kLo2qCcUCkCcNlolivEM3/rhjgoPY02LTbvl0QJjVxQJpNja8hNj5QDDiZTQ
        TX13dmZ5EB3mD1jhiJ8JhD4VDRtltIrtQdHdyWHHh3BtUOpzfwavC2qTyE9GeiuZ
        7eTpA597IduJ7iJKpxD01jI4S0vt1pQxPg1YMDIaBuGLwa4EDFTHl3lbZ1jSKqOD
        /eaOgIxNIz0MGvcYQD2TZm0f3tSRDff7/pLAMoHGFjD/L5My8mixd9lw1uHBcsC0
        6FEJuFaGNPJIsKiI3G0Ng==
X-ME-Sender: <xms:HK6KY4pSz1DYBVLjPwswS6-9fkAjPXQ5hahTxdXJa0DOSayNX9cWlA>
    <xme:HK6KY-o8nLcOpbbvcqtAyoOfsdvucRQkgu63KF3GbYfJaJI3gg1sRTbNyFfjwUQR1
    0DMULmWYGLsT9gyfQ>
X-ME-Received: <xmr:HK6KY9ODWJfH5Zfyk-_iuQ6tS1LKdIMuMlFAsdlJ-q5b74cyahyxZit_0Cm86axXbx3HlnOG3-99dbpA_0P8g_xz29ucarlcYWDw3manWENg5vnInaepbpohaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdelgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepjefgfffhudejfedtuedugeeutdetgfeiteffffehjeeugfeuvdeh
    jeetfedtffdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:HK6KY_4eh7xxfsn07JzTdrNdhy9sghN40aL7HFeM8MAwlHidQxTYgw>
    <xmx:HK6KY34qzL2NwZC0SVM8UjAHgskkHl0xYt0N_sth4fLkVuE_pJiJfw>
    <xmx:HK6KY_jnKS9CLM9W-tcisWceuaHZTQlWsCs-s2R3GziZkC8UTRkZQA>
    <xmx:Ha6KY_zpl94MFL4JJcla-uWp5ZhLz8ABLAauiXRtsL00WIOgSTPfVg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Dec 2022 21:02:04 -0500 (EST)
Message-ID: <291a9677-47b9-69e6-0a21-8e7269cfb230@sholland.org>
Date:   Fri, 2 Dec 2022 20:02:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221202081647.3183870-1-uwu@icenowy.me>
 <20221202081647.3183870-6-uwu@icenowy.me>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 5/6] dt-bindings: arm: sunxi: add Rongpin RP-H6B board
In-Reply-To: <20221202081647.3183870-6-uwu@icenowy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/22 02:16, Icenowy Zheng wrote:
> Rongpin RP-H6B is a development board with RP-H6C SoM, which uses an
> Allwinner H6 SoC.
> 
> Add compatible strings for it, including the board-specific compatible
> and the SoM compatible.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes in v2:
> - Add Krzysztof's ACK.
> 
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Samuel Holland <samuel@sholland.org>

