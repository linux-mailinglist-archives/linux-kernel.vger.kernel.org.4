Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832BA6ABD56
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCFKuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjCFKuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:50:00 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250D225E35
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:49:56 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8D45E5C0085;
        Mon,  6 Mar 2023 05:49:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 06 Mar 2023 05:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1678099795; x=1678186195; bh=U6WvYvGj+f6Jr+yF0TNYNLkePrZ5UiOb/5y
        LjPbLweU=; b=RhbmysweGmGMNXTZBJzGnra6qF60EdYNzt5UVON246FMWUbGd/B
        KP00jCpnjN+q/1azw8pPOoJoCmYlRyN10kQ+2vhFCByWyiH0rEXGrQFcecARj43I
        V+ycRC0irRR6cKl7Z3bMY81iOhMF6LU2wrmsKBUXQkesD4kWyyVABxpieWL6s1hQ
        P93TL3GuvT1COeYWs1Nv0pl2x9FOC+eJ0+rg9aS7h/qGVMWc08yfIamIWXDT0pR/
        37ULKJc4+vFYZ/i4KrieJVvD7y6vLLR4t6OcAkHW2IPW7e3hbL+AYbrXnV4IUSD7
        7Ywe353GUsXhrpaBkrQSGV97BPFXJVq6fiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1678099795; x=1678186195; bh=U6WvYvGj+f6Jr+yF0TNYNLkePrZ5UiOb/5y
        LjPbLweU=; b=Ev3X+XmUJ47svJjjlhjRy8i8oRZjlbgFMwZdphwADQ3e0f9hazO
        /n7e1O11A47ubz1KQzI7ITLNkY21HS01iVsANgKhHmIyOZ+81fNk2nZfD1IpGJk6
        w96nTsVKDl/Qo1yhH+gkHOUy2IHRvFGUI5JA1qQcEhOtp+syx0hnG2UBoKoL5U9m
        qg89ywrhLxEScMJTiuM5W4cibIk8LyG5Kr1fOhUhbf9gcFqnZUrwXLWFxf40oIz8
        w6odSny8DikIE0Q6/TThbQPEf3rR62C7tlp3E6ooGFKjEiYn2H23g9x5V9hn5JSI
        L8mluXB4a/jbNMrdXSC6B/ChR6h5J/Ra8JA==
X-ME-Sender: <xms:U8UFZBTJlmCP1a-rA4TREYPwY3bGdN_SaT7WWasEgu-Wa_lurvyFeA>
    <xme:U8UFZKyxQZc6NSSwa_lFsuiY2XI8Qml0BUyBqI2CX8eNRJdsi8DOA8FFlq3drhBoD
    Gl80WpkC-F7eDgYVqU>
X-ME-Received: <xmr:U8UFZG2GiVbbceOluh4HEpRkLiszdHRQij6ecAjje-M13jWb3r5uFeNFD7oE304zzmx6cBEWFQNAEizyNRdcC8rEmWeNTlc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtiedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepvedvleeijeegvdekffehkeehieelhfeggfffheetkeeuledvtdeuffeh
    teeltdffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:U8UFZJCWsx5iE256JGw_uWFFsv3zpFXXCqDn_cK6v2DoAuhAFiH-GA>
    <xmx:U8UFZKg_wFQ6AdjB5rlH1t6M86Jiz9EKUX7yRYVyDqh9Rqfss5PCnQ>
    <xmx:U8UFZNqm0q5-w4Oz4dtmVCUwFliKADzyzXZ_iSCTDmJHbzNkQHkdkA>
    <xmx:U8UFZDZGWP9DIriMNAYW3PFtJ3Tiwmtq8xxZywdPpSv5OItxhtoqgQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Mar 2023 05:49:54 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Mon, 06 Mar 2023 11:46:48 +0100
Subject: [PATCH v3 7/9] drm/vc4: hdmi: Add a function to retrieve the CSC
 matrix
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221207-rpi-hdmi-improvements-v3-7-bdd54f66884e@cerno.tech>
References: <20221207-rpi-hdmi-improvements-v3-0-bdd54f66884e@cerno.tech>
In-Reply-To: <20221207-rpi-hdmi-improvements-v3-0-bdd54f66884e@cerno.tech>
To:     Emma Anholt <emma@anholt.net>, Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2847; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=07Z626J9apTaH2nWy8eyHugnVc3F1Vi8gC2KI7yAn9Q=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCmsR2Z0JMw4P9OFdZ/4VrlOWffKhU/eyVrKlqZUVZv3HmP9
 YrSio5SFQYyLQVZMkSVG2HxJ3KlZrzvZ+ObBzGFlAhnCwMUpABOJYGBk+Gsktsj3+gy2Wx4vdOb5SB
 WrXWF7fJX71Kq1CbKrBbbLczP8rzK7V/lgUnGleO6kKbdvad+f6ZYlfOq40PmLv1c2Rt9p5wIA
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The CSC matrix to use depends on the output format, its range and the
colorspace.

