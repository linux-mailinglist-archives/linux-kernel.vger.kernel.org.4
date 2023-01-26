Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E5C67C40E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 05:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbjAZE5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 23:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAZE5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 23:57:42 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A75D552BF;
        Wed, 25 Jan 2023 20:57:41 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 188255C01B6;
        Wed, 25 Jan 2023 23:57:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 25 Jan 2023 23:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1674709059; x=1674795459; bh=X9
        s6cjs86up+hYIsx64vzFJpoNRPbaCk4kY0RDMfADM=; b=ZdfM3FHeaYvIoHcQHq
        Mu1XGs6brJrMAo8pzIvFqLwScLYzcIGA4/oKuganif+5zjOxXSlQ7kuIFKZ8avYT
        EfmX596NVkSAIdcWTDCAjqfuE9/XzN7SZbyCkCt5oIhYNKn5wjtq2kwLdUimeCHa
        1eWgUjERUxTu1YLjXZXfcm18LePGJVLjH6JGfHIMIqPUbbzuMeluTtyEjwPGZ6Ej
        gu9fN2dKLpqCBdK69J+jt7bHyPgwqkfDbNZk0EHa9qoYtHBWn0ZlJU8mCf/l+zvv
        UK5D94FncKy1GfcVXxk/aB5M0/N2XxnTOLBEcZzEN0TCjdZmvas3EiHmv9IeSWav
        okEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674709059; x=1674795459; bh=X9s6cjs86up+h
        YIsx64vzFJpoNRPbaCk4kY0RDMfADM=; b=aMnaHHNqYI09i7aWVOdETtUjh0iXl
        o82oN73/s9VaKfU4CxNbz0a/OfjJoYNTSfDCBnSNVLbzEl4HYGZb2+2KtSlJuDCg
        lCg+Q3+v5acB+D2jHnCDa/u7I1hVip8VfnXbaPMm0+abg63d/VCcsghXUN59sdeF
        2xk0i/wF8enIDLMibiEi2Ey8bsEAem81EHDJ80BZKVr3eotubyd0J1Lu5J/c0TGa
        muRgAVintA06SY7a4EKMh7hfDyGZqfWxscYY/n5UdFlSd1BS9mjU9L+KDZZqq4wM
        uHJUZaNDHLB24KEqKGkbsJnOGCsTYDC1hILNlYPFm0vC9Rs+K4rPKffvw==
X-ME-Sender: <xms:QgjSY1F4guQ851BAJdwAXIb008Ul94EDm9wK0nnSSxWQ0eA2EgVKFQ>
    <xme:QgjSY6UcSPQt2y8vMu-F_O7pprfFklElUaBgfvLgRKHBvMMha3NIXtMt7TMqleS7P
    b2iLu71QwwjfDrFmw>
X-ME-Received: <xmr:QgjSY3LI7EEpPFlG8Hkr0aAPck9gYEs8G4JfLBrY_MaSGcHqcJs8OV6NKJk3Dy2-VjYEEnptW4ZJBYjS7sIQoX0j2GBAXUrvrUnWWwVn8UyzdmlPPRzFOUQhN2_3JUaYulLvgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvfedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:QgjSY7Ew47d7ILfejfjoMitEvIH0E2h7fN1GUHwHEYEeNkSVEMtS6w>
    <xmx:QgjSY7WF6gYdzduL_fuaekaHP-J1QAvwOtBUA5T4tCCfJsvmUcGONQ>
    <xmx:QgjSY2Movl_2umPdOTWpoA3raCJrug0nggZetfpCFb9vI03Y18TmDw>
    <xmx:QwjSY8tjoUOnsv8ozOXKhBsh0d9L9hOe84_9EAkn13_4mO_kqitaJA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 23:57:37 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     linux-riscv@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH v5 01/11] MAINTAINERS: Match the sun20i family of Allwinner SoCs
Date:   Wed, 25 Jan 2023 22:57:28 -0600
Message-Id: <20230126045738.47903-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230126045738.47903-1-samuel@sholland.org>
References: <20230126045738.47903-1-samuel@sholland.org>
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
index 3b0148001f92..2600c85bdfd5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1887,7 +1887,7 @@ F:	drivers/pinctrl/sunxi/
 F:	drivers/soc/sunxi/
 N:	allwinner
 N:	sun[x456789]i
-N:	sun50i
+N:	sun[25]0i
 
 ARM/Amlogic Meson SoC CLOCK FRAMEWORK
 M:	Neil Armstrong <neil.armstrong@linaro.org>
-- 
2.37.4

