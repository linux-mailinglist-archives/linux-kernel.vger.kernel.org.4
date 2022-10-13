Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754EF5FD76D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 11:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJMJ5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 05:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJMJ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 05:57:17 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219CD11BD82
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 02:57:15 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1CCE35C00A6;
        Thu, 13 Oct 2022 05:57:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 13 Oct 2022 05:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1665655035; x=
        1665741435; bh=YJIorxZ3pr3ObxvJBlO+ZXthuYIK21XnMOr0CgbO85g=; b=B
        /K/5gJoeHdYAJtm/xI3HB0HpvFmv0vVKfPkgneITXJsMni8HIo5A+w7wXosbENtH
        WAQJLL+fRTlZ+UhKaRloXgdtAkOu+pgJIj30A+NI+4SZaELN7jwRqx1wEIBN5mfb
        wBxNzy5L5DwxA0LkJh2Wn5Ff3GwXMQic2L+4xxAlcCKZK1eEYTy+wPGAUEaoQN8G
        YHwh05xJOWzQimRwDXshAcQ3WP6PmxC0KOqbMBy8sriNhSBWN3OS50vLTNqSioQ7
        99LPs5CUyqQnSXn+BEOkSA18C3Rr4n9BxiSV4BzQMdGClT5zX+IQApqJ3ggNzAnx
        b2UpkEI7xBD2yzqrOMg0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665655035; x=
        1665741435; bh=YJIorxZ3pr3ObxvJBlO+ZXthuYIK21XnMOr0CgbO85g=; b=T
        1qUH36QS6wVuprS6GW2gNoDbfQfxHVde1oSUdy9kPWVP5M0it87NVXIYFE/mDCw0
        u7SuYjhXEk/wLXlEXPO0sDShocrKdX4Gcr5cZsPa/57sLqd+cit5/+iGcvul8RPz
        AUhAgz385uQkSI2GWYAF/bJ3teIwc1MSVVXIxEeu57nRxPgy06syxMVHUq50tnYN
        Q6UoTi6vLWIHggkyOdjOlQe3fIsdL5sR8GkhSjPXjYXIJOQ44qjdykWJTespPjnC
        WxvSAED8E6VyALcjsO+wx4lpjO7EX4QhEFuUfTcm0A3ILqRJklpb24y/6PT45R1t
        AoUvCLe2udomn6UqLM6MA==
X-ME-Sender: <xms:--BHY2YeXAkWUktRK4ONkH_PxbpF2NZHHixw9YEXu4EuKpVmk-WrSQ>
    <xme:--BHY5axhoHd-X-QJGVab0jbZvqrsTeTjjAcA050hlZZKe_4NM0l5CK7V0OXLeN94
    BVryaSIH3ccgB6m2s0>
X-ME-Received: <xmr:--BHYw-5juuCuwik49_CffUyLCpGDAcy30XS-K2-4CSnKHV4rZaWmOryK1mE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeektddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepudduudfhveejteefgedvffdvvedvjedugedukeejhedtlefhffevtefh
    jeeltdevnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:--BHY4qxv2ZTEIC_5Poa1PphNLrvZZ4Lbi5Mdwl4Gpt5RV0ss1LQKg>
    <xmx:--BHYxpYnIzTbH54hy6hFLOBEBhSsGRFjguGV5JF4e8J1qGk7W7dkQ>
    <xmx:--BHY2R7l5rRSnwhmpJSjswqultgK9ooCyDaBnHeuThwifhYIbp-3w>
    <xmx:--BHYyQvUxd_bqfBklnONLUbfI0tXpfIuToNlF9ciHhBmsEwezB9Lw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Oct 2022 05:57:14 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Thu, 13 Oct 2022 11:56:50 +0200
Subject: [PATCH 6/7] drm/vc4: dpi: Change the default DPI format to being 18bpp,
 not 24.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221013-rpi-dpi-improvements-v1-6-8a7a96949cb0@cerno.tech>
References: <20221013-rpi-dpi-improvements-v1-0-8a7a96949cb0@cerno.tech>
In-Reply-To: <20221013-rpi-dpi-improvements-v1-0-8a7a96949cb0@cerno.tech>
To:     Maxime Ripard <mripard@kernel.org>, Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>,
        Emma Anholt <emma@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        Joerg Quinten <aBUGSworstnightmare@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.11.0-dev-7da52
X-Developer-Signature: v=1; a=openpgp-sha256; l=1264; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=Wft1tzL7nxwyTwNtu5OqGs7F+nLIDZNQX56ZSduIte0=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMnuD9627pcUfvUmYLe7i/T0yiCHiGsTm4zta7877tj58PNp
 QTmJjlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAEzkkirDf/9Yrx4+zXuFmqJZ6oG7GD
 lcKzcbvJ30z7K679TKtGWbDzD8r/l+dfb2a5lLkvdJ3nPQ3ury3rV2fzJ7qbGAXuOM6Zv6uQE=
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

DPI hasn't really been used up until now, so the default has
been meaningless.
In theory we should be able to pass the desired format for the
adjacent bridge chip through, but framework seems to be missing
for that.

As the main device to use DPI is the VGA666 or Adafruit Kippah,
both of which use RGB666, change the default to being RGB666 instead
of RGB888.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_dpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dpi.c b/drivers/gpu/drm/vc4/vc4_dpi.c
index ecbe4cd87036..fdae02760b6d 100644
--- a/drivers/gpu/drm/vc4/vc4_dpi.c
+++ b/drivers/gpu/drm/vc4/vc4_dpi.c
@@ -150,8 +150,8 @@ static void vc4_dpi_encoder_enable(struct drm_encoder *encoder)
 	}
 	drm_connector_list_iter_end(&conn_iter);
 
-	/* Default to 24bit if no connector or format found. */
-	dpi_c |= VC4_SET_FIELD(DPI_FORMAT_24BIT_888_RGB, DPI_FORMAT);
+	/* Default to 18bit if no connector or format found. */
+	dpi_c |= VC4_SET_FIELD(DPI_FORMAT_18BIT_666_RGB_1, DPI_FORMAT);
 
 	if (connector) {
 		if (connector->display_info.num_bus_formats) {

-- 
b4 0.11.0-dev-7da52