Since we're going to add more colorspaces, let's move the CSC matrix
retrieval to a function.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index a3e0bf00e4c6..1424835bd83e 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1299,6 +1299,20 @@ static void vc5_hdmi_set_csc_coeffs_swap(struct vc4_hdmi *vc4_hdmi,
 	HDMI_WRITE(HDMI_CSC_34_33, (coeffs[0][3] << 16) | coeffs[0][2]);
 }
 
+static const u16
+(*vc5_hdmi_find_yuv_csc_coeffs(struct vc4_hdmi *vc4_hdmi, u32 colorspace, bool limited))[4]
+{
+	switch (colorspace) {
+	default:
+	case DRM_MODE_COLORIMETRY_NO_DATA:
+	case DRM_MODE_COLORIMETRY_BT709_YCC:
+	case DRM_MODE_COLORIMETRY_XVYCC_709:
+	case DRM_MODE_COLORIMETRY_RGB_WIDE_FIXED:
+	case DRM_MODE_COLORIMETRY_RGB_WIDE_FLOAT:
+		return vc5_hdmi_csc_full_rgb_to_yuv_bt709[limited];
+	}
+}
+
 static void vc5_hdmi_csc_setup(struct vc4_hdmi *vc4_hdmi,
 			       struct drm_connector_state *state,
 			       const struct drm_display_mode *mode)
@@ -1308,6 +1322,7 @@ static void vc5_hdmi_csc_setup(struct vc4_hdmi *vc4_hdmi,
 		conn_state_to_vc4_hdmi_conn_state(state);
 	unsigned int lim_range = vc4_hdmi_is_full_range(vc4_hdmi, vc4_state) ? 0 : 1;
 	unsigned long flags;
+	const u16 (*csc)[4];
 	u32 if_cfg = 0;
 	u32 if_xbar = 0x543210;
 	u32 csc_chan_ctl = 0;
@@ -1322,11 +1337,14 @@ static void vc5_hdmi_csc_setup(struct vc4_hdmi *vc4_hdmi,
 
 	switch (vc4_state->output_format) {
 	case VC4_HDMI_OUTPUT_YUV444:
-		vc5_hdmi_set_csc_coeffs_swap(vc4_hdmi,
-					     vc5_hdmi_csc_full_rgb_to_yuv_bt709[lim_range]);
+		csc = vc5_hdmi_find_yuv_csc_coeffs(vc4_hdmi, state->colorspace, !!lim_range);
+
+		vc5_hdmi_set_csc_coeffs_swap(vc4_hdmi, csc);
 		break;
 
 	case VC4_HDMI_OUTPUT_YUV422:
+		csc = vc5_hdmi_find_yuv_csc_coeffs(vc4_hdmi, state->colorspace, !!lim_range);
+
 		csc_ctl |= VC4_SET_FIELD(VC5_MT_CP_CSC_CTL_FILTER_MODE_444_TO_422_STANDARD,
 					 VC5_MT_CP_CSC_CTL_FILTER_MODE_444_TO_422) |
 			VC5_MT_CP_CSC_CTL_USE_444_TO_422 |
@@ -1338,7 +1356,7 @@ static void vc5_hdmi_csc_setup(struct vc4_hdmi *vc4_hdmi,
 		if_cfg |= VC4_SET_FIELD(VC5_DVP_HT_VEC_INTERFACE_CFG_SEL_422_FORMAT_422_LEGACY,
 					VC5_DVP_HT_VEC_INTERFACE_CFG_SEL_422);
 
-		vc5_hdmi_set_csc_coeffs(vc4_hdmi, vc5_hdmi_csc_full_rgb_to_yuv_bt709[lim_range]);
+		vc5_hdmi_set_csc_coeffs(vc4_hdmi, csc);
 		break;
 
 	case VC4_HDMI_OUTPUT_RGB:

-- 
2.39.2

