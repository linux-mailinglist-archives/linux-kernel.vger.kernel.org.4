Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED9263906E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 20:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiKYTyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 14:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiKYTyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 14:54:06 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3714355AB9;
        Fri, 25 Nov 2022 11:54:06 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A6B915C0102;
        Fri, 25 Nov 2022 14:54:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 25 Nov 2022 14:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669406045; x=1669492445; bh=s+
        PpxXX1k5QU3HQeh+iSdhp6bhrGbLgb0SFaWijnFOs=; b=kE+cO2LMI6NerflRZX
        JOuoiJrPOSpB+KOImtGNq9liQovmNHSMcC5mjRBX/yolECy8nGvBW6xy+r3Cgsw5
        EBZa6Vt8h/WBCUUMr0F9CqJgmJ2ytTOS/5385UTBKkJX/AYC6WuAc7U8B3/p1E5D
        jESF2b9lRaSV/2Y2088K1pjWXVjPVObQ7/latGSVKZ598BUs0WcT7TboQXnPhuip
        9G1CWZfhUV6Xgzvk3UC/wgJ2lUgbE9/SHNg2pV+/Rk4qIVqghe07KTuUIKDKOogn
        LGW/bH8juBt03obxmvZcrvA/hE8cbicCp1OJ4LM5kHaN3fPeJdN0XMFYWMDCvRRi
        yIcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1669406045; x=1669492445; bh=s+PpxXX1k5QU3
        HQeh+iSdhp6bhrGbLgb0SFaWijnFOs=; b=XNwTI8yx7ZMHTp5Qci5vb/1Lui0CX
        oJNRhGq2G5j9p8ctaMSloxqdSq8oCJKl+Rb8HhXXff+smSCDMhdBOTBvCWX4pK78
        jzwxlqnZWzNjLWhw+ikonNAlLcVPD45dH1KLM/RK0s+G0DeL0thUqKmKSyu/C7ar
        pc7eHESSIbBQ+yzZw8TzXEJqhVGql5+f+QotYnOE0oH4kx9IT4qVq5rBffiTdHsI
        oWACokr69x+feuUE/wtaXA6k4nFi2l2iP5Un+ouCr19t3ibqWQj+mABocrqald2I
        HBQbAruW6rebk5wwmjbhBzxGeELIGxQsNzR2FuXdbKt/hnJp/b9nLpCeA==
X-ME-Sender: <xms:XB2BY68r0j_4iYia-TuHC-JqZzE4tXo1YUtKjfjXDxUHONkoEWFQxw>
    <xme:XB2BY6vvBU8VGGevlSB5FFFo0GaFA6q1EbRxD9Xit338BU7PDJ1u6seUEVutLLqRB
    sEMTOgQkj_2y_1cQw>
X-ME-Received: <xmr:XB2BYwAG3y0i3mOjslyMFBjxrJ5nShm-DO5Asc_tWMxKDdXs515zhhpKWW0DIZ09ClrBJFCzcXW7KrAGCwcoNV2AbGwS4OY9jVzeq7hbXzSNpgAUXOTHAzc561748IEa209XTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieehgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:XB2BYyf6PLTdDO7TfphLzk7vBfuS0XEZcxC7JUbfie_ZNd_Ttz4pTA>
    <xmx:XB2BY_NQ7TBZphav5_3ftrrHDMDOzWjbrhFoDT_5s4vj8ZwJhMugQw>
    <xmx:XB2BY8llsOadMuAVsPlxmMB9nsHt_oIWaAs3HTIxv3vHBDHtwiZUww>
    <xmx:XR2BY6ryMFTSiBMBTNUg-EELKUX2gBJNAsbTFMAZwCwrI_Fiu8IdKg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Nov 2022 14:54:03 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Karl Palsson <karlp@tweak.net.au>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH 2/2] ARM: dts: sun8i: nanopi-duo2: Fix regulator GPIO reference
Date:   Fri, 25 Nov 2022 13:54:01 -0600
Message-Id: <20221125195401.61642-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221125195401.61642-1-samuel@sholland.org>
References: <20221125195401.61642-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The property named in the schema is 'enable-gpios', not 'enable-gpio'.
This makes no difference at runtime, because the regulator is marked as
always-on, but it breaks validation.

Fixes: 4701fc6e5dd9 ("ARM: dts: sun8i: add FriendlyARM NanoPi Duo2")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
index 43641cb82398..343b02b97155 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
@@ -57,7 +57,7 @@ reg_vdd_cpux: vdd-cpux-regulator {
 		regulator-ramp-delay = <50>; /* 4ms */
 
 		enable-active-high;
-		enable-gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+		enable-gpios = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
 		gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
 		gpios-states = <0x1>;
 		states = <1100000 0>, <1300000 1>;
-- 
2.37.4

