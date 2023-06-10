Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD33C72A705
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 02:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjFJA2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 20:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjFJA2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 20:28:16 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59EF3A81;
        Fri,  9 Jun 2023 17:28:15 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 5EA8D320098A;
        Fri,  9 Jun 2023 20:28:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 09 Jun 2023 20:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:content-type:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1686356891; x=1686443291; bh=Mm
        xYjjMkckIeR2YerMD4Iu5F7+IlL0Yr7ofr4yjvAcg=; b=lokKzEX7D56w8/Dpbe
        I7aJaADgN3uDvIqcEMC0j6ZOfWdY2sXGvnk4SY6/o4D/Apn2kbYwMyNmhJaOnL4f
        WhJEbc/C2OiNJ2vCIpB7rrFfPVONA3QkNVEraFtkZIgZXW3tcrMz0TWI1yhtVZ8t
        V1hVUJXHNs1CJGu+KI1TRVTCxXQYMQlQE39zE30+vfYHATjwimuomfnbYxltUPgg
        uZ/u5FX5nw95+kIJ2lqXRxIdWYktkcaoU/sPTfRMCWJw9hLENBM0hwArtzmQ00jR
        igdF2cBAwlgthNb2CCdqmYRdmBhSctD/cChy77PN7HFFLDHmqbi9mfTV2fTpGRFA
        SL2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686356891; x=1686443291; bh=MmxYjjMkckIeR2YerMD4Iu5F7+IlL0Yr7of
        r4yjvAcg=; b=L+z2PXoALAnUzFAatwQyd8AOEyG6BTxEkRsH/1aSEM3ixT9mGYs
        8inBfwMPkCKM0+v0RCdgKJbJpJh+EjMlp9K3bon2EItpvFXtSkE8p8VSCKl8va8b
        jmfZbk73bbZfrQk/FQVpkQE6wt8hWyO5OeqN/Gb9D1MteNV1kxk57n4v2J/WWgRC
        +IMQTFwmqKApeGAIP3FN1NTpXCF/6KJ9CxgesEfxMJw8ZUIAtnm9qyuo/h1uYCau
        9we5yqOIIuF7VySyPnb5XuY0DXe3Q27SDePJxiixfZVP9OH6BAELoNRAInQPZ3s+
        AjVzXfj+P4BGwH6nZ8LCscpsx7a5BK28H6A==
X-ME-Sender: <xms:m8ODZMzpl3Pj6x2DjzKDXN-IxjAhCWVXMMXhd1z9FaBR2aUtBa9h7g>
    <xme:m8ODZATwwWuarKe8Nt6GqcuP2ATF7OdYwbdmKEQIs3zOgoT06l8lCOvlAtB4jEGES
    Sb9L11QrUJIHSMZyJc>
X-ME-Received: <xmr:m8ODZOUhR9K9UUvTH5588xA4tdq0gA2u0zDtW9pJeCI4d2lfCvrdAdV7OA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtledgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfggtggusehttdertddttddvnecuhfhrohhmpeflohhshhcuvfhr
    ihhplhgvthhtuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqnecuggftrf
    grthhtvghrnhepleelgeegtdejjeefuedvudefgefgkedtfeekheevueevvddvhfegfffg
    vdfgffeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgh
X-ME-Proxy: <xmx:m8ODZKiYvIrF0iobGY7goVzeU2cIK9geLYL7afLqSOoer7i2UmvxyQ>
    <xmx:m8ODZOCzlyqu6ZOQeEZBc1cU-6Vs6WeM7QcTnqFoeg13dr1_Jl6G_g>
    <xmx:m8ODZLJymQFH6J3WqjHiGiM2ykwxnXgUbXKC0SdSCi8SiaSCOhI6gg>
    <xmx:m8ODZB_8QWV8g3JTboAfgGlq3uxuXrMeO4twQxn0vTu2uLOuZ1Fewg>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jun 2023 20:28:10 -0400 (EDT)
Date:   Fri, 9 Jun 2023 17:28:09 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: deb-pkg: Include modules.builtin* even if non-modular
Message-ID: <36a4014c73a52af27d930d3ca31d362b60f4461c.1686356364.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even for a non-modular kernel, the kernel builds modules.builtin and
modules.builtin.modinfo, with information about the built-in modules.
Tools such as initramfs-tools need these files to build a working
initramfs on some systems, such as those requiring firmware.

Install modules.builtin and modules.builtin.modinfo into the linux-image
package even for a non-modular kernel.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 scripts/package/builddeb | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 252faaa5561c..91261529f2c7 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -70,6 +70,12 @@ install_linux_image () {
 			mkdir -p "${pdir}/usr/lib/uml/modules"
 			mv "${pdir}/lib/modules/${KERNELRELEASE}" "${pdir}/usr/lib/uml/modules/${KERNELRELEASE}"
 		fi
+	elif [ -f modules.builtin ]; then
+		mkdir -p "${pdir}/lib/modules/${KERNELRELEASE}"
+		cp modules.builtin "${pdir}/lib/modules/${KERNELRELEASE}/modules.builtin"
+		if [ -f modules.builtin.modinfo ]; then
+			cp modules.builtin.modinfo "${pdir}/lib/modules/${KERNELRELEASE}/modules.builtin.modinfo"
+		fi
 	fi
 
 	# Install the kernel
-- 
2.40.1

