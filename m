Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1E3646B4B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiLHJCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiLHJCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:02:47 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DA35FDD;
        Thu,  8 Dec 2022 01:02:45 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 48D1232001AB;
        Thu,  8 Dec 2022 04:02:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 08 Dec 2022 04:02:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670490162; x=1670576562; bh=/2
        5Zms0aIlGn7UuOR8iB864vzGQsFadP0HWzXb42zI4=; b=0hEhAnbHJNDHMyjC0+
        obqd/bf6wKQ3lqcED9F0ToWleTIW7Eqh/cn2Ya0k+QRiM7YXwXyAmfAeHfIM/t9P
        Af4EQg8FsOOCIk0Pi+BbLeZ6TYW+WPqV2uyJvNTW711ysx8OscXixK+lApD32bhQ
        /lVNNlrp+JXOFUGFjupxOoUWbuwxSBUfy+AfQs9qhyrKbLVXTU+Eg4NtzITaiwky
        ZkBgaGufnhnRy/4tccWhnwAhDXo5MRqwp1JMRU3AMVLy6Py9SQbvWyFdTL459DeU
        U0Q6vN2aCpInHyDgSQsEM2cBKw907VnHzKICb6mtrOfS5SqQf5xdToto+YF3btnl
        vmrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1670490162; x=1670576562; bh=/25Zms0aIlGn7
        UuOR8iB864vzGQsFadP0HWzXb42zI4=; b=Iitbe5M0PAyGVAxuUrPucZSEW35de
        NUymnQVdanHenoPwXlAkVWaho2lJvVYkv0iMZsW2Lh89oo1f01kIw/CfsydoWGkQ
        UdfYWdYgnwn5+MnXz72vNEHd14B51GMr782/g2HwIc1V4jJXLOzWcjLy1j75khfH
        w5FQtme3lxebiVZskIY2ox/PXdw2mjjr23xZOwttqojwBq9NNTUhP2/EmIsTeAhZ
        YQEjC81Q4dTUaJTF0ny/AHZ/zQpOmcr+h1JNcdsFtrBW1+3YfmnIRsbNljshUI5w
        gZcksNvxqPrrF9y+yxnbKDP1d81UyTTBKmfLaioG8+w5bz8THC2hgdKTw==
X-ME-Sender: <xms:MqiRY5xjmBgPvyWAdGQbH-FraoLFHLFHtIKlyVjTR3vJoFuA4hg7_w>
    <xme:MqiRY5StJsamoJQzOS9hjy7OiRkNTzqT_UFeBVX9yHKM5sViJJc6Q1wdWLS9SbBOu
    wZZtXbguJvUSPyizg>
X-ME-Received: <xmr:MqiRYzU4O3K8PM1iC-lBYDY8BWlMDBIuvwOkSxGTfTArOPrFZBvn_NLpHwlM3egZUTMtw1-N6yY2BI4ULnJIiFOCtX1ahrcJPwQNYOYR_ImVC0F3PO0c9DXwCMM4hQhqOIB4ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefgudefiedt
    veetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:MqiRY7j4deMr6WbmTd0d0nygcxQBxwF4nCl2-g8LCkVhrAj-PdKWow>
    <xmx:MqiRY7D6k-zOkQ6F6R4A0jQocRm9E2C9mP_jNgvEVik12jdN9Ovm8A>
    <xmx:MqiRY0J5YukAEh5986n_31irKYsE7gRrP36SdLhmm1M1QoX_pGiO7A>
    <xmx:MqiRYzYOOX8tD1le9c60gkdLSXr3hglrCAwiXpEsGe8JvQFcmoIUjA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Dec 2022 04:02:41 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org
Cc:     Jisheng Zhang <jszhang@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH v3 01/12] MAINTAINERS: Match the sun20i family of Allwinner SoCs
Date:   Thu,  8 Dec 2022 03:02:26 -0600
Message-Id: <20221208090237.20572-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221208090237.20572-1-samuel@sholland.org>
References: <20221208090237.20572-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no
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
index 38293bfb1918..35f5808cc308 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1828,7 +1828,7 @@ F:	drivers/pinctrl/sunxi/
 F:	drivers/soc/sunxi/
 N:	allwinner
 N:	sun[x456789]i
-N:	sun50i
+N:	sun[25]0i
 
 ARM/Amlogic Meson SoC CLOCK FRAMEWORK
 M:	Neil Armstrong <neil.armstrong@linaro.org>
-- 
2.37.4

