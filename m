Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9302466183D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbjAHSmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjAHSm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:42:28 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F3CD2CF;
        Sun,  8 Jan 2023 10:42:27 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id D6ADE320051E;
        Sun,  8 Jan 2023 13:42:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 08 Jan 2023 13:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1673203343; x=
        1673289743; bh=4HxaoxSmL2YgQvvfelQ6b5kuPAJv1CjzGJUleFxKIpw=; b=Y
        o9uxpsF0+1PzZqxaq1zv3Sp3KhJL0k70tP1taomF6bh3Hci5zHRp9C31rJooYu6b
        qPndPSo4tIq/i8CFO8Q4LYadC/LkqBHUVxhPuih2T4BeB3XaAgf7yk5MKy07S8kX
        p4mSvjGTIwpBvSqACB4eUHqtnnzz0LDS86nnON6nUubsLkgUP/Gh4fDEl+aM6Lt6
        x010wN/jLbEe79pyFjkcOmfJ4n68FoADEziBRqHYbSH+9vFfS9EZvTWdzrP+kv17
        lGHtk42qZO2GTmVyn12+pBWj5bAdXonqou8iN53mGarV2/bChbHqszD1bmFgkRLb
        i/NU0zxw0lD2U5m92dDuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1673203343; x=
        1673289743; bh=4HxaoxSmL2YgQvvfelQ6b5kuPAJv1CjzGJUleFxKIpw=; b=Q
        0bRs+tFJ65qD/ayXF3gBchdZDL5v8ltnehU0+7Ji27PShAOm090RhHeGvKJtI0hB
        sqRDj7psWKjmBy86jLlnFOuQyatKrqARbKuGg/BjdCpTpx9RzWr6D8dIaKFR2Tr2
        nOjZ1LaUd38LOuUNRlR+J58Vso7XTFLeKK+KIL2N72xqBlYu59y1f5LOXeNAa8Sr
        KwTS7PJ6hFwiZgkG9jTvJYyfvJDCI9BRJmhCSzuZmbH26Vu2GoTpqX3Od82bsbd7
        q/kDP4Y4FsMhPN7ENIoYORbXI7egItIEYayOA1xsOuLaYPa6mSmT+feaARw6g9+M
        7h5oHrKqnc6hdFPoVPgUg==
X-ME-Sender: <xms:jg67Y7-N5CD-ZEGT6j6ZDqH0_UgBac0unneKBUSqKyboP-2vGCk4nA>
    <xme:jg67Y3sQtO6gNjvrNbkaUFjO77GVqD5_6A1gnmLXSGqfUMVfq_IGLGIGVrR1MD9NW
    l87IOmAwpv_Efq2Fg>
X-ME-Received: <xmr:jg67Y5DePTyEmcKTC8Rweu5dFblhBqCm2wHwDF-93TmiWzI7v2PHJWXvAoEWI4aMfp0TwTcwrdi4RSAehCC2PZicULHRZIbs1e2fCginm2h52Dh6NLqjZ7oTFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrkeeggdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeejgfffhfdujeeftdeuudeguedttefgieetffffheejuefguedv
    heejteeftdfftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:jg67Y3eP8I1A_p3acOoucyt1y2qqML3199db1xRkDdXAO2SbQWvXmA>
    <xmx:jg67YwPESUDJzGkkECrouMBx5OAllm8s8vkaqqPZCiYX1uHz6aou7A>
    <xmx:jg67Y5nDLXMDn-Dn25NXA36oUQIlBQlFRLODkkE8Hru1UuBgnPWYGQ>
    <xmx:jw67Y3kgA6b40v_-Woj3CmTYPlRaMhdiYeFqIxv_Iz06x9pA27k6zw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Jan 2023 13:42:21 -0500 (EST)
Message-ID: <05c1ee07-0750-d40e-8498-55ea07b52ab1@sholland.org>
Date:   Sun, 8 Jan 2023 12:42:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@rivosinc.com>
References: <20221231233851.24923-1-samuel@sholland.org>
 <20221231233851.24923-8-samuel@sholland.org> <Y7bW32i3EUmGHqSK@aptenodytes>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v4 07/12] riscv: dts: allwinner: Add Sipeed Lichee RV
 devicetrees
In-Reply-To: <Y7bW32i3EUmGHqSK@aptenodytes>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 1/5/23 07:55, Paul Kocialkowski wrote:
> Hi Samuel,
> 
> On Sat 31 Dec 22, 17:38, Samuel Holland wrote:
>> Sipeed manufactures a "Lichee RV" system-on-module, which provides a
>> minimal working system on its own, as well as a few carrier boards. The
>> "Dock" board provides audio, USB, and WiFi. The "86 Panel" additionally
>> provides 100M Ethernet and a built-in display panel.
>>
>> The 86 Panel repurposes the USB ID and VBUS detection GPIOs for its RGB
>> panel interface, since the USB OTG port is inaccessible inside the case.
> 
> Looks like the panel-enabled variants would better be described as device-tree
> overlays as they are not specific devices but are peripheral extensions.
> 
> What do you think?

I don't agree. The Lichee RV 86 Panel is sold as a complete unit, with
the SoM+board and LCD pre-assembled inside a case. It is not possible to
purchase the board without a panel, so the panel-enabled variants are
the only variants.

Regards,
Samuel

