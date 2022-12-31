Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079CE65A831
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiLaXjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLaXi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:38:58 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737A962E3;
        Sat, 31 Dec 2022 15:38:55 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DA0625C00BA;
        Sat, 31 Dec 2022 18:38:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 31 Dec 2022 18:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672529934; x=1672616334; bh=z1
        WCshbGb9fwiGuVdzVroIaH2YpnFBDx+tGRyEoLwl4=; b=eINxSgvXyA9czdxcZK
        sPTD770vcv0sZKsO4sQaOvYoD6Q0ciOgUsdY9f6dgKCIvf8HHmuV5BLWQ3EcDDBz
        LdrAdB8x1FpxoeJhm11j1nRH0fCb1W8DdMDsoBhKkMnb0f7qwHbsNUNTiFB5CdS1
        P7FbF+iw3oeynFSvrD4WgmMcNdUAlpM83N+pdNd/akKn+9xbhpra5uBzT3ifN4Qe
        hNc2EJfGkYaSf7MzFHSEQ5szhEYl2ampJGh3mstM1mKiBjHaqANjX2w0DQv8Lvcz
        4Hx1yr1ZYP56kujqzwR9c95dy6JFAi4n6oFMOhIOvvrk3NoH1lUVvudXFBPRsa9v
        z1wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672529934; x=1672616334; bh=z1WCshbGb9fwi
        GuVdzVroIaH2YpnFBDx+tGRyEoLwl4=; b=Nw1JPUIcZ7bWcpYQWSAApt2ioQJYi
        A7FbzLvb/YX7f8JZfJDTU4AF8Z9Dpqdt0aBCBgVm7bNap9s907wJtbgG3NtvQbRQ
        l5RWSBCbI4jjqJIFgP7tZNn5A+6kiTZwmrX6QhebJqCWRc/s1AG26o4ZoMx6vpLY
        LKiK23Bbt+uzo4ROYLQipHh/cTuK0WT/g+gOApgXJH82tCCz/0nD+SZ/FlXgXhY7
        Vc6JB/itiJXpBmYt18ztDpvF9IjvVfdB0nBeCAFq4+L3NqFHGKNUNgGLu0H+Jegq
        VfU5h3zrMW0o8y3IyWVYkVH18Wcs8bE3a3EXVVQEgFwOH4+O/aBdWqKSg==
X-ME-Sender: <xms:DsiwY2l8qhe8jYmrvd6XdMV6RhtpCtwQpNeO3M4eyNYPjjFjHmdzQw>
    <xme:DsiwY91qH0Y6bG_lzLyghjCJaBY-TykvxR0Nhsg5BgtB92LtmQFf7cFXMsJmr-loV
    HXPOQX5Sq1dBRg0gg>
X-ME-Received: <xmr:DsiwY0pmfzbM7RC4hQrsNGgAnT1Lu_dApd8KGtkQIgfo6qYfMwEy8HdxO0TUK9FkXlMldeIP18Xzq8CJQmKTvWKT_5X2l-9ZXvjW86ZNVmDPsBN3THliN2-sX4DIlHRPuf4qpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:DsiwY6l1QGf6uZGlQ7JFPttBgCDFDyvYzBW16KYXfHcBBAnRWTuGJQ>
    <xmx:DsiwY02zNyLcCzsrTtbL1dAYyIQeobgJlRIelB80yPSxBjMSJ2SEpw>
    <xmx:DsiwYxsisS54DwxO29GZMnMaYLHY1eGuR_CNxZs2oWqf_eWvItsy5A>
    <xmx:DsiwY-PIZm5O0_ONhLYtVMoUR9LiwRzWGQnts38LgCqP94Ay_SY08Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:38:53 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH v4 01/12] MAINTAINERS: Match the sun20i family of Allwinner SoCs
Date:   Sat, 31 Dec 2022 17:38:40 -0600
Message-Id: <20221231233851.24923-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221231233851.24923-1-samuel@sholland.org>
References: <20221231233851.24923-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner sunxi SoCs with a RISC-V CPU use the sun20i designator. Match
that pattern in addition to the designators for 32 and 64-bit ARM SoCs.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a484ff31bd2..2fa0182f2711 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1888,7 +1888,7 @@ F:	drivers/pinctrl/sunxi/
 F:	drivers/soc/sunxi/
 N:	allwinner
 N:	sun[x456789]i
-N:	sun50i
+N:	sun[25]0i
 
 ARM/Amlogic Meson SoC CLOCK FRAMEWORK
 M:	Neil Armstrong <neil.armstrong@linaro.org>
-- 
2.37.4

