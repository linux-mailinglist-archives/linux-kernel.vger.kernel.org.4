Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52EB65A5CB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 17:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiLaQqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 11:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiLaQqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 11:46:33 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE91165EB;
        Sat, 31 Dec 2022 08:46:32 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 644E85C00CB;
        Sat, 31 Dec 2022 11:46:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 31 Dec 2022 11:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672505192; x=1672591592; bh=1D
        BP+rGGLrXexyIgtUoV3nBhVt1qdh7rplGwtcADlbA=; b=e5vzK2/pbB8gZeo7qF
        c60+an/Kwxd7BMvePWfJ9q3xwb80doRZb4xwwU8UETvmwxhTLkhkF1kOtXrYlo2f
        5YEJItP+f1VjKbff4i1/0pdcEUrky3zmUIZONKo88TTSCPWJuDAxPRpzaCdSukmx
        rThbjWpcwGKoZwD6+jefZDW/CsiTqsTocbDH0LOney+5DdkGvgePpIGiKv9Arayx
        mxlHs2ryCWK9+xEOxY3V330oL7TSMtQpdnkJmK99Z7T0rCdF1DGH3nx+2wMS+Mf4
        NNaW2MjOnqeo2FRViHuwuqwo0QEvCM79IDBEux1nziwCHvhD0sgUEr+lRwrHdTxg
        WlJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672505192; x=1672591592; bh=1DBP+rGGLrXex
        yIgtUoV3nBhVt1qdh7rplGwtcADlbA=; b=OmRoilvKB3hnuYsCxnQPK9mXHGJl1
        OO4BkDOFFVeDfqf6AWkCOEgTFXWzutaY+GBE7Fi55ZIIVVm9HAHZViLJ0GQFFvAt
        U5s+ki5nsRMqRliLSLPLAOOZG9FhG9kdR+rryp7F/lDU63FgxCoRp5o0R+3LB2Qd
        1DdbkBmoTOrzTCIQCzys9mthJoW5sE8aC2vQikyZYVdo7k1s2XmhJ5z+mNlqmwU6
        hU3QTdCIcNnCSReX0eDfsyK+RMCc90eZSfZLrvUJBnD9TO/UJQ/MkAyE7/R6T6dh
        t0QaoyjR9Y5s6AvucVUU98YIXf0nFzgGHZZgc+suPXlsD9kiY0m1p6Vgw==
X-ME-Sender: <xms:aGewYzSOKq09gkyWPv8ncOA3_579N_Ah4E0zNmBmSI2m5GXXkdb8tA>
    <xme:aGewY0xgx269-Ay-W2mbHpmXKaCJtALPRJn6J4eH0Gyi8Efj23aJ2bKsjArs85ASx
    jFTaWc3z341YSHZMw>
X-ME-Received: <xmr:aGewY42g2PAfXjlpGZO9EutL2_LmJlPTjwHzAX6vS476DacuDjOuF5Ey8mMDdmTj7IxiVkGQrrvWE1a4YQvAaJg2u6cLwV0nAKZZX9M0kMi_W125bSdRg2Cmzje7ozzKwehWaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieekgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:aGewYzB2Wrl6y9fgbpxLIi0WfqPPgfKZXowQqB6qb3wp2ls4_7Z_5Q>
    <xmx:aGewY8g2NwLGMuh1tdFTyBqb3Trm-9ZnKrqE2yhrYfEIfXtSjykmpg>
    <xmx:aGewY3qfAP6pQPZ5WvI3qOinQ3d3ZL3jl5Hm_zPa2xlnywr4KM3CnA>
    <xmx:aGewY1YJcGNoln_Fl3udknLlditU6uqvNakHroFUmA_1ILHMVu3AlA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 11:46:31 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 1/4] media: dt-bindings: cedrus: Allow power domain references
Date:   Sat, 31 Dec 2022 10:46:24 -0600
Message-Id: <20221231164628.19688-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221231164628.19688-1-samuel@sholland.org>
References: <20221231164628.19688-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner D1 SoC contains a separate power domain for its video
engine, controlled via the "PPU" power controller. Allow the
power-domains property so this can be represented in the devicetree.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../bindings/media/allwinner,sun4i-a10-video-engine.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml
index 541325f900a1..d5be7f604e8c 100644
--- a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml
+++ b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml
@@ -63,6 +63,9 @@ properties:
       CMA pool to use for buffers allocation instead of the default
       CMA pool.
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.37.4

