Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4976FDF81
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbjEJOEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236853AbjEJOEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:04:09 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80D5E7C;
        Wed, 10 May 2023 07:04:07 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 657E15C020B;
        Wed, 10 May 2023 10:04:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 10 May 2023 10:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1683727445; x=1683813845; bh=kTL4f5KIw3wMvRAkNXXul615DukLk1ocVlo
        TB3qbjIA=; b=kcixg1WysUEJMLh+AOCn9T4HjkZ2SkUt+hQCyoLz+HV68AnP0O1
        0/Eexoec6WUy179FcCD1JvvfUPFpxPsZgt5HEgL8fxIYXsgALIgI3jYdcwOoZQeW
        7xmpHhlTyQm/BWJI7vZZDzirIlpNAXvKAGTc44Phx6Mc4xvXuWR0lR7dGiZab9cK
        mOfDIqAcVuBBGWcj9BBMKVPhoL9w/nhvC757j7OfggFxeI6NMOdRu7HHXTxkxOxN
        uNnJpRWH2nAsOVEZTmJnJhUkV3DwAe4R35cuhu7BPmk7AdGFPCitZXBms3qqKuST
        YpLPk1P5slS2J1cDc+X4iKWgZn7VpphNunw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683727445; x=1683813845; bh=kTL4f5KIw3wMvRAkNXXul615DukLk1ocVlo
        TB3qbjIA=; b=WZxAJGdSOh/nwuEkfMVI1eXfcfd4auiFGvDhb1PK+BT0MxPK3kT
        jeMy144LD7JqeaoW5xstsOheT00SjjjCWBpNNFTYVqnqfyCYpNpICHsRft0E6XWq
        f8+yxpMYjgEIoPVQivjZk6Q7cHtlFr7TEpLq4pSoEmoJzXzIP6avHdO/wxHX92PN
        yxTGlh/RDWqAZ1ey0y9c+R1Xt9Wa4sFTIluwB6Tz51+QNVMWXLApvtgl8GHpd7Q+
        U4SC1G0MWdlj26xCKS53/BHcHOOK+3V4jTfLC0CM79S2M5AHY1WtgksyUkkOVEub
        z736dfgWrS/tdnO3c1ivVFqm6TbIkeNxkSA==
X-ME-Sender: <xms:U6RbZPmK8GJN8Pux2hQ-xF7o9cKrPnjhfd09vAcQ2Vx491DzdybkhQ>
    <xme:U6RbZC3-yJAGuFKGg96CRnkhSGJq-YUiVZ6TiYuie76dJv7epUtxTGafXOnoDd41N
    I0gNLiS7PJosyNov0U>
X-ME-Received: <xmr:U6RbZFr_zIhNlMj5xr5E96P2PHqo1EqO4c17Zw0KJd8SzWhkzYeroOsCuKmlpdVmq1A76X5920wUmQDe7dv0Eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvegjfhfukfffgggtgffosehtjeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepleeifffgvdetjeejueejieehuedvteeigeehtefhhfeifeegleekudek
    teegueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:U6RbZHkBjyQ0w38HRPFotZUTsTwsa4eduNbPrR7fqkaw0UtmN3ogtg>
    <xmx:U6RbZN0aBpKEAK6zTkHww0kgSjya8xufHUKDzwGWulDPcgVU2wKd7g>
    <xmx:U6RbZGuaXpOYmF-IlrVZiYsoFUn30IYllQ5STZrqELbpZVAZBxoxwQ>
    <xmx:VaRbZEtSEWdL6efS9woWYejq3zpYJgVmlpoo0WLYYpnbsGagyW8DPg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 10:04:02 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roman Beranek <me@crly.cz>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Icenowy Zheng <icenowy@aosc.io>, Ondrej Jirman <megi@xff.cz>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230505052110.67514-4-me@crly.cz>
References: <20230505052110.67514-1-me@crly.cz>
 <20230505052110.67514-4-me@crly.cz>
Subject: Re: (subset) [PATCH v4 3/4] drm: sun4i: rename sun4i_dotclock to
 sun4i_tcon_dclk
Message-Id: <168372744041.19948.4436808010046905352.b4-ty@cerno.tech>
Date:   Wed, 10 May 2023 16:04:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 May 2023 07:21:09 +0200, Roman Beranek wrote:
> While the rate of TCON0's DCLK matches dotclock for parallel and LVDS
> outputs, this doesn't hold for DSI. The 'D' in DCLK actually stands for
> 'Data' according to Allwinner's manuals. The clock is mostly referred to
> as dclk throughout this driver already anyway, so stick with that.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

